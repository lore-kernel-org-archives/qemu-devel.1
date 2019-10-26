Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4717FCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A01214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A01214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOU28-0000mi-S0
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 17:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iOTzX-0006zV-4S
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iOTzV-0003dh-Bo
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:52:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53924)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iOTzU-0003c6-In
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:52:57 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A4BE3330276
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 21:52:54 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id m189so6351898qkc.7
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=tXGJp+rCCgyjcVmn+mwC2du6Xae9aaVCkOjM2+F9SkY=;
 b=oW1VgZux+OyEESxeUPFxI1oYv1JkFQXlaM1Cozof+aPEIU544/GOhKtChFO3uSI7Tz
 +24Hi0dZTOBskDkIXLn1X8jbndg9LNk3/aCJRs6AN49zf9g4h84xrK1qd1ox7wwyKlVi
 k8eVW2sSOzIwGj73k5y+QfQgkNjIT3PQvKSwWQkTj4Ycf+RMqkGtK1PtQNh5JLUS+pn4
 51woZfPRb5CZUQPCRmj2vqARlDSR39l/taO9MgnengPy3LxU/b13M8pGhVkSa/jLhUhZ
 h66s4VeGvKF70K/Wda/ad/uozu3WI0cCi9KuZMnAkM4IhKj7VhfpocPeSlgl1cN4ttop
 t1sQ==
X-Gm-Message-State: APjAAAUAfxOPOQs+iZ4/zUAKEL8u+3FkqHyXr1QeQcImd+KVChlANi4M
 iR+YWHSAwBJ+j04h8JhrqOIOP+74dxTlTmtLrXe4U14N9pjD3U4Xz1Ldw0phurgT7XnJ4swU7cG
 ziKlf0ISRZTzNt8g=
X-Received: by 2002:ac8:45d0:: with SMTP id e16mr10270107qto.8.1572126773684; 
 Sat, 26 Oct 2019 14:52:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxk4z47Qvzp9Rif43s6sZchs1PBgqQ2EAPTZMq+aKGh3k4QsLKHOep/aHyJsKOlpeE/oOPUjQ==
X-Received: by 2002:ac8:45d0:: with SMTP id e16mr10270095qto.8.1572126773485; 
 Sat, 26 Oct 2019 14:52:53 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 j6sm3834148qkc.31.2019.10.26.14.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 14:52:52 -0700 (PDT)
Date: Sat, 26 Oct 2019 17:52:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/25] libqos: pass full QVirtQueue to set_queue_address()
Message-ID: <20191026193824.11926-20-mst@redhat.com>
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
 Sergio Lopez <slp@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Instead of just passing the vring page frame number, pass the full
QVirtQueue.  This will allow the VIRTIO 1.0 transport to program the
fine-grained vring address registers in the future.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191023100425.12168-12-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/libqos/virtio-mmio.c | 6 ++++--
 tests/libqos/virtio-pci.c  | 6 ++++--
 tests/libqos/virtio.h      | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 4db1f1b8bc..e0a2bd7bc6 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -143,9 +143,11 @@ static uint16_t qvirtio_mmio_get_queue_size(QVirtioD=
evice *d)
     return (uint16_t)qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_QUEU=
E_NUM_MAX);
 }
=20
-static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, uint32_t pf=
n)
+static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, QVirtQueue =
*vq)
 {
     QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vdev);
+    uint64_t pfn =3D vq->desc / dev->page_size;
+
     qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
 }
=20
@@ -179,7 +181,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirt=
ioDevice *d,
=20
     addr =3D guest_alloc(alloc, qvring_size(vq->size, dev->page_size));
     qvring_init(dev->qts, alloc, vq, addr);
-    qvirtio_mmio_set_queue_address(d, vq->desc / dev->page_size);
+    qvirtio_mmio_set_queue_address(d, vq);
=20
     return vq;
 }
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 7ecf5d0a52..e4fa318dcc 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -199,9 +199,11 @@ static uint16_t qvirtio_pci_get_queue_size(QVirtioDe=
vice *d)
     return qpci_io_readw(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_NUM);
 }
=20
-static void qvirtio_pci_set_queue_address(QVirtioDevice *d, uint32_t pfn=
)
+static void qvirtio_pci_set_queue_address(QVirtioDevice *d, QVirtQueue *=
vq)
 {
     QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+    uint64_t pfn =3D vq->desc / VIRTIO_PCI_VRING_ALIGN;
+
     qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_PFN, pfn);
 }
=20
@@ -239,7 +241,7 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirti=
oDevice *d,
     addr =3D guest_alloc(alloc, qvring_size(vqpci->vq.size,
                                           VIRTIO_PCI_VRING_ALIGN));
     qvring_init(qvpcidev->pdev->bus->qts, alloc, &vqpci->vq, addr);
-    qvirtio_pci_set_queue_address(d, vqpci->vq.desc / VIRTIO_PCI_VRING_A=
LIGN);
+    qvirtio_pci_set_queue_address(d, &vqpci->vq);
=20
     return &vqpci->vq;
 }
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index ebbff5193b..529ef7555a 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -81,7 +81,7 @@ struct QVirtioBus {
     uint16_t (*get_queue_size)(QVirtioDevice *d);
=20
     /* Set the address of the selected queue */
-    void (*set_queue_address)(QVirtioDevice *d, uint32_t pfn);
+    void (*set_queue_address)(QVirtioDevice *d, QVirtQueue *vq);
=20
     /* Setup the virtqueue specified by index */
     QVirtQueue *(*virtqueue_setup)(QVirtioDevice *d, QGuestAllocator *al=
loc,
--=20
MST


