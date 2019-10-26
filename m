Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD40CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8050720867
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8050720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOS3J-0008Ly-9g
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 15:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iORue-00017e-GK
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iORuZ-0000Id-35
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43302)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iORuY-0000I3-Kv
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:43 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96F6D2CE953
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 19:39:41 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id n34so6327385qta.12
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 12:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Xsjesy0h9Ujk8Gb7mQO8oQh+WSzz9PJs1MGmGd1eaLY=;
 b=jWF/wowVkqRGUTIB750SZNQUvHU1/YCZ0+wUhCDp6gtBMX/2Yo5g/kJ/wbuqGPrayf
 j6bp0oABeNtdhxXXjbjcjpfBbBzPvJwvH7y1qNHOTVYlMEyg7/jkl49hSMqtC7MFqYq6
 CSFnihkDHzl6eG4ryIni6507TC57u5jggB5Pz2qBNO9SnsFvM2NohWYDZ2XmX93qgHYj
 goezP1mDpRh0tJst4eIRJziju6O46bi4+MXCvpdxgRc/VxACUm1jd6oi6YbruykW59wI
 6UR9PGlKxHECGuGsqgNy8xK0qzdAaZe35b6KtUiHLwEcPWsNa1EzlndtL2nJm1u8sp1v
 zD3A==
X-Gm-Message-State: APjAAAVQsuhIPTWUsNz8BY2QNWgam6eLbD+6UrInvSqAxMDr2GFpkzd5
 JqRh38UCC0XUviuAhHiie6fRsW+gUK60LcpoXIV/at+8cYwp22eBsrOpOXPfghI4blQD9EO1Xi8
 tz7ZsSeNHNY0Q61U=
X-Received: by 2002:aed:3baf:: with SMTP id r44mr7979319qte.255.1572118779916; 
 Sat, 26 Oct 2019 12:39:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtMX+KD0r+HLdeIGonKOHC+Khbgy26RfR0kgg8TwBBwuePOErfoaE2ZnSG9VAtCGX4BqVOlQ==
X-Received: by 2002:aed:3baf:: with SMTP id r44mr7979259qte.255.1572118779063; 
 Sat, 26 Oct 2019 12:39:39 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 q8sm4000155qta.31.2019.10.26.12.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 12:39:38 -0700 (PDT)
Date: Sat, 26 Oct 2019 15:39:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/25] virtio: basic packed virtqueue support
Message-ID: <20191026193824.11926-6-mst@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Wei Xu <wexu@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

This patch implements basic support for the packed virtqueue. Compare
the split virtqueue which has three rings, packed virtqueue only have
one which is supposed to have better cache utilization and more
hardware friendly.

Please refer virtio specification for more information.

Signed-off-by: Wei Xu <wexu@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
Message-Id: <20191025083527.30803-6-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/virtio-blk.c       |   2 +-
 hw/char/virtio-serial-bus.c |   2 +-
 hw/scsi/virtio-scsi.c       |   3 +-
 hw/virtio/virtio.c          | 901 +++++++++++++++++++++++++++++++++---
 include/hw/virtio/virtio.h  |  10 +-
 5 files changed, 836 insertions(+), 82 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ba846fe9dc..7dbdeaaab9 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1052,7 +1052,7 @@ static void virtio_blk_save_device(VirtIODevice *vd=
ev, QEMUFile *f)
             qemu_put_be32(f, virtio_get_queue_index(req->vq));
         }
=20
-        qemu_put_virtqueue_element(f, &req->elem);
+        qemu_put_virtqueue_element(vdev, f, &req->elem);
         req =3D req->next;
     }
     qemu_put_sbyte(f, 0);
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 4e0ed829ae..33259042a9 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -708,7 +708,7 @@ static void virtio_serial_save_device(VirtIODevice *v=
dev, QEMUFile *f)
         if (elem_popped) {
             qemu_put_be32s(f, &port->iov_idx);
             qemu_put_be64s(f, &port->iov_offset);
-            qemu_put_virtqueue_element(f, port->elem);
+            qemu_put_virtqueue_element(vdev, f, port->elem);
         }
     }
 }
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index ee52aa7d17..e8b2b64d09 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -190,11 +190,12 @@ static void virtio_scsi_save_request(QEMUFile *f, S=
CSIRequest *sreq)
 {
     VirtIOSCSIReq *req =3D sreq->hba_private;
     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(req->dev);
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(req->dev);
     uint32_t n =3D virtio_get_queue_index(req->vq) - 2;
=20
     assert(n < vs->conf.num_queues);
     qemu_put_be32s(f, &n);
-    qemu_put_virtqueue_element(f, &req->elem);
+    qemu_put_virtqueue_element(vdev, f, &req->elem);
 }
=20
 static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 74cc10fad9..a694b4ab50 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -96,6 +96,7 @@ typedef struct VRingPackedDescEvent {
 struct VirtQueue
 {
     VRing vring;
+    VirtQueueElement *used_elems;
=20
     /* Next head to pop */
     uint16_t last_avail_idx;
@@ -160,6 +161,7 @@ static void virtio_init_region_cache(VirtIODevice *vd=
ev, int n)
     VRingMemoryRegionCaches *new =3D NULL;
     hwaddr addr, size;
     int64_t len;
+    bool packed;
=20
=20
     addr =3D vq->vring.desc;
@@ -168,8 +170,10 @@ static void virtio_init_region_cache(VirtIODevice *v=
dev, int n)
     }
     new =3D g_new0(VRingMemoryRegionCaches, 1);
     size =3D virtio_queue_get_desc_size(vdev, n);
+    packed =3D virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED) ?
+                                   true : false;
     len =3D address_space_cache_init(&new->desc, vdev->dma_as,
-                                   addr, size, false);
+                                   addr, size, packed);
     if (len < size) {
         virtio_error(vdev, "Cannot map desc");
         goto err_desc;
@@ -225,8 +229,8 @@ void virtio_queue_update_rings(VirtIODevice *vdev, in=
t n)
 }
=20
 /* Called within rcu_read_lock().  */
-static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
-                            MemoryRegionCache *cache, int i)
+static void vring_split_desc_read(VirtIODevice *vdev, VRingDesc *desc,
+                                  MemoryRegionCache *cache, int i)
 {
     address_space_read_cached(cache, i * sizeof(VRingDesc),
                               desc, sizeof(VRingDesc));
@@ -236,6 +240,7 @@ static void vring_desc_read(VirtIODevice *vdev, VRing=
Desc *desc,
     virtio_tswap16s(vdev, &desc->next);
 }
=20
+/* Called within rcu_read_lock().  */
 static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQueue=
 *vq)
 {
     VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.cache=
s);
@@ -370,6 +375,95 @@ int virtio_queue_ready(VirtQueue *vq)
     return vq->vring.avail !=3D 0;
 }
=20
+static void vring_packed_desc_read_flags(VirtIODevice *vdev,
+                                         uint16_t *flags,
+                                         MemoryRegionCache *cache,
+                                         int i)
+{
+    address_space_read_cached(cache,
+                              i * sizeof(VRingPackedDesc) +
+                              offsetof(VRingPackedDesc, flags),
+                              flags, sizeof(*flags));
+    virtio_tswap16s(vdev, flags);
+}
+
+static void vring_packed_desc_read(VirtIODevice *vdev,
+                                   VRingPackedDesc *desc,
+                                   MemoryRegionCache *cache,
+                                   int i, bool strict_order)
+{
+    hwaddr off =3D i * sizeof(VRingPackedDesc);
+
+    vring_packed_desc_read_flags(vdev, &desc->flags, cache, i);
+
+    if (strict_order) {
+        /* Make sure flags is read before the rest fields. */
+        smp_rmb();
+    }
+
+    address_space_read_cached(cache, off + offsetof(VRingPackedDesc, add=
r),
+                              &desc->addr, sizeof(desc->addr));
+    address_space_read_cached(cache, off + offsetof(VRingPackedDesc, id)=
,
+                              &desc->id, sizeof(desc->id));
+    address_space_read_cached(cache, off + offsetof(VRingPackedDesc, len=
),
+                              &desc->len, sizeof(desc->len));
+    virtio_tswap64s(vdev, &desc->addr);
+    virtio_tswap16s(vdev, &desc->id);
+    virtio_tswap32s(vdev, &desc->len);
+}
+
+static void vring_packed_desc_write_data(VirtIODevice *vdev,
+                                         VRingPackedDesc *desc,
+                                         MemoryRegionCache *cache,
+                                         int i)
+{
+    hwaddr off_id =3D i * sizeof(VRingPackedDesc) +
+                    offsetof(VRingPackedDesc, id);
+    hwaddr off_len =3D i * sizeof(VRingPackedDesc) +
+                    offsetof(VRingPackedDesc, len);
+
+    virtio_tswap32s(vdev, &desc->len);
+    virtio_tswap16s(vdev, &desc->id);
+    address_space_write_cached(cache, off_id, &desc->id, sizeof(desc->id=
));
+    address_space_cache_invalidate(cache, off_id, sizeof(desc->id));
+    address_space_write_cached(cache, off_len, &desc->len, sizeof(desc->=
len));
+    address_space_cache_invalidate(cache, off_len, sizeof(desc->len));
+}
+
+static void vring_packed_desc_write_flags(VirtIODevice *vdev,
+                                          VRingPackedDesc *desc,
+                                          MemoryRegionCache *cache,
+                                          int i)
+{
+    hwaddr off =3D i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDes=
c, flags);
+
+    virtio_tswap16s(vdev, &desc->flags);
+    address_space_write_cached(cache, off, &desc->flags, sizeof(desc->fl=
ags));
+    address_space_cache_invalidate(cache, off, sizeof(desc->flags));
+}
+
+static void vring_packed_desc_write(VirtIODevice *vdev,
+                                    VRingPackedDesc *desc,
+                                    MemoryRegionCache *cache,
+                                    int i, bool strict_order)
+{
+    vring_packed_desc_write_data(vdev, desc, cache, i);
+    if (strict_order) {
+        /* Make sure data is wrote before flags. */
+        smp_wmb();
+    }
+    vring_packed_desc_write_flags(vdev, desc, cache, i);
+}
+
+static inline bool is_desc_avail(uint16_t flags, bool wrap_counter)
+{
+    bool avail, used;
+
+    avail =3D !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
+    used =3D !!(flags & (1 << VRING_PACKED_DESC_F_USED));
+    return (avail !=3D used) && (avail =3D=3D wrap_counter);
+}
+
 /* Fetch avail_idx from VQ memory only when we really need to know if
  * guest has added some buffers.
  * Called within rcu_read_lock().  */
@@ -390,7 +484,7 @@ static int virtio_queue_empty_rcu(VirtQueue *vq)
     return vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
 }
=20
-int virtio_queue_empty(VirtQueue *vq)
+static int virtio_queue_split_empty(VirtQueue *vq)
 {
     bool empty;
=20
@@ -412,6 +506,41 @@ int virtio_queue_empty(VirtQueue *vq)
     return empty;
 }
=20
+static int virtio_queue_packed_empty_rcu(VirtQueue *vq)
+{
+    struct VRingPackedDesc desc;
+    VRingMemoryRegionCaches *cache;
+
+    if (unlikely(!vq->vring.desc)) {
+        return 1;
+    }
+
+    cache =3D vring_get_region_caches(vq);
+    vring_packed_desc_read_flags(vq->vdev, &desc.flags, &cache->desc,
+                                 vq->last_avail_idx);
+
+    return !is_desc_avail(desc.flags, vq->last_avail_wrap_counter);
+}
+
+static int virtio_queue_packed_empty(VirtQueue *vq)
+{
+    bool empty;
+
+    rcu_read_lock();
+    empty =3D virtio_queue_packed_empty_rcu(vq);
+    rcu_read_unlock();
+    return empty;
+}
+
+int virtio_queue_empty(VirtQueue *vq)
+{
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        return virtio_queue_packed_empty(vq);
+    } else {
+        return virtio_queue_split_empty(vq);
+    }
+}
+
 static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement *el=
em,
                                unsigned int len)
 {
@@ -449,10 +578,25 @@ static void virtqueue_unmap_sg(VirtQueue *vq, const=
 VirtQueueElement *elem,
 void virtqueue_detach_element(VirtQueue *vq, const VirtQueueElement *ele=
m,
                               unsigned int len)
 {
-    vq->inuse--;
+    vq->inuse -=3D elem->ndescs;
     virtqueue_unmap_sg(vq, elem, len);
 }
=20
+static void virtqueue_split_rewind(VirtQueue *vq, unsigned int num)
+{
+    vq->last_avail_idx -=3D num;
+}
+
+static void virtqueue_packed_rewind(VirtQueue *vq, unsigned int num)
+{
+    if (vq->last_avail_idx < num) {
+        vq->last_avail_idx =3D vq->vring.num + vq->last_avail_idx - num;
+        vq->last_avail_wrap_counter ^=3D 1;
+    } else {
+        vq->last_avail_idx -=3D num;
+    }
+}
+
 /* virtqueue_unpop:
  * @vq: The #VirtQueue
  * @elem: The #VirtQueueElement
@@ -464,7 +608,13 @@ void virtqueue_detach_element(VirtQueue *vq, const V=
irtQueueElement *elem,
 void virtqueue_unpop(VirtQueue *vq, const VirtQueueElement *elem,
                      unsigned int len)
 {
-    vq->last_avail_idx--;
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_packed_rewind(vq, 1);
+    } else {
+        virtqueue_split_rewind(vq, 1);
+    }
+
     virtqueue_detach_element(vq, elem, len);
 }
=20
@@ -485,25 +635,21 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int n=
um)
     if (num > vq->inuse) {
         return false;
     }
-    vq->last_avail_idx -=3D num;
+
     vq->inuse -=3D num;
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_packed_rewind(vq, num);
+    } else {
+        virtqueue_split_rewind(vq, num);
+    }
     return true;
 }
=20
-/* Called within rcu_read_lock().  */
-void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
+static void virtqueue_split_fill(VirtQueue *vq, const VirtQueueElement *=
elem,
                     unsigned int len, unsigned int idx)
 {
     VRingUsedElem uelem;
=20
-    trace_virtqueue_fill(vq, elem, len, idx);
-
-    virtqueue_unmap_sg(vq, elem, len);
-
-    if (unlikely(vq->vdev->broken)) {
-        return;
-    }
-
     if (unlikely(!vq->vring.used)) {
         return;
     }
@@ -515,16 +661,72 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueE=
lement *elem,
     vring_used_write(vq, &uelem, idx);
 }
=20
+static void virtqueue_packed_fill(VirtQueue *vq, const VirtQueueElement =
*elem,
+                                  unsigned int len, unsigned int idx)
+{
+    vq->used_elems[idx].index =3D elem->index;
+    vq->used_elems[idx].len =3D len;
+    vq->used_elems[idx].ndescs =3D elem->ndescs;
+}
+
+static void virtqueue_packed_fill_desc(VirtQueue *vq,
+                                       const VirtQueueElement *elem,
+                                       unsigned int idx,
+                                       bool strict_order)
+{
+    uint16_t head;
+    VRingMemoryRegionCaches *caches;
+    VRingPackedDesc desc =3D {
+        .id =3D elem->index,
+        .len =3D elem->len,
+    };
+    bool wrap_counter =3D vq->used_wrap_counter;
+
+    if (unlikely(!vq->vring.desc)) {
+        return;
+    }
+
+    head =3D vq->used_idx + idx;
+    if (head >=3D vq->vring.num) {
+        head -=3D vq->vring.num;
+        wrap_counter ^=3D 1;
+    }
+    if (wrap_counter) {
+        desc.flags |=3D (1 << VRING_PACKED_DESC_F_AVAIL);
+        desc.flags |=3D (1 << VRING_PACKED_DESC_F_USED);
+    } else {
+        desc.flags &=3D ~(1 << VRING_PACKED_DESC_F_AVAIL);
+        desc.flags &=3D ~(1 << VRING_PACKED_DESC_F_USED);
+    }
+
+    caches =3D vring_get_region_caches(vq);
+    vring_packed_desc_write(vq->vdev, &desc, &caches->desc, head, strict=
_order);
+}
+
 /* Called within rcu_read_lock().  */
-void virtqueue_flush(VirtQueue *vq, unsigned int count)
+void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
+                    unsigned int len, unsigned int idx)
 {
-    uint16_t old, new;
+    trace_virtqueue_fill(vq, elem, len, idx);
+
+    virtqueue_unmap_sg(vq, elem, len);
=20
     if (unlikely(vq->vdev->broken)) {
-        vq->inuse -=3D count;
         return;
     }
=20
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_packed_fill(vq, elem, len, idx);
+    } else {
+        virtqueue_split_fill(vq, elem, len, idx);
+    }
+}
+
+/* Called within rcu_read_lock().  */
+static void virtqueue_split_flush(VirtQueue *vq, unsigned int count)
+{
+    uint16_t old, new;
+
     if (unlikely(!vq->vring.used)) {
         return;
     }
@@ -540,6 +742,43 @@ void virtqueue_flush(VirtQueue *vq, unsigned int cou=
nt)
         vq->signalled_used_valid =3D false;
 }
=20
+static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
+{
+    unsigned int i, ndescs =3D 0;
+
+    if (unlikely(!vq->vring.desc)) {
+        return;
+    }
+
+    for (i =3D 1; i < count; i++) {
+        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
+        ndescs +=3D vq->used_elems[i].ndescs;
+    }
+    virtqueue_packed_fill_desc(vq, &vq->used_elems[0], 0, true);
+    ndescs +=3D vq->used_elems[0].ndescs;
+
+    vq->inuse -=3D ndescs;
+    vq->used_idx +=3D ndescs;
+    if (vq->used_idx >=3D vq->vring.num) {
+        vq->used_idx -=3D vq->vring.num;
+        vq->used_wrap_counter ^=3D 1;
+    }
+}
+
+void virtqueue_flush(VirtQueue *vq, unsigned int count)
+{
+    if (unlikely(vq->vdev->broken)) {
+        vq->inuse -=3D count;
+        return;
+    }
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_packed_flush(vq, count);
+    } else {
+        virtqueue_split_flush(vq, count);
+    }
+}
+
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len)
 {
@@ -592,9 +831,9 @@ enum {
     VIRTQUEUE_READ_DESC_MORE =3D 1,   /* more buffers in chain */
 };
=20
-static int virtqueue_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
-                                    MemoryRegionCache *desc_cache, unsig=
ned int max,
-                                    unsigned int *next)
+static int virtqueue_split_read_next_desc(VirtIODevice *vdev, VRingDesc =
*desc,
+                                          MemoryRegionCache *desc_cache,
+                                          unsigned int max, unsigned int=
 *next)
 {
     /* If this descriptor says it doesn't chain, we're done. */
     if (!(desc->flags & VRING_DESC_F_NEXT)) {
@@ -611,13 +850,13 @@ static int virtqueue_read_next_desc(VirtIODevice *v=
dev, VRingDesc *desc,
         return VIRTQUEUE_READ_DESC_ERROR;
     }
=20
-    vring_desc_read(vdev, desc, desc_cache, *next);
+    vring_split_desc_read(vdev, desc, desc_cache, *next);
     return VIRTQUEUE_READ_DESC_MORE;
 }
=20
-void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
-                               unsigned int *out_bytes,
-                               unsigned max_in_bytes, unsigned max_out_b=
ytes)
+static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
+                            unsigned int *in_bytes, unsigned int *out_by=
tes,
+                            unsigned max_in_bytes, unsigned max_out_byte=
s)
 {
     VirtIODevice *vdev =3D vq->vdev;
     unsigned int max, idx;
@@ -627,27 +866,12 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsig=
ned int *in_bytes,
     int64_t len =3D 0;
     int rc;
=20
-    if (unlikely(!vq->vring.desc)) {
-        if (in_bytes) {
-            *in_bytes =3D 0;
-        }
-        if (out_bytes) {
-            *out_bytes =3D 0;
-        }
-        return;
-    }
-
     rcu_read_lock();
     idx =3D vq->last_avail_idx;
     total_bufs =3D in_total =3D out_total =3D 0;
=20
     max =3D vq->vring.num;
     caches =3D vring_get_region_caches(vq);
-    if (caches->desc.len < max * sizeof(VRingDesc)) {
-        virtio_error(vdev, "Cannot map descriptor ring");
-        goto err;
-    }
-
     while ((rc =3D virtqueue_num_heads(vq, idx)) > 0) {
         MemoryRegionCache *desc_cache =3D &caches->desc;
         unsigned int num_bufs;
@@ -660,7 +884,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigne=
d int *in_bytes,
             goto err;
         }
=20
-        vring_desc_read(vdev, &desc, desc_cache, i);
+        vring_split_desc_read(vdev, &desc, desc_cache, i);
=20
         if (desc.flags & VRING_DESC_F_INDIRECT) {
             if (!desc.len || (desc.len % sizeof(VRingDesc))) {
@@ -686,7 +910,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigne=
d int *in_bytes,
=20
             max =3D desc.len / sizeof(VRingDesc);
             num_bufs =3D i =3D 0;
-            vring_desc_read(vdev, &desc, desc_cache, i);
+            vring_split_desc_read(vdev, &desc, desc_cache, i);
         }
=20
         do {
@@ -705,7 +929,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigne=
d int *in_bytes,
                 goto done;
             }
=20
-            rc =3D virtqueue_read_next_desc(vdev, &desc, desc_cache, max=
, &i);
+            rc =3D virtqueue_split_read_next_desc(vdev, &desc, desc_cach=
e, max, &i);
         } while (rc =3D=3D VIRTQUEUE_READ_DESC_MORE);
=20
         if (rc =3D=3D VIRTQUEUE_READ_DESC_ERROR) {
@@ -730,14 +954,194 @@ done:
         *in_bytes =3D in_total;
     }
     if (out_bytes) {
-        *out_bytes =3D out_total;
+        *out_bytes =3D out_total;
+    }
+    rcu_read_unlock();
+    return;
+
+err:
+    in_total =3D out_total =3D 0;
+    goto done;
+}
+
+static int virtqueue_packed_read_next_desc(VirtQueue *vq,
+                                           VRingPackedDesc *desc,
+                                           MemoryRegionCache
+                                           *desc_cache,
+                                           unsigned int max,
+                                           unsigned int *next,
+                                           bool indirect)
+{
+    /* If this descriptor says it doesn't chain, we're done. */
+    if (!indirect && !(desc->flags & VRING_DESC_F_NEXT)) {
+        return VIRTQUEUE_READ_DESC_DONE;
+    }
+
+    ++*next;
+    if (*next =3D=3D max) {
+        if (indirect) {
+            return VIRTQUEUE_READ_DESC_DONE;
+        } else {
+            (*next) -=3D vq->vring.num;
+        }
+    }
+
+    vring_packed_desc_read(vq->vdev, desc, desc_cache, *next, false);
+    return VIRTQUEUE_READ_DESC_MORE;
+}
+
+static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
+                                             unsigned int *in_bytes,
+                                             unsigned int *out_bytes,
+                                             unsigned max_in_bytes,
+                                             unsigned max_out_bytes)
+{
+    VirtIODevice *vdev =3D vq->vdev;
+    unsigned int max, idx;
+    unsigned int total_bufs, in_total, out_total;
+    MemoryRegionCache *desc_cache;
+    VRingMemoryRegionCaches *caches;
+    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INVALI=
D;
+    int64_t len =3D 0;
+    VRingPackedDesc desc;
+    bool wrap_counter;
+
+    rcu_read_lock();
+    idx =3D vq->last_avail_idx;
+    wrap_counter =3D vq->last_avail_wrap_counter;
+    total_bufs =3D in_total =3D out_total =3D 0;
+
+    max =3D vq->vring.num;
+    caches =3D vring_get_region_caches(vq);
+
+    for (;;) {
+        unsigned int num_bufs =3D total_bufs;
+        unsigned int i =3D idx;
+        int rc;
+
+        desc_cache =3D &caches->desc;
+        vring_packed_desc_read(vdev, &desc, desc_cache, idx, true);
+        if (!is_desc_avail(desc.flags, wrap_counter)) {
+            break;
+        }
+
+        if (desc.flags & VRING_DESC_F_INDIRECT) {
+            if (desc.len % sizeof(VRingPackedDesc)) {
+                virtio_error(vdev, "Invalid size for indirect buffer tab=
le");
+                goto err;
+            }
+
+            /* If we've got too many, that implies a descriptor loop. */
+            if (num_bufs >=3D max) {
+                virtio_error(vdev, "Looped descriptor");
+                goto err;
+            }
+
+            /* loop over the indirect descriptor table */
+            len =3D address_space_cache_init(&indirect_desc_cache,
+                                           vdev->dma_as,
+                                           desc.addr, desc.len, false);
+            desc_cache =3D &indirect_desc_cache;
+            if (len < desc.len) {
+                virtio_error(vdev, "Cannot map indirect buffer");
+                goto err;
+            }
+
+            max =3D desc.len / sizeof(VRingPackedDesc);
+            num_bufs =3D i =3D 0;
+            vring_packed_desc_read(vdev, &desc, desc_cache, i, false);
+        }
+
+        do {
+            /* If we've got too many, that implies a descriptor loop. */
+            if (++num_bufs > max) {
+                virtio_error(vdev, "Looped descriptor");
+                goto err;
+            }
+
+            if (desc.flags & VRING_DESC_F_WRITE) {
+                in_total +=3D desc.len;
+            } else {
+                out_total +=3D desc.len;
+            }
+            if (in_total >=3D max_in_bytes && out_total >=3D max_out_byt=
es) {
+                goto done;
+            }
+
+            rc =3D virtqueue_packed_read_next_desc(vq, &desc, desc_cache=
, max,
+                                                 &i, desc_cache =3D=3D
+                                                 &indirect_desc_cache);
+        } while (rc =3D=3D VIRTQUEUE_READ_DESC_MORE);
+
+        if (desc_cache =3D=3D &indirect_desc_cache) {
+            address_space_cache_destroy(&indirect_desc_cache);
+            total_bufs++;
+            idx++;
+        } else {
+            idx +=3D num_bufs - total_bufs;
+            total_bufs =3D num_bufs;
+        }
+
+        if (idx >=3D vq->vring.num) {
+            idx -=3D vq->vring.num;
+            wrap_counter ^=3D 1;
+        }
+    }
+
+    /* Record the index and wrap counter for a kick we want */
+    vq->shadow_avail_idx =3D idx;
+    vq->shadow_avail_wrap_counter =3D wrap_counter;
+done:
+    address_space_cache_destroy(&indirect_desc_cache);
+    if (in_bytes) {
+        *in_bytes =3D in_total;
+    }
+    if (out_bytes) {
+        *out_bytes =3D out_total;
+    }
+    rcu_read_unlock();
+    return;
+
+err:
+    in_total =3D out_total =3D 0;
+    goto done;
+}
+
+void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
+                               unsigned int *out_bytes,
+                               unsigned max_in_bytes, unsigned max_out_b=
ytes)
+{
+    uint16_t desc_size;
+    VRingMemoryRegionCaches *caches;
+
+    if (unlikely(!vq->vring.desc)) {
+        goto err;
+    }
+
+    caches =3D vring_get_region_caches(vq);
+    desc_size =3D virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED=
) ?
+                                sizeof(VRingPackedDesc) : sizeof(VRingDe=
sc);
+    if (caches->desc.len < vq->vring.num * desc_size) {
+        virtio_error(vq->vdev, "Cannot map descriptor ring");
+        goto err;
+    }
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_packed_get_avail_bytes(vq, in_bytes, out_bytes,
+                                         max_in_bytes, max_out_bytes);
+    } else {
+        virtqueue_split_get_avail_bytes(vq, in_bytes, out_bytes,
+                                        max_in_bytes, max_out_bytes);
+    }
+
+    return;
+err:
+    if (in_bytes) {
+        *in_bytes =3D 0;
+    }
+    if (out_bytes) {
+        *out_bytes =3D 0;
     }
-    rcu_read_unlock();
-    return;
-
-err:
-    in_total =3D out_total =3D 0;
-    goto done;
 }
=20
 int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
@@ -864,7 +1268,7 @@ static void *virtqueue_alloc_element(size_t sz, unsi=
gned out_num, unsigned in_nu
     return elem;
 }
=20
-void *virtqueue_pop(VirtQueue *vq, size_t sz)
+static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, head, max;
     VRingMemoryRegionCaches *caches;
@@ -879,9 +1283,6 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     VRingDesc desc;
     int rc;
=20
-    if (unlikely(vdev->broken)) {
-        return NULL;
-    }
     rcu_read_lock();
     if (virtio_queue_empty_rcu(vq)) {
         goto done;
@@ -917,7 +1318,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     }
=20
     desc_cache =3D &caches->desc;
-    vring_desc_read(vdev, &desc, desc_cache, i);
+    vring_split_desc_read(vdev, &desc, desc_cache, i);
     if (desc.flags & VRING_DESC_F_INDIRECT) {
         if (!desc.len || (desc.len % sizeof(VRingDesc))) {
             virtio_error(vdev, "Invalid size for indirect buffer table")=
;
@@ -935,7 +1336,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
=20
         max =3D desc.len / sizeof(VRingDesc);
         i =3D 0;
-        vring_desc_read(vdev, &desc, desc_cache, i);
+        vring_split_desc_read(vdev, &desc, desc_cache, i);
     }
=20
     /* Collect all the descriptors */
@@ -966,7 +1367,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
             goto err_undo_map;
         }
=20
-        rc =3D virtqueue_read_next_desc(vdev, &desc, desc_cache, max, &i=
);
+        rc =3D virtqueue_split_read_next_desc(vdev, &desc, desc_cache, m=
ax, &i);
     } while (rc =3D=3D VIRTQUEUE_READ_DESC_MORE);
=20
     if (rc =3D=3D VIRTQUEUE_READ_DESC_ERROR) {
@@ -976,6 +1377,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     /* Now copy what we have collected and mapped */
     elem =3D virtqueue_alloc_element(sz, out_num, in_num);
     elem->index =3D head;
+    elem->ndescs =3D 1;
     for (i =3D 0; i < out_num; i++) {
         elem->out_addr[i] =3D addr[i];
         elem->out_sg[i] =3D iov[i];
@@ -999,23 +1401,204 @@ err_undo_map:
     goto done;
 }
=20
-/* virtqueue_drop_all:
- * @vq: The #VirtQueue
- * Drops all queued buffers and indicates them to the guest
- * as if they are done. Useful when buffers can not be
- * processed but must be returned to the guest.
- */
-unsigned int virtqueue_drop_all(VirtQueue *vq)
+static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
+{
+    unsigned int i, max;
+    VRingMemoryRegionCaches *caches;
+    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INVALI=
D;
+    MemoryRegionCache *desc_cache;
+    int64_t len;
+    VirtIODevice *vdev =3D vq->vdev;
+    VirtQueueElement *elem =3D NULL;
+    unsigned out_num, in_num, elem_entries;
+    hwaddr addr[VIRTQUEUE_MAX_SIZE];
+    struct iovec iov[VIRTQUEUE_MAX_SIZE];
+    VRingPackedDesc desc;
+    uint16_t id;
+    int rc;
+
+    rcu_read_lock();
+    if (virtio_queue_packed_empty_rcu(vq)) {
+        goto done;
+    }
+
+    /* When we start there are none of either input nor output. */
+    out_num =3D in_num =3D elem_entries =3D 0;
+
+    max =3D vq->vring.num;
+
+    if (vq->inuse >=3D vq->vring.num) {
+        virtio_error(vdev, "Virtqueue size exceeded");
+        goto done;
+    }
+
+    i =3D vq->last_avail_idx;
+
+    caches =3D vring_get_region_caches(vq);
+    if (caches->desc.len < max * sizeof(VRingDesc)) {
+        virtio_error(vdev, "Cannot map descriptor ring");
+        goto done;
+    }
+
+    desc_cache =3D &caches->desc;
+    vring_packed_desc_read(vdev, &desc, desc_cache, i, true);
+    id =3D desc.id;
+    if (desc.flags & VRING_DESC_F_INDIRECT) {
+        if (desc.len % sizeof(VRingPackedDesc)) {
+            virtio_error(vdev, "Invalid size for indirect buffer table")=
;
+            goto done;
+        }
+
+        /* loop over the indirect descriptor table */
+        len =3D address_space_cache_init(&indirect_desc_cache, vdev->dma=
_as,
+                                       desc.addr, desc.len, false);
+        desc_cache =3D &indirect_desc_cache;
+        if (len < desc.len) {
+            virtio_error(vdev, "Cannot map indirect buffer");
+            goto done;
+        }
+
+        max =3D desc.len / sizeof(VRingPackedDesc);
+        i =3D 0;
+        vring_packed_desc_read(vdev, &desc, desc_cache, i, false);
+    }
+
+    /* Collect all the descriptors */
+    do {
+        bool map_ok;
+
+        if (desc.flags & VRING_DESC_F_WRITE) {
+            map_ok =3D virtqueue_map_desc(vdev, &in_num, addr + out_num,
+                                        iov + out_num,
+                                        VIRTQUEUE_MAX_SIZE - out_num, tr=
ue,
+                                        desc.addr, desc.len);
+        } else {
+            if (in_num) {
+                virtio_error(vdev, "Incorrect order for descriptors");
+                goto err_undo_map;
+            }
+            map_ok =3D virtqueue_map_desc(vdev, &out_num, addr, iov,
+                                        VIRTQUEUE_MAX_SIZE, false,
+                                        desc.addr, desc.len);
+        }
+        if (!map_ok) {
+            goto err_undo_map;
+        }
+
+        /* If we've got too many, that implies a descriptor loop. */
+        if (++elem_entries > max) {
+            virtio_error(vdev, "Looped descriptor");
+            goto err_undo_map;
+        }
+
+        rc =3D virtqueue_packed_read_next_desc(vq, &desc, desc_cache, ma=
x, &i,
+                                             desc_cache =3D=3D
+                                             &indirect_desc_cache);
+    } while (rc =3D=3D VIRTQUEUE_READ_DESC_MORE);
+
+    /* Now copy what we have collected and mapped */
+    elem =3D virtqueue_alloc_element(sz, out_num, in_num);
+    for (i =3D 0; i < out_num; i++) {
+        elem->out_addr[i] =3D addr[i];
+        elem->out_sg[i] =3D iov[i];
+    }
+    for (i =3D 0; i < in_num; i++) {
+        elem->in_addr[i] =3D addr[out_num + i];
+        elem->in_sg[i] =3D iov[out_num + i];
+    }
+
+    elem->index =3D id;
+    elem->ndescs =3D (desc_cache =3D=3D &indirect_desc_cache) ? 1 : elem=
_entries;
+    vq->last_avail_idx +=3D elem->ndescs;
+    vq->inuse +=3D elem->ndescs;
+
+    if (vq->last_avail_idx >=3D vq->vring.num) {
+        vq->last_avail_idx -=3D vq->vring.num;
+        vq->last_avail_wrap_counter ^=3D 1;
+    }
+
+    vq->shadow_avail_idx =3D vq->last_avail_idx;
+    vq->shadow_avail_wrap_counter =3D vq->last_avail_wrap_counter;
+
+    trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
+done:
+    address_space_cache_destroy(&indirect_desc_cache);
+    rcu_read_unlock();
+
+    return elem;
+
+err_undo_map:
+    virtqueue_undo_map_desc(out_num, in_num, iov);
+    goto done;
+}
+
+void *virtqueue_pop(VirtQueue *vq, size_t sz)
 {
+    if (unlikely(vq->vdev->broken)) {
+        return NULL;
+    }
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        return virtqueue_packed_pop(vq, sz);
+    } else {
+        return virtqueue_split_pop(vq, sz);
+    }
+}
+
+static unsigned int virtqueue_packed_drop_all(VirtQueue *vq)
+{
+    VRingMemoryRegionCaches *caches;
+    MemoryRegionCache *desc_cache;
     unsigned int dropped =3D 0;
     VirtQueueElement elem =3D {};
     VirtIODevice *vdev =3D vq->vdev;
-    bool fEventIdx =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT=
_IDX);
+    VRingPackedDesc desc;
=20
-    if (unlikely(vdev->broken)) {
-        return 0;
+    caches =3D vring_get_region_caches(vq);
+    desc_cache =3D &caches->desc;
+
+    virtio_queue_set_notification(vq, 0);
+
+    while (vq->inuse < vq->vring.num) {
+        unsigned int idx =3D vq->last_avail_idx;
+        /*
+         * works similar to virtqueue_pop but does not map buffers
+         * and does not allocate any memory.
+         */
+        vring_packed_desc_read(vdev, &desc, desc_cache,
+                               vq->last_avail_idx , true);
+        if (!is_desc_avail(desc.flags, vq->last_avail_wrap_counter)) {
+            break;
+        }
+        elem.index =3D desc.id;
+        elem.ndescs =3D 1;
+        while (virtqueue_packed_read_next_desc(vq, &desc, desc_cache,
+                                               vq->vring.num, &idx, fals=
e)) {
+            ++elem.ndescs;
+        }
+        /*
+         * immediately push the element, nothing to unmap
+         * as both in_num and out_num are set to 0.
+         */
+        virtqueue_push(vq, &elem, 0);
+        dropped++;
+        vq->last_avail_idx +=3D elem.ndescs;
+        if (vq->last_avail_idx >=3D vq->vring.num) {
+            vq->last_avail_idx -=3D vq->vring.num;
+            vq->last_avail_wrap_counter ^=3D 1;
+        }
     }
=20
+    return dropped;
+}
+
+static unsigned int virtqueue_split_drop_all(VirtQueue *vq)
+{
+    unsigned int dropped =3D 0;
+    VirtQueueElement elem =3D {};
+    VirtIODevice *vdev =3D vq->vdev;
+    bool fEventIdx =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT=
_IDX);
+
     while (!virtio_queue_empty(vq) && vq->inuse < vq->vring.num) {
         /* works similar to virtqueue_pop but does not map buffers
         * and does not allocate any memory */
@@ -1037,6 +1620,27 @@ unsigned int virtqueue_drop_all(VirtQueue *vq)
     return dropped;
 }
=20
+/* virtqueue_drop_all:
+ * @vq: The #VirtQueue
+ * Drops all queued buffers and indicates them to the guest
+ * as if they are done. Useful when buffers can not be
+ * processed but must be returned to the guest.
+ */
+unsigned int virtqueue_drop_all(VirtQueue *vq)
+{
+    struct VirtIODevice *vdev =3D vq->vdev;
+
+    if (unlikely(vdev->broken)) {
+        return 0;
+    }
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return virtqueue_packed_drop_all(vq);
+    } else {
+        return virtqueue_split_drop_all(vq);
+    }
+}
+
 /* Reading and writing a structure directly to QEMUFile is *awful*, but
  * it is what QEMU has always done by mistake.  We can change it sooner
  * or later by bumping the version number of the affected vm states.
@@ -1093,11 +1697,16 @@ void *qemu_get_virtqueue_element(VirtIODevice *vd=
ev, QEMUFile *f, size_t sz)
         elem->out_sg[i].iov_len =3D data.out_sg[i].iov_len;
     }
=20
+    if (virtio_host_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        qemu_get_be32s(f, &elem->ndescs);
+    }
+
     virtqueue_map(vdev, elem);
     return elem;
 }
=20
-void qemu_put_virtqueue_element(QEMUFile *f, VirtQueueElement *elem)
+void qemu_put_virtqueue_element(VirtIODevice *vdev, QEMUFile *f,
+                                VirtQueueElement *elem)
 {
     VirtQueueElementOld data;
     int i;
@@ -1125,6 +1734,11 @@ void qemu_put_virtqueue_element(QEMUFile *f, VirtQ=
ueueElement *elem)
         /* Do not save iov_base as above.  */
         data.out_sg[i].iov_len =3D elem->out_sg[i].iov_len;
     }
+
+    if (virtio_host_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        qemu_put_be32s(f, &elem->ndescs);
+    }
+
     qemu_put_buffer(f, (uint8_t *)&data, sizeof(VirtQueueElementOld));
 }
=20
@@ -1249,6 +1863,9 @@ void virtio_reset(void *opaque)
         vdev->vq[i].last_avail_idx =3D 0;
         vdev->vq[i].shadow_avail_idx =3D 0;
         vdev->vq[i].used_idx =3D 0;
+        vdev->vq[i].last_avail_wrap_counter =3D true;
+        vdev->vq[i].shadow_avail_wrap_counter =3D true;
+        vdev->vq[i].used_wrap_counter =3D true;
         virtio_queue_set_vector(vdev, i, VIRTIO_NO_VECTOR);
         vdev->vq[i].signalled_used =3D 0;
         vdev->vq[i].signalled_used_valid =3D false;
@@ -1639,6 +2256,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int=
 queue_size,
     vdev->vq[i].vring.align =3D VIRTIO_PCI_VRING_ALIGN;
     vdev->vq[i].handle_output =3D handle_output;
     vdev->vq[i].handle_aio_output =3D NULL;
+    vdev->vq[i].used_elems =3D g_malloc0(sizeof(VirtQueueElement) *
+                                       queue_size);
=20
     return &vdev->vq[i];
 }
@@ -1653,6 +2272,7 @@ void virtio_del_queue(VirtIODevice *vdev, int n)
     vdev->vq[n].vring.num_default =3D 0;
     vdev->vq[n].handle_output =3D NULL;
     vdev->vq[n].handle_aio_output =3D NULL;
+    g_free(vdev->vq[n].used_elems);
 }
=20
 static void virtio_set_isr(VirtIODevice *vdev, int value)
@@ -1780,6 +2400,13 @@ static bool virtio_virtqueue_needed(void *opaque)
     return virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1);
 }
=20
+static bool virtio_packed_virtqueue_needed(void *opaque)
+{
+    VirtIODevice *vdev =3D opaque;
+
+    return virtio_host_has_feature(vdev, VIRTIO_F_RING_PACKED);
+}
+
 static bool virtio_ringsize_needed(void *opaque)
 {
     VirtIODevice *vdev =3D opaque;
@@ -1828,6 +2455,20 @@ static const VMStateDescription vmstate_virtqueue =
=3D {
     }
 };
=20
+static const VMStateDescription vmstate_packed_virtqueue =3D {
+    .name =3D "packed_virtqueue_state",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT16(last_avail_idx, struct VirtQueue),
+        VMSTATE_BOOL(last_avail_wrap_counter, struct VirtQueue),
+        VMSTATE_UINT16(used_idx, struct VirtQueue),
+        VMSTATE_BOOL(used_wrap_counter, struct VirtQueue),
+        VMSTATE_UINT32(inuse, struct VirtQueue),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_virtqueues =3D {
     .name =3D "virtio/virtqueues",
     .version_id =3D 1,
@@ -1840,6 +2481,18 @@ static const VMStateDescription vmstate_virtio_vir=
tqueues =3D {
     }
 };
=20
+static const VMStateDescription vmstate_virtio_packed_virtqueues =3D {
+    .name =3D "virtio/packed_virtqueues",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D &virtio_packed_virtqueue_needed,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
+                      VIRTIO_QUEUE_MAX, 0, vmstate_packed_virtqueue, Vir=
tQueue),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ringsize =3D {
     .name =3D "ringsize_state",
     .version_id =3D 1,
@@ -1972,6 +2625,7 @@ static const VMStateDescription vmstate_virtio =3D =
{
         &vmstate_virtio_broken,
         &vmstate_virtio_extra_state,
         &vmstate_virtio_started,
+        &vmstate_virtio_packed_virtqueues,
         NULL
     }
 };
@@ -2271,6 +2925,13 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, i=
nt version_id)
                 virtio_queue_update_rings(vdev, i);
             }
=20
+            if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+                vdev->vq[i].shadow_avail_idx =3D vdev->vq[i].last_avail_=
idx;
+                vdev->vq[i].shadow_avail_wrap_counter =3D
+                                        vdev->vq[i].last_avail_wrap_coun=
ter;
+                continue;
+            }
+
             nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_=
avail_idx;
             /* Check it isn't doing strange things with descriptor numbe=
rs. */
             if (nheads > vdev->vq[i].vring.num) {
@@ -2414,6 +3075,10 @@ hwaddr virtio_queue_get_avail_size(VirtIODevice *v=
dev, int n)
 {
     int s;
=20
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return sizeof(struct VRingPackedDescEvent);
+    }
+
     s =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0=
;
     return offsetof(VRingAvail, ring) +
         sizeof(uint16_t) * vdev->vq[n].vring.num + s;
@@ -2423,23 +3088,83 @@ hwaddr virtio_queue_get_used_size(VirtIODevice *v=
dev, int n)
 {
     int s;
=20
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return sizeof(struct VRingPackedDescEvent);
+    }
+
     s =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0=
;
     return offsetof(VRingUsed, ring) +
         sizeof(VRingUsedElem) * vdev->vq[n].vring.num + s;
 }
=20
-uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
+static unsigned int virtio_queue_packed_get_last_avail_idx(VirtIODevice =
*vdev,
+                                                           int n)
+{
+    unsigned int avail, used;
+
+    avail =3D vdev->vq[n].last_avail_idx;
+    avail |=3D ((uint16_t)vdev->vq[n].last_avail_wrap_counter) << 15;
+
+    used =3D vdev->vq[n].used_idx;
+    used |=3D ((uint16_t)vdev->vq[n].used_wrap_counter) << 15;
+
+    return avail | used << 16;
+}
+
+static uint16_t virtio_queue_split_get_last_avail_idx(VirtIODevice *vdev=
,
+                                                      int n)
 {
     return vdev->vq[n].last_avail_idx;
 }
=20
-void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t=
 idx)
+unsigned int virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
 {
-    vdev->vq[n].last_avail_idx =3D idx;
-    vdev->vq[n].shadow_avail_idx =3D idx;
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return virtio_queue_packed_get_last_avail_idx(vdev, n);
+    } else {
+        return virtio_queue_split_get_last_avail_idx(vdev, n);
+    }
 }
=20
-void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
+static void virtio_queue_packed_set_last_avail_idx(VirtIODevice *vdev,
+                                                   int n, unsigned int i=
dx)
+{
+    struct VirtQueue *vq =3D &vdev->vq[n];
+
+    vq->last_avail_idx =3D vq->shadow_avail_idx =3D idx & 0x7fff;
+    vq->last_avail_wrap_counter =3D
+        vq->shadow_avail_wrap_counter =3D !!(idx & 0x8000);
+    idx >>=3D 16;
+    vq->used_idx =3D idx & 0x7ffff;
+    vq->used_wrap_counter =3D !!(idx & 0x8000);
+}
+
+static void virtio_queue_split_set_last_avail_idx(VirtIODevice *vdev,
+                                                  int n, unsigned int id=
x)
+{
+        vdev->vq[n].last_avail_idx =3D idx;
+        vdev->vq[n].shadow_avail_idx =3D idx;
+}
+
+void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n,
+                                     unsigned int idx)
+{
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        virtio_queue_packed_set_last_avail_idx(vdev, n, idx);
+    } else {
+        virtio_queue_split_set_last_avail_idx(vdev, n, idx);
+    }
+}
+
+static void virtio_queue_packed_restore_last_avail_idx(VirtIODevice *vde=
v,
+                                                       int n)
+{
+    /* We don't have a reference like avail idx in shared memory */
+    return;
+}
+
+static void virtio_queue_split_restore_last_avail_idx(VirtIODevice *vdev=
,
+                                                      int n)
 {
     rcu_read_lock();
     if (vdev->vq[n].vring.desc) {
@@ -2449,7 +3174,22 @@ void virtio_queue_restore_last_avail_idx(VirtIODev=
ice *vdev, int n)
     rcu_read_unlock();
 }
=20
-void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
+void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
+{
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        virtio_queue_packed_restore_last_avail_idx(vdev, n);
+    } else {
+        virtio_queue_split_restore_last_avail_idx(vdev, n);
+    }
+}
+
+static void virtio_queue_packed_update_used_idx(VirtIODevice *vdev, int =
n)
+{
+    /* used idx was updated through set_last_avail_idx() */
+    return;
+}
+
+static void virtio_split_packed_update_used_idx(VirtIODevice *vdev, int =
n)
 {
     rcu_read_lock();
     if (vdev->vq[n].vring.desc) {
@@ -2458,6 +3198,15 @@ void virtio_queue_update_used_idx(VirtIODevice *vd=
ev, int n)
     rcu_read_unlock();
 }
=20
+void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
+{
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return virtio_queue_packed_update_used_idx(vdev, n);
+    } else {
+        return virtio_split_packed_update_used_idx(vdev, n);
+    }
+}
+
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n)
 {
     vdev->vq[n].signalled_used_valid =3D false;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 48e8d04ff6..d123d5b181 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -59,6 +59,8 @@ typedef struct VirtQueue VirtQueue;
 typedef struct VirtQueueElement
 {
     unsigned int index;
+    unsigned int len;
+    unsigned int ndescs;
     unsigned int out_num;
     unsigned int in_num;
     hwaddr *in_addr;
@@ -196,7 +198,8 @@ void virtqueue_map(VirtIODevice *vdev, VirtQueueEleme=
nt *elem);
 void *virtqueue_pop(VirtQueue *vq, size_t sz);
 unsigned int virtqueue_drop_all(VirtQueue *vq);
 void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t=
 sz);
-void qemu_put_virtqueue_element(QEMUFile *f, VirtQueueElement *elem);
+void qemu_put_virtqueue_element(VirtIODevice *vdev, QEMUFile *f,
+                                VirtQueueElement *elem);
 int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
                           unsigned int out_bytes);
 void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
@@ -291,8 +294,9 @@ hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev,=
 int n);
 hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n);
-uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n);
-void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t=
 idx);
+unsigned int virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n);
+void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n,
+                                     unsigned int idx);
 void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n);
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n);
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
--=20
MST


