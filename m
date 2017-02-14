Received: from eggs.gnu.org ([2001:4830:134:3::10]:38734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJO-0005qh-Hd
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJL-0003Ko-BE
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJL-0003KH-35
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:15 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AE14C04B948
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3557EACB84
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:25:50 +0100
Message-Id: <1487067971-10443-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 03/24] tests/test-cutils: Add missing
 qemu_strtol()... endptr checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-cutils.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 20b0f59..71681dc 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -262,6 +262,7 @@ static void test_qemu_strtol_empty(void)
     err = qemu_strtol(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }
 
 static void test_qemu_strtol_whitespace(void)
@@ -275,6 +276,7 @@ static void test_qemu_strtol_whitespace(void)
     err = qemu_strtol(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }
 
 static void test_qemu_strtol_invalid(void)
@@ -288,6 +290,7 @@ static void test_qemu_strtol_invalid(void)
     err = qemu_strtol(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }
 
 static void test_qemu_strtol_trailing(void)
@@ -548,6 +551,7 @@ static void test_qemu_strtoul_empty(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }
 
 static void test_qemu_strtoul_whitespace(void)
@@ -561,6 +565,7 @@ static void test_qemu_strtoul_whitespace(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }
 
 static void test_qemu_strtoul_invalid(void)
@@ -574,6 +579,7 @@ static void test_qemu_strtoul_invalid(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }
 
 static void test_qemu_strtoul_trailing(void)
@@ -829,6 +835,7 @@ static void test_qemu_strtoll_empty(void)
     err = qemu_strtoll(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }
 
 static void test_qemu_strtoll_whitespace(void)
@@ -842,6 +849,7 @@ static void test_qemu_strtoll_whitespace(void)
     err = qemu_strtoll(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }
 
 static void test_qemu_strtoll_invalid(void)
@@ -855,6 +863,7 @@ static void test_qemu_strtoll_invalid(void)
     err = qemu_strtoll(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }
 
 static void test_qemu_strtoll_trailing(void)
@@ -1113,6 +1122,7 @@ static void test_qemu_strtoull_empty(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }
 
 static void test_qemu_strtoull_whitespace(void)
@@ -1126,6 +1136,7 @@ static void test_qemu_strtoull_whitespace(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }
 
 static void test_qemu_strtoull_invalid(void)
@@ -1139,6 +1150,7 @@ static void test_qemu_strtoull_invalid(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }
 
 static void test_qemu_strtoull_trailing(void)
-- 
2.7.4
