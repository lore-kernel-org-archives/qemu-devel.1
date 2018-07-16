Received: from eggs.gnu.org ([2001:4830:134:3::10]:49813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fesB7-0003VS-BN
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 21:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fesB3-0003wE-5w
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 21:19:53 -0400
Received: from ozlabs.org ([203.11.71.1]:40611)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fesB2-0003ss-CB
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 21:19:49 -0400
Date: Mon, 16 Jul 2018 11:19:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180716011932.GE2599@umbus.fritz.box>
References: <20180715211731.311B67456B5@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline
In-Reply-To: <20180715211731.311B67456B5@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH for 3.0] sm501: Fix warning about
 unreachable code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 15, 2018 at 10:59:21PM +0200, BALATON Zoltan wrote:
> Coverity warned that the false arm of conditional expression is
> unreachable when it is inside an if with the same condition.
> Remove the unreachable code to avoid the warning.
>=20
> Fixes: CID 1394215
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/display/sm501.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 9ab29d3..874260a 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1024,7 +1024,7 @@ static void sm501_i2c_write(void *opaque, hwaddr ad=
dr, uint64_t value,
>                          if (res) {
>                              SM501_DPRINTF("sm501 i2c : transfer failed"
>                                            " i=3D%d, res=3D%d\n", i, res);
> -                            s->i2c_status |=3D (res ? SM501_I2C_STATUS_E=
RROR : 0);
> +                            s->i2c_status |=3D SM501_I2C_STATUS_ERROR;
>                              return;
>                          }
>                      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltL8qQACgkQbDjKyiDZ
s5LdtxAAstbGger1EilJFnE6oRsgXjmi8Y9kL0ZMtJdmsq0MaNikkfLPNMF67hl0
49mQO2jVFja7RAM+blWP3TDJYdgPbQWRQmFZp6x2MIVJnh0g+1oXx99cCQbQJmqj
PP4t1qOVcLZQAK69ZbatQ6EDONpFfoBzjNLIyv5sppHC8BaxWqhYTdZ34dWQmzF+
6soFFo9HMiK23ypDe3GKTWN3m21vKurZSij8y9XVYm3iz4OyMXse10jgsz7vRzEC
SVfQdNNKJGFm8Lp4VLRaVbxVktw5ao8v7YZDcZRe4pcHxKxWMHcVxBBQrFL0ejkL
rNBRo/D9A7pphrCciAzr/S+zpiOiL18yBq2TXSYKyEceQRFyiJBmD2+hDH9iqWkP
bYHncHtYHrde3a1tUs6G+NUjkyNGiyZEei7/mOKB6qrS1dAESb15J4F27aI9KR8U
Fg8ATEX9eSly0lZUZI6qHjA27yGjGCNOQ26s2K7xBOr3SbQadL+/hgOnaAdtfSs+
mqqyOI13gLAmzH5GJkpKakKb11kCb5xlDNdEsGzilbUKwUj+JsbTFELwgDCWn6OS
E+NAV2Iv9mVYeuNYV6He6nW4EF9ZgdnzBtA4fTfKKE/QiUSYgf3qZnEiqcf0UawB
b3aEslX6AQvuWEJHrbjDWYQ8ML5xEfdG2x4lyvcqxMlywYIMFdE=
=u/TI
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
