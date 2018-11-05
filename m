Received: from eggs.gnu.org ([2001:4830:134:3::10]:50647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhuD-0007sZ-Hz
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhtz-0005AL-DE
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:39:06 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:17 +0100
Message-Id: <20181105163744.25139-10-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/36] block: change some function return type
 to bool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/sysemu/block-backend.h | 6 +++---
 block/block-backend.c          | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index 830d873f24..c96bcdee14 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -166,9 +166,9 @@ BlockErrorAction blk_get_error_action(BlockBackend *b=
lk, bool is_read,
                                       int error);
 void blk_error_action(BlockBackend *blk, BlockErrorAction action,
                       bool is_read, int error);
-int blk_is_read_only(BlockBackend *blk);
-int blk_is_sg(BlockBackend *blk);
-int blk_enable_write_cache(BlockBackend *blk);
+bool blk_is_read_only(BlockBackend *blk);
+bool blk_is_sg(BlockBackend *blk);
+bool blk_enable_write_cache(BlockBackend *blk);
 void blk_set_enable_write_cache(BlockBackend *blk, bool wce);
 void blk_invalidate_cache(BlockBackend *blk, Error **errp);
 bool blk_is_inserted(BlockBackend *blk);
diff --git a/block/block-backend.c b/block/block-backend.c
index dc0cd57724..2a8f3b55f8 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1708,7 +1708,7 @@ void blk_error_action(BlockBackend *blk, BlockError=
Action action,
     }
 }
=20
-int blk_is_read_only(BlockBackend *blk)
+bool blk_is_read_only(BlockBackend *blk)
 {
     BlockDriverState *bs =3D blk_bs(blk);
=20
@@ -1719,18 +1719,18 @@ int blk_is_read_only(BlockBackend *blk)
     }
 }
=20
-int blk_is_sg(BlockBackend *blk)
+bool blk_is_sg(BlockBackend *blk)
 {
     BlockDriverState *bs =3D blk_bs(blk);
=20
     if (!bs) {
-        return 0;
+        return false;
     }
=20
     return bdrv_is_sg(bs);
 }
=20
-int blk_enable_write_cache(BlockBackend *blk)
+bool blk_enable_write_cache(BlockBackend *blk)
 {
     return blk->enable_write_cache;
 }
--=20
2.19.1
