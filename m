Received: from eggs.gnu.org ([2001:4830:134:3::10]:57935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gBsLR-0002mp-C3
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 22:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gBsLN-0002Gi-Go
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 22:10:57 -0400
Date: Mon, 15 Oct 2018 12:04:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181015010438.GI16167@umbus.fritz.box>
References: <153933509870.3834759.13291133122604475240.stgit@bahia.lan>
	<153933510947.3834759.3504000962964977142.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Content-Disposition: inline
In-Reply-To: <153933510947.3834759.3504000962964977142.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] spapr_pci: convert g_malloc() to
 g_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 11:05:09AM +0200, Greg Kurz wrote:
> When allocating an array, it is a recommended coding practice to call
> g_new(FooType, n) instead of g_malloc(n * sizeof(FooType)) because
> it takes care to avoid overflow when calculating the size of the
> allocated block and it returns FooType *, which allows the compiler
> to perform type checking.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-3.1, thanks.

> ---
>  hw/ppc/spapr_pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index c2271e6ed462..0537ce018f51 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1883,7 +1883,7 @@ static int spapr_pci_pre_save(void *opaque)
>      if (!sphb->msi_devs_num) {
>          return 0;
>      }
> -    sphb->msi_devs =3D g_malloc(sphb->msi_devs_num * sizeof(spapr_pci_ms=
i_mig));
> +    sphb->msi_devs =3D g_new(spapr_pci_msi_mig, sphb->msi_devs_num);
> =20
>      g_hash_table_iter_init(&iter, sphb->msi);
>      for (i =3D 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvD56MACgkQbDjKyiDZ
s5LUaxAAp8Hqlr2oSBY2DG9Pk+ldGHzSxRFR0h7oLUuVVnAAdVoWkncbWut4VjXU
CDYfcw4XwcTjE0NI4ME5SkPYMiMTFzup1uq2UlmP3YU6WLqixA1CK7xVEEPM9c9A
7n5vaDBSwLk+QjTCJssT9F958IwmZfmDR48f0KKkfXpWm9RcwlWQ6WNsw6uHH4oF
nEXiYMOEXtw/Oeh7NAhdSfxM5vuycTZNuAps/xkJIbkRtzAACoFsSlMrekXrjcXd
BGFf6og5AkSrG9KFC+GpYhJAriy/I1Ec3ti+1oCE4GwVtn7329S9cb7YXjsZ11hl
Du2U3kAo4k7VvrkLSfzex3lqAOjs75Iwffs2KPjGEt59OUjIEgg72q/j30Eoh+s2
KaMO//IYCLalzqSjYprNzB1OXFihRTeHf53DPj8ungqxXco4Ad2E52MuBn83jvt1
jm5dgsI87twmHtavgA2bcO4APMH3TlfiYfZYYenZSsUY3ouq+HN7YJGUPihdjCvY
5S3kedLOSgwCSM+GDY4+IZWM96bHrDj4ei3GoE39B++2jYXn+YKl9ROmjqwauKwk
vPnYa1Z6mBlPkU1PZ5X0uJIdkFNp92Skj0uV3pFKWMKh1vm1wrhffakgow+JHTWg
HiXIi+cScA6M4UjRIy1dmdtxdZ8sR+3DzEelKrWlctgo3b521Ew=
=8Tvp
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
