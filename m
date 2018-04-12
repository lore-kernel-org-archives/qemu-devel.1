Received: from eggs.gnu.org ([2001:4830:134:3::10]:50926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6SAg-0004iI-6V
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6SAb-00041l-66
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:41:10 -0400
Date: Thu, 12 Apr 2018 12:21:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180412022106.GC9425@umbus.fritz.box>
References: <152346876630.89534.10956847520017803741.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <152346876630.89534.10956847520017803741.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: drop useless sanity check in
 spapr_irq_alloc*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 07:46:06PM +0200, Greg Kurz wrote:
> Both spapr_irq_alloc() and spapr_irq_alloc_block() have an errp
> parameter, but they don't use it if XICS hasn't been initialized
> yet.
>=20
> This is doubly wrong:
>=20
> - all callers do pass a non-null Error **, ie, they expect an error
>   to be propagated in case of failure
>=20
> - XICS obviously needs to be initialized before anything starts allocating
>   IRQs
>=20
> So this patch turns the check into an assert.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.13, thanks.

> ---
>  hw/ppc/spapr.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4d27909fb152..799673319b06 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3707,9 +3707,8 @@ int spapr_irq_alloc(sPAPRMachineState *spapr, int i=
rq_hint, bool lsi,
>      ICSState *ics =3D spapr->ics;
>      int irq;
> =20
> -    if (!ics) {
> -        return -1;
> -    }
> +    assert(ics);
> +
>      if (irq_hint) {
>          if (!ICS_IRQ_FREE(ics, irq_hint - ics->offset)) {
>              error_setg(errp, "can't allocate IRQ %d: already in use", ir=
q_hint);
> @@ -3741,9 +3740,7 @@ int spapr_irq_alloc_block(sPAPRMachineState *spapr,=
 int num, bool lsi,
>      ICSState *ics =3D spapr->ics;
>      int i, first =3D -1;
> =20
> -    if (!ics) {
> -        return -1;
> -    }
> +    assert(ics);
> =20
>      /*
>       * MSIMesage::data is used for storing VIRQ so
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrOwo8ACgkQbDjKyiDZ
s5JycQ/+IOSTCcKbHaU2e+jD8ndnAwE4/6h0TGUt+PCg0Z5tNL18YM1dl2CiBOe1
BY78m7MccdOEUSVsiuk70EuKH3oFoo3lbFWFxipN0xSCWjmrkcjIPOaeTA9aHdVm
y/IXNl5tcCGuld58NP0HEI4k62PI3tFK2xNPq8LcuyVsbbjSAuvkwyWURYAdxiiy
r1kb4cg9iFxm2R6/+UzcW4VYcXffI1VsN302kFLEtyu76EJdCsyTErbZgZmK4qyT
kOlXeyy2tjeoe8vcKorwbMTSHsMOsqv2eRI3BaHsYpmD0g7DDd9uwdnQA00tEKvF
KeNB9yD2uMkiOTgrqPcfk4Vi1gR6HtVYAOeDZF3tK6T4d38Xn+LV5/j37dEwbEe3
5381bF0dYfvzTMLTROBojW1JbBR08PA3WznbC4RoTbEpjScAb0dTvRUbn4muFnx0
QO9pkiqd0oUTBNmKdy0gk7aEAW2vcMD8Aad9c8busnmGIJKEcAK58ROfkD/8tCs9
QnKdr+gQ9KwZZZ6qDHntNDInptcm5aAEVQYbBNmhMybZBp8ZqFp2+vQlx185fMXI
oSWfPFlCJpSKxUi3Q54tBPBHlwriZTi8C/sqFj5hR9eTB1dm947DAemr5cbEwRHb
iGv/4T1wDRFS/yV4ONYJT+tzAF0B9Rh4zCeNcCnAC7slegXVIEA=
=5gHo
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
