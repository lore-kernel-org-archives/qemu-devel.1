Received: from eggs.gnu.org ([2001:4830:134:3::10]:53176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4c-0001W8-05
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4W-0007FG-Dd
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38142 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4W-0007EY-9T
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:04 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:53 +0200
Message-Id: <20180703085358.13941-28-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 27/32] qmp: Add some comments around null
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
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
