Received: from eggs.gnu.org ([2001:4830:134:3::10]:38962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eswu7-0007L0-75
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:40:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eswu4-0000CM-2K
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:40:15 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:36211)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eswu3-00008b-Pn
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:40:12 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  5 Mar 2018 21:39:02 +0100
Message-Id: <20180305203910.10391-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/8] target/m68k: implement 680x0 FPU (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Implement flognp1, flogn, flog10, flog2, fetox, ftwotox, ftentox

As previously, all the floatx80 functions are copied from "Previous",
the NeXT Computer Emulator, and written by Andreas Grabher.

I did not improve or clean up the code, it's a simple port of
Andreas' work from "Previous".

"Previous" code I have ported to QEMU can be found in (r844):

  http://svn.code.sf.net/p/previous/code/trunk/src/softfloat/

"Previous" code is a C implementation of m68040 assembly language functions
found in ($NetBSD: copyright.s,v 1.2 1994/10/26 07:48:57 cgd Exp)

  https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/sys/arch/m68k/fpsp/

floatx80_move() comes from WinUAE (3600b8):

  https://github.com/tonioni/WinUAE/blob/master/softfloat/softfloat.cpp

All the original work is under SoftFloat-2a license, and additional work
under BSD license or GPL-v2-or-later license.

All softfloat new functions are added in target/m68k as they are derived
from m68k code.

I have compared results of these instructions from a real m68040 and from
QEMU, and they match.

Laurent Vivier (8):
  target/m68k: define floatx80_move()
  target/m68k: implement flognp1
  target/m68k: implement flogn
  target/m68k: implement flog10
  target/m68k: implement flog2
  target/m68k: implement fetox
  target/m68k: implement ftwotox
  target/m68k: implement ftentox

 target/m68k/fpu_helper.c            |   35 ++
 target/m68k/helper.h                |    7 +
 target/m68k/softfloat.c             | 1019 +++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h             |    8 +
 target/m68k/softfloat_fpsp_tables.h |  374 +++++++++++++
 target/m68k/translate.c             |   21 +
 6 files changed, 1464 insertions(+)
 create mode 100755 target/m68k/softfloat_fpsp_tables.h

-- 
2.14.3
