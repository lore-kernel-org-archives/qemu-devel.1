Received: from eggs.gnu.org ([2001:4830:134:3::10]:54064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct62B-0001vI-7a
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct629-0005lp-SA
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:20:39 -0400
Date: Wed, 29 Mar 2017 16:10:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170329051032.GY21068@umbus.fritz.box>
References: <20170328081349.18734-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lYVfafuUkPqz/tKz"
Content-Disposition: inline
In-Reply-To: <20170328081349.18734-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] spapr_pci: Warn when RAM page size is
 not enabled in IOMMU page mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--lYVfafuUkPqz/tKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 07:13:49PM +1100, Alexey Kardashevskiy wrote:
> If a page size used by QEMU is not enabled in the PHB IOMMU page mask,
> in-kernel acceleration of TCE handling won't be enabled and performance
> might be slower than expected.
>=20
> This prints a warning if system page size is not enabled. This should
> print a warning if huge pages are enabled but sphb.pgsz still uses
> the default value of 4K|64K.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> This follow-up for "exec, spapr_pci: Advertise huge IOMMU pages".
> Instead of silently changing PHB properties+behaviour for better
> performance if huge pages are detected, this simply warns the user
> if IOMMU page mask needs to be adjusted. Since the user chooses
> huge pages in the first place, the user can also supply additional
> page masks as well.

Applied to ppc-for-2.10.

>=20
>=20
> ---
>  hw/ppc/spapr_pci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 98c52e411f..097ebdd51d 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1771,6 +1771,12 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
>      }
> =20
>      /* DMA setup */
> +    if ((sphb->page_size_mask & qemu_getrampagesize()) =3D=3D 0) {
> +        error_report("System page size 0x%lx is not enabled in page_size=
_mask "
> +                     "(0x%"PRIx64"). Performance may be slow",
> +                     qemu_getrampagesize(), sphb->page_size_mask);
> +    }
> +
>      for (i =3D 0; i < windows_supported; ++i) {
>          tcet =3D spapr_tce_new_table(DEVICE(sphb), sphb->dma_liobn[i]);
>          if (!tcet) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lYVfafuUkPqz/tKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY20HFAAoJEGw4ysog2bOSPfQP/0/J0Fmd56IsLghEsFPl59rG
WLF+obXI990fb6TKixtGKP7t+5BYDlfUpCqAUK28BnhrNHFnBjJOLldoOK8yYCp9
KKB7+IDBEQh7OXRfnSjitzHaMYkOxTVnJuxavSXnfu/UGJxnysvi5SGA8I8axNDS
nFYbXNCxoRP0olOvO9WnpMKxj+nJnMC7z+hwJpXQGDOuBA7P/L3sSEadnCJS+dQl
bnKKPMOno34z5TXhKbE2du23bvgxK0LflkCV2Hxy/ZQzQdwP9hlW+4I7dnTwhSgb
m7Fp1VZQCm4ob8JL0lOBQh8To1c7GGfPfaarHK7ty7oNhjTtzGNlS2MqkeNczOcQ
5NgMb2UT53mUEu/CPFuoNwoghIuExDfDKdeQTKkUzy9gyf/M0XBo+oXqMwoL7iB8
4wqJelOsI59YVQclPWWOvdt3QROXyUyUyV6yoToce4Am0X1+w2z9RXp0J8Mt+MLt
wYMoW8kdD6c0vOW8DYtNScpK6FJouhMlI6C9ao0GGF7LrFPLuxOt4DjIywTm+23f
j8POmNCd1dMjFpNVcF6n2cP2O3g08E6ll5NRu9NRBmQNPaFiQOe+eOIFprd2XAC1
Kg0ZTz9xep9pnXuKq8XVbL0QyZskxQzwCGT3diwfgzmR7b80ZkTKm7b+Wq4ZsjoM
lX8ymysrL1eKG7D/K7vO
=tvJd
-----END PGP SIGNATURE-----

--lYVfafuUkPqz/tKz--
