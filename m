Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E631C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 01:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1640A22B48
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 01:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gQ/xFoNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1640A22B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igfIl-0002Mz-VH
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 20:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1igfHX-0000md-BJ
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 20:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1igfHV-0003vz-PC
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 20:34:43 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:48899 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1igfHU-0003r7-Vk; Sun, 15 Dec 2019 20:34:41 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47bkMs4zCtz9sQp; Mon, 16 Dec 2019 12:34:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576460073;
 bh=gnujiirHHa9mSdoe20bRQXDzsy3EU5Du6XIOCow943c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gQ/xFoNVDpYlcgVIwJdfylWUjvpoLg8bN+P6bskX8Xa3fZBUfXTnXOYcSE7GoJoO+
 pIzNuf3Def4XB4jFCTPpOuiiuh6geDbm59EZYO/OOIo/B5NbFhAo5g2/ZX5cQP2GRR
 LSrUUbYYMpZcajBl1zx/cF9vSNDlffegdq6eBYjQ=
Date: Mon, 16 Dec 2019 12:32:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 12/13] ppc/pnv: Introduce PnvChipClass::xscom_pcba() method
Message-ID: <20191216013259.GA6242@umbus.fritz.box>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
 <157623843543.360005.13996472463887521794.stgit@bahia.lan>
 <07d68959-4f71-56cd-75e7-2035d770535b@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <07d68959-4f71-56cd-75e7-2035d770535b@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2019 at 02:06:31PM +0100, C=E9dric Le Goater wrote:
> On 13/12/2019 13:00, Greg Kurz wrote:
> > The XSCOM bus is implemented with a QOM interface, which is mostly
> > generic from a CPU type standpoint, except for the computation of
> > addresses on the Pervasize Connect Bus (PCB) network. This is handled
>=20
> Pervasive

I've fixed this typo in transit.

>=20
> > by the pnv_xscom_pcba() function with a switch statement based on
> > the chip_type class level attribute of the CPU chip.
> >=20
> > This can be achieved using QOM. Also the address argument is masked with
> > PNV_XSCOM_SIZE - 1, which is for POWER8 only. Addresses may have differ=
ent
> > sizes with other CPU types. Have each CPU chip type handle the appropri=
ate
> > computation with a QOM xscom_pcba() method.
>=20
> PnvXscom model ? :)
>=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> > ---
> >  hw/ppc/pnv.c         |   23 +++++++++++++++++++++++
> >  hw/ppc/pnv_xscom.c   |   14 +-------------
> >  include/hw/ppc/pnv.h |    1 +
> >  3 files changed, 25 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 0447b534b8c5..cc40b90e9cd2 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -1121,6 +1121,12 @@ static void pnv_chip_power8_realize(DeviceState =
*dev, Error **errp)
> >                                  &chip8->homer.regs);
> >  }
> > =20
> > +static uint32_t pnv_chip_power8_xscom_pcba(PnvChip *chip, uint64_t add=
r)
> > +{
> > +    addr &=3D (PNV_XSCOM_SIZE - 1);
> > +    return ((addr >> 4) & ~0xfull) | ((addr >> 3) & 0xf);
> > +}
> > +
> >  static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > @@ -1138,6 +1144,7 @@ static void pnv_chip_power8e_class_init(ObjectCla=
ss *klass, void *data)
> >      k->dt_populate =3D pnv_chip_power8_dt_populate;
> >      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> >      k->xscom_core_base =3D pnv_chip_power8_xscom_core_base;
> > +    k->xscom_pcba =3D pnv_chip_power8_xscom_pcba;
> >      dc->desc =3D "PowerNV Chip POWER8E";
> > =20
> >      device_class_set_parent_realize(dc, pnv_chip_power8_realize,
> > @@ -1161,6 +1168,7 @@ static void pnv_chip_power8_class_init(ObjectClas=
s *klass, void *data)
> >      k->dt_populate =3D pnv_chip_power8_dt_populate;
> >      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> >      k->xscom_core_base =3D pnv_chip_power8_xscom_core_base;
> > +    k->xscom_pcba =3D pnv_chip_power8_xscom_pcba;
> >      dc->desc =3D "PowerNV Chip POWER8";
> > =20
> >      device_class_set_parent_realize(dc, pnv_chip_power8_realize,
> > @@ -1184,6 +1192,7 @@ static void pnv_chip_power8nvl_class_init(ObjectC=
lass *klass, void *data)
> >      k->dt_populate =3D pnv_chip_power8_dt_populate;
> >      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> >      k->xscom_core_base =3D pnv_chip_power8_xscom_core_base;
> > +    k->xscom_pcba =3D pnv_chip_power8_xscom_pcba;
> >      dc->desc =3D "PowerNV Chip POWER8NVL";
> > =20
> >      device_class_set_parent_realize(dc, pnv_chip_power8_realize,
> > @@ -1340,6 +1349,12 @@ static void pnv_chip_power9_realize(DeviceState =
*dev, Error **errp)
> >                                  &chip9->homer.regs);
> >  }
> > =20
> > +static uint32_t pnv_chip_power9_xscom_pcba(PnvChip *chip, uint64_t add=
r)
> > +{
> > +    addr &=3D (PNV9_XSCOM_SIZE - 1);
> > +    return addr >> 3;
> > +}
> > +
> >  static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > @@ -1357,6 +1372,7 @@ static void pnv_chip_power9_class_init(ObjectClas=
s *klass, void *data)
> >      k->dt_populate =3D pnv_chip_power9_dt_populate;
> >      k->pic_print_info =3D pnv_chip_power9_pic_print_info;
> >      k->xscom_core_base =3D pnv_chip_power9_xscom_core_base;
> > +    k->xscom_pcba =3D pnv_chip_power9_xscom_pcba;
> >      dc->desc =3D "PowerNV Chip POWER9";
> > =20
> >      device_class_set_parent_realize(dc, pnv_chip_power9_realize,
> > @@ -1422,6 +1438,12 @@ static void pnv_chip_power10_realize(DeviceState=
 *dev, Error **errp)
> >                                              (uint64_t) PNV10_LPCM_BASE=
(chip));
> >  }
> > =20
> > +static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t ad=
dr)
> > +{
> > +    addr &=3D (PNV10_XSCOM_SIZE - 1);
> > +    return addr >> 3;
> > +}
> > +
> >  static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > @@ -1439,6 +1461,7 @@ static void pnv_chip_power10_class_init(ObjectCla=
ss *klass, void *data)
> >      k->dt_populate =3D pnv_chip_power10_dt_populate;
> >      k->pic_print_info =3D pnv_chip_power10_pic_print_info;
> >      k->xscom_core_base =3D pnv_chip_power10_xscom_core_base;
> > +    k->xscom_pcba =3D pnv_chip_power10_xscom_pcba;
> >      dc->desc =3D "PowerNV Chip POWER10";
> > =20
> >      device_class_set_parent_realize(dc, pnv_chip_power10_realize,
> > diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> > index 5ae9dfbb88ad..b681c72575b2 100644
> > --- a/hw/ppc/pnv_xscom.c
> > +++ b/hw/ppc/pnv_xscom.c
> > @@ -57,19 +57,7 @@ static void xscom_complete(CPUState *cs, uint64_t hm=
er_bits)
> > =20
> >  static uint32_t pnv_xscom_pcba(PnvChip *chip, uint64_t addr)
> >  {
> > -    addr &=3D (PNV_XSCOM_SIZE - 1);
> > -
> > -    switch (PNV_CHIP_GET_CLASS(chip)->chip_type) {
> > -    case PNV_CHIP_POWER8E:
> > -    case PNV_CHIP_POWER8:
> > -    case PNV_CHIP_POWER8NVL:
> > -        return ((addr >> 4) & ~0xfull) | ((addr >> 3) & 0xf);
> > -    case PNV_CHIP_POWER9:
> > -    case PNV_CHIP_POWER10:
> > -        return addr >> 3;
> > -    default:
> > -        g_assert_not_reached();
> > -    }
> > +    return PNV_CHIP_GET_CLASS(chip)->xscom_pcba(chip, addr);
> >  }
> > =20
> >  static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
> > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > index 7a134a15d3b5..4972e93c2619 100644
> > --- a/include/hw/ppc/pnv.h
> > +++ b/include/hw/ppc/pnv.h
> > @@ -138,6 +138,7 @@ typedef struct PnvChipClass {
> >      void (*dt_populate)(PnvChip *chip, void *fdt);
> >      void (*pic_print_info)(PnvChip *chip, Monitor *mon);
> >      uint64_t (*xscom_core_base)(PnvChip *chip, uint32_t core_id);
> > +    uint32_t (*xscom_pcba)(PnvChip *chip, uint64_t addr);
> >  } PnvChipClass;
> > =20
> >  #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl323ssACgkQbDjKyiDZ
s5ICZRAAsVHyA5VPTkHfAWrgI8J+f/IEn3PC1Ojjz/2z496IlzgGwqhpm0KURZkR
diyI09QSUe4Hc2lrsY/qTEC924f2vpz7sh2njvVskmzY9XBLrOf0TtmEEE4pWDdj
edWPGTObxVVo7rYmxDrz/ue/+w1kx2DkGBllf0WNnZojhX8pYQ0f9FQ9G7/LVYlo
ynO/EMcsunOPDpB561Gp5FKjOWmHszCyc32kuYIDCKnPzzg3CyRpgbNSLDMp6+b7
tRL5grRZY9wDW2v4nzlI4wu/Mheq0AnR230DDwrNh8Rh01e+0AOEtAucVsKRDjFB
OW26rlw0t1QC1usBfNfssijPgvsDW4gsMu7H27LSKrRN/vDQm3/OxasmMr6n3kb0
pB0Bb2cWxP6sexgBoe6XyJ9is9a8gZVdKlaAiKQiolvO1n2laWnEm0M0bDIHP0og
YtslXnMwP61XXLrifA9t8ZulJlHycT0kPCqXqPKmkhEJepPzzIr5OuO7biHAd+As
4hkz8N80IjRjQLo6xYGOkt+0Ih89BR2H1N2OsI4bf/MOdZYrrz4euye8IWcjIGZe
haWBVTKaXeP2k5ANm3f7qItR4VMqzf6mNWne+0+VG7Nom2ykvtc+KJspnZ1RSXY/
LmMxc6E+eDw0LAKhr5QHd6VRzpTpxEI8aSwqL6zXPPqqyWEyJbc=
=RUDz
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

