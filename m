Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43473C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2B220848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2B220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFSp-0006EW-6x
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:26:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFLY-0008Tn-Qp
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFLV-0001YN-0U
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFLU-0001Xp-IS
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id m32so3611569qtf.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=tTBRannrdM9DkulDt21RsSxYNxb2e+uEhsKDTQkk1LY=;
	b=SsjW5bwtiOSzgw5wlPAUTgoVmr6VesBEdH70GWMjzhx44ERUeY0bWbaJcw1830jn+y
	Zp2sImsPXTSDL+QEbJk+WsRaYRfpt5TRCk0RFoAXoNDRQj8Mo/tAuLOh84pjOnArJkyG
	+f9JmFkH+KkJKD5UDkaYjCdaDMlMu6jqqrgUTFsn2fulq6A9gsonRGzzNPdKD5enUBAR
	JH7oAtSpz8otlnrGQj6KcK+kpAVUILYZabRIvKG7G54ClzBAtXqahRvJMZWSzTIZlBud
	6cro1we5jdg7qJI7HHNlzddhNoLiKA7PZJeLy2zOSkGU1Thm+W7TN7oyDbf8b253R/1V
	QSaw==
X-Gm-Message-State: APjAAAWOfSzv2kIxgtHvstlA/GKfsWuGx3isYqdIhaTmMtHHBxXBn3T6
	gFCnqsSMsnuI/xtATVBr7AXUDZXiI+o=
X-Google-Smtp-Source: APXvYqyzyv+WwODhysJoiAi1KilkXrFpXZB/h5hSDGAFR7fNWd/Iwzie0UQSBvxaMHbQ6fAQJ0Kisg==
X-Received: by 2002:a0c:b656:: with SMTP id q22mr38717999qvf.205.1558009127280;
	Thu, 16 May 2019 05:18:47 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	l185sm3034687qkf.63.2019.05.16.05.18.45
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:18:46 -0700 (PDT)
Date: Thu, 16 May 2019 08:18:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190320112646.3712-7-xieyongji@baidu.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
Subject: [Qemu-devel] [PULL 09/37] vhost-user-blk: Add support to reconnect
 backend
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Xie Yongji <xieyongji@baidu.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>, Zhang Yu <zhangyu31@baidu.com>,
	Ni Xun <nixun@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

Since we now support the message VHOST_USER_GET_INFLIGHT_FD
and VHOST_USER_SET_INFLIGHT_FD. The backend is able to restart
safely because it can track inflight I/O in shared memory.
This patch allows qemu to reconnect the backend after
connection closed.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Ni Xun <nixun@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Message-Id: <20190320112646.3712-7-xieyongji@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user-blk.h |   3 +
 hw/block/vhost-user-blk.c          | 159 ++++++++++++++++++++++++-----
 2 files changed, 139 insertions(+), 23 deletions(-)

diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 68634bee61..51457fb857 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -38,6 +38,9 @@ typedef struct VHostUserBlk {
     struct vhost_dev dev;
     struct vhost_inflight *inflight;
     VhostUserState vhost_user;
+    struct vhost_virtqueue *vqs;
+    guint watch;
+    bool connected;
 } VHostUserBlk;
 
 #endif
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 6802c19d65..9cb61336a6 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -192,17 +192,27 @@ static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     bool should_start = vdev->started;
+    int ret;
 
     if (!vdev->vm_running) {
         should_start = false;
     }
 
+    if (!s->connected) {
+        return;
+    }
+
     if (s->dev.started == should_start) {
         return;
     }
 
     if (should_start) {
-        vhost_user_blk_start(vdev);
+        ret = vhost_user_blk_start(vdev);
+        if (ret < 0) {
+            error_report("vhost-user-blk: vhost start failed: %s",
+                         strerror(-ret));
+            qemu_chr_fe_disconnect(&s->chardev);
+        }
     } else {
         vhost_user_blk_stop(vdev);
     }
@@ -238,12 +248,16 @@ static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
 static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
-    int i;
+    int i, ret;
 
     if (!vdev->start_on_kick) {
         return;
     }
 
+    if (!s->connected) {
+        return;
+    }
+
     if (s->dev.started) {
         return;
     }
@@ -251,7 +265,13 @@ static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
     /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
      * vhost here instead of waiting for .set_status().
      */
-    vhost_user_blk_start(vdev);
+    ret = vhost_user_blk_start(vdev);
+    if (ret < 0) {
+        error_report("vhost-user-blk: vhost start failed: %s",
+                     strerror(-ret));
+        qemu_chr_fe_disconnect(&s->chardev);
+        return;
+    }
 
     /* Kick right away to begin processing requests already in vring */
     for (i = 0; i < s->dev.nvqs; i++) {
@@ -271,11 +291,103 @@ static void vhost_user_blk_reset(VirtIODevice *vdev)
     vhost_dev_free_inflight(s->inflight);
 }
 
+static int vhost_user_blk_connect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    int ret = 0;
+
+    if (s->connected) {
+        return 0;
+    }
+    s->connected = true;
+
+    s->dev.nvqs = s->num_queues;
+    s->dev.vqs = s->vqs;
+    s->dev.vq_index = 0;
+    s->dev.backend_features = 0;
+
+    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
+
+    ret = vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0);
+    if (ret < 0) {
+        error_report("vhost-user-blk: vhost initialization failed: %s",
+                     strerror(-ret));
+        return ret;
+    }
+
+    /* restore vhost state */
+    if (vdev->started) {
+        ret = vhost_user_blk_start(vdev);
+        if (ret < 0) {
+            error_report("vhost-user-blk: vhost start failed: %s",
+                         strerror(-ret));
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+static void vhost_user_blk_disconnect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    if (!s->connected) {
+        return;
+    }
+    s->connected = false;
+
+    if (s->dev.started) {
+        vhost_user_blk_stop(vdev);
+    }
+
+    vhost_dev_cleanup(&s->dev);
+}
+
+static gboolean vhost_user_blk_watch(GIOChannel *chan, GIOCondition cond,
+                                     void *opaque)
+{
+    DeviceState *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    qemu_chr_fe_disconnect(&s->chardev);
+
+    return true;
+}
+
+static void vhost_user_blk_event(void *opaque, int event)
+{
+    DeviceState *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        if (vhost_user_blk_connect(dev) < 0) {
+            qemu_chr_fe_disconnect(&s->chardev);
+            return;
+        }
+        s->watch = qemu_chr_fe_add_watch(&s->chardev, G_IO_HUP,
+                                         vhost_user_blk_watch, dev);
+        break;
+    case CHR_EVENT_CLOSED:
+        vhost_user_blk_disconnect(dev);
+        if (s->watch) {
+            g_source_remove(s->watch);
+            s->watch = 0;
+        }
+        break;
+    }
+}
+
 static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
-    struct vhost_virtqueue *vqs = NULL;
+    Error *err = NULL;
     int i, ret;
 
     if (!s->chardev.chr) {
@@ -306,27 +418,29 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     }
 
     s->inflight = g_new0(struct vhost_inflight, 1);
+    s->vqs = g_new(struct vhost_virtqueue, s->num_queues);
+    s->watch = 0;
+    s->connected = false;
 
-    s->dev.nvqs = s->num_queues;
-    s->dev.vqs = g_new(struct vhost_virtqueue, s->dev.nvqs);
-    s->dev.vq_index = 0;
-    s->dev.backend_features = 0;
-    vqs = s->dev.vqs;
+    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, vhost_user_blk_event,
+                             NULL, (void *)dev, NULL, true);
 
-    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
-
-    ret = vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0);
-    if (ret < 0) {
-        error_setg(errp, "vhost-user-blk: vhost initialization failed: %s",
-                   strerror(-ret));
+reconnect:
+    if (qemu_chr_fe_wait_connected(&s->chardev, &err) < 0) {
+        error_report_err(err);
         goto virtio_err;
     }
 
+    /* check whether vhost_user_blk_connect() failed or not */
+    if (!s->connected) {
+        goto reconnect;
+    }
+
     ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
-                              sizeof(struct virtio_blk_config));
+                               sizeof(struct virtio_blk_config));
     if (ret < 0) {
-        error_setg(errp, "vhost-user-blk: get block config failed");
-        goto vhost_err;
+        error_report("vhost-user-blk: get block config failed");
+        goto reconnect;
     }
 
     if (s->blkcfg.num_queues != s->num_queues) {
@@ -335,10 +449,8 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
 
     return;
 
-vhost_err:
-    vhost_dev_cleanup(&s->dev);
 virtio_err:
-    g_free(vqs);
+    g_free(s->vqs);
     g_free(s->inflight);
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
@@ -348,12 +460,13 @@ static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBlk *s = VHOST_USER_BLK(dev);
-    struct vhost_virtqueue *vqs = s->dev.vqs;
 
     virtio_set_status(vdev, 0);
+    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, NULL,
+                             NULL, NULL, NULL, false);
     vhost_dev_cleanup(&s->dev);
     vhost_dev_free_inflight(s->inflight);
-    g_free(vqs);
+    g_free(s->vqs);
     g_free(s->inflight);
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
-- 
MST


