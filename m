Received: from eggs.gnu.org ([2001:4830:134:3::10]:51353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimh4-0002jp-3m
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimh1-0000yo-0V
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:44:46 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:38001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimh0-0000yV-Q3
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:44:42 -0500
Received: by mail-qk0-x241.google.com with SMTP id w128so11740346qkb.5
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:44:42 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
	<20180203103727.26457-5-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d87b3731-f630-53e2-4f97-d10bb73cc969@amsat.org>
Date: Mon, 5 Feb 2018 16:44:38 -0300
MIME-Version: 1.0
In-Reply-To: <20180203103727.26457-5-mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="gGhtERG2zSqOATTzEWFG3SocWewuwQ1lR"
Subject: Re: [Qemu-devel] [PATCH 04/10] cuda: introduce CUDAState parameter
 to get_counter()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, lvivier@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gGhtERG2zSqOATTzEWFG3SocWewuwQ1lR
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 lvivier@redhat.com
Message-ID: <d87b3731-f630-53e2-4f97-d10bb73cc969@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 04/10] cuda: introduce CUDAState parameter to
 get_counter()
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
 <20180203103727.26457-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180203103727.26457-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2018 07:37 AM, Mark Cave-Ayland wrote:
> This will be required shortly and also happens to match nicely with the=

> corresponding signature for set_counter().
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  hw/misc/macio/cuda.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index ba14dbeacd..f036e8d7e1 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -150,7 +150,7 @@ static uint64_t get_tb(uint64_t time, uint64_t freq=
)
>      return muldiv64(time, freq, NANOSECONDS_PER_SECOND);
>  }
> =20
> -static unsigned int get_counter(CUDATimer *ti)
> +static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
>  {
>      int64_t d;
>      unsigned int counter;
> @@ -295,12 +295,12 @@ static uint64_t cuda_read(void *opaque, hwaddr ad=
dr, unsigned size)
>          val =3D s->dira;
>          break;
>      case CUDA_REG_T1CL:
> -        val =3D get_counter(&s->timers[0]) & 0xff;
> +        val =3D get_counter(s, &s->timers[0]) & 0xff;
>          s->ifr &=3D ~T1_INT;
>          cuda_update_irq(s);
>          break;
>      case CUDA_REG_T1CH:
> -        val =3D get_counter(&s->timers[0]) >> 8;
> +        val =3D get_counter(s, &s->timers[0]) >> 8;
>          cuda_update_irq(s);
>          break;
>      case CUDA_REG_T1LL:
> @@ -311,12 +311,12 @@ static uint64_t cuda_read(void *opaque, hwaddr ad=
dr, unsigned size)
>          val =3D (s->timers[0].latch >> 8) & 0xff;
>          break;
>      case CUDA_REG_T2CL:
> -        val =3D get_counter(&s->timers[1]) & 0xff;
> +        val =3D get_counter(s, &s->timers[1]) & 0xff;
>          s->ifr &=3D ~T2_INT;
>          cuda_update_irq(s);
>          break;
>      case CUDA_REG_T2CH:
> -        val =3D get_counter(&s->timers[1]) >> 8;
> +        val =3D get_counter(s, &s->timers[1]) >> 8;
>          break;
>      case CUDA_REG_SR:
>          val =3D s->sr;
>=20


--gGhtERG2zSqOATTzEWFG3SocWewuwQ1lR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp4tCYACgkQ4+MsLN6t
wN5bBhAApQaeFNJDauvX4z1UQvznxvr9/xjP6RwNHXydzsBLTeSbjhv1Vd8Un3xQ
uNTbVYc76787hIyABIVkfLZfRSfelHA60B70BPG8lXYRHgmRFwSf56qZ4k22xqje
03NoZxfZz8FuGww/dPKBf1qJ9uPG7qgR21RpqGKt10Rc/zjDftE/IBmWELzSZIj9
8QPVfIBnwi8TVT3Qmoe7waFNEOsGygjIKrCXu0Ip9xWmMTwHnsHZ1kTPZQKF0onU
HfZDbvB6heKoPfjhcXTlpKVSpkYZt3P3Ek+7RthVGZNvt37rjgfdj6bgnmhgkzFM
elMwBYM/z9/x6wDffWBwNzp+5BGuFM455Cmw/kV+D5ECvBrHLAW/d3EaKzSwe8c/
LinOHbVNUcTGMidvDaX89d4Tirc1qz/rV0ckMFuX5Mqz0T6qfF4gdzI4S41Cmi6X
v+qLaDBbMl3UZ/yUcUcUaa1JS8SSncre46ZZRBSzQZszuyFTz6bFIUe985jtqEmr
QhIKhAJW0QYRmjK1MoYob3IEkEA4lFOd9+FsW0zAARSLd8iEEnlx4pegg0BGzG36
s33tazoGEHJ8janJg6q+YRmJFw5VI9Wu4yWqLN+znFWoKY/rCVU5WjbsdTz5qUTh
MsEk6qC2v2SybyP1yuUAA0uqTF8EQNkO+LoJ+Qa/CRLJ/1hzRMY=
=krlY
-----END PGP SIGNATURE-----

--gGhtERG2zSqOATTzEWFG3SocWewuwQ1lR--
