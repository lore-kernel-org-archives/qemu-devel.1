Received: from eggs.gnu.org ([2001:4830:134:3::10]:36263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIs-0007Xa-8i
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIp-0000xX-10
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:26 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 22:27:02 +0100
Message-Id: <1488317230-26248-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1488317230-26248-1-git-send-email-armbru@redhat.com>
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/24] monitor: Assert qmp_schema_json[] is
 sane
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

qmp_query_qmp_schema() parses qmp_schema_json[] with
qobject_from_json().  This must not fail, so pass &error_abort.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 858bcda..13f6133 100644
--- a/monitor.c
+++ b/monitor.c
@@ -950,7 +950,7 @@ EventInfoList *qmp_query_events(Error **errp)
 static void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
                                  Error **errp)
 {
-    *ret_data = qobject_from_json(qmp_schema_json, NULL);
+    *ret_data = qobject_from_json(qmp_schema_json, &error_abort);
 }
 
 /*
-- 
2.7.4
