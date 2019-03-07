Received: from eggs.gnu.org ([209.51.188.92]:38758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2350-0002z2-EE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h234z-0002vW-FO
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:38 -0500
Date: Fri, 8 Mar 2019 10:39:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307233938.GX7722@umbus.fritz.box>
References: <20190307212058.4890-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b2s+RKoBicgQlNJs"
Content-Disposition: inline
In-Reply-To: <20190307212058.4890-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/2] mac: fix booting from hd device with
 -drive syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-stable@nongnu.org


--b2s+RKoBicgQlNJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 09:20:56PM +0000, Mark Cave-Ayland wrote:
> These two patches correct a mistake in the original FWPathProvider
> implementation for Old World and New World Macs whereby the alias name is
> used instead of the node name.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

>=20
>=20
> Mark Cave-Ayland (2):
>   mac_oldworld: use node name instead of alias name for hd device in
>     FWPathProvider
>   mac_newworld: use node name instead of alias name for hd device in
>     FWPathProvider
>=20
>  hw/ppc/mac_newworld.c | 4 ++--
>  hw/ppc/mac_oldworld.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--b2s+RKoBicgQlNJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBq7oACgkQbDjKyiDZ
s5IpYw//XopRLTB+aPOWsUZxVbJ/fO/W+nAbHhN+UfOfX8SgGABEq3cyfr+Zxk4N
OKxvMXubd83JfAYH6oYjwPMWnK+4RO0RRRVhx6JyqgjYMMPnbgfMHladpHlXVIgT
Af7RFFILN/2+0I2zFeIdUm5cNJLG9+Ptz3anO8trnht15YWxnQWYAo8DEL46vh2p
cvo8mDBhCjaP7OIJz0M7F0Gxc2XK/BvoeCIpDtpCGrOgLoa8iW0z6EaliLPusP9j
4jNBhbvsL3W86BBuM4M0X8oLWwC/e6HP94a1V4pKnXIYtx2WzXF0SA9XC0AV55YR
tiYoVFeilAsJ/Q8cbxSqJjzdX/PoW+AopFvHCizPmhh2AESAKY3rpsH/E0yVAxql
D3vizh8tOf3pv8zAOrf5/JOazaVZEil9/8H4S0CMfPRLKIcLQYWA95XsLTlLL2ZO
+Sxa3HROoIl3EPHQzG4UJDLdWzMb8/B91OFfu7Q6t/ZTVGdxjkdw8oB8zW+TmdG2
kPnMZebYIKbHfK1dlXvMAJntodMkGo8jH+Fu5kTMBDhQXoHW8ursgUmU8MAa304Y
QtbIyaJOaZULMGd9AjkdK4R6ftFX9wtngGZCiVmuv7xSFY5iMrgvRtTlGzS2wYpL
NaYGKoUQJtsB7vAfTwFmYSp2kxHtZsReGSkd8e0xE/yCmwnN3UM=
=t38m
-----END PGP SIGNATURE-----

--b2s+RKoBicgQlNJs--
