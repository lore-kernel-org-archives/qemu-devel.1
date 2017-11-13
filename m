Received: from eggs.gnu.org ([2001:4830:134:3::10]:52919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eE7IL-0007WS-Ft
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 00:28:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eE7II-0004bd-CA
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 00:28:29 -0500
Date: Mon, 13 Nov 2017 16:28:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171113052811.GC1014@umbus.fritz.box>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <20171110152017.24324-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 02/11] ppc/xics: remove useless
 if condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 03:20:08PM +0000, C=E9dric Le Goater wrote:
> The previous code section uses a 'first < 0' test and returns. Therefore,
> there is no need to test the 'first' variable against '>=3D 0' afterwards.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xics_spapr.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index d98ea8b13068..e8c0a1b3e903 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -329,10 +329,8 @@ int spapr_ics_alloc_block(ICSState *ics, int num, bo=
ol lsi,
>          return -1;
>      }
> =20
> -    if (first >=3D 0) {
> -        for (i =3D first; i < first + num; ++i) {
> -            ics_set_irq_type(ics, i, lsi);
> -        }
> +    for (i =3D first; i < first + num; ++i) {
> +        ics_set_irq_type(ics, i, lsi);
>      }
>      first +=3D ics->offset;
> =20

Applied to ppc-for-2.12.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloJLWsACgkQbDjKyiDZ
s5JdvxAAobUHzqEx5IdAobrgKau3ZTtWZtiFBphKb84z0XZ3bGr3QF3trWgOen6P
uJpY7ZZRuMFBFDzEC/GNiQUGzzO3rU17HGpl1OfI/MSsVxGR9kP+/Gpd9REg0cfR
cN+1dLj4n3MWcL4Wzu2xVZTq1LhtfWkAUPwrNJEiYbQStVZ6GN2+2+YhmSY9guV/
LL76MdpAETywOObiEn6hrOXmJxjb8J5MXdOn4ugOb+5c84hcTGm0z0zlYLJmwx1q
EHq5MD3viaqDO4mj4fr1acpX5g8UMIgfGpxprlbxDf0hmgW/7SB8Rs2X7EBDNXcN
w74CZtGhQzPpboEDllXAJsbADTaNV0n4ZwKJBYQ1vQBL1+d+im0rNiUDYRlZ6Pj/
Q0Oo5EV2P+poPhc02uOVXrZl1cAtnnVCS6liiIUsNut5Fa88jJz+E09GcQoRZVNL
JPZpWMuzx7a4RrPcTay21NtqRi84xFjcMBkoESpMlZK1qabnLfYaQkT+QWZxr/QI
2WrmDm4RzQL9dbOQwmc4Pc8ZAouczfk0OuRqRAeeZuq2dBu+h8EkgEYq2KvytFpx
RlcT7xCelhtBWaCTyJ1Y6OJ5Z2kKTyz1A/X7Nm3xKLgNUiz9M4nZEghlGY3Qt+SS
n46UeV9n/MUiI9e6LTlsc8nXq8oVrVm20pd3HSPq8BL1lCU+yQ4=
=BIiJ
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
