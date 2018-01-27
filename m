Received: from eggs.gnu.org ([2001:4830:134:3::10]:50967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1efKKb-00080D-JK
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 01:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1efKKY-0007Dg-HA
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 01:51:17 -0500
Received: from ozlabs.org ([103.22.144.67]:55507)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1efKKX-0007AL-N5
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 01:51:14 -0500
Date: Sat, 27 Jan 2018 17:27:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180127062732.GF2099@umbus>
References: <20180126092029.20737-1-mark.cave-ayland@ilande.co.uk>
	<20180126092029.20737-4-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Content-Disposition: inline
In-Reply-To: <20180126092029.20737-4-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 3/3] input: add missing newline from
 trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2018 at 09:20:29AM +0000, Mark Cave-Ayland wrote:
> This was accidentally omitted from 77cb0f5aaf "Split adb.c into adb.c, ad=
b-mouse.c
> and adb-kbd.c".
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-2.12.

> ---
>  hw/input/trace-events | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/input/trace-events b/hw/input/trace-events
> index a8d46cb766..5affabc81d 100644
> --- a/hw/input/trace-events
> +++ b/hw/input/trace-events
> @@ -4,6 +4,7 @@
>  adb_kbd_no_key(void) "Ignoring NO_KEY"
>  adb_kbd_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
>  adb_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%=
2.2x obuf[1] 0x%2.2x"
> +
>  # hw/input/adb-mouse.c
>  adb_mouse_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
>  adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0=
x%2.2x obuf[1] 0x%2.2x"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpsG9QACgkQbDjKyiDZ
s5JYMBAAsB8Dg7t4aNa3PM0PnRpYtZJrymoMkKT2z0wbcCf2kbc9VK+zXNr84+Ym
ytS2Mv5K9uM8RDEX5rowEiXgepP3Y3iu7yUD3aMamFTdBjg7H32aMxZs5BPbhG/S
a056Nc525uJkQ+sI2bd6bEU0j8vj1Ke2RH7Pe0UN4hK+2/8PcVQfA/LUmsfyuS/8
AFD8v0iU+7BiJPYGd/qahrVVnM/QxysoMZ4A3IpwiMYUHC5OcfieG/1JdH9UX4r+
FxqJ3xoT+IgV/QyqVeT9OA3OUhDhKZCb9r78MiajvdRq+cPIK626juagXDeBJ59j
v6F9hlOTfI5gzWnxdLQQqDKLgvCg92iCzOHhlYCbMz3ULtGtTHyyHpd94b/NId4j
QvATFz7a46oV4xihwADf5e9qQd2d6lKbxPFgUjq+TkOeQbRzaCeFFOEg7nmCrYb1
2H74DRQJKOT0eoUUDSoOY/+4Jl2wPTzizoGp+Yy4j95q2ECr9SXAnwU62XmhCn0L
YfbZerzKd1JKMgeAXzJ7Y73Qa10rLO2FjzxpnPcDLA1JBALxXQu4Mu4GLSoibv2Q
hwt83uhn6E0RUZYL8hCNGuTTDrI7Se+dP+1lEVFmZJ0REdwkJjgFelhBHMHv+epD
hp3cXM4XxTcW5y3crZDgJ6fVInuDu/AF4AxiolbkJXk9LqSWxZs=
=h7au
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--
