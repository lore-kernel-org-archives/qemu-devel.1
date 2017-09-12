Received: from eggs.gnu.org ([2001:4830:134:3::10]:35294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drcpS-0004fL-VW
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drcpP-0005OK-Sz
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:29:42 -0400
Date: Tue, 12 Sep 2017 13:59:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170912035906.GC2774@umbus.fritz.box>
References: <20170912025307.45376-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <20170912025307.45376-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] vfio, spapr: Fix levels calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2017 at 12:53:07PM +1000, Alexey Kardashevskiy wrote:
> The existing tries to round up the number of pages but @pages is always
> calculated as the rounded up value minus one  which makes ctz64() always
> return 0 and have create.levels always set 1.
>=20
> This removes wrong "-1" and allows having more than 1 levels. This becomes
> handy for >128GB guests with standard 64K pages as this requires blocks
> with zone order 9 and the popular limit of CONFIG_FORCE_MAX_ZONEORDER=3D9
> means that only blocks up to order 8 are allowed.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-2.11.

> ---
>  hw/vfio/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 32fd6a9b54..259397c002 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -163,7 +163,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>       */
>      entries =3D create.window_size >> create.page_shift;
>      pages =3D MAX((entries * sizeof(uint64_t)) / getpagesize(), 1);
> -    pages =3D MAX(pow2ceil(pages) - 1, 1); /* Round up */
> +    pages =3D MAX(pow2ceil(pages), 1); /* Round up */
>      create.levels =3D ctz64(pages) / 6 + 1;
> =20
>      ret =3D ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm3W4oACgkQbDjKyiDZ
s5K8vQ//Y7GFeDG0h3c0gbWj0fZmJC3UVnmMnfTKym2jUa1prhlwZ/u11s7QAKFU
iUUFDQF+dwcz7NxhHnh6I4lzOqaQIQvQQyUF0uxipqgz/JcL4XkBLtxAcNZ1YuEJ
Ubz2UTYpy0tcUaPP7NS6Ztz1GApjsKvqJHSK6wZdx6MXRbofL8LNuZTStR+yUmKG
TkGrjo7Of8Vobo80UE7cm1EAn6vXODdlNzSY7pQm9pA3oMp1DiZVByRkZohbEefS
2jJJUSoG/0Vq+TXe1cm+Oc813JvNLU3GkrvMA4B1yJkWJjZAS+A9/zL2XVMQrgRu
ezVCXuAglU7EafqNRvl2cibZRS6rto6jbZRwP3czr/ppO8PGvYEqrwenwSv2Wf1x
prKzdMX0DrdUosyDmZKbsQqWmB/8Z58GWCDhR7lWIPBuMZKxMszRvX7OIM90P9cI
m/b7sFgR3N1OIf52Tl42QkFZw+UY+6vApBMKn3xgmTXOufbOuQ7AepaDMDm4HJD9
BiUXbBdfZ8uXLkpXtOY2vfLnhg42GKudO66iirkJROkL3pA/lsx3INtpcn6xv/Ih
QHimhF+nj3NaBP4n1n1qR4ZhVsVqrF/7n/Xgb3+U21+3s7Y6RxPeVBNGZETqRktI
GVlNavAoX6zTlSTVw699lYzbveOnM9LVhDkqWPX5Wup6MwtkUxc=
=raOj
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
