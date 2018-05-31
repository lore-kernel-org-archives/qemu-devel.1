Received: from eggs.gnu.org ([2001:4830:134:3::10]:52529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fOUxE-0004pn-54
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fOUxD-0008CH-HE
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:17:52 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Fri, 1 Jun 2018 00:17:21 +0300
Message-ID: <1527801443-30620-3-git-send-email-ari@tuxera.com>
In-Reply-To: <1527801443-30620-2-git-send-email-ari@tuxera.com>
References: <1527801443-30620-1-git-send-email-ari@tuxera.com>
	<1527801443-30620-2-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/5] hw/scsi/scsi-disk: Always apply block
 configuration to block driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Ari Sundholm <ari@tuxera.com>

This is an example of what all block devices should ideally do in their
realization functions to convey the block configuration to the block
driver.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 hw/scsi/scsi-disk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index ded23d3..d50517e 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2413,6 +2413,7 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
         blk_set_dev_ops(s->qdev.conf.blk, &scsi_disk_block_ops, s);
     }
     blk_set_guest_block_size(s->qdev.conf.blk, s->qdev.blocksize);
+    blkconf_apply_to_blkdrv(&s->qdev.conf);
 
     blk_iostatus_enable(s->qdev.conf.blk);
 }
-- 
2.7.4
