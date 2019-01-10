Received: from eggs.gnu.org ([209.51.188.92]:33633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghQgJ-0005sr-Oo
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 22:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghQgI-00017v-D2
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 22:06:55 -0500
Date: Thu, 10 Jan 2019 12:52:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190110015255.GF6682@umbus.fritz.box>
References: <20190109151532.20504-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
In-Reply-To: <20190109151532.20504-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/xive: fix remaining XiveFabric names
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


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 04:15:32PM +0100, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  include/hw/ppc/xive.h | 2 +-
>  hw/intc/xive.c        | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 4cd2e54c4958..0f935a146c66 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -146,7 +146,7 @@
>  #include "hw/ppc/xive_regs.h"
> =20
>  /*
> - * XIVE Fabric (Interface between Source and Router)
> + * XIVE Notifier (Interface between Source and Router)
>   */
> =20
>  typedef struct XiveNotifier {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 469c90e50c6a..39aac9f89d2a 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1659,9 +1659,9 @@ static const TypeInfo xive_end_source_info =3D {
>  };
> =20
>  /*
> - * XIVE Fabric
> + * XIVE Notifier
>   */
> -static const TypeInfo xive_fabric_info =3D {
> +static const TypeInfo xive_notifier_info =3D {
>      .name =3D TYPE_XIVE_NOTIFIER,
>      .parent =3D TYPE_INTERFACE,
>      .class_size =3D sizeof(XiveNotifierClass),
> @@ -1670,7 +1670,7 @@ static const TypeInfo xive_fabric_info =3D {
>  static void xive_register_types(void)
>  {
>      type_register_static(&xive_source_info);
> -    type_register_static(&xive_fabric_info);
> +    type_register_static(&xive_notifier_info);
>      type_register_static(&xive_router_info);
>      type_register_static(&xive_end_source_info);
>      type_register_static(&xive_tctx_info);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlw2pXcACgkQbDjKyiDZ
s5Ir4hAAkE/JA9IWczWYLjk1+oNNd5SCoiWD5tGLm5zmuE7mKZOHs2u4VSGODB3g
n2o4jzbgcbv6YxdLSI38uLDO4ap2J1uygPuSiotlV+LtwyH/KZZ3KjypeLxEeTUD
jnqccuccjlZhLwOUKevf/f2DJRWsWzDbmDt/OUbFCTvoAAKZ/fvR6qvqF7WkE2lR
azVRIoy8jhnL1m+Sj2d+ob03743/l7A4UmLRKSJ9DjUBnUVUTl4sf7BHT2ZdgCta
rzA+RQ8mZw17IxuOo6GeDvjD6Oa5MHoV0tBOmlPwCVyP3jV3NE/OsxDendseddKj
C6suqf031xvLvb2lrYh2p1MUf1gnIEr9aGupIhGOZamHJjFsEG5I1+pqX5GSMrjr
ZF6g9U7gA9qhg5xKx1Mkwuhg76W+rupzVrq3k+VfF7SIJzXt6dITBK7EyeWx2cDa
VTOo+F2+YtEWnYQaOIwRyVLGGwvYz2An32e2rs6lSlDb95Yb1DB4f2SZh5bFWG1D
bufH4eRi1oawLSHTIN1rRcXnWprTbtyrlccR+d+u5VXbB8O3IQFgtsTkmXQP7Z0n
8uBEkUQCfvDr6d5gv22hISeXkzYW5Dk0kwUBL99eWjHk1dr0rvppOy6AleELVaDj
ZNIhkvvdxLO8ckgffYGuagU1Fu0iMdFGkIAEwT7GNRyxgAkShno=
=iESq
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
