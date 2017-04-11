Received: from eggs.gnu.org ([2001:4830:134:3::10]:37494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxp7m-0003TG-Av
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 02:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxp7j-0005Nk-7J
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 02:17:58 -0400
Date: Tue, 11 Apr 2017 16:15:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170411061535.GB12900@umbus.fritz.box>
References: <20170411060456.21594-1-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <20170411060456.21594-1-anton@ozlabs.org>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix size of struct
 PPCElfPrstatus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Blanchard <anton@ozlabs.org>
Cc: agraf@suse.de, aneesh.kumar@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 04:04:56PM +1000, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
>=20
> gdb refuses to parse QEMU memory dumps because struct PPCElfPrstatus
> is the wrong size. Fix it.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Fixes: e62fbc54d459 ("target-ppc: dump-guest-memory support")

Applied to ppc-for-2.10, thanks.

> ---
>  target/ppc/arch_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> index 28d9cc7d79..8e9397aa58 100644
> --- a/target/ppc/arch_dump.c
> +++ b/target/ppc/arch_dump.c
> @@ -50,7 +50,7 @@ struct PPCUserRegStruct {
>  struct PPCElfPrstatus {
>      char pad1[112];
>      struct PPCUserRegStruct pr_reg;
> -    reg_t pad2[4];
> +    char pad2[40];
>  } QEMU_PACKED;
> =20
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7HSHAAoJEGw4ysog2bOSij8P+QGpXOeQy5n5gWkNPXy9dKcp
r8TzvxjI54dSVhsBu77yh0VdJykgVqpRiKmLNtGNNabOgw1+WEk50zZrQQ8aj/5i
XwNHZ2rV5qgxSn+yeCb+CV81odAI0j7Ccb+H8mpE/Mk+XNTaJKoM2870GxgNUGEb
vQHlshXNVFTA/iPyyQseiYYAEu5nB8MWfqdCiHsD/Rh6y4zRLQCq2tMe+iO3UHi+
2J7j6QFYaUmo/MXAgLMo0vsmTF/BAG1NC4CQaJTgWJA4FQ3wddoFZXhXpSyzhMdM
k8yCAyGlNtqxkh9nGXB4n9cs9Iy4MQ4Q6UCrNtBtrQU2GdtgFU0qHvWrkFh3xDeG
MP/aZCac02K+bDeelgzG/xxd9u3oy+sMAzXXOASo1yOwWU8B+BCBhKQwg9Umn8O1
KaJcP4R8mgqoG730jviN65Z2W/UJuhdrD0XYUlnj4tGLcy0OorMGsihDK/LEJJJb
BUFgjjeQIkEKnyfUzewwgICjIDUuaIlnGFqT46Wr6GoY2oiNU8AOD4h/JoQX9Yhl
rbodLzvhR4d3eDzrHcn+67o+IUQtUJw6zFvYKxLg2QSDzw7zKHeV18Y0FSN16lXU
xRb8SP7FHxnkRK+BCA7lyOLUYChI0CwLhNaVtxa0YtrdSjQAOEKYKCSyQW4V9Wzz
soiQHKfKLPxo8KB6w+6r
=HioY
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
