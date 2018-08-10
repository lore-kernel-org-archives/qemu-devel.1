Received: from eggs.gnu.org ([2001:4830:134:3::10]:49573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fo0tl-00073A-UW
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fo0tj-0001qI-99
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:27:45 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Fri, 10 Aug 2018 09:26:47 +0300
Message-Id: <20180810062647.23211-10-lbloch@janustech.com>
In-Reply-To: <20180810062647.23211-1-lbloch@janustech.com>
References: <20180810062647.23211-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 9/9] qcow2: Explicit number replaced by a
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
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b4f291765b..b0e20aeffc 100644
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
2.17.1
