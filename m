Received: from eggs.gnu.org ([2001:4830:134:3::10]:47607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkLs0-0004Yc-HX
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkLrz-0001R5-IK
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:58:16 -0400
Date: Wed, 23 Aug 2017 12:30:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823023024.GL5379@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<86d29467038393122310cf0ba1c2547489324c61.1503249785.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sCNd3Ivk/oijKKf1"
Content-Disposition: inline
In-Reply-To: <86d29467038393122310cf0ba1c2547489324c61.1503249785.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 12/15] ppc4xx: Export ECB and PLB emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--sCNd3Ivk/oijKKf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
> Make these device models available outside ppc405_uc.c for reuse in
> 460EX emulation. They are left in their current place for now because
> they are used mostly unchanged and I'm not sure these correctly model
> the components in 440 SoCs (but they seem to be good enough). These
> functions could be moved in a subsequent clean up series when this is
> confirmed.

Your reasoning convinces me.  Applied to ppc-for-2.11.

>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/ppc405.h    | 3 +++
>  hw/ppc/ppc405_uc.c | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405.h b/hw/ppc/ppc405.h
> index a9ffc87..7ed25cf 100644
> --- a/hw/ppc/ppc405.h
> +++ b/hw/ppc/ppc405.h
> @@ -59,6 +59,9 @@ struct ppc4xx_bd_info_t {
>  ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, ppc4xx_bd_info_t *bd,
>                                  uint32_t flags);
> =20
> +void ppc4xx_plb_init(CPUPPCState *env);
> +void ppc405_ebc_init(CPUPPCState *env);
> +
>  CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
>                          MemoryRegion ram_memories[4],
>                          hwaddr ram_bases[4],
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index 8f44cb4..e621d0a 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -174,7 +174,7 @@ static void ppc4xx_plb_reset (void *opaque)
>      plb->besr =3D 0x00000000;
>  }
> =20
> -static void ppc4xx_plb_init(CPUPPCState *env)
> +void ppc4xx_plb_init(CPUPPCState *env)
>  {
>      ppc4xx_plb_t *plb;
> =20
> @@ -585,7 +585,7 @@ static void ebc_reset (void *opaque)
>      ebc->cfg =3D 0x80400000;
>  }
> =20
> -static void ppc405_ebc_init(CPUPPCState *env)
> +void ppc405_ebc_init(CPUPPCState *env)
>  {
>      ppc4xx_ebc_t *ebc;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sCNd3Ivk/oijKKf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmc6MAACgkQbDjKyiDZ
s5KnAA/+PdxB9hVoQ6FnLS7bYnlzA5tmJIX4z0HOGir5V/Vgnwv8XuPGnxhdfyvH
eSwzCnFGmzZDJRTqu3a+VPbtt9Qoy01pvyYvo7JDEdvexx6M9o8NLFMbLBIZlnqP
fL3T7df7IHxtotsMmpHPAhnDv2NTvFxOdeoOqkiakk3JhvkRGfASiD2m/BBygi0r
FoCTwNICa8rWZ3Ff6ZtVL4H0ck+Gg3w/Z3jBoJIPAxADO1rpUMPSUJ9ifGGO84+X
hUi70sAPjdWngUjRj6xdyKwYf/55TkNFuhXrA4jEube8bNjfDJBuQasEjw701I7o
gUCNtAe1yI9HhIcPmQDv781REg0nqeQftS++UneNNyH4QnQSqQzBvkcCoRFwHvbo
JpDurhJ5/sjJyHQy8RMmamS18Bpv7LIp6HG7I0fDcBr7S0i2iHChYpPMPLJXcy4/
WU1GspsFmCsBydnPfspIvIW9sfBZmfouYy+LydJSXJkidi4vQfkpmK31Hr6NqLJU
GLXIpFlVe/HzZDBTmV4l7kD9YI8wX9hisDPV8xBrbuTahRbQsieFMitAFNr46P73
TJO84D3ecUFnOewf3CruEmpb3wjNG2AtqucaBdI5HvLrFu4+U5lorom9NMebCOvo
SISO+iS7yK9syiIhihceWleDn1iJ9+diLdVwfj2WQxPoRoKMof0=
=0fsB
-----END PGP SIGNATURE-----

--sCNd3Ivk/oijKKf1--
