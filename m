Received: from eggs.gnu.org ([2001:4830:134:3::10]:49945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBC-0004uw-LB
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBA-00035i-9e
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:54 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:51930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fDWBA-00034i-1Z
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:52 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Tue,  1 May 2018 16:22:15 +0200
Message-Id: <20180501142222.19154-6-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [RFC PATCH 05/12] tests/tcg/tricore: Add clz test
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
 tests/tcg/tricore/Makefile   | 1 +
 tests/tcg/tricore/test_clz.S | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 tests/tcg/tricore/test_clz.S

diff --git a/tests/tcg/tricore/Makefile b/tests/tcg/tricore/Makefile
index 34c91dccf5..16ec5460d7 100644
--- a/tests/tcg/tricore/Makefile
+++ b/tests/tcg/tricore/Makefile
@@ -10,6 +10,7 @@ SIMFLAGS = -M tricore_testboard -nographic -kernel
 
 TESTCASES += test_abs.tst
 TESTCASES += test_bmerge.tst
+TESTCASES += test_clz.tst
 
 all: build
 
diff --git a/tests/tcg/tricore/test_clz.S b/tests/tcg/tricore/test_clz.S
new file mode 100644
index 0000000000..e03835f123
--- /dev/null
+++ b/tests/tcg/tricore/test_clz.S
@@ -0,0 +1,9 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    TEST_D_D(cls.h, 1, 0x0, 0x6db17976)
+    TEST_D_D(cls.h, 2, 0x000f000f, 0x0)
+
+    TEST_PASSFAIL
+
-- 
2.11.0
