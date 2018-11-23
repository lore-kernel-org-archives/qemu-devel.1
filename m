Received: from eggs.gnu.org ([2001:4830:134:3::10]:48782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPzDN-0007AV-IY
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 19:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPzDJ-0007tI-GF
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 19:20:57 -0500
Date: Fri, 23 Nov 2018 11:20:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181123002037.GO10448@umbus.fritz.box>
References: <154289709597.235079.13366613265527123490.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vEfizQhTV1P/vojJ"
Content-Disposition: inline
In-Reply-To: <154289709597.235079.13366613265527123490.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: drop redundant statement in
 spapr_populate_drconf_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org


--vEfizQhTV1P/vojJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 03:31:36PM +0100, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-3.2.

> ---
>  hw/ppc/spapr.c |    2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9c41098b5781..7771a628f879 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -893,8 +893,6 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
>      /* ibm,associativity-lookup-arrays */
>      buf_len =3D (nr_nodes * 4 + 2) * sizeof(uint32_t);
>      cur_index =3D int_buf =3D g_malloc0(buf_len);
> -
> -    cur_index =3D int_buf;
>      int_buf[0] =3D cpu_to_be32(nr_nodes);
>      int_buf[1] =3D cpu_to_be32(4); /* Number of entries per associativit=
y list */
>      cur_index +=3D 2;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vEfizQhTV1P/vojJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv3R9UACgkQbDjKyiDZ
s5JgzQ/9Gud9ccOjZ+GsxWD2C47Oe84U75HjmPMaLF7tvRkLInWuABAcCaAkrc9X
UpNJy+ySiTMleECMgZ6g37IVbxT56gR3uaOgICuIpnD24AG3kZLZCU3V9fwyZded
c4UWsCyW3r6cTjbv9SXmuNJvaBpKatdUwuLnqovKchTkH1SaPrT2efY1vQGK1LHd
gz2bBcoyEXVyVh8NAYG5+t0yF+6Qf3eU71vJLhnjhPF1llv9jVib0DX9uEbAb3jU
pNrBY/2ixHSBarpcKvQxh+9mqAWMbGyK1f6rVeeC2hnPgeTJjccPJtxQblbOiOJo
bFWQjWaez8tDCbkvrFfcJ4mJ53karS0eZ9CtFE/2GfrY+PXvFLpYYwdlA8iuQAmj
qidaA2PjfrNI42PHL3LchxDBtfTal6lXs9guUkHx7pVD1hNhbUEDT5taNNdq/lQa
ifCpIHLw9+xrnFiegkrUcoiK0p2bekw96KVWXV8YxZjx+kWzQ2eDdJAsMXDUo/Jq
K05knUdZDHPxYe/s93jbnL9hQrr/oRh5lVZxdnz4iF+FU++Fl2bF1w9MdaM+bFkx
FBKiIhUN644X7s4DD49k5luBz9dusyA6oqAdt7ch9McAiqoEzoqCf0azT8HJOrEV
VobBzy/imMLf4s3lvHZ/nRVg/JBLq/+QlCNPJkI3JgLI5ep37hE=
=JQP0
-----END PGP SIGNATURE-----

--vEfizQhTV1P/vojJ--
