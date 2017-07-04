Received: from eggs.gnu.org ([2001:4830:134:3::10]:49516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVyX-0001RN-2q
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVyW-0001aq-CI
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:07:17 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:45 +0200
Message-Id: <20170704220346.29244-35-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 34/35] vhdx: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:VHDX" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/vhdx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 8b270b57c9..56b54f3ed7 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1787,7 +1787,8 @@ exit:
  *    .---- ~ ----------- ~ ------------ ~ ---------------- ~ ----------=
-.
  *   1MB
  */
-static int vhdx_create(const char *filename, QemuOpts *opts, Error **err=
p)
+static int coroutine_fn
+vhdx_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     int ret =3D 0;
     uint64_t image_size =3D (uint64_t) 2 * GiB;
--=20
2.13.1.395.gf7b71de06
