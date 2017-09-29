Received: from eggs.gnu.org ([2001:4830:134:3::10]:54919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dy4mY-0006cJ-FG
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 19:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dy4mX-0004O7-LN
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 19:33:22 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:45656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dy4mX-0004Me-FO
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 19:33:21 -0400
Received: by mail-wm0-x235.google.com with SMTP id q124so2011236wmb.0
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 16:33:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <46ce7f3c-f0cb-bdfe-25fc-984276601f7d@vivier.eu>
References: <1506703816-7359-1-git-send-email-zhuoweizhang@yahoo.com>
	<46ce7f3c-f0cb-bdfe-25fc-984276601f7d@vivier.eu>
From: Carlo Arenas <carenas@gmail.com>
Date: Fri, 29 Sep 2017 16:33:17 -0700
Message-ID: <CAPUEspiEoZk2ems4L_f9J7y9r+65EKu85COJzkBoH_YYuu+q8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] syscall: fix special case of write(fd, NULL,
 0)
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: zhuoweizhang@yahoo.com, qemu-devel@nongnu.org, riku.voipio@iki.fi
List-ID: <qemu-devel.nongnu.org>

a return of 0 is a valid response for write per POSIX and just indicates 0
bytes were written.

the use of NULL for the buffer is not a trigger for that behaviour, but the
fact that the third parameter asks for 0 bytes to be copied.

therefore there is no need to get logic in this handler to check for NULL
IMHO

Carlo
