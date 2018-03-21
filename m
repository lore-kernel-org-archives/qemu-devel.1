Received: from eggs.gnu.org ([2001:4830:134:3::10]:49154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJw-0006zo-Ax
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJv-0000LB-E5
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:54:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51888 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJv-0000Kz-9X
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:54:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C597240267D7
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:54:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:52:10 +0100
Message-Id: <20180321115211.17937-49-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 48/49] qapi: remove qmp_unregister_command()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This command is no longer needed after the schema is made conditional.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 1 -
 qapi/qmp-registry.c         | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index ffb4652f71..dba9ee70b3 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -38,7 +38,6 @@ typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpComm=
andList;
=20
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options)=
;
-void qmp_unregister_command(QmpCommandList *cmds, const char *name);
 QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
 QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request);
 void qmp_disable_command(QmpCommandList *cmds, const char *name);
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
2.16.2.521.g9aa15f885a
