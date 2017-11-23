Received: from eggs.gnu.org ([2001:4830:134:3::10]:46669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eHuTu-0007oA-BQ
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eHuTq-0003Fz-9H
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:06 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:63489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eHuTp-0003D9-Rw
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:02 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 23 Nov 2017 17:35:33 +0100
Message-Id: <20171123163538.31411-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 0/5] target/m68k: implement 680x0 FPU (part
 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Implement fmod, frem, fscale, fgetman and fgetexp.

Instead of using functions of libm (v1 of this series)
and converting between host long double and floatx80 type
the new version (v2) adds new floatx80 functions in softfloat.

All the floatx80 functions are copied from "Previous",
the NeXT Computer Emulator, and written by Andreas Grabher.

Laurent Vivier (5):
  softfloat: add floatx80_mod()
  target/m68k: add fmod/frem
  softfloat: use floatx80_infinity in softfloat
  softfloat: add floatx80_getman(), floatx80_getexp(), floatx80_scale()
  target-m68k: add fscale, fgetman and fgetexp

 fpu/softfloat-specialize.h |  29 +++++
 fpu/softfloat.c            | 258 ++++++++++++++++++++++++++++++++++++++++++---
 include/fpu/softfloat.h    |  13 ++-
 target/m68k/cpu.h          |   1 +
 target/m68k/fpu_helper.c   |  48 +++++++++
 target/m68k/helper.h       |   5 +
 target/m68k/translate.c    |  15 +++
 7 files changed, 355 insertions(+), 14 deletions(-)

-- 
2.13.6
