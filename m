Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57119C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFDC20863
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFDC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43563 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrgo-00046X-QO
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:27:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQf-000739-QN
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQd-0007yq-Rc
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrQd-0007yg-Mq
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id c14so9942423qke.3
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=tTBRannrdM9DkulDt21RsSxYNxb2e+uEhsKDTQkk1LY=;
	b=b4ELpUXtQY3cd01pPaCWiiMNC98B/L/mlr5urXxA3zOQpZm+GLNra9nGLhqLhXP7tg
	d77gYOZE2/dsxz9TuESleijMixWFpQ6MtMBb1bIWA8gpCj4L7x8aTCUyPSr6356F3wAG
	fp2GWdPd3k9EmmgluGiJjjRYs41m6CCeizb8ZSG07cpPbul1KwLre2Ffnm029/3Th3UQ
	3drH4uybO6XMrllylm+639/2wgak3KzDb/kexg4zBvtbcFbTU0RXEqZnEOYc4i9/CNgA
	dAf2yrfWvu2qDPQedicsM38VZ7pmMwT/NJvVaYWktaf4Hf8AJMTqH3CQ5PJ42vzKyrwZ
	CndQ==
X-Gm-Message-State: APjAAAW/nRDCp+I4M9n+V6Idzak+6qej3J6/Hsryb4TszBhvv5vQCFoT
	EmeXd9ms3BFfZ5NQhCxuwez7EFuwuu8=
X-Google-Smtp-Source: APXvYqyM0/5L8FmsFwQSvku73slhcatyH0vkm4dhnl7vyKjZvKh5a8iXHlirjKQPrCS0KyrREZyyLw==
X-Received: by 2002:a37:495:: with SMTP id 143mr60421345qke.106.1558393846837; 
	Mon, 20 May 2019 16:10:46 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	o63sm9171293qkf.41.2019.05.20.16.10.45
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:10:46 -0700 (PDT)
Date: Mon, 20 May 2019 19:10:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190320112646.3712-7-xieyongji@baidu.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.194
Subject: [Qemu-devel] [PULL v2 09/36] vhost-user-blk: Add support to
 reconnect backend
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
Message-ID: <20190520231045.W96pVv0LezR1-eLyIPn70p0rHpOQABEL3Hi-oLkJgVY@z>

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


