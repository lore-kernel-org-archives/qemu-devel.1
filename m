Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADE1CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D42A20863
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D42A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUVR-0002FC-Ot
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iOTzM-00064S-Ju
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iOTzK-0003aj-FA
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:52:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iOTzK-0003aH-6L
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:52:46 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 47598A705
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 21:52:44 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id y10so6684355qti.1
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uEPlpaYxuYfVWP9srt2fxLna8qoXdy1ftu/MeQw6BLE=;
 b=dLdjp/MkvsuIGgpo6uc9zcncmIjQTDLwKJo5SEEmgRkyvnw19H6tuYOC6oGiejWcb/
 CF+3Pxq1PVjUBvVyhecQcrPO/2qcfEake4FyMADwPfpzBWDIUDFafH18cDwenulGTne+
 XwrjhIv1hWsfZmofyVBhwbc1B0eFuvVHNKZV99s9p/FUxFpx94d8ps6kYhJiho7ObiHV
 istCsw/hY74l5Sf72JfSSPcR/EILuHEkg6R/qZujTg1phkjutcZBejXhI9BwlPzJKY8I
 dtZ3bh2J4lXANR5l1G4JP5u8phJGAJog/jKP/HS5KI2hMuPXtR0A0NA2syVOIbguhQmU
 LuQA==
X-Gm-Message-State: APjAAAWzZ3InoOR27mSxKHTFQXN7Cm2/ZTeKF7u0V0jZauT15EsyWRws
 +QMtZkOeURL4+J8+MJQe6dDjxdEVCTz8YaoywbOifpym6twnP+bOXeDTCqVXlTqybpBJaSllED4
 2TIIAF+CcNvegRQo=
X-Received: by 2002:a37:b647:: with SMTP id g68mr9653963qkf.215.1572126763073; 
 Sat, 26 Oct 2019 14:52:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwDeYFHYCl5s8xgPHALWT+nlLdxwG1D9+O6vEhecLJap1oIQmIcklGOsLh98Czb8HNe8G/RUQ==
X-Received: by 2002:a37:b647:: with SMTP id g68mr9653940qkf.215.1572126762629; 
 Sat, 26 Oct 2019 14:52:42 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 a2sm3536316qkb.82.2019.10.26.14.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 14:52:41 -0700 (PDT)
Date: Sat, 26 Oct 2019 17:52:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/25] libqos: access VIRTIO 1.0 vring in little-endian
Message-ID: <20191026193824.11926-18-mst@redhat.com>
References: <20191026193824.11926-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026193824.11926-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

VIRTIO 1.0 uses little-endian for the vring.  Legacy VIRTIO uses guest
endianness.  Adjust the code to handle both.

Note that qvirtio_readq() is not defined because it has no users.  All
the other accessors are really needed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191023100425.12168-10-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/libqos/virtio-mmio.c |   1 +
 tests/libqos/virtio-pci.c  |   1 +
 tests/libqos/virtio.c      | 131 +++++++++++++++++++++++++++----------
 tests/libqos/virtio.h      |   4 +-
 tests/virtio-blk-test.c    |   8 +--
 5 files changed, 106 insertions(+), 39 deletions(-)

diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 78066e6e05..4db1f1b8bc 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -157,6 +157,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,
     uint64_t addr;
 
     vq = g_malloc0(sizeof(*vq));
+    vq->vdev = d;
     qvirtio_mmio_queue_select(d, index);
     qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_ALIGN, dev->page_size);
 
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 1b6b760fc6..7ecf5d0a52 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -217,6 +217,7 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
     feat = qvirtio_pci_get_guest_features(d);
 
     qvirtio_pci_queue_select(d, index);
+    vqpci->vq.vdev = d;
     vqpci->vq.index = index;
     vqpci->vq.size = qvirtio_pci_get_queue_size(d);
     vqpci->vq.free_head = 0;
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index fa597c2481..9aa360620c 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -8,11 +8,68 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "libqtest.h"
 #include "libqos/virtio.h"
 #include "standard-headers/linux/virtio_config.h"
 #include "standard-headers/linux/virtio_ring.h"
 
+/*
+ * qtest_readX/writeX() functions transfer host endian from/to guest endian.
+ * This works great for Legacy VIRTIO devices where we need guest endian
+ * accesses.  For VIRTIO 1.0 the vring is little-endian so the automatic guest
+ * endianness conversion is not wanted.
+ *
+ * The following qvirtio_readX/writeX() functions handle Legacy and VIRTIO 1.0
+ * accesses seamlessly.
+ */
+static uint16_t qvirtio_readw(QVirtioDevice *d, QTestState *qts, uint64_t addr)
+{
+    uint16_t val = qtest_readw(qts, addr);
+
+    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
+        val = bswap16(val);
+    }
+    return val;
+}
+
+static uint32_t qvirtio_readl(QVirtioDevice *d, QTestState *qts, uint64_t addr)
+{
+    uint32_t val = qtest_readl(qts, addr);
+
+    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
+        val = bswap32(val);
+    }
+    return val;
+}
+
+static void qvirtio_writew(QVirtioDevice *d, QTestState *qts,
+                           uint64_t addr, uint16_t val)
+{
+    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
+        val = bswap16(val);
+    }
+    qtest_writew(qts, addr, val);
+}
+
+static void qvirtio_writel(QVirtioDevice *d, QTestState *qts,
+                           uint64_t addr, uint32_t val)
+{
+    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
+        val = bswap32(val);
+    }
+    qtest_writel(qts, addr, val);
+}
+
+static void qvirtio_writeq(QVirtioDevice *d, QTestState *qts,
+                           uint64_t addr, uint64_t val)
+{
+    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
+        val = bswap64(val);
+    }
+    qtest_writeq(qts, addr, val);
+}
+
 uint8_t qvirtio_config_readb(QVirtioDevice *d, uint64_t addr)
 {
     g_assert_true(d->features_negotiated);
@@ -189,23 +246,23 @@ void qvring_init(QTestState *qts, const QGuestAllocator *alloc, QVirtQueue *vq,
 
     for (i = 0; i < vq->size - 1; i++) {
         /* vq->desc[i].addr */
-        qtest_writeq(qts, vq->desc + (16 * i), 0);
+        qvirtio_writeq(vq->vdev, qts, vq->desc + (16 * i), 0);
         /* vq->desc[i].next */
-        qtest_writew(qts, vq->desc + (16 * i) + 14, i + 1);
+        qvirtio_writew(vq->vdev, qts, vq->desc + (16 * i) + 14, i + 1);
     }
 
     /* vq->avail->flags */
-    qtest_writew(qts, vq->avail, 0);
+    qvirtio_writew(vq->vdev, qts, vq->avail, 0);
     /* vq->avail->idx */
-    qtest_writew(qts, vq->avail + 2, 0);
+    qvirtio_writew(vq->vdev, qts, vq->avail + 2, 0);
     /* vq->avail->used_event */
-    qtest_writew(qts, vq->avail + 4 + (2 * vq->size), 0);
+    qvirtio_writew(vq->vdev, qts, vq->avail + 4 + (2 * vq->size), 0);
 
     /* vq->used->flags */
-    qtest_writew(qts, vq->used, 0);
+    qvirtio_writew(vq->vdev, qts, vq->used, 0);
     /* vq->used->avail_event */
-    qtest_writew(qts, vq->used + 2 + sizeof(struct vring_used_elem) * vq->size,
-                 0);
+    qvirtio_writew(vq->vdev, qts, vq->used + 2 +
+                   sizeof(struct vring_used_elem) * vq->size, 0);
 }
 
 QVRingIndirectDesc *qvring_indirect_desc_setup(QTestState *qs, QVirtioDevice *d,
@@ -221,35 +278,39 @@ QVRingIndirectDesc *qvring_indirect_desc_setup(QTestState *qs, QVirtioDevice *d,
 
     for (i = 0; i < elem - 1; ++i) {
         /* indirect->desc[i].addr */
-        qtest_writeq(qs, indirect->desc + (16 * i), 0);
+        qvirtio_writeq(d, qs, indirect->desc + (16 * i), 0);
         /* indirect->desc[i].flags */
-        qtest_writew(qs, indirect->desc + (16 * i) + 12, VRING_DESC_F_NEXT);
+        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12,
+                       VRING_DESC_F_NEXT);
         /* indirect->desc[i].next */
-        qtest_writew(qs, indirect->desc + (16 * i) + 14, i + 1);
+        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, i + 1);
     }
 
     return indirect;
 }
 
-void qvring_indirect_desc_add(QTestState *qts, QVRingIndirectDesc *indirect,
+void qvring_indirect_desc_add(QVirtioDevice *d, QTestState *qts,
+                              QVRingIndirectDesc *indirect,
                               uint64_t data, uint32_t len, bool write)
 {
     uint16_t flags;
 
     g_assert_cmpint(indirect->index, <, indirect->elem);
 
-    flags = qtest_readw(qts, indirect->desc + (16 * indirect->index) + 12);
+    flags = qvirtio_readw(d, qts, indirect->desc +
+                                  (16 * indirect->index) + 12);
 
     if (write) {
         flags |= VRING_DESC_F_WRITE;
     }
 
     /* indirect->desc[indirect->index].addr */
-    qtest_writeq(qts, indirect->desc + (16 * indirect->index), data);
+    qvirtio_writeq(d, qts, indirect->desc + (16 * indirect->index), data);
     /* indirect->desc[indirect->index].len */
-    qtest_writel(qts, indirect->desc + (16 * indirect->index) + 8, len);
+    qvirtio_writel(d, qts, indirect->desc + (16 * indirect->index) + 8, len);
     /* indirect->desc[indirect->index].flags */
-    qtest_writew(qts, indirect->desc + (16 * indirect->index) + 12, flags);
+    qvirtio_writew(d, qts, indirect->desc + (16 * indirect->index) + 12,
+                   flags);
 
     indirect->index++;
 }
@@ -269,11 +330,11 @@ uint32_t qvirtqueue_add(QTestState *qts, QVirtQueue *vq, uint64_t data,
     }
 
     /* vq->desc[vq->free_head].addr */
-    qtest_writeq(qts, vq->desc + (16 * vq->free_head), data);
+    qvirtio_writeq(vq->vdev, qts, vq->desc + (16 * vq->free_head), data);
     /* vq->desc[vq->free_head].len */
-    qtest_writel(qts, vq->desc + (16 * vq->free_head) + 8, len);
+    qvirtio_writel(vq->vdev, qts, vq->desc + (16 * vq->free_head) + 8, len);
     /* vq->desc[vq->free_head].flags */
-    qtest_writew(qts, vq->desc + (16 * vq->free_head) + 12, flags);
+    qvirtio_writew(vq->vdev, qts, vq->desc + (16 * vq->free_head) + 12, flags);
 
     return vq->free_head++; /* Return and increase, in this order */
 }
@@ -288,13 +349,14 @@ uint32_t qvirtqueue_add_indirect(QTestState *qts, QVirtQueue *vq,
     vq->num_free--;
 
     /* vq->desc[vq->free_head].addr */
-    qtest_writeq(qts, vq->desc + (16 * vq->free_head), indirect->desc);
+    qvirtio_writeq(vq->vdev, qts, vq->desc + (16 * vq->free_head),
+                   indirect->desc);
     /* vq->desc[vq->free_head].len */
-    qtest_writel(qts, vq->desc + (16 * vq->free_head) + 8,
-           sizeof(struct vring_desc) * indirect->elem);
+    qvirtio_writel(vq->vdev, qts, vq->desc + (16 * vq->free_head) + 8,
+                   sizeof(struct vring_desc) * indirect->elem);
     /* vq->desc[vq->free_head].flags */
-    qtest_writew(qts, vq->desc + (16 * vq->free_head) + 12,
-                 VRING_DESC_F_INDIRECT);
+    qvirtio_writew(vq->vdev, qts, vq->desc + (16 * vq->free_head) + 12,
+                   VRING_DESC_F_INDIRECT);
 
     return vq->free_head++; /* Return and increase, in this order */
 }
@@ -303,21 +365,21 @@ void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
                      uint32_t free_head)
 {
     /* vq->avail->idx */
-    uint16_t idx = qtest_readw(qts, vq->avail + 2);
+    uint16_t idx = qvirtio_readw(d, qts, vq->avail + 2);
     /* vq->used->flags */
     uint16_t flags;
     /* vq->used->avail_event */
     uint16_t avail_event;
 
     /* vq->avail->ring[idx % vq->size] */
-    qtest_writew(qts, vq->avail + 4 + (2 * (idx % vq->size)), free_head);
+    qvirtio_writew(d, qts, vq->avail + 4 + (2 * (idx % vq->size)), free_head);
     /* vq->avail->idx */
-    qtest_writew(qts, vq->avail + 2, idx + 1);
+    qvirtio_writew(d, qts, vq->avail + 2, idx + 1);
 
     /* Must read after idx is updated */
-    flags = qtest_readw(qts, vq->avail);
-    avail_event = qtest_readw(qts, vq->used + 4 +
-                                   sizeof(struct vring_used_elem) * vq->size);
+    flags = qvirtio_readw(d, qts, vq->avail);
+    avail_event = qvirtio_readw(d, qts, vq->used + 4 +
+                                sizeof(struct vring_used_elem) * vq->size);
 
     /* < 1 because we add elements to avail queue one by one */
     if ((flags & VRING_USED_F_NO_NOTIFY) == 0 &&
@@ -342,7 +404,8 @@ bool qvirtqueue_get_buf(QTestState *qts, QVirtQueue *vq, uint32_t *desc_idx,
     uint16_t idx;
     uint64_t elem_addr, addr;
 
-    idx = qtest_readw(qts, vq->used + offsetof(struct vring_used, idx));
+    idx = qvirtio_readw(vq->vdev, qts,
+                        vq->used + offsetof(struct vring_used, idx));
     if (idx == vq->last_used_idx) {
         return false;
     }
@@ -354,12 +417,12 @@ bool qvirtqueue_get_buf(QTestState *qts, QVirtQueue *vq, uint32_t *desc_idx,
 
     if (desc_idx) {
         addr = elem_addr + offsetof(struct vring_used_elem, id);
-        *desc_idx = qtest_readl(qts, addr);
+        *desc_idx = qvirtio_readl(vq->vdev, qts, addr);
     }
 
     if (len) {
         addr = elem_addr + offsetof(struct vring_used_elem, len);
-        *len = qtest_readw(qts, addr);
+        *len = qvirtio_readw(vq->vdev, qts, addr);
     }
 
     vq->last_used_idx++;
@@ -371,7 +434,7 @@ void qvirtqueue_set_used_event(QTestState *qts, QVirtQueue *vq, uint16_t idx)
     g_assert(vq->event);
 
     /* vq->avail->used_event */
-    qtest_writew(qts, vq->avail + 4 + (2 * vq->size), idx);
+    qvirtio_writew(vq->vdev, qts, vq->avail + 4 + (2 * vq->size), idx);
 }
 
 void qvirtio_start_device(QVirtioDevice *vdev)
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 0e8f823c7b..ebbff5193b 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -27,6 +27,7 @@ typedef struct QVirtioDevice {
 } QVirtioDevice;
 
 typedef struct QVirtQueue {
+    QVirtioDevice *vdev;
     uint64_t desc; /* This points to an array of struct vring_desc */
     uint64_t avail; /* This points to a struct vring_avail */
     uint64_t used; /* This points to a struct vring_used */
@@ -135,7 +136,8 @@ void qvring_init(QTestState *qts, const QGuestAllocator *alloc, QVirtQueue *vq,
 QVRingIndirectDesc *qvring_indirect_desc_setup(QTestState *qs, QVirtioDevice *d,
                                                QGuestAllocator *alloc,
                                                uint16_t elem);
-void qvring_indirect_desc_add(QTestState *qts, QVRingIndirectDesc *indirect,
+void qvring_indirect_desc_add(QVirtioDevice *d, QTestState *qts,
+                              QVRingIndirectDesc *indirect,
                               uint64_t data, uint32_t len, bool write);
 uint32_t qvirtqueue_add(QTestState *qts, QVirtQueue *vq, uint64_t data,
                         uint32_t len, bool write, bool next);
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index fe0dc4a896..2a23698211 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -388,8 +388,8 @@ static void indirect(void *obj, void *u_data, QGuestAllocator *t_alloc)
     g_free(req.data);
 
     indirect = qvring_indirect_desc_setup(qts, dev, t_alloc, 2);
-    qvring_indirect_desc_add(qts, indirect, req_addr, 528, false);
-    qvring_indirect_desc_add(qts, indirect, req_addr + 528, 1, true);
+    qvring_indirect_desc_add(dev, qts, indirect, req_addr, 528, false);
+    qvring_indirect_desc_add(dev, qts, indirect, req_addr + 528, 1, true);
     free_head = qvirtqueue_add_indirect(qts, vq, indirect);
     qvirtqueue_kick(qts, dev, vq, free_head);
 
@@ -413,8 +413,8 @@ static void indirect(void *obj, void *u_data, QGuestAllocator *t_alloc)
     g_free(req.data);
 
     indirect = qvring_indirect_desc_setup(qts, dev, t_alloc, 2);
-    qvring_indirect_desc_add(qts, indirect, req_addr, 16, false);
-    qvring_indirect_desc_add(qts, indirect, req_addr + 16, 513, true);
+    qvring_indirect_desc_add(dev, qts, indirect, req_addr, 16, false);
+    qvring_indirect_desc_add(dev, qts, indirect, req_addr + 16, 513, true);
     free_head = qvirtqueue_add_indirect(qts, vq, indirect);
     qvirtqueue_kick(qts, dev, vq, free_head);
 
-- 
MST


