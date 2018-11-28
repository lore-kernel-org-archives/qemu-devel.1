Received: from eggs.gnu.org ([2001:4830:134:3::10]:58528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gS9v3-0004sl-49
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 19:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gS9v1-0005M3-D0
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 19:11:00 -0500
Date: Thu, 29 Nov 2018 09:59:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181128225941.GH2251@umbus.fritz.box>
References: <20181128195802.B6A6C7456B9@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9gXqgVhKaPB5h51M"
Content-Disposition: inline
In-Reply-To: <20181128195802.B6A6C7456B9@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] i2c: Move typedef of bitbang_i2c_interface
 to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>


--9gXqgVhKaPB5h51M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 08:27:06PM +0100, BALATON Zoltan wrote:
> Clang 3.4 considers duplicate typedef in ppc4xx_i2c.h and
> bitbang_i2c.h an error even if they are identical. Move it to a common
> place to allow building with this clang version.
>=20
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i2c/bitbang_i2c.h        | 2 --
>  include/hw/i2c/i2c.h        | 2 ++
>  include/hw/i2c/ppc4xx_i2c.h | 3 ---
>  3 files changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/i2c/bitbang_i2c.h b/hw/i2c/bitbang_i2c.h
> index 3a7126d5de..9443021710 100644
> --- a/hw/i2c/bitbang_i2c.h
> +++ b/hw/i2c/bitbang_i2c.h
> @@ -3,8 +3,6 @@
> =20
>  #include "hw/i2c/i2c.h"
> =20
> -typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> -
>  #define BITBANG_I2C_SDA 0
>  #define BITBANG_I2C_SCL 1
> =20
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 5dc166158b..cf4c45a98f 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -82,6 +82,8 @@ int i2c_recv(I2CBus *bus);
> =20
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r);
> =20
> +typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> +
>  /* lm832x.c */
>  void lm832x_key_event(DeviceState *dev, int key, int state);
> =20
> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
> index 0891a9c948..b3450bacf7 100644
> --- a/include/hw/i2c/ppc4xx_i2c.h
> +++ b/include/hw/i2c/ppc4xx_i2c.h
> @@ -31,9 +31,6 @@
>  #include "hw/sysbus.h"
>  #include "hw/i2c/i2c.h"
> =20
> -/* from hw/i2c/bitbang_i2c.h */
> -typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> -
>  #define TYPE_PPC4xx_I2C "ppc4xx-i2c"
>  #define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_=
I2C)
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9gXqgVhKaPB5h51M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv/Hd0ACgkQbDjKyiDZ
s5KlSA/+NHUfZ8I4kU4anN7+DE+G0YXYfW0XoHyn/tq+NACr0wG9a87k7nS/pN+F
gAlrX7g7iMgbW9q06rSlEZiJP/yR/19ShSRc1Ymi5bNIXfVMsPKIWBy/oh1YmxQK
N4MHOZjiKpl3aD0BPRW6myM9bWyIjNF7j6E25vY/J6OEBmZM8gc01qMtL3C1BUA4
VwpVepjwwd+Qf15cjUueozM3uyCsXi149tv4hgVXp5vHcbe6/u+smWFQKuJFNMx+
rGXu1gFFVLlufiO7/pICyFHkWikOVt4RlrUM63cGcRfwl3vGK8ydaazz9FfVewaQ
9W7j0U/RJoUsLgrTrBLzmZjK6XsgBrUSCbkGkYzreMVNfNN3TnT2aNEwQvuFILIZ
xaqSFkBFPnLzSYTmDbjXKolW19FHDpo0vXnL/DY8iRrlb1x0D6d9P2+BwBlF7x/M
7kl4IbVmG+S6TNL6CUw8xOG9TDW1tJAsFhMxLHamVmP/3ozj+4kipWIUqnSUj+nJ
GQ3ld+maXxjMQnhsKO/U4TFYeooxX277ql9iCPmiIXfeRwQRxJGfQNTC49bk0fX4
t+PU7DkHCQ/z6cbLESKyBa5KdNHuHljv8bDvz391cAAPH4pxuGKz1XvMF9VwoU8O
8eSn5rfqvciTirySRgQRb49Ub4b94jMsvcGH64GbGpBJ/hINXCQ=
=sLA6
-----END PGP SIGNATURE-----

--9gXqgVhKaPB5h51M--
