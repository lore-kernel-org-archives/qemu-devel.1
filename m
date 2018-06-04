Received: from eggs.gnu.org ([2001:4830:134:3::10]:47392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPeAH-0006DW-7S
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPeAD-0003Jy-4A
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:20:05 -0400
Date: Mon, 4 Jun 2018 10:38:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604003834.GA4251@umbus>
References: <20180506142005.19580-1-mark.cave-ayland@ilande.co.uk>
	<20180506142005.19580-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20180506142005.19580-3-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/4] macio: add trace-events to timer device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 03:20:03PM +0100, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  hw/misc/macio/macio.c      | 3 +++
>  hw/misc/macio/trace-events | 4 ++++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 79621eb879..f9a40eea81 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -32,6 +32,7 @@
>  #include "hw/char/escc.h"
>  #include "hw/misc/macio/macio.h"
>  #include "hw/intc/heathrow_pic.h"
> +#include "trace.h"
> =20
>  /* Note: this code is strongly inspirated from the corresponding code
>   * in PearPC */
> @@ -246,6 +247,7 @@ static void macio_oldworld_init(Object *obj)
>  static void timer_write(void *opaque, hwaddr addr, uint64_t value,
>                         unsigned size)
>  {
> +    trace_macio_timer_write(addr, size, value);
>  }
> =20
>  static uint64_t timer_read(void *opaque, hwaddr addr, unsigned size)
> @@ -266,6 +268,7 @@ static uint64_t timer_read(void *opaque, hwaddr addr,=
 unsigned size)
>          break;
>      }
> =20
> +    trace_macio_timer_read(addr, size, value);
>      return value;
>  }
> =20
> diff --git a/hw/misc/macio/trace-events b/hw/misc/macio/trace-events
> index 24c0a36824..d499d78c99 100644
> --- a/hw/misc/macio/trace-events
> +++ b/hw/misc/macio/trace-events
> @@ -9,3 +9,7 @@ cuda_packet_receive(int len) "length %d"
>  cuda_packet_receive_data(int i, const uint8_t data) "[%d] 0x%02x"
>  cuda_packet_send(int len) "length %d"
>  cuda_packet_send_data(int i, const uint8_t data) "[%d] 0x%02x"
> +
> +# hw/misc/macio/macio.c
> +macio_timer_write(uint64_t addr, unsigned len, uint64_t val) "write addr=
 0x%"PRIx64 " len %d val 0x%"PRIx64
> +macio_timer_read(uint64_t addr, unsigned len, uint32_t val) "read addr 0=
x%"PRIx64 " len %d val 0x%"PRIx32

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsUigUACgkQbDjKyiDZ
s5LMdQ//aaOLkCqg5jH+lW28hutkrddwU16C0qIo/vhnEwiKUocF4K4g4ghAtMXi
3j4WBIWiOwSxqidw4ZDWc3GHutEIM3rme6nK0o+82MjODU0q1iVMdMqPl9maNP1h
s/8RQD12OBDjqv6XjjcTWl20IwS5GSg25QJfpNwwRXJNyFtrB1iEMr7NbdiNeAUa
iCgBff00I4KOFTaoCGPJGJk/4vTc2Lb2NLg+7ewVBQlNq0CerYTkJT6OtAQGHsqw
IFFRbWa+qUl9TC2Q10y9TCgxmZ+GU5YtsybhQ1PTFpc3DgGhweZLpLkuoY/Fa72+
prRGZCDgeViKNUbiHtv0SL6CnHJJ0JUEhHfLbIKKsWMq/9zrdslk3rkf99ydcbPA
iRBUsXpU7cbMD203xF5UllNnhf6rTcYLmX7czcO3bpQGrKMzTgQf4INV4LPbFu9F
9uLvj+UQBOpJ+upYWNnJCLDb9PCzhUTriNNPHI7x74QyCMFLo1kw1Zy6imlgmJvV
0sorjILwOIQXN0dvZqNiSeMlBjXjpcks6zlqWliMblgtYgOACb5H4KzwgG02myiZ
qs8dOUJqi1JjcpNvQdLmy634wYjeVVxLeB+Syl1zv1dOyzUQuXiToKC912z4hGkJ
M9IaKbEE1Oqw4Z0rcdYXnGEy6bPrnOYN9ckTzbJx5llxAXh+JlA=
=IFQW
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
