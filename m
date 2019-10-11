Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191E8C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E270A21A4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E270A21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iItw9-00042j-1b
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 08:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iItuk-0003Ss-Bl
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iItuj-0002Im-89
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:20:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iItui-0002IK-Vb
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:20:57 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E84294ACA5
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 12:20:55 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id c188so2701502wmd.9
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 05:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=wF4cKqd5QM/MyZHnnVprDhZTIVmR4Nt6k9wXlRbOu2A=;
 b=FifwTuI9rNhZuxh142k8BpDHl0YrVZ5lZn13C5njfq5NF8wSqYfA7CfBii/IJEE5St
 2n7jpneM5aVs2/GPTnEvYLvBLyjJFsJ/DQwdE2rr1shTeoG/6C595+ECIiZuN7Y+xqQl
 rOMkiIf+oW68MsG6r9fhALCbYSOTQRMIbhIwohznGNbsnxrb6AcjKqrSOMirQcg/prNV
 5AX+u5JJ9jS1to+xMvPvTeknTekgRwYwC9c8euMcy10REjolOdn8+B/R4HSY4C+NRlX2
 I3A/p0HU05U4kSvnnjOJrcHDG8sBPPp8OpHH/cSd2FDhARaM8I190BOlU/dMapx3JSFm
 ZIvA==
X-Gm-Message-State: APjAAAWShkzkBZ2LDmFnAo6rP3EtTjOlBpA52KwbyuqD/JgG6aZS6vZ8
 w28rS0J8FmA7UDzROnbW3GDH01vAp7FoSnLk6rU+mRaY5kyIRBDUdXwAM25c+UJ0ovth5IvJ9rk
 8+tAjGaLHJO5LuHs=
X-Received: by 2002:adf:82ab:: with SMTP id 40mr12475259wrc.251.1570796454634; 
 Fri, 11 Oct 2019 05:20:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyOdtWONRLbLXuNQMt0xXKM27ZWRCZREJ2uvWUHwXEHHYq1qEQG52ajrQhA5ZiNM7mdc29j8w==
X-Received: by 2002:adf:82ab:: with SMTP id 40mr12475239wrc.251.1570796454400; 
 Fri, 11 Oct 2019 05:20:54 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id z189sm14200835wmc.25.2019.10.11.05.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 05:20:53 -0700 (PDT)
References: <20191011085611.4194-1-stefanha@redhat.com>
 <20191011085611.4194-2-stefanha@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 1/7] libqos: extract Legacy virtio-pci.c code
In-reply-to: <20191011085611.4194-2-stefanha@redhat.com>
Date: Fri, 11 Oct 2019 14:20:51 +0200
Message-ID: <874l0fcw2k.fsf@redhat.com>
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

> The current libqos virtio-pci.c code implements the VIRTIO Legacy
> interface.  Extract existing code in preparation for VIRTIO 1.0 support.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/libqos/virtio-pci.h |  2 --
>  tests/libqos/virtio-pci.c | 25 ++++++++++---------------
>  2 files changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
> index 728b4715f1..0d105d67b3 100644
> --- a/tests/libqos/virtio-pci.h
> +++ b/tests/libqos/virtio-pci.h
> @@ -31,8 +31,6 @@ typedef struct QVirtQueuePCI {
>      uint32_t msix_data;
>  } QVirtQueuePCI;
>=20=20
> -extern const QVirtioBus qvirtio_pci;
> -
>  void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress * =
addr);
>  QVirtioPCIDevice *virtio_pci_new(QPCIBus *bus, QPCIAddress * addr);
>=20=20
> diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
> index 50499e75ef..c8d736f4d1 100644
> --- a/tests/libqos/virtio-pci.c
> +++ b/tests/libqos/virtio-pci.c
> @@ -35,14 +35,6 @@
>   * original qvirtio_pci_destructor and qvirtio_pci_start_hw.
>   */
>=20=20
> -static inline bool qvirtio_pci_is_big_endian(QVirtioPCIDevice *dev)
> -{
> -    QPCIBus *bus =3D dev->pdev->bus;
> -
> -    /* FIXME: virtio 1.0 is always little-endian */
> -    return qtest_big_endian(bus->qts);
> -}
> -
>  #define CONFIG_BASE(dev) (VIRTIO_PCI_CONFIG_OFF((dev)->pdev->msix_enable=
d))
>=20=20
>  static uint8_t qvirtio_pci_config_readb(QVirtioDevice *d, uint64_t off)
> @@ -55,8 +47,7 @@ static uint8_t qvirtio_pci_config_readb(QVirtioDevice *=
d, uint64_t off)
>   * but virtio ( < 1.0) is in guest order
>   * so with a big-endian guest the order has been reversed,
>   * reverse it again
> - * virtio-1.0 is always little-endian, like PCI, but this
> - * case will be managed inside qvirtio_pci_is_big_endian()
> + * virtio-1.0 is always little-endian, like PCI
>   */
>=20=20
>  static uint16_t qvirtio_pci_config_readw(QVirtioDevice *d, uint64_t off)
> @@ -258,7 +249,7 @@ static void qvirtio_pci_virtqueue_kick(QVirtioDevice =
*d, QVirtQueue *vq)
>      qpci_io_writew(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_NOTIFY, vq->ind=
ex);
>  }
>=20=20
> -const QVirtioBus qvirtio_pci =3D {
> +static const QVirtioBus qvirtio_pci_legacy =3D {
>      .config_readb =3D qvirtio_pci_config_readb,
>      .config_readw =3D qvirtio_pci_config_readw,
>      .config_readl =3D qvirtio_pci_config_readl,
> @@ -374,15 +365,19 @@ void qvirtio_pci_start_hw(QOSGraphObject *obj)
>      qvirtio_start_device(&dev->vdev);
>  }
>=20=20
> +static void qvirtio_pci_init_legacy(QVirtioPCIDevice *dev)
> +{
> +    dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUBSYSTEM=
_ID);
> +    dev->vdev.bus =3D &qvirtio_pci_legacy;
> +    dev->vdev.big_endian =3D qtest_big_endian(dev->pdev->bus->qts);
> +}
> +
>  static void qvirtio_pci_init_from_pcidev(QVirtioPCIDevice *dev, QPCIDevi=
ce *pci_dev)
>  {
>      dev->pdev =3D pci_dev;
> -    dev->vdev.device_type =3D qpci_config_readw(pci_dev, PCI_SUBSYSTEM_I=
D);
> -
>      dev->config_msix_entry =3D -1;
>=20=20
> -    dev->vdev.bus =3D &qvirtio_pci;
> -    dev->vdev.big_endian =3D qvirtio_pci_is_big_endian(dev);
> +    qvirtio_pci_init_legacy(dev);
>=20=20
>      /* each virtio-xxx-pci device should override at least this function=
 */
>      dev->obj.get_driver =3D NULL;

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2gc6MACgkQ9GknjS8M
AjVLsQ/+NvBkC+mR4sY4zG2n56RO0V96v8uRCWf4FBxsfFb4ucXI3E9k0PA8byP9
4R6oX6E+L5S6RmXUNWz+V8A1o6RAg+GbheLGFC9+SYt3+iM0zfcuwz2nfL3oplau
NPU12cPmFcHwu0Qf120+LpYEa3t5jf/ghJX5l2wn/GqeBdHlVxLD57WsHk68yO01
XoP3q6gcPI4KZFmW49lrbwfEPnKeMDVcn/JoAm+iWuHyMwOXaQfP5cWkXMiwZLla
XsvAkt+nxI1inHLxOvLfZKtDwl8BAIzKRnlSQHDsDGMuGKhIBpvEFoIF3Q3EOQTc
2+fy7O60CyJDUGEiO50ec580BwinoHQiL5TXcIcmyHYV4NYN5xwC8quhTeZw5P83
BF6hgvEVuYPiSxj8zCqKIm+ZNEdoA8q5oVT+PNn1dp1JpihKn651V4gL8SIPS+oX
25AZftOHo1s1ujbgHd8itKCesyJ7VLi5xRGiPiW1fKBxop6UXRLuXaD8Oe/jqajQ
fN/tOTt5N8yKd4zLI7RwlLJGC/yYq/tJKBrmOvzI3KM2v1CS/V6igP2jFNbYhYen
4LOKn/hidNDSvTiMeVYIeMmwohrRQfVY70ZenqklDsW/CKLr/3VKDh9o69puiWds
y44qDQ9iTxRtPDGURasHQEp3XdO2sSAPDNVUOFSRJz2RXE8SdPs=
=c2ig
-----END PGP SIGNATURE-----
--=-=-=--

