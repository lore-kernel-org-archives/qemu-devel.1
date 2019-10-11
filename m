Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3251C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0872089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0872089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iItzo-0007Bk-L2
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 08:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iItyL-00064x-TI
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iItyJ-0004BN-EN
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:24:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iItyJ-0004B8-4z
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:24:39 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE414368DA
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 12:24:37 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id j125so4027525wmj.6
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 05:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=P8hDv5LaRNlamqm4Fa6Ubt/2c34q6VdK2ipMGxpdII8=;
 b=P6oWBsu4qbmUd9qKM35TDxk99Jmh0lyggf4Gl/ohbtpQvVhFEl0pwGA3DWQzZ6zmo+
 ZOySn0qGMJ8gqCqQyoKdo0Of2Uo6xcsM8RRATcjiSiGGOanVn6XHHio1TF8jq1nxRbvp
 VrIbuyiyc48sY8yI2dhbeeKYWPhfrJcwgJWtjoGLv9No/vJAU/oP+HjJkaLoSE4SQsug
 oW3igG9QGKcYMxt7nmd9z4d1w1YmM1UuCs2UOJMcVqqvX5UwlAP29ekEQ/omQwlTkL/G
 9OTAIJUm4NZZoGE/jF1H/+mdF0CAbNZi6LZ0AK5xuqEyeygF9ZHb4vkP+MWzl4FpplBd
 /uDg==
X-Gm-Message-State: APjAAAX5XWz4RCLUY0q+955z0zQWgu/tmX90TrpWkHcvaGlVjMwhV80W
 DAdBI5+oP1Qy15JhqMI4scbKzP8Sth2wKuGDqidRDrK/HxOGe6+AEoSysVSsMIwpyorjexWHgoH
 +8JS54tvMSn9MCgc=
X-Received: by 2002:adf:9c81:: with SMTP id d1mr12434093wre.238.1570796676291; 
 Fri, 11 Oct 2019 05:24:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxU1BXwfF4YGx3Gko5UdlxWP8PfQykVx/pVaGcEi8KH2v04KDgSCrKcKTMugvOAC8qO0Tqmhg==
X-Received: by 2002:adf:9c81:: with SMTP id d1mr12434059wre.238.1570796675923; 
 Fri, 11 Oct 2019 05:24:35 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id v11sm7937324wml.30.2019.10.11.05.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 05:24:35 -0700 (PDT)
References: <20191011085611.4194-1-stefanha@redhat.com>
 <20191011085611.4194-8-stefanha@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 7/7] libqos: add VIRTIO PCI 1.0 support
In-reply-to: <20191011085611.4194-8-stefanha@redhat.com>
Date: Fri, 11 Oct 2019 14:24:33 +0200
Message-ID: <87wodbbhby.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Stefan Hajnoczi <stefanha@redhat.com> writes:

> Implement the VIRTIO 1.0 virtio-pci interface.  The main change here is
> that the register layout is no longer a fixed layout in BAR 0.  Instead
> we have to iterate of PCI Capabilities to find descriptions of where
> various registers are located.  The vring registers are also more
> fine-grained, allowing for more flexible vring layouts, but we don't
> take advantage of that.
>
> Note that test cases do not negotiate VIRTIO_F_VERSION_1 yet and are
> therefore not running in VIRTIO 1.0 mode.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/Makefile.include           |   1 +
>  tests/libqos/virtio-pci-modern.h |  17 ++
>  tests/libqos/virtio-pci.h        |  10 +
>  tests/libqos/virtio-pci-modern.c | 412 +++++++++++++++++++++++++++++++
>  tests/libqos/virtio-pci.c        |   6 +-
>  5 files changed, 445 insertions(+), 1 deletion(-)
>  create mode 100644 tests/libqos/virtio-pci-modern.h
>  create mode 100644 tests/libqos/virtio-pci-modern.c
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3543451ed3..3f633c8313 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -715,6 +715,7 @@ qos-test-obj-y +=3D tests/libqos/virtio-blk.o
>  qos-test-obj-y +=3D tests/libqos/virtio-mmio.o
>  qos-test-obj-y +=3D tests/libqos/virtio-net.o
>  qos-test-obj-y +=3D tests/libqos/virtio-pci.o
> +qos-test-obj-y +=3D tests/libqos/virtio-pci-modern.o
>  qos-test-obj-y +=3D tests/libqos/virtio-rng.o
>  qos-test-obj-y +=3D tests/libqos/virtio-scsi.o
>  qos-test-obj-y +=3D tests/libqos/virtio-serial.o
> diff --git a/tests/libqos/virtio-pci-modern.h b/tests/libqos/virtio-pci-m=
odern.h
> new file mode 100644
> index 0000000000..6bf2b207c3
> --- /dev/null
> +++ b/tests/libqos/virtio-pci-modern.h
> @@ -0,0 +1,17 @@
> +/*
> + * libqos virtio PCI VIRTIO 1.0 definitions
> + *
> + * Copyright (c) 2019 Red Hat, Inc
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef LIBQOS_VIRTIO_PCI_MODERN_H
> +#define LIBQOS_VIRTIO_PCI_MODERN_H
> +
> +#include "virtio-pci.h"
> +
> +bool qvirtio_pci_init_virtio_1(QVirtioPCIDevice *dev);
> +
> +#endif /* LIBQOS_VIRTIO_PCI_MODERN_H */
> diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
> index f2d53aa377..29d4e9bf79 100644
> --- a/tests/libqos/virtio-pci.h
> +++ b/tests/libqos/virtio-pci.h
> @@ -27,6 +27,13 @@ typedef struct QVirtioPCIDevice {
>      uint32_t config_msix_data;
>=20=20
>      uint8_t bar_idx;
> +
> +    /* VIRTIO 1.0 */
> +    uint32_t common_cfg_offset;
> +    uint32_t notify_cfg_offset;
> +    uint32_t notify_off_multiplier;
> +    uint32_t isr_cfg_offset;
> +    uint32_t device_cfg_offset;
>  } QVirtioPCIDevice;
>=20=20
>  struct QVirtioPCIMSIXOps {
> @@ -43,6 +50,9 @@ typedef struct QVirtQueuePCI {
>      uint16_t msix_entry;
>      uint64_t msix_addr;
>      uint32_t msix_data;
> +
> +    /* VIRTIO 1.0 */
> +    uint64_t notify_offset;
>  } QVirtQueuePCI;
>=20=20
>  void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress * =
addr);
> diff --git a/tests/libqos/virtio-pci-modern.c b/tests/libqos/virtio-pci-m=
odern.c
> new file mode 100644
> index 0000000000..f23c876290
> --- /dev/null
> +++ b/tests/libqos/virtio-pci-modern.c
> @@ -0,0 +1,412 @@
> +/*
> + * libqos VIRTIO 1.0 PCI driver
> + *
> + * Copyright (c) 2019 Red Hat, Inc
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "standard-headers/linux/pci_regs.h"
> +#include "standard-headers/linux/virtio_pci.h"
> +#include "virtio-pci-modern.h"
> +
> +static uint8_t config_readb(QVirtioDevice *d, uint64_t addr)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +    return qpci_io_readb(dev->pdev, dev->bar, dev->device_cfg_offset + a=
ddr);
> +}
> +
> +static uint16_t config_readw(QVirtioDevice *d, uint64_t addr)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +    return qpci_io_readw(dev->pdev, dev->bar, dev->device_cfg_offset + a=
ddr);
> +}
> +
> +static uint32_t config_readl(QVirtioDevice *d, uint64_t addr)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +    return qpci_io_readl(dev->pdev, dev->bar, dev->device_cfg_offset + a=
ddr);
> +}
> +
> +static uint64_t config_readq(QVirtioDevice *d, uint64_t addr)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +    return qpci_io_readq(dev->pdev, dev->bar, dev->device_cfg_offset + a=
ddr);
> +}
> +
> +static uint32_t get_features(QVirtioDevice *d)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +
> +    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg,
> +                            device_feature_select),
> +                   0);
> +    return qpci_io_readl(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                         offsetof(struct virtio_pci_common_cfg,
> +                                  device_feature));
> +}
> +
> +static void set_features(QVirtioDevice *d, uint32_t features)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +
> +    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg,
> +                            guest_feature_select),
> +                   0);
> +    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg,
> +                            guest_feature),
> +                   features);
> +}
> +
> +static uint32_t get_guest_features(QVirtioDevice *d)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +
> +    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg,
> +                            guest_feature_select),
> +                   0);
> +    return qpci_io_readl(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                         offsetof(struct virtio_pci_common_cfg,
> +                                  guest_feature));
> +}
> +
> +static uint8_t get_status(QVirtioDevice *d)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +
> +    return qpci_io_readb(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                         offsetof(struct virtio_pci_common_cfg,
> +                                  device_status));
> +}
> +
> +static void set_status(QVirtioDevice *d, uint8_t status)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +
> +    return qpci_io_writeb(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                          offsetof(struct virtio_pci_common_cfg,
> +                                   device_status),
> +                          status);
> +}
> +
> +static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
> +                            uint32_t msix_addr, uint32_t msix_data)
> +{
> +    uint32_t data;
> +
> +    g_assert_cmpint(msix_entry, !=3D, -1);
> +    if (qpci_msix_masked(dev->pdev, msix_entry)) {
> +        /* No ISR checking should be done if masked, but read anyway */
> +        return qpci_msix_pending(dev->pdev, msix_entry);
> +    }
> +
> +    data =3D qtest_readl(dev->pdev->bus->qts, msix_addr);
> +    if (data =3D=3D msix_data) {
> +        qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
> +        return true;
> +    } else {
> +        return false;
> +    }
> +}
> +
> +static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +
> +    if (dev->pdev->msix_enabled) {
> +        QVirtQueuePCI *vqpci =3D container_of(vq, QVirtQueuePCI, vq);
> +
> +        return get_msix_status(dev, vqpci->msix_entry, vqpci->msix_addr,
> +                               vqpci->msix_data);
> +    }
> +
> +    return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 1;
> +}
> +
> +static bool get_config_isr_status(QVirtioDevice *d)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +
> +    if (dev->pdev->msix_enabled) {
> +        return get_msix_status(dev, dev->config_msix_entry,
> +                               dev->config_msix_addr, dev->config_msix_d=
ata);
> +    }
> +
> +    return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 2;
> +}
> +
> +static void wait_config_isr_status(QVirtioDevice *d, gint64 timeout_us)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +    gint64 start_time =3D g_get_monotonic_time();
> +
> +    do {
> +        g_assert(g_get_monotonic_time() - start_time <=3D timeout_us);
> +        qtest_clock_step(dev->pdev->bus->qts, 100);
> +    } while (!get_config_isr_status(d));
> +}
> +
> +static void queue_select(QVirtioDevice *d, uint16_t index)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +
> +    qpci_io_writew(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg, queue_select),
> +                   index);
> +}
> +
> +static uint16_t get_queue_size(QVirtioDevice *d)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +
> +    return qpci_io_readw(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                         offsetof(struct virtio_pci_common_cfg, queue_si=
ze));
> +}
> +
> +static void set_queue_address(QVirtioDevice *d, QVirtQueue *vq)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +
> +    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg, queue_desc_lo),
> +                   vq->desc);
> +    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg, queue_desc_hi),
> +                   vq->desc >> 32);
> +
> +    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg, queue_avail_lo=
),
> +                   vq->avail);
> +    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg, queue_avail_hi=
),
> +                   vq->avail >> 32);
> +
> +    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg, queue_used_lo),
> +                   vq->used);
> +    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg, queue_used_hi),
> +                   vq->used >> 32);
> +}
> +
> +static QVirtQueue *virtqueue_setup(QVirtioDevice *d, QGuestAllocator *al=
loc,
> +                                   uint16_t index)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +    QVirtQueue *vq;
> +    QVirtQueuePCI *vqpci;
> +    uint16_t notify_off;
> +
> +    vq =3D qvirtio_pci_virtqueue_setup_common(d, alloc, index);
> +    vqpci =3D container_of(vq, QVirtQueuePCI, vq);
> +
> +    notify_off =3D qpci_io_readw(dev->pdev, dev->bar, dev->common_cfg_of=
fset +
> +                               offsetof(struct virtio_pci_common_cfg,
> +                                        queue_notify_off));
> +
> +    vqpci->notify_offset =3D dev->notify_cfg_offset +
> +                           notify_off * dev->notify_off_multiplier;
> +
> +    qpci_io_writew(dev->pdev, dev->bar, dev->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg, queue_enable),=
 1);
> +
> +    return vq;
> +}
> +
> +static void virtqueue_kick(QVirtioDevice *d, QVirtQueue *vq)
> +{
> +    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +    QVirtQueuePCI *vqpci =3D container_of(vq, QVirtQueuePCI, vq);
> +
> +    qpci_io_writew(dev->pdev, dev->bar, vqpci->notify_offset, vq->index);
> +}
> +
> +static const QVirtioBus qvirtio_pci_virtio_1 =3D {
> +    .config_readb =3D config_readb,
> +    .config_readw =3D config_readw,
> +    .config_readl =3D config_readl,
> +    .config_readq =3D config_readq,
> +    .get_features =3D get_features,
> +    .set_features =3D set_features,
> +    .get_guest_features =3D get_guest_features,
> +    .get_status =3D get_status,
> +    .set_status =3D set_status,
> +    .get_queue_isr_status =3D get_queue_isr_status,
> +    .wait_config_isr_status =3D wait_config_isr_status,
> +    .queue_select =3D queue_select,
> +    .get_queue_size =3D get_queue_size,
> +    .set_queue_address =3D set_queue_address,
> +    .virtqueue_setup =3D virtqueue_setup,
> +    .virtqueue_cleanup =3D qvirtio_pci_virtqueue_cleanup_common,
> +    .virtqueue_kick =3D virtqueue_kick,
> +};
> +
> +static void set_config_vector(QVirtioPCIDevice *d, uint16_t entry)
> +{
> +    uint16_t vector;
> +
> +    qpci_io_writew(d->pdev, d->bar, d->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg, msix_config), =
entry);
> +    vector =3D qpci_io_readw(d->pdev, d->bar, d->common_cfg_offset +
> +                           offsetof(struct virtio_pci_common_cfg,
> +                                    msix_config));
> +    g_assert_cmphex(vector, !=3D, VIRTIO_MSI_NO_VECTOR);
> +}
> +
> +static void set_queue_vector(QVirtioPCIDevice *d, uint16_t vq_idx,
> +                             uint16_t entry)
> +{
> +    uint16_t vector;
> +
> +    queue_select(&d->vdev, vq_idx);
> +    qpci_io_writew(d->pdev, d->bar, d->common_cfg_offset +
> +                   offsetof(struct virtio_pci_common_cfg, queue_msix_vec=
tor),
> +                   entry);
> +    vector =3D qpci_io_readw(d->pdev, d->bar, d->common_cfg_offset +
> +                           offsetof(struct virtio_pci_common_cfg,
> +                                    queue_msix_vector));
> +    g_assert_cmphex(vector, !=3D, VIRTIO_MSI_NO_VECTOR);
> +}
> +
> +static const QVirtioPCIMSIXOps qvirtio_pci_msix_ops_virtio_1 =3D {
> +    .set_config_vector =3D set_config_vector,
> +    .set_queue_vector =3D set_queue_vector,
> +};
> +
> +static bool probe_device_type(QVirtioPCIDevice *dev)
> +{
> +    uint16_t vendor_id;
> +    uint16_t device_id;
> +
> +    /* "Drivers MUST match devices with the PCI Vendor ID 0x1AF4" */
> +    vendor_id =3D qpci_config_readw(dev->pdev, PCI_VENDOR_ID);
> +    if (vendor_id !=3D 0x1af4) {
> +        return false;
> +    }
> +
> +    /*
> +     * "Any PCI device with ... PCI Device ID 0x1000 through 0x107F incl=
usive
> +     * is a virtio device"
> +     */
> +    device_id =3D qpci_config_readw(dev->pdev, PCI_DEVICE_ID);
> +    if (device_id < 0x1000 || device_id > 0x107f) {
> +        return false;
> +    }
> +
> +    /*
> +     * "Devices MAY utilize a Transitional PCI Device ID range, 0x1000 to
> +     * 0x103F depending on the device type"
> +     */
> +    if (device_id < 0x1040) {
> +        /*
> +         * "Transitional devices MUST have the PCI Subsystem Device ID m=
atching
> +         * the Virtio Device ID"
> +         */
> +        dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUBSY=
STEM_ID);
> +    } else {
> +        /*
> +         * "The PCI Device ID is calculated by adding 0x1040 to the Virt=
io
> +         * Device ID"
> +         */
> +        dev->vdev.device_type =3D device_id - 0x1040;
> +    }
> +
> +    return true;
> +}
> +
> +/* Find the first VIRTIO 1.0 PCI structure for a given type */
> +static bool find_structure(QVirtioPCIDevice *dev, uint8_t cfg_type,
> +                           uint8_t *bar, uint32_t *offset, uint32_t *len=
gth,
> +                           uint8_t *cfg_addr)
> +{
> +    uint8_t addr =3D 0;
> +
> +    while ((addr =3D qpci_find_capability(dev->pdev, PCI_CAP_ID_VNDR,
> +                                        addr)) !=3D 0) {
> +        uint8_t type;
> +
> +        type =3D qpci_config_readb(dev->pdev,
> +                addr + offsetof(struct virtio_pci_cap, cfg_type));
> +        if (type !=3D cfg_type) {
> +            continue;
> +        }
> +
> +        *bar =3D qpci_config_readb(dev->pdev,
> +                addr + offsetof(struct virtio_pci_cap, bar));
> +        *offset =3D qpci_config_readl(dev->pdev,
> +                addr + offsetof(struct virtio_pci_cap, offset));
> +        *length =3D qpci_config_readl(dev->pdev,
> +                addr + offsetof(struct virtio_pci_cap, length));
> +        if (cfg_addr) {
> +            *cfg_addr =3D addr;
> +        }
> +
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static bool probe_device_layout(QVirtioPCIDevice *dev)
> +{
> +    uint8_t bar;
> +    uint8_t cfg_addr;
> +    uint32_t length;
> +
> +    /*
> +     * Due to the qpci_iomap() API we only support devices that put all
> +     * structures in the same PCI BAR.  Luckily this is true with QEMU.
> +     */
> +
> +    if (!find_structure(dev, VIRTIO_PCI_CAP_COMMON_CFG, &dev->bar_idx,
> +                        &dev->common_cfg_offset, &length, NULL)) {
> +        return false;
> +    }
> +
> +    if (!find_structure(dev, VIRTIO_PCI_CAP_NOTIFY_CFG, &bar,
> +                        &dev->notify_cfg_offset, &length, &cfg_addr)) {
> +        return false;
> +    }
> +    g_assert_cmphex(bar, =3D=3D, dev->bar_idx);
> +
> +    dev->notify_off_multiplier =3D qpci_config_readl(dev->pdev,
> +            cfg_addr + offsetof(struct virtio_pci_notify_cap,
> +                                notify_off_multiplier));
> +
> +    if (!find_structure(dev, VIRTIO_PCI_CAP_ISR_CFG, &bar,
> +                        &dev->isr_cfg_offset, &length, NULL)) {
> +        return false;
> +    }
> +    g_assert_cmphex(bar, =3D=3D, dev->bar_idx);
> +
> +    if (!find_structure(dev, VIRTIO_PCI_CAP_DEVICE_CFG, &bar,
> +                        &dev->device_cfg_offset, &length, NULL)) {
> +        return false;
> +    }
> +    g_assert_cmphex(bar, =3D=3D, dev->bar_idx);
> +
> +    return true;
> +}
> +
> +/* Probe a VIRTIO 1.0 device */
> +bool qvirtio_pci_init_virtio_1(QVirtioPCIDevice *dev)
> +{
> +    if (!probe_device_type(dev)) {
> +        return false;
> +    }
> +
> +    if (!probe_device_layout(dev)) {
> +        return false;
> +    }
> +
> +    dev->vdev.bus =3D &qvirtio_pci_virtio_1;
> +    dev->msix_ops =3D &qvirtio_pci_msix_ops_virtio_1;
> +    dev->vdev.big_endian =3D false;
> +    return true;
> +}
> diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
> index efd8caee18..5bdf403351 100644
> --- a/tests/libqos/virtio-pci.c
> +++ b/tests/libqos/virtio-pci.c
> @@ -22,6 +22,8 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_regs.h"
>=20=20
> +#include "virtio-pci-modern.h"
> +
>  /* virtio-pci is a superclass of all virtio-xxx-pci devices;
>   * the relation between virtio-pci and virtio-xxx-pci is implicit,
>   * and therefore virtio-pci does not produce virtio and is not
> @@ -400,7 +402,9 @@ static void qvirtio_pci_init_from_pcidev(QVirtioPCIDe=
vice *dev, QPCIDevice *pci_
>      dev->pdev =3D pci_dev;
>      dev->config_msix_entry =3D -1;
>=20=20
> -    qvirtio_pci_init_legacy(dev);
> +    if (!qvirtio_pci_init_virtio_1(dev)) {
> +        qvirtio_pci_init_legacy(dev);
> +    }
>=20=20
>      /* each virtio-xxx-pci device should override at least this function=
 */
>      dev->obj.get_driver =3D NULL;

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2gdIEACgkQ9GknjS8M
AjUY0g//Q2yQCuJLGeBSrGG6vWNUGYoQrwp+48j2qqPdcjyNZRbvl4baePQzknyF
kEw8oNpiIJaHEl1OPzp1Qfqx4O/5Uq1U/iM4BysMcSdY07f++4qA5IeUA5oZVsLd
tpKvtX8wQTr4HCqXTHsi2oqvEXdSUgKrhTQDfXurZdZKwV8Q3V8sZaffi5LCC/J2
wmCYL9hRs+N1FNCAigpYi0TBMIUV3Me1k0OD1iIxb5lV71035FtRCuqrgs2i8D4q
rfWwf52kcLERbiLAgq/i+4lpQ83CJeEvTO9UkCe0ZmPUwVrz/DPiu/TpXDfhj8up
Btq97Och9gBMPb873ReIVJhIC+0VXlGlpksn4U9YtTIX8LE4G9U7Wk1YqHFB6fHi
Jva6Pcyla0uXld8kfNaKxkoYtS3B0tCrOF1tcx3qEiW4EMH/nmu46SOIRPa1VdXl
fWbtR2zKC+Q+2YUTKReflFQQ7avgJNQcA0a1BOE0dDhueCypO9FpfyrciIS0lWBb
nanWEgYfqT8GzasontFnIoke8jzHHZazAmZ1OrFvS5DMMCrKs6asbex0w/plAFt+
8LnvDAeKY/XnF3UbKfWig1VEwDz0aBhBqJ+zYVWQ9ogE3CrRZZHWi2MRbdb2soNT
5oOSjhRWSO7rUTNTwWtBNK+XvufSRGK1623ii17LcEHnY44UpJM=
=xgbD
-----END PGP SIGNATURE-----
--=-=-=--

