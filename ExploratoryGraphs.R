#.............................................................
#1. Downloading and unziping the data
#.............................................................

if(!file.exists("./projectw4")){dir.create("./projectw4")}
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile = "./projectw4/dataset.zip")
unzip(zipfile = "./projectw4/dataset.zip", exdir="./projectw4")

#..............................................................
#2. Loading the data and subsetting 
#..............................................................

ElectricData<-read.table("./projectw4/household_power_consumption.txt",header = TRUE, sep=";")
SubPower<-subset(ElectricData, ElectricData$Date=="1/2/2007"|ElectricData$Date=="2/2/2007")

#............................................................
# Plot1
#converting class of global_Active_power to numeric
SubPower$Global_active_power<-as.numeric(as.character(SubPower$Global_active_power))
#plotting
png("plot1.png", width=480, height=480)
hist(SubPower$Global_active_power,col="red", xlab = "Global Active Power(Killowatts)", ylab = "frequency", main="Global Active Power")
dev.off()

#..............................................................

#plot2
#step 1. Converting date and time into standard format

SubPower$Date<-as.Date(SubPower$Date, format="%d/%m/%Y")
SubPower$Time<-strptime(SubPower$Time, format="%H:%M:%S")
SubPower[1:1440,"Time"] <- format(SubPower[1:1440,"Time"],"2007-02-01 %H:%M:%S")
SubPower[1441:2880,"Time"] <- format(SubPower[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#step 2. plotting
png("plot2.png", width=480, height=480)
plot(SubPower$Time,SubPower$Global_active_power,type = "l", xlab="", ylab = "Global Active Power(killowatts)")
title(main="Global Active Power Vs Time")
dev.off()

#....................................................................
#plot3

png("plot3.png", width = 480, height = 480)
plot(SubPower$Time,SubPower$Sub_metering_1,type="n",xlab="", ylab = "Energy Sub Metering")
lines(SubPower$Time,as.numeric(as.character(SubPower$Sub_metering_1)))
lines(SubPower$Time,as.numeric(as.character(SubPower$Sub_metering_2)), col="red")
lines(SubPower$Time,as.numeric(as.character(SubPower$Sub_metering_3)), col="blue")
legend("topright", lty=1, col=c("black","red","blue"), legend=c("sub_metering_1","sub_metering_2","sub_metering_3"))
title(main="Energy sub mettering")
dev.off()

#...................................................................
#plot4
#...................................................................
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
#plot1
plot(SubPower$Time,SubPower$Global_active_power, type="l", xlab = "", ylab = "Global Avtive power")
#plot2
plot(SubPower$Time, as.numeric(as.character(SubPower$Voltage)), type="l", xlab="datetime", ylab = "Voltage" )
#plot3
plot(SubPower$Time,SubPower$Sub_metering_1,type="n",xlab="", ylab = "Energy Sub Metering")
lines(SubPower$Time,as.numeric(as.character(SubPower$Sub_metering_1)))
lines(SubPower$Time,as.numeric(as.character(SubPower$Sub_metering_2)), col="red")
lines(SubPower$Time,as.numeric(as.character(SubPower$Sub_metering_3)), col="blue")
legend("topright", lty=1, col=c("black","red","blue"), legend=c("sub_metering_1","sub_metering_2","sub_metering_3"))
#plot4
plot(SubPower$Time, as.numeric(as.character(SubPower$Global_reactive_power)), type="l", xlab="datetime", ylab = "Global_reactive_power" )
dev.off()



