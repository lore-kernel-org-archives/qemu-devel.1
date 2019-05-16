Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E496C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060EE20848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060EE20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53841 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFSk-00065a-5A
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:26:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFL2-00082p-5z
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFKy-0001CG-Bp
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFKw-0001BB-Qx
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id c14so2087280qke.3
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=MuXZh2Zl/Nzl0zuzr+YjoWM5yncHsvEMueXKMI+UDWA=;
	b=SZsuL7HPH4M8O1qtZQVIxDrel5/4Dyixf37dLrl+Ol5F/HDsgmcRN/Q1B9UUIC4uyz
	OHuywCwNsV893MGxWu7jkbHNgXQ0kVlx31NBZ6Y6nEl1KCnVwoax3/MEswnciK86b2tv
	xGtJ5mtcPLnZ8mXk6m3i4Hn2RcCguJuNJEgXDMXB/pc7ttA0XmlZ3JQiBvCbXX9nulx7
	aarK8qDnr3sQJ0GvI1TRbVyHLPC/0V/RUqixb/UCJL4bGBdPZOI38IwuJexFVMYo2FS9
	6HjCwCOgm0+yVde6JVdMI9VYP8X2IQhJcyP9z3iNBomL2LBYxyXgoBbkpYEfuDc1JfS9
	JuRg==
X-Gm-Message-State: APjAAAXXXrNj2E/WEguOhxoaB5XMVYgQr8Yqjaz5OAVjvbGifoI3GYbV
	+YgbF1xPoMCjDRV2yFv+zV/qPJAtXa4=
X-Google-Smtp-Source: APXvYqy600plV1cjGcYcBbirNsmRrRu65bTdgI7Scfj4PtOFQrioIwy1SU5AyQzn4gGkmjJQa5bf/g==
X-Received: by 2002:a37:a705:: with SMTP id q5mr37964559qke.123.1558009093959; 
	Thu, 16 May 2019 05:18:13 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id u9sm2236847qtg.91.2019.05.16.05.18.11
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:18:13 -0700 (PDT)
Date: Thu, 16 May 2019 08:18:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190320112646.3712-2-xieyongji@baidu.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.195
Subject: [Qemu-devel] [PULL 04/37] virtio: Introduce started flag to
 VirtioDevice
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Xie Yongji <xieyongji@baidu.com>,
	Zhang Yu <zhangyu31@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

The virtio 1.0 transitional devices support driver uses the device
before setting the DRIVER_OK status bit. So we introduce a started
flag to indicate whether driver has started the device or not.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Message-Id: <20190320112646.3712-2-xieyongji@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h |  2 ++
 hw/virtio/virtio.c         | 52 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index ce9516236a..fea08bcc44 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -105,6 +105,8 @@ struct VirtIODevice
     uint16_t device_id;
     bool vm_running;
     bool broken; /* device in invalid state, needs reset */
+    bool started;
+    bool start_on_kick; /* virtio 1.0 transitional devices support that */
     VMChangeStateEntry *vmstate;
     char *bus_name;
     uint8_t device_endian;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2626a895cb..af7b59b4ae 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1162,10 +1162,16 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
             }
         }
     }
+    vdev->started = val & VIRTIO_CONFIG_S_DRIVER_OK;
+    if (unlikely(vdev->start_on_kick && vdev->started)) {
+        vdev->start_on_kick = false;
+    }
+
     if (k->set_status) {
         k->set_status(vdev, val);
     }
     vdev->status = val;
+
     return 0;
 }
 
@@ -1208,6 +1214,9 @@ void virtio_reset(void *opaque)
         k->reset(vdev);
     }
 
+    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
+                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
+    vdev->started = false;
     vdev->broken = false;
     vdev->guest_features = 0;
     vdev->queue_sel = 0;
@@ -1518,14 +1527,21 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
 
 static bool virtio_queue_notify_aio_vq(VirtQueue *vq)
 {
+    bool ret = false;
+
     if (vq->vring.desc && vq->handle_aio_output) {
         VirtIODevice *vdev = vq->vdev;
 
         trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
-        return vq->handle_aio_output(vdev, vq);
+        ret = vq->handle_aio_output(vdev, vq);
+
+        if (unlikely(vdev->start_on_kick)) {
+            vdev->started = true;
+            vdev->start_on_kick = false;
+        }
     }
 
-    return false;
+    return ret;
 }
 
 static void virtio_queue_notify_vq(VirtQueue *vq)
@@ -1539,6 +1555,11 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
 
         trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
         vq->handle_output(vdev, vq);
+
+        if (unlikely(vdev->start_on_kick)) {
+            vdev->started = true;
+            vdev->start_on_kick = false;
+        }
     }
 }
 
@@ -1556,6 +1577,11 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
     } else if (vq->handle_output) {
         vq->handle_output(vdev, vq);
     }
+
+    if (unlikely(vdev->start_on_kick)) {
+        vdev->started = true;
+        vdev->start_on_kick = false;
+    }
 }
 
 uint16_t virtio_queue_vector(VirtIODevice *vdev, int n)
@@ -1770,6 +1796,13 @@ static bool virtio_broken_needed(void *opaque)
     return vdev->broken;
 }
 
+static bool virtio_started_needed(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+
+    return vdev->started;
+}
+
 static const VMStateDescription vmstate_virtqueue = {
     .name = "virtqueue_state",
     .version_id = 1,
@@ -1898,6 +1931,17 @@ static const VMStateDescription vmstate_virtio_broken = {
     }
 };
 
+static const VMStateDescription vmstate_virtio_started = {
+    .name = "virtio/started",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_started_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(started, VirtIODevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio = {
     .name = "virtio",
     .version_id = 1,
@@ -1913,6 +1957,7 @@ static const VMStateDescription vmstate_virtio = {
         &vmstate_virtio_ringsize,
         &vmstate_virtio_broken,
         &vmstate_virtio_extra_state,
+        &vmstate_virtio_started,
         NULL
     }
 };
@@ -2286,6 +2331,9 @@ void virtio_init(VirtIODevice *vdev, const char *name,
             g_malloc0(sizeof(*vdev->vector_queues) * nvectors);
     }
 
+    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
+                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
+    vdev->started = false;
     vdev->device_id = device_id;
     vdev->status = 0;
     atomic_set(&vdev->isr, 0);
-- 
MST


