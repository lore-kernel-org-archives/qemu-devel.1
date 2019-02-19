Received: from eggs.gnu.org ([209.51.188.92]:49471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydY-0005Gs-7X
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydX-00074H-ET
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:12 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:33323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydV-00073t-On
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:11 -0500
Received: by mail-lj1-x242.google.com with SMTP id f24-v6so16402592ljk.0
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:09 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:10:55 -0800
Message-Id: <20190219061111.10231-8-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 07/23] tests/tcg/xtensa: enable boolean tests
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

Uncomment test_boolean in the test makefile. Make actual tests code
conditional on the presence of boolean option in the config.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/Makefile       | 2 +-
 tests/tcg/xtensa/test_boolean.S | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index b3693809372b..aee0134ef5b9 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -31,7 +31,7 @@ CRT        = crt.o vectors.o
 
 TESTCASES += test_b.tst
 TESTCASES += test_bi.tst
-#TESTCASES += test_boolean.tst
+TESTCASES += test_boolean.tst
 TESTCASES += test_break.tst
 TESTCASES += test_bz.tst
 TESTCASES += test_cache.tst
diff --git a/tests/tcg/xtensa/test_boolean.S b/tests/tcg/xtensa/test_boolean.S
index eac40e0973a3..5a850bfe7eac 100644
--- a/tests/tcg/xtensa/test_boolean.S
+++ b/tests/tcg/xtensa/test_boolean.S
@@ -2,6 +2,8 @@
 
 test_suite boolean
 
+#if XCHAL_HAVE_BOOLEANS
+
 test all4
     movi    a2, 0xfec0
     wsr     a2, br
@@ -20,4 +22,6 @@ test all4
     assert  eq, a2, a3
 test_end
 
+#endif
+
 test_suite_end
-- 
2.11.0
