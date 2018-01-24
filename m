Received: from eggs.gnu.org ([2001:4830:134:3::10]:47732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeLna-0003iB-22
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:13:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeLnU-0006g4-45
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:13:10 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:37840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeLnT-0006fc-V2
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:13:04 -0500
Received: by mail-qt0-x242.google.com with SMTP id d54so10603481qtd.4
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 06:13:03 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f4b4e663-8dc7-e687-1b50-13aead2b18b4@amsat.org>
Date: Wed, 24 Jan 2018 11:12:58 -0300
MIME-Version: 1.0
In-Reply-To: <20180124131315.30567-8-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="f3wrEheuSL2AG2y4umv6igFtAJ3Q3EDpF"
Subject: Re: [Qemu-devel] [PATCH v3 07/22] include/fpu/softfloat: implement
 float16_set_sign helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f3wrEheuSL2AG2y4umv6igFtAJ3Q3EDpF
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <f4b4e663-8dc7-e687-1b50-13aead2b18b4@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v3 07/22] include/fpu/softfloat: implement
 float16_set_sign helper
References: <20180124131315.30567-1-alex.bennee@linaro.org>
 <20180124131315.30567-8-alex.bennee@linaro.org>
In-Reply-To: <20180124131315.30567-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/24/2018 10:13 AM, Alex Benn=C3=A9e wrote:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  include/fpu/softfloat.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index f75aa59100..59c06ef192 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -281,6 +281,11 @@ static inline float16 float16_chs(float16 a)
>      return make_float16(float16_val(a) ^ 0x8000);
>  }
> =20
> +static inline float16 float16_set_sign(float16 a, int sign)
> +{
> +    return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
> +}
> +
>  /*--------------------------------------------------------------------=
--------
>  | The pattern for a default generated half-precision NaN.
>  *---------------------------------------------------------------------=
-------*/
>=20


--f3wrEheuSL2AG2y4umv6igFtAJ3Q3EDpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpolGoACgkQ4+MsLN6t
wN4utRAAgUPCk/Gz/I8OLZ7wvkHEp+OItZFdmnuEDrmMQRTK2cAOYKWn+/I/qFx/
4nfsFGJsxQluHKwG3brxsIGSj2tlmsit4H06fOK4IEycxfhaenvePdfjuexyVgt6
tX679SgSavZFdDAQ16ZAoyRUdq+bigMnpSeSAt79qn/pvEhNZBUlcgS8cI9v1PjQ
3a87p7rU8JUrYzRJ0mby8b5s5friOKjUqsU+CUety2HqgI0dXTZed72rSwm8fL7/
QdqaAX5NCi3ksW0XJM08wx0mRajUvFKZ+Cd0Ud98z3yauJ1pSB+Cjg70J0y9A4Fj
Dl8YuO5C3xAyaHKp2XImmwwF3WwcxVa2n/sojkLEJ+TyBb+tT22ZzhUbhRJvgkz6
+qUgdPvadbdkiDn2B5AaiN4Pxe8msWN1RRsSVNrYqlUSrcQvRtLRSP/O3Q4vd0PM
2HBmvrdo5rJK2TqREmdA+PWd8+q0CM2Dc6j0KRGi8nehmHf/rZKvSbBQzbr3wIP6
26D5zPaILcErLUEOuh0u7nIb4LtwlMITjd6VvWWNlxe4ec7yR8OhhjFaxEPAz6Rd
psYvazxHyYJSPuzQkqReRnc3+Rvg4a8IqFsBw4+LcifIN+SEeBDzoIbnyziBiqnh
tCRAZiNgDP7PY+r/BMTcKWYSBhUxzf94fnryPnrPrhYOUdx3YVc=
=ItNF
-----END PGP SIGNATURE-----

--f3wrEheuSL2AG2y4umv6igFtAJ3Q3EDpF--
