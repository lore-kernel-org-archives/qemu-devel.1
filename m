Received: from eggs.gnu.org ([209.51.188.92]:36145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guULF-0008U6-Ry
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guUEa-0004cn-E7
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:32:18 -0500
Date: Fri, 15 Feb 2019 14:32:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190215033202.GH4573@umbus.fritz.box>
References: <20190214052144.59541-1-aik@ozlabs.ru>
	<20190214052144.59541-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+QwZB9vYiNIzNXIj"
Content-Disposition: inline
In-Reply-To: <20190214052144.59541-3-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2 2/4] vfio/spapr: Rename local
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>


--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 04:21:42PM +1100, Alexey Kardashevskiy wrote:
> The "systempagesize" name suggests that it is the host system page size
> while it is the smallest page size of memory backing the guest RAM so
> let's rename it to stop confusion. This should cause no behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  hw/vfio/spapr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 302d6b0..1498fee 100644
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
> +    long minpagesize =3D qemu_getrampagesize();

I'd prefer "rampagesize" or "minrampagesize" here.  "minpagesize"
doesn't make it clear what it's the minimum of, whereas rampagesize at
least makes it clear it's the same thing that qemu_getrampagesize() is
working with.

>      /*
>       * The host might not support the guest supported IOMMU page size,
>       * so we will use smaller physical IOMMU pages to back them.
>       */
> -    if (pagesize > systempagesize) {
> -        pagesize =3D systempagesize;
> +    if (pagesize > minpagesize) {
> +        pagesize =3D minpagesize;
>      }
>      pagesize =3D 1ULL << (63 - clz64(container->pgsizes &
>                                     (pagesize | (pagesize - 1))));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+QwZB9vYiNIzNXIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxmMrIACgkQbDjKyiDZ
s5ILPw/9EkcNXiwiKrktNtDUvdOd6bZE/KPhKp46ercaHLgxFJSR829cr89B2eyA
BRkUR+ZGYLFdVXZFYi2pFCRO7qJg7L1cm2DPrgA/dnOTWi27KF3raklqe5cHD7ww
4I0hIIcLVGh7kb0VtTCMjED/GdSsziLnftJSt+fvlfVUdeYbnQm6zo8m71/ZN2q4
PKDRqiOjYiIUxygR7td4bDFvkHRjoWIvu/ArPXYribYJaNxLgwt2OuNrs86eInJs
b3TP0jKojO2E/FV78/S8pIkbDhfmvFiGSbOijn9mQOZR1ftzTELAHuPjAhWGiWad
G8LxYz1eQNiducZ5n+ku9T/JYZsmTe6rnp/FWzlq8AQ/khDJXtdWXOOcCtD2UoJq
4UxXLyVPcoG+IFdLm+VvokEQdEqCvWNSx1y2fXlYXQkcTTSNBGbidAvZvpQ9Vr5f
tgpfidkmKxKPXB765twLDKuoEecXkWlcLDA366OD9GWK/TN3fJFYRajuic+F+Q/O
N3gtjH8ZkBcufei/ANeldaYRTtVwYdAMMfUh2nRAqnqa9+HxU4fKddKolPWLVVwj
nz3WpppTtFa+QGda/2jYhVREpxU9QCJjNu1qPUUjjOSjb7Oh4Nyuce4XDmtixk1O
8YwZmLS/q2r+dkDVZfXrDkqPzNzcE1VtL/rg/PgEk5TZkMTaULE=
=XI4Y
-----END PGP SIGNATURE-----

--+QwZB9vYiNIzNXIj--
