Received: from eggs.gnu.org ([2001:4830:134:3::10]:55161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOK7c-0001CB-7l
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOK7X-0007FC-BZ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:43:52 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:32918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOK7X-0007EK-45
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:43:47 -0400
Received: by mail-wm0-x229.google.com with SMTP id z6-v6so1046553wma.0
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 02:43:46 -0700 (PDT)
Date: Thu, 31 May 2018 10:43:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180531094344.GI26429@stefanha-x1.localdomain>
References: <20180529220338.10879-1-jusual@mail.ru>
	<20180529220338.10879-4-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o7gdRJTuwFmWapyH"
Content-Disposition: inline
In-Reply-To: <20180529220338.10879-4-jusual@mail.ru>
Subject: Re: [Qemu-devel] [RFC 3/3] tests/boot-serial-test: Add support for
 the microbit board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>


--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 01:03:38AM +0300, Julia Suvorova wrote:
> New mini-kernel test for nRF51 SoC UART.
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  tests/boot-serial-test.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 4d6815c3e0..e6dbc8a293 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -62,6 +62,16 @@ static const uint8_t kernel_aarch64[] =3D {
>      0xfd, 0xff, 0xff, 0x17,                 /* b       -12 (loop) */
>  };
> =20
> +static const uint8_t kernel_nrf51[] =3D {
> +    0x00, 0x00, 0x00, 0x00,                 /* Stack top address */
> +    0x09, 0x00, 0x00, 0x00,                 /* Reset handler address */
> +    0x01, 0x4b,                             /* ldr   r3,[pc,#4]    Get b=
ase */
> +    0x54, 0x22,                             /* mov   r2,#'T' */
> +    0x1a, 0x70,                             /* strb  r2,[r3] */
> +    0x01, 0xe0,                             /* b     loop */
> +    0x1c, 0x25, 0x00, 0x40,                 /* 0x40002000 =3D UART0 base=
 addr */
> +};

Good for now, will need STARTTX in the future.

Stefan

--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD8PQAAoJEJykq7OBq3PIUmIH/jPM/vVCgmC1+Pta4ABbHks+
qyCqXJbGhryOmMGjrsnDBfdMjoPIV5wVccJCM9lwzpSYPab2N9cXDva0Sp6Sbu4p
ovN8hFxL6zalMGS/qxBtKFRviowk29vxt4MmAjW8pj7ikSHluVXYoMVsF/AOlM/l
uVvNrAGfYkYo47AqvFtYdla+Rm3JdVk5jk73dhWuiQpyeJAyVEE9YCfvYavLwkqg
8c3ADBHVSGC5kRWyehR/mKz8xqql+Ldmp3QVl9U+V/Qzl5eHbiCl9HK4bmdJNcPB
WDPcS4snxlkX8nJFwalshrLvQ5nZyYJanFZYnJPoQ6L9KJl3vbg5mbH7o6nlJA4=
=a8kb
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--
