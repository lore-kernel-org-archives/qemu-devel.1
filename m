Received: from eggs.gnu.org ([209.51.188.92]:58519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpd-0005bY-BJ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpc-0003V0-C1
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:53 -0500
Date: Fri, 11 Jan 2019 11:35:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190111003527.GO6682@umbus.fritz.box>
References: <CALvuzg43uSodseEHjNaRcPFBKKPTY2mcppUbYgiLL=QO9RxX_Q@mail.gmail.com>
	<e62bbdda-2ab9-b9a1-7843-0a3a40f56282@vivier.eu>
	<4cfad0f8-1b66-b6be-693e-ba439e81f171@sysgo.com>
	<f36c1752-98ad-7c44-4637-7186c7511f38@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m46qSNjkc66Ye11q"
Content-Disposition: inline
In-Reply-To: <f36c1752-98ad-7c44-4637-7186c7511f38@vivier.eu>
Subject: Re: [Qemu-devel] [Qemu-trivial] ppc: e6500 registers SPR 604 twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Roman Kapl <roman.kapl@sysgo.com>, Jon Diekema <jon.diekema@gmail.com>, qemu-trivial@nongnu.org, Roman Kapl <rka@sysgo.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


--m46qSNjkc66Ye11q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 11:17:00AM +0100, Laurent Vivier wrote:
> David,
>=20
> will you take this through your ppc branch?

Somehow I missed this one, sorry.  Even when I look back through my
mail archives I can't see the original message of this thread.  Can
you resend please?

>=20
> Thanks,
> Laurent
>=20
> On 04/01/2019 11:41, Roman Kapl wrote:
> >> Le 25/12/2018 =E0 10:50, Jon Diekema a =E9crit=A0:
> >>> =A0From f399f28441e0aa79458d68996038ca3606fcb699 Mon Sep 17 00:00:00 =
2001
> >>> From: Jon Diekema <jon.diekema@ge.com <mailto:jon.diekema@ge.com>>
> >>> Date: Tue, 25 Dec 2018 04:36:06 -0500
> >>> Subject: ppc: e6500 registers SPR 604 twice
> >>>
> >>> When using the e6500 CPU, QEMU generates a fatal error after
> >>> complaining about registering SPR 604 twice.
> >>>
> >>>
> >>> diff --git a/target/ppc/translate_init.inc.c
> >>> b/target/ppc/translate_init.inc.c
> >>> index 03f1d34a97..c971a5faf7 100644
> >>> --- a/target/ppc/translate_init.inc.c
> >>> +++ b/target/ppc/translate_init.inc.c
> >>> @@ -4947,14 +4947,6 @@ static void init_proc_e500(CPUPPCState *env, i=
nt
> >>> version)
> >>> =A0=A0 =A0 =A0}
> >>> =A0 =A0=A0 =A0 =A0if (version =3D=3D fsl_e6500) {
> >>> -=A0 =A0 =A0 =A0 spr_register(env, SPR_BOOKE_SPRG8, "SPRG8",
> >>> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SPR_NOACCESS, SPR_NOACCES=
S,
> >>> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&spr_read_generic, &spr_w=
rite_generic,
> >>> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000000);
> >>> -=A0 =A0 =A0 =A0 spr_register(env, SPR_BOOKE_SPRG9, "SPRG9",
> >>> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SPR_NOACCESS, SPR_NOACCES=
S,
> >>> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&spr_read_generic, &spr_w=
rite_generic,
> >>> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000000);
> >>> =A0=A0 =A0 =A0 =A0 =A0/* Thread identification */
> >>> =A0=A0 =A0 =A0 =A0 =A0spr_register(env, SPR_TIR, "TIR",
> >>> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPR_NOACCESS, SPR_NOAC=
CESS,
> >>> --=A0
> >>> 2.20.1.3.gf17a2b179
> >>>
> >>
> >> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> >> Tested-by: Laurent Vivier <laurent@vivier.eu>
> >>
> >=20
> > Thanks Jon, I did not test with e6500. The patch fixes the issue &
> > debugging still works on e5500.
> >=20
> > Roman Kapl
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m46qSNjkc66Ye11q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlw35M8ACgkQbDjKyiDZ
s5JrDBAA2W9jRgDOmtIA3oS0ABuCbESvUObpqMgVHF+wZNdlYy97pIdnTvE/zV20
IF2SKzvM8N919DZHpdJRfLNm5tmnG9O6vfLXv//PfxYeE+h6VCPDQRjfAlTSpkKY
gZPKUUU+OzRaco8yC3CvuRAxe5VrHnMrDmepoFo5BND02dSNl8JnHbMkPHC5yhKU
zHNbbienVs3OX7fcnAX19VnL9CDkKZBv3G9mQkWdn7J0IW9AcfaloSNsSOa9+3o/
2bFnt78Ze9jXvb9Fo5krXzbLUqCEeP3FVzuBBTXH1GGKjswQ5BTT92N+gLcihSfH
mCjYWrJOVtqNgKqcIzX78gvgaZgDOhhUpujBVgMBBKY0JutJ74nbFa0rTNjqpQxl
qZfTlKbIiEQf51my0C2HWnj1dxyrz5c/QzHMA3nomT03Ox7FfmMshVEG4sAODrNo
YO9PGKEQmyWTJ7bHOCzSGEkPOia3GIDIC5McFPVZykXTxprUVyyHk8CwTykNboFc
jCpOuXTiEzOESMECF/xp1cMzDy7Kx20POQJkr7slq2c7G64Tw4L6fGNXzYLReD1Z
zwdt7TMCzjqDgnv8AKxkTskAqkOAsvjVOjPOM9D9xMC7wnCTK8AUzEftvaQVUqfG
dJ/DoecSAxGTPvcpNlNzMM5edtJo13tEvUaj9uFL5Uni3t2gAy0=
=/zHe
-----END PGP SIGNATURE-----

--m46qSNjkc66Ye11q--
