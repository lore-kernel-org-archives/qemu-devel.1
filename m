Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ACAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC73C20850
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dZlI2o2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC73C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FeO-00083k-TK
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1FZ6-0000QV-TC
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1FZ5-0000ad-31
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:49:40 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47023)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1FZ0-0000VF-Jw; Fri, 23 Aug 2019 15:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566589774; x=1598125774;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ArUqT7gctwo2CvLYjZvaT+85TujFifdpj4yt8JCxXJM=;
 b=dZlI2o2V+aNvz81HsUBVYdTyXC/KHYpxu+A+tAIkF/JkRK9X7IKvQwBn
 rGYIwg6pDqBWLBUSTBGKOe4RWziJS7DcsYRrE76lBrBc94OlZkl+j/tgY
 chpFVxJE4BoKi49OZyF6WaHW8SthHO1K5MR1lz1d99s9peUkbjSzXKMv8
 yQaDdglZ7lITe0+TdbWBZetXhzpbG37n2jWVFWTt7ifDxi6k2ItBYHpG0
 hsOcmbpRL9iXXDqq12qcDpmO1EPS3rJZDH3iwJsSYAebJTU7TADV+sr1H
 vihM9tqPcursKHYosVVKReJnfDrnkXmhO6NIG5PM6+hQd1B2tA1vkZhiY w==;
IronPort-SDR: /UxrVOYPyLgIZ9FwO/lRiIxcY0cq1KXTGhflB0CPqVfficLGlXk67Wtch2I2ebuOjZt3CvySDe
 mbSaIElOqhoHL3dtNGME6gMzFI35lnWD89B67vvo9dMHq54lDKhlKXq23gWp4rlD6PFSMnJC+v
 f5r9BVKjXkxfZ1BBKCkBohSWnnH2njkosy8cJN9/ZiWVohDDYeGm3AX+jt1MSKBRUfc8OmNR0s
 s315XaWVRCdpz4f1FYHPwflOtMGUNNVVt8G4THsoqc81D69w7ELbBsLVvPHuFWbYkle7hU5iDg
 zkk=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="223162546"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 03:49:32 +0800
IronPort-SDR: +K+5GtX5218W74b7tDc+y6IiiUHb348xMmdQjxgT35Lq17GjRyIHeGmZnQ2jRmtXm+NvxA9QK1
 4XTsrRvfgJ/1/QRfRAD+FhW/QScwDFO3alRDG+YFy1wi6YdwEdAc/Spj1ZbBehaJ2GlMfVf82b
 CMdwkrQEEoJiYMXMxj5SwXt4JC+QMwy2hAKK8jkV1sSQ3oh1fsmKjA0jrX7W2hj/RfGGa5VP0C
 kYFdI3b70Yp73co85CLntytf9yWWroSnd0cbPLocQJYZbc3yjkYZ8ME3cRUUwaClmUiRW9Y2+k
 PgvcuQBFl/XZdl4mZKT7mvVE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 12:46:49 -0700
IronPort-SDR: 6A7zUUx6WEpxSPBoP0l0I2jMehnUqOsS+i8Ky/ge2bFM0VVnadEylExS+xkRvFZXpx1VW/v27d
 Gsb2WBXQHBtCyuXH/uFym7Zj2IPoNXc9QbSBbzxz2BiXlERudr6dYS4fTNcf04OlPXHE3HlzWL
 zXz0Ae9YyYPnDx9Kdh1ThPLuT+cvQYQye3sUDYlkMIVlcXMDTZOYaxEtK6UcUx9tLnNNBP7VxT
 0jk/yjebneITZVTU6VuCutLG4Ox0j5I3E+kRGn/x26SeJ9CnR1CFmfklSrNGYM1kAe8nP4jtjt
 4RQ=
WDCIronportException: Internal
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 12:49:31 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Fri, 23 Aug 2019 15:49:26 -0400
Message-Id: <20190823194927.23278-4-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
References: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v5 3/4] block/ide/scsi: Set
 BLK_PERM_SUPPORT_ZONED
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
backend can handle zoned block devices or not.

blkconf_apply_backend_options() then sets BLK_PERM_SUPPORT_ZONED
permission accordingly. The raw code can then use this permission
to allow or deny opening a zone device by a particular block driver.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Acked-by: Paul Durrant <paul.durrant@citrix.com>
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
index bf56c7612b..23fbe4d567 100644
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
+        perm |= BLK_PERM_SUPPORT_ZONED;
+    }
 
     shared_perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
-                  BLK_PERM_GRAPH_MOD;
+                  BLK_PERM_GRAPH_MOD | BLK_PERM_SUPPORT_ZONED;
     if (resizable) {
         shared_perm |= BLK_PERM_RESIZE;
     }
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index ac5d31e8c1..c5f41b3eb6 100644
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
+    				       errp)) {
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


