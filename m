Received: from eggs.gnu.org ([2001:4830:134:3::10]:45178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1chaAO-0007am-7O
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 06:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1chaAL-0007aj-3N
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 06:05:32 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:60912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1chaAK-0007ZS-Pf
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 06:05:29 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 25 Feb 2017 12:05:15 +0100
Message-Id: <20170225110517.2832-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/2] linux-user: m68k update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

A couple of m68k patches I have in my stack for
a while and needed to have a working linux-user qemu.

The first one is needed to be able to use RISU with m68k.

Laurent Vivier (1):
  linux-user: correctly manage SR in ucontext

Michael Karcher (1):
  linux-user: fix do_rt_sigreturn on m68k linux userspace emulation

 linux-user/signal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.9.3
