Received: from eggs.gnu.org ([209.51.188.92]:49963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9187e18d5=Paul.Durrant@citrix.com>)
	id 1gm17r-0007Tc-BQ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9187e18d5=Paul.Durrant@citrix.com>)
	id 1gm17k-0007S0-Co
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:50:15 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 22 Jan 2019 14:51:32 +0000
Message-ID: <20190122145132.12571-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] hw/block: clean up stake xen_disk trace entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This should have been removed then xen_disk.c was removed but I missed them.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/trace-events | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index 55e5a5500c..d0851953c5 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -121,13 +121,6 @@ nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completion queue
 nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write for nonexistent queue, sqid=%"PRIu32", ignoring"
 nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submission queue doorbell write value beyond queue size, sqid=%"PRIu32", new_head=%"PRIu16", ignoring"
 
-# hw/block/xen_disk.c
-xen_disk_alloc(char *name) "%s"
-xen_disk_init(char *name) "%s"
-xen_disk_connect(char *name) "%s"
-xen_disk_disconnect(char *name) "%s"
-xen_disk_free(char *name) "%s"
-
 # hw/block/xen-block.c
 xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
 xen_block_connect(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
-- 
2.20.1.2.gb21ebb6
