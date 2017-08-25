Received: from eggs.gnu.org ([2001:4830:134:3::10]:37485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dl4zi-0001DV-5T
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 23:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dl4zh-00051C-4y
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 23:09:14 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:38382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1dl4zh-000515-0N
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 23:09:13 -0400
Received: by mail-qt0-x22c.google.com with SMTP id n13so6068311qtc.5
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 20:09:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z2CjwTUPgREzBzkSLht9FP=g0_NsrOhVokQUgS2Sg-XOQ@mail.gmail.com>
References: <CAOE=1Z2CjwTUPgREzBzkSLht9FP=g0_NsrOhVokQUgS2Sg-XOQ@mail.gmail.com>
From: Sam <batmanustc@gmail.com>
Date: Fri, 25 Aug 2017 11:09:11 +0800
Message-ID: <CAOE=1Z1GxtF-V8tnqpPKVNiJSyD2+yT9+u48c=V855qtwnUxoQ@mail.gmail.com>
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
To: qemu-devel@nongnu.org

Also I found:

when I use `socat` to take a qga socket, then I use `socat` to communicate
it will got error.
But also SOMETIMES, I will not got error and will communicate OK.

If one user take qga socket, another user should got error, is it? But why
sometimes, the communicate is OK?

2017-08-25 10:11 GMT+08:00 Sam <batmanustc@gmail.com>:

> Hi all,
>
> I'm using qga to send `route -n` and `ping` command to guest. But I found
> SOMETIMES, the second `ping` command's result is the same as `route -n`
> command.
>
> So I guess is there some cache mechanism of qga command result? So when I
> send the second command, and receive from qga socket, I receive the result
> of first command.
>
> Or is this bug happened because of I use async mechanism of python code to
> operate qga socket?
>
> This is the python code I use to operate on this qga socket:
>
> try:
>>         sock=socket(AF_UNIX, SOCK_STREAM)
>>         sock.settimeout(20)
>>         sock.connect(vm_qga_sockpath)
>>         sock.send(cmd)
>>         while True:
>>             res = sock.recv(1024)
>>             if len(res):
>>                 break
>>     except Exception as e:
>>         res = -1
>>     finally:
>>         sock.settimeout(None)
>>         sock.close()
>
>
