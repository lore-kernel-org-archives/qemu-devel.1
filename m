Received: from eggs.gnu.org ([2001:4830:134:3::10]:42756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSWRJ-0000DM-MF
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:13:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSWPm-00007s-U6
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:12:15 -0500
Date: Fri, 30 Nov 2018 11:05:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181130000524.GC30479@umbus.fritz.box>
References: <20181128195802.B6A6C7456B9@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
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


--NKoe5XOeduwbEQHU
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

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwAfsQACgkQbDjKyiDZ
s5IAbA/7BSzKjrO7WBIfBhz/E/WUZrMZpGRpCOn/uT8eqODTYYHa9tcdSf71afHm
IeBezCxDw8qUlY08oEAb5ewc1Iv4pE8u32PFE0IAA1hH8KBkKIwqxmxlIBAzhd8w
OoZKyIu0+ChgJ8JChG2eWteGpFb0Nu1KQ1Wb0MaSz0yGsxko3qjtyCUSQ+jEwxsO
S5yiXnANSRsgEqvQVJRAPT4LvqqYLM0gpiuFulZvJRs1+q38z7WfIn70E6eKd7Rd
ptjb5lsNyzHMg0OG2JTJOHjhMx/Bbb57h80eizivz8RyCUqyK+uZKibLx1sqIzzU
rHuySiLakHeytrY3+7aZN2KV9KHIqqkmLMHkEjqkhy5Zk50oV5pzK701uiQgDXfo
sLuZjg+2oMSBwZssGDEyoAu15h06ws2W4b9AINS4JUmr9xa5qs2DBrVA+ZaPrleD
KKKaJPwog7z/48ZEM6EduyfXQnhzQV46F/eMiiBwm4Gx2RkGNjSZ/bv3lLLIXzeZ
zGsqMko6WZlBQDi3mbVwOrayUXtmamypz8pajwVNVImfg4kEAZ7ahNnVMZOXSGVd
PJQm9DmXPgPJ6i8ZfB2Cb4XpaRNzfrf1bIvcZBLeiIcg7e4Q07vZg4eUTwS60jq5
YMkYH6LQjfEyILWud3T2EkJh6OiTsrXsgZ+9bCTGpQU1c4i0gYg=
=v4Zd
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
