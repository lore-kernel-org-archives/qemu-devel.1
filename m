Received: from eggs.gnu.org ([2001:4830:134:3::10]:53684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70p-0002N0-Lc
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70m-0005iD-W0
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:07 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 14 Nov 2018 20:03:28 -0600
Message-Id: <20181115020334.1189829-8-eblake@redhat.com>
In-Reply-To: <20181115020334.1189829-1-eblake@redhat.com>
References: <20181115020334.1189829-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/13] blklogwrites: Audit for read/write
 64-bit cleanness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Ari Sundholm <ari@tuxera.com>, Max Reitz <mreitz@redhat.com>

Nothing in blk_log_writes_co_do_log() is inherently limited by
a 32-bit type; document this by updating the refresh_limits
callback to document that this driver is 64-bit clean.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/blklogwrites.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index ff98cd55333..c945d3d77d7 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -328,6 +328,7 @@ static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVBlkLogWritesState *s = bs->opaque;
     bs->bl.request_alignment = s->sectorsize;
+    bs->bl.max_transfer = INT64_MAX;
 }

 static int coroutine_fn
-- 
2.17.2
