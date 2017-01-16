Received: from eggs.gnu.org ([2001:4830:134:3::10]:54447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cT6Tw-00061N-9J
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cT6Ts-0006Ro-48
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:33:52 -0500
Date: Mon, 16 Jan 2017 23:11:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170116121104.GC15853@umbus>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-3-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <1484288903-18807-3-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 02/17] hw/ppc/spapr: Add POWER9 to
 pseries cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 05:28:08PM +1100, Suraj Jitindar Singh wrote:
> Add POWER9 cpu to list of spapr core models which allows it to be specifi=
ed
> as the cpu model for a pseries guest (e.g. -machine pseries -cpu POWER9).
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

I realize you need this first for development, but for submission,
please move it to the end of the series.  The idea is if you're
bisecting or iterating through commits, then when the POWER9 option
appears, it will actually work.  That won't be the case without the
rest of the patches in the series.

> ---
>  hw/ppc/spapr_cpu_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index c18632b..8cc7058 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -358,6 +358,9 @@ static const char *spapr_core_models[] =3D {
> =20
>      /* POWER8NVL */
>      "POWER8NVL_v1.0",
> +
> +    /* POWER9 */
> +    "POWER9_v1.0",
>  };
> =20
>  void spapr_cpu_core_class_init(ObjectClass *oc, void *data)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYfLhWAAoJEGw4ysog2bOSE2YP/iYLnroafVn6NzQKt/xEkpZ4
VrqkRA7iHQyU33GNJ2ou6Fz4zKURTRKW1wfGvfGwxnMhTXKUXngTBefBtUDaHOcd
1morMaQxANxLnnxxDiq0zxS6XrTfnbiBEGGolVW5jf6G9CEtKsMxz0XVlZSb2gE5
aIsPqxM+QpFbc+xRhZAOhyh8+jnFZjNDY46nv8axb2ABGWWJ7rPH7fEwHLBmuZ8Y
A6BLZ1V9xXlpr3To43ESh7d7PH62w6wG+fC5iUGauY/+EoRkTYMdcA91aPt0qE9Q
X6SKTAhVSLOX42tY1OjtUX2BfNsi/Fu9QZVPN3M6na5suthF2GIPYsffdbE381JY
Paqa20yuGB9At1B21I/3pnBiT0mFxfEm9ecESOVmBDmrQyf+wmB1Nzq6WzILrMim
JBRMOCPCfK7cROEc+k2lfUIwpfyheAy1Mplo20+8lftKd2FP7jKCfuIpbS6TavkR
lBLbD4PNGLqmZQ4CiAR1NUOi0ylO94TDLcoX0chv1cBbrPmXACb5Z/mG2xmlMTEi
uB9W92Yy1BFy+ZEhPSE5cXHh0vNfm3x43lABSCackErJsN5ib1Bx6sE9Fm2/JIgQ
p8EJSEycQQ7y2eXNw8F6XEJNZD9L28qCnWSER7XnKVe3ESkqMo9B9X4Lb0z/v/KR
NyxwXxUkCyRWUM1OtSx4
=U3qm
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
