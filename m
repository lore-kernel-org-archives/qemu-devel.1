Received: from eggs.gnu.org ([2001:4830:134:3::10]:48120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eaxIE-0008HR-C0
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 00:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eaxIB-0006V8-6g
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 00:26:46 -0500
Date: Mon, 15 Jan 2018 16:26:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180115052632.GE2027@umbus.fritz.box>
References: <20180114192349.22212-1-joserz@linux.vnet.ibm.com>
	<20180114192349.22212-2-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <20180114192349.22212-2-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc: Change Power9 compat table to
 support at most 8 threads/core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, lvivier@redhat.com


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2018 at 05:23:48PM -0200, Jose Ricardo Ziviani wrote:
> Increases the max smt mode to 8 for Power9. That's because KVM supports
> smt emulation in this platform so QEMU should allow users to use it as
> well.
>=20
> Today if we try to pass -smp ...,threads=3D8, QEMU will silently truncate
> it to smt4 mode and may cause a crash if we try to perform a cpu
> hotplug.
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

Applied, with the addition of a comment explaining why we want this
despite the hardware limit.

> ---
>  target/ppc/compat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> index ad8f93c064..d1770cdc6f 100644
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -73,7 +73,7 @@ static const CompatInfo compat_table[] =3D {
>          .pvr =3D CPU_POWERPC_LOGICAL_3_00,
>          .pcr =3D PCR_COMPAT_3_00,
>          .pcr_level =3D PCR_COMPAT_3_00,
> -        .max_threads =3D 4,
> +        .max_threads =3D 8,
>      },
>  };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpcO4YACgkQbDjKyiDZ
s5I8LxAAwtAdiRsf1mpVZ4tj2sjB5d5hbYIj12slBKxhQ8r5Ui3Yk/pGwWnUsfbH
Kr8jqEb+4djk6xrV8jYqb13IDY0rPUCZwtDaz4JFhYtOlJ4DXLWh5KZyDVvNJKRh
3tUvRcTHityA7oWPVq24oGaDse/l3FW0xSLJxqfH0kk3glvkbiye1JErv3z4vaLh
mcPS84AdOcVXjk5uWQdu7rJOGTv32lZ46oaJ5Lx5FWKQI9BDuimY8W3oPbtKrSvX
MP+A33qNFBNQPkkln0tb1BaQl+heOVN260zTJyuzVO+IL5O5X2yVwE1IwIOHewKC
ZzhQolY0f+RLteQ8gaS5+3wJplUJiBzsHZlt2Ap6NEsHMXNGAm9UZ3TxDgr1JBAb
u2O+rgYubRLTjEY2/18LOB5OAO/WOjoYsDE+2c6nUUNUlU19v18YsLTyzIDS3z8n
40LsL8Q+weyRQdjaY/55Ja2nultLfZlzlC43jc5MRfvQ/A1rzlf3Feyvz7yz2U3z
Mj4SQo7OG5uffJ1fxZewPoVNnTkj3AyUEBSN1XYWlK3DUl4YK5Ke/lKxq4xT5OxL
54wyng3RO+NMhmo9QT7a0NAjEjN9/Hd/V/uiSxaYpc5QdHzcYFEn+GiQ6q9OhhuP
kbo6+EENyeC/rnCCi94bRkhzUAtqyWXQ2EWPxQR3LkaBNs0YDRQ=
=6yQt
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
