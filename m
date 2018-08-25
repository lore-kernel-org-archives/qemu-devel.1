Received: from eggs.gnu.org ([2001:4830:134:3::10]:49378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ftZ4G-00018s-Sw
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ftZ4G-00033G-13
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35036 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ftZ4F-000335-Sw
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:31 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Aug 2018 15:57:16 +0200
Message-Id: <20180825135724.8981-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180825135724.8981-1-marcandre.lureau@redhat.com>
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/9] monitor: consitify qmp_send_response()
 QDict argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 021c11b1bf..a1db4db487 100644
--- a/monitor.c
+++ b/monitor.c
@@ -503,9 +503,9 @@ int monitor_fprintf(FILE *stream, const char *fmt, ..=
.)
     return 0;
 }
=20
-static void qmp_send_response(Monitor *mon, QDict *rsp)
+static void qmp_send_response(Monitor *mon, const QDict *rsp)
 {
-    QObject *data =3D QOBJECT(rsp);
+    const QObject *data =3D QOBJECT(rsp);
     QString *json;
=20
     json =3D mon->flags & MONITOR_USE_PRETTY ? qobject_to_json_pretty(da=
ta) :
--=20
2.18.0.547.g1d89318c48
