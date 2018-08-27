Received: from eggs.gnu.org ([2001:4830:134:3::10]:49111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vincenzo.romano@notorand.it>) id 1fuLy4-0004E3-5j
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 14:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vincenzo.romano@notorand.it>) id 1fuLy3-0002kI-DW
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 14:10:24 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:40031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vincenzo.romano@notorand.it>)
	id 1fuLy3-0002jp-4j
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 14:10:23 -0400
Received: by mail-oi0-x22b.google.com with SMTP id l202-v6so22041789oig.7
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 11:10:22 -0700 (PDT)
MIME-Version: 1.0
From: Vincenzo Romano <vincenzo.romano@notorand.it>
Date: Mon, 27 Aug 2018 20:09:45 +0200
Message-ID: <CAHjZ2x7AmxMbWoxU3FvD3C1We3ygELxQbJ4S29SAB40yaHGbrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Hints for a networkable console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'd like to work on an idea that could be explained with the examples below.

-nographic \
-chardev socket,id=console,host=127.1.2.3,port=1234,server \
-display curses,chardev=console

and

-nographic \
-chardev socket,id=console,path=/tmp/asocket,server \
-display curses,chardev=console

This would allow for a "networkable" character-based console,
as opposed to an "image-oriented" one like VNC.

I have already given a look to some code (mainly in vl.c) and
I'd like to avoid reverse-engineering the code structure.
Where can I find some details about the code structure and maybe
a general overview?

--
Vincenzo Romano - NotOrAnd.IT
Information Technologies
--
NON QVIETIS MARIBVS NAVTA PERITVS
