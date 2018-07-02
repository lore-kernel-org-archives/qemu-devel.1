Received: from eggs.gnu.org ([2001:4830:134:3::10]:42575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1at-0004Rl-S9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1as-0006fq-0k
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47596 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1ar-0006ew-IX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2314D7DAC6
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:22:13 +0200
Message-Id: <20180702162218.13678-28-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 27/32] qmp: Add some comments around null
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
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
