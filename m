Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URI_NOVOWEL,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20988C48BE9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD7F205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD7F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfR9A-0005Xr-82
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44886)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hfQy2-0003X3-7z
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hfQxz-0000MJ-Q2
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:14 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:11953)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hfQxz-0000JY-AW
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:11 -0400
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: DtRLvqc0OQttJbGxfrj2CMu3fCO0USvAN3kY8b2v+tCf975QkKMKnJE+tZweePJZvR6fLSO/VB
 Tfu7LGadR4xMXIg5ZLlfUsOo+YJ789K7tTy5qCfGamVQ/L2NEJ4gu9oLfC/YcllM0OlXFZ5Wbw
 jzlUYU9KlM2Us6DiTgRJFGpNAPnxxu81Dl5bGxZbABVFZc9dBjS19HfZJCFororxxITS6tKLfE
 vW7BOsRreuN1vaM/gCl24H6K8lWmdphl+ub1aiXMmYRiHnhZUmLW2n0+WU3E0VZHraDtpj9ZJY
 O5k=
X-SBRS: 2.7
X-MesageID: 2148095
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,412,1557201600"; 
   d="scan'208";a="2148095"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Mon, 24 Jun 2019 16:32:50 +0100
Message-ID: <20190624153257.20163-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624153257.20163-1-anthony.perard@citrix.com>
References: <20190624153257.20163-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.155
Subject: [Qemu-devel] [PULL 1/8] xen-block: support feature-large-sector-size
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
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paul Durrant <paul.durrant@citrix.com>

A recent Xen commit [1] clarified the semantics of sector based quantities
used in the blkif protocol such that it is now safe to create a xen-block
device with a logical_block_size != 512, as long as the device only
connects to a frontend advertizing 'feature-large-block-size'.

This patch modifies xen-block accordingly. It also uses a stack variable
for the BlockBackend in xen_block_realize() to avoid repeated dereferencing
of the BlockConf pointer, and changes the parameters of
xen_block_dataplane_create() so that the BlockBackend pointer and sector
size are passed expicitly rather than implicitly via the BlockConf.

These modifications have been tested against a recent Windows PV XENVBD
driver [2] using a xen-disk device with a 4kB logical block size.

[1] http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=67e1c050e36b2c9900cca83618e56189effbad98
[2] https://winpvdrvbuild.xenproject.org:8080/job/XENVBD-master/126

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20190409164038.25484-1-paul.durrant@citrix.com>
[Edited error message]
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/dataplane/xen-block.c | 25 ++++++++++++----------
 hw/block/dataplane/xen-block.h |  3 ++-
 hw/block/xen-block.c           | 38 +++++++++++++++++++++-------------
 3 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index f7ad452bbd..6da5c77fbb 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -58,6 +58,7 @@ struct XenBlockDataPlane {
     int requests_inflight;
     unsigned int max_requests;
     BlockBackend *blk;
+    unsigned int sector_size;
     QEMUBH *bh;
     IOThread *iothread;
     AioContext *ctx;
@@ -167,7 +168,7 @@ static int xen_block_parse_request(XenBlockRequest *request)
         goto err;
     }
 
-    request->start = request->req.sector_number * XEN_BLKIF_SECTOR_SIZE;
+    request->start = request->req.sector_number * dataplane->sector_size;
     for (i = 0; i < request->req.nr_segments; i++) {
         if (i == BLKIF_MAX_SEGMENTS_PER_REQUEST) {
             error_report("error: nr_segments too big");
@@ -177,14 +178,14 @@ static int xen_block_parse_request(XenBlockRequest *request)
             error_report("error: first > last sector");
             goto err;
         }
-        if (request->req.seg[i].last_sect * XEN_BLKIF_SECTOR_SIZE >=
+        if (request->req.seg[i].last_sect * dataplane->sector_size >=
             XC_PAGE_SIZE) {
             error_report("error: page crossing");
             goto err;
         }
 
         len = (request->req.seg[i].last_sect -
-               request->req.seg[i].first_sect + 1) * XEN_BLKIF_SECTOR_SIZE;
+               request->req.seg[i].first_sect + 1) * dataplane->sector_size;
         request->size += len;
     }
     if (request->start + request->size > blk_getlength(dataplane->blk)) {
@@ -218,17 +219,17 @@ static int xen_block_copy_request(XenBlockRequest *request)
         if (to_domain) {
             segs[i].dest.foreign.ref = request->req.seg[i].gref;
             segs[i].dest.foreign.offset = request->req.seg[i].first_sect *
-                XEN_BLKIF_SECTOR_SIZE;
+                dataplane->sector_size;
             segs[i].source.virt = virt;
         } else {
             segs[i].source.foreign.ref = request->req.seg[i].gref;
             segs[i].source.foreign.offset = request->req.seg[i].first_sect *
-                XEN_BLKIF_SECTOR_SIZE;
+                dataplane->sector_size;
             segs[i].dest.virt = virt;
         }
         segs[i].len = (request->req.seg[i].last_sect -
                        request->req.seg[i].first_sect + 1) *
-                      XEN_BLKIF_SECTOR_SIZE;
+                      dataplane->sector_size;
         virt += segs[i].len;
     }
 
@@ -336,12 +337,12 @@ static bool xen_block_split_discard(XenBlockRequest *request,
 
     /* Wrap around, or overflowing byte limit? */
     if (sec_start + sec_count < sec_count ||
-        sec_start + sec_count > INT64_MAX / XEN_BLKIF_SECTOR_SIZE) {
+        sec_start + sec_count > INT64_MAX / dataplane->sector_size) {
         return false;
     }
 
-    byte_offset = sec_start * XEN_BLKIF_SECTOR_SIZE;
-    byte_remaining = sec_count * XEN_BLKIF_SECTOR_SIZE;
+    byte_offset = sec_start * dataplane->sector_size;
+    byte_remaining = sec_count * dataplane->sector_size;
 
     do {
         byte_chunk = byte_remaining > BDRV_REQUEST_MAX_BYTES ?
@@ -625,13 +626,15 @@ static void xen_block_dataplane_event(void *opaque)
 }
 
 XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
-                                              BlockConf *conf,
+                                              BlockBackend *blk,
+                                              unsigned int sector_size,
                                               IOThread *iothread)
 {
     XenBlockDataPlane *dataplane = g_new0(XenBlockDataPlane, 1);
 
     dataplane->xendev = xendev;
-    dataplane->blk = conf->blk;
+    dataplane->blk = blk;
+    dataplane->sector_size = sector_size;
 
     QLIST_INIT(&dataplane->inflight);
     QLIST_INIT(&dataplane->freelist);
diff --git a/hw/block/dataplane/xen-block.h b/hw/block/dataplane/xen-block.h
index d6fa6d26dd..76dcd51c3d 100644
--- a/hw/block/dataplane/xen-block.h
+++ b/hw/block/dataplane/xen-block.h
@@ -15,7 +15,8 @@
 typedef struct XenBlockDataPlane XenBlockDataPlane;
 
 XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
-                                              BlockConf *conf,
+                                              BlockBackend *blk,
+                                              unsigned int sector_size,
                                               IOThread *iothread);
 void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane);
 void xen_block_dataplane_start(XenBlockDataPlane *dataplane,
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 4de537aef4..8f224ef81d 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -52,11 +52,25 @@ static void xen_block_connect(XenDevice *xendev, Error **errp)
     XenBlockDevice *blockdev = XEN_BLOCK_DEVICE(xendev);
     const char *type = object_get_typename(OBJECT(blockdev));
     XenBlockVdev *vdev = &blockdev->props.vdev;
+    BlockConf *conf = &blockdev->props.conf;
+    unsigned int feature_large_sector_size;
     unsigned int order, nr_ring_ref, *ring_ref, event_channel, protocol;
     char *str;
 
     trace_xen_block_connect(type, vdev->disk, vdev->partition);
 
+    if (xen_device_frontend_scanf(xendev, "feature-large-sector-size", "%u",
+                                  &feature_large_sector_size) != 1) {
+        feature_large_sector_size = 0;
+    }
+
+    if (feature_large_sector_size != 1 &&
+        conf->logical_block_size != XEN_BLKIF_SECTOR_SIZE) {
+        error_setg(errp, "logical_block_size != %u not supported by frontend",
+                   XEN_BLKIF_SECTOR_SIZE);
+        return;
+    }
+
     if (xen_device_frontend_scanf(xendev, "ring-page-order", "%u",
                                   &order) != 1) {
         nr_ring_ref = 1;
@@ -150,7 +164,7 @@ static void xen_block_set_size(XenBlockDevice *blockdev)
     const char *type = object_get_typename(OBJECT(blockdev));
     XenBlockVdev *vdev = &blockdev->props.vdev;
     BlockConf *conf = &blockdev->props.conf;
-    int64_t sectors = blk_getlength(conf->blk) / XEN_BLKIF_SECTOR_SIZE;
+    int64_t sectors = blk_getlength(conf->blk) / conf->logical_block_size;
     XenDevice *xendev = XEN_DEVICE(blockdev);
 
     trace_xen_block_size(type, vdev->disk, vdev->partition, sectors);
@@ -185,6 +199,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
     const char *type = object_get_typename(OBJECT(blockdev));
     XenBlockVdev *vdev = &blockdev->props.vdev;
     BlockConf *conf = &blockdev->props.conf;
+    BlockBackend *blk = conf->blk;
     Error *local_err = NULL;
 
     if (vdev->type == XEN_BLOCK_VDEV_TYPE_INVALID) {
@@ -206,8 +221,8 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
      * The blkif protocol does not deal with removable media, so it must
      * always be present, even for CDRom devices.
      */
-    assert(conf->blk);
-    if (!blk_is_inserted(conf->blk)) {
+    assert(blk);
+    if (!blk_is_inserted(blk)) {
         error_setg(errp, "device needs media, but drive is empty");
         return;
     }
@@ -224,26 +239,20 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
 
     blkconf_blocksizes(conf);
 
-    if (conf->logical_block_size != XEN_BLKIF_SECTOR_SIZE) {
-        error_setg(errp, "logical_block_size != %u not supported",
-                   XEN_BLKIF_SECTOR_SIZE);
-        return;
-    }
-
     if (conf->logical_block_size > conf->physical_block_size) {
         error_setg(
             errp, "logical_block_size > physical_block_size not supported");
         return;
     }
 
-    blk_set_dev_ops(conf->blk, &xen_block_dev_ops, blockdev);
-    blk_set_guest_block_size(conf->blk, conf->logical_block_size);
+    blk_set_dev_ops(blk, &xen_block_dev_ops, blockdev);
+    blk_set_guest_block_size(blk, conf->logical_block_size);
 
     if (conf->discard_granularity == -1) {
         conf->discard_granularity = conf->physical_block_size;
     }
 
-    if (blk_get_flags(conf->blk) & BDRV_O_UNMAP) {
+    if (blk_get_flags(blk) & BDRV_O_UNMAP) {
         xen_device_backend_printf(xendev, "feature-discard", "%u", 1);
         xen_device_backend_printf(xendev, "discard-granularity", "%u",
                                   conf->discard_granularity);
@@ -260,12 +269,13 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
                                blockdev->device_type);
 
     xen_device_backend_printf(xendev, "sector-size", "%u",
-                              XEN_BLKIF_SECTOR_SIZE);
+                              conf->logical_block_size);
 
     xen_block_set_size(blockdev);
 
     blockdev->dataplane =
-        xen_block_dataplane_create(xendev, conf, blockdev->props.iothread);
+        xen_block_dataplane_create(xendev, blk, conf->logical_block_size,
+                                   blockdev->props.iothread);
 }
 
 static void xen_block_frontend_changed(XenDevice *xendev,
-- 
Anthony PERARD


