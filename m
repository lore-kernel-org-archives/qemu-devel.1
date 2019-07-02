Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172EBC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41562146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41562146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiL6C-0001lp-63
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58736)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hiKOB-0007Gb-WC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hiKO9-0000xQ-Rj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:08:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hiKO7-0000v6-VG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:08:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5317130872CF;
 Tue,  2 Jul 2019 15:08:06 +0000 (UTC)
Received: from redhat.com (ovpn-124-209.rdu2.redhat.com [10.10.124.209])
 by smtp.corp.redhat.com (Postfix) with SMTP id D1D0C5D9D6;
 Tue,  2 Jul 2019 15:08:04 +0000 (UTC)
Date: Tue, 2 Jul 2019 11:08:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190626023130.31315-4-xieyongji@baidu.com>
References: <20190702150606.24851-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190702150606.24851-1-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 02 Jul 2019 15:08:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/22] virtio: Set "start_on_kick" on
 virtio_set_features()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Xie Yongji <xieyongji@baidu.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190702150803.bDpl24GPw50brT6XKuLBaxNsjDxezSZBp7JVNG7hVcA@z>

From: Xie Yongji <xieyongji@baidu.com>

The guest feature is not set correctly on virtio_reset() and
virtio_init(). So we should not use it to set "start_on_kick" at that
point. This patch set "start_on_kick" on virtio_set_features() instead.

Fixes: badaf79cfdbd3 ("virtio: Introduce started flag to VirtioDevice")
Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20190626023130.31315-4-xieyongji@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f7504d1395..5fd25d98a9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1212,7 +1212,7 @@ void virtio_reset(void *opaque)
         k->reset(vdev);
     }
 
-    vdev->start_on_kick = !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
+    vdev->start_on_kick = false;
     vdev->started = false;
     vdev->broken = false;
     vdev->guest_features = 0;
@@ -2063,14 +2063,21 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
         return -EINVAL;
     }
     ret = virtio_set_features_nocheck(vdev, val);
-    if (!ret && virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
-        /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
-        int i;
-        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
-            if (vdev->vq[i].vring.num != 0) {
-                virtio_init_region_cache(vdev, i);
+    if (!ret) {
+        if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
+            /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
+            int i;
+            for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+                if (vdev->vq[i].vring.num != 0) {
+                    virtio_init_region_cache(vdev, i);
+                }
             }
         }
+
+        if (!virtio_device_started(vdev, vdev->status) &&
+            !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+            vdev->start_on_kick = true;
+        }
     }
     return ret;
 }
@@ -2222,6 +2229,11 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         }
     }
 
+    if (!virtio_device_started(vdev, vdev->status) &&
+        !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        vdev->start_on_kick = true;
+    }
+
     rcu_read_lock();
     for (i = 0; i < num; i++) {
         if (vdev->vq[i].vring.desc) {
@@ -2324,7 +2336,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
             g_malloc0(sizeof(*vdev->vector_queues) * nvectors);
     }
 
-    vdev->start_on_kick = !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
+    vdev->start_on_kick = false;
     vdev->started = false;
     vdev->device_id = device_id;
     vdev->status = 0;
-- 
MST


