Received: from eggs.gnu.org ([2001:4830:134:3::10]:51258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmeID-0005qK-3Q
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmeIB-0001I8-Sj
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:02:49 -0400
Date: Tue, 29 Aug 2017 17:34:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170829073428.GN2578@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<alpine.BSF.2.21.1708271402040.1289@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WuedheRyq6FDfQ9j"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1708271402040.1289@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 00/15] Sam460ex emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>


--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 27, 2017 at 02:34:14PM +0200, BALATON Zoltan wrote:
> Hello,
>=20
> Just to confirm where we are with this series, let me summarise what I got
> from the replies and what's my plan for this based on that. Here's the li=
st
> of patches for reference:
>=20
> [PATCH 01/15] ppc4xx: Move MAL from ppc405_uc to ppc4xx_devs
> [PATCH 02/15] ppc4xx: Make MAL emulation more generic
> [PATCH 03/15] ohci: Allow sysbus version to be used as a companion
> [PATCH 04/15] ehci: Add ppc4xx-ehci for the USB 2.0 controller in embedde=
d PPC SoCs
> [PATCH 05/15] ppc4xx: Split off 4xx I2C emulation from ppc405_uc to its o=
wn file
> [PATCH 06/15] ppc4xx_i2c: QOMify
> [PATCH 07/15] ppc4xx_i2c: Move to hw/i2c
> [PATCH 08/15] ppc4xx_i2c: Implement basic I2C functions
> [PATCH 09/15] hw/ide: Emulate SiI3112 SATA controller
> [PATCH 10/15] ppc440: Add emulation of plb-pcix controller found in some =
440 SoCs
> [PATCH 11/15] ppc: Add 460EX embedded CPU
> [PATCH 12/15] ppc4xx: Export ECB and PLB emulation
> [PATCH 13/15] ppc4xx: Add more PLB registers
> [PATCH 14/15] ppc4xx: Add device models found in PPC440 core SoCs
> [PATCH 15/15] ppc: Add aCube Sam460ex board
>=20
> - I think 1-7 is either already queued for 2.11 or could be applied as is
> having got reviews without need to change so I don't need to resend them.=
 So
> are 11-13 if I got that right. That leaves 8-10 and 14-15 that I'll resen=
d.

The way to handle this is to pull the 'ppc-for-2.11' tree from
git://github.com/dgibson/qemu.git, then rebase your series on top of
it.  That should automatically filter out the patches I've already applied.

> - I'm not sure if 8 was reviewed or do I need to make any modifications to
> it.

I think I didn't get to it.  Just include it in the next spin and
we'll see how we go.

>=20
> - I know I should change 9-10 and 14-15 based on review comments and rese=
nd.
>=20
> Since I'll likely also need to change those patches to fix the bugs we kn=
ow
> about currently, I thought I should probably resend after those bugs are
> fixed to avoid subsequent fixup patches. Since this will not be before ne=
xt
> week (because I don't have time for it before that) I hope development
> should be open again and those patches that are already OK could be merged
> by then so I can rebase on that and only resend the missing ones as
> described above. Is that OK or did I miss something?

2.11 dev should open soon, but I don't know how long it will take to
get my already queued patches merged there.

> David, in case you want to stage all of this in your for-2.11 branch befo=
re
> all patches are ready and send them together, then where is this branch I
> should rebase to?

As above, use the 'ppc-for-2.11' branch at
git://github.com/dgibson/qemu.git.  Note that this is a rebasing branch.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmlGQQACgkQbDjKyiDZ
s5JLRRAAzoA2kk+zvs2miCvDfXBGq/+y2fATNcpy1L/2T5PHWm3OufumMoekKJ5T
FBkIOO6dPkSopcWBNU/ugfzzj0pq8BFP5lD62o5z8x3vq49pS/Rgc6OLiM9iJco7
RiBAqbLHTkwWL9TqIK3Nh1Tdss2TBVkVuzTSzaix5cT2jwePlYKZUg/dtEErIqpy
QyoLYtwTOoraKnTbgk24J6OskoUcOg99TXUCyL2HrZH1Z9iziD+h+ylJbYI9ECvl
+NrI7fi1pRRf1drlYHaay7mg0intzedKhNXVJPh6AutEBWKj1U87ZUnkNC1/M6J2
4lXjdm3WqS5ai8aUnWmMiwxkOrsRpETe7XrAfRa2OUOMwl2pESwLH8wIZWzMUQz+
51voCyNHPr3wmBt9HAEGXgn+QFLqrZ/GqDq4O5oe1p3Z4jViyM9JYh5E2X5n79O0
NpjpJJbwi3A4ibv+thC1W7RHjPBsCRBKfP2AMK66YP0NLCBraepnMrl87+8BiXT+
hZVaaLjn76wMfPaSEPX7/6leI1vbmoG0B+RDCxPCuO90DD59c2h+9XEw5wFN3JQg
v5VcNocgD1VzkfiO9SDNTzE3VZUf/QjJFcRUJtGafi/f6iGHgcojX5zB21sk6EYq
rxmVCZOazX6RdVKtfz8XfhxtMUJ+xBsFXEXFhWIaOWqsVRMM5Js=
=xdDJ
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--
