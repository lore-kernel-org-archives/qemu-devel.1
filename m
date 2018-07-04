Received: from eggs.gnu.org ([2001:4830:134:3::10]:33681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faWpY-0006FP-4E
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 21:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faWpW-0004EM-WC
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 21:43:40 -0400
Date: Wed, 4 Jul 2018 11:29:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180704012913.GB14043@umbus.fritz.box>
References: <20180703152359.16618-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20180703152359.16618-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-3.0] spapr/vio: quiet down the "irq"
 property accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 05:23:59PM +0200, C=E9dric Le Goater wrote:
> commit efe2add7cb7f ("spapr/vio: deprecate the "irq" property")
> introduced get/set accessors for the "irq" property to warn of its
> usage, but the warning in the get pollutes the monitor 'info qtree'.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.0.

> ---
>  hw/ppc/spapr_vio.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index daf85130b5ef..be9af71437cc 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -43,7 +43,16 @@
> =20
>  #include <libfdt.h>
> =20
> -static void spapr_vio_getset_irq(Object *obj, Visitor *v, const char *na=
me,
> +static void spapr_vio_get_irq(Object *obj, Visitor *v, const char *name,
> +                              void *opaque, Error **errp)
> +{
> +    Property *prop =3D opaque;
> +    uint32_t *ptr =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> +
> +    visit_type_uint32(v, name, ptr, errp);
> +}
> +
> +static void spapr_vio_set_irq(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>  {
>      Property *prop =3D opaque;
> @@ -57,8 +66,8 @@ static void spapr_vio_getset_irq(Object *obj, Visitor *=
v, const char *name,
> =20
>  static const PropertyInfo spapr_vio_irq_propinfo =3D {
>      .name =3D "irq",
> -    .get =3D spapr_vio_getset_irq,
> -    .set =3D spapr_vio_getset_irq,
> +    .get =3D spapr_vio_get_irq,
> +    .set =3D spapr_vio_set_irq,
>  };
> =20
>  static Property spapr_vio_props[] =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls8IukACgkQbDjKyiDZ
s5J2Ug//Z6BSVaBovbeKHOgqAeRAeH7GWWbvivMJ6H8roqeRYoHubpS2jHdP/Zij
/wJlWtwfGzQE/mpK2Vbr+bwMZ3mkAwDgn5E9jA4dhMxHevoQR7DvLbPv7nAZu1Tz
/MKaSrdOZ9m/kDwHVOurU7rO4LBXf4tYbbgLepyblBTKb4HrhKMLMDQsuZaQpgap
8GbyFZTeJ4nOGTkwLW2osoCLhammkQONALVnXANRL3xBvXM2Ck0CR67wlq11/+o6
wxLFf6YPAB/faQuClNyiwAeBJ/mzQH04e7NTJXjM7P/RarJDbi1ki3RDgdpRyK+/
l7GrSqWNIf3kMJJYQorY+qzaC/ptylSWQNFy1iNHHYInBhvmLuZARgb4JBz/crXt
JNh6Epaa7k5x3UgyPzTWmno8UQ0FLa0x2BO39iPRc90+lekKXHh2VH3BQdhINieM
pprs2wfHnSfJRAnFeGZUWesO9nna8yc0PnJZKImCbuBbTXQ+k2USXKJL1J7plEbW
L3osLuk2kH66rfClxQajtf4i0O1JxWna+b6svlbTGi0I/+7UUzWQZkL6SU0GBi/v
f9CgAuUo6QdbZZzAqx4eZlWOMCKPMQW06HnK2Coj4u+5MaTZZ6/PNjUZVXr/wZEb
1u4YCBYWdEg6hIgsx/eP9CEULHTeQjAtJQhbhdtab++LCOLGSfQ=
=53P1
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
