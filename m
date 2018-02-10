Received: from eggs.gnu.org ([2001:4830:134:3::10]:45805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekPXN-0006iC-VA
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekPXK-0001Dj-Qy
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:25:29 -0500
Date: Sat, 10 Feb 2018 18:23:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210072319.GN11634@umbus.fritz.box>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jdM5ZcN/ZcXXVwZs"
Content-Disposition: inline
In-Reply-To: <20180209185142.17151-3-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2 02/12] cuda: don't allow writes to port
 output pins
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


--jdM5ZcN/ZcXXVwZs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:51:32PM +0000, Mark Cave-Ayland wrote:
> Use the direction registers as a mask to ensure that only input pins are
> updated upon write.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Applied, thanks.

> ---
>  hw/misc/macio/cuda.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 6631017ca2..eaa8924f49 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -359,11 +359,11 @@ static void cuda_write(void *opaque, hwaddr addr, u=
int64_t val, unsigned size)
> =20
>      switch(addr) {
>      case CUDA_REG_B:
> -        s->b =3D val;
> +        s->b =3D (s->b & ~s->dirb) | (val & s->dirb);
>          cuda_update(s);
>          break;
>      case CUDA_REG_A:
> -        s->a =3D val;
> +        s->a =3D (s->a & ~s->dira) | (val & s->dira);
>          break;
>      case CUDA_REG_DIRB:
>          s->dirb =3D val;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jdM5ZcN/ZcXXVwZs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp+necACgkQbDjKyiDZ
s5KUwhAAlnyZTv9GfvHBKeCB1kP/6miVvRyxXhchG7CXZFk0qZkVsZ2fmppLO+HV
QWEQYxsXQIb5d/cYr8Dfc05Qamca9TqCoE4jrqvSnxaWK2QLMNvo0fYa8s5KcB8m
KHoE/cLdGfEfYw13aL6fJxIZxQWCIhyIeqw/MpdouhxOroKQUGPoy86vRbYiOWSm
kkJl4OPd39v2qETVMimLD6r2g9vLLBPuY+v2bCwGtV+1BknpBaVemJmxSrhzz0Ra
mDyOwP5ON25fvDF7x6ZWvBUvj3uyHLv7CE/O1/9VTbhH8Q33sn8L3osRil9zUtND
/JyHzWdu5DyhC1GtyOthuIOgTy4lvRXXt9xufcm2yv2GfhNw7tP9R5RdqEvSPxfL
wsha/rVL0KsJGxCZt15jXeax+HGrvNpDXObEuYGvY/UObXGKcgPDAOGpWeygmNJr
wPfBpK2xOinwvVLtgmEsRV7sHoxy6ll0jczQm9karXrHfqbA7vg6UFZo+XIz6tt0
tpMcUJcMxxh/d0/QsvTcjledKyDw5x5I9sp4690sB8JgwiSV0k0CnkxKPubBpIXq
1TOe6c1O1fHjegxfhmszwRV4o5OQIcKWN1ysq8DNtVHywD0nPe+wqxeH3jxbzR6Y
bhLZeEjQc2emVDirzEhjr+ts9OVPxTd1fLeA4ym/6SiQ5d5R1lQ=
=D8WI
-----END PGP SIGNATURE-----

--jdM5ZcN/ZcXXVwZs--
