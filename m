Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D99C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229B7249F4
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ8WpLxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229B7249F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47446 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY40t-0002hQ-9i
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 03:37:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hY3z1-0001Ns-ES
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hY3z0-0004wQ-3V
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:47 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hY3yz-0004tR-TY
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:46 -0400
Received: by mail-pg1-x541.google.com with SMTP id w34so9815477pga.12
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=BlmwWQSrvfnPLK3snMGwGG+KcVuIss3R/7Aben6MrQw=;
	b=VJ8WpLxq43rtFJQ9KMSJSFwSHLmfhxYJ4phcnhQLO6VuOcNa81TtNGRMs0fdFpCz4S
	yMfq4G9kHxo9Ec2eTESm5PTfnDoK6OUxen1oNS73U0n91eYHkJ0QXHj52gsZqrpzfahN
	/RmFv5nfN+i+cyKFfF1bJbAqD50f+QSF1inhSLMz5PjFFM4VrqQkhbxh3drXMEiGTQ2Q
	tXu4b6yN4NGx+yLNF3qfN7ATT/xtHSzHTp08k9D2e2PiXZBvteBuZXDk9NA0eByrlB03
	Usi2BvVjXKSxhtbwixUXfgZhz8wOAQyVXYHUYT01uiMz1HVWDIaa01cdcmmd2+CeVYuw
	7S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=BlmwWQSrvfnPLK3snMGwGG+KcVuIss3R/7Aben6MrQw=;
	b=Fm+KzA9QW4PNGmNlfpofHLQyGEwLDm6ue3MgTY/vJENnfGCmIOQqveHGCvu3JWTdJX
	mvcq6808w3mxT1RxVlfV7jBunKn+o7Eudvrm/sbPCJNNtVwnxdETy/qyGg6hWOIUINSA
	uUOww/PQZ+8MsO2LvcfX7AjfiFsUsEnvIelgl+q1u1NK4vUdksRuHRbGKd1QrQDa96ol
	8kmGd9dQmHLExZX90+H3cma8oyC157PcLabkIOOFu0b+0bcqlEXnyKSlajVA6hSqaikL
	8/YxB4PPFG6LNw5plmzQgD7s5d5BIU1wH5tC0+qE7MNg/HnVbkTbNg+B7rNcvKz8EAr6
	cm3Q==
X-Gm-Message-State: APjAAAXcy6d1Hy0UIz3fhD9jYTTxVfi9ZszkNF1zUIVdFgQYAm3zGRUe
	CpoY+CjOxQpa4XCB7BQEpIQqgqm+
X-Google-Smtp-Source: APXvYqyx2Cn2oWru565C85iqVbPdB5kTgKZHSX0YYGuquvXmTkPAhf81/XoH66oZlUvYcmoIecANXA==
X-Received: by 2002:a17:90a:6348:: with SMTP id
	v8mr35026298pjs.34.1559633744907; 
	Tue, 04 Jun 2019 00:35:44 -0700 (PDT)
Received: from localhost ([116.247.112.152])
	by smtp.gmail.com with ESMTPSA id m20sm995215pjn.16.2019.06.04.00.35.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 04 Jun 2019 00:35:44 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org
Date: Tue,  4 Jun 2019 15:34:59 +0800
Message-Id: <20190604073459.15651-6-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604073459.15651-1-xieyongji@baidu.com>
References: <20190604073459.15651-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 5/5] virtio: add "use-started" property
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
Cc: Xie Yongji <xieyongji@baidu.com>, dgilbert@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

In order to avoid migration issues, we introduce a "use-started"
property to the base virtio device to indicate whether use
"started" flag or not. This property will be true by default and
set to false when machine type <= 4.0.1.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
---
 hw/block/vhost-user-blk.c  |  4 ++--
 hw/core/machine.c          |  4 +++-
 hw/virtio/virtio.c         | 21 ++++++++-------------
 include/hw/virtio/virtio.h | 21 +++++++++++++++++++++
 4 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9cb61336a6..85bc4017e7 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -191,7 +191,7 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
 static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
-    bool should_start = vdev->started;
+    bool should_start = virtio_device_started(vdev, status);
     int ret;
 
     if (!vdev->vm_running) {
@@ -317,7 +317,7 @@ static int vhost_user_blk_connect(DeviceState *dev)
     }
 
     /* restore vhost state */
-    if (vdev->started) {
+    if (virtio_device_started(vdev, vdev->status)) {
         ret = vhost_user_blk_start(vdev);
         if (ret < 0) {
             error_report("vhost-user-blk: vhost start failed: %s",
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f1a0f45f9c..133c113ebf 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -24,7 +24,9 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 
-GlobalProperty hw_compat_4_0_1[] = {};
+GlobalProperty hw_compat_4_0_1[] = {
+    { "virtio-device", "use-started", "false" },
+};
 const size_t hw_compat_4_0_1_len = G_N_ELEMENTS(hw_compat_4_0_1);
 
 GlobalProperty hw_compat_4_0[] = {};
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3960619bd4..9af2e339af 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1165,10 +1165,7 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
 
     if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) !=
         (val & VIRTIO_CONFIG_S_DRIVER_OK)) {
-        vdev->started = val & VIRTIO_CONFIG_S_DRIVER_OK;
-        if (unlikely(vdev->start_on_kick && vdev->started)) {
-            vdev->start_on_kick = false;
-        }
+        virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
     }
 
     if (k->set_status) {
@@ -1539,8 +1536,7 @@ static bool virtio_queue_notify_aio_vq(VirtQueue *vq)
         ret = vq->handle_aio_output(vdev, vq);
 
         if (unlikely(vdev->start_on_kick)) {
-            vdev->started = true;
-            vdev->start_on_kick = false;
+            virtio_set_started(vdev, true);
         }
     }
 
@@ -1560,8 +1556,7 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
         vq->handle_output(vdev, vq);
 
         if (unlikely(vdev->start_on_kick)) {
-            vdev->started = true;
-            vdev->start_on_kick = false;
+            virtio_set_started(vdev, true);
         }
     }
 }
@@ -1581,8 +1576,7 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
         vq->handle_output(vdev, vq);
 
         if (unlikely(vdev->start_on_kick)) {
-            vdev->started = true;
-            vdev->start_on_kick = false;
+            virtio_set_started(vdev, true);
         }
     }
 }
@@ -2083,7 +2077,7 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
             }
         }
 
-        if (!vdev->started &&
+        if (!virtio_device_started(vdev, vdev->status) &&
             !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
             vdev->start_on_kick = true;
         }
@@ -2238,7 +2232,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         }
     }
 
-    if (!vdev->started &&
+    if (!virtio_device_started(vdev, vdev->status) &&
         !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         vdev->start_on_kick = true;
     }
@@ -2306,7 +2300,7 @@ static void virtio_vmstate_change(void *opaque, int running, RunState state)
     VirtIODevice *vdev = opaque;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    bool backend_run = running && vdev->started;
+    bool backend_run = running && virtio_device_started(vdev, vdev->status);
     vdev->vm_running = running;
 
     if (backend_run) {
@@ -2683,6 +2677,7 @@ static void virtio_device_instance_finalize(Object *obj)
 
 static Property virtio_properties[] = {
     DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
+    DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 303242b3c2..b189788cb2 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -105,6 +105,7 @@ struct VirtIODevice
     uint16_t device_id;
     bool vm_running;
     bool broken; /* device in invalid state, needs reset */
+    bool use_started;
     bool started;
     bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
     VMChangeStateEntry *vmstate;
@@ -351,4 +352,24 @@ static inline bool virtio_is_big_endian(VirtIODevice *vdev)
     /* Devices conforming to VIRTIO 1.0 or later are always LE. */
     return false;
 }
+
+static inline bool virtio_device_started(VirtIODevice *vdev, uint8_t status)
+{
+    if (vdev->use_started) {
+        return vdev->started;
+    }
+
+    return status & VIRTIO_CONFIG_S_DRIVER_OK;
+}
+
+static inline void virtio_set_started(VirtIODevice *vdev, bool started)
+{
+    if (started) {
+        vdev->start_on_kick = false;
+    }
+
+    if (vdev->use_started) {
+        vdev->started = started;
+    }
+}
 #endif
-- 
2.17.1


