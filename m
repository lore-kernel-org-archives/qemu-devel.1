Received: from eggs.gnu.org ([2001:4830:134:3::10]:45496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeX7-0000jm-IE
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeX3-00016S-JI
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:13 -0500
Date: Sun, 11 Feb 2018 09:31:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210223113.GR11634@umbus.fritz.box>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-5-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DzFMwNuU1QL7hgxO"
Content-Disposition: inline
In-Reply-To: <20180209185142.17151-5-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2 04/12] cuda: introduce CUDAState
 parameter to get_counter()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com


--DzFMwNuU1QL7hgxO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:51:34PM +0000, Mark Cave-Ayland wrote:
> This will be required shortly and also happens to match nicely with the
> corresponding signature for set_counter().
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Applied, thanks.

> ---
>  hw/misc/macio/cuda.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 1d0f7e8289..a88535fa66 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -150,7 +150,7 @@ static uint64_t get_tb(uint64_t time, uint64_t freq)
>      return muldiv64(time, freq, NANOSECONDS_PER_SECOND);
>  }
> =20
> -static unsigned int get_counter(CUDATimer *ti)
> +static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
>  {
>      int64_t d;
>      unsigned int counter;
> @@ -295,12 +295,12 @@ static uint64_t cuda_read(void *opaque, hwaddr addr=
, unsigned size)
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
> @@ -311,12 +311,12 @@ static uint64_t cuda_read(void *opaque, hwaddr addr=
, unsigned size)
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DzFMwNuU1QL7hgxO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp/crAACgkQbDjKyiDZ
s5LNRw/9HD6BaJhy2NUksQYP4v/DQ5y6V+2mGDz5b9RxFkdKMwuEKr11zgNuHJxs
im51sO5kw1PYEmOsR5sxvJAs5iX9cUjhsauxoClAV0KP7aNc5jrgAcySQW4QlV1B
9gDa+Oo+VFqft7AcAkAAKqz0d4LY56otlGcM4SbVa3OUG04SY8pakEBgyrWzPR7Z
IuVUDoBbEWv5tCzekKefHWVDcO3Amq4eifrpPvVzwFgVpxeesgoes/SAf03mrvBY
0OZWtFouDbWoHCyktYL4+ywr1M0iJYWJyT+uyIU3WLkjfI2W4HW6UlwwINz+YldE
rem7H9p4v2/6mAzPj2lI4PmicFowZKEy1jCEzI0ztnfK55PfRsQfqOV8i0psHVZv
XCHBgIBxwAfunr5jdfJViH19vd0ETgLorrAMhO+S1gx4MfjB1qBkqmbUePNcN3M5
uf+fA0Wb6EIKH/Kv7QkzMaTg6Zwlb7lwzXWajC9zX4DliPx9LM6KDqPnR5kMZ2XH
ucBbnmnIJYKmaxTYlHCNlLHMOoF0jWaRLioRiXhsyxmGy45OCb+M8Kduf2Cfdyhq
oU3GMwFaaPI66+M6wxOmOxlEvoCR2iQMVdDCAeIVDSnlL/00Yot6RSlEnDRv4AwI
a5PZyX7JSHFueh5VZ82g6MkESQGaPsrsnfkCGQGFxUfh17pfImE=
=r6nf
-----END PGP SIGNATURE-----

--DzFMwNuU1QL7hgxO--
