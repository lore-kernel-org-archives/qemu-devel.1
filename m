Received: from eggs.gnu.org ([2001:4830:134:3::10]:48998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxL-0000LB-3N
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxK-0000p5-8d
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:03 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:32 +0200
Message-Id: <20170704220346.29244-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 21/35] rbd: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:RBD" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/rbd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 9da02cdceb..7b4d548cd2 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -348,7 +348,8 @@ static QemuOptsList runtime_opts =3D {
     },
 };
=20
-static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error *=
*errp)
+static int coroutine_fn
+qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     Error *local_err =3D NULL;
     int64_t bytes =3D 0;
@@ -861,7 +862,8 @@ failed:
     return NULL;
 }
=20
-static BlockAIOCB *qemu_rbd_aio_readv(BlockDriverState *bs,
+static BlockAIOCB * coroutine_fn
+qemu_rbd_aio_readv(BlockDriverState *bs,
                                       int64_t sector_num,
                                       QEMUIOVector *qiov,
                                       int nb_sectors,
@@ -873,7 +875,8 @@ static BlockAIOCB *qemu_rbd_aio_readv(BlockDriverStat=
e *bs,
                          RBD_AIO_READ);
 }
=20
-static BlockAIOCB *qemu_rbd_aio_writev(BlockDriverState *bs,
+static BlockAIOCB * coroutine_fn
+qemu_rbd_aio_writev(BlockDriverState *bs,
                                        int64_t sector_num,
                                        QEMUIOVector *qiov,
                                        int nb_sectors,
@@ -886,7 +889,8 @@ static BlockAIOCB *qemu_rbd_aio_writev(BlockDriverSta=
te *bs,
 }
=20
 #ifdef LIBRBD_SUPPORTS_AIO_FLUSH
-static BlockAIOCB *qemu_rbd_aio_flush(BlockDriverState *bs,
+static BlockAIOCB * coroutine_fn
+qemu_rbd_aio_flush(BlockDriverState *bs,
                                       BlockCompletionFunc *cb,
                                       void *opaque)
 {
@@ -1063,7 +1067,8 @@ static int qemu_rbd_snap_list(BlockDriverState *bs,
 }
=20
 #ifdef LIBRBD_SUPPORTS_DISCARD
-static BlockAIOCB *qemu_rbd_aio_pdiscard(BlockDriverState *bs,
+static BlockAIOCB * coroutine_fn
+qemu_rbd_aio_pdiscard(BlockDriverState *bs,
                                          int64_t offset,
                                          int bytes,
                                          BlockCompletionFunc *cb,
--=20
2.13.1.395.gf7b71de06
