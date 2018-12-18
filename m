Received: from eggs.gnu.org ([2001:4830:134:3::10]:50361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ530-0004iO-0T
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 21:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ52y-0005AM-JY
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 21:23:49 -0500
Date: Tue, 18 Dec 2018 13:13:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181218021343.GC23604@umbus.fritz.box>
References: <20181217223445.28594-1-clg@kaod.org>
	<20181217223445.28594-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
In-Reply-To: <20181217223445.28594-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v9 1/7] target/ppc: fix the PPC_BIT
 definitions
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


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 11:34:39PM +0100, C=E9dric Le Goater wrote:
> Change the PPC_BIT macro to use ULL instead of UL and the PPC_BIT32
> and PPC_BIT8 not to use any suffix.
>=20
> This fixes a compile breakage on windows.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied (before the rest of the XIVE patches), thanks.

> ---
>  target/ppc/cpu.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index ab68abe8a23c..527181c0f09f 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -70,9 +70,9 @@
>  #define PPC_ELF_MACHINE     EM_PPC
>  #endif
> =20
> -#define PPC_BIT(bit)            (0x8000000000000000UL >> (bit))
> -#define PPC_BIT32(bit)          (0x80000000UL >> (bit))
> -#define PPC_BIT8(bit)           (0x80UL >> (bit))
> +#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> +#define PPC_BIT32(bit)          (0x80000000 >> (bit))
> +#define PPC_BIT8(bit)           (0x80 >> (bit))
>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(b=
s))
>  #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
>                                   PPC_BIT32(bs))

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwYV9cACgkQbDjKyiDZ
s5LxdhAAhxZb8qad8++PRmjA7IFsfHTbgzv5IeCSyZ847SYLpJMVP3+PSqsOX6zF
lK5lxCOCWDE6pUtKDVTM9MP3A650Oyz/SMUA+c572G+DfbR4LFDZM+fuQBhidHvA
IpyClT3AULrKCXhI5cu9qfm8OpQ8P0BcRvxZ284fw/+huqXgM8Y0PQb3aWUaDhzB
ifTKC1+mku21bX+NEKKUrZuBlK/zE5l2U1/3TkFneGKZHCnuKh8XCC/wHkRImUq+
kXDHXaz+jxYFqKSwSz6SHaECO9eJifRUHVjV2BMaN9PftnVfscW0qX+5Fz+AvojP
zVGR6MM+k8XRVS7VGxbflqYxjLu5S0sDwQvKun3kHMh32ivwwj/uvbVetXdG3OLm
OPpUOGRk4FJmgCz175CzM8m6cUxZ44Iqq/vOsi+LBBqQ9ivCSFsrdbaG+GFf+pL4
yX+9pzYNVJx2BWE14UalU/kjzmlfDVP3RMj7YI4YgUiNsEMJeDkCc81UEupej48H
MsTqFmh3HPFMAVKT36hkLB7xlBbL+t/Muhi/ZxuAKfArWEfp9Li5mnKWkcHfVFxi
Mzd/CEIVzCDxncZy3A0BkHRIHJb0rpRwJzxdop1TFH3lEpLbfRX0GQrj9oiRencZ
3UFRAyjH+wuADxiwSkfbh5c5fGIYv8v2bRTsMnM4C7k1g3u8tNw=
=hi1Y
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
