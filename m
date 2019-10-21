Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E420CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5572C20679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5572C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXLC-0004wX-F0
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMXI2-0002tG-HU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMXHy-0007KE-Rj
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:00:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49766)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMXHy-0007Js-JX
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:59:58 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 93896C04AC69
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 12:59:57 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id 7so7306605wrl.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 05:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VLObdgGCBHKd4NyKqw1nb9Ft4ivPz1Wm47y/KgC4Yfo=;
 b=ct5p9TfHM27CzGVpjE1USaOpUlfECsJYpeOLsPUBLPSh685AxC6RnaLcopRviCC8H0
 6AIFiS2KYOtNVxC4/qsCxGleCd+JVn6DOZCXHrrVzfAEr2qmD/W+IoR1GJyLg+n2OD+v
 ftzKb9mxp8o+g3yy600ZJ3i3ZxYtibKad+d1eVaSSo5xYF5TKC24tWwAkFq9v4BRff7X
 SK4yiKgq+JVca0nGpWbzFVijardaVS9IBalBAF5x/PBKtoqXWqrUipToUftDzGi5oXZ9
 KnkTQHq7qc6O+wyjxOL8o6Ii7aAjSU113L0qs8J1MfjDBrhrXztU80pUnQvgk8b8HTdU
 huTQ==
X-Gm-Message-State: APjAAAWiqNOyyTFOuC0sIbfrJ47cYnxzxKcGxJ81D2oqwp4PITFzxVkt
 5pKbSTA4MzATR52iUhQNjnQGOVM6X1BEHGbZn1BUBKSMaobsrWOMmJc1IX0s9e9F56Ksb8QEL10
 upp9IOaNAYaAcdMo=
X-Received: by 2002:a5d:4644:: with SMTP id j4mr20193605wrs.355.1571662796354; 
 Mon, 21 Oct 2019 05:59:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy9a4mBGzc4Atj27HBMDjG+ZXbuXSzITmVipWUvlu1WEC85D5/kswe/8fIndQB2FRYUdSQ8KA==
X-Received: by 2002:a5d:4644:: with SMTP id j4mr20193582wrs.355.1571662796132; 
 Mon, 21 Oct 2019 05:59:56 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id j19sm28075358wre.0.2019.10.21.05.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 05:59:54 -0700 (PDT)
Subject: Re: [PATCH v3 11/16] libqos: pass full QVirtQueue to
 set_queue_address()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191019063810.6944-1-stefanha@redhat.com>
 <20191019063810.6944-12-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0c13b978-9998-cba4-dffb-b76795553398@redhat.com>
Date: Mon, 21 Oct 2019 14:59:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191019063810.6944-12-stefanha@redhat.com>
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

On 10/19/19 8:38 AM, Stefan Hajnoczi wrote:
> Instead of just passing the vring page frame number, pass the full
> QVirtQueue.  This will allow the VIRTIO 1.0 transport to program the
> fine-grained vring address registers in the future.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   tests/libqos/virtio.h      | 2 +-
>   tests/libqos/virtio-mmio.c | 6 ++++--
>   tests/libqos/virtio-pci.c  | 6 ++++--
>   3 files changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
> index 5777683a2a..407d8fc088 100644
> --- a/tests/libqos/virtio.h
> +++ b/tests/libqos/virtio.h
> @@ -80,7 +80,7 @@ struct QVirtioBus {
>       uint16_t (*get_queue_size)(QVirtioDevice *d);
>  =20
>       /* Set the address of the selected queue */
> -    void (*set_queue_address)(QVirtioDevice *d, uint32_t pfn);
> +    void (*set_queue_address)(QVirtioDevice *d, QVirtQueue *vq);
>  =20
>       /* Setup the virtqueue specified by index */
>       QVirtQueue *(*virtqueue_setup)(QVirtioDevice *d, QGuestAllocator =
*alloc,
> diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
> index 4db1f1b8bc..e0a2bd7bc6 100644
> --- a/tests/libqos/virtio-mmio.c
> +++ b/tests/libqos/virtio-mmio.c
> @@ -143,9 +143,11 @@ static uint16_t qvirtio_mmio_get_queue_size(QVirti=
oDevice *d)
>       return (uint16_t)qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_Q=
UEUE_NUM_MAX);
>   }
>  =20
> -static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, uint32_t =
pfn)
> +static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, QVirtQueu=
e *vq)
>   {
>       QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vde=
v);
> +    uint64_t pfn =3D vq->desc / dev->page_size;
> +
>       qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
>   }
>  =20
> @@ -179,7 +181,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVi=
rtioDevice *d,
>  =20
>       addr =3D guest_alloc(alloc, qvring_size(vq->size, dev->page_size)=
);
>       qvring_init(dev->qts, alloc, vq, addr);
> -    qvirtio_mmio_set_queue_address(d, vq->desc / dev->page_size);
> +    qvirtio_mmio_set_queue_address(d, vq);
>  =20
>       return vq;
>   }
> diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
> index 7ecf5d0a52..e4fa318dcc 100644
> --- a/tests/libqos/virtio-pci.c
> +++ b/tests/libqos/virtio-pci.c
> @@ -199,9 +199,11 @@ static uint16_t qvirtio_pci_get_queue_size(QVirtio=
Device *d)
>       return qpci_io_readw(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_NUM);
>   }
>  =20
> -static void qvirtio_pci_set_queue_address(QVirtioDevice *d, uint32_t p=
fn)
> +static void qvirtio_pci_set_queue_address(QVirtioDevice *d, QVirtQueue=
 *vq)
>   {
>       QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev)=
;
> +    uint64_t pfn =3D vq->desc / VIRTIO_PCI_VRING_ALIGN;
> +
>       qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_PFN, pfn);
>   }
>  =20
> @@ -239,7 +241,7 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVir=
tioDevice *d,
>       addr =3D guest_alloc(alloc, qvring_size(vqpci->vq.size,
>                                             VIRTIO_PCI_VRING_ALIGN));
>       qvring_init(qvpcidev->pdev->bus->qts, alloc, &vqpci->vq, addr);
> -    qvirtio_pci_set_queue_address(d, vqpci->vq.desc / VIRTIO_PCI_VRING=
_ALIGN);
> +    qvirtio_pci_set_queue_address(d, &vqpci->vq);
>  =20
>       return &vqpci->vq;
>   }
>=20

