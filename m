Received: from eggs.gnu.org ([2001:4830:134:3::10]:48980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimc0-00067f-Is
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimbx-0004Zq-Ev
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:39:32 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:39433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimbx-0004Zc-8h
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:39:29 -0500
Received: by mail-qk0-x242.google.com with SMTP id d72so3933593qkc.6
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:39:29 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
	<20180203103727.26457-7-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5c44b1ee-8d6a-094f-6bf6-bad23fdfda91@amsat.org>
Date: Mon, 5 Feb 2018 16:39:23 -0300
MIME-Version: 1.0
In-Reply-To: <20180203103727.26457-7-mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="ZtLDYxYwZT5rAzX0dxobVvtL5gZEjwKZQ"
Subject: Re: [Qemu-devel] [PATCH 06/10] cuda: minor cosmetic tidy-ups to
 get_next_irq_time()
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
--ZtLDYxYwZT5rAzX0dxobVvtL5gZEjwKZQ
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 lvivier@redhat.com
Message-ID: <5c44b1ee-8d6a-094f-6bf6-bad23fdfda91@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 06/10] cuda: minor cosmetic tidy-ups to
 get_next_irq_time()
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
 <20180203103727.26457-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180203103727.26457-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2018 07:37 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  hw/misc/macio/cuda.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index a200320e7d..3336ed46b2 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -184,36 +184,37 @@ static void set_counter(CUDAState *s, CUDATimer *=
ti, unsigned int val)
>      cuda_timer_update(s, ti, ti->load_time);
>  }
> =20
> -static int64_t get_next_irq_time(CUDATimer *s, int64_t current_time)
> +static int64_t get_next_irq_time(CUDATimer *ti, int64_t current_time)
>  {
>      int64_t d, next_time;
>      unsigned int counter;
> =20
>      /* current counter value */
> -    d =3D muldiv64(current_time - s->load_time,
> +    d =3D muldiv64(current_time - ti->load_time,
>                   CUDA_TIMER_FREQ, NANOSECONDS_PER_SECOND);
>      /* the timer goes down from latch to -1 (period of latch + 2) */
> -    if (d <=3D (s->counter_value + 1)) {
> -        counter =3D (s->counter_value - d) & 0xffff;
> +    if (d <=3D (ti->counter_value + 1)) {
> +        counter =3D (ti->counter_value - d) & 0xffff;
>      } else {
> -        counter =3D (d - (s->counter_value + 1)) % (s->latch + 2);
> -        counter =3D (s->latch - counter) & 0xffff;
> +        counter =3D (d - (ti->counter_value + 1)) % (ti->latch + 2);
> +        counter =3D (ti->latch - counter) & 0xffff;
>      }
> =20
>      /* Note: we consider the irq is raised on 0 */
>      if (counter =3D=3D 0xffff) {
> -        next_time =3D d + s->latch + 1;
> +        next_time =3D d + ti->latch + 1;
>      } else if (counter =3D=3D 0) {
> -        next_time =3D d + s->latch + 2;
> +        next_time =3D d + ti->latch + 2;
>      } else {
>          next_time =3D d + counter;
>      }
>      CUDA_DPRINTF("latch=3D%d counter=3D%" PRId64 " delta_next=3D%" PRI=
d64 "\n",
> -                 s->latch, d, next_time - d);
> +                 ti->latch, d, next_time - d);
>      next_time =3D muldiv64(next_time, NANOSECONDS_PER_SECOND, CUDA_TIM=
ER_FREQ) +
> -        s->load_time;
> -    if (next_time <=3D current_time)
> +                         ti->load_time;
> +    if (next_time <=3D current_time) {
>          next_time =3D current_time + 1;
> +    }
>      return next_time;
>  }
> =20
>=20


--ZtLDYxYwZT5rAzX0dxobVvtL5gZEjwKZQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp4susACgkQ4+MsLN6t
wN4uNxAAwAMF7Tm05/3TUyYeSaOZW4Qk6kouDp7fZotlHtExuB+4lnLvvmd0y9cD
aoTi2JvPdopC77drdYtGTUC5p3pWlo/gpHDzW1gIGq2sSvBixxs6d1m7XOMw1oBu
I0Z4k4uI9mVvnRcaTOQBpMOT1oIL7v/GojDQKKxGlKsrY76dJRG6dkAulngQwPrQ
G6OY7h77ZBsc1griVIKK/H0dDqfMFBuxbR3k0/fbD5fLA1Wz7pdZz25a827NDGUv
0MWU34HjzgfCzuZivxL9mpTPxzU5sP2TnDwwIQM37jd2SwtkZPzuck4U4lIr0VSj
oy8KXBp47IHR3bmzfrqDqKCzd2WJcyzfqYMAW21cBDnSPrUMyJawEoi/qwnzstLp
luiSPdm1TS51dOnoGenCJA8vPY/ZsoDIBuTCwqrbehpTDzeJOmql/i1O1HmW/RGd
VaXL6s0ABe6+73xD3apLCl0dHV3oBow3CoDFEk1ZeiGqJ0IW4cDDBl9X4xD3eJcy
Us6HxeWQS59ypZBQ/fYoA48lq/+hPoqMW2jyXxEqHXxsdGgjPm90KLiZJvtqg/iR
8+PxKN0nZASp+cfyCSlqmRJA8xnG0xL0V6v9bGwhFoT205WgZWHpNxQw8z7BdXT/
OD0Q6g/nWlIDXYVEaWy2oqCXcL5f3mNXcr8BIgs8ptEtWfSU+Zw=
=fzS1
-----END PGP SIGNATURE-----

--ZtLDYxYwZT5rAzX0dxobVvtL5gZEjwKZQ--
