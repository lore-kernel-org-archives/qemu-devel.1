Received: from eggs.gnu.org ([2001:4830:134:3::10]:33530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIjfk-0007vF-Ke
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIjfh-0006ZV-Ip
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:43:28 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:65518)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIjfh-0006Wk-7O
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:43:25 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Thu,  8 Jun 2017 01:43:16 +0300
Message-Id: <20170607224316.6952-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH] block: change variable names in
 BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org

Change the 'int count' parameter in bdrv_co_pwrite_zeros and
bdrv_co_pdiscard to 'int bytes', as they both refer to bytes.
This helps with code legibility.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 include/block/block_int.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index cb78c4f..06e398b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -162,9 +162,9 @@ struct BlockDriver {
      * will be called instead.
      */
     int coroutine_fn (*bdrv_co_pwrite_zeroes)(BlockDriverState *bs,
-        int64_t offset, int count, BdrvRequestFlags flags);
+        int64_t offset, int bytes, BdrvRequestFlags flags);
     int coroutine_fn (*bdrv_co_pdiscard)(BlockDriverState *bs,
-        int64_t offset, int count);
+        int64_t offset, int bytes);
 
     /*
      * Building block for bdrv_block_status[_above]. The driver should
-- 
2.11.0
