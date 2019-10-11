Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497F2ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E33C206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E33C206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIu6b-0002Ue-AD
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 08:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iItxn-0005jm-QD
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iItxl-0003gp-4B
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:24:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iItxk-0003ea-Ci
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:24:04 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 15EFBC057FA6
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 12:24:03 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id l3so4025310wmf.8
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 05:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=pRo2dK5iUCG2njcAceFNgCewT9YPA60zZcwPI9+Ayts=;
 b=R4TnNFoepUOMtkNMYfiXLAP1Uq7fOSZnbET9Tzr+4qe9CHV3kHPg3qJoqfkLo93NTm
 nCux9lxYbMAXxoDnRL9RlIb9FwoUURkypK6jakeFWcwgj4iH++SGFK3DPJoQty4Mec5A
 XGvabQKaRrFd9YMMDF4Iks0cI0+wekhddBv9PrbSClpRGFwyWJTLF/GGfr/rRPKVbPsE
 QWyP/cbN8fAQ3H8ctj0EfoIpyS81WFsfpz9pnIRH58BuoJWeogir9Zild5Mj5nP0SjyL
 1xNuVpK3qQnCnTdpdVUAVIhqHRRW58KSHvZbjOpUaaS+MqCeYeee84gFzUoRGjx+O2Rn
 nM8Q==
X-Gm-Message-State: APjAAAUl5j/uFAzH3Zm1hpPe4jfN7V0pfgB1l+/DlCAw1+dQdhmBNWHJ
 pWw6TLS1bvNFgmGBt9Qqj3lsKHEf/VD4jzczclrLbSUwFX256gi77a+2gS5Rq/OrSW+tLczttBZ
 UDS0OWYtAXmWu3a0=
X-Received: by 2002:a1c:9894:: with SMTP id a142mr2976577wme.70.1570796641583; 
 Fri, 11 Oct 2019 05:24:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzpFXAVdVpk9WrtplbOprN0wGZFzbFdh4adcxPDFqmK42CMZ7ziidfPOxeZSUI2B/DTAQXqiQ==
X-Received: by 2002:a1c:9894:: with SMTP id a142mr2976560wme.70.1570796641369; 
 Fri, 11 Oct 2019 05:24:01 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id n1sm12303598wrg.67.2019.10.11.05.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 05:24:00 -0700 (PDT)
References: <20191011085611.4194-1-stefanha@redhat.com>
 <20191011085611.4194-6-stefanha@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 5/7] libqos: expose common virtqueue setup/cleanup
 functions
In-reply-to: <20191011085611.4194-6-stefanha@redhat.com>
Date: Fri, 11 Oct 2019 14:23:58 +0200
Message-ID: <87y2xrbhcx.fsf@redhat.com>
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

> The VIRTIO 1.0 code will need to perform additional steps but it will
> reuse the common virtqueue setup/cleanup code.  Make these functions
> public.
>
> Make sure to invoke callbacks via QVirtioBus instead of directly calling
> the virtio-pci Legacy versions of these functions.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/libqos/virtio-pci.h |  8 ++++++++
>  tests/libqos/virtio-pci.c | 19 ++++++++++---------
>  2 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
> index 443e53affc..b620c30451 100644
> --- a/tests/libqos/virtio-pci.h
> +++ b/tests/libqos/virtio-pci.h
> @@ -63,4 +63,12 @@ void qvirtio_pci_set_msix_configuration_vector(QVirtio=
PCIDevice *d,
>                                          QGuestAllocator *alloc, uint16_t=
 entry);
>  void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
>                                          QGuestAllocator *alloc, uint16_t=
 entry);
> +
> +/* Used by Legacy and Modern virtio-pci code */
> +QVirtQueue *qvirtio_pci_virtqueue_setup_common(QVirtioDevice *d,
> +                                               QGuestAllocator *alloc,
> +                                               uint16_t index);
> +void qvirtio_pci_virtqueue_cleanup_common(QVirtQueue *vq,
> +                                          QGuestAllocator *alloc);
> +
>  #endif
> diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
> index 651f6dbfc6..3fb4af4016 100644
> --- a/tests/libqos/virtio-pci.c
> +++ b/tests/libqos/virtio-pci.c
> @@ -198,8 +198,9 @@ static void qvirtio_pci_set_queue_address(QVirtioDevi=
ce *d, QVirtQueue *vq)
>      qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_PFN, pfn);
>  }
>=20=20
> -static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
> -                                        QGuestAllocator *alloc, uint16_t=
 index)
> +QVirtQueue *qvirtio_pci_virtqueue_setup_common(QVirtioDevice *d,
> +                                               QGuestAllocator *alloc,
> +                                               uint16_t index)
>  {
>      uint32_t feat;
>      uint64_t addr;
> @@ -207,11 +208,11 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVir=
tioDevice *d,
>      QVirtioPCIDevice *qvpcidev =3D container_of(d, QVirtioPCIDevice, vde=
v);
>=20=20
>      vqpci =3D g_malloc0(sizeof(*vqpci));
> -    feat =3D qvirtio_pci_get_guest_features(d);
> +    feat =3D d->bus->get_guest_features(d);
>=20=20
> -    qvirtio_pci_queue_select(d, index);
> +    d->bus->queue_select(d, index);
>      vqpci->vq.index =3D index;
> -    vqpci->vq.size =3D qvirtio_pci_get_queue_size(d);
> +    vqpci->vq.size =3D d->bus->get_queue_size(d);
>      vqpci->vq.free_head =3D 0;
>      vqpci->vq.num_free =3D vqpci->vq.size;
>      vqpci->vq.align =3D VIRTIO_PCI_VRING_ALIGN;
> @@ -231,12 +232,12 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVir=
tioDevice *d,
>      addr =3D guest_alloc(alloc, qvring_size(vqpci->vq.size,
>                                            VIRTIO_PCI_VRING_ALIGN));
>      qvring_init(qvpcidev->pdev->bus->qts, alloc, &vqpci->vq, addr);
> -    qvirtio_pci_set_queue_address(d, &vqpci->vq);
> +    d->bus->set_queue_address(d, &vqpci->vq);
>=20=20
>      return &vqpci->vq;
>  }
>=20=20
> -static void qvirtio_pci_virtqueue_cleanup(QVirtQueue *vq,
> +void qvirtio_pci_virtqueue_cleanup_common(QVirtQueue *vq,
>                                            QGuestAllocator *alloc)
>  {
>      QVirtQueuePCI *vqpci =3D container_of(vq, QVirtQueuePCI, vq);
> @@ -266,8 +267,8 @@ static const QVirtioBus qvirtio_pci_legacy =3D {
>      .queue_select =3D qvirtio_pci_queue_select,
>      .get_queue_size =3D qvirtio_pci_get_queue_size,
>      .set_queue_address =3D qvirtio_pci_set_queue_address,
> -    .virtqueue_setup =3D qvirtio_pci_virtqueue_setup,
> -    .virtqueue_cleanup =3D qvirtio_pci_virtqueue_cleanup,
> +    .virtqueue_setup =3D qvirtio_pci_virtqueue_setup_common,
> +    .virtqueue_cleanup =3D qvirtio_pci_virtqueue_cleanup_common,
>      .virtqueue_kick =3D qvirtio_pci_virtqueue_kick,
>  };

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2gdF4ACgkQ9GknjS8M
AjXAIQ//eOyumi4VEc1UgcXsLhZKY0PipfMsEoguIdY8j/SS2yDerOdPwUZbM/I8
1bO9Ab5so2G73xyTSh9MvEMl0jBTYdmu5gBUaXqeY8HOUqfpqYOFdHzGTlE4LmbU
bH8wClh7cDohpDjTJUpNDX/WzeGlBkNyki2k9YsGy230s9/WvjHLYxaAGXz6UX0Z
54f4OjkxQLEzsacFZ/ID56ucH1h4zEzcE3y07Vuw39D14SyLip2NL+gJjF8eAJl+
3Vg/zu0rHEcOgY3xe6OQl6nkGWZbc9q0tOEXT+m7RmxyHR4Pj8w7Ga2DuqMq/nI9
UFUgXiiOOicrlyHLHYccLPlfs1EQQPVojMrO4r+RHNJOZjzCiF6tERQlAtXwqCiW
gZuw3DtTqQ4GmFtumlZUAiK6An3a77VohWJ/yiyGMhfn/nmjJVwmn2HWDluY3oVh
6zSFoLStOfzL6cJpeNIE38FeXx/fPmmQ6QDaKTn0le5Xi9pH7/diytDRrudwZ3HM
QXc5A1sSdOqT3n3pOJJQr5Z7PxBhubA/nA18IT9+kM4C+nAm4ABE2l2qFeKgpmkT
SHxiXf5WBda7f8w06lra4+XN/c4xgkPi5B1RSBGvIeMIo6m/2VLgsGrU6/PYnP8h
u/ukcjheE1JjRUIizmETbv0VcwtuIZk7K4vvefRPTxqdyQE+7ZI=
=Bmek
-----END PGP SIGNATURE-----
--=-=-=--

