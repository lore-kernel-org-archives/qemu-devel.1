Received: from eggs.gnu.org ([2001:4830:134:3::10]:40837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dSJOr-0002uo-Qg
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dSJOr-0004qM-1p
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:41:37 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Tue,  4 Jul 2017 11:40:58 +0300
Message-Id: <20170704084059.6278-4-el13635@mail.ntua.gr>
In-Reply-To: <20170704084059.6278-1-el13635@mail.ntua.gr>
References: <20170704084059.6278-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v3 3/4] block: Remove bdrv_truncate callback in
 blkdebug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-block <qemu-block@nongnu.org>

Now that bdrv_truncate is passed to bs->file by default, remove the
callback from block/blkdebug.c

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/blkdebug.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index b25856c4..5e118e10 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -821,11 +821,6 @@ static int64_t blkdebug_getlength(BlockDriverState *bs)
     return bdrv_getlength(bs->file->bs);
 }
 
-static int blkdebug_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
-{
-    return bdrv_truncate(bs->file, offset, errp);
-}
-
 static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
 {
     BDRVBlkdebugState *s = bs->opaque;
@@ -916,7 +911,6 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_child_perm        = bdrv_filter_default_perms,
 
     .bdrv_getlength         = blkdebug_getlength,
-    .bdrv_truncate          = blkdebug_truncate,
     .bdrv_refresh_filename  = blkdebug_refresh_filename,
     .bdrv_refresh_limits    = blkdebug_refresh_limits,
 
-- 
2.11.0
