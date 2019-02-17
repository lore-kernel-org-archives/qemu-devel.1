Received: from eggs.gnu.org ([209.51.188.92]:52757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWiK-0008Jy-Dk
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWiG-0005h0-Bp
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:14 -0500
Date: Mon, 18 Feb 2019 10:59:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190217235934.GM2765@umbus.fritz.box>
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RXc6EO4W1yUvSQ0X"
Content-Disposition: inline
In-Reply-To: <20190215133005.15955-3-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] spapr: support memory unplug for
 qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--RXc6EO4W1yUvSQ0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 02:30:01PM +0100, David Hildenbrand wrote:
> Fake availability of OV5_HP_EVT, so we can test memory unplug in qtest.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Kinda gross, but I don't see a better way of handling this quickly,
so,

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr_ovec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> index 318bf33de4..12510b236a 100644
> --- a/hw/ppc/spapr_ovec.c
> +++ b/hw/ppc/spapr_ovec.c
> @@ -16,6 +16,7 @@
>  #include "qemu/bitmap.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
> +#include "sysemu/qtest.h"
>  #include "trace.h"
>  #include <libfdt.h>
> =20
> @@ -131,6 +132,11 @@ bool spapr_ovec_test(sPAPROptionVector *ov, long bit=
nr)
>      g_assert(ov);
>      g_assert(bitnr < OV_MAXBITS);
> =20
> +    /* support memory unplug for qtest */
> +    if (qtest_enabled() && bitnr =3D=3D OV5_HP_EVT) {
> +        return true;
> +    }
> +
>      return test_bit(bitnr, ov->bitmap) ? true : false;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RXc6EO4W1yUvSQ0X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp9WUACgkQbDjKyiDZ
s5KIFRAAor5dVNyO621TR+90x2x06qteJdDL9cNd1CXcY7NWzxTq1e3ou+ng9yOn
IbbavIPnmVuewHw37UfBwrGufjeWSM3f+KuIOX0nOjwtg4TdMV72gys8zPhPqZAH
0rg0wMyR3UhSIeSe60StAEBgeQl6l5fYdQz3+usnq9pOzPgiWChkL6CTULWdTISi
cwIDTmLOOxpgvZro4GgbqG2RxJlo0eTf8WNEoEwsNaJk8l0Sc2qRm4R0cQ9O/9IH
xPXPq51pRkTi1t+xOjtvGuB8W6Pxp6LLYvewAH2XlQTYEcN2x6RHfIp4Lq9bG4+q
eEbY/jiU9xzbXoNw2Hh0OKq+fmyI2RDgaqMgJMKoI6G+R4JhDy0GQ2+kJYAfvJZG
m82vJ4TFvbZr1IcC/IAgQCmxB4ulSWEoIN05yaaNPbBNLsx/al9+4QwH+2MjJf37
auegRCQcGCMUZIIW5Qt/KAOltmdUDjjddR/5JeiDu85GnRc6YIudkXdtgjOvWyM3
KdC0IAqJjklT2ViQdA2wPSOaiV0fsurO3tnQxyyP+VeG1h7+2BuCeXk/Y8hRImWx
J99x8RZqpsgqIcNNGMzonH/J2YgIb0nDfYh2xo8YD6zTnhIsreQH/cy6Vi4nq0Lf
jgU44BS6E3BvzakrVKEHoViWSkV0zl6ce+o/Rnp6bQC9EIMLbWw=
=8kGi
-----END PGP SIGNATURE-----

--RXc6EO4W1yUvSQ0X--
