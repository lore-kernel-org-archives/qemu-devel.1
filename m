Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB13C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E5E205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XdjK5WQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E5E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnrTR-0003kw-0i
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 17:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49599)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrSB-0006oy-3k
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrS9-0006zB-Lu
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:27:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrS9-0006xf-D4; Wed, 17 Jul 2019 17:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563398829; x=1594934829;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=by5qDPAghaT24+Q7Y+BWV+7eEwBr8LsYWNFox979xzw=;
 b=XdjK5WQ4+7Yf2BRAFb3PvW8SDT6sGb5Tv5c8XsQc/jih643VejUwIJVR
 hBoEp2yJK02UefAammLOocjO0/Jpqz2me7IiecRQxdieKrNruKT6Djtqt
 V/BYt0a8EndDknqVYOuRmQTte87YfWcRzaZlvbWea55fMldR/ld07YF/o
 NU/EkY97ujfDFB+Py7VIkdbyBZr/THDke24Vbmoz3RalxOP9Nopwyorvn
 Wg8YGfwbrjNE2A9FZxAJSoLeCFvibL+gINxk14gfVZW8I7WXD/fm4KOX0
 m45x5SNvXQ2hSChVDpC4E9plcWE37hf3EMsBH6U6hZNNs8y7BdYEQAmY/ w==;
IronPort-SDR: 9OpBeZ63nJQTrIb7t75dVdmPWwI/GWZhDybkptkGLuObhQq/5zdE0maxgNp7r4UJXJQwV/tTpW
 51buf0Hb+ZgSFCJwODigFsMjHHV5U3rrnmWEEyz6KKjGxEHl14vkpY0E6W9Ib1YbVYJT0x7JDQ
 9A5l3E3waluUVwbCknsifQYd1iUMkMFr2RjbqcEE8K5j25+3afETaXud/wR8I/VriGryVkm3HU
 NCKcn/RjO/bjniXcNMCmQEgqMsNmzZ2ep2gPqqMF1aMKdHlHdnYUdHKF/tuYNmska8ALFH9tRL
 6j4=
X-IronPort-AV: E=Sophos;i="5.64,275,1559491200"; d="scan'208";a="113319444"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2019 05:27:07 +0800
IronPort-SDR: N14iLDMXInbykI+cWVS3K5L0xgFr4TuTL5YD8ivTviKkH6FH+WxJAQ9JNEhfuW/neS9YqG2LPc
 IVHpcNGgTo0Kql5KerCferRVWpIm5BhF4Ve7dQ16IXQVYyRGx0SjdManfT52ibiPx5tWYpx1hP
 vKVOevpuH/QigZIYt1diAcmVU2C+IsbM4yWuaGq5H1VzbqDiLqfy/upDb7xzItUSybouL/o9WO
 1tf/yQDA++vVNcoD3k0D7Mv9o08gDeBP/hNP2vPMB0MOFkI95y3hfEHCuiCPkx2Q7GRkLBg9gE
 DFbkfdmqZxy1KZz33OoS1mJx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 17 Jul 2019 14:25:35 -0700
IronPort-SDR: KaA+C8Ge9txD3jq/Sz0bsuNZVJ/bR55MQSq9f8BXS3ZAEMQXRS/PpwxPcEov+A8K9cAcicxxH2
 QAryfRRsCN2N0bNTCZnKEBblogBgGPHrkX7SElZaoS92vTHNmtPwIYE09AhneiIY9fxyw4WuB+
 4fmh7i8wqm8f6NSqWL4W2pdJu15wBttvzAz/RjI5r5aQ728pKpk67pdEPPqfSOpQFqRRz7r7mT
 dPjORN0tPmqI8J/skfwTfsv6nPgLW1wPDE7D92sfqhUyAS/sJnFQ6DeRXeAFaOcX0yFyZAP0x/
 iJk=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 Jul 2019 14:27:07 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 17 Jul 2019 17:27:01 -0400
Message-Id: <20190717212703.10205-4-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717212703.10205-1-dmitry.fomichev@wdc.com>
References: <20190717212703.10205-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v2 3/5] block/ide/scsi: Set
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Paul Durrant <paul.durrant@citrix.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
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
---
 hw/block/block.c         |  8 ++++++--
 hw/block/fdc.c           |  4 ++--
 hw/block/nvme.c          |  2 +-
 hw/block/virtio-blk.c    |  2 +-
 hw/block/xen-block.c     |  2 +-
 hw/ide/qdev.c            |  2 +-
 hw/scsi/scsi-disk.c      | 13 +++++++------
 hw/scsi/scsi-generic.c   |  2 +-
 hw/usb/dev-storage.c     |  2 +-
 include/hw/block/block.h |  3 ++-
 10 files changed, 23 insertions(+), 17 deletions(-)

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
index 77af9979de..85efc80992 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -474,7 +474,7 @@ static void fd_change_cb(void *opaque, bool load, Error **errp)
     } else {
         if (!blkconf_apply_backend_options(drive->conf,
                                            blk_is_read_only(drive->blk), false,
-                                           errp)) {
+                                           false, errp)) {
             return;
         }
     }
@@ -561,7 +561,7 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
 
     if (!blkconf_apply_backend_options(&dev->conf,
                                        blk_is_read_only(dev->conf.blk),
-                                       false, errp)) {
+                                       false, false, errp)) {
         return;
     }
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 36d6a8bb3a..71b35bf4e7 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1333,7 +1333,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     }
     blkconf_blocksizes(&n->conf);
     if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
-                                       false, errp)) {
+                                       false, false, errp)) {
         return;
     }
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index cbb3729158..8894bdbb0c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1123,7 +1123,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
 
     if (!blkconf_apply_backend_options(&conf->conf,
                                        blk_is_read_only(conf->conf.blk), true,
-                                       errp)) {
+                                       false, errp)) {
         return;
     }
     s->original_wce = blk_enable_write_cache(conf->conf.blk);
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 69d73196e2..8ed5e9d832 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -228,7 +228,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
     }
 
     if (!blkconf_apply_backend_options(conf, blockdev->info & VDISK_READONLY,
-                                       true, errp)) {
+                                       true, false, errp)) {
         return;
     }
 
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 9d8502785d..c0b4a445e4 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -197,7 +197,7 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
         }
     }
     if (!blkconf_apply_backend_options(&dev->conf, kind == IDE_CD,
-                                       kind != IDE_CD, errp)) {
+                                       kind != IDE_CD, false, errp)) {
         return;
     }
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 8e95e3e38d..f20815b1d7 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2315,7 +2315,7 @@ static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
     }
 }
 
-static void scsi_realize(SCSIDevice *dev, Error **errp)
+static void scsi_realize(SCSIDevice *dev, bool zoned_support, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
 
@@ -2353,7 +2353,8 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     }
     if (!blkconf_apply_backend_options(&dev->conf,
                                        blk_is_read_only(s->qdev.conf.blk),
-                                       dev->type == TYPE_DISK, errp)) {
+                                       dev->type == TYPE_DISK, zoned_support,
+                                       errp)) {
         return;
     }
 
@@ -2412,7 +2413,7 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
     if (!s->product) {
         s->product = g_strdup("QEMU HARDDISK");
     }
-    scsi_realize(&s->qdev, errp);
+    scsi_realize(&s->qdev, false, errp);
     if (ctx) {
         aio_context_release(ctx);
     }
@@ -2440,7 +2441,7 @@ static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
     if (!s->product) {
         s->product = g_strdup("QEMU CD-ROM");
     }
-    scsi_realize(&s->qdev, errp);
+    scsi_realize(&s->qdev, false, errp);
     aio_context_release(ctx);
 }
 
@@ -2450,7 +2451,7 @@ static void scsi_disk_realize(SCSIDevice *dev, Error **errp)
     Error *local_err = NULL;
 
     if (!dev->conf.blk) {
-        scsi_realize(dev, &local_err);
+        scsi_realize(dev, false, &local_err);
         assert(local_err);
         error_propagate(errp, local_err);
         return;
@@ -2643,7 +2644,7 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
      */
     s->features |= (1 << SCSI_DISK_F_NO_REMOVABLE_DEVOPS);
 
-    scsi_realize(&s->qdev, errp);
+    scsi_realize(&s->qdev, true, errp);
     scsi_generic_read_device_inquiry(&s->qdev);
 
 out:
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index f07891b3f6..a43efe39ec 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -686,7 +686,7 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
     }
     if (!blkconf_apply_backend_options(&s->conf,
                                        blk_is_read_only(s->conf.blk),
-                                       true, errp)) {
+                                       true, true, errp)) {
         return;
     }
 
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 9ffb88ea5b..60d6a92ce1 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -601,7 +601,7 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
 
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


