Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CD4C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4023020739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwJrWi7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4023020739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw39S-0001za-GK
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 08:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw38V-0000I5-NI; Thu, 16 Jul 2020 08:37:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw38U-0002uD-0L; Thu, 16 Jul 2020 08:37:15 -0400
Received: by mail-wr1-x441.google.com with SMTP id j4so6862011wrp.10;
 Thu, 16 Jul 2020 05:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yt7eySGtavnjPzGN+i8j014hrBU1DwpMXeuXr5l5jTo=;
 b=GwJrWi7NzhlZA4yxH4OfDvTOmFPCV1YmqJH5FABJF0+CA65AsrRknug6fPfWlv83Qd
 GkI3GoROwQQP9LuFLuo2xdfVAEmPqS0thSSDl9K+vaJr5F1/sZPXuAPl0CB20fO0SFSP
 3b117ls+ZNIOevkLPFyAac3rN9DwA6g31571KA6tdQx2DCPu3wYuhFJfrf8Vny5liIV/
 yyjO4JRhTwcI4M5s7rYk0QOLELwhyggUNLk5uuPiilLonV1m60Lp08kmF4wkmYnaarQe
 Pr4BqRZ8V1+7DkIZUIec5c3kcSyfPOk+bUMv8WC9AC/9XwSpqnfIrH9R/hNhvJyu5Fzv
 D0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Yt7eySGtavnjPzGN+i8j014hrBU1DwpMXeuXr5l5jTo=;
 b=fMyP+AzvrD1EMYnZluu4nRGIOPUKMHhhPirUp3kv17mTkC8IoD7C3uwERXztBGoDXM
 XI8phSnaTVwI9Ht0GDCVZmW9rCWzEFGjaqK7CveZxDRoSJHwth/+43Tpn0vEo1hcGVFa
 qswNrR4xoZyX4Uwek1FiVtdH5zgo+dzLc5BVyw2ANpGiXth0REbUFWA37Nw3DZEnGgvs
 HQpb/WVFTtZ2WXIdrNXJXdF8866gK6gOYTROyCsX8Szh5IJWi0HpUezOhCLNNPQJZZq0
 tEqFLtXL0V1l2g0dym0YPtLhjivU93o2zDNT0lvR4p6eY3grk9umKzybhClynV8qqnVf
 EdWg==
X-Gm-Message-State: AOAM532qaSCf0sZXq83wqN4GOk7DoFa6wQ1i0Qo9LuG3Mg57G0h0kVRG
 n/bVeQwa8e+DvUPqeitSFWw=
X-Google-Smtp-Source: ABdhPJz9Mv+iabMWKJD6ocXUgDtFCLEwVYiCUdorqAbxwQkYska8o+cgZhIN7hekPn4aaRBpVKJSaA==
X-Received: by 2002:adf:8b5a:: with SMTP id v26mr4826248wra.165.1594903032286; 
 Thu, 16 Jul 2020 05:37:12 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c194sm8336673wme.8.2020.07.16.05.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 05:37:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.2 v2 2/2] block/block-backend: Let blk_attach_dev()
 provide helpful error
Date: Thu, 16 Jul 2020 14:37:04 +0200
Message-Id: <20200716123704.6557-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200716123704.6557-1-f4bug@amsat.org>
References: <20200716123704.6557-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let blk_attach_dev() take an Error* object to return helpful
information. Adapt the callers.

  $ qemu-system-arm -M n800
  qemu-system-arm: sd_init failed: cannot attach blk 'sd0' to device 'sd-card'
  blk 'sd0' is already attached by device 'omap2-mmc'
  Drive 'sd0' is already in use because it has been automatically connected to another device
  (do you need 'if=none' in the drive options?)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Rebased after 668f62ec62 ("error: Eliminate error_propagate()")
---
 include/sysemu/block-backend.h   |  2 +-
 block/block-backend.c            | 11 ++++++++++-
 hw/block/fdc.c                   |  4 +---
 hw/block/swim.c                  |  4 +---
 hw/block/xen-block.c             |  5 +++--
 hw/core/qdev-properties-system.c | 16 +++++++++-------
 hw/ide/qdev.c                    |  4 +---
 hw/scsi/scsi-disk.c              |  4 +---
 8 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 8203d7f6f9..118fbad0b4 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -113,7 +113,7 @@ BlockDeviceIoStatus blk_iostatus(const BlockBackend *blk);
 void blk_iostatus_disable(BlockBackend *blk);
 void blk_iostatus_reset(BlockBackend *blk);
 void blk_iostatus_set_err(BlockBackend *blk, int error);
-int blk_attach_dev(BlockBackend *blk, DeviceState *dev);
+int blk_attach_dev(BlockBackend *blk, DeviceState *dev, Error **errp);
 void blk_detach_dev(BlockBackend *blk, DeviceState *dev);
 DeviceState *blk_get_attached_dev(BlockBackend *blk);
 char *blk_get_attached_dev_id(BlockBackend *blk);
diff --git a/block/block-backend.c b/block/block-backend.c
index 63ff940ef9..b7be0a4619 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -884,12 +884,21 @@ void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm)
 
 /*
  * Attach device model @dev to @blk.
+ *
+ * @blk: Block backend
+ * @dev: Device to attach the block backend to
+ * @errp: pointer to NULL initialized error object
+ *
  * Return 0 on success, -EBUSY when a device model is attached already.
  */
-int blk_attach_dev(BlockBackend *blk, DeviceState *dev)
+int blk_attach_dev(BlockBackend *blk, DeviceState *dev, Error **errp)
 {
     trace_blk_attach_dev(blk_name(blk), object_get_typename(OBJECT(dev)));
     if (blk->dev) {
+        error_setg(errp, "cannot attach blk '%s' to device '%s'",
+                   blk_name(blk), object_get_typename(OBJECT(dev)));
+        error_append_hint(errp, "blk '%s' is already attached by device '%s'\n",
+                          blk_name(blk), object_get_typename(OBJECT(blk->dev)));
         return -EBUSY;
     }
 
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index e9ed3eef45..bc39244152 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -519,7 +519,6 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
     FloppyBus *bus = FLOPPY_BUS(qdev->parent_bus);
     FDrive *drive;
     bool read_only;
-    int ret;
 
     if (dev->unit == -1) {
         for (dev->unit = 0; dev->unit < MAX_FD; dev->unit++) {
@@ -545,8 +544,7 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
     if (!dev->conf.blk) {
         /* Anonymous BlockBackend for an empty drive */
         dev->conf.blk = blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
-        ret = blk_attach_dev(dev->conf.blk, qdev);
-        assert(ret == 0);
+        blk_attach_dev(dev->conf.blk, qdev, &error_abort);
 
         /* Don't take write permissions on an empty drive to allow attaching a
          * read-only node later */
diff --git a/hw/block/swim.c b/hw/block/swim.c
index 74f56e8f46..2f1ecd0bb2 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -159,7 +159,6 @@ static void swim_drive_realize(DeviceState *qdev, Error **errp)
     SWIMDrive *dev = SWIM_DRIVE(qdev);
     SWIMBus *bus = SWIM_BUS(qdev->parent_bus);
     FDrive *drive;
-    int ret;
 
     if (dev->unit == -1) {
         for (dev->unit = 0; dev->unit < SWIM_MAX_FD; dev->unit++) {
@@ -185,8 +184,7 @@ static void swim_drive_realize(DeviceState *qdev, Error **errp)
     if (!dev->conf.blk) {
         /* Anonymous BlockBackend for an empty drive */
         dev->conf.blk = blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
-        ret = blk_attach_dev(dev->conf.blk, qdev);
-        assert(ret == 0);
+        blk_attach_dev(dev->conf.blk, qdev, &error_abort);
     }
 
     if (!blkconf_blocksizes(&dev->conf, errp)) {
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 8a7a3f5452..eb99757faf 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -609,14 +609,15 @@ static void xen_cdrom_realize(XenBlockDevice *blockdev, Error **errp)
     blockdev->device_type = "cdrom";
 
     if (!conf->blk) {
+        Error *local_err = NULL;
         int rc;
 
         /* Set up an empty drive */
         conf->blk = blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
 
-        rc = blk_attach_dev(conf->blk, DEVICE(blockdev));
+        rc = blk_attach_dev(conf->blk, DEVICE(blockdev), &local_err);
         if (!rc) {
-            error_setg_errno(errp, -rc, "failed to create drive");
+            error_propagate_prepend(errp, local_err, "failed to create drive");
             return;
         }
     }
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 3e4f16fc21..e3a757b1c3 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -136,17 +136,19 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
                    object_get_typename(OBJECT(dev)), prop->name, str);
         goto fail;
     }
-    if (blk_attach_dev(blk, dev) < 0) {
+    if (blk_attach_dev(blk, dev, errp) < 0) {
         DriveInfo *dinfo = blk_legacy_dinfo(blk);
 
         if (dinfo && dinfo->type != IF_NONE) {
-            error_setg(errp, "Drive '%s' is already in use because "
-                       "it has been automatically connected to another "
-                       "device (did you need 'if=none' in the drive options?)",
-                       str);
+            error_append_hint(errp,
+                              "Drive '%s' is already in use because it has "
+                              "been automatically connected to another device\n"
+                              "(do you need 'if=none' in the drive options?)\n",
+                              str);
         } else {
-            error_setg(errp, "Drive '%s' is already in use by another device",
-                       str);
+            error_append_hint(errp,
+                              "Drive '%s' is already in use by another device",
+                              str);
         }
         goto fail;
     }
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 27ff1f7f66..9a02eb87f4 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -165,7 +165,6 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
 {
     IDEBus *bus = DO_UPCAST(IDEBus, qbus, dev->qdev.parent_bus);
     IDEState *s = bus->ifs + dev->unit;
-    int ret;
 
     if (!dev->conf.blk) {
         if (kind != IDE_CD) {
@@ -174,8 +173,7 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
         } else {
             /* Anonymous BlockBackend for an empty drive */
             dev->conf.blk = blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
-            ret = blk_attach_dev(dev->conf.blk, &dev->qdev);
-            assert(ret == 0);
+            blk_attach_dev(dev->conf.blk, &dev->qdev, &error_abort);
         }
     }
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 8ce68a9dd6..92350642c7 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2451,14 +2451,12 @@ static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
     AioContext *ctx;
-    int ret;
 
     if (!dev->conf.blk) {
         /* Anonymous BlockBackend for an empty drive. As we put it into
          * dev->conf, qdev takes care of detaching on unplug. */
         dev->conf.blk = blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
-        ret = blk_attach_dev(dev->conf.blk, &dev->qdev);
-        assert(ret == 0);
+        blk_attach_dev(dev->conf.blk, &dev->qdev, &error_abort);
     }
 
     ctx = blk_get_aio_context(dev->conf.blk);
-- 
2.21.3


