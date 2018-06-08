Received: from eggs.gnu.org ([2001:4830:134:3::10]:46327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fRGZM-0000fb-Ij
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fRGZK-0005tZ-IM
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:32:40 -0400
Received: from mx2.mpynet.fi ([82.197.21.85]:27588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ari@tuxera.com>) id 1fRGZK-0005sM-9P
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:32:38 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Fri, 8 Jun 2018 15:32:22 +0300
Message-ID: <1528461148-17925-5-git-send-email-ari@tuxera.com>
In-Reply-To: <1528461148-17925-1-git-send-email-ari@tuxera.com>
References: <1528461148-17925-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 04/10] hw/scsi/scsi-disk: Always apply block
 configuration to block driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
	Zheng <famz@redhat.com>

This allows the block driver to use the block configuration of the new
SCSI device. One use for this information is to set request limits
using this information.

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
