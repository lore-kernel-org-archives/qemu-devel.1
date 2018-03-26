Received: from eggs.gnu.org ([2001:4830:134:3::10]:55021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlB-0005dW-5Q
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tl9-0002yr-A3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tl9-0002yW-5t
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:07 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:55 +0200
Message-Id: <20180326150916.9602-18-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 17/38] qmp: constify qmp_is_oob()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 2 +-
 qapi/qmp-dispatch.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 8e0ac29300..79fe7f18e0 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -49,7 +49,7 @@ const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QObject *qmp_build_error_object(Error *err);
 QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp);
-bool qmp_is_oob(QDict *dict);
+bool qmp_is_oob(const QDict *dict);
=20
 typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
=20
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 4be0648809..e8a14eb845 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -129,7 +129,7 @@ QObject *qmp_build_error_object(Error *err)
  * peeking at whether we have: { "control": { "run-oob": true } }. By
  * default commands are run in-band.
  */
-bool qmp_is_oob(QDict *dict)
+bool qmp_is_oob(const QDict *dict)
 {
     QBool *bool_obj;
=20
--=20
2.17.0.rc1.1.g4c4f2b46a3
