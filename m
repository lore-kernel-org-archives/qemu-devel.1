Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443CCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23247214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23247214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUlT-0003GZ-2c
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iOTzs-0000O6-A0
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iOTzr-0003im-06
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iOTzq-0003iF-Nu
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:18 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D657483F40
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 21:53:17 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id h4so6328723qkd.18
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=200A6pZsFeKYhAzQAYPGzKOt5B2pR+KCtMbv+3uRpio=;
 b=b2KoE2VDl3t/LTkVfxXctfHkEhTCl10bK48JJD2Kk7ye/EnWSFL4gTMJkD2bDyHUrC
 ldeR9jvC5gn6grktL4qsS7WRzJ1+F5cuJM8IR1ZbysRzSySje5y/3IVbvJwLA17flbNm
 O6eY8I7e0EsoJe+wANI2qec4HezIjbcEqiE4ayAEDBkCHghwiPkVz/QKfsGN2HovL91Y
 vSoEOpbGinDBh7X+3FcIuvi8WeUT32tvJDqzT/1S6jWNDGulvzJaYWIzk8WjPXMEHOmZ
 MFAEeR6N/bsT3I85IwCSmzHYsDwtHdkNynoYllDK8c0F5vwd8bxKMMN87iw9huYUUag4
 rstA==
X-Gm-Message-State: APjAAAU9m2EnJHPTPa6Ged/QotszU7ZXjOMUnzoVtExapQ6T1ou4mRfi
 84cGFPtuGnP6gxXSf0Cb07tcjKhz6f11mXaOwdJxvJelo839FepmFlc6/fla1+EpM3ed9zZoktR
 vfHLwrFThp5+TudE=
X-Received: by 2002:ac8:549:: with SMTP id c9mr10403906qth.178.1572126795441; 
 Sat, 26 Oct 2019 14:53:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5Bu4+OjfoVV6Y/rsEGNOcrU18Ag7/bwKwUNhp69/Yj8yjVaAgXQEyBOXIE+VmpQiYizs7Nw==
X-Received: by 2002:ac8:549:: with SMTP id c9mr10403894qth.178.1572126795142; 
 Sat, 26 Oct 2019 14:53:15 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 x38sm4556263qtc.64.2019.10.26.14.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 14:53:14 -0700 (PDT)
Date: Sat, 26 Oct 2019 17:53:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/25] libqos: extract Legacy virtio-pci.c code
Message-ID: <20191026193824.11926-24-mst@redhat.com>
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

The current libqos virtio-pci.c code implements the VIRTIO Legacy
interface.  Extract existing code in preparation for VIRTIO 1.0 support.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191023100425.12168-16-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/libqos/virtio-pci.c | 29 ++++++++++++-----------------
 tests/libqos/virtio-pci.h |  2 --
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index e9595603f5..11866f7772 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -35,14 +35,6 @@
  * original qvirtio_pci_destructor and qvirtio_pci_start_hw.
  */
=20
-static inline bool qvirtio_pci_is_big_endian(QVirtioPCIDevice *dev)
-{
-    QPCIBus *bus =3D dev->pdev->bus;
-
-    /* FIXME: virtio 1.0 is always little-endian */
-    return qtest_big_endian(bus->qts);
-}
-
 #define CONFIG_BASE(dev) (VIRTIO_PCI_CONFIG_OFF((dev)->pdev->msix_enable=
d))
=20
 static uint8_t qvirtio_pci_config_readb(QVirtioDevice *d, uint64_t off)
@@ -55,8 +47,7 @@ static uint8_t qvirtio_pci_config_readb(QVirtioDevice *=
d, uint64_t off)
  * but virtio ( < 1.0) is in guest order
  * so with a big-endian guest the order has been reversed,
  * reverse it again
- * virtio-1.0 is always little-endian, like PCI, but this
- * case will be managed inside qvirtio_pci_is_big_endian()
+ * virtio-1.0 is always little-endian, like PCI
  */
=20
 static uint16_t qvirtio_pci_config_readw(QVirtioDevice *d, uint64_t off)
@@ -262,7 +253,7 @@ static void qvirtio_pci_virtqueue_kick(QVirtioDevice =
*d, QVirtQueue *vq)
     qpci_io_writew(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_NOTIFY, vq->ind=
ex);
 }
=20
-const QVirtioBus qvirtio_pci =3D {
+static const QVirtioBus qvirtio_pci_legacy =3D {
     .config_readb =3D qvirtio_pci_config_readb,
     .config_readw =3D qvirtio_pci_config_readw,
     .config_readl =3D qvirtio_pci_config_readl,
@@ -396,17 +387,21 @@ void qvirtio_pci_start_hw(QOSGraphObject *obj)
     qvirtio_start_device(&dev->vdev);
 }
=20
-static void qvirtio_pci_init_from_pcidev(QVirtioPCIDevice *dev, QPCIDevi=
ce *pci_dev)
+static void qvirtio_pci_init_legacy(QVirtioPCIDevice *dev)
 {
-    dev->pdev =3D pci_dev;
-    dev->vdev.device_type =3D qpci_config_readw(pci_dev, PCI_SUBSYSTEM_I=
D);
+    dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUBSYSTEM=
_ID);
     dev->bar_idx =3D 0;
+    dev->vdev.bus =3D &qvirtio_pci_legacy;
+    dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
+    dev->vdev.big_endian =3D qtest_big_endian(dev->pdev->bus->qts);
+}
=20
+static void qvirtio_pci_init_from_pcidev(QVirtioPCIDevice *dev, QPCIDevi=
ce *pci_dev)
+{
+    dev->pdev =3D pci_dev;
     dev->config_msix_entry =3D -1;
-    dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
=20
-    dev->vdev.bus =3D &qvirtio_pci;
-    dev->vdev.big_endian =3D qvirtio_pci_is_big_endian(dev);
+    qvirtio_pci_init_legacy(dev);
=20
     /* each virtio-xxx-pci device should override at least this function=
 */
     dev->obj.get_driver =3D NULL;
diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 78a1c15c2a..6b3a385b06 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -45,8 +45,6 @@ typedef struct QVirtQueuePCI {
     uint32_t msix_data;
 } QVirtQueuePCI;
=20
-extern const QVirtioBus qvirtio_pci;
-
 void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress * =
addr);
 QVirtioPCIDevice *virtio_pci_new(QPCIBus *bus, QPCIAddress * addr);
=20
--=20
MST


