Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D0FC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 03:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3055214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 03:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gaca2R1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3055214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iweBM-0000sj-8M
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 22:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iweAY-0000Ma-Fr
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 22:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iweAW-00074z-PI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 22:37:34 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:51329)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iweAW-0006yZ-06; Tue, 28 Jan 2020 22:37:32 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 486q1K6FwVz9sPW; Wed, 29 Jan 2020 14:37:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580269045;
 bh=MLyRhoj51KYLPxS8cRRhAJDYuanJ8+tuWW4b3UATAJk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gaca2R1f5NTHAHtQ9ZpezW6OgP2ScSqx/1mzSqZ79L/1mcqkM0Z8TJCm8Gs3+OxA0
 8kFhrc9ytO7Qmd2qTn+VsvgCZ1oah9+7NJJbWXceSJDaG3e1NMPPcStVsIqcm9BAEl
 wahpn9d8gZl5KOAqLAyHWKeRTA+dwhFjvbt//haM=
Date: Wed, 29 Jan 2020 14:37:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu] spapr_pci: Create assigned properties for bridges
Message-ID: <20200129033712.GY42099@umbus.fritz.box>
References: <20200129023111.1699-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wnJX2LVqXtdJquW1"
Content-Disposition: inline
In-Reply-To: <20200129023111.1699-1-aik@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wnJX2LVqXtdJquW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 01:31:11PM +1100, Alexey Kardashevskiy wrote:
> QEMU assigns bus numbers so tell the guest about assigned values.
>=20
> This also adds an empty "ranges" to let the existing linux kernels proceed
> far enough to trigger resource reassignment (which is rather a
> hack).

That is rather a hack, but AIUI this makes things better than they
were before, so I've applied it to ppc-for-5.0.

What would a less hacky approach to this look like?

>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> This is a part of the "kill CAS reboot" effort, the SLOF's side of it was
> posted as "[PATCH slof] fdt: Fix creating new nodes at H_CAS"
>=20
> ---
>  hw/ppc/spapr_pci.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 723373de732c..877ff1d0d5fa 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1336,7 +1336,23 @@ static int spapr_dt_pci_bus(SpaprPhbState *sphb, P=
CIBus *bus,
>      if (pci_bus_is_root(bus)) {
>          owner =3D OBJECT(sphb);
>      } else {
> -        owner =3D OBJECT(pci_bridge_get_device(bus));
> +        PCIDevice *pdev =3D pci_bridge_get_device(bus);
> +        uint8_t pri =3D pci_default_read_config(pdev, PCI_PRIMARY_BUS, 1=
);
> +        uint8_t sec  =3D pci_default_read_config(pdev, PCI_SECONDARY_BUS=
, 1);
> +        uint8_t sub  =3D pci_default_read_config(pdev, PCI_SUBORDINATE_B=
US, 1);
> +        uint32_t range[] =3D { cpu_to_be32(sec), cpu_to_be32(sub) };
> +
> +        /*
> +         * Create these to get existing Linux kernels proceed far enough=
 to
> +         * trigger resource reassignment. We creates these for vPHB alre=
ady.
> +         */
> +        _FDT(fdt_setprop_cell(fdt, offset, "primary-bus", pri));
> +        _FDT(fdt_setprop_cell(fdt, offset, "secondary-bus", sec));
> +        _FDT(fdt_setprop_cell(fdt, offset, "subordinate-bus", sub));
> +        _FDT(fdt_setprop(fdt, offset, "bus-range", range, sizeof(range))=
);
> +        _FDT(fdt_setprop_string(fdt, offset, "device_type", "pci"));
> +        _FDT(fdt_setprop(fdt, offset, "ranges", NULL, 0));
> +        owner =3D OBJECT(pdev);
>      }
> =20
>      ret =3D spapr_dt_drc(fdt, offset, owner,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wnJX2LVqXtdJquW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4w/egACgkQbDjKyiDZ
s5Ku5Q/9HOJ6og/jEUHazAQPcbbgJjjydkc6SsszV2d2xxLgiTwUQE+DTt6gleeq
sQtXWmc5fHI0dIKUiHSR/V1hMaREX1Uv1sSkmHgsFhfF3jMtQQLai30FWucC4RDz
Ye2ycFia5aTkTp/oJgKZJkLKG84ts4sXC860aFEOwRkxSOvBrNZcLGjjSidwDy7H
eclS1gQ/Mn/w1pjsEojy0fwNTu9Ze4+6G1gi+p1SD1MP9MV1+8WQhzc4/MppPnwn
Izi4r1JywHjFq/xXAKrI0yUshhRfzZZIgUZZWIqlnuMmbPjNeBZh/328Uob0Fb+m
iLBrJ4aIYFtyBJulvRiG59RI+4320uKliPqUr1yL0KQ2ub/gIQnJ8w2sXmdxtBkO
O4kGi1N8E3I3ictHGzuLbkUIa93zXms/JctFFUm8/iCf/LVVIhH3yleRloy9LF5Z
LRPUdCFLvdT3R/RqghBtCRnWyY4SKDgovorDqyN1TbNgCzMzquxF0DYsFYg9qGK/
FkWw8ZDtKj1D/qPYv3gQGtGmf9EzKN9urxaKxy2AKkZaG0y8QJ1LDdkra6Xc4gTI
kSxrr49lTBZeE1Jka4Uec5ekagk5bvSgSjXffpoQITk4pYSNJUYObP96dqZP0maM
KcB4HgIhTMrixWN4A/xd6a4LTXhREqcvOTow1erU0xyYnamxeHc=
=/zr/
-----END PGP SIGNATURE-----

--wnJX2LVqXtdJquW1--

