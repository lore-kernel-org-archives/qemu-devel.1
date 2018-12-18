Received: from eggs.gnu.org ([2001:4830:134:3::10]:43709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK14-0003bw-Bs
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK13-0002fH-4c
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZK0z-0002Sl-FT
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4003389AC1
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 18:22:44 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Dec 2018 19:22:31 +0100
Message-Id: <20181218182234.28876-13-armbru@redhat.com>
In-Reply-To: <20181218182234.28876-1-armbru@redhat.com>
References: <20181218182234.28876-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 12/15] qapi: remove
 qmp_unregister_command()
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
