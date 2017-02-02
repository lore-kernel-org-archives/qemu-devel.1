Received: from eggs.gnu.org ([2001:4830:134:3::10]:39686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIkR-0004xY-Tn
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIkR-0004Id-9c
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cZIkR-0004IQ-4U
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:31 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38584C04D2EF
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:52:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  2 Feb 2017 18:51:29 +0400
Message-Id: <20170202145141.17138-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170202145141.17138-1-marcandre.lureau@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/22] char: useless NULL check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

g_strdup(NULL) returns NULL already.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index f47d933828..4b633b9366 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -763,7 +763,7 @@ void qemu_chr_parse_common(QemuOpts *opts, ChardevCom=
mon *backend)
     const char *logfile =3D qemu_opt_get(opts, "logfile");
=20
     backend->has_logfile =3D logfile !=3D NULL;
-    backend->logfile =3D logfile ? g_strdup(logfile) : NULL;
+    backend->logfile =3D g_strdup(logfile);
=20
     backend->has_logappend =3D true;
     backend->logappend =3D qemu_opt_get_bool(opts, "logappend", false);
--=20
2.11.0.295.gd7dffce1c.dirty
