Received: from eggs.gnu.org ([2001:4830:134:3::10]:48678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwY-00085A-89
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwX-0000NQ-B0
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:14 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:23 +0200
Message-Id: <20170704220346.29244-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/35] raw: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:raw" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/raw-format.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index 0d185fe41b..402d3b9fba 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -361,7 +361,8 @@ static void raw_lock_medium(BlockDriverState *bs, boo=
l locked)
     bdrv_lock_medium(bs->file->bs, locked);
 }
=20
-static int raw_co_ioctl(BlockDriverState *bs, unsigned long int req, voi=
d *buf)
+static int coroutine_fn
+raw_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
 {
     BDRVRawState *s =3D bs->opaque;
     if (s->offset || s->has_size) {
@@ -375,7 +376,8 @@ static int raw_has_zero_init(BlockDriverState *bs)
     return bdrv_has_zero_init(bs->file->bs);
 }
=20
-static int raw_create(const char *filename, QemuOpts *opts, Error **errp=
)
+static int coroutine_fn
+raw_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     return bdrv_create_file(filename, opts, errp);
 }
--=20
2.13.1.395.gf7b71de06
