Received: from eggs.gnu.org ([2001:4830:134:3::10]:46119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FAh-0003bf-5q
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FAd-0004XI-EZ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:43:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6FAd-0004Wq-8h
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:43:43 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 15:42:21 +0400
Message-Id: <20170504114232.20318-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170504114232.20318-1-marcandre.lureau@redhat.com>
References: <20170504114232.20318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/21] char: useless NULL check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

g_strdup(NULL) returns NULL already.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 chardev/char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index aee8b4555d..33dbab6981 100644
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
2.12.0.191.gc5d8de91d
