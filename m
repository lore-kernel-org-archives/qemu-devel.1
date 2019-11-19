Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F363C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 22:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B6222440
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 22:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Vq0aU6Lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B6222440
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXBdW-00044R-U8
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 17:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXBb3-0002IZ-1g
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 17:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXBb1-0007pL-4z
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 17:03:40 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36835 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXBb0-0007nG-Pi; Tue, 19 Nov 2019 17:03:39 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47HfwP1FB9z9sPL; Wed, 20 Nov 2019 09:03:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574201013;
 bh=bz3VgbM5bcPHwm4BRnE/W8qR+9GDx8v3N8D87H8bK5A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vq0aU6Lx2j7gMtSIxn/cOFqw17ApjVfEb4DCT30P+Qs1S1HL9TtPiKW8gxy+wJNX8
 wlptoKNe5noZMtUj9ZOa94SzRfsoZ0tAvushL5ZMMhwDBC7aoQ7rFYPSeDBgoCsXOk
 CBzgJB6bFy1cKnoaf52WbOB7AXrNW6dOf0Kf0F+g=
Date: Wed, 20 Nov 2019 09:00:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Balamuruhan S <bala24@linux.ibm.com>
Subject: Re: [PATCH 2/5] hw/ppc/pnv_xscom: PBA bar mask values are incorrect
 with homer/occ sizes
Message-ID: <20191119220032.GV5582@umbus.fritz.box>
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-3-bala24@linux.ibm.com>
 <20191119215618.GU5582@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NHfequSh1hmJPP0s"
Content-Disposition: inline
In-Reply-To: <20191119215618.GU5582@umbus.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NHfequSh1hmJPP0s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 08:56:18AM +1100, David Gibson wrote:
> On Tue, Nov 19, 2019 at 11:20:53PM +0530, Balamuruhan S wrote:
> > homer/occ sizes are calculated in skiboot with `(mask | 0xfffff) + 1`,
> > and from xscom access should return correct mask values instead of actu=
al
> > sizes.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > ---
> >  hw/ppc/pnv_xscom.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> > index f01d788a65..cdd5fa356e 100644
> > --- a/hw/ppc/pnv_xscom.c
> > +++ b/hw/ppc/pnv_xscom.c
> > @@ -46,6 +46,10 @@
> >  #define P9_PBA_BARMASK0                 0x5012b04
> >  #define P9_PBA_BARMASK2                 0x5012b06
> > =20
> > +/* Mask to calculate Homer/Occ size */
> > +#define HOMER_SIZE_MASK                 0x0000000000300000ull
> > +#define OCC_SIZE_MASK                   0x0000000000700000ull
>=20
> Uuuhhhhh... AFAICT these defines have identical values to
> PNV_HOMER_SIZE and PNV_OCC_COMMON_AREA_SIZE, so I don't see what this
> patch is actually changing.

Oh, sorry, missed that the values were changed in 1/5.  Would have
been easier to follow if the two patches were folded together, but
never mind.  Applied.

>=20
>=20
> >  static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
> >  {
> >      /*
> > @@ -90,9 +94,8 @@ static uint64_t xscom_read_default(PnvChip *chip, uin=
t32_t pcba)
> >          return PNV_HOMER_BASE(chip);
> > =20
> >      case P9_PBA_BARMASK0: /* P9 homer region size */
> > -        return PNV9_HOMER_SIZE;
> >      case P8_PBA_BARMASK0: /* P8 homer region size */
> > -        return PNV_HOMER_SIZE;
> > +        return HOMER_SIZE_MASK;
> > =20
> >      case P9_PBA_BAR2: /* P9 occ common area */
> >          return PNV9_OCC_COMMON_AREA(chip);
> > @@ -100,9 +103,8 @@ static uint64_t xscom_read_default(PnvChip *chip, u=
int32_t pcba)
> >          return PNV_OCC_COMMON_AREA(chip);
> > =20
> >      case P9_PBA_BARMASK2: /* P9 occ common area size */
> > -        return PNV9_OCC_COMMON_AREA_SIZE;
> >      case P8_PBA_BARMASK2: /* P8 occ common area size */
> > -        return PNV_OCC_COMMON_AREA_SIZE;
> > +        return OCC_SIZE_MASK;
> > =20
> >      case 0x1010c00:     /* PIBAM FIR */
> >      case 0x1010c03:     /* PIBAM FIR MASK */
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NHfequSh1hmJPP0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3UZgAACgkQbDjKyiDZ
s5JLtA/+Jo93ouDOCJ63bsiPmfyP910FeQtE/QvjjEVcS68LoAaV1V5hM8RJTVf/
DYsszQWmCqwCSCIKaYdytATnwqQqFzo2RP8K6NxNOzeaBOTEQ+wfJFpHSaejEEU4
ccnxAj9wBkvUxvyZQWK4gA9700trr4iGiFQGU7lQhQH+0/xEPrQwd4ODj8MRpquH
3LTLVmHMHZGavxU02cPjxLXo+gnS2v8ApdTOsY111IXOoe6b17eYeC+dL5JNQtU5
9TF8+vjb9PGh6cQEvdCSF1fnXc6myTcAgM9FJnSXKDdp/1/P0d6B9/9BJfbskPTH
vgaMM5N3sx4r4SUbfozaDjMmdZNpb/DIWhpxu1zYL+NfbDfjN7CuuRmW7Ydt8lYT
2nzJ/TzKRMBEYCB+ZY/mfWplouTnmBFie4ULKkzlw6IMw5P5FeBllvQhz7j7x0hT
NW63gJbvr1/pHDWLw2RayjdPS68CLgAjMk70U7lOIVe+W+O7SqUkZ9ZYEbymP1f2
TMYXmanas7X1JqG/oBkhGJl//CY1UQsmc1PJXA4/ZCmhKxJSGtpn60DPTLzALOW5
qA91QCbTL3oxUy/clekhuRYFD/O3e0z8x2ynKnjKtKnWt5y/7Hw3lX6lOLFav5Rq
ZnrrNOSWwtVvgft3/Rxyb1DEdOGAKad/q3A3lyJ0rUgxXp4wjnE=
=braH
-----END PGP SIGNATURE-----

--NHfequSh1hmJPP0s--

