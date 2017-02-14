Received: from eggs.gnu.org ([2001:4830:134:3::10]:38798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJP-0005qp-R8
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJN-0003O3-TV
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJN-0003ND-N1
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:17 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DDACA19CBD8
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1EAQGwJ003252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:26:17 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:26:06 +0100
Message-Id: <1487067971-10443-20-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 19/24] tests/test-cutils: Drop suffix from
 test_qemu_strtosz_simple()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Leave testing unit suffixes to test_qemu_strtosz_units().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-cutils.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index ebef377..585912b 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1380,13 +1380,13 @@ static void test_qemu_strtosz_simple(void)
     g_assert_cmpint(res, ==, 0);
     g_assert(endptr == str + 1);
 
-    str = "12345M";
+    str = "12345";
     res = qemu_strtosz(str, &endptr);
-    g_assert_cmpint(res, ==, 12345 * M_BYTE);
-    g_assert(endptr == str + 6);
+    g_assert_cmpint(res, ==, 12345);
+    g_assert(endptr == str + 5);
 
     res = qemu_strtosz(str, NULL);
-    g_assert_cmpint(res, ==, 12345 * M_BYTE);
+    g_assert_cmpint(res, ==, 12345);
 
     /* Note: precision is 53 bits since we're parsing with strtod() */
 
-- 
2.7.4
