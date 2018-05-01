Received: from eggs.gnu.org ([2001:4830:134:3::10]:49955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBC-0004v4-LK
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBB-00036o-7u
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:54 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:51966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fDWBB-00035n-0A
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:53 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Tue,  1 May 2018 16:22:18 +0200
Message-Id: <20180501142222.19154-9-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [RFC PATCH 08/12] tests/tcg/tricore: Add fmul test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/Makefile    | 1 +
 tests/tcg/tricore/test_fmul.S | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 tests/tcg/tricore/test_fmul.S

diff --git a/tests/tcg/tricore/Makefile b/tests/tcg/tricore/Makefile
index ba0514bfa3..5e2a450892 100644
--- a/tests/tcg/tricore/Makefile
+++ b/tests/tcg/tricore/Makefile
@@ -13,6 +13,7 @@ TESTCASES += test_bmerge.tst
 TESTCASES += test_clz.tst
 TESTCASES += test_dvstep.tst
 TESTCASES += test_fadd.tst
+TESTCASES += test_fmul.tst
 
 all: build
 
diff --git a/tests/tcg/tricore/test_fmul.S b/tests/tcg/tricore/test_fmul.S
new file mode 100644
index 0000000000..fb1f634b2d
--- /dev/null
+++ b/tests/tcg/tricore/test_fmul.S
@@ -0,0 +1,8 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    TEST_D_DD_PSW(mul.f, 1, 0x974f4f0a, 0x84000b80, 0x1a0b1980, 0xbcbec42d)
+
+    TEST_PASSFAIL
+
-- 
2.11.0
