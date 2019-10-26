Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B840CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5879214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5879214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUnK-0008CN-UL
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iOTzy-0000uL-8V
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iOTzv-0003jV-UN
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53105)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iOTzv-0003jE-KM
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:23 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A9BA85AFE3
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 21:53:22 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id k67so6388948qkc.3
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JbSzVWuqQ6QP5EzNef2zotBYCyp0rg5tRI50px6nvws=;
 b=ki3jq2dgMkm7IDKNtlexxRl/mZE5S5cFLknjdxD525K91dKcsqJ9h5wy40MWlflb1y
 Uam8wfgazfMmxMEK8LkcPJZVvEvbosfPnGYDehiX6c1hCPDfxpXeiZdpkMs7h7ZvQzZc
 0x9GlTUZdSqoeHY5j9anxIdMv6O2yAGACeTCUHK/rp7eNzzA+gUaGwtWjUbco6ycTrrR
 31YU+17uHmXGJfADzm9mW056fT1dpuhjnOkB2oM474308C7n/vi888/pUmtksLL7dpL/
 vLrlwrPkIpucltVArHmtlA08946cZ/IHZqxSiJAvogTpH73F7WRvwnlvyuv/jXAFeVqD
 a1+w==
X-Gm-Message-State: APjAAAU1j0CJUldTKgiR9DdAtHw8V1eGNpRe4BPcrC4Pw/uH9pqXVEXh
 YmDRW+08x1g7pVwhl9LBi7dltcNAP81ab8a/ofa/aB6Og5IZo+2nouV9btbzWtzZ9HspEJSagWn
 dMKt1pL/qUBzHUIY=
X-Received: by 2002:ac8:518f:: with SMTP id c15mr10228518qtn.352.1572126801322; 
 Sat, 26 Oct 2019 14:53:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzxdGDqMGsTIlL7zUc8wxb6X7MikvjUST2leWFgyyjY8C+AYiiPVIhZMXFN7VCmYXhLIRAF8A==
X-Received: by 2002:ac8:518f:: with SMTP id c15mr10228497qtn.352.1572126800816; 
 Sat, 26 Oct 2019 14:53:20 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 q64sm3644551qkb.32.2019.10.26.14.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 14:53:20 -0700 (PDT)
Date: Sat, 26 Oct 2019 17:53:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/25] libqos: add VIRTIO PCI 1.0 support
Message-ID: <20191026193824.11926-25-mst@redhat.com>
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
 Sergio Lopez <slp@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Implement the VIRTIO 1.0 virtio-pci interface.  The main change here is
that the register layout is no longer a fixed layout in BAR 0.  Instead
we have to iterate of PCI Capabilities to find descriptions of where
various registers are located.  The vring registers are also more
fine-grained, allowing for more flexible vring layouts, but we don't
take advantage of that.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Message-Id: <20191023100425.12168-17-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include           |   1 +
 tests/libqos/virtio-pci-modern.c | 443 +++++++++++++++++++++++++++++++
 tests/libqos/virtio-pci-modern.h |  17 ++
 tests/libqos/virtio-pci.c        |   6 +-
 tests/libqos/virtio-pci.h        |  10 +
 5 files changed, 476 insertions(+), 1 deletion(-)
 create mode 100644 tests/libqos/virtio-pci-modern.c
 create mode 100644 tests/libqos/virtio-pci-modern.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 09e5b410dc..fde8a0c5ef 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -723,6 +723,7 @@ qos-test-obj-y += tests/libqos/virtio-blk.o
 qos-test-obj-y += tests/libqos/virtio-mmio.o
 qos-test-obj-y += tests/libqos/virtio-net.o
 qos-test-obj-y += tests/libqos/virtio-pci.o
+qos-test-obj-y += tests/libqos/virtio-pci-modern.o
 qos-test-obj-y += tests/libqos/virtio-rng.o
 qos-test-obj-y += tests/libqos/virtio-scsi.o
 qos-test-obj-y += tests/libqos/virtio-serial.o
diff --git a/tests/libqos/virtio-pci-modern.c b/tests/libqos/virtio-pci-modern.c
new file mode 100644
index 0000000000..18d118866f
--- /dev/null
+++ b/tests/libqos/virtio-pci-modern.c
@@ -0,0 +1,443 @@
+/*
+ * libqos VIRTIO 1.0 PCI driver
+ *
+ * Copyright (c) 2019 Red Hat, Inc
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "standard-headers/linux/pci_regs.h"
+#include "standard-headers/linux/virtio_pci.h"
+#include "standard-headers/linux/virtio_config.h"
+#include "virtio-pci-modern.h"
+
+static uint8_t config_readb(QVirtioDevice *d, uint64_t addr)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+    return qpci_io_readb(dev->pdev, dev->bar, dev->device_cfg_offset + addr);
+}
+
+static uint16_t config_readw(QVirtioDevice *d, uint64_t addr)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+    return qpci_io_readw(dev->pdev, dev->bar, dev->device_cfg_offset + addr);
+}
+
+static uint32_t config_readl(QVirtioDevice *d, uint64_t addr)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+    return qpci_io_readl(dev->pdev, dev->bar, dev->device_cfg_offset + addr);
+}
+
+static uint64_t config_readq(QVirtioDevice *d, uint64_t addr)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+    return qpci_io_readq(dev->pdev, dev->bar, dev->device_cfg_offset + addr);
+}
+
+static uint64_t get_features(QVirtioDevice *d)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+    uint64_t lo, hi;
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg,
+                            device_feature_select),
+                   0);
+    lo = qpci_io_readl(dev->pdev, dev->bar, dev->common_cfg_offset +
+                       offsetof(struct virtio_pci_common_cfg, device_feature));
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg,
+                            device_feature_select),
+                   1);
+    hi = qpci_io_readl(dev->pdev, dev->bar, dev->common_cfg_offset +
+                       offsetof(struct virtio_pci_common_cfg, device_feature));
+
+    return (hi << 32) | lo;
+}
+
+static void set_features(QVirtioDevice *d, uint64_t features)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+
+    /* Drivers must enable VIRTIO 1.0 or else use the Legacy interface */
+    g_assert_cmphex(features & (1ull << VIRTIO_F_VERSION_1), !=, 0);
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg,
+                            guest_feature_select),
+                   0);
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg,
+                            guest_feature),
+                   features);
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg,
+                            guest_feature_select),
+                   1);
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg,
+                            guest_feature),
+                   features >> 32);
+}
+
+static uint64_t get_guest_features(QVirtioDevice *d)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+    uint64_t lo, hi;
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg,
+                            guest_feature_select),
+                   0);
+    lo = qpci_io_readl(dev->pdev, dev->bar, dev->common_cfg_offset +
+                       offsetof(struct virtio_pci_common_cfg, guest_feature));
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg,
+                            guest_feature_select),
+                   1);
+    hi = qpci_io_readl(dev->pdev, dev->bar, dev->common_cfg_offset +
+                       offsetof(struct virtio_pci_common_cfg, guest_feature));
+
+    return (hi << 32) | lo;
+}
+
+static uint8_t get_status(QVirtioDevice *d)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+
+    return qpci_io_readb(dev->pdev, dev->bar, dev->common_cfg_offset +
+                         offsetof(struct virtio_pci_common_cfg,
+                                  device_status));
+}
+
+static void set_status(QVirtioDevice *d, uint8_t status)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+
+    return qpci_io_writeb(dev->pdev, dev->bar, dev->common_cfg_offset +
+                          offsetof(struct virtio_pci_common_cfg,
+                                   device_status),
+                          status);
+}
+
+static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
+                            uint32_t msix_addr, uint32_t msix_data)
+{
+    uint32_t data;
+
+    g_assert_cmpint(msix_entry, !=, -1);
+    if (qpci_msix_masked(dev->pdev, msix_entry)) {
+        /* No ISR checking should be done if masked, but read anyway */
+        return qpci_msix_pending(dev->pdev, msix_entry);
+    }
+
+    data = qtest_readl(dev->pdev->bus->qts, msix_addr);
+    if (data == msix_data) {
+        qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
+        return true;
+    } else {
+        return false;
+    }
+}
+
+static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+
+    if (dev->pdev->msix_enabled) {
+        QVirtQueuePCI *vqpci = container_of(vq, QVirtQueuePCI, vq);
+
+        return get_msix_status(dev, vqpci->msix_entry, vqpci->msix_addr,
+                               vqpci->msix_data);
+    }
+
+    return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 1;
+}
+
+static bool get_config_isr_status(QVirtioDevice *d)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+
+    if (dev->pdev->msix_enabled) {
+        return get_msix_status(dev, dev->config_msix_entry,
+                               dev->config_msix_addr, dev->config_msix_data);
+    }
+
+    return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 2;
+}
+
+static void wait_config_isr_status(QVirtioDevice *d, gint64 timeout_us)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+    gint64 start_time = g_get_monotonic_time();
+
+    do {
+        g_assert(g_get_monotonic_time() - start_time <= timeout_us);
+        qtest_clock_step(dev->pdev->bus->qts, 100);
+    } while (!get_config_isr_status(d));
+}
+
+static void queue_select(QVirtioDevice *d, uint16_t index)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+
+    qpci_io_writew(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_select),
+                   index);
+}
+
+static uint16_t get_queue_size(QVirtioDevice *d)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+
+    return qpci_io_readw(dev->pdev, dev->bar, dev->common_cfg_offset +
+                         offsetof(struct virtio_pci_common_cfg, queue_size));
+}
+
+static void set_queue_address(QVirtioDevice *d, QVirtQueue *vq)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_desc_lo),
+                   vq->desc);
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_desc_hi),
+                   vq->desc >> 32);
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_avail_lo),
+                   vq->avail);
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_avail_hi),
+                   vq->avail >> 32);
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_used_lo),
+                   vq->used);
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_used_hi),
+                   vq->used >> 32);
+}
+
+static QVirtQueue *virtqueue_setup(QVirtioDevice *d, QGuestAllocator *alloc,
+                                   uint16_t index)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+    QVirtQueue *vq;
+    QVirtQueuePCI *vqpci;
+    uint16_t notify_off;
+
+    vq = qvirtio_pci_virtqueue_setup_common(d, alloc, index);
+    vqpci = container_of(vq, QVirtQueuePCI, vq);
+
+    notify_off = qpci_io_readw(dev->pdev, dev->bar, dev->common_cfg_offset +
+                               offsetof(struct virtio_pci_common_cfg,
+                                        queue_notify_off));
+
+    vqpci->notify_offset = dev->notify_cfg_offset +
+                           notify_off * dev->notify_off_multiplier;
+
+    qpci_io_writew(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_enable), 1);
+
+    return vq;
+}
+
+static void virtqueue_kick(QVirtioDevice *d, QVirtQueue *vq)
+{
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
+    QVirtQueuePCI *vqpci = container_of(vq, QVirtQueuePCI, vq);
+
+    qpci_io_writew(dev->pdev, dev->bar, vqpci->notify_offset, vq->index);
+}
+
+static const QVirtioBus qvirtio_pci_virtio_1 = {
+    .config_readb = config_readb,
+    .config_readw = config_readw,
+    .config_readl = config_readl,
+    .config_readq = config_readq,
+    .get_features = get_features,
+    .set_features = set_features,
+    .get_guest_features = get_guest_features,
+    .get_status = get_status,
+    .set_status = set_status,
+    .get_queue_isr_status = get_queue_isr_status,
+    .wait_config_isr_status = wait_config_isr_status,
+    .queue_select = queue_select,
+    .get_queue_size = get_queue_size,
+    .set_queue_address = set_queue_address,
+    .virtqueue_setup = virtqueue_setup,
+    .virtqueue_cleanup = qvirtio_pci_virtqueue_cleanup_common,
+    .virtqueue_kick = virtqueue_kick,
+};
+
+static void set_config_vector(QVirtioPCIDevice *d, uint16_t entry)
+{
+    uint16_t vector;
+
+    qpci_io_writew(d->pdev, d->bar, d->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, msix_config), entry);
+    vector = qpci_io_readw(d->pdev, d->bar, d->common_cfg_offset +
+                           offsetof(struct virtio_pci_common_cfg,
+                                    msix_config));
+    g_assert_cmphex(vector, !=, VIRTIO_MSI_NO_VECTOR);
+}
+
+static void set_queue_vector(QVirtioPCIDevice *d, uint16_t vq_idx,
+                             uint16_t entry)
+{
+    uint16_t vector;
+
+    queue_select(&d->vdev, vq_idx);
+    qpci_io_writew(d->pdev, d->bar, d->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_msix_vector),
+                   entry);
+    vector = qpci_io_readw(d->pdev, d->bar, d->common_cfg_offset +
+                           offsetof(struct virtio_pci_common_cfg,
+                                    queue_msix_vector));
+    g_assert_cmphex(vector, !=, VIRTIO_MSI_NO_VECTOR);
+}
+
+static const QVirtioPCIMSIXOps qvirtio_pci_msix_ops_virtio_1 = {
+    .set_config_vector = set_config_vector,
+    .set_queue_vector = set_queue_vector,
+};
+
+static bool probe_device_type(QVirtioPCIDevice *dev)
+{
+    uint16_t vendor_id;
+    uint16_t device_id;
+
+    /* "Drivers MUST match devices with the PCI Vendor ID 0x1AF4" */
+    vendor_id = qpci_config_readw(dev->pdev, PCI_VENDOR_ID);
+    if (vendor_id != 0x1af4) {
+        return false;
+    }
+
+    /*
+     * "Any PCI device with ... PCI Device ID 0x1000 through 0x107F inclusive
+     * is a virtio device"
+     */
+    device_id = qpci_config_readw(dev->pdev, PCI_DEVICE_ID);
+    if (device_id < 0x1000 || device_id > 0x107f) {
+        return false;
+    }
+
+    /*
+     * "Devices MAY utilize a Transitional PCI Device ID range, 0x1000 to
+     * 0x103F depending on the device type"
+     */
+    if (device_id < 0x1040) {
+        /*
+         * "Transitional devices MUST have the PCI Subsystem Device ID matching
+         * the Virtio Device ID"
+         */
+        dev->vdev.device_type = qpci_config_readw(dev->pdev, PCI_SUBSYSTEM_ID);
+    } else {
+        /*
+         * "The PCI Device ID is calculated by adding 0x1040 to the Virtio
+         * Device ID"
+         */
+        dev->vdev.device_type = device_id - 0x1040;
+    }
+
+    return true;
+}
+
+/* Find the first VIRTIO 1.0 PCI structure for a given type */
+static bool find_structure(QVirtioPCIDevice *dev, uint8_t cfg_type,
+                           uint8_t *bar, uint32_t *offset, uint32_t *length,
+                           uint8_t *cfg_addr)
+{
+    uint8_t addr = 0;
+
+    while ((addr = qpci_find_capability(dev->pdev, PCI_CAP_ID_VNDR,
+                                        addr)) != 0) {
+        uint8_t type;
+
+        type = qpci_config_readb(dev->pdev,
+                addr + offsetof(struct virtio_pci_cap, cfg_type));
+        if (type != cfg_type) {
+            continue;
+        }
+
+        *bar = qpci_config_readb(dev->pdev,
+                addr + offsetof(struct virtio_pci_cap, bar));
+        *offset = qpci_config_readl(dev->pdev,
+                addr + offsetof(struct virtio_pci_cap, offset));
+        *length = qpci_config_readl(dev->pdev,
+                addr + offsetof(struct virtio_pci_cap, length));
+        if (cfg_addr) {
+            *cfg_addr = addr;
+        }
+
+        return true;
+    }
+
+    return false;
+}
+
+static bool probe_device_layout(QVirtioPCIDevice *dev)
+{
+    uint8_t bar;
+    uint8_t cfg_addr;
+    uint32_t length;
+
+    /*
+     * Due to the qpci_iomap() API we only support devices that put all
+     * structures in the same PCI BAR.  Luckily this is true with QEMU.
+     */
+
+    if (!find_structure(dev, VIRTIO_PCI_CAP_COMMON_CFG, &bar,
+                        &dev->common_cfg_offset, &length, NULL)) {
+        return false;
+    }
+    dev->bar_idx = bar;
+
+    if (!find_structure(dev, VIRTIO_PCI_CAP_NOTIFY_CFG, &bar,
+                        &dev->notify_cfg_offset, &length, &cfg_addr)) {
+        return false;
+    }
+    g_assert_cmphex(bar, ==, dev->bar_idx);
+
+    dev->notify_off_multiplier = qpci_config_readl(dev->pdev,
+            cfg_addr + offsetof(struct virtio_pci_notify_cap,
+                                notify_off_multiplier));
+
+    if (!find_structure(dev, VIRTIO_PCI_CAP_ISR_CFG, &bar,
+                        &dev->isr_cfg_offset, &length, NULL)) {
+        return false;
+    }
+    g_assert_cmphex(bar, ==, dev->bar_idx);
+
+    if (!find_structure(dev, VIRTIO_PCI_CAP_DEVICE_CFG, &bar,
+                        &dev->device_cfg_offset, &length, NULL)) {
+        return false;
+    }
+    g_assert_cmphex(bar, ==, dev->bar_idx);
+
+    return true;
+}
+
+/* Probe a VIRTIO 1.0 device */
+bool qvirtio_pci_init_virtio_1(QVirtioPCIDevice *dev)
+{
+    if (!probe_device_type(dev)) {
+        return false;
+    }
+
+    if (!probe_device_layout(dev)) {
+        return false;
+    }
+
+    dev->vdev.bus = &qvirtio_pci_virtio_1;
+    dev->msix_ops = &qvirtio_pci_msix_ops_virtio_1;
+    dev->vdev.big_endian = false;
+    return true;
+}
diff --git a/tests/libqos/virtio-pci-modern.h b/tests/libqos/virtio-pci-modern.h
new file mode 100644
index 0000000000..6bf2b207c3
--- /dev/null
+++ b/tests/libqos/virtio-pci-modern.h
@@ -0,0 +1,17 @@
+/*
+ * libqos virtio PCI VIRTIO 1.0 definitions
+ *
+ * Copyright (c) 2019 Red Hat, Inc
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef LIBQOS_VIRTIO_PCI_MODERN_H
+#define LIBQOS_VIRTIO_PCI_MODERN_H
+
+#include "virtio-pci.h"
+
+bool qvirtio_pci_init_virtio_1(QVirtioPCIDevice *dev);
+
+#endif /* LIBQOS_VIRTIO_PCI_MODERN_H */
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 11866f7772..62851c29bb 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -22,6 +22,8 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_regs.h"
 
+#include "virtio-pci-modern.h"
+
 /* virtio-pci is a superclass of all virtio-xxx-pci devices;
  * the relation between virtio-pci and virtio-xxx-pci is implicit,
  * and therefore virtio-pci does not produce virtio and is not
@@ -401,7 +403,9 @@ static void qvirtio_pci_init_from_pcidev(QVirtioPCIDevice *dev, QPCIDevice *pci_
     dev->pdev = pci_dev;
     dev->config_msix_entry = -1;
 
-    qvirtio_pci_init_legacy(dev);
+    if (!qvirtio_pci_init_virtio_1(dev)) {
+        qvirtio_pci_init_legacy(dev);
+    }
 
     /* each virtio-xxx-pci device should override at least this function */
     dev->obj.get_driver = NULL;
diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 6b3a385b06..294d5567ee 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -27,6 +27,13 @@ typedef struct QVirtioPCIDevice {
     uint32_t config_msix_data;
 
     int bar_idx;
+
+    /* VIRTIO 1.0 */
+    uint32_t common_cfg_offset;
+    uint32_t notify_cfg_offset;
+    uint32_t notify_off_multiplier;
+    uint32_t isr_cfg_offset;
+    uint32_t device_cfg_offset;
 } QVirtioPCIDevice;
 
 struct QVirtioPCIMSIXOps {
@@ -43,6 +50,9 @@ typedef struct QVirtQueuePCI {
     uint16_t msix_entry;
     uint64_t msix_addr;
     uint32_t msix_data;
+
+    /* VIRTIO 1.0 */
+    uint64_t notify_offset;
 } QVirtQueuePCI;
 
 void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress * addr);
-- 
MST


