Received: from eggs.gnu.org ([2001:4830:134:3::10]:52174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eI4h1-0000Gc-11
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 22:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eI4gz-0003Dp-UV
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 22:30:18 -0500
Date: Fri, 24 Nov 2017 14:16:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171124031659.GD28000@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <20171123132955.1261-6-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 05/25] spapr: introduce a spapr_irq_set()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 02:29:35PM +0100, C=E9dric Le Goater wrote:
> It will make synchronisation easier with the XIVE interrupt mode when
> available. The 'irq' parameter refers to the global IRQ number space.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

s/spapr_irq_set/spapr_irq_set_lsi/

otherwise the name doesn't tell you what it sets.

With that change,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7ae84d40bdb4..79f38a9ff4e1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3594,6 +3594,11 @@ static int ics_find_free_block(ICSState *ics, int =
num, int alignnum)
>      return -1;
>  }
> =20
> +static void spapr_irq_set(sPAPRMachineState *spapr, int irq, bool lsi)
> +{
> +    ics_set_irq_type(spapr->ics, irq - spapr->ics->offset, lsi);
> +}
> +
>  int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
>                      Error **errp)
>  {
> @@ -3618,7 +3623,7 @@ int spapr_irq_alloc(sPAPRMachineState *spapr, int i=
rq_hint, bool lsi,
>          irq +=3D ics->offset;
>      }
> =20
> -    ics_set_irq_type(ics, irq - ics->offset, lsi);
> +    spapr_irq_set(spapr, irq, lsi);
>      trace_spapr_irq_alloc(irq);
> =20
>      return irq;
> @@ -3657,10 +3662,10 @@ int spapr_irq_alloc_block(sPAPRMachineState *spap=
r, int num, bool lsi,
>          return -1;
>      }
> =20
> +    first +=3D ics->offset;
>      for (i =3D first; i < first + num; ++i) {
> -        ics_set_irq_type(ics, i, lsi);
> +        spapr_irq_set(spapr, i, lsi);
>      }
> -    first +=3D ics->offset;
> =20
>      trace_spapr_irq_alloc_block(first, num, lsi, align);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloXjysACgkQbDjKyiDZ
s5K/thAAgbAktZsAFEOBfANXWwcJimF2m2B2tN6jtMHsmFqO0KLdlIG4JwP6kRyR
LGBISUywp09pRJMTWEfqwkHf9MX3PFdB9MmLvnduZz1DYjr/5Cgph3p1TMvBjGKj
nRTRVcgaqmn/J4I9gU2o0tPYFhykZ8WGrTXkCetJSBLqRIqnjDlYEac0isCg587Q
njAJpn/gdiEO6s+tmCUhe/RrTDC1ZhMWgh0kah7AoCwmNSerdDCiNXUIxBUWi/W5
tBqJCgZOVLAzGcjx+ai3NOx/B30nMIacpw9LKr7Z2w+QG/yFPdNN0t5FbHTeMl9Z
+92z79y4xWnZDT00B03rACnO8Orluoanqj9gbJOlenINw1q4We19s05Ne7WiWVgf
3glToOJGLeEITSNpxTfZn1laDjABYuanA+IvSpJ+ubCijmjPEX7AIu1cNF/v3TH6
atYw9jt8qT3EHFUmDCrvo7LbxrvXvBodUxICe8bbbBIuK8V8me4aBapyV2/H5G8G
KA/tGeWqgNeNSpvGiOiBvybyQYIXgTyZRx5C7mv++MaMPNXz0w71MqejigLSnIQq
v5gkZAFpUuhlXGl8sO8hLy26SELLMvYvGBMyRIYWzqubOS4fqIilpuwz4jZCDFRQ
9CdAt3eB0ainqwszDugBTbBXVlISIqaaf4QAVgMAiUWq9NsMNSw=
=Qe4f
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
