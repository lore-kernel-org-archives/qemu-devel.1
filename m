Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782D1C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 06:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E3D206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 06:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DQydiAJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E3D206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwgu8-0004hm-E9
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 01:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iwgsD-0002Qy-Hm
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 01:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iwgsC-0008Ny-2b
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 01:30:49 -0500
Received: from ozlabs.org ([203.11.71.1]:54241)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iwgsB-0008K2-5I; Wed, 29 Jan 2020 01:30:48 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 486tsG2bM0z9sPK; Wed, 29 Jan 2020 17:30:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580279442;
 bh=OTyr7VTqhuMws5D0OO/Wvh09PnkBArZf3MdS5Lqe+ew=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DQydiAJy893TQI0843D5Hlhv1At7Y5e75t+agK95A2rwFBUJFtE0Zw0DTjpnHjRHB
 yxpfgzBeDP/SPXo8ZIrNwSe7sH/afFFloXjSwnk57V6rApvFEa+vXJZHsckQCnVKe7
 Qyivwv/hGl0ennk5HrUFicWEpN+RPtsqo9q6zCeI=
Date: Wed, 29 Jan 2020 17:16:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 1/2] ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge
Message-ID: <20200129061635.GA42099@umbus.fritz.box>
References: <20200127144506.11132-1-clg@kaod.org>
 <20200127144506.11132-2-clg@kaod.org>
 <20200129030920.GX42099@umbus.fritz.box>
 <CAOSf1CHvYOMd2cjQDLT44QxyQakkV6a8eBrWX+V6FhQMQh2GWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eGwLO2yoW8Ya4hN1"
Content-Disposition: inline
In-Reply-To: <CAOSf1CHvYOMd2cjQDLT44QxyQakkV6a8eBrWX+V6FhQMQh2GWA@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--eGwLO2yoW8Ya4hN1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 02:54:19PM +1100, Oliver O'Halloran wrote:
> On Wed, Jan 29, 2020 at 2:09 PM David Gibson
> <david@gibson.dropbear.id.au> wrote:
> >
> > On Mon, Jan 27, 2020 at 03:45:05PM +0100, C=E9dric Le Goater wrote:
> > > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > >
>=20
> *snip*
>=20
> > > +
> > > +/*
> > > + * The CONFIG_DATA register expects little endian accesses, but as t=
he
> > > + * region is big endian, we have to swap the value.
> > > + */
> > > +static void pnv_phb4_config_write(PnvPHB4 *phb, unsigned off,
> > > +                                  unsigned size, uint64_t val)
> > > +{
> > > +    uint32_t cfg_addr, limit;
> > > +    PCIDevice *pdev;
> > > +
> > > +    pdev =3D pnv_phb4_find_cfg_dev(phb);
> > > +    if (!pdev) {
> > > +        return;
> > > +    }
> > > +    cfg_addr =3D (phb->regs[PHB_CONFIG_ADDRESS >> 3] >> 32) & 0xffc;
> > > +    cfg_addr |=3D off;
> > > +    limit =3D pci_config_size(pdev);
> > > +    if (limit <=3D cfg_addr) {
> > > +        /*
> > > +         * conventional pci device can be behind pcie-to-pci bridge.
> > > +         * 256 <=3D addr < 4K has no effects.
> > > +         */
> > > +        return;
> > > +    }
> > > +    switch (size) {
> > > +    case 1:
> > > +        break;
> > > +    case 2:
> > > +        val =3D bswap16(val);
> >
> > I'm a little confused by these byteswaps.  As I see below the device
> > is set to big endian, so the values passed in here should already be
> > in host-native endian.  Why do you need the swap?  Are some of the
> > registers in the bank BE and some LE?
>=20
> All the registers are BE except for CONFIG_DATA, which isn't actually
> a register. It's really a window into the config space of the device
> specified in CONFIG_ADDR so it doesn't do any byte-swapping.

Ah, right, that makes sense.

>=20
> > > +        break;
> > > +    case 4:
> > > +        val =3D bswap32(val);
> > > +        break;
> > > +    default:
> > > +        g_assert_not_reached();
> > > +    }
> > > +    pci_host_config_write_common(pdev, cfg_addr, limit, val, size);
> > > +}
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eGwLO2yoW8Ya4hN1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4xI0AACgkQbDjKyiDZ
s5LLRw/5ARvpO6HxH0dQJnXw9I+mw6AVXH+dkHmrZ3Z0a6IhP0HPOKPNt4NR8c6k
5SjJsSitGz0fyAY662rLZ0Z0eoRGq4o09oXaiTX74QVlU6bYMtip6oQE9irNlXTW
tBAmpF+aVcT7+KmpCaCKmYKyPou9Og3F+Oj3tDH+CtzkQ7RF2i3ug6ybuBh9SOcD
rAE1++R0PmbGrUJsatfEu+Ia41HszrtZKb0WK1Re2BDkgrEELNORYX7oRLyReYXS
kIzr15i5dndeByT92RFGzvvkMsExrBFimuRpwjmdemmZG+doToIVQh22Fx47ssao
niOpAuwmMO6VCDxfkWfPz+91t/wvtxwWP58BBZw/BZyOZz8yJkA0s3OL5bWEMIKg
ZVtlG6PUCL5pc7EZ8fiCmMoWKVcFWYNoE8fJaCLBa3I1PZosrU6pgHYRbyKaBckY
ZRKWJuDsOl9I4wKkYQaIirEJ2k7vzXot58KOUaTcOYaok/uCUBFoc9mllqZ4fBBU
XY3RtXtygApJeYVVqNQClPGSZ5S5mFtQ82CExFcksyaUR97iK2xt7E2wG+hlJSh2
NwCPcpfdEt4Nr4vT7MZeBudVhzkoIMuGDxmK/lDy/E11qHV2hl/3oY2CcKITVMHn
NiBSrJAukcyt1lr6LHnyALnJ6XJ9BGwe5+HCSOiWOSItKevmTe4=
=NVMH
-----END PGP SIGNATURE-----

--eGwLO2yoW8Ya4hN1--

