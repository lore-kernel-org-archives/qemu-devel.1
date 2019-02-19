Received: from eggs.gnu.org ([209.51.188.92]:49431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydR-0005BN-MR
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydN-00071Y-1J
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:05 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:41136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydM-00070R-D0
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:00 -0500
Received: by mail-lf1-x143.google.com with SMTP id e27so14015451lfj.8
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:11:59 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:10:50 -0800
Message-Id: <20190219061111.10231-3-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 02/23] tests/tcg/xtensa: indicate failed tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

When test suite with multiple tests fails it's not obvious which test
failed. Pring "failed" in every invocation of test_fail. Do printing
when DEBUG preprocessor macro is defined.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/macros.inc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/xtensa/macros.inc b/tests/tcg/xtensa/macros.inc
index 4ebd30ab86ab..25c7ee479e6c 100644
--- a/tests/tcg/xtensa/macros.inc
+++ b/tests/tcg/xtensa/macros.inc
@@ -49,7 +49,9 @@ main:
 .endm
 
 .macro test name
-    //print test_\name
+#ifdef DEBUG
+    print test_\name
+#endif
     test_init
 test_\name:
 .global test_\name
@@ -74,6 +76,9 @@ test_\name:
     l32i    a2, a2, 0
     movi    a3, 1
     s8i     a3, a2, 0
+#ifdef DEBUG
+    print   failed
+#endif
     j       99f
 .endm
 
-- 
2.11.0
