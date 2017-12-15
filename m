Received: from eggs.gnu.org ([2001:4830:134:3::10]:58036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePj40-0001nq-NF
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePj3x-00011b-Kq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:01:40 -0500
Date: Fri, 15 Dec 2017 17:01:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171215060126.GG7753@umbus.fritz.box>
References: <20171212051619.24456-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
In-Reply-To: <20171212051619.24456-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2] vfio/spapr: Allow fallback to
 SPAPR TCE IOMMU v1
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


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2017 at 04:16:19PM +1100, Alexey Kardashevskiy wrote:
> The vfio_iommu_spapr_tce driver advertises kernel's support for
> v1 and v2 IOMMU support, however it is not always possible to use
> the requested IOMMU type. For example, a pseries host platform does not
> support dynamic DMA windows so v2 cannot initialize and QEMU fails to
> start.
>=20
> This adds a fallback to the v1 IOMMU if v2 cannot be used.
>=20
> Fixes: 318f67ce1371 "vfio: spapr: Add DMA memory preregistering (SPAPR IO=
MMU v2)"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Alex, will you take this through your tree, or should I take it
through mine?

> ---
> Changes:
> v2:
> * updated commit log
>=20
> ---
>  hw/vfio/common.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7b2924c..cd81cc9 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1040,6 +1040,11 @@ static int vfio_connect_container(VFIOGroup *group=
, AddressSpace *as,
>              v2 ? VFIO_SPAPR_TCE_v2_IOMMU : VFIO_SPAPR_TCE_IOMMU;
>          ret =3D ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
>          if (ret) {
> +            container->iommu_type =3D VFIO_SPAPR_TCE_IOMMU;
> +            v2 =3D false;
> +            ret =3D ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
> +        }
> +        if (ret) {
>              error_setg_errno(errp, errno, "failed to set iommu for conta=
iner");
>              ret =3D -errno;
>              goto free_container_exit;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlozZTMACgkQbDjKyiDZ
s5ItZQ/+IY8aGUqrWSZ48HBGK9aFdZAro5xYzgyjKbf1HaE+VRtzypaVKvC71yuk
PvonwnT91OnmK1xEIIYBNjsK+JpbZXH5mmbrwFHcixYeHZCi/fYH1ZCmjerMiSJ9
1EbS4Cld+zYo6Zizoiem7v/La8ogPckYXjq/scMIa6Z4oSjALetND7NEgO2p5S2M
7boBBb5y9BU4/8R134JtXnEZYgVOODfO6/d7MdvBWzhqRO5dr6ZIHD6dKpotHbrb
/8AINTRg0s6ayY8Iw4fzbkKVbynZX5NPJSFoJMaUQVErY+tRgqm/ypOZGZIBftue
D+FFJK6hkVoBHl39f1JI3ydR7iLKyOsiknhvUg5DBugtYH3Sc+1NaVZn86Heu1yl
pTjMdJmoXTDKvXZWVJR1IQcX5bIrXTaSCCNZU23iHm0FdaiNvcWkG3ob0mJrs2+g
oNR0ryE/Gt5hdWatpRB8jSguvPBqHFh1ZeIqWcYu+fxtRWDeMTAz7LbkDrJGMzv8
AkVTvC4G+75pUGMEhpR6Aqk/sKBXg3vXtZdI4uNjmUiXdu0EFEXidyEuUauPlDNs
9S4yUeqWOVJM14pKuuhWATpmOut1Udv6+NR0l1hYrJ25gmu3UBVmEaW5RK+YAv69
ctjMo+1Kirepe4dzIgExfvvHrUmO8TvyIWczQ9A0EWzdL6Udx5U=
=0xMk
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--
