Received: from eggs.gnu.org ([2001:4830:134:3::10]:47147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnId8-00047e-H4
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 03:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnId5-0003De-8A
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 03:11:38 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Wed,  8 Aug 2018 10:10:51 +0300
Message-Id: <20180808071051.30628-6-lbloch@janustech.com>
In-Reply-To: <20180808071051.30628-1-lbloch@janustech.com>
References: <20180808071051.30628-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 5/5] qcow2: Explicit number replaced by a
 constant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 block/qcow2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 453a6377ac..a54e20402b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1321,7 +1321,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     /* 2^(s->refcount_order - 3) is the refcount width in bytes */
     s->refcount_block_bits = s->cluster_bits - (s->refcount_order - 3);
     s->refcount_block_size = 1 << s->refcount_block_bits;
-    bs->total_sectors = header.size / 512;
+    bs->total_sectors = header.size / BDRV_SECTOR_SIZE;
     s->csize_shift = (62 - (s->cluster_bits - 8));
     s->csize_mask = (1 << (s->cluster_bits - 8)) - 1;
     s->cluster_offset_mask = (1LL << s->csize_shift) - 1;
@@ -3446,7 +3446,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         goto fail;
     }
 
-    old_length = bs->total_sectors * 512;
+    old_length = bs->total_sectors * BDRV_SECTOR_SIZE;
     new_l1_size = size_to_l1(s, offset);
 
     if (offset < old_length) {
-- 
2.17.1
