Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED811CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC350214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC350214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOU4N-0001Jb-HO
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 17:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iOTzd-0007Pl-9Q
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iOTzb-0003f0-A9
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iOTzZ-0003eR-AG
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:03 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 15535C049E10
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 21:53:00 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id k67so6388468qkc.3
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/MkpAHK2Hskh7ImAHNPKaD4E2/muC8lHemAshCkwGhQ=;
 b=RUdTDxpiX6jvUM/70M9Cb0Ut0IP1F08IUQhc293m5YcLSuaLj+wXPbPE2KvSuDCHmJ
 5CIFXMHiO38mhvicP9puZ62Kya7oflO6fjnkSsRWurPsn68cu/vPvQa7JaTw2qmmWFX0
 O2gvu0ybrQPHnXGLwgWDai5YyngIMJ/UxwlgEHl0gX6l7PEylcqJUSR0VJlgCIWMr48H
 yZKQvWjCTgLbP93EW5FkXzcdPk63PfU50KoDaCOSG8yvRVCfcY9qzBO2Uu1eO+18wr27
 XDKl58FGZKjhBxhAFqOtsJd7gdPhKIW6P63nq+yqWM+KBuG2NrAfltq0oup7HyNe444I
 o0aw==
X-Gm-Message-State: APjAAAVQ9a5VOd49Zmo3UYNBj9gMh3Eq5F/1LTwfr8qUVatWIYeJtRCj
 oZC5AZsMKxJUyJVUA0oXyP84buygH83ogdL6pmhLOhmn9tcxpN2eh6PKEdhAQcn18DkMhonmnav
 bjO5bMUizqyyRtRw=
X-Received: by 2002:a37:7904:: with SMTP id u4mr9306702qkc.267.1572126778798; 
 Sat, 26 Oct 2019 14:52:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAzx1qIgCzYr9e4d27a90G5Z+OB39mlgo9BglGyG1wWfhsHVigqqNuYwhaJcZlhSYS7khCgA==
X-Received: by 2002:a37:7904:: with SMTP id u4mr9306683qkc.267.1572126778473; 
 Sat, 26 Oct 2019 14:52:58 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 t1sm3553913qkt.87.2019.10.26.14.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 14:52:57 -0700 (PDT)
Date: Sat, 26 Oct 2019 17:52:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/25] libqos: add MSI-X callbacks to QVirtioPCIDevice
Message-ID: <20191026193824.11926-21-mst@redhat.com>
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

The MSI-X vectors are programmed differently in the VIRTIO 1.0 and
Legacy interfaces.  Introduce callbacks so different implementations can
be used depending on the interface version.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191023100425.12168-13-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/libqos/virtio-pci.c | 37 ++++++++++++++++++++++++++++---------
 tests/libqos/virtio-pci.h | 12 ++++++++++++
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index e4fa318dcc..0725777a8d 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -281,6 +281,31 @@ const QVirtioBus qvirtio_pci = {
     .virtqueue_kick = qvirtio_pci_virtqueue_kick,
 };
 
+static void qvirtio_pci_set_config_vector(QVirtioPCIDevice *d, uint16_t entry)
+{
+    uint16_t vector;
+
+    qpci_io_writew(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR, entry);
+    vector = qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR);
+    g_assert_cmphex(vector, !=, VIRTIO_MSI_NO_VECTOR);
+}
+
+static void qvirtio_pci_set_queue_vector(QVirtioPCIDevice *d, uint16_t vq_idx,
+                                         uint16_t entry)
+{
+    uint16_t vector;
+
+    qvirtio_pci_queue_select(&d->vdev, vq_idx);
+    qpci_io_writew(d->pdev, d->bar, VIRTIO_MSI_QUEUE_VECTOR, entry);
+    vector = qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_QUEUE_VECTOR);
+    g_assert_cmphex(vector, !=, VIRTIO_MSI_NO_VECTOR);
+}
+
+static const QVirtioPCIMSIXOps qvirtio_pci_msix_ops_legacy = {
+    .set_config_vector = qvirtio_pci_set_config_vector,
+    .set_queue_vector = qvirtio_pci_set_queue_vector,
+};
+
 void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
 {
     qpci_device_enable(d->pdev);
@@ -295,7 +320,6 @@ void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
 void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
                                         QGuestAllocator *alloc, uint16_t entry)
 {
-    uint16_t vector;
     uint32_t control;
     uint64_t off;
 
@@ -321,16 +345,12 @@ void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
                    off + PCI_MSIX_ENTRY_VECTOR_CTRL,
                    control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
-    qvirtio_pci_queue_select(&d->vdev, vqpci->vq.index);
-    qpci_io_writew(d->pdev, d->bar, VIRTIO_MSI_QUEUE_VECTOR, entry);
-    vector = qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_QUEUE_VECTOR);
-    g_assert_cmphex(vector, !=, VIRTIO_MSI_NO_VECTOR);
+    d->msix_ops->set_queue_vector(d, vqpci->vq.index, entry);
 }
 
 void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
                                         QGuestAllocator *alloc, uint16_t entry)
 {
-    uint16_t vector;
     uint32_t control;
     uint64_t off;
 
@@ -358,9 +378,7 @@ void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
                    off + PCI_MSIX_ENTRY_VECTOR_CTRL,
                    control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
-    qpci_io_writew(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR, entry);
-    vector = qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR);
-    g_assert_cmphex(vector, !=, VIRTIO_MSI_NO_VECTOR);
+    d->msix_ops->set_config_vector(d, entry);
 }
 
 void qvirtio_pci_destructor(QOSGraphObject *obj)
@@ -383,6 +401,7 @@ static void qvirtio_pci_init_from_pcidev(QVirtioPCIDevice *dev, QPCIDevice *pci_
     dev->vdev.device_type = qpci_config_readw(pci_dev, PCI_SUBSYSTEM_ID);
 
     dev->config_msix_entry = -1;
+    dev->msix_ops = &qvirtio_pci_msix_ops_legacy;
 
     dev->vdev.bus = &qvirtio_pci;
     dev->vdev.big_endian = qvirtio_pci_is_big_endian(dev);
diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 728b4715f1..4299efc023 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -14,16 +14,28 @@
 #include "libqos/pci.h"
 #include "libqos/qgraph.h"
 
+typedef struct QVirtioPCIMSIXOps QVirtioPCIMSIXOps;
+
 typedef struct QVirtioPCIDevice {
     QOSGraphObject obj;
     QVirtioDevice vdev;
     QPCIDevice *pdev;
     QPCIBar bar;
+    const QVirtioPCIMSIXOps *msix_ops;
     uint16_t config_msix_entry;
     uint64_t config_msix_addr;
     uint32_t config_msix_data;
 } QVirtioPCIDevice;
 
+struct QVirtioPCIMSIXOps {
+    /* Set the Configuration Vector for MSI-X */
+    void (*set_config_vector)(QVirtioPCIDevice *d, uint16_t entry);
+
+    /* Set the Queue Vector for MSI-X */
+    void (*set_queue_vector)(QVirtioPCIDevice *d, uint16_t vq_idx,
+                             uint16_t entry);
+};
+
 typedef struct QVirtQueuePCI {
     QVirtQueue vq;
     uint16_t msix_entry;
-- 
MST


