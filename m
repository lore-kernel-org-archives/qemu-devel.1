Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C04ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD2E2089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD2E2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iItzo-00079a-4s
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 08:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iItwb-0004kB-GY
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iItwZ-000369-Rz
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:22:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53032)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iItwX-00035A-U0
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:22:50 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D011588306
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 12:22:48 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id i2so4309978wrv.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 05:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=bmBztziAuDiqdcIAey+kj3bOFlXKkTs13C4e/Axy074=;
 b=hA3E0PsIOsLr3KFJL+HfALzaER/3BzcMx4m41whmSKV3rit4lcDbit7SjUNFWORY33
 3qWkcvwHXzD+zPQ4E2G9HXzgthxAjRGa7BvnrsUoprMBsOZWuy9zbMV0lVJxGEWuIVZ4
 gWe7FU3isCQW5HzpnB3i8I+5FeyZA9nP6d3lAa1o0LP6CXxPaqZA8UAg8uDRHOssBMYb
 BLx/THpbkWQ1rbYxFghkeBIpST5eh64clz2ZL14FB0hEUYEWNh+aAVGTq84bbqe6Dsil
 LWVUkSMYNmeel2Grk0nxnyRl7PA5tS4ctkG0ZrXSmqAKFP7HLaFFFt6ZXq9CBIrtyv2w
 0opg==
X-Gm-Message-State: APjAAAVLQqocw9DrhkEin0Orc+t9lO2kAeQ/Rd6IM1BNGSyaHcISHiU0
 Oq7Hsf3ioYDif9mokc2XcIfi2iOFe64QROMIUG7xy+X6uLy2CZ9UDJRqwq6rLEo71sgVZy98glE
 /VxiqVi4PQf4phE4=
X-Received: by 2002:a1c:99cd:: with SMTP id b196mr3064548wme.105.1570796567183; 
 Fri, 11 Oct 2019 05:22:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw62ht1qJDRzShztuCoq+bESu18OfgJxByU50f/GrJ0grNwDnlIRuPhlCjZGxVN2TC7X4lwXA==
X-Received: by 2002:a1c:99cd:: with SMTP id b196mr3064532wme.105.1570796566940; 
 Fri, 11 Oct 2019 05:22:46 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id z142sm12740804wmc.24.2019.10.11.05.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 05:22:46 -0700 (PDT)
References: <20191011085611.4194-1-stefanha@redhat.com>
 <20191011085611.4194-4-stefanha@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 3/7] libqos: pass full QVirtQueue to set_queue_address()
In-reply-to: <20191011085611.4194-4-stefanha@redhat.com>
Date: Fri, 11 Oct 2019 14:22:44 +0200
Message-ID: <871rvjcvzf.fsf@redhat.com>
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

> Instead of just passing the vring page frame number, pass the full
> QVirtQueue.  This will allow the VIRTIO 1.0 transport to program the
> fine-grained vring address registers in the future.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/libqos/virtio.h      | 2 +-
>  tests/libqos/virtio-mmio.c | 6 ++++--
>  tests/libqos/virtio-pci.c  | 6 ++++--
>  3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
> index 2cb2448f46..37f55b6ade 100644
> --- a/tests/libqos/virtio.h
> +++ b/tests/libqos/virtio.h
> @@ -79,7 +79,7 @@ struct QVirtioBus {
>      uint16_t (*get_queue_size)(QVirtioDevice *d);
>=20=20
>      /* Set the address of the selected queue */
> -    void (*set_queue_address)(QVirtioDevice *d, uint32_t pfn);
> +    void (*set_queue_address)(QVirtioDevice *d, QVirtQueue *vq);
>=20=20
>      /* Setup the virtqueue specified by index */
>      QVirtQueue *(*virtqueue_setup)(QVirtioDevice *d, QGuestAllocator *al=
loc,
> diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
> index d0047876a8..43ca4e49c1 100644
> --- a/tests/libqos/virtio-mmio.c
> +++ b/tests/libqos/virtio-mmio.c
> @@ -127,9 +127,11 @@ static uint16_t qvirtio_mmio_get_queue_size(QVirtioD=
evice *d)
>      return (uint16_t)qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_QUEU=
E_NUM_MAX);
>  }
>=20=20
> -static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, uint32_t pf=
n)
> +static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, QVirtQueue =
*vq)
>  {
>      QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vdev);
> +    uint64_t pfn =3D vq->desc / dev->page_size;
> +
>      qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
>  }
>=20=20
> @@ -162,7 +164,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirt=
ioDevice *d,
>=20=20
>      addr =3D guest_alloc(alloc, qvring_size(vq->size, dev->page_size));
>      qvring_init(dev->qts, alloc, vq, addr);
> -    qvirtio_mmio_set_queue_address(d, vq->desc / dev->page_size);
> +    qvirtio_mmio_set_queue_address(d, vq);
>=20=20
>      return vq;
>  }
> diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
> index c8d736f4d1..4772239b61 100644
> --- a/tests/libqos/virtio-pci.c
> +++ b/tests/libqos/virtio-pci.c
> @@ -190,9 +190,11 @@ static uint16_t qvirtio_pci_get_queue_size(QVirtioDe=
vice *d)
>      return qpci_io_readw(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_NUM);
>  }
>=20=20
> -static void qvirtio_pci_set_queue_address(QVirtioDevice *d, uint32_t pfn)
> +static void qvirtio_pci_set_queue_address(QVirtioDevice *d, QVirtQueue *=
vq)
>  {
>      QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
> +    uint64_t pfn =3D vq->desc / VIRTIO_PCI_VRING_ALIGN;
> +
>      qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_PFN, pfn);
>  }
>=20=20
> @@ -229,7 +231,7 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirti=
oDevice *d,
>      addr =3D guest_alloc(alloc, qvring_size(vqpci->vq.size,
>                                            VIRTIO_PCI_VRING_ALIGN));
>      qvring_init(qvpcidev->pdev->bus->qts, alloc, &vqpci->vq, addr);
> -    qvirtio_pci_set_queue_address(d, vqpci->vq.desc / VIRTIO_PCI_VRING_A=
LIGN);
> +    qvirtio_pci_set_queue_address(d, &vqpci->vq);
>=20=20
>      return &vqpci->vq;
>  }

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2gdBQACgkQ9GknjS8M
AjU5OxAAhXBSLsmBBKNa5zKdLtoYuPsZ31tor1GgwhWdlCwsA0V2mdY27FBCCoyo
g3kVtNZJfw66ZMEmyvo5q6QbTAilxw0rfFAKbbl45ks5aGNauq4qUyZmJYPiVoE1
F+LlzdM6fGP6X3DdVMjDkewcWsq0osvPoMHilLnKT8h7Wk+M/rvMVv5ldInDUbiW
2ih5UCUDZi6rnRuMsLgd95yyd6xzPtp0QT4cbZOUcY5pBdqqcVwJQYbAl2lUNfa2
f3HYpQn3LIxM1K5KcNUZm6A3hOIlaH3mfNyrzQZb7Ula8CeGbGFFKx+fWChtdBqS
weDiCsyhiI3xZRMbupVc/hwVDCHu18mhNsMymvEnmN29aLM6JoUs6j/ej5EtkJ7e
3WeGmUboS/n7Wn/5c3PrO3wTqi4NkasSw4EqNkH8/W+qppbEhCHk3GzK3xQ75Za6
6NUk057JW49CRb4aL1vOEbariY7H8CXzl93VNqdNHx+ucDkc/gGFVQXCOyxK16pT
Py9EkYOuyj6edoO6dRp11MxRJ+lsm0quM43d+IjmLwPbMbcdjVDI8gvQecsFVUa1
zmf1Buz21GutyBlR4CU1TBSjQGbSr1hthq1BN2pYEtuAYjZGc8jeeveJzMVHQS3X
g2AqQFTo0QI6zDKANVpRBz9kbgChp92aq1cO8yLjXmMzsPoOq4k=
=5aJP
-----END PGP SIGNATURE-----
--=-=-=--

