
create database ExerciseDb
use ExerciseDb
create table Student (Sid int primary key,SName nvarchar(50),SEmail nvarchar(50),SContact nvarchar(50))
insert into Student values (100,'Amit','amitchauhan@mail.com','9800685387')
insert into Student values (101,'Gurpreet','kaur_gurpreet@mail.com','9854685387')
insert into Student values (102,'Virat','vkfan@mail.com','9885685387')

create table Fee (Sid int foreign key references Student(Sid),SFee float,SMonth int ,SYear int,constraint StudentFeePK primary key(Sid,SMonth,SYear))

create table PayConfirmation (Sid int,Name nvarchar(50),Email nvarchar (50),Fee float,PaidOnDate datetime)

create trigger trgFeePayConfirmation on Fee after insert
as
declare @id int
declare @name nvarchar(50)
declare @mail nvarchar(50)
declare @fee float

select @id=Sid from inserted
select @fee=SFee from inserted
select @name=s.SName from inserted i join Student s on s.Sid = i.Sid where i.Sid = @id
select @mail=s.SEmail from inserted i join Student s on s.Sid = i.Sid where i.Sid = @id

insert into PayConfirmation(Sid,Name,Email,Fee,PaidOnDate) values (@id,@name,@mail,@fee,GETDATE())
print 'Trigger Fired Values Inserted'


insert into Fee values (100,4500.50,4,21)
insert into Fee values (101,7500.50,6,22)

select * from PayConfirmation
select * from Fee
Select * from Student



