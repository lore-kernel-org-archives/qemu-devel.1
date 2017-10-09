Received: from eggs.gnu.org ([2001:4830:134:3::10]:49155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e1MEn-000822-FM
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 20:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e1MEm-0000Bv-Kx
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 20:48:05 -0400
Message-ID: <1507510072.5452.151.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 09 Oct 2017 11:17:52 +1030
In-Reply-To: <20170920070135.31379-7-clg@kaod.org>
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-7-clg@kaod.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-eTx3SJYtBYAbjZOoBSKH"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 6/6] aspeed: add the pc9552 chips to the
 witherspoon machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--=-eTx3SJYtBYAbjZOoBSKH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-09-20 at 09:01 +0200, C=C3=A9dric Le Goater wrote:
> The pca9552 LED blinkers on the Witherspoon machine are used for leds
> but also as GPIOs to control fans and GPUs.
>=C2=A0
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
> =C2=A0hw/arm/aspeed.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=C2=A0
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 462f8008cff5..2ae46d71bff7 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -379,6 +379,8 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState=
 *bmc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AspeedSoCState *soc =3D &bmc->soc;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint8_t *eeprom_buf =3D g_malloc0(8 * 1024)=
;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc-=
>i2c), 3), "pca9552", 0x60);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(=
&soc->i2c), 4), "tmp423", 0x4c);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(=
&soc->i2c), 5), "tmp423", 0x4c);
> =C2=A0
> @@ -390,6 +392,8 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState=
 *bmc)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0smbus_eeprom_init_one(aspeed_i2c_get_bus(DE=
VICE(&soc->i2c), 11), 0x51,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0eeprom_buf);
> +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc-=
>i2c), 11), "pca9552",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x60);
> =C2=A0}
> =C2=A0
> =C2=A0static void witherspoon_bmc_init(MachineState *machine)
--=-eTx3SJYtBYAbjZOoBSKH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZ2sc4AAoJEJ0dnzgO5LT5c8IP/R6u1SPk7my/NtGhKOIU2I8m
nekuOKl7re2jVERZ/oFDW/mEwuXglT5nGyP0PDoBpWfp2McUob81a5U9BgBaY+Uj
agr8o4EjRukMHjeFkAl0bOxFppsBULBRF8IVkusSCEw3wQGylbB6in3d/3vyAeRp
20Is8dXf/FcGHQ5SzyzUT/EP+gWZqmt54JUj54LxjCj7o8LLvEowrGnLiVu3LisY
0cILXAGW0DtKj4576BE6pxOExDqRsPd2Ht40PdvK6VpxjVEMZ3IV8mntYtGJ0FHV
ieDLuWPbLlE70D1drjZ9jvdSN7c2xQIYydkLBEcCzEF0V+fhEdTXzhy8Y8bc4IZS
FlUlo1EEqZr8gqMUGoDqYExC4Pg+ad6DdVXECAQOo8NYVQxezMi/mclLMkOdX0ZB
P+PtNPvXLSolOUQRjVOOI6UIPcLVZx4kswmOcbmbNhXfxwVuZtJYL877jLjkTT3b
IVbo9t9k8RwucPSqXJE5ZYtR0EIqtN7ZSK5sajAyPnlwGg1HHKntK5vt85D5iNsh
VvJkSBKx4PZhMgG/eSs+upj8oIFQEelUj7/2+qKGcEP/7TJHQi5PQr1EkuF0XQXs
xIOM38cX3MhrcaQvF50JaeyK4WWkAJfKdi1YJK2r8zknR2DUqqFo1deDRqEcZxld
+1pX3Nwvgz95J8yff2EL
=7R2O
-----END PGP SIGNATURE-----

--=-eTx3SJYtBYAbjZOoBSKH--
