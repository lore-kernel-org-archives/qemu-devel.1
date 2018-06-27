Received: from eggs.gnu.org ([2001:4830:134:3::10]:32790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fY7Cx-0004ZG-6g
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fY7Cu-0000Y0-2H
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:57:51 -0400
Date: Wed, 27 Jun 2018 10:57:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180627095744.GE4325@stefanha-x1.localdomain>
References: <20180627073351.856-1-contrib@steffen-goertz.de>
	<20180627073351.856-7-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline
In-Reply-To: <20180627073351.856-7-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [RFC 6/8] arm: Add UICR/FICR handling to NRF51 SOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 09:33:49AM +0200, Steffen G=F6rtz wrote:
> This patch maps preallocated user/factory information
> configuration registers to the NRF51 SOC.
> See NRF51 reference manual section 7 and 8.
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  hw/arm/nrf51_soc.c         | 174 ++++++++++++++++++++++++++++++-------
>  include/hw/arm/nrf51_soc.h |   5 +-
>  2 files changed, 145 insertions(+), 34 deletions(-)
>=20
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index e93699a4b0..82e4c2d833 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -19,7 +19,6 @@
>  #include "sysemu/sysemu.h"
>  #include "qemu/log.h"
>  #include "cpu.h"
> -#include "crypto/random.h"
> =20
>  #include "hw/arm/nrf51_soc.h"
> =20
> @@ -29,6 +28,9 @@
>  #define FICR_BASE       0x10000000
>  #define FICR_SIZE       0x100
> =20
> +#define UICR_BASE       0x10001000
> +#define UICR_SIZE       0x100

This definition is duplicated in your NVMC patch.  Please put it in the
nrf51_soc.h header file.

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM1+YAAoJEJykq7OBq3PIk7cH/RJNX0RmF/0jm9YaHbpXiS+W
5P2K1EW58m/VgxpXlc64HHxbEz6IPniYca/lQT78vmWG3b6IMKDZdevPahAHF9iK
YjwDtmscMXarjoSRxAfum5WaThjpLcDQ6ni8VqKgRm/EjNn5q15YxY/rsLcXbr3A
WNOxxNvSfHDMZK8c3exoSR/HdJ0Ed/6KQnrpU9SIxs6wEadPc3/1h/PytjwT5eQ1
4By3HHPSjaAUqdpPJjBChmU6qNriasyLn0dcLJvgnj8MJJ3XDo9GE7H08A17OiDZ
ypdFUTGKqr8xeL2u5FtwAByQUwnnY4CUvqg4KcFubCdMqQNsZaBeXx8DG0oS/eY=
=OwKQ
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
