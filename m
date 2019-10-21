Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD80CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30483214B2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30483214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXGp-0000yV-7k
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 08:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMXFM-00088x-Sm
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMXFK-0006hZ-K0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:57:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMXFI-0006gh-9X
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:57:12 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF262368FF
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 12:57:09 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id c6so7276613wrp.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 05:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rQcJwWKrimHInNtfGwNWgZ1EIrZZcdziVm1tGcHXJdI=;
 b=aPeAIvkqq6GmK+1tsX59keY6KcBW4lqxp9gZcHwxh/8O5QC9zzb6KHFSLYCwcc0/bd
 8fBQAy7468RT//JtK3EdeBjWpHKz8/rYzgsKnYwgq5RMVsNOEx81DYdUNEF+y2P4VJ6G
 kWWQ7H62jmVzytDUTu23RtMUvVtQ8N6gJgNp78SDzfGziOmNkLTyvSQKr2iIbnFMUGg4
 hznrYt0HZ0UvuySLiPfxG/kfFmmZ+SmKJ49ak2ekba8W/PA/nSAKpCXl7RhFaoGmridG
 2LrocS6XmtO2UcD/0jOas1b9lzaXwR3a9WTCGEdVbcgZIV8v4xQeRJxULYEnAfQrYnSv
 ob/Q==
X-Gm-Message-State: APjAAAX8nKcpJRxXYkFsenQ384o5f8Af8G+HOWylgM5groMBjoNE+G2E
 6uWQeFIIlvbZQFDb0KQXxk6cdM7JWjKD6px0K7U4L7EgbeKh5FT90NLFVuy71uPvAtXyc7KPj42
 6dCDs6HfqNBMoV/U=
X-Received: by 2002:a5d:66c6:: with SMTP id k6mr12337205wrw.152.1571662628611; 
 Mon, 21 Oct 2019 05:57:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzJFNVUYsZgbVLg3uv0E2wzyygv3IE0hhRAvMPq7R14iBpuoZHJawbwLs257+g0yi1cmUFCyg==
X-Received: by 2002:a5d:66c6:: with SMTP id k6mr12337183wrw.152.1571662628291; 
 Mon, 21 Oct 2019 05:57:08 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x12sm5141632wru.93.2019.10.21.05.57.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 05:57:07 -0700 (PDT)
Subject: Re: [PATCH v3 03/16] libqos: extend feature bits to 64-bit
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191019063810.6944-1-stefanha@redhat.com>
 <20191019063810.6944-4-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e2b1c922-e872-7eb4-886e-dc1d0aed693a@redhat.com>
Date: Mon, 21 Oct 2019 14:57:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191019063810.6944-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/19 8:37 AM, Stefan Hajnoczi wrote:
> In VIRTIO 1.0 feature bits changed from 32-bit to 64-bit.  (In fact, th=
e
> transports allow even more feature bits but nothing uses more than 64
> bits today.)
>=20
> Add 64-bit feature bit support to virtio-mmio and virtio-pci.  This wil=
l
> be necessary for VIRTIO 1.0 support.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tests/libqos/virtio.h      | 12 ++++++------
>   tests/libqos/virtio-mmio.c | 28 ++++++++++++++++++++++------
>   tests/libqos/virtio-net.c  |  6 +++---
>   tests/libqos/virtio-pci.c  | 12 ++++++------
>   tests/libqos/virtio.c      |  4 ++--
>   tests/virtio-blk-test.c    |  8 ++++----
>   6 files changed, 43 insertions(+), 27 deletions(-)
>=20
> diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
> index 2cb2448f46..a5c99fb3c9 100644
> --- a/tests/libqos/virtio.h
> +++ b/tests/libqos/virtio.h
> @@ -13,7 +13,7 @@
>   #include "libqos/malloc.h"
>   #include "standard-headers/linux/virtio_ring.h"
>  =20
> -#define QVIRTIO_F_BAD_FEATURE           0x40000000
> +#define QVIRTIO_F_BAD_FEATURE           0x40000000ull
>  =20
>   typedef struct QVirtioBus QVirtioBus;
>  =20
> @@ -52,13 +52,13 @@ struct QVirtioBus {
>       uint64_t (*config_readq)(QVirtioDevice *d, uint64_t addr);
>  =20
>       /* Get features of the device */
> -    uint32_t (*get_features)(QVirtioDevice *d);
> +    uint64_t (*get_features)(QVirtioDevice *d);
>  =20
>       /* Set features of the device */
> -    void (*set_features)(QVirtioDevice *d, uint32_t features);
> +    void (*set_features)(QVirtioDevice *d, uint64_t features);
>  =20
>       /* Get features of the guest */
> -    uint32_t (*get_guest_features)(QVirtioDevice *d);
> +    uint64_t (*get_guest_features)(QVirtioDevice *d);
>  =20
>       /* Get status of the device */
>       uint8_t (*get_status)(QVirtioDevice *d);
> @@ -103,8 +103,8 @@ uint8_t qvirtio_config_readb(QVirtioDevice *d, uint=
64_t addr);
>   uint16_t qvirtio_config_readw(QVirtioDevice *d, uint64_t addr);
>   uint32_t qvirtio_config_readl(QVirtioDevice *d, uint64_t addr);
>   uint64_t qvirtio_config_readq(QVirtioDevice *d, uint64_t addr);
> -uint32_t qvirtio_get_features(QVirtioDevice *d);
> -void qvirtio_set_features(QVirtioDevice *d, uint32_t features);
> +uint64_t qvirtio_get_features(QVirtioDevice *d);
> +void qvirtio_set_features(QVirtioDevice *d, uint64_t features);
>   bool qvirtio_is_big_endian(QVirtioDevice *d);
>  =20
>   void qvirtio_reset(QVirtioDevice *d);
> diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
> index 7154b03c1d..78066e6e05 100644
> --- a/tests/libqos/virtio-mmio.c
> +++ b/tests/libqos/virtio-mmio.c
> @@ -40,22 +40,38 @@ static uint64_t qvirtio_mmio_config_readq(QVirtioDe=
vice *d, uint64_t off)
>       return qtest_readq(dev->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPEC=
IFIC + off);
>   }
>  =20
> -static uint32_t qvirtio_mmio_get_features(QVirtioDevice *d)
> +static uint64_t qvirtio_mmio_get_features(QVirtioDevice *d)
>   {
>       QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vde=
v);
> +    uint64_t lo;
> +    uint64_t hi =3D 0;
> +
>       qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SEL=
, 0);
> -    return qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURE=
S);
> +    lo =3D qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURE=
S);
> +
> +    if (dev->version >=3D 2) {
> +        qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES_=
SEL, 1);
> +        hi =3D qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEA=
TURES);
> +    }
> +
> +    return (hi << 32) | lo;
>   }
>  =20
> -static void qvirtio_mmio_set_features(QVirtioDevice *d, uint32_t featu=
res)
> +static void qvirtio_mmio_set_features(QVirtioDevice *d, uint64_t featu=
res)
>   {
>       QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vde=
v);
>       dev->features =3D features;
>       qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_SE=
L, 0);
>       qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES, f=
eatures);
> +
> +    if (dev->version >=3D 2) {
> +        qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES=
_SEL, 1);
> +        qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES=
,
> +                     features >> 32);
> +    }
>   }
>  =20
> -static uint32_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
> +static uint64_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
>   {
>       QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vde=
v);
>       return dev->features;
> @@ -149,8 +165,8 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVi=
rtioDevice *d,
>       vq->free_head =3D 0;
>       vq->num_free =3D vq->size;
>       vq->align =3D dev->page_size;
> -    vq->indirect =3D (dev->features & (1u << VIRTIO_RING_F_INDIRECT_DE=
SC)) !=3D 0;
> -    vq->event =3D (dev->features & (1u << VIRTIO_RING_F_EVENT_IDX)) !=3D=
 0;
> +    vq->indirect =3D dev->features & (1ull << VIRTIO_RING_F_INDIRECT_D=
ESC);
> +    vq->event =3D dev->features & (1ull << VIRTIO_RING_F_EVENT_IDX);
>  =20
>       qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NUM, vq->si=
ze);
>  =20
> diff --git a/tests/libqos/virtio-net.c b/tests/libqos/virtio-net.c
> index 6567beb553..710d440c3d 100644
> --- a/tests/libqos/virtio-net.c
> +++ b/tests/libqos/virtio-net.c
> @@ -44,11 +44,11 @@ static void virtio_net_setup(QVirtioNet *interface)
>  =20
>       features =3D qvirtio_get_features(vdev);
>       features &=3D ~(QVIRTIO_F_BAD_FEATURE |
> -                  (1u << VIRTIO_RING_F_INDIRECT_DESC) |
> -                  (1u << VIRTIO_RING_F_EVENT_IDX));
> +                  (1ull << VIRTIO_RING_F_INDIRECT_DESC) |
> +                  (1ull << VIRTIO_RING_F_EVENT_IDX));
>       qvirtio_set_features(vdev, features);
>  =20
> -    if (features & (1u << VIRTIO_NET_F_MQ)) {
> +    if (features & (1ull << VIRTIO_NET_F_MQ)) {
>           interface->n_queues =3D qvirtio_config_readw(vdev, 8) * 2;
>       } else {
>           interface->n_queues =3D 2;
> diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
> index 50499e75ef..1b6b760fc6 100644
> --- a/tests/libqos/virtio-pci.c
> +++ b/tests/libqos/virtio-pci.c
> @@ -96,19 +96,19 @@ static uint64_t qvirtio_pci_config_readq(QVirtioDev=
ice *d, uint64_t off)
>       return val;
>   }
>  =20
> -static uint32_t qvirtio_pci_get_features(QVirtioDevice *d)
> +static uint64_t qvirtio_pci_get_features(QVirtioDevice *d)
>   {
>       QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev)=
;
>       return qpci_io_readl(dev->pdev, dev->bar, VIRTIO_PCI_HOST_FEATURE=
S);
>   }
>  =20
> -static void qvirtio_pci_set_features(QVirtioDevice *d, uint32_t featur=
es)
> +static void qvirtio_pci_set_features(QVirtioDevice *d, uint64_t featur=
es)
>   {
>       QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev)=
;
>       qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_GUEST_FEATURES, fe=
atures);
>   }
>  =20
> -static uint32_t qvirtio_pci_get_guest_features(QVirtioDevice *d)
> +static uint64_t qvirtio_pci_get_guest_features(QVirtioDevice *d)
>   {
>       QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev)=
;
>       return qpci_io_readl(dev->pdev, dev->bar, VIRTIO_PCI_GUEST_FEATUR=
ES);
> @@ -208,7 +208,7 @@ static void qvirtio_pci_set_queue_address(QVirtioDe=
vice *d, uint32_t pfn)
>   static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
>                                           QGuestAllocator *alloc, uint1=
6_t index)
>   {
> -    uint32_t feat;
> +    uint64_t feat;
>       uint64_t addr;
>       QVirtQueuePCI *vqpci;
>       QVirtioPCIDevice *qvpcidev =3D container_of(d, QVirtioPCIDevice, =
vdev);
> @@ -222,8 +222,8 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVir=
tioDevice *d,
>       vqpci->vq.free_head =3D 0;
>       vqpci->vq.num_free =3D vqpci->vq.size;
>       vqpci->vq.align =3D VIRTIO_PCI_VRING_ALIGN;
> -    vqpci->vq.indirect =3D (feat & (1u << VIRTIO_RING_F_INDIRECT_DESC)=
) !=3D 0;
> -    vqpci->vq.event =3D (feat & (1u << VIRTIO_RING_F_EVENT_IDX)) !=3D =
0;
> +    vqpci->vq.indirect =3D feat & (1ull << VIRTIO_RING_F_INDIRECT_DESC=
);
> +    vqpci->vq.event =3D feat & (1ull << VIRTIO_RING_F_EVENT_IDX);
>  =20
>       vqpci->msix_entry =3D -1;
>       vqpci->msix_addr =3D 0;
> diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
> index 0ae9956fc8..4f7e6bb8a1 100644
> --- a/tests/libqos/virtio.c
> +++ b/tests/libqos/virtio.c
> @@ -33,12 +33,12 @@ uint64_t qvirtio_config_readq(QVirtioDevice *d, uin=
t64_t addr)
>       return d->bus->config_readq(d, addr);
>   }
>  =20
> -uint32_t qvirtio_get_features(QVirtioDevice *d)
> +uint64_t qvirtio_get_features(QVirtioDevice *d)
>   {
>       return d->bus->get_features(d);
>   }
>  =20
> -void qvirtio_set_features(QVirtioDevice *d, uint32_t features)
> +void qvirtio_set_features(QVirtioDevice *d, uint64_t features)
>   {
>       d->features =3D features;
>       d->bus->set_features(d, features);
> diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
> index f6674fb233..31680cc159 100644
> --- a/tests/virtio-blk-test.c
> +++ b/tests/virtio-blk-test.c
> @@ -119,7 +119,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAl=
locator *alloc,
>       QVirtioBlkReq req;
>       uint64_t req_addr;
>       uint64_t capacity;
> -    uint32_t features;
> +    uint64_t features;
>       uint32_t free_head;
>       uint8_t status;
>       char *data;
> @@ -352,7 +352,7 @@ static void indirect(void *obj, void *u_data, QGues=
tAllocator *t_alloc)
>       QVRingIndirectDesc *indirect;
>       uint64_t req_addr;
>       uint64_t capacity;
> -    uint32_t features;
> +    uint64_t features;
>       uint32_t free_head;
>       uint8_t status;
>       char *data;
> @@ -467,7 +467,7 @@ static void msix(void *obj, void *u_data, QGuestAll=
ocator *t_alloc)
>       int n_size =3D TEST_IMAGE_SIZE / 2;
>       uint64_t req_addr;
>       uint64_t capacity;
> -    uint32_t features;
> +    uint64_t features;
>       uint32_t free_head;
>       uint8_t status;
>       char *data;
> @@ -574,7 +574,7 @@ static void idx(void *obj, void *u_data, QGuestAllo=
cator *t_alloc)
>       QVirtioBlkReq req;
>       uint64_t req_addr;
>       uint64_t capacity;
> -    uint32_t features;
> +    uint64_t features;
>       uint32_t free_head;
>       uint32_t write_head;
>       uint32_t desc_idx;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

