Received: from eggs.gnu.org ([2001:4830:134:3::10]:56990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dl46N-0003W1-TH
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 22:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dl46M-00012d-Vv
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 22:12:03 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:37716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1dl46M-00011N-Qk
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 22:12:02 -0400
Received: by mail-qt0-x22f.google.com with SMTP id d15so5780832qta.4
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 19:12:00 -0700 (PDT)
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Fri, 25 Aug 2017 10:11:59 +0800
Message-ID: <CAOE=1Z2CjwTUPgREzBzkSLht9FP=g0_NsrOhVokQUgS2Sg-XOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [QGA] Bug of qga?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

I'm using qga to send `route -n` and `ping` command to guest. But I found
SOMETIMES, the second `ping` command's result is the same as `route -n`
command.

So I guess is there some cache mechanism of qga command result? So when I
send the second command, and receive from qga socket, I receive the result
of first command.

Or is this bug happened because of I use async mechanism of python code to
operate qga socket?

This is the python code I use to operate on this qga socket:

try:
>         sock=socket(AF_UNIX, SOCK_STREAM)
>         sock.settimeout(20)
>         sock.connect(vm_qga_sockpath)
>         sock.send(cmd)
>         while True:
>             res = sock.recv(1024)
>             if len(res):
>                 break
>     except Exception as e:
>         res = -1
>     finally:
>         sock.settimeout(None)
>         sock.close()
