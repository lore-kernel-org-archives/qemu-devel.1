Received: from eggs.gnu.org ([2001:4830:134:3::10]:59468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRlTi-0001kd-7z
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 16:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRlTh-0001HN-Bf
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 16:28:22 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:41548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dRlTh-0001GH-4b
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 16:28:21 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun,  2 Jul 2017 22:28:09 +0200
Message-Id: <20170702202814.27793-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 0/5] target/sh4: misc FPU fixes and
 optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Bruno Haible <bruno@clisp.org>, Aurelien Jarno <aurelien@aurel32.net>

This patchset should fix the bug#1701821 reported by Bruno Haible,
which makes the gnulib testsuite to fail for single precision libm
tests or for tests relying on unordered comparisons.

It also fixes an inversion of cause and flag bits in the FPSCR register,
which is unrelated with the reported bug. It also improves a bit the fneg
and fcmp instructions.

Aurelien Jarno (5):
  target/sh4: do not check for PR bit for fabs instruction
  target/sh4: fix FPU unorderered compare
  target/sh4: fix FPSCR cause vs flag inversion
  target/sh4: do not use a helper to implement fneg
  target/sh4: return result of fcmp using TCG

 target/sh4/helper.h    | 11 +++-----
 target/sh4/op_helper.c | 71 ++++++++++++++++----------------------------------
 target/sh4/translate.c | 30 ++++++++-------------
 3 files changed, 37 insertions(+), 75 deletions(-)

-- 
2.11.0
