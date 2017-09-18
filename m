Received: from eggs.gnu.org ([2001:4830:134:3::10]:50964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtO-000169-VG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtN-0002hx-Qz
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:38 -0400
Date: Tue, 19 Sep 2017 06:25:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918202552.GE15823@umbus>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505668548-16616-3-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
In-Reply-To: <1505668548-16616-3-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/8] ppc/mac: Advertise a high clock
 frequency for NewWorld Macs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, benh@kernel.crashing.org


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2017 at 06:15:42PM +0100, Mark Cave-Ayland wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> We use 900Mhz, otherwise MacOS X 10.5 refuses to install.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to ppc-for-2.11.

> ---
>  hw/ppc/mac_newworld.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index d466634..c581d96 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -77,7 +77,7 @@
>  #define MAX_IDE_BUS 2
>  #define CFG_ADDR 0xf0000510
>  #define TBFREQ (100UL * 1000UL * 1000UL)
> -#define CLOCKFREQ (266UL * 1000UL * 1000UL)
> +#define CLOCKFREQ (900UL * 1000UL * 1000UL)
>  #define BUSFREQ (100UL * 1000UL * 1000UL)
> =20
>  #define NDRV_VGA_FILENAME "qemu_vga.ndrv"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAK9AACgkQbDjKyiDZ
s5LyGBAAsBjiwCuSiMSRXUNs5Z82K3ugUXKKeOD9XD/fRl6iQA+RD6Qh72NCavKB
vLMB0IS9kf4RMALMZ1+6EEApr+pdrz/5AJoNMapZVKo7WXA8OGOeHhLSJY6xmzk1
JQAaDNIW9X4hkanrDPNbt9KAPpUxbBT53ER0HwnA3QTbC6BO30pKr40lgFrLu8Ue
EP8a/Ioi0BjzWGbils191a5DIFWiNNVp95/mcY+IfAnBTaRoymXumKFg1y9Nqsme
K/q2IZIrLyaAIdmS72bCUe6LKwRz8IlOC0cYpQNPoLr+nKueIvCn52f05reijVVx
UonpPbn7K+l5nd2FlYq9K9aZX5Ic4s4Mv+lKKG3MH1PdTqNLv24bsygkoJcyuUjZ
B8zxXb2ms3Kl9bvMRXgDl+ua8dhvJMiZJTSp2PmW+ugVpP3PYfYufKWjGsMnbRTL
ZeyASqe/T8ZOo84Mc1NdrAha5ptSU7Qi4vIq9kPWTggLLqfz2Y6dszLGCGmOyrtX
6FWC+EBAsUZWzo/+/6aby3/WkrKmcdjnPqfQxOf2o2Aa+AEpwbaj2PnCL8FPiQk1
irayQqqM4yiVDnmqnZCW4GLumyefoPI/vJGPZz7rdgRDhOYZrCmVE+Gj8xhbK6oi
cJ9YAHLB1c9JzBRGjzV2Rk6MDXmruDiel8difpsEMTmdpgDe6PY=
=pEuH
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
