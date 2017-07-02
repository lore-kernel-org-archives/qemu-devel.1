Received: from eggs.gnu.org ([2001:4830:134:3::10]:53530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRhnT-0007mC-RO
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 12:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRhnT-0006kG-76
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 12:32:31 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dRhnT-0006hk-0e
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 12:32:31 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun,  2 Jul 2017 18:32:18 +0200
Message-Id: <20170702163220.8039-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 0/2] target/sh4: fix fabs and optimize fneg
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

This patchset should fix the bug #1701821 reported by Bruno Haible,
which makes the gnulib testsuite to fail for single precision libm
tests.

Aurelien Jarno (2):
  target/sh4: do not check for PR bit for fabs instruction
  target/sh4: do not use a helper to implement fneg

 target/sh4/helper.h    |  3 ---
 target/sh4/op_helper.c | 15 ---------------
 target/sh4/translate.c | 20 +++++---------------
 3 files changed, 5 insertions(+), 33 deletions(-)

-- 
2.11.0
