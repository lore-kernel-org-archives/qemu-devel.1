Received: from eggs.gnu.org ([2001:4830:134:3::10]:53829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEPUV-00022y-RA
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEPUU-0004B1-Tp
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:26:31 -0400
Date: Fri, 4 May 2018 10:15:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504001556.GK13229@umbus.fritz.box>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-35-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tw5XVHq4jmAOFG53"
Content-Disposition: inline
In-Reply-To: <1525376963-79623-35-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 34/67] hw/ppc: add include directory headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--Tw5XVHq4jmAOFG53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 10:51:12PM +0300, Michael S. Tsirkin wrote:
> This way they are easier to find using standard rules.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I don't really understand what this is accomplishing.

> ---
>  include/hw/ppc/e500-ccsr.h | 1 +
>  include/hw/ppc/mac.h       | 1 +
>  2 files changed, 2 insertions(+)
>  create mode 100644 include/hw/ppc/e500-ccsr.h
>  create mode 100644 include/hw/ppc/mac.h
>=20
> diff --git a/include/hw/ppc/e500-ccsr.h b/include/hw/ppc/e500-ccsr.h
> new file mode 100644
> index 0000000..08e4ba2
> --- /dev/null
> +++ b/include/hw/ppc/e500-ccsr.h
> @@ -0,0 +1 @@
> +#include_next "../hw/ppc/e500-ccsr.h"
> diff --git a/include/hw/ppc/mac.h b/include/hw/ppc/mac.h
> new file mode 100644
> index 0000000..e0f0b67
> --- /dev/null
> +++ b/include/hw/ppc/mac.h
> @@ -0,0 +1 @@
> +#include_next "../hw/ppc/mac.h"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Tw5XVHq4jmAOFG53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrrpjwACgkQbDjKyiDZ
s5KaTw//Zdq1CH0+z+wwDKw3FQ0aL49zOPwznJnr9194sv8uqs946JlKmX3Hpmbe
3Jd7k4eZ9vvRpMGCuXbqDWw217zR4sW+Ui1jjIfDuNaNM/3355KaoyI7B2HraBkH
nnOZDdBt2hgRsDiZsOXrUygufqxOpi6ao8FDz1JUWcc+At51g9wPT4ZnPsLOHeg4
dHK/mMTEwtlPZLd0LiGDSPjodNLsLBi+zaHxUMDu73g1MDte8SCU0T4rY/Nf1cyf
fflvq705oqhzBYhnFyLalP4wXM0ID7w7d6tA72eViz0zF5D0ASe+ybJ/fzab7TlX
jMVCZkZEY0p5NKkw3m99ijE3VNuw48XC6mmJLJ1qpGmM/ZDw7cv7Nh+Wjb9fODcs
EE2WKeJQbFWyYjgtPGpCq/DvEv15SNMsqcDmlX3UZQeICH3kdwkrMXhEg4oBAnHc
JTUUa3QL+OuTjjqeCT4YmIcCCamxGCHvTIzc1Eaq6FQ5xyYySYhSDWFiRdHbzufq
12rcOr93tomS5kc8E3izWL6iCpeIMOshVNSHz40KquzuRcbG+RXHAjPm9KQec3Tu
FIvoySPSPLjw4hjMUkK7mo7DehVQ0ngyRghOKer8/p7z8GMl70UFY36gAwtgowiO
0lUmPtJL3iETXPUAUhGRxOG50MsHxp+vY+uF3d1kVfPH1WlyXsE=
=TmDJ
-----END PGP SIGNATURE-----

--Tw5XVHq4jmAOFG53--
