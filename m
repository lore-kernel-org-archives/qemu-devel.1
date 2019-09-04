Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF01C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B6520828
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jwxARo6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B6520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5dHi-0000ma-Up
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOy-0006Jf-DV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOt-0007bq-N2
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:01:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOp-0007Va-Mv; Wed, 04 Sep 2019 17:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567630868; x=1599166868;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OnXlkFcTPYgqEfiUU2UuIQATvEj+6IvGP2VEZxsujN4=;
 b=jwxARo6yRjklusEC/Vc67Xeek9l9xNH/lRCMT2+7oYbUtgrExzfjBVwL
 hjTbYyIyfrvhRPY+xCO2PNq8JaKqjouOtOl/ONbgpLotoBWHvv4gDLkCj
 eGedgNC+VOLBGr12lI6tznVgmYmvYIOnf6Xq8HqTK5IauCXGMKNNF2+cI
 4klEXTGmhVz4Oy6M+ebd8lsY3QvoVSfakIE03HobHNxWcxL1IJIrozScO
 XDWcKC83fHTguSAJjSzXy4aybXnIEqU3KGuQNzDyz85sT6EIT1UHqofbG
 Z429mHy1DoSDqKw7UNF5U9VQxNWRvhedQOnQ/AU3z2dGSBCvnrBcBNDhd w==;
IronPort-SDR: WbHX3yCigadLrHQfGXOqAlhN2k2m3yMr9LefBeFmVa6/ZVjzT3CKw2lpIlX+AexisDlEy1iP/q
 nWNJVG+QBJaEvMzO2JoL0HbIXgj/JZQcnJtP6LHmbeU3KfNRJ9iEIKDVZewQ7XcRRCV+awvNml
 BIITs/SUCgEPnvTBKJErtxBM1afAoQ+W4Y6ErOgVD+sKOf/kg8NLhB1Yy/84CxZ/xmvll5++2S
 Bq3b1Vxzzzuej8cRkXJmfBDfxgnM3RFPHo1QY8weo7baJ7qgJAzD56LkeEIxZN3mgzfceaq2FN
 jlQ=
X-IronPort-AV: E=Sophos;i="5.64,468,1559491200"; d="scan'208";a="117451668"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2019 05:01:05 +0800
IronPort-SDR: LGsGmm3Jc940Op4Pz2Rz7Ysrrh6TAS2PCB+FOc7H14MqZxNW//MPN6kyGaR1iSjk90m7Yn1G0/
 MJn6UClJ9SoRVLwalGklYDcmOqG+zid9bp4lsV80fTuNrdSwnQ6gdTv4bU0cI964xMT7WxDz23
 8z6aPDooqopPotvf6D4tdsuR8RAQn/fCrNQige9Uz18+xtOdnoNS4nB5qh3P6BOdN3X46iAtwB
 eiz6hKbf+nb1qCPerzAqVG2pU+z6aZaXDMC1ajt6+QciSvaTAhAJXDOtBizLxj0q86pKoDJNda
 5unWJuzOQysUqJSxiH6ySbGE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 13:58:02 -0700
IronPort-SDR: cqKao75qHF6NxRG9ovjx3b4dt77CkyyhAEqcwRc56FqTjxJ/S+wVI/Ls68TdBj4BctdpBG9NSR
 4ZCGb1E8Ws2BjCiUOqtjm9rUWxMejgJvH8v8k5988obAitcxecTBWmBDIwTp5SVQDuzJ5ScoZc
 cj4P5Ygfxupb49cGuqxi6zQSIPASP37SOFidVgiqUXffwPV8bwK30ArTPm7YdSHqY3I0Knk5t5
 kqiRQ9DJYVyhmyLblNvFbzKe8ikTA2I5OABvHUvUH3+TII6lxdYpB6evgZ4hfB199gmGf7TWK6
 jiU=
WDCIronportException: Internal
Received: from dhcp-10-88-173-181.hgst.com ([10.88.173.181])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Sep 2019 14:01:04 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Wed,  4 Sep 2019 17:00:59 -0400
Message-Id: <20190904210100.10501-4-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
References: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v6 3/4] block/ide/scsi: Set
 BLK_PERM_SUPPORT_HM_ZONED
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added a new boolean argument to blkconf_apply_backend_options()
to let the common block code know whether the chosen block
backend can handle host managed zoned block devices.

blkconf_apply_backend_options() then sets BLK_PERM_SUPPORT_HM_ZONED
permission accordingly. The raw code can then use this permission
to allow or deny opening a zone device by a particular block driver.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Acked-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/block.c         |  8 ++++++--
 hw/block/fdc.c           |  5 +++--
 hw/block/nvme.c          |  2 +-
 hw/block/virtio-blk.c    |  2 +-
 hw/block/xen-block.c     |  2 +-
 hw/ide/qdev.c            |  2 +-
 hw/scsi/scsi-disk.c      | 13 +++++++------
 hw/scsi/scsi-generic.c   |  2 +-
 hw/usb/dev-storage.c     |  2 +-
 include/hw/block/block.h |  3 ++-
 10 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index bf56c7612b..19f0e77bb2 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -86,7 +86,8 @@ void blkconf_blocksizes(BlockConf *conf)
 }
 
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
-                                   bool resizable, Error **errp)
+                                   bool resizable, bool zoned_support,
+                                   Error **errp)
 {
     BlockBackend *blk = conf->blk;
     BlockdevOnError rerror, werror;
@@ -98,9 +99,12 @@ bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
     if (!readonly) {
         perm |= BLK_PERM_WRITE;
     }
+    if (zoned_support) {
+        perm |= BLK_PERM_SUPPORT_HM_ZONED;
+    }
 
     shared_perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
-                  BLK_PERM_GRAPH_MOD;
+                  BLK_PERM_GRAPH_MOD | BLK_PERM_SUPPORT_HM_ZONED;
     if (resizable) {
         shared_perm |= BLK_PERM_RESIZE;
     }
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index ac5d31e8c1..673a8b39bc 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -477,7 +477,7 @@ static void fd_change_cb(void *opaque, bool load, Error **errp)
     } else {
         if (!blkconf_apply_backend_options(drive->conf,
                                            blk_is_read_only(drive->blk), false,
-                                           errp)) {
+                                           false, errp)) {
             return;
         }
     }
@@ -569,7 +569,8 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
     dev->conf.rerror = BLOCKDEV_ON_ERROR_AUTO;
     dev->conf.werror = BLOCKDEV_ON_ERROR_AUTO;
 
-    if (!blkconf_apply_backend_options(&dev->conf, read_only, false, errp)) {
+    if (!blkconf_apply_backend_options(&dev->conf, read_only, false, false,
+                                       errp)) {
         return;
     }
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 12d8254250..07f08d0768 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1334,7 +1334,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     }
     blkconf_blocksizes(&n->conf);
     if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
-                                       false, errp)) {
+                                       false, false, errp)) {
         return;
     }
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 18851601cb..8be62903e2 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1127,7 +1127,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
 
     if (!blkconf_apply_backend_options(&conf->conf,
                                        blk_is_read_only(conf->conf.blk), true,
-                                       errp)) {
+                                       false, errp)) {
         return;
     }
     s->original_wce = blk_enable_write_cache(conf->conf.blk);
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index f77343db60..57fe970908 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -229,7 +229,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
     }
 
     if (!blkconf_apply_backend_options(conf, blockdev->info & VDISK_READONLY,
-                                       true, errp)) {
+                                       true, false, errp)) {
         return;
     }
 
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 6fba6b62b8..a57a8f1a8f 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -200,7 +200,7 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
         }
     }
     if (!blkconf_apply_backend_options(&dev->conf, kind == IDE_CD,
-                                       kind != IDE_CD, errp)) {
+                                       kind != IDE_CD, false, errp)) {
         return;
     }
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 915641a0f1..8a57caafd7 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2318,7 +2318,7 @@ static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
     }
 }
 
-static void scsi_realize(SCSIDevice *dev, Error **errp)
+static void scsi_realize(SCSIDevice *dev, bool zoned_support, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
     bool read_only;
@@ -2362,7 +2362,8 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     }
 
     if (!blkconf_apply_backend_options(&dev->conf, read_only,
-                                       dev->type == TYPE_DISK, errp)) {
+                                       dev->type == TYPE_DISK, zoned_support,
+                                       errp)) {
         return;
     }
 
@@ -2421,7 +2422,7 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
     if (!s->product) {
         s->product = g_strdup("QEMU HARDDISK");
     }
-    scsi_realize(&s->qdev, errp);
+    scsi_realize(&s->qdev, false, errp);
     if (ctx) {
         aio_context_release(ctx);
     }
@@ -2449,7 +2450,7 @@ static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
     if (!s->product) {
         s->product = g_strdup("QEMU CD-ROM");
     }
-    scsi_realize(&s->qdev, errp);
+    scsi_realize(&s->qdev, false, errp);
     aio_context_release(ctx);
 }
 
@@ -2459,7 +2460,7 @@ static void scsi_disk_realize(SCSIDevice *dev, Error **errp)
     Error *local_err = NULL;
 
     if (!dev->conf.blk) {
-        scsi_realize(dev, &local_err);
+        scsi_realize(dev, false, &local_err);
         assert(local_err);
         error_propagate(errp, local_err);
         return;
@@ -2652,7 +2653,7 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
      */
     s->features |= (1 << SCSI_DISK_F_NO_REMOVABLE_DEVOPS);
 
-    scsi_realize(&s->qdev, errp);
+    scsi_realize(&s->qdev, true, errp);
     scsi_generic_read_device_inquiry(&s->qdev);
 
 out:
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index e7798ebcd0..ccce710497 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -692,7 +692,7 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
     }
     if (!blkconf_apply_backend_options(&s->conf,
                                        blk_is_read_only(s->conf.blk),
-                                       true, errp)) {
+                                       true, true, errp)) {
         return;
     }
 
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 8545193488..c75c0dd6a5 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -603,7 +603,7 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
 
     blkconf_blocksizes(&s->conf);
     if (!blkconf_apply_backend_options(&s->conf, blk_is_read_only(blk), true,
-                                       errp)) {
+                                       false, errp)) {
         return;
     }
 
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 607539057a..f988edc87e 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -85,7 +85,8 @@ bool blkconf_geometry(BlockConf *conf, int *trans,
                       Error **errp);
 void blkconf_blocksizes(BlockConf *conf);
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
-                                   bool resizable, Error **errp);
+                                   bool resizable, bool zoned_support,
+                                   Error **errp);
 
 /* Hard disk geometry */
 
-- 
2.21.0


