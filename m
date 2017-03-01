Received: from eggs.gnu.org ([2001:4830:134:3::10]:42155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cj46h-000565-OQ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cj46e-00007n-Iw
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:15:51 -0500
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:35967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1cj46e-00004w-E6
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:15:48 -0500
Received: by mail-qk0-x234.google.com with SMTP id n186so67267167qkb.3
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 05:15:46 -0800 (PST)
MIME-Version: 1.0
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Wed, 1 Mar 2017 14:15:45 +0100
Message-ID: <CAJy91CZO+XOyzyhG5yKYcYQsfG_jwRF7W_4sxp6Fen=4gNr+YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Windows Pipe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Dear QEMU developers,

I want the host-guest communication for QEMU. I want to achieve
it via serial port redirection to a pipe. My host is windows and guest is
Linux. QEMU is in version 2.8.50

I looked into char-pipe.c and char-win.c, and find that the current QEMU
only supports reading data on the pipe from host to guest for Windows.
See *win_chr_pipe_init
() *in char-pipe.c

Is it true?

I don't know how to use *win_chr_write() *in char-win.c.
Can you please present an example?

best regards,
Jiahuan
