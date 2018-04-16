Received: from eggs.gnu.org ([2001:4830:134:3::10]:39800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f82Ya-0006Ab-21
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f82YU-0005lE-VS
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:44:23 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 16 Apr 2018 14:44:10 +0300
Message-Id: <20180416114414.18406-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180416114414.18406-1-vsementsov@virtuozzo.com>
References: <20180416114414.18406-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 3/7] dirty-bitmap: remove missed
 bdrv_dirty_bitmap_get_autoload header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 1ff8949b1b..c7e910016d 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -88,7 +88,6 @@ int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes);
 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
-bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_qmp_locked(BdrvDirtyBitmap *bitmap);
 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
-- 
2.11.1
