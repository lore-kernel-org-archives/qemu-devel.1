Received: from eggs.gnu.org ([2001:4830:134:3::10]:35914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqopE-0000jq-Oo
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqopD-0002CT-Sk
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:38:24 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180227104903.21353-1-linus.walleij@linaro.org>
	<20180227104903.21353-4-linus.walleij@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <37d1e8d7-1d73-b635-269a-fd154426cdeb@amsat.org>
Date: Tue, 27 Feb 2018 20:38:18 -0300
MIME-Version: 1.0
In-Reply-To: <20180227104903.21353-4-linus.walleij@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="fXsmhgVwVcLef5cnEExs5SFYtBLUEllUV"
Subject: Re: [Qemu-devel] [PATCH 3/5] hw/i2c-ddc: Do not fail writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Corey Minyard <cminyard@mvista.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fXsmhgVwVcLef5cnEExs5SFYtBLUEllUV
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Linus Walleij <linus.walleij@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Corey Minyard <cminyard@mvista.com>
Message-ID: <37d1e8d7-1d73-b635-269a-fd154426cdeb@amsat.org>
Subject: Re: [PATCH 3/5] hw/i2c-ddc: Do not fail writes
References: <20180227104903.21353-1-linus.walleij@linaro.org>
 <20180227104903.21353-4-linus.walleij@linaro.org>
In-Reply-To: <20180227104903.21353-4-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2018 07:49 AM, Linus Walleij wrote:
> The tx function of the DDC I2C slave emulation was returning 1
> on all writes resulting in NACK in the I2C bus. Changing it to
> 0 makes the DDC I2C work fine with bit-banged I2C such as the
> versatile I2C.
>=20
> I guess it was not affecting whatever I2C controller this was
> used with until now, but with the Versatile I2C it surely
> does not work.
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  hw/i2c/i2c-ddc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i2c/i2c-ddc.c b/hw/i2c/i2c-ddc.c
> index 199dac9e41c1..bec0c91e2dd0 100644
> --- a/hw/i2c/i2c-ddc.c
> +++ b/hw/i2c/i2c-ddc.c
> @@ -259,12 +259,12 @@ static int i2c_ddc_tx(I2CSlave *i2c, uint8_t data=
)
>          s->reg =3D data;
>          s->firstbyte =3D false;
>          DPRINTF("[EDID] Written new pointer: %u\n", data);
> -        return 1;
> +        return 0;
>      }
> =20
>      /* Ignore all writes */
>      s->reg++;
> -    return 1;
> +    return 0;
>  }
> =20
>  static void i2c_ddc_init(Object *obj)
>=20


--fXsmhgVwVcLef5cnEExs5SFYtBLUEllUV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlqV6+oACgkQ4+MsLN6t
wN5Y8w/8CGKWeG2YXKnSvJbxGmqvFhXUo8x+C1+rc7ejjElT56bN3AtjAOvCDSPC
WMeUZ6J2OyHLDHHkxzmk41tm8T2h9quO8aDbaUzFVf8ThnKP07eEbO6eDiplP5Pa
5XBvp/WEpXwwsPNXOI+Rdwigqr6ZKFA7Wn58enCtRUqbuSlSjHF9GmYFDRJsQkgH
obsumgKoxjc/tcUe4EBvq+n2oDLBBSAstFtJ3quZP25zOR/zK1LDoMbgPfQwZn/l
gjX+AluOanQdx6H6CZ7tgxVzS92VeuL0IT+5QZIqQI195JWFwnddtO/HvntIAAzd
aaOo38oTUmj1qy/6j/acPUUJPaTouxjmwGisouBEu0l8kkEDjbdj+MSleEcAOr85
A14Kv4byumMmg1tSNXMuQ42WZOGM4ZFlLh88tO8tsqql2UalmBzlQbdLQ1/Ocd2d
je8AZVwgC5aneHK7RCugZOM/v1uqB+GuE/Xbm1VEXgJ5jFJZPtKXtjG9heIvNTp1
RaQUSlgVvW0SUoe+cKyqXk+nosc2gOhQ4HpeLqWJKSaosTit9tlZeyDYQ0AZsH9e
6fR3nzXG9PWpNGjEquz3RicQJfaZXnPtPUaMF646j/MyFJiPvm8e5WuCFwH9bS8Q
5qJdt+3PJqMFoDhgDQyOlo8wPgrLDmwK8FEfwGMl1IEBdoze1hU=
=jHaS
-----END PGP SIGNATURE-----

--fXsmhgVwVcLef5cnEExs5SFYtBLUEllUV--
