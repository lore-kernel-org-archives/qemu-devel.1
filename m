Received: from eggs.gnu.org ([2001:4830:134:3::10]:50014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBE-0004vu-2u
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBC-00038O-Ls
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:56 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:52010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fDWBC-000373-9u
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:54 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Tue,  1 May 2018 16:22:22 +0200
Message-Id: <20180501142222.19154-13-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [RFC PATCH 12/12] tests/tcg/tricore: Add muls test
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
 tests/tcg/tricore/test_muls.S | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 tests/tcg/tricore/test_muls.S

diff --git a/tests/tcg/tricore/Makefile b/tests/tcg/tricore/Makefile
index e3113b726c..37c3101e4d 100644
--- a/tests/tcg/tricore/Makefile
+++ b/tests/tcg/tricore/Makefile
@@ -17,6 +17,7 @@ TESTCASES += test_fmul.tst
 TESTCASES += test_ftoi.tst
 TESTCASES += test_madd.tst
 TESTCASES += test_msub.tst
+TESTCASES += test_muls.tst
 
 all: build
 
diff --git a/tests/tcg/tricore/test_muls.S b/tests/tcg/tricore/test_muls.S
new file mode 100644
index 0000000000..ca517556bc
--- /dev/null
+++ b/tests/tcg/tricore/test_muls.S
@@ -0,0 +1,9 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    TEST_D_DD_PSW(muls.u, 1, 0xffffffff, 0x78000b80, 0x80000001, 0xffffffff)
+    TEST_D_DD_PSW(muls.u, 2, 0xffffffff, 0x60000b80, 0xfffffffe, 0xffffffff)
+
+    TEST_PASSFAIL
+
-- 
2.11.0
