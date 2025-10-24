# 安装和加载必要的包
install.packages("openxlsx")
install.packages("psych")
install.packages("corrplot")
library(openxlsx)
library(psych)
library(corrplot)

# 修改1：更新数据路径
data_path <- "你的输入数据路径"  # 使用正斜杠替换反斜杠
data <- read.xlsx(data_path)

# 修改2：选择X1-X7变量列
selected_cols <- c("X1", "X2", "X3", "X4", "X5", "X6", "X7") # 修改为你的变量名
analysis_data <- data[selected_cols]

# 计算相关性
cor_matrix <- corr.test(analysis_data, method = "pearson")
r <- cor_matrix$r
p <- cor_matrix$p

# 设置图形参数
par(
  family = "serif",        # Times New Roman属于serif字体族
  font = 2,                # 加粗
  mar = c(5, 4, 8, 2) + 0.1 # 增大上边距：c(下，左，上，右)
)

# 绘制热图（上半部分）
corrplot(r, method = "color",
         type = "upper",
         tl.cex = 1.1,        # 稍减小标签大小防止重叠
         tl.col = "black",    
         tl.font = 2,         
         tl.srt = 45,         
         tl.pos = "lt",       
         p.mat = p,
         sig.level = c(0.001, 0.01, 0.05),
         insig = "label_sig",
         pch.cex = 1.1,
         cl.cex = 1.1,        # 图例文字大小
         mar = c(0, 0, 2, 0),  # 单独控制热图边距
         title = "可以自己DIY标题")          # 添加标题"a"

# 绘制热图（下半部分）
corrplot(r, method = "number",
         type = "lower",
         tl.pos = "n",        # 不显示标签
         number.cex = 0.8,     # 调整数字大小
         number.font = 2,      # 数字加粗
         add = TRUE)           # 叠加到前一个图上


# 输出文字结果
cat("\n相关系数矩阵:\n")
print(round(r, 3))  # 保留3位小数

cat("\n显著性水平矩阵(p值):\n")
print(round(p, 4))  # 保留4位小数

# 可选：将结果保存到文件
# write.csv(round(r, 3), "相关系数矩阵.csv")
# write.csv(round(p, 4), "显著性矩阵.csv")
