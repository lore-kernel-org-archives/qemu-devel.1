Received: from eggs.gnu.org ([2001:4830:134:3::10]:47769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEO5G-0001jb-Qi
	for qemu-devel@nongnu.org; Thu, 03 May 2018 19:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEO5F-0000d6-Qq
	for qemu-devel@nongnu.org; Thu, 03 May 2018 19:56:22 -0400
Date: Fri, 4 May 2018 09:34:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503233448.GD13229@umbus.fritz.box>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-13-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HjNkcEWJ4DMx36DP"
Content-Disposition: inline
In-Reply-To: <1525376963-79623-13-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/67] ppc: use local path for local headers
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


--HjNkcEWJ4DMx36DP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 10:50:35PM +0300, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory. Directory based path works more or less by accident.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc440_uc.c | 2 +-
>  hw/ppc/sam460ex.c  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index e312fdb..123f4ac 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -20,7 +20,7 @@
>  #include "hw/ppc/ppc.h"
>  #include "hw/pci/pci.h"
>  #include "sysemu/block-backend.h"
> -#include "hw/ppc/ppc440.h"
> +#include "ppc440.h"
> =20
>  /***********************************************************************=
******/
>  /* L2 Cache as SRAM */
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index dfff262..4a66e1d 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -27,8 +27,8 @@
>  #include "elf.h"
>  #include "exec/address-spaces.h"
>  #include "exec/memory.h"
> -#include "hw/ppc/ppc440.h"
> -#include "hw/ppc/ppc405.h"
> +#include "ppc440.h"
> +#include "ppc405.h"
>  #include "hw/block/flash.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/qtest.h"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HjNkcEWJ4DMx36DP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrrnJYACgkQbDjKyiDZ
s5LMog//esqX6Ip7dBWnX8wvPBjy7OU1HkeTPN+DSq/srpDEKVyEqmhjRERk3kvS
w4oGO4vjS8qGXcsZIl3PwPniN+PzQ063zhX8YIdZkJh6DGykZjilOTBHv5OJj/Ev
oq8Ntw+3RR3NvOgESzdTjFOlH12e9GsFoF7qgyBVIf4VD5PuFwE6U0bWQxZQAiXS
GlIp9NGOo/slccO0fYyNbXMfHSWK5tfIEo2E6NhUJIjJ9rfsyQC96a7+ttdgR+SB
Kzf6WiImnIJWtRs9u4L2um1+ZNxpJ4WTn9t3uezV8+F5sM3SvE/bGZxXap8aXF+c
lXc/9nCVFioaCRJtkX7WEsNAyDw2x0IDXUSutgSAjtzjjFRDNTQ9tdYoOGC1TZKz
PyfDrSNidQUj24+kngRXomxXQZ+ylHjaPxlALr0PyHHE4//glywaIQGq0LqmeRSO
XpYi8y257qkyJ5LiST0ci3WAqzMV1iujODDmjSmJtv4lKEcHIVRDl8rZGNZjChtA
sPKiar5Clfki9GtylFA8X8WMsAbSswRcD2Sbh2dwAFJSENJc751WE2KduEx3ddSZ
1CAESgKvzfzqqWPx1kU1Wcp6muyiCCJLi7uomhCT4PBggbXh3qI70h5gCwMHjunj
qzSdZzQrxDmBVxg5MwY20u0Zp077bjR4hiKqBwZO/r5RvHL+YMM=
=Med/
-----END PGP SIGNATURE-----

--HjNkcEWJ4DMx36DP--
