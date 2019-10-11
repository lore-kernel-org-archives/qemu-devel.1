Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E30ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A16206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A16206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIu4S-0001UF-P1
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 08:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iItxI-0005RR-5j
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iItxG-0003Ng-SF
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:23:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iItxG-0003Ms-JS
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:23:34 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E988C053B34
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 12:23:33 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id z205so4025445wmb.7
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 05:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=YxITuAEyHyd9ggwamaaSGer6Lr7Ln0Ym0NutTFeLYMc=;
 b=Wol9L69ymJI32rOx/BNiyPxyc7F9QjnOQxAQiE4AcW35CTRxMezsy/pm5uSlUV4FJN
 +zujbNK89jsADv4yugeQidRnqcaVi31OGdkIC8KEQB0VMzmNyvJV4sWKXIqR1t8jlh+5
 TaDrgnfYNM+kdvs0bRTI/NvEjHnLQfVjvJnSzfoUNw81lSPWXALw1b8yttEdLppH1sxY
 WG2M7yS9o5qkZt6dZ11FQvuILNTmgndHd9FRnpyTMV+puSA4ctmlQ92M1fYUfOglkZUc
 NYcM2YhikPL5IFjkc6Wf4IWDB/TLyaRovrU8l9SyUsIc4K0G0Ss83T+rK6PYH2zBUr+X
 /TmQ==
X-Gm-Message-State: APjAAAWyk6DCES2Dd4l+R5n4ekfbU/M/5eAEGh2ItuSEhqdhdl4Q3mBE
 YT+3xjY6WaledEkKY8mv/hkM1qPPtptlgoGSCrRDSeuksmiNXyYhs6EENxGBmhRYGIaM0ud0h45
 jYprqc4h45IEEYDs=
X-Received: by 2002:a5d:43c2:: with SMTP id v2mr7756509wrr.153.1570796612203; 
 Fri, 11 Oct 2019 05:23:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0Sm52JJTTjvnMLZUIqN5i0sYP4UErG6WPOmxymLwv2dYQ0wSUbIiYu4LA+0+F2sqFJCwTcQ==
X-Received: by 2002:a5d:43c2:: with SMTP id v2mr7756494wrr.153.1570796611993; 
 Fri, 11 Oct 2019 05:23:31 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id n18sm6985979wmi.20.2019.10.11.05.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 05:23:31 -0700 (PDT)
References: <20191011085611.4194-1-stefanha@redhat.com>
 <20191011085611.4194-5-stefanha@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 4/7] libqos: add MSI-X callbacks to QVirtioPCIDevice
In-reply-to: <20191011085611.4194-5-stefanha@redhat.com>
Date: Fri, 11 Oct 2019 14:23:29 +0200
Message-ID: <87zhi7bhdq.fsf@redhat.com>
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

> The MSI-X vectors are programmed differently in the VIRTIO 1.0 and
> Legacy interfaces.  Introduce callbacks so different implementations can
> be used depending on the interface version.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/libqos/virtio-pci.h | 12 ++++++++++++
>  tests/libqos/virtio-pci.c | 37 ++++++++++++++++++++++++++++---------
>  2 files changed, 40 insertions(+), 9 deletions(-)
>
> diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
> index 0d105d67b3..443e53affc 100644
> --- a/tests/libqos/virtio-pci.h
> +++ b/tests/libqos/virtio-pci.h
> @@ -14,16 +14,28 @@
>  #include "libqos/pci.h"
>  #include "libqos/qgraph.h"
>=20=20
> +typedef struct QVirtioPCIMSIXOps QVirtioPCIMSIXOps;
> +
>  typedef struct QVirtioPCIDevice {
>      QOSGraphObject obj;
>      QVirtioDevice vdev;
>      QPCIDevice *pdev;
>      QPCIBar bar;
> +    const QVirtioPCIMSIXOps *msix_ops;
>      uint16_t config_msix_entry;
>      uint64_t config_msix_addr;
>      uint32_t config_msix_data;
>  } QVirtioPCIDevice;
>=20=20
> +struct QVirtioPCIMSIXOps {
> +    /* Set the Configuration Vector for MSI-X */
> +    void (*set_config_vector)(QVirtioPCIDevice *d, uint16_t entry);
> +
> +    /* Set the Queue Vector for MSI-X */
> +    void (*set_queue_vector)(QVirtioPCIDevice *d, uint16_t vq_idx,
> +                             uint16_t entry);
> +};
> +
>  typedef struct QVirtQueuePCI {
>      QVirtQueue vq;
>      uint16_t msix_entry;
> diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
> index 4772239b61..651f6dbfc6 100644
> --- a/tests/libqos/virtio-pci.c
> +++ b/tests/libqos/virtio-pci.c
> @@ -271,6 +271,31 @@ static const QVirtioBus qvirtio_pci_legacy =3D {
>      .virtqueue_kick =3D qvirtio_pci_virtqueue_kick,
>  };
>=20=20
> +static void qvirtio_pci_set_config_vector(QVirtioPCIDevice *d, uint16_t =
entry)
> +{
> +    uint16_t vector;
> +
> +    qpci_io_writew(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR, entry);
> +    vector =3D qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR);
> +    g_assert_cmphex(vector, !=3D, VIRTIO_MSI_NO_VECTOR);
> +}
> +
> +static void qvirtio_pci_set_queue_vector(QVirtioPCIDevice *d, uint16_t v=
q_idx,
> +                                         uint16_t entry)
> +{
> +    uint16_t vector;
> +
> +    qvirtio_pci_queue_select(&d->vdev, vq_idx);
> +    qpci_io_writew(d->pdev, d->bar, VIRTIO_MSI_QUEUE_VECTOR, entry);
> +    vector =3D qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_QUEUE_VECTOR);
> +    g_assert_cmphex(vector, !=3D, VIRTIO_MSI_NO_VECTOR);
> +}
> +
> +static const QVirtioPCIMSIXOps qvirtio_pci_msix_ops_legacy =3D {
> +    .set_config_vector =3D qvirtio_pci_set_config_vector,
> +    .set_queue_vector =3D qvirtio_pci_set_queue_vector,
> +};
> +
>  void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
>  {
>      qpci_device_enable(d->pdev);
> @@ -285,7 +310,6 @@ void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
>  void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
>                                          QGuestAllocator *alloc, uint16_t=
 entry)
>  {
> -    uint16_t vector;
>      uint32_t control;
>      uint64_t off;
>=20=20
> @@ -311,16 +335,12 @@ void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d,=
 QVirtQueuePCI *vqpci,
>                     off + PCI_MSIX_ENTRY_VECTOR_CTRL,
>                     control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
>=20=20
> -    qvirtio_pci_queue_select(&d->vdev, vqpci->vq.index);
> -    qpci_io_writew(d->pdev, d->bar, VIRTIO_MSI_QUEUE_VECTOR, entry);
> -    vector =3D qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_QUEUE_VECTOR);
> -    g_assert_cmphex(vector, !=3D, VIRTIO_MSI_NO_VECTOR);
> +    d->msix_ops->set_queue_vector(d, vqpci->vq.index, entry);
>  }
>=20=20
>  void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
>                                          QGuestAllocator *alloc, uint16_t=
 entry)
>  {
> -    uint16_t vector;
>      uint32_t control;
>      uint64_t off;
>=20=20
> @@ -348,9 +368,7 @@ void qvirtio_pci_set_msix_configuration_vector(QVirti=
oPCIDevice *d,
>                     off + PCI_MSIX_ENTRY_VECTOR_CTRL,
>                     control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
>=20=20
> -    qpci_io_writew(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR, entry);
> -    vector =3D qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR);
> -    g_assert_cmphex(vector, !=3D, VIRTIO_MSI_NO_VECTOR);
> +    d->msix_ops->set_config_vector(d, entry);
>  }
>=20=20
>  void qvirtio_pci_destructor(QOSGraphObject *obj)
> @@ -371,6 +389,7 @@ static void qvirtio_pci_init_legacy(QVirtioPCIDevice =
*dev)
>  {
>      dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUBSYSTEM=
_ID);
>      dev->vdev.bus =3D &qvirtio_pci_legacy;
> +    dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
>      dev->vdev.big_endian =3D qtest_big_endian(dev->pdev->bus->qts);
>  }

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2gdEEACgkQ9GknjS8M
AjWSixAAkMK/3KpuDoTMlWeJq6Q8KUfxg5PqhdGHf/0+0X6jdpk6AZjPMJJ3D5Yh
AMpbCTQEyxZoe5zXSLnnSDOXDuvvQqMWWxw57tXXxVSTfOE591OaB3Rf/mxy7lrP
4XZlfaByn0rSIUqYk3SM4K/xeyjH6zpqPMH2CJByF9Yq79a1jD7tUtJh8F0amMh6
t2LYZ1bNrvPE/9SftoDNCWdKTYf2If+xxHEKSx0tNXMHeFE271aIBMBNO4lsZ90O
G4Ss0Y0zU9LcKwpAqMR4N/zMKtDtFtid2urY9w6oiS0OldM1qiRs/YHDgO9xE41y
FS+q779jPhpc8agXsOelHRlUVlAwwlUjFP0Aj6VctmtabfWUL5vDWPfp/OCwBui9
/SN+VemqLKj3B4Te9sP33hbtjFXGxprxSo86Xgd2MJeeYGCbtgmt+9SGMRv+Hk28
FY2mM692ymcUB/Tky+U1iOlJAMidh0dbP5jDXIwBrI8QNr0AkNjb5OKB+50iV2LG
wByOk3jUODhSmaaor4rO+x5lqaO9Ce8Z8nL1SUL3LxB6Oa0OZkRk+jFOtv1YLbxR
0AGEFgj6lCaGGhCsAommAMxoPntFdoJHNZ4Uc2kIF0alUgvsg+EnlvITVXJ4pRZ+
+M6OBLUvdh3Htuwo9mMfnPtlu2xv7m9D4lpv15OQULqaaXAYZBA=
=jA2h
-----END PGP SIGNATURE-----
--=-=-=--

