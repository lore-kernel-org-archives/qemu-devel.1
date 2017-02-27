Received: from eggs.gnu.org ([2001:4830:134:3::10]:53484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciLZt-0001zd-HO
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciLZq-0001fI-FB
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:43:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ciLZq-0001f2-8o
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:42:58 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E6A6883A4
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 13:42:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Feb 2017 17:41:51 +0400
Message-Id: <20170227134202.2991-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170227134202.2991-1-marcandre.lureau@redhat.com>
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/21] char: useless NULL check
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
index 558fd8b31c..bb20d73fcf 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -764,7 +764,7 @@ void qemu_chr_parse_common(QemuOpts *opts, ChardevCom=
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
2.12.0.rc2.3.gc93709801
