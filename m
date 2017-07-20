Received: from eggs.gnu.org ([2001:4830:134:3::10]:54119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY6HQ-0003h7-Rq
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY6HP-00036L-Lh
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:53:52 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 20 Jul 2017 09:53:35 +0200
Message-Id: <1500537221-20556-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1500537221-20556-1-git-send-email-armbru@redhat.com>
References: <1500537221-20556-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/10] tests/test-qobject-input-visitor:
 Drop redundant test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

test_visitor_in_alternate() tests UserDefAlternate with inadmissible
input.  test_visitor_in_fail_alternate() does basically the same.
Drop the former, keep the latter.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/test-qobject-input-visitor.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index f451844..bcf0261 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -567,7 +567,6 @@ static void test_visitor_in_alternate(TestInputVisitorData *data,
                                       const void *unused)
 {
     Visitor *v;
-    Error *err = NULL;
     UserDefAlternate *tmp;
     WrapAlternate *wrap;
 
@@ -599,11 +598,6 @@ static void test_visitor_in_alternate(TestInputVisitorData *data,
     g_assert_cmpint(tmp->u.udfu.u.value1.has_a_b, ==, false);
     qapi_free_UserDefAlternate(tmp);
 
-    v = visitor_input_test_init(data, "false");
-    visit_type_UserDefAlternate(v, NULL, &tmp, &err);
-    error_free_or_abort(&err);
-    qapi_free_UserDefAlternate(tmp);
-
     v = visitor_input_test_init(data, "{ 'alt': 42 }");
     visit_type_WrapAlternate(v, NULL, &wrap, &error_abort);
     g_assert_cmpint(wrap->alt->type, ==, QTYPE_QNUM);
-- 
2.7.5
