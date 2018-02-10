Received: from eggs.gnu.org ([2001:4830:134:3::10]:45447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeX5-0000ix-2G
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeX3-00016H-IY
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:11 -0500
Date: Sun, 11 Feb 2018 09:35:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210223506.GU11634@umbus.fritz.box>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-4-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z118w8IfbP8nVdqq"
Content-Disposition: inline
In-Reply-To: <20180209185142.17151-4-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2 03/12] cuda: don't call cuda_update()
 when writing to ACR register
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


--z118w8IfbP8nVdqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:51:33PM +0000, Mark Cave-Ayland wrote:
> The wire protocol for reading data to/from the VIA is triggered by changi=
ng
> inputs on port B rather than changing the timer configuration via the ACR.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  hw/misc/macio/cuda.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index eaa8924f49..1d0f7e8289 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -406,7 +406,6 @@ static void cuda_write(void *opaque, hwaddr addr, uin=
t64_t val, unsigned size)
>      case CUDA_REG_ACR:
>          s->acr =3D val;
>          cuda_timer_update(s, &s->timers[0], qemu_clock_get_ns(QEMU_CLOCK=
_VIRTUAL));
> -        cuda_update(s);
>          break;
>      case CUDA_REG_PCR:
>          s->pcr =3D val;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z118w8IfbP8nVdqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp/c5oACgkQbDjKyiDZ
s5Kuvg//QtaM3oAzwUJAjlgOA/4YZ8pvi7UReQXuq9HDCURwLyKRoMfh6cEFaGkB
WV7L+4unI7Aa5xGDlEu0OT7vdi+BNjAQ2uazXhYd3qfe2NfCwIFBchEeJEoflG5V
SCP3/oegftTS3KVF1zJJleiy1gLJwSvX+TsFi+bCkgdzl9mp/PUWfqypRTXlnQvu
OC0kTt6ZGnr5pnyTKV4UrdkjaYEfvxvqGcHQ7biEmpJLrPXZYdDX5qowWafzdK6G
PqfCSr4dmeHImYfaZ8BYpPabtG7DqUmliemv1NBpKDbKgM7C4afCEYNSG1EZGQRt
hfbtltbxtCIadc4RY18x25OPTFeNOWAOt7MsQEowLzd73TpMdNGKj3oaVfkJ9LwW
Lk0TY1NI9SnElNWmsy/SCmQcWC8Cri7TOBSku3S6c4qWkLwzIF5HpafPK93LuMMK
Cu6lm9WggY+B2wfVDBtM4srPSVzKPJ7116MZDW3Ch4dM923cICU2Bq7Hs59yqJhb
vcaFMbEop3czUqrex0uK2pDZx95QE/tvzZX8HaJ4ndp4lXQ+zrba3PAnbsksEIyc
0wewVYyyUiuyukubsYgN9xmNLKFqxNsjNvOV2dxSt/IsUVLPRWtKDbIbMrWxvj6Z
xyeXc4rmlnf0eeMPcmkCrj/nORqYqjlE+semOdh4j9lsX5WTSc4=
=YguH
-----END PGP SIGNATURE-----

--z118w8IfbP8nVdqq--
