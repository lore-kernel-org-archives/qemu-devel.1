Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9031DCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2233D206DD
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2233D206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iORzv-0002kg-Qi
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 15:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iORug-0001A2-4o
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iORue-0000MA-Le
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iORue-0000LQ-Cd
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:48 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E0DB2CE953
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 19:39:46 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id j10so6023898qka.10
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 12:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BRmAJHNfuUgrgO37y4oNQFAHZ0EePq1R3JVv9cY5RJ0=;
 b=sRzkFLXNWc6eW6GXgXHxPUapNCXEohGgF1zKdKjen4C+77Ou3JSOAaBfCxNhqnHFS6
 7tPdIG7PSunIsPW5D+jAL50JZcF1RCw4ptgxRk/j0KFc/JWmsF7tLoEgbi7QMwvc13v0
 naUcVCEtf8tpNMMLZz9GK/L5wzbMtDOc0MQbsv8zKitQJCOyFRK0mQatxDH22z4qkfHm
 KBqkjZtm80AA4EGHlsrCIc5A7uilhk93tGCDT1tuWkj5GWRFmapp+Z9UWubsMmoAZJV9
 W/uoqNazDni82N2V9ivDMOfvgSyc/8/9uvbLqfvrMbP946ovuhSEmy5Hq7IcQgzbwa0d
 WtDQ==
X-Gm-Message-State: APjAAAUh031viYJxDxn+m5k2X24R5n239noTgYPA0SFYNG9+cAlkkO77
 zg3cPYdRbwp2zf97RsNwNrEDkYpbJOxiUiuyRfSgI5c1au2akXqr+f84BCgUcpCKNGKQ6eTBmw5
 yUpGTknCaMXRfaUg=
X-Received: by 2002:ac8:73cf:: with SMTP id v15mr9697314qtp.310.1572118785315; 
 Sat, 26 Oct 2019 12:39:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBejjOZdnkLthXs2DM0CavSBD/X32gfGB4QQ+gpDTPlj8NlPOt6Q0PU3AX9KHBsv/yp64g5g==
X-Received: by 2002:ac8:73cf:: with SMTP id v15mr9697294qtp.310.1572118785079; 
 Sat, 26 Oct 2019 12:39:45 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 v3sm3052636qkd.78.2019.10.26.12.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 12:39:44 -0700 (PDT)
Date: Sat, 26 Oct 2019 15:39:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/25] virtio: event suppression support for packed ring
Message-ID: <20191026193824.11926-7-mst@redhat.com>
References: <20191026193824.11926-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191026193824.11926-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Wei Xu <wexu@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

This patch implements event suppression through device/driver
area. Please refer virtio specification for more information.

Signed-off-by: Wei Xu <wexu@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
Message-Id: <20191025083527.30803-7-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 142 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 133 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a694b4ab50..828c27de1f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -240,6 +240,44 @@ static void vring_split_desc_read(VirtIODevice *vdev=
, VRingDesc *desc,
     virtio_tswap16s(vdev, &desc->next);
 }
=20
+static void vring_packed_event_read(VirtIODevice *vdev,
+                                    MemoryRegionCache *cache,
+                                    VRingPackedDescEvent *e)
+{
+    hwaddr off_off =3D offsetof(VRingPackedDescEvent, off_wrap);
+    hwaddr off_flags =3D offsetof(VRingPackedDescEvent, flags);
+
+    address_space_read_cached(cache, off_flags, &e->flags,
+                              sizeof(e->flags));
+    /* Make sure flags is seen before off_wrap */
+    smp_rmb();
+    address_space_read_cached(cache, off_off, &e->off_wrap,
+                              sizeof(e->off_wrap));
+    virtio_tswap16s(vdev, &e->off_wrap);
+    virtio_tswap16s(vdev, &e->flags);
+}
+
+static void vring_packed_off_wrap_write(VirtIODevice *vdev,
+                                        MemoryRegionCache *cache,
+                                        uint16_t off_wrap)
+{
+    hwaddr off =3D offsetof(VRingPackedDescEvent, off_wrap);
+
+    virtio_tswap16s(vdev, &off_wrap);
+    address_space_write_cached(cache, off, &off_wrap, sizeof(off_wrap));
+    address_space_cache_invalidate(cache, off, sizeof(off_wrap));
+}
+
+static void vring_packed_flags_write(VirtIODevice *vdev,
+                                     MemoryRegionCache *cache, uint16_t =
flags)
+{
+    hwaddr off =3D offsetof(VRingPackedDescEvent, flags);
+
+    virtio_tswap16s(vdev, &flags);
+    address_space_write_cached(cache, off, &flags, sizeof(flags));
+    address_space_cache_invalidate(cache, off, sizeof(flags));
+}
+
 /* Called within rcu_read_lock().  */
 static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQueue=
 *vq)
 {
@@ -347,14 +385,8 @@ static inline void vring_set_avail_event(VirtQueue *=
vq, uint16_t val)
     address_space_cache_invalidate(&caches->used, pa, sizeof(val));
 }
=20
-void virtio_queue_set_notification(VirtQueue *vq, int enable)
+static void virtio_queue_split_set_notification(VirtQueue *vq, int enabl=
e)
 {
-    vq->notification =3D enable;
-
-    if (!vq->vring.desc) {
-        return;
-    }
-
     rcu_read_lock();
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
@@ -370,6 +402,51 @@ void virtio_queue_set_notification(VirtQueue *vq, in=
t enable)
     rcu_read_unlock();
 }
=20
+static void virtio_queue_packed_set_notification(VirtQueue *vq, int enab=
le)
+{
+    uint16_t off_wrap;
+    VRingPackedDescEvent e;
+    VRingMemoryRegionCaches *caches;
+
+    rcu_read_lock();
+    caches  =3D vring_get_region_caches(vq);
+    vring_packed_event_read(vq->vdev, &caches->used, &e);
+
+    if (!enable) {
+        e.flags =3D VRING_PACKED_EVENT_FLAG_DISABLE;
+    } else if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX=
)) {
+        off_wrap =3D vq->shadow_avail_idx | vq->shadow_avail_wrap_counte=
r << 15;
+        vring_packed_off_wrap_write(vq->vdev, &caches->used, off_wrap);
+        /* Make sure off_wrap is wrote before flags */
+        smp_wmb();
+        e.flags =3D VRING_PACKED_EVENT_FLAG_DESC;
+    } else {
+        e.flags =3D VRING_PACKED_EVENT_FLAG_ENABLE;
+    }
+
+    vring_packed_flags_write(vq->vdev, &caches->used, e.flags);
+    if (enable) {
+        /* Expose avail event/used flags before caller checks the avail =
idx. */
+        smp_mb();
+    }
+    rcu_read_unlock();
+}
+
+void virtio_queue_set_notification(VirtQueue *vq, int enable)
+{
+    vq->notification =3D enable;
+
+    if (!vq->vring.desc) {
+        return;
+    }
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtio_queue_packed_set_notification(vq, enable);
+    } else {
+        virtio_queue_split_set_notification(vq, enable);
+    }
+}
+
 int virtio_queue_ready(VirtQueue *vq)
 {
     return vq->vring.avail !=3D 0;
@@ -2287,8 +2364,7 @@ static void virtio_set_isr(VirtIODevice *vdev, int =
value)
     }
 }
=20
-/* Called within rcu_read_lock().  */
-static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
+static bool virtio_split_should_notify(VirtIODevice *vdev, VirtQueue *vq=
)
 {
     uint16_t old, new;
     bool v;
@@ -2311,6 +2387,54 @@ static bool virtio_should_notify(VirtIODevice *vde=
v, VirtQueue *vq)
     return !v || vring_need_event(vring_get_used_event(vq), new, old);
 }
=20
+static bool vring_packed_need_event(VirtQueue *vq, bool wrap,
+                                    uint16_t off_wrap, uint16_t new,
+                                    uint16_t old)
+{
+    int off =3D off_wrap & ~(1 << 15);
+
+    if (wrap !=3D off_wrap >> 15) {
+        off -=3D vq->vring.num;
+    }
+
+    return vring_need_event(off, new, old);
+}
+
+static bool virtio_packed_should_notify(VirtIODevice *vdev, VirtQueue *v=
q)
+{
+    VRingPackedDescEvent e;
+    uint16_t old, new;
+    bool v;
+    VRingMemoryRegionCaches *caches;
+
+    caches =3D vring_get_region_caches(vq);
+    vring_packed_event_read(vdev, &caches->avail, &e);
+
+    old =3D vq->signalled_used;
+    new =3D vq->signalled_used =3D vq->used_idx;
+    v =3D vq->signalled_used_valid;
+    vq->signalled_used_valid =3D true;
+
+    if (e.flags =3D=3D VRING_PACKED_EVENT_FLAG_DISABLE) {
+        return false;
+    } else if (e.flags =3D=3D VRING_PACKED_EVENT_FLAG_ENABLE) {
+        return true;
+    }
+
+    return !v || vring_packed_need_event(vq, vq->used_wrap_counter,
+                                         e.off_wrap, new, old);
+}
+
+/* Called within rcu_read_lock().  */
+static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
+{
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return virtio_packed_should_notify(vdev, vq);
+    } else {
+        return virtio_split_should_notify(vdev, vq);
+    }
+}
+
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
 {
     bool should_notify;
--=20
MST


