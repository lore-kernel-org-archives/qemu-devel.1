Received: from eggs.gnu.org ([2001:4830:134:3::10]:45206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fGu1C-00056o-Bi
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fGu19-0007rV-7T
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:26:34 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fGu18-0007qs-U7
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:26:31 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 11 May 2018 00:25:56 +0200
Message-Id: <20180510222601.19944-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/5] linux-user: move socket.h definitions to
 CPU directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Splitting out socket.h definitions helps to read the code
and to fix the bugs...

No code change, except for the last one that ports
definitions from linux for sparc as the values are not the
correct ones.

Laurent Vivier (5):
  linux-user: move mips socket.h definitions to mips/sockbits.h
  linux-user: move alpha socket.h definitions to alpha/sockbits.h
  linux-user: move sparc/sparc64 socket.h definitions to
    sparc/sockbits.h
  linux-user: move ppc socket.h definitions to ppc/sockbits.h
  linux-user: copy sparc/sockbits.h definitions from linux

 linux-user/alpha/sockbits.h   | 113 ++++++++++++++++++
 linux-user/mips/sockbits.h    | 110 ++++++++++++++++++
 linux-user/mips64/sockbits.h  |   1 +
 linux-user/ppc/sockbits.h     |  58 ++++++++++
 linux-user/socket.h           | 261 +-----------------------------------------
 linux-user/sparc/sockbits.h   | 111 ++++++++++++++++++
 linux-user/sparc64/sockbits.h |   1 +
 7 files changed, 397 insertions(+), 258 deletions(-)
 create mode 100644 linux-user/alpha/sockbits.h
 create mode 100644 linux-user/mips/sockbits.h
 create mode 100644 linux-user/mips64/sockbits.h
 create mode 100644 linux-user/ppc/sockbits.h
 create mode 100644 linux-user/sparc/sockbits.h
 create mode 100644 linux-user/sparc64/sockbits.h

-- 
2.14.3
