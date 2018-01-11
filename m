Received: from eggs.gnu.org ([2001:4830:134:3::10]:52143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXh-0000Dv-VX
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXh-0007PT-1V
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkXg-0007NT-Qv
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:44 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:50 +0100
Message-Id: <20180111213250.16511-52-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 51/51] qapi: remove qmp_unregister_command()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This command is no longer needed after the schema is made conditional.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 1 -
 qapi/qmp-registry.c         | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 20578dcd48..b2c8d2041c 100644
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
2.16.0.rc1.1.gef27df75a1
