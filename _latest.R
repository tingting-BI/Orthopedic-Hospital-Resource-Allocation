install.packages("tidyverse")
library(tidyverse)
library(dplyr)
mydata <- read.csv(file.choose())
head(mydata)
fiteredDf <- mydata %>%
            drop_na(DISCHARGE.DATE)

mydata$ADMISSION.DATE <- as.POSIXct(mydata$ADMISSION.DATE,format="%d/%m/%Y %H:%M", tz = "GMT")
mydata$DISCHARGE.DATE <- as.POSIXct(mydata$DISCHARGE.DATE,format="%d/%m/%Y %H:%M", tz = "GMT")
mydata$OPENING.MEDICAL.RECORD.DATE <- as.POSIXct(mydata$OPENING.MEDICAL.RECORD.DATE,format="%d/%m/%Y %H:%M", tz = "GMT")
mydata$DISCHARGE.FORECAST <- as.POSIXct(mydata$DISCHARGE.FORECAST,format="%d/%m/%Y %H:%M", tz = "GMT")
mydata$X1ST.SURGERY.DATE <- as.POSIXct(mydata$X1ST.SURGERY.DATE,format="%d/%m/%Y %H:%M", tz = "GMT")
mydata$DATE.OF.ACCIDENT <- as.POSIXct(mydata$DATE.OF.ACCIDENT,format="%d/%m/%Y %H:%M", tz = "GMT")

glimpse(fiteredDf)
fiteredDf$lenOfStay <- as.numeric(difftime(fiteredDf$DISCHARGE.DATE, fiteredDf$ADMISSION.DATE, units = "days"))
Mean_Los <-fiteredDf %>% group_by(SERVICE,SEX) %>% 
        summarise(across(c(lenOfStay, AGE, NUMBER.OF.SURGERIES, COMORBIDITIES), mean))
Mean_Los <- NULL
Mean_Los[order(-Mean_Los$lenOfStay),]
meanForQues1 <- Mean_Los %>% as.data.frame()