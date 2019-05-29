Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BA8C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FBD208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oS4L5qKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FBD208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48967 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVt0n-0006vV-0m
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:28:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVsjt-0000lv-Rg
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVsjs-0006Vh-Mw
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:11:09 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hVsjs-0006VU-HT
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:11:08 -0400
Received: by mail-pf1-x443.google.com with SMTP id a23so1020499pff.4
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 00:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=wRsGG+CGI58wbB7Mu7nQkCFNg2G6+zgNOiTS5HlNUlA=;
	b=oS4L5qKNQS+ZvLE5YFnPSgWq1B9nlIahoTrgCkNKl6aLEN+fsxF+wztid3inPjecMl
	jZ3DR2FKtD0nqnTFX4Kt7kgbBaawIkJ7sD3N2tYneHvotojaZBSf9H0dghyVDyDAbDbE
	+JKYlHWGqLAvMStwxRMSdG73kNr9F91H/hw9LIpS7EjvHcL0j5OPw7jRZFHR/v/iRqjz
	D8FBMbWGtKUXEjJqCxekpti3CxoplQOOomKga0tytLaAeqUkjs5e12sOEBoBU0/7vTaR
	CgNDaooWZlayngwSZRuDouvaFzEFZFVn9CzAFuPKGObKPV2b0Q76rSjG+b604BvoK1Gv
	DrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=wRsGG+CGI58wbB7Mu7nQkCFNg2G6+zgNOiTS5HlNUlA=;
	b=RTVxFr8UXGU+kAoHOYOkWEDhFjGJG60S7P2kFGWY3tpwPWrhM3cjUaB6dVacPfyr9H
	jztXIVf85/T+j5LEXg6lMe4X4gTUxjrFeWd/OeLd/zLJYEtiCQvQCotpULn38/J+FrtG
	ADUozO3w3vYELUK/334/nYT/V9MX8FxQPNmaaJ0DqFD/xySyWLQS8zcYOaWawuBTgfUq
	lZPSRzijeH3UGVRiZ2DxwNSr3DDQUEr0P5PhjW04JwJff3AIdNtrJzAJSWcJd04ZxtJV
	jQuuqOe6CzCRp2/8kXM2XAqRTrClBI5adF1Bbz8fMU3RwC4Vfs2rSfELhzvGQ8fZMMCt
	M0Bw==
X-Gm-Message-State: APjAAAWlGT93Rk5+Q8F8/ezfcgzretKYtEX63jNmNZEK65X0xC44bbHO
	ubNs3o1jP7XDfTIRF+r/F5Q=
X-Google-Smtp-Source: APXvYqxkMNjESQg57MaxRwMsrqBHV13dx6I98in6HvbqVaR4y7VLSFJYCnMk5lZ238uXg/sd7/Ebsg==
X-Received: by 2002:a63:8449:: with SMTP id k70mr19826829pgd.208.1559113867619;
	Wed, 29 May 2019 00:11:07 -0700 (PDT)
Received: from localhost ([116.247.112.152]) by smtp.gmail.com with ESMTPSA id
	5sm16693672pfh.109.2019.05.29.00.11.06
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 29 May 2019 00:11:07 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org,
	dgilbert@redhat.com
Date: Wed, 29 May 2019 15:09:55 +0800
Message-Id: <20190529070955.25565-6-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529070955.25565-1-xieyongji@baidu.com>
References: <20190529070955.25565-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 5/5] virtio: add "use-started" property
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Xie Yongji <xieyongji@baidu.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

In order to avoid migration issues, we introduce a "use-started"
property to the base virtio device to indicate whether "started"
and "start_on_kick" flag could be used. This property will be
true by default and set to false when machine type <= 4.0.

Suggested-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Xie Yongji <xieyongji@baidu.com>
---
 hw/block/vhost-user-blk.c  |  8 ++++++--
 hw/core/machine.c          |  4 +++-
 hw/virtio/virtio.c         |  7 ++++---
 include/hw/virtio/virtio.h | 10 ++++++++++
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9cb61336a6..520c5d3d4b 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -191,9 +191,13 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
 static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
-    bool should_start = vdev->started;
+    bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
     int ret;
 
+    if (virtio_device_started(vdev)) {
+        should_start = true;
+    }
+
     if (!vdev->vm_running) {
         should_start = false;
     }
@@ -317,7 +321,7 @@ static int vhost_user_blk_connect(DeviceState *dev)
     }
 
     /* restore vhost state */
-    if (vdev->started) {
+    if (virtio_device_started(vdev)) {
         ret = vhost_user_blk_start(vdev);
         if (ret < 0) {
             error_report("vhost-user-blk: vhost start failed: %s",
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 934c1bcceb..1730d28c1b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -24,7 +24,9 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 
-GlobalProperty hw_compat_4_0[] = {};
+GlobalProperty hw_compat_4_0[] = {
+    { "virtio-device", "use-started", "false" },
+};
 const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
 
 GlobalProperty hw_compat_3_1[] = {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9e17293d46..4c05a9efe3 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1803,14 +1803,14 @@ static bool virtio_started_needed(void *opaque)
 {
     VirtIODevice *vdev = opaque;
 
-    return vdev->started;
+    return vdev->started && vdev->use_started;
 }
 
 static bool virtio_start_on_kick_needed(void *opaque)
 {
     VirtIODevice *vdev = opaque;
 
-    return vdev->start_on_kick;
+    return vdev->start_on_kick && vdev->use_started;
 }
 
 static const VMStateDescription vmstate_virtqueue = {
@@ -2320,7 +2320,7 @@ static void virtio_vmstate_change(void *opaque, int running, RunState state)
     VirtIODevice *vdev = opaque;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    bool backend_run = running && vdev->started;
+    bool backend_run = running && virtio_device_started(vdev);
     vdev->vm_running = running;
 
     if (backend_run) {
@@ -2698,6 +2698,7 @@ static void virtio_device_instance_finalize(Object *obj)
 
 static Property virtio_properties[] = {
     DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
+    DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 27c0efc3d0..ba4dbd7480 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -105,6 +105,7 @@ struct VirtIODevice
     uint16_t device_id;
     bool vm_running;
     bool broken; /* device in invalid state, needs reset */
+    bool use_started;
     bool started;
     bool start_on_kick; /* virtio 1.0 transitional devices support that */
     VMChangeStateEntry *vmstate;
@@ -351,4 +352,13 @@ static inline bool virtio_is_big_endian(VirtIODevice *vdev)
     /* Devices conforming to VIRTIO 1.0 or later are always LE. */
     return false;
 }
+
+static inline bool virtio_device_started(VirtIODevice *vdev)
+{
+    if (vdev->use_started) {
+        return vdev->started;
+    }
+
+    return vdev->status & VIRTIO_CONFIG_S_DRIVER_OK;
+}
 #endif
-- 
2.17.1


