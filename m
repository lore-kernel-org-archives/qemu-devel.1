Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141CFCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7236214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7236214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUim-0001Vb-07
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iOTzh-0007yO-Ul
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iOTzg-0003fy-4m
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47370)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iOTzf-0003fd-2t
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:07 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7AE5183F40
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 21:53:05 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id g1so6519530qtp.19
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0+thIogjCVVkRsOOk+NaM1DB9Ez4R4OTz7Vkyt9+x4A=;
 b=mm09wnDIqxDvtktYJBmcIiHUVQ1LST+kDe6zxe4Og2UrdAEN4SEgEU4eOruUJibDf8
 7Q223Zmtqcn4eWT1wQvQN3xPP0/wWshOyqcb98EtoWg30SIOaFNOLRitEMHLHE64VqBj
 QVSP3XAQWQn/U4eHOcxw0A8qRFOhZn4N99CP6xvODQnqa6LTTXjc+PxaZatVeV8UatcH
 BPS6wCttdFlAgDlCPuWAATD0+zFAcRCK9IVVApE7nlaCLNO+PD8XsH/uBew5vVesuq9I
 wmYENJKAiOFb8ekWFsFDhp3N53oHZnYAEDfVOC+oqR+7nNLTfD+dqfp1wobRbR8FFqZL
 BSXA==
X-Gm-Message-State: APjAAAVUgfd7xngsRozV9EYoeUfzJdfeWnmC4J5yIdUftGtLBlfr5n9w
 4k2Zf83qTzVJeT6gA0kk2Lp6dp0UCzmnTtN7uAWyzC5HMNJqI6pbNewWoqB4pkpOkRRkaEVLvzr
 EGnDweNhx4dY6YP8=
X-Received: by 2002:a0c:95a1:: with SMTP id s30mr10485794qvs.110.1572126784489; 
 Sat, 26 Oct 2019 14:53:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqycGjEe4hnoPFewItQCNddKlGonXeuHDxIndy7xvdU9h8/UJUO+kEL35WewvaL0bV644clofQ==
X-Received: by 2002:a0c:95a1:: with SMTP id s30mr10485778qvs.110.1572126784263; 
 Sat, 26 Oct 2019 14:53:04 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 z72sm3317771qka.115.2019.10.26.14.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 14:53:03 -0700 (PDT)
Date: Sat, 26 Oct 2019 17:52:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/25] libqos: expose common virtqueue setup/cleanup functions
Message-ID: <20191026193824.11926-22-mst@redhat.com>
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

The VIRTIO 1.0 code will need to perform additional steps but it will
reuse the common virtqueue setup/cleanup code.  Make these functions
public.

Make sure to invoke callbacks via QVirtioBus instead of directly calling
the virtio-pci Legacy versions of these functions.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191023100425.12168-14-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/libqos/virtio-pci.c | 19 ++++++++++---------
 tests/libqos/virtio-pci.h |  8 ++++++++
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 0725777a8d..c900742f96 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -207,8 +207,9 @@ static void qvirtio_pci_set_queue_address(QVirtioDevice *d, QVirtQueue *vq)
     qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_PFN, pfn);
 }
 
-static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
-                                        QGuestAllocator *alloc, uint16_t index)
+QVirtQueue *qvirtio_pci_virtqueue_setup_common(QVirtioDevice *d,
+                                               QGuestAllocator *alloc,
+                                               uint16_t index)
 {
     uint64_t feat;
     uint64_t addr;
@@ -216,12 +217,12 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
     QVirtioPCIDevice *qvpcidev = container_of(d, QVirtioPCIDevice, vdev);
 
     vqpci = g_malloc0(sizeof(*vqpci));
-    feat = qvirtio_pci_get_guest_features(d);
+    feat = d->bus->get_guest_features(d);
 
-    qvirtio_pci_queue_select(d, index);
+    d->bus->queue_select(d, index);
     vqpci->vq.vdev = d;
     vqpci->vq.index = index;
-    vqpci->vq.size = qvirtio_pci_get_queue_size(d);
+    vqpci->vq.size = d->bus->get_queue_size(d);
     vqpci->vq.free_head = 0;
     vqpci->vq.num_free = vqpci->vq.size;
     vqpci->vq.align = VIRTIO_PCI_VRING_ALIGN;
@@ -241,12 +242,12 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
     addr = guest_alloc(alloc, qvring_size(vqpci->vq.size,
                                           VIRTIO_PCI_VRING_ALIGN));
     qvring_init(qvpcidev->pdev->bus->qts, alloc, &vqpci->vq, addr);
-    qvirtio_pci_set_queue_address(d, &vqpci->vq);
+    d->bus->set_queue_address(d, &vqpci->vq);
 
     return &vqpci->vq;
 }
 
-static void qvirtio_pci_virtqueue_cleanup(QVirtQueue *vq,
+void qvirtio_pci_virtqueue_cleanup_common(QVirtQueue *vq,
                                           QGuestAllocator *alloc)
 {
     QVirtQueuePCI *vqpci = container_of(vq, QVirtQueuePCI, vq);
@@ -276,8 +277,8 @@ const QVirtioBus qvirtio_pci = {
     .queue_select = qvirtio_pci_queue_select,
     .get_queue_size = qvirtio_pci_get_queue_size,
     .set_queue_address = qvirtio_pci_set_queue_address,
-    .virtqueue_setup = qvirtio_pci_virtqueue_setup,
-    .virtqueue_cleanup = qvirtio_pci_virtqueue_cleanup,
+    .virtqueue_setup = qvirtio_pci_virtqueue_setup_common,
+    .virtqueue_cleanup = qvirtio_pci_virtqueue_cleanup_common,
     .virtqueue_kick = qvirtio_pci_virtqueue_kick,
 };
 
diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 4299efc023..0e4a8b7b00 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -65,4 +65,12 @@ void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
                                         QGuestAllocator *alloc, uint16_t entry);
 void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
                                         QGuestAllocator *alloc, uint16_t entry);
+
+/* Used by Legacy and Modern virtio-pci code */
+QVirtQueue *qvirtio_pci_virtqueue_setup_common(QVirtioDevice *d,
+                                               QGuestAllocator *alloc,
+                                               uint16_t index);
+void qvirtio_pci_virtqueue_cleanup_common(QVirtQueue *vq,
+                                          QGuestAllocator *alloc);
+
 #endif
-- 
MST


