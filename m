Received: from eggs.gnu.org ([2001:4830:134:3::10]:50799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fw3u7-0003Sr-FO
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fw3u6-0000jv-9u
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48030 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fw3u6-0000jc-5B
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDAA487A7C
	for <qemu-devel@nongnu.org>; Sat,  1 Sep 2018 11:17:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Sat,  1 Sep 2018 13:17:13 +0200
Message-Id: <20180901111716.1675-4-armbru@redhat.com>
In-Reply-To: <20180901111716.1675-1-armbru@redhat.com>
References: <20180901111716.1675-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/6] monitor: consitify qmp_send_response()
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180829134043.31706-2-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index c1add2ce09..bd0810df4d 100644
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
2.17.1
