Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51224C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2781A20663
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2781A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKwJ-00086w-Bq
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hiKO6-0007E2-4i
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hiKO4-0000tV-6y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:08:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>)
 id 1hiKNz-0000pi-FW; Tue, 02 Jul 2019 11:07:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E88C80F79;
 Tue,  2 Jul 2019 15:07:58 +0000 (UTC)
Received: from redhat.com (ovpn-124-209.rdu2.redhat.com [10.10.124.209])
 by smtp.corp.redhat.com (Postfix) with SMTP id 059F66F947;
 Tue,  2 Jul 2019 15:07:54 +0000 (UTC)
Date: Tue, 2 Jul 2019 11:07:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190626023130.31315-2-xieyongji@baidu.com>
References: <20190702150606.24851-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190702150606.24851-1-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 02 Jul 2019 15:07:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/22] virtio: add "use-started" property
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
 Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190702150753.uUpkQmrXYMYlh6xWLUi4ueDLySBymUFet0p3GjicqNs@z>

From: Xie Yongji <xieyongji@baidu.com>

In order to avoid migration issues, we introduce a "use-started"
property to the base virtio device to indicate whether use
"started" flag or not. This property will be true by default and
set to false when machine type <= 4.0.

Suggested-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Message-Id: <20190626023130.31315-2-xieyongji@baidu.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h | 21 +++++++++++++++++++++
 hw/block/vhost-user-blk.c  |  4 ++--
 hw/core/machine.c          |  1 +
 hw/virtio/virtio.c         | 18 +++++++-----------
 4 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 27c0efc3d0..15d5366939 100644
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
index ea5a01aa49..ea84bd6788 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -30,6 +30,7 @@ GlobalProperty hw_compat_4_0[] = {
     { "bochs-display",  "edid", "false" },
     { "virtio-vga",     "edid", "false" },
     { "virtio-gpu-pci", "edid", "false" },
+    { "virtio-device", "use-started", "false" },
 };
 const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e1e90fcfd6..c9a6ca04b8 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1162,10 +1162,8 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
             }
         }
     }
-    vdev->started = val & VIRTIO_CONFIG_S_DRIVER_OK;
-    if (unlikely(vdev->start_on_kick && vdev->started)) {
-        vdev->start_on_kick = false;
-    }
+
+    virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
 
     if (k->set_status) {
         k->set_status(vdev, val);
@@ -1536,8 +1534,7 @@ static bool virtio_queue_notify_aio_vq(VirtQueue *vq)
         ret = vq->handle_aio_output(vdev, vq);
 
         if (unlikely(vdev->start_on_kick)) {
-            vdev->started = true;
-            vdev->start_on_kick = false;
+            virtio_set_started(vdev, true);
         }
     }
 
@@ -1557,8 +1554,7 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
         vq->handle_output(vdev, vq);
 
         if (unlikely(vdev->start_on_kick)) {
-            vdev->started = true;
-            vdev->start_on_kick = false;
+            virtio_set_started(vdev, true);
         }
     }
 }
@@ -1579,8 +1575,7 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
     }
 
     if (unlikely(vdev->start_on_kick)) {
-        vdev->started = true;
-        vdev->start_on_kick = false;
+        virtio_set_started(vdev, true);
     }
 }
 
@@ -2291,7 +2286,7 @@ static void virtio_vmstate_change(void *opaque, int running, RunState state)
     VirtIODevice *vdev = opaque;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    bool backend_run = running && vdev->started;
+    bool backend_run = running && virtio_device_started(vdev, vdev->status);
     vdev->vm_running = running;
 
     if (backend_run) {
@@ -2669,6 +2664,7 @@ static void virtio_device_instance_finalize(Object *obj)
 
 static Property virtio_properties[] = {
     DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
+    DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST


