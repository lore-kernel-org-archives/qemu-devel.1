Received: from eggs.gnu.org ([2001:4830:134:3::10]:57840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rC-0002VM-IL
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rB-0007Ie-BZ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:57 +0200
Message-Id: <20181001171901.11004-20-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/23] qcow2: Explicit number replaced by a
 constant
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

From: Leonid Bloch <lbloch@janustech.com>

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 95e1c98daa..7277feda13 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1324,7 +1324,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     /* 2^(s->refcount_order - 3) is the refcount width in bytes */
     s->refcount_block_bits = s->cluster_bits - (s->refcount_order - 3);
     s->refcount_block_size = 1 << s->refcount_block_bits;
-    bs->total_sectors = header.size / 512;
+    bs->total_sectors = header.size / BDRV_SECTOR_SIZE;
     s->csize_shift = (62 - (s->cluster_bits - 8));
     s->csize_mask = (1 << (s->cluster_bits - 8)) - 1;
     s->cluster_offset_mask = (1LL << s->csize_shift) - 1;
@@ -3450,7 +3450,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         goto fail;
     }
 
-    old_length = bs->total_sectors * 512;
+    old_length = bs->total_sectors * BDRV_SECTOR_SIZE;
     new_l1_size = size_to_l1(s, offset);
 
     if (offset < old_length) {
-- 
2.13.6
