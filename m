Received: from eggs.gnu.org ([2001:4830:134:3::10]:38183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMq-0002pU-ED
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMo-0002oF-F1
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cktMo-0002nG-9x
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:02 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 806241CCC47
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 14:12:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v26EC124028034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 09:12:02 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 15:11:47 +0100
Message-Id: <1488809515-4047-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1488809515-4047-1-git-send-email-armbru@redhat.com>
References: <1488809515-4047-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 16/24] monitor: Assert qmp_schema_json[] is
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

qmp_query_qmp_schema() parses qmp_schema_json[] with
qobject_from_json().  This must not fail, so pass &error_abort.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-17-git-send-email-armbru@redhat.com>
---
 monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index ae6c4d3..f11893e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -953,7 +953,7 @@ EventInfoList *qmp_query_events(Error **errp)
 static void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
                                  Error **errp)
 {
-    *ret_data = qobject_from_json(qmp_schema_json, NULL);
+    *ret_data = qobject_from_json(qmp_schema_json, &error_abort);
 }
 
 /*
-- 
2.7.4
