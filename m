Received: from eggs.gnu.org ([2001:4830:134:3::10]:36313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbPjG-0003TU-BB
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbPjD-0008Vw-7A
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:20:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbPjC-0008Uw-Q9
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:20:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9A50E9007
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 12:13:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 14:13:44 +0200
Message-Id: <20180706121354.2021-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180706121354.2021-1-marcandre.lureau@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/12] monitor: consitify qmp_send_response()
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
Cc: eblake@redhat.com, armbru@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 3c9c97b73f..fc481d902d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -504,9 +504,9 @@ int monitor_fprintf(FILE *stream, const char *fmt, ..=
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
2.18.0.rc1
