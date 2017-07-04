Received: from eggs.gnu.org ([2001:4830:134:3::10]:48461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVw8-0007dd-IR
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVw7-0008Us-NX
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:48 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:19 +0200
Message-Id: <20170704220346.29244-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/35] block: all bdrv_aio callbacks are
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/block/block_int.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 15fa602150..93eb2a9528 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -133,15 +133,15 @@ struct BlockDriver {
     void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
=20
     /* aio */
-    BlockAIOCB *(*bdrv_aio_readv)(BlockDriverState *bs,
+    BlockAIOCB * coroutine_fn (*bdrv_aio_readv)(BlockDriverState *bs,
         int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
         BlockCompletionFunc *cb, void *opaque);
-    BlockAIOCB *(*bdrv_aio_writev)(BlockDriverState *bs,
+    BlockAIOCB * coroutine_fn (*bdrv_aio_writev)(BlockDriverState *bs,
         int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
         BlockCompletionFunc *cb, void *opaque);
-    BlockAIOCB *(*bdrv_aio_flush)(BlockDriverState *bs,
+    BlockAIOCB * coroutine_fn (*bdrv_aio_flush)(BlockDriverState *bs,
         BlockCompletionFunc *cb, void *opaque);
-    BlockAIOCB *(*bdrv_aio_pdiscard)(BlockDriverState *bs,
+    BlockAIOCB * coroutine_fn (*bdrv_aio_pdiscard)(BlockDriverState *bs,
         int64_t offset, int bytes,
         BlockCompletionFunc *cb, void *opaque);
=20
@@ -247,7 +247,7 @@ struct BlockDriver {
     void (*bdrv_lock_medium)(BlockDriverState *bs, bool locked);
=20
     /* to control generic scsi devices */
-    BlockAIOCB *(*bdrv_aio_ioctl)(BlockDriverState *bs,
+    BlockAIOCB * coroutine_fn (*bdrv_aio_ioctl)(BlockDriverState *bs,
         unsigned long int req, void *buf,
         BlockCompletionFunc *cb, void *opaque);
     int coroutine_fn (*bdrv_co_ioctl)(BlockDriverState *bs,
--=20
2.13.1.395.gf7b71de06
