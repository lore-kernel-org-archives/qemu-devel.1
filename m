Received: from eggs.gnu.org ([2001:4830:134:3::10]:37362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dmwOS-0008LZ-Bk
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 02:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dmwOQ-0004Ax-Uq
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 02:22:28 -0400
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z28oKkkzHrXUuKPKP0fRZXouYzJUtS7JrJFKn1PK0261g@mail.gmail.com>
References: <CAOE=1Z2CjwTUPgREzBzkSLht9FP=g0_NsrOhVokQUgS2Sg-XOQ@mail.gmail.com>
	<CAOE=1Z1GxtF-V8tnqpPKVNiJSyD2+yT9+u48c=V855qtwnUxoQ@mail.gmail.com>
	<CAOE=1Z2cbY+vEpM32a1b6oGMa6Ogo==DtTY8mGV_8ncV+UduuQ@mail.gmail.com>
	<CAOE=1Z2tU0Hqruqcca1G3JVUqX2B42Y3DG2xDPfMJT0Mrq6E1w@mail.gmail.com>
	<CAKPgXcGJLOdSPWVfR5QY0iUGTSjwW1F-trrO-wEzQavU7VaRDA@mail.gmail.com>
	<CAOE=1Z28oKkkzHrXUuKPKP0fRZXouYzJUtS7JrJFKn1PK0261g@mail.gmail.com>
From: Sam <batmanustc@gmail.com>
Date: Wed, 30 Aug 2017 14:22:25 +0800
Message-ID: <CAOE=1Z2ixrKeyvzJrDWHssfo_TunieR8LdgaYRXw=oVGMjFVUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [QGA] Bug of qga?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-discuss@nongnu.org

Qemu-2.6.0

2017-08-30 14:20 GMT+08:00 Sam <batmanustc@gmail.com>:

> Hi all,
>
> I could repeat it, host os and guest os is Centos-7, qemu-ga is alive in
> guest. the step to repeat it is:
>
> 1. run python script just like the first email.
> 2. send qmp command1(cmd in the python script, like `route -n` command or
> something, of course it's qmp format), and interrupt it immediately(use
> `ctrl+c`).
> 3. then use that script to send command2(do not send command1) again, then
> you could get the result of command1.
>
>
> 2017-08-29 17:04 GMT+08:00 Sameeh Jubran <sameeh@daynix.com>:
>
>> Hi Sam,
>>
>> Thanks for reporting this, in order to debug this efficiently I need you
>> to provide me with more info, if you can provide it that would be great.
>> Can you reproduce the issue with ncat? You can use ncat to connect to the
>> socket by running the following command:
>>
>> nc -U /tmp/qga.sock
>>
>> Which OS are you running? Which qemu-ga version are you running? can you
>> reproduce with upstream qemu-ga?
>>
>> On Tue, Aug 29, 2017 at 9:19 AM, Sam <batmanustc@gmail.com> wrote:
>>
>>> So how to fix this bug? And where should I to report bug?
>>>
>>> 2017-08-29 13:52 GMT+08:00 Sam <batmanustc@gmail.com>:
>>>
>>> > I could repeat this several times, I think it's mis-order of qmp in qga
>>> > socket.
>>> >
>>> > 2017-08-25 11:09 GMT+08:00 Sam <batmanustc@gmail.com>:
>>> >
>>> >> Also I found:
>>> >>
>>> >> when I use `socat` to take a qga socket, then I use `socat` to
>>> >> communicate it will got error.
>>> >> But also SOMETIMES, I will not got error and will communicate OK.
>>> >>
>>> >> If one user take qga socket, another user should got error, is it? But
>>> >> why sometimes, the communicate is OK?
>>> >>
>>> >> 2017-08-25 10:11 GMT+08:00 Sam <batmanustc@gmail.com>:
>>> >>
>>> >>> Hi all,
>>> >>>
>>> >>> I'm using qga to send `route -n` and `ping` command to guest. But I
>>> >>> found SOMETIMES, the second `ping` command's result is the same as
>>> `route
>>> >>> -n` command.
>>> >>>
>>> >>> So I guess is there some cache mechanism of qga command result? So
>>> when
>>> >>> I send the second command, and receive from qga socket, I receive the
>>> >>> result of first command.
>>> >>>
>>> >>> Or is this bug happened because of I use async mechanism of python
>>> code
>>> >>> to operate qga socket?
>>> >>>
>>> >>> This is the python code I use to operate on this qga socket:
>>> >>>
>>> >>> try:
>>> >>>>         sock=socket(AF_UNIX, SOCK_STREAM)
>>> >>>>         sock.settimeout(20)
>>> >>>>         sock.connect(vm_qga_sockpath)
>>> >>>>         sock.send(cmd)
>>> >>>>         while True:
>>> >>>>             res = sock.recv(1024)
>>> >>>>             if len(res):
>>> >>>>                 break
>>> >>>>     except Exception as e:
>>> >>>>         res = -1
>>> >>>>     finally:
>>> >>>>         sock.settimeout(None)
>>> >>>>         sock.close()
>>> >>>
>>> >>>
>>> >>
>>> >
>>>
>>
>>
>>
>> --
>> Respectfully,
>> *Sameeh Jubran*
>> *Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
>> *Software Engineer @ Daynix <http://www.daynix.com>.*
>>
>
>
