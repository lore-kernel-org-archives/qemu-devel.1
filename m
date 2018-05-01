Received: from eggs.gnu.org ([2001:4830:134:3::10]:49948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBC-0004ux-LD
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBA-00036Y-V3
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:54 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:51958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fDWBA-00035W-O2
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:52 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Tue,  1 May 2018 16:22:17 +0200
Message-Id: <20180501142222.19154-8-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [RFC PATCH 07/12] tests/tcg/tricore: Add fadd test
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
 tests/tcg/tricore/Makefile    |  1 +
 tests/tcg/tricore/test_fadd.S | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 tests/tcg/tricore/test_fadd.S

diff --git a/tests/tcg/tricore/Makefile b/tests/tcg/tricore/Makefile
index 36f15a7544..ba0514bfa3 100644
--- a/tests/tcg/tricore/Makefile
+++ b/tests/tcg/tricore/Makefile
@@ -12,6 +12,7 @@ TESTCASES += test_abs.tst
 TESTCASES += test_bmerge.tst
 TESTCASES += test_clz.tst
 TESTCASES += test_dvstep.tst
+TESTCASES += test_fadd.tst
 
 all: build
 
diff --git a/tests/tcg/tricore/test_fadd.S b/tests/tcg/tricore/test_fadd.S
new file mode 100644
index 0000000000..1a65054803
--- /dev/null
+++ b/tests/tcg/tricore/test_fadd.S
@@ -0,0 +1,16 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    TEST_D_DD_PSW(add.f, 1, 0x7fc00000, 0x00000b80, 0xffffff85, 0x00001234)
+    TEST_D_DD_PSW(add.f, 2, 0xf9c00000, 0x00000b80, 0xf9400000, 0xf9400000)
+    TEST_D_DD_PSW(add.f, 3, 0x8bb858ca, 0x00000b80, 0x8b3858ca, 0x8b3858ca)
+    TEST_D_DD_PSW(add.f, 4, 0x00000000, 0x00000b80, 0x000000ff, 0x00000000)
+    TEST_D_DD_PSW(add.f, 5, 0x7fc00000, 0x00000b80, 0xfffffe52, 0x0a4cf70c)
+    TEST_D_DD_PSW(add.f, 6, 0x9e6d5076, 0x84000b80, 0x9ded50ec, 0x9ded4fff)
+    TEST_D_DD_PSW(add.f, 7, 0x00000000, 0x04000b80, 0x0000e8bd, 0x00000000)
+    TEST_D_DD_PSW(add.f, 8, 0x7fc00000, 0xc4000b80, 0xffad546e, 0xffad546e)
+    TEST_D_DD_PSW(add.f, 9, 0x7fc00000, 0x04000b80, 0xfffe0000, 0x08130000)
+
+    TEST_PASSFAIL
+
-- 
2.11.0
