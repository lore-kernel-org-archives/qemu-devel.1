Received: from eggs.gnu.org ([2001:4830:134:3::10]:44742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePqBN-0003Ab-Ly
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePqBK-0002ni-Hq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:37:45 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:41415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePqBK-0002me-B0
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:37:42 -0500
Received: by mail-qk0-x244.google.com with SMTP id r184so2664640qke.8
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 05:37:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8b36b09f-eb89-46bf-561b-2536cc93c489@amsat.org>
Date: Fri, 15 Dec 2017 10:37:33 -0300
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-6-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="LSmlbITroLX29esaaf2dxNAmu6oCpqNoa"
Subject: Re: [Qemu-devel] [PATCH v1 05/19] include/fpu/softfloat: add some
 float16 contants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LSmlbITroLX29esaaf2dxNAmu6oCpqNoa
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com,
 aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <8b36b09f-eb89-46bf-561b-2536cc93c489@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v1 05/19] include/fpu/softfloat: add some
 float16 contants
References: <20171211125705.16120-1-alex.bennee@linaro.org>
 <20171211125705.16120-6-alex.bennee@linaro.org>
In-Reply-To: <20171211125705.16120-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On 12/11/2017 09:56 AM, Alex Benn=C3=A9e wrote:
> This defines the same set of common constants for float 16 as defined
> for 32 and 64 bit floats. These are often used by target helper
> functions.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  include/fpu/softfloat.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 17dfe60dbd..5a9258c57c 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -395,6 +395,13 @@ static inline float16 float16_set_sign(float16 a, =
int sign)
>      return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
>  }
> =20
> +#define float16_zero make_float16(0)

ok

> +#define float16_one make_float16(0x3a00)

I'm a bit confused...

>>> [np.fromstring(struct.pack("<H", x), dtype=3Dnp.float16)[0] for x in
[0, 0x3a00, 0x34d1, 0x4448, 0x3800, 0x7a00]]
[0.0, 0.75, 0.30103, 4.2812, 0.5, 49152.0]

However:

>>> ['0x' + binascii.hexlify(np.array([x], '>f2').tostring()) for x in
[0, 1, math.log(2), np.pi, 0.5, np.inf]]
['0x0000', '0x3c00', '0x398c', '0x4248', '0x3800', '0x7c00']

It seems the MSB bit of the mantissa got shifted as the LSB of the
biased exponent...

> +#define float16_ln2 make_float16(0x34d1)

incorrect? 0x398c

> +#define float16_pi make_float16(0x4448)

incorrect? 0x4248

> +#define float16_half make_float16(0x3800)

ok

> +#define float16_infinity make_float16(0x7a00)

incorrect? 0x7c00

> +
>  /*--------------------------------------------------------------------=
--------
>  | The pattern for a default generated half-precision NaN.
>  *---------------------------------------------------------------------=
-------*/
>=20


--LSmlbITroLX29esaaf2dxNAmu6oCpqNoa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAloz0B0ACgkQ4+MsLN6t
wN71Xg//ahAZmBx18jbSP8xWXjsgUS9PA/q9hfHwBaPXr/VXdlmWS7EjiTlj8f6y
C81y+GTcbXXVJZVPRMvhDpnr6lM1Ffw5f3AWxeh7BlvWMnJrpQKaSSlzL+mi9SJV
ngPvMDkQfWpRDWBB0MwvoOjJfo2m1/5muDzk7kTDTJYgp68lsy8hZ96/crJPUDjI
ePLaPnOvmVrXRAsatfMeRN+URgh7bNC37MmdlGmFmbWep5NNgy7XkthaCUxDrCCL
4/SOOuHGwGYMHaN+MKDiHA48j0g+gL4oe8YH0V6nbktk1HmfQ90l5Gx9FCnto5Kh
eYRPCEEoPwWxdEUYseJJCGJ8C4dH7+oH+2ur9npJ6SMFKOthFWs4Z1TovwznGYtf
ePd91arI1w/pLe3zahq/JWjUlkLFFKe3gQ46+9plaUTFihShkB1USTYhKlulB2dW
ewMTgQcgDhLM3LTBrOVN/ySj50WTz+Gx3JUONEsr2bFA0eld9tfQpCdv7G8lRmkB
FZVkufEH7sG/96DL6A3noNlud5mjxQRSOqddQhKgVqo70uDs4p8NhDFR6fGdnEHI
g4wP1H1YFOXvknh1QnDF6NAWysxCG+Ank+2swzUAU7tatbWARGso/2toFNP2rNW6
ZUQ5Gr2scwokjR4K1JITWz+Iy65jUsPg26s03plIBQ8miMbL+gc=
=660x
-----END PGP SIGNATURE-----

--LSmlbITroLX29esaaf2dxNAmu6oCpqNoa--
