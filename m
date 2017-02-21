Received: from eggs.gnu.org ([2001:4830:134:3::10]:55092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpE-0007Q2-Db
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpC-0008Vy-Ke
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgGpC-0008V0-9l
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:14 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89EEFC05AA72
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:14:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:14:03 +0100
Message-Id: <1487708048-2131-20-git-send-email-armbru@redhat.com>
In-Reply-To: <1487708048-2131-1-git-send-email-armbru@redhat.com>
References: <1487708048-2131-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 19/24] test-cutils: Drop suffix from
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/test-cutils.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index d492d1e..c4437d9 100644
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
