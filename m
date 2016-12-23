Received: from eggs.gnu.org ([2001:4830:134:3::10]:40549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKUBL-0000cw-O4
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKUBK-0005IK-NE
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:03:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:57 +0300
Message-ID: <1482503344-6424-15-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 14/21] block: add trace point on bdrv_close_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com, jcody@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c            | 1 +
 block/trace-events | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block.c b/block.c
index 39ddea3..3aa433b 100644
--- a/block.c
+++ b/block.c
@@ -2372,6 +2372,7 @@ static void bdrv_close(BlockDriverState *bs)
 
 void bdrv_close_all(void)
 {
+    trace_bdrv_close_all();
     block_job_cancel_sync_all();
     nbd_export_close_all();
 
diff --git a/block/trace-events b/block/trace-events
index 832e8ed..e7a7372 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -3,6 +3,7 @@
 # block.c
 bdrv_open_common(void *bs, const char *filename, int flags, const char *format_name) "bs %p filename \"%s\" flags %#x format_name \"%s\""
 bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
+bdrv_close_all(void) ""
 
 # block/block-backend.c
 blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags %x"
-- 
1.8.3.1
