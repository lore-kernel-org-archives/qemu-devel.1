Received: from eggs.gnu.org ([2001:4830:134:3::10]:34441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNN0-0002OE-Q6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNMy-0005Mj-GO
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36040 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faNMy-0005LB-5T
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B114B4021CC1
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D976111762D
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 17:37:23 +0200
Message-Id: <20180703153728.2175-28-armbru@redhat.com>
In-Reply-To: <20180703153728.2175-1-armbru@redhat.com>
References: <20180703153728.2175-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 27/32] qmp: Add some comments around null
 responses
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-28-armbru@redhat.com>
---
 qapi/qmp-dispatch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 761812e924..6f2d466596 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -133,6 +133,7 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
     } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
         g_assert(!ret);
     } else if (!ret) {
+        /* TODO turn into assertion */
         ret = QOBJECT(qdict_new());
     }
 
@@ -176,6 +177,7 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
         rsp = qdict_new();
         qdict_put_obj(rsp, "return", ret);
     } else {
+        /* Can only happen for commands with QCO_NO_SUCCESS_RESP */
         rsp = NULL;
     }
 
-- 
2.17.1
