Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EB4ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD7A214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD7A214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIti3-0003up-4o
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 08:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iItgT-0002r4-9O
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iItgP-0003sd-Ji
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iItgP-0003rM-BD
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:06:09 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 91F212CD7E5
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 12:06:06 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id w2so4287335wrn.4
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 05:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=Fj8PSfq5WFLBOLtHNy+i0Njh829PlDsgWtmyC2KwsT8=;
 b=S9/G2J18Ax1xzKRPkCyJlsKXc+aCFc4TL9wD/Yit9I1N0Gb43al4SoENLOOeqmc1AR
 pDziYcqfJ67BH48h1OSdYUGsktJigcEBLlcgBohg5KOtngSnSFIsk9Ili0Awo8aaWtJh
 hWZu9ye1ZzED0rggm11PjjF+mG/ZLu1o/bz7xD1SozaK1AyPKfl2DLbXKOkylZpRDyIF
 Dlwjt2yU2a0Q7r2ZLC1vx22Ck4lYleptoM9GjpxLoacPT+V7Jo+buVgpJnYs/yJ3cpaQ
 qNe3ooeVocAe/YUWGqfW+HN5yszqfQplOa/JPsAJGFyu1IYzrshm7KlANvzo8VCjuOb/
 wpdg==
X-Gm-Message-State: APjAAAXgXjYsOMtBPtb8FYR5vczPzwuVhNzeFzelM9wxUWg2QlSh8sGi
 eusB83A9N8sC9s/hZR+tXfrby0pnBKJN2rft+YZP4XzTQadHJsF27Jp+O1lLyv3qo1W6qxfqtgu
 w17dA/lA8KYNE1bY=
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr12700606wro.65.1570795565365; 
 Fri, 11 Oct 2019 05:06:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBZ0+Rz+8vRUt662o1EdGPDgwhL3lSaU5fCIgXKQXIoELiMeZmM/Yf2DAs5gNBDqfBMFtvLw==
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr12700584wro.65.1570795565140; 
 Fri, 11 Oct 2019 05:06:05 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id r140sm11813154wme.47.2019.10.11.05.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 05:06:03 -0700 (PDT)
References: <20191011085611.4194-1-stefanha@redhat.com>
 <20191011085611.4194-7-stefanha@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 6/7] libqos: make the virtio-pci BAR index configurable
In-reply-to: <20191011085611.4194-7-stefanha@redhat.com>
Date: Fri, 11 Oct 2019 14:06:01 +0200
Message-ID: <877e5bqyfq.fsf@redhat.com>
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

> The Legacy virtio-pci interface always uses BAR 0.  VIRTIO 1.0 may need
> to use a different BAR index, so make it configurable.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/libqos/virtio-pci.h | 2 ++
>  tests/libqos/virtio-pci.c | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
> index b620c30451..f2d53aa377 100644
> --- a/tests/libqos/virtio-pci.h
> +++ b/tests/libqos/virtio-pci.h
> @@ -25,6 +25,8 @@ typedef struct QVirtioPCIDevice {
>      uint16_t config_msix_entry;
>      uint64_t config_msix_addr;
>      uint32_t config_msix_data;
> +
> +    uint8_t bar_idx;
>  } QVirtioPCIDevice;
>=20=20
>  struct QVirtioPCIMSIXOps {
> diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
> index 3fb4af4016..efd8caee18 100644
> --- a/tests/libqos/virtio-pci.c
> +++ b/tests/libqos/virtio-pci.c
> @@ -300,7 +300,7 @@ static const QVirtioPCIMSIXOps qvirtio_pci_msix_ops_l=
egacy =3D {
>  void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
>  {
>      qpci_device_enable(d->pdev);
> -    d->bar =3D qpci_iomap(d->pdev, 0, NULL);
> +    d->bar =3D qpci_iomap(d->pdev, d->bar_idx, NULL);
>  }
>=20=20
>  void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
> @@ -389,6 +389,7 @@ void qvirtio_pci_start_hw(QOSGraphObject *obj)
>  static void qvirtio_pci_init_legacy(QVirtioPCIDevice *dev)
>  {
>      dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUBSYSTEM=
_ID);
> +    dev->bar_idx =3D 0;
>      dev->vdev.bus =3D &qvirtio_pci_legacy;
>      dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
>      dev->vdev.big_endian =3D qtest_big_endian(dev->pdev->bus->qts);

qpci_iomap() is also called with a hardcoded bar at
virtio-blk-test.c:test_nonexistent_virtqueue(). Should it be fixed here
or in a future patch?

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2gcCkACgkQ9GknjS8M
AjXGDBAAuVHXzfeV4SNSaKBhqBUepGbF+rXkX8kcSBu+jU4jK8gTn7y1jH4u5Ad0
0vO3zTCTyCUZw53/EwFbEYnZLz9jvlEyU7A97CN+yow9p2i3vUA+Rht/pjzrhRnX
z+OFIM8hj5UWpi/8e0lYK2DaqZDV6hYi1mNBS+QVC1v9qKGs4FQbX4w/KBZUwE8t
RXrSPm5r4wNfh5ZSk4L78JNuF4dfKgCBSUz1Zgosvy9Etn0WkJpRFlq2tlQ+k7D8
tmmBPEOeUq8DimLw9407vIm3s0VdcTJIYUdwrX94J8crwQM1k5d4i0/QAEN6vslK
8mRxGRMqJElntb+xFRlVTv/E5u29xbD8w38/uhel9XmNDHtXAks/boKd7gzYK4Js
V76AeVFUuwqrfySW2JsvVaj3NE9B/c9dPnDsu2eqrlngs8Ves/vf8Us/G9erJ09v
dtaDpUbjkZLkR3ayT7Uzk3dMv+lEycyQJ13Lzjiri5nOywSI/q1Dk8mVC7gqKi/y
R4yUrX2+iIGMEqIiuGQh9Z0H4X6Wn1tAhHXh0K8qv4s2P2LHacN1Sf0k+iZRQ0eo
wIgSOB5uBE8XiLCr+lqTxjtHgCwEKoaCjaHDYbJUmLYKcEiymGt6gX9OLw3wtRhh
p0jMpsBPgqm0V+1MEtJxDyeFQYlI5+nYd8smQpkpnygoTufEduU=
=luLU
-----END PGP SIGNATURE-----
--=-=-=--

