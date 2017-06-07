Received: from eggs.gnu.org ([2001:4830:134:3::10]:41012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIg21-0000eU-JC
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIg1x-00049t-Nc
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:50:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60585)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIg1x-00048V-IJ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:50:09 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 22:49:20 +0400
Message-Id: <20170607184921.28407-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170607184921.28407-1-marcandre.lureau@redhat.com>
References: <20170607184921.28407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] chardev: don't use alias names in
 parse_compat()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

"parport" is considered "old" since commit 88a946d32d, when "parallel"
was added. Similarly for "tty" in commit d59044ef74d.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index f38fac5c6b..55b671973b 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -452,12 +452,12 @@ QemuOpts *qemu_chr_parse_compat(const char *label, =
const char *filename)
     }
     if (strstart(filename, "/dev/parport", NULL) ||
         strstart(filename, "/dev/ppi", NULL)) {
-        qemu_opt_set(opts, "backend", "parport", &error_abort);
+        qemu_opt_set(opts, "backend", "parallel", &error_abort);
         qemu_opt_set(opts, "path", filename, &error_abort);
         return opts;
     }
     if (strstart(filename, "/dev/", NULL)) {
-        qemu_opt_set(opts, "backend", "tty", &error_abort);
+        qemu_opt_set(opts, "backend", "serial", &error_abort);
         qemu_opt_set(opts, "path", filename, &error_abort);
         return opts;
     }
--=20
2.13.0.91.g00982b8dd
