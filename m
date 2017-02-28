Received: from eggs.gnu.org ([2001:4830:134:3::10]:36092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIo-0007Ss-Lt
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIm-0000v2-HD
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:22 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 22:26:57 +0100
Message-Id: <1488317230-26248-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1488317230-26248-1-git-send-email-armbru@redhat.com>
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/24] test-qobject-input-visitor: Abort
 earlier on bad test input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

visitor_input_test_init_internal() parses test input with
qobject_from_jsonv(), and asserts it succeeds.  Pass &error_abort for
good measure.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-qobject-input-visitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 36cc4b5..6eb48fe 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -51,7 +51,7 @@ static Visitor *visitor_input_test_init_internal(TestInputVisitorData *data,
 {
     visitor_input_teardown(data, NULL);
 
-    data->obj = qobject_from_jsonv(json_string, ap, NULL);
+    data->obj = qobject_from_jsonv(json_string, ap, &error_abort);
     g_assert(data->obj);
 
     if (keyval) {
-- 
2.7.4
