Received: from eggs.gnu.org ([209.51.188.92]:46630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCnt-00043e-85
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCns-0005n9-8P
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:56:13 -0500
Date: Thu, 28 Feb 2019 13:26:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190228022600.GE7734@umbus.fritz.box>
References: <20190227085149.38596-1-aik@ozlabs.ru>
	<20190227085149.38596-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <20190227085149.38596-4-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v3 3/6] vfio/spapr: Rename local
 systempagesize variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 07:51:46PM +1100, Alexey Kardashevskiy wrote:
> The "systempagesize" name suggests that it is the host system page size
> while it is the smallest page size of memory backing the guest RAM so
> let's rename it to stop confusion. This should cause no behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Definitely a good idea, applied.

> ---
>  hw/vfio/spapr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 88437a7..57fe758 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -148,14 +148,14 @@ int vfio_spapr_create_window(VFIOContainer *contain=
er,
>      uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_mr=
);
>      unsigned entries, bits_total, bits_per_level, max_levels;
>      struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof(cr=
eate) };
> -    long systempagesize =3D qemu_getrampagesize();
> +    long rampagesize =3D qemu_getrampagesize();
> =20
>      /*
>       * The host might not support the guest supported IOMMU page size,
>       * so we will use smaller physical IOMMU pages to back them.
>       */
> -    if (pagesize > systempagesize) {
> -        pagesize =3D systempagesize;
> +    if (pagesize > rampagesize) {
> +        pagesize =3D rampagesize;
>      }
>      pagesize =3D 1ULL << (63 - clz64(container->pgsizes &
>                                     (pagesize | (pagesize - 1))));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx3RrgACgkQbDjKyiDZ
s5Lufw/8Da/D/i2H6paR11lCiOh6ca1w3Hiq+7S4X9EN2I6vkNvbq4Ni+oOU0GTk
x9Ukcuolkaxd1/alqNuiOJg12OiZg5UgoKuUm0O8G7nrYPkT6sJ+zd3u9aTGY4tb
MfF6B5mfR6OPDMMz8Ibz7VqKnijD9Ikm0E20KuOYTz5RIk6Gk2bbpRE1hGEd/3LF
PiZMj/MwXSog9m4RJQ5TVpj/U4ZTnzTws6OIr8PLU9pFAqgXykaJ3z1Zwf1+OW3Y
4mlLlCxNMlOGcI+7aaOtW4BBuWuyeEnsc/uD2g8zEUrjAd3NuLVeTNlPFfAEpsmr
X+dchHvWfQR5j5xd7i63ASJwmeILsuFyH+N63MxpavAsuKhhKYtQxjgetyg9GcbU
iDw8skFczhNf1FWEZ6diJCj7HJ/jDmCMmOFb6QJ723mYUu8Qn0p8JtYYJFHUvt5U
iBU74d1S1mBgMdTZhBLvN8HNFCK6uhAVwgykksCEuWoLd8tmNw7449m+3TiHT1o+
ABeWWz2aHn0FNTfyu3aic1VuTycggl0wCDpYXaqHWYaqT+sKKUUgARRntGrSAvGb
rGqOu0SOCtDUmY8fBB2VVB9Cdx+CjKzGOBrRf/KRhogMRg3Mc1N9MYN/7AW84VvE
i/lUmbNmVFv0RLEDJeyfoRUP9q/j1ZLjgMtgGx/aQGg9o8GRvAE=
=V/gx
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
