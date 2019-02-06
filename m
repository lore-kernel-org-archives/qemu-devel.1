Received: from eggs.gnu.org ([209.51.188.92]:46222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRlf-0004mX-QC
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRlb-0001yv-UW
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39063)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grRlY-0001qd-1o
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B5CA80F6D
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 18:17:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  6 Feb 2019 19:17:22 +0100
Message-Id: <20190206181725.14337-15-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-1-armbru@redhat.com>
References: <20190206181725.14337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 14/17] qapi: remove qmp_unregister_command()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This command is no longer needed, the schema has compile-time
configuration conditions.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/dispatch.h | 1 -
 qapi/qmp-registry.c         | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 68a528a9aa..9aa426a398 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -39,7 +39,6 @@ typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpComm=
andList;
=20
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options)=
;
-void qmp_unregister_command(QmpCommandList *cmds, const char *name);
 QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
 void qmp_disable_command(QmpCommandList *cmds, const char *name);
 void qmp_enable_command(QmpCommandList *cmds, const char *name);
diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
index 5af484cd9a..ca00f74795 100644
--- a/qapi/qmp-registry.c
+++ b/qapi/qmp-registry.c
@@ -27,14 +27,6 @@ void qmp_register_command(QmpCommandList *cmds, const =
char *name,
     QTAILQ_INSERT_TAIL(cmds, cmd, node);
 }
=20
-void qmp_unregister_command(QmpCommandList *cmds, const char *name)
-{
-    QmpCommand *cmd =3D qmp_find_command(cmds, name);
-
-    QTAILQ_REMOVE(cmds, cmd, node);
-    g_free(cmd);
-}
-
 QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name)
 {
     QmpCommand *cmd;
--=20
2.17.2
