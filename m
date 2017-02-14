Received: from eggs.gnu.org ([2001:4830:134:3::10]:38738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJO-0005qj-Iv
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJL-0003Kt-BD
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJL-0003KS-33
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:15 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC07F85540
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1EAQDii001965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:26:14 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:25:51 +0100
Message-Id: <1487067971-10443-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 04/24] tests/test-cutils: Clean up
 qemu_strtoul() result checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use unsigned comparisons to check the result of qemu_strtoul() and
strtoull().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-cutils.c | 60 ++++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 71681dc..ef76792 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -523,7 +523,7 @@ static void test_qemu_strtoul_correct(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 12345);
+    g_assert_cmpuint(res, ==, 12345);
     g_assert(endptr == str + 5);
 }
 
@@ -593,7 +593,7 @@ static void test_qemu_strtoul_trailing(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
     g_assert(endptr == str + 3);
 }
 
@@ -608,7 +608,7 @@ static void test_qemu_strtoul_octal(void)
     err = qemu_strtoul(str, &endptr, 8, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0123);
+    g_assert_cmpuint(res, ==, 0123);
     g_assert(endptr == str + strlen(str));
 
     res = 999;
@@ -616,7 +616,7 @@ static void test_qemu_strtoul_octal(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0123);
+    g_assert_cmpuint(res, ==, 0123);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -631,7 +631,7 @@ static void test_qemu_strtoul_decimal(void)
     err = qemu_strtoul(str, &endptr, 10, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
     g_assert(endptr == str + strlen(str));
 
     str = "123";
@@ -640,7 +640,7 @@ static void test_qemu_strtoul_decimal(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -655,7 +655,7 @@ static void test_qemu_strtoul_hex(void)
     err = qemu_strtoul(str, &endptr, 16, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0x123);
+    g_assert_cmpuint(res, ==, 0x123);
     g_assert(endptr == str + strlen(str));
 
     str = "0x123";
@@ -664,7 +664,7 @@ static void test_qemu_strtoul_hex(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0x123);
+    g_assert_cmpuint(res, ==, 0x123);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -679,7 +679,7 @@ static void test_qemu_strtoul_max(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, ULONG_MAX);
+    g_assert_cmpuint(res, ==, ULONG_MAX);
     g_assert(endptr == str + strlen(str));
     g_free(str);
 }
@@ -695,7 +695,7 @@ static void test_qemu_strtoul_overflow(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpint(res, ==, ULONG_MAX);
+    g_assert_cmpuint(res, ==, ULONG_MAX);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -710,7 +710,7 @@ static void test_qemu_strtoul_underflow(void)
     err  = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpint(res, ==, -1ul);
+    g_assert_cmpuint(res, ==, -1ul);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -725,7 +725,7 @@ static void test_qemu_strtoul_negative(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, -321ul);
+    g_assert_cmpuint(res, ==, -321ul);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -738,7 +738,7 @@ static void test_qemu_strtoul_full_correct(void)
     err = qemu_strtoul(str, NULL, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
 }
 
 static void test_qemu_strtoul_full_null(void)
@@ -769,7 +769,7 @@ static void test_qemu_strtoul_full_negative(void)
 
     err = qemu_strtoul(str, NULL, 0, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, -321ul);
+    g_assert_cmpuint(res, ==, -321ul);
 }
 
 static void test_qemu_strtoul_full_trailing(void)
@@ -792,7 +792,7 @@ static void test_qemu_strtoul_full_max(void)
     err = qemu_strtoul(str, NULL, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, ULONG_MAX);
+    g_assert_cmpuint(res, ==, ULONG_MAX);
     g_free(str);
 }
 
@@ -1094,7 +1094,7 @@ static void test_qemu_strtoull_correct(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 12345);
+    g_assert_cmpuint(res, ==, 12345);
     g_assert(endptr == str + 5);
 }
 
@@ -1164,7 +1164,7 @@ static void test_qemu_strtoull_trailing(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
     g_assert(endptr == str + 3);
 }
 
@@ -1179,7 +1179,7 @@ static void test_qemu_strtoull_octal(void)
     err = qemu_strtoull(str, &endptr, 8, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0123);
+    g_assert_cmpuint(res, ==, 0123);
     g_assert(endptr == str + strlen(str));
 
     endptr = &f;
@@ -1187,7 +1187,7 @@ static void test_qemu_strtoull_octal(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0123);
+    g_assert_cmpuint(res, ==, 0123);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -1202,7 +1202,7 @@ static void test_qemu_strtoull_decimal(void)
     err = qemu_strtoull(str, &endptr, 10, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
     g_assert(endptr == str + strlen(str));
 
     str = "123";
@@ -1211,7 +1211,7 @@ static void test_qemu_strtoull_decimal(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -1226,7 +1226,7 @@ static void test_qemu_strtoull_hex(void)
     err = qemu_strtoull(str, &endptr, 16, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0x123);
+    g_assert_cmpuint(res, ==, 0x123);
     g_assert(endptr == str + strlen(str));
 
     str = "0x123";
@@ -1235,7 +1235,7 @@ static void test_qemu_strtoull_hex(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0x123);
+    g_assert_cmpuint(res, ==, 0x123);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -1250,7 +1250,7 @@ static void test_qemu_strtoull_max(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, ULLONG_MAX);
+    g_assert_cmpuint(res, ==, ULLONG_MAX);
     g_assert(endptr == str + strlen(str));
     g_free(str);
 }
@@ -1266,7 +1266,7 @@ static void test_qemu_strtoull_overflow(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpint(res, ==, ULLONG_MAX);
+    g_assert_cmpuint(res, ==, ULLONG_MAX);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -1281,7 +1281,7 @@ static void test_qemu_strtoull_underflow(void)
     err  = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpint(res, ==, -1);
+    g_assert_cmpuint(res, ==, (uint64_t)-1);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -1296,7 +1296,7 @@ static void test_qemu_strtoull_negative(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, -321);
+    g_assert_cmpuint(res, ==, (uint64_t)-321);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -1309,7 +1309,7 @@ static void test_qemu_strtoull_full_correct(void)
     err = qemu_strtoull(str, NULL, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 18446744073709551614LLU);
+    g_assert_cmpuint(res, ==, 18446744073709551614LLU);
 }
 
 static void test_qemu_strtoull_full_null(void)
@@ -1342,7 +1342,7 @@ static void test_qemu_strtoull_full_negative(void)
     err = qemu_strtoull(str, NULL, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 18446744073709551295LLU);
+    g_assert_cmpuint(res, ==, 18446744073709551295LLU);
 }
 
 static void test_qemu_strtoull_full_trailing(void)
@@ -1365,7 +1365,7 @@ static void test_qemu_strtoull_full_max(void)
     err = qemu_strtoull(str, NULL, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, ULLONG_MAX);
+    g_assert_cmpuint(res, ==, ULLONG_MAX);
     g_free(str);
 }
 
-- 
2.7.4
