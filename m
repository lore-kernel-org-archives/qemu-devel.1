Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806BFCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4219321871
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4219321871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOS6p-0006Kz-FE
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 15:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iORv6-0001mQ-2I
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iORv4-0000lH-8s
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:40:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iORv4-0000l0-0Z
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:40:14 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24C0283F40
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 19:40:13 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id h9so6014754qkk.16
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 12:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bg6kcb6fwS3IqXA+pOQcgET9mHY2vz8LtBX9S9VBHXs=;
 b=K1+wNWiL82SkQZ8urxlnlsYouvY0nCdUVQV/HovSy2M+iQCG7YbnBv3hFpKZ9IRtS3
 WnTMBvrLv7auqdhyRuFU+bk9qeCOOORcuUhOHTvkKcGkbfbZHuku7B60roPAR5N3zV3/
 9jJamFd2JdoTq7K8WliskZtBcTDUzG9Da88qqn/rrvGPL0SwpTw1pAAXcAYVkz2oSAUc
 UlX73Pp32lsJSzm2S6Rm284IHbvOxiZ93UBGGjnq1q/nTTMRL0KlKKLE3aaVQCrnAVcU
 Zo34fhFOunAhQ6EnF2abo7IEFQYG3u35h5r8L/GLclyRYx671fqci7mvI5cSaU6EILsi
 A5gw==
X-Gm-Message-State: APjAAAVqpMT0+UseNaHE44VkwHrDpH7HYqKh9Q8jiwqKSSSfo4ERI+MP
 UgiSt8WeOc4TU1b4woIvCUQN4ea5hv/XsQZw2wR+Gq6SBZMwfFX87eR/OiUefrCKhRRn7xdIPXv
 V3lruUgl+v04w1Q8=
X-Received: by 2002:a0c:9083:: with SMTP id p3mr8592833qvp.210.1572118811850; 
 Sat, 26 Oct 2019 12:40:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCz8Ia0v4RsWUTc6wKPZy3+QtlJqlwtF9dZa9upN/Uh49odPgIZBRXQjw+bnJppwut+qV+Tw==
X-Received: by 2002:a0c:9083:: with SMTP id p3mr8592804qvp.210.1572118811484; 
 Sat, 26 Oct 2019 12:40:11 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 b18sm561556qkh.95.2019.10.26.12.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 12:40:10 -0700 (PDT)
Date: Sat, 26 Oct 2019 15:40:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/25] libqos: extend feature bits to 64-bit
Message-ID: <20191026193824.11926-12-mst@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

In VIRTIO 1.0 feature bits changed from 32-bit to 64-bit.  (In fact, the
transports allow even more feature bits but nothing uses more than 64
bits today.)

Add 64-bit feature bit support to virtio-mmio and virtio-pci.  This will
be necessary for VIRTIO 1.0 support.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191023100425.12168-4-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/libqos/virtio-mmio.c | 28 ++++++++++++++++++++++------
 tests/libqos/virtio-net.c  |  6 +++---
 tests/libqos/virtio-pci.c  | 12 ++++++------
 tests/libqos/virtio.c      |  4 ++--
 tests/libqos/virtio.h      | 12 ++++++------
 tests/virtio-blk-test.c    |  8 ++++----
 6 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 7154b03c1d..78066e6e05 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -40,22 +40,38 @@ static uint64_t qvirtio_mmio_config_readq(QVirtioDevi=
ce *d, uint64_t off)
     return qtest_readq(dev->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFI=
C + off);
 }
=20
-static uint32_t qvirtio_mmio_get_features(QVirtioDevice *d)
+static uint64_t qvirtio_mmio_get_features(QVirtioDevice *d)
 {
     QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vdev);
+    uint64_t lo;
+    uint64_t hi =3D 0;
+
     qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SEL, 0=
);
-    return qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES)=
;
+    lo =3D qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES)=
;
+
+    if (dev->version >=3D 2) {
+        qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SE=
L, 1);
+        hi =3D qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATU=
RES);
+    }
+
+    return (hi << 32) | lo;
 }
=20
-static void qvirtio_mmio_set_features(QVirtioDevice *d, uint32_t feature=
s)
+static void qvirtio_mmio_set_features(QVirtioDevice *d, uint64_t feature=
s)
 {
     QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vdev);
     dev->features =3D features;
     qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_SEL, =
0);
     qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES, feat=
ures);
+
+    if (dev->version >=3D 2) {
+        qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_S=
EL, 1);
+        qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES,
+                     features >> 32);
+    }
 }
=20
-static uint32_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
+static uint64_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
 {
     QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vdev);
     return dev->features;
@@ -149,8 +165,8 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirt=
ioDevice *d,
     vq->free_head =3D 0;
     vq->num_free =3D vq->size;
     vq->align =3D dev->page_size;
-    vq->indirect =3D (dev->features & (1u << VIRTIO_RING_F_INDIRECT_DESC=
)) !=3D 0;
-    vq->event =3D (dev->features & (1u << VIRTIO_RING_F_EVENT_IDX)) !=3D=
 0;
+    vq->indirect =3D dev->features & (1ull << VIRTIO_RING_F_INDIRECT_DES=
C);
+    vq->event =3D dev->features & (1ull << VIRTIO_RING_F_EVENT_IDX);
=20
     qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NUM, vq->size)=
;
=20
diff --git a/tests/libqos/virtio-net.c b/tests/libqos/virtio-net.c
index 6567beb553..710d440c3d 100644
--- a/tests/libqos/virtio-net.c
+++ b/tests/libqos/virtio-net.c
@@ -44,11 +44,11 @@ static void virtio_net_setup(QVirtioNet *interface)
=20
     features =3D qvirtio_get_features(vdev);
     features &=3D ~(QVIRTIO_F_BAD_FEATURE |
-                  (1u << VIRTIO_RING_F_INDIRECT_DESC) |
-                  (1u << VIRTIO_RING_F_EVENT_IDX));
+                  (1ull << VIRTIO_RING_F_INDIRECT_DESC) |
+                  (1ull << VIRTIO_RING_F_EVENT_IDX));
     qvirtio_set_features(vdev, features);
=20
-    if (features & (1u << VIRTIO_NET_F_MQ)) {
+    if (features & (1ull << VIRTIO_NET_F_MQ)) {
         interface->n_queues =3D qvirtio_config_readw(vdev, 8) * 2;
     } else {
         interface->n_queues =3D 2;
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 50499e75ef..1b6b760fc6 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -96,19 +96,19 @@ static uint64_t qvirtio_pci_config_readq(QVirtioDevic=
e *d, uint64_t off)
     return val;
 }
=20
-static uint32_t qvirtio_pci_get_features(QVirtioDevice *d)
+static uint64_t qvirtio_pci_get_features(QVirtioDevice *d)
 {
     QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
     return qpci_io_readl(dev->pdev, dev->bar, VIRTIO_PCI_HOST_FEATURES);
 }
=20
-static void qvirtio_pci_set_features(QVirtioDevice *d, uint32_t features=
)
+static void qvirtio_pci_set_features(QVirtioDevice *d, uint64_t features=
)
 {
     QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
     qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_GUEST_FEATURES, featu=
res);
 }
=20
-static uint32_t qvirtio_pci_get_guest_features(QVirtioDevice *d)
+static uint64_t qvirtio_pci_get_guest_features(QVirtioDevice *d)
 {
     QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
     return qpci_io_readl(dev->pdev, dev->bar, VIRTIO_PCI_GUEST_FEATURES)=
;
@@ -208,7 +208,7 @@ static void qvirtio_pci_set_queue_address(QVirtioDevi=
ce *d, uint32_t pfn)
 static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
                                         QGuestAllocator *alloc, uint16_t=
 index)
 {
-    uint32_t feat;
+    uint64_t feat;
     uint64_t addr;
     QVirtQueuePCI *vqpci;
     QVirtioPCIDevice *qvpcidev =3D container_of(d, QVirtioPCIDevice, vde=
v);
@@ -222,8 +222,8 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirti=
oDevice *d,
     vqpci->vq.free_head =3D 0;
     vqpci->vq.num_free =3D vqpci->vq.size;
     vqpci->vq.align =3D VIRTIO_PCI_VRING_ALIGN;
-    vqpci->vq.indirect =3D (feat & (1u << VIRTIO_RING_F_INDIRECT_DESC)) =
!=3D 0;
-    vqpci->vq.event =3D (feat & (1u << VIRTIO_RING_F_EVENT_IDX)) !=3D 0;
+    vqpci->vq.indirect =3D feat & (1ull << VIRTIO_RING_F_INDIRECT_DESC);
+    vqpci->vq.event =3D feat & (1ull << VIRTIO_RING_F_EVENT_IDX);
=20
     vqpci->msix_entry =3D -1;
     vqpci->msix_addr =3D 0;
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 0ae9956fc8..4f7e6bb8a1 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -33,12 +33,12 @@ uint64_t qvirtio_config_readq(QVirtioDevice *d, uint6=
4_t addr)
     return d->bus->config_readq(d, addr);
 }
=20
-uint32_t qvirtio_get_features(QVirtioDevice *d)
+uint64_t qvirtio_get_features(QVirtioDevice *d)
 {
     return d->bus->get_features(d);
 }
=20
-void qvirtio_set_features(QVirtioDevice *d, uint32_t features)
+void qvirtio_set_features(QVirtioDevice *d, uint64_t features)
 {
     d->features =3D features;
     d->bus->set_features(d, features);
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 2cb2448f46..a5c99fb3c9 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -13,7 +13,7 @@
 #include "libqos/malloc.h"
 #include "standard-headers/linux/virtio_ring.h"
=20
-#define QVIRTIO_F_BAD_FEATURE           0x40000000
+#define QVIRTIO_F_BAD_FEATURE           0x40000000ull
=20
 typedef struct QVirtioBus QVirtioBus;
=20
@@ -52,13 +52,13 @@ struct QVirtioBus {
     uint64_t (*config_readq)(QVirtioDevice *d, uint64_t addr);
=20
     /* Get features of the device */
-    uint32_t (*get_features)(QVirtioDevice *d);
+    uint64_t (*get_features)(QVirtioDevice *d);
=20
     /* Set features of the device */
-    void (*set_features)(QVirtioDevice *d, uint32_t features);
+    void (*set_features)(QVirtioDevice *d, uint64_t features);
=20
     /* Get features of the guest */
-    uint32_t (*get_guest_features)(QVirtioDevice *d);
+    uint64_t (*get_guest_features)(QVirtioDevice *d);
=20
     /* Get status of the device */
     uint8_t (*get_status)(QVirtioDevice *d);
@@ -103,8 +103,8 @@ uint8_t qvirtio_config_readb(QVirtioDevice *d, uint64=
_t addr);
 uint16_t qvirtio_config_readw(QVirtioDevice *d, uint64_t addr);
 uint32_t qvirtio_config_readl(QVirtioDevice *d, uint64_t addr);
 uint64_t qvirtio_config_readq(QVirtioDevice *d, uint64_t addr);
-uint32_t qvirtio_get_features(QVirtioDevice *d);
-void qvirtio_set_features(QVirtioDevice *d, uint32_t features);
+uint64_t qvirtio_get_features(QVirtioDevice *d);
+void qvirtio_set_features(QVirtioDevice *d, uint64_t features);
 bool qvirtio_is_big_endian(QVirtioDevice *d);
=20
 void qvirtio_reset(QVirtioDevice *d);
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index f6674fb233..31680cc159 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -119,7 +119,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllo=
cator *alloc,
     QVirtioBlkReq req;
     uint64_t req_addr;
     uint64_t capacity;
-    uint32_t features;
+    uint64_t features;
     uint32_t free_head;
     uint8_t status;
     char *data;
@@ -352,7 +352,7 @@ static void indirect(void *obj, void *u_data, QGuestA=
llocator *t_alloc)
     QVRingIndirectDesc *indirect;
     uint64_t req_addr;
     uint64_t capacity;
-    uint32_t features;
+    uint64_t features;
     uint32_t free_head;
     uint8_t status;
     char *data;
@@ -467,7 +467,7 @@ static void msix(void *obj, void *u_data, QGuestAlloc=
ator *t_alloc)
     int n_size =3D TEST_IMAGE_SIZE / 2;
     uint64_t req_addr;
     uint64_t capacity;
-    uint32_t features;
+    uint64_t features;
     uint32_t free_head;
     uint8_t status;
     char *data;
@@ -574,7 +574,7 @@ static void idx(void *obj, void *u_data, QGuestAlloca=
tor *t_alloc)
     QVirtioBlkReq req;
     uint64_t req_addr;
     uint64_t capacity;
-    uint32_t features;
+    uint64_t features;
     uint32_t free_head;
     uint32_t write_head;
     uint32_t desc_idx;
--=20
MST


