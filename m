Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9465C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FF22190F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FF22190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iItxT-0005Kd-T0
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 08:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iItvs-00043h-HE
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iItvr-0002jU-AE
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:22:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iItvr-0002jG-1D
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:22:07 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E456FC057FA6
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 12:22:05 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id i2so4309185wrv.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 05:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=Jakrpdd8gtxEIqOy43mVaH1S94XS97FyyWbR/IJvm60=;
 b=CaP59ZlL9K9DxPM+myuxLr6dhuihV4sDapOg1LLT6On7ZY7WzBr0Kn/0NAsgKeg/LZ
 eASbVWJAOrfth/531spmKDYzkYIR1LrrZ+sx67vWervNj3aZ6CwTqn1xySA1DVOxoMZT
 uZ5IHzj9CWZjhuEVCpMn+ca/ZshJ9CRhzfFSVBbInnHZ7AHyzod8YlFNDuD5N+WxHYwS
 nzPIfBUhPW0q8KlaPCEfkmDIQGmEzWsta2MV8yn+LlhDzyRDR8Z/MfDfPzd6HD7m283z
 gYAefUGWwMqaWuSs8wfsb/i+bYbJJbSlid24UXWvBh+zex0P+onxxHqQfxoTBbhDGPv/
 stqg==
X-Gm-Message-State: APjAAAWltKVE4WsbrRivoxEm+XQKV0il1g3Hm/+f29Xmv1fRXap09lqd
 jdu4TF/WVJNpTGr8XJleNVuNBIren5J66jsS5yk3mChL8/cB5fAet1m8o2Eg5k+RPc6tfTEmIwT
 vcWNqaA98OzKrQdI=
X-Received: by 2002:a5d:4fcd:: with SMTP id h13mr10291658wrw.307.1570796524347; 
 Fri, 11 Oct 2019 05:22:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz3vi7zvLOP4aVU6Kyvfvpw1/9xpfnzuIT8ce/aUYy0Dhkt4Srf7bRgwsYb32Dj5mHIc22RWg==
X-Received: by 2002:a5d:4fcd:: with SMTP id h13mr10291640wrw.307.1570796524161; 
 Fri, 11 Oct 2019 05:22:04 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id x129sm14619422wmg.8.2019.10.11.05.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 05:22:03 -0700 (PDT)
References: <20191011085611.4194-1-stefanha@redhat.com>
 <20191011085611.4194-3-stefanha@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 2/7] libqos: add iteration support to
 qpci_find_capability()
In-reply-to: <20191011085611.4194-3-stefanha@redhat.com>
Date: Fri, 11 Oct 2019 14:22:01 +0200
Message-ID: <8736fzcw0m.fsf@redhat.com>
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

> VIRTIO 1.0 PCI devices have multiple PCI_CAP_ID_VNDR capabilities so we
> need a way to iterate over them.  Extend qpci_find_capability() to take
> the last address.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/libqos/pci.h |  2 +-
>  tests/libqos/pci.c | 18 ++++++++++++------
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
> index a5389a5845..590c175190 100644
> --- a/tests/libqos/pci.h
> +++ b/tests/libqos/pci.h
> @@ -86,7 +86,7 @@ bool qpci_has_buggy_msi(QPCIDevice *dev);
>  bool qpci_check_buggy_msi(QPCIDevice *dev);
>=20=20
>  void qpci_device_enable(QPCIDevice *dev);
> -uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id);
> +uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_=
addr);
>  void qpci_msix_enable(QPCIDevice *dev);
>  void qpci_msix_disable(QPCIDevice *dev);
>  bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
> diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
> index 662ee7a517..b8679dff1d 100644
> --- a/tests/libqos/pci.c
> +++ b/tests/libqos/pci.c
> @@ -115,10 +115,16 @@ void qpci_device_enable(QPCIDevice *dev)
>      g_assert_cmphex(cmd & PCI_COMMAND_MASTER, =3D=3D, PCI_COMMAND_MASTER=
);
>  }
>=20=20
> -uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id)
> +uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_=
addr)
>  {
>      uint8_t cap;
> -    uint8_t addr =3D qpci_config_readb(dev, PCI_CAPABILITY_LIST);
> +    uint8_t addr;
> +
> +    if (start_addr) {
> +        addr =3D qpci_config_readb(dev, start_addr + PCI_CAP_LIST_NEXT);
> +    } else {
> +        addr =3D qpci_config_readb(dev, PCI_CAPABILITY_LIST);
> +    }
>=20=20
>      do {
>          cap =3D qpci_config_readb(dev, addr);
> @@ -138,7 +144,7 @@ void qpci_msix_enable(QPCIDevice *dev)
>      uint8_t bir_table;
>      uint8_t bir_pba;
>=20=20
> -    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX);
> +    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
>      g_assert_cmphex(addr, !=3D, 0);
>=20=20
>      val =3D qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
> @@ -167,7 +173,7 @@ void qpci_msix_disable(QPCIDevice *dev)
>      uint16_t val;
>=20=20
>      g_assert(dev->msix_enabled);
> -    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX);
> +    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
>      g_assert_cmphex(addr, !=3D, 0);
>      val =3D qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
>      qpci_config_writew(dev, addr + PCI_MSIX_FLAGS,
> @@ -203,7 +209,7 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
>      uint64_t vector_off =3D dev->msix_table_off + entry * PCI_MSIX_ENTRY=
_SIZE;
>=20=20
>      g_assert(dev->msix_enabled);
> -    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX);
> +    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
>      g_assert_cmphex(addr, !=3D, 0);
>      val =3D qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
>=20=20
> @@ -221,7 +227,7 @@ uint16_t qpci_msix_table_size(QPCIDevice *dev)
>      uint8_t addr;
>      uint16_t control;
>=20=20
> -    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX);
> +    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
>      g_assert_cmphex(addr, !=3D, 0);
>=20=20
>      control =3D qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2gc+kACgkQ9GknjS8M
AjXaMxAAhyPZsFtkBwQAN8uCiGRx5xPcdbntPiM9tGkdR4YmvK7ZOlzvXArtSVnz
fSPhY/BkMwjG6v7E4aKFPeYNRmI9PsRiej5mh0TSV7hT1TleSDHsjmi+Koq9BIZp
IcCatcYN/1bkiUhSsyLOIXA8tZZHdIqc2RxXrQsbeWGMVGIvbw2wxZrCzuBrhXUG
Q6FroEnpE6ENhNAYfm577COpw/7ceekysDzYaFYCUC61sNLi3StfY/hu/dXQbtFv
YMcToVKs3ruedaGLQJixhuT/yFDxQTqkYEzjcg5jDhWAC1Aok33jhZxeVKIXsq6U
wn0Z6YpXH2ZR0eeRtRzJr4B3DxDyyD4tE0Lubvs/4aDtHWEsit/8L+s6g4ayCi1B
7zmHQLHY8cMDvkgYJImCvSODv70Rr7OE5/lylmW36lJpsyWhAznUjiz+7FPgULXu
iSYmjmCV1X2t+99g0EbA/9FkiTgLj2v+OPRxI54httyvaqqypc+5P5yNBUSDU4ob
KJT6xPW8PjGKYlaJT8CHvDVee3hK6K6BUk5VaJpcEZ8M4ZDf7R3XGHU+juVY3PzQ
w9+++CU0QR2pc3XQ15ndaz1VajDzcYjvYugXsNLgzPJ4PkD0YSI7Ml4QJcn6iCgd
1jbWToPncLPsWVH49FClbimi7adxg2mHBt4q9SKiNWUSPd2qwRE=
=3gcU
-----END PGP SIGNATURE-----
--=-=-=--

