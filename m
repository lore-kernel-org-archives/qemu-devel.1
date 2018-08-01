Received: from eggs.gnu.org ([2001:4830:134:3::10]:36727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkiU6-0005Ul-AJ
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 00:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkiU3-0005Em-4x
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 00:11:38 -0400
Date: Wed, 1 Aug 2018 14:11:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180801041124.GM2708@umbus.fritz.box>
References: <153303460952.379428.12331310797981914812.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yklP1rR72f9kjNtc"
Content-Disposition: inline
In-Reply-To: <153303460952.379428.12331310797981914812.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH for-3.1] xics: don't include
 "target/ppc/cpu-qom.h" in "hw/ppc/xics.h"
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


--yklP1rR72f9kjNtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2018 at 12:56:49PM +0200, Greg Kurz wrote:
> The last user of the PowerPCCPU typedef in "hw/ppc/xics.h" vanished with
> commit b1fd36c363d73969841468146ebfb9fd84a5ee52. It isn't necessary to
> include "target/ppc/cpu-qom.h" there anymore.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-3.1.

> ---
>  include/hw/ppc/xics.h |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 6ac8a9392da6..9c2916c9b23a 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -29,7 +29,6 @@
>  #define XICS_H
> =20
>  #include "hw/qdev.h"
> -#include "target/ppc/cpu-qom.h"
> =20
>  #define XICS_IPI        0x2
>  #define XICS_BUID       0x1
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yklP1rR72f9kjNtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlthMukACgkQbDjKyiDZ
s5JZiQ/7BdGgRzSi7cTSG9+SLoTc3//BRkIcvvL7GJGOl/CN3kezPI8Lz5wEfmta
IdHySRdpvK6XrtYvQITjE/95SPl+EsKKtWcy03K1n31RhygVMiq4qX+KFWXkLHXW
RhoZdKXX1ym5ZERAXizq3uoEEVkMy51nW8Ctwkjf8SJ3j3pw+HPgG/7Pe0tjgllX
HiULkOYPUTUyGRVnlTjVMA3Ys8JPC3dNvAVo6wkDIZ94Gr0q1t6Hl/htFlV4qaRE
kzhNBYNB3qfStBf+//tiBHUV5ydFat836JIAZEOtemafe7bTxuykEdupzPv+lTQb
XKHl+jV6XRwVby4Q+bAgxLzRi3dQs7eeF2j0bhy0eDpkYlwEhwSnSBOf4Jc2cc6X
gtqxgmz19LnzKjb5SOOQ9Z6cRJcGntY1GatO3V5TJg5xd2snubMaccgUYuLQ6JWO
eXMONUNz1B8tp2ESHBcmvSJUP+UzOd9VXxvGNkdbJlA48QsO/68Q8JoCDr7mlfdr
Eho0jDFKhboeoWXg8Yaf5AszRo5qK7PKdAWXQ45zyJ4xINwYkYuDX2p9jIpvwCij
mz9kcoi7lTh+losPRrZsfTWUlf0WFggvWVkGTciJRGnlh6tbwxNf/Z8JkoGFn3ov
stp3W0nfXhKW9GuVeeeqkSwQfnQ+vVk5iHw0p2r46H0tDYuGdJI=
=b2aW
-----END PGP SIGNATURE-----

--yklP1rR72f9kjNtc--
