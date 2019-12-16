Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D083C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 01:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4544D22B48
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 01:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="H+7PmuYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4544D22B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igfIj-0002JT-3t
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 20:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1igfHX-0000mc-9b
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 20:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1igfHV-0003wE-TE
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 20:34:43 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45655 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1igfHU-0003r6-NZ; Sun, 15 Dec 2019 20:34:41 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47bkMs4Fybz9sP6; Mon, 16 Dec 2019 12:34:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576460073;
 bh=3sA2X89tv8lwuDTMB9Qi381MLK7eBRsYKTRuv+ZBr0A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H+7PmuYxGRs2S8WbMLOhO7GS2dit0oEbVFBSCeoswPVl6i8bG/52QOjeFUpZ0gyj5
 8ANr4ib8FxozVxrRKXYDaMHyAyvtp27X2lLt9/qy4mKJeYTisx8iEVsGXc2b4/Yi8c
 gTFRFO1f1hmFgjld2lEEvcQ5Sr/nQBakGEacVnwI=
Date: Mon, 16 Dec 2019 12:34:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 00/13] ppc/pnv: Get rid of chip_type attributes
Message-ID: <20191216013426.GB6242@umbus.fritz.box>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2019 at 12:59:28PM +0100, Greg Kurz wrote:
> The PnvChipClass type has a chip_type attribute which identifies various
> POWER CPU chip types that can be used in a powernv machine.
>=20
> typedef enum PnvChipType {
>     PNV_CHIP_POWER8E,     /* AKA Murano (default) */
>     PNV_CHIP_POWER8,      /* AKA Venice */
>     PNV_CHIP_POWER8NVL,   /* AKA Naples */
>     PNV_CHIP_POWER9,      /* AKA Nimbus */
>     PNV_CHIP_POWER10,     /* AKA TBD */
> } PnvChipType;
>=20
> This attribute is used in many places where we want a different behaviour
> depending on the CPU type, either directly like:
>=20
>     switch (PNV_CHIP_GET_CLASS(chip)->chip_type) {
>     case PNV_CHIP_POWER8E:
>     case PNV_CHIP_POWER8:
>     case PNV_CHIP_POWER8NVL:
>         return ((addr >> 4) & ~0xfull) | ((addr >> 3) & 0xf);
>     case PNV_CHIP_POWER9:
>     case PNV_CHIP_POWER10:
>         return addr >> 3;
>     default:
>         g_assert_not_reached();
>     }
>=20
> or through various helpers that rely on it:
>=20
>         /* Each core has an XSCOM MMIO region */
>         if (pnv_chip_is_power10(chip)) {
>             xscom_core_base =3D PNV10_XSCOM_EC_BASE(core_hwid);
>         } else if (pnv_chip_is_power9(chip)) {
>             xscom_core_base =3D PNV9_XSCOM_EC_BASE(core_hwid);
>         } else {
>             xscom_core_base =3D PNV_XSCOM_EX_BASE(core_hwid);
>         }
>=20
> The chip_type is also duplicated in the PnvPsiClass type.
>=20
> It looks a bit unfortunate to implement manually something that falls into
> the scope of QOM. Especially since we don't seem to need a finer grain th=
an
> the CPU familly, ie. POWER8, POWER9, POWER10, ..., and we already have
> specialized versions of PnvChipClass and PnvPsiClass for these.
>=20
> This series basically QOM-ifies all the places where we check on the chip
> type, and gets rid of the chip_type attributes and the is_powerXX() helpe=
rs.
>=20
> Patch 1 was recently posted to the list but it isn't available in David's
> ppc-for-5.0 tree yet, so I include it in this series for convenience.

Applied to ppc-for-5.0.  I had been anticipating just replacing a
bunch of tests on ->chip_type with object_dynamic_cast() checks, but
this is better still.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl323yIACgkQbDjKyiDZ
s5KEXA//UD2ccxjuBOwmogbC9Ld9wC6S5FUkUckxXsygz1IyZUeCqx4bBRL4opTo
Kt2Ss211CS7ZvsuqHZ+bsBZr4haakvBpBMLNAxUo8J1RvLPxo7/uSHHxEPa09IvU
It/CFpwJWi6rZk+WeYBXgyzuN1nNyaOW1B3LPFpon7SRcRQYkXttzksxtWSK/BmN
LJDOxa6PVCuYOaGAxRIohyj5Q5pN7n7UYv+N5dBUlEoQyFGJkHxfQGl21Jo+p8q+
p6GsRKq1/XkiEwJ95R+zGuCH0z0xA9YCkySR7g6ZYHBbsrA6CwzGEjhc2G8WSt3+
A2IQix9RWjfmIKC3om/p4iR9n/9bmThrlZ1ZJlzyZg1Sp7T7WMBAcD+DMnT+PIiw
srKPGIZI6fIuNn9a7ha8p6FkHQ0qJogTCc0lDMdp8GxatVJL0R5B2FMAtThHsCOP
DMt88XceC9L9y2iEMwrfC9pdNi4ND8PBYPlzDVu6k1TcBgS/lCXUzJ/E2ZixSNS0
E0yaMwMjtF1E64SW3dPtoCeYFHQBL2xhORELowhn2/8Qu3YzbZ+hT6aPq0yrY4iq
CLZ2JBlYEBsjqVcUdDZBFv9gTVzqBgyGKsfKjT+qhx23ntzRPt0/eWl9R1kur/Y1
zejdHI3qgwHnXLqpJbbORqIGTNJigPPzhvRCDeiQuRbi8VZ3q5Y=
=64IK
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--

