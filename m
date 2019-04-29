Received: from eggs.gnu.org ([209.51.188.92]:56808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF4-0003Ig-OR
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF0-0002QU-Od
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:06 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 29 Apr 2019 20:42:40 +0200
Message-Id: <e823a4cb62ef8ab37d3e30773052a5f69393f06c.1556562150.git.berto@igalia.com>
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 5/5] qcow2: Remove
 BDRVQcow2State.cluster_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

The last user of this field disappeared when we replace the
sector-based bdrv_write() with the byte-based bdrv_pwrite().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 1 -
 block/qcow2.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3ace3b2209..3a3240fcca 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1259,7 +1259,6 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
 
     s->cluster_bits = header.cluster_bits;
     s->cluster_size = 1 << s->cluster_bits;
-    s->cluster_sectors = 1 << (s->cluster_bits - BDRV_SECTOR_BITS);
 
     /* Initialise version 3 header fields */
     if (header.version == 2) {
diff --git a/block/qcow2.h b/block/qcow2.h
index fdee297f33..e62508d1ce 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -266,7 +266,6 @@ typedef struct Qcow2BitmapHeaderExt {
 typedef struct BDRVQcow2State {
     int cluster_bits;
     int cluster_size;
-    int cluster_sectors;
     int l2_slice_size;
     int l2_bits;
     int l2_size;
-- 
2.11.0
