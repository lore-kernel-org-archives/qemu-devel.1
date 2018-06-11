Received: from eggs.gnu.org ([2001:4830:134:3::10]:53754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fSSNW-0004uC-1B
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fSSNU-0003yW-S2
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:21:22 -0400
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-35-f4bug@amsat.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <0e83902b-01dc-42ba-d708-8baa0fc16b9c@weilnetz.de>
Date: Mon, 11 Jun 2018 21:20:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180611011501.10235-35-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kj7AYo4YczuQ8bsfCrBfJUyhkjyMLb4UX"
Subject: Re: [Qemu-devel] [PATCH v4 34/40] hw/net: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>, "open list:Allwinner-a10" <qemu-arm@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kj7AYo4YczuQ8bsfCrBfJUyhkjyMLb4UX
From: Stefan Weil <sw@weilnetz.de>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Beniamino Galvani <b.galvani@gmail.com>,
 "open list:Allwinner-a10" <qemu-arm@nongnu.org>
Message-ID: <0e83902b-01dc-42ba-d708-8baa0fc16b9c@weilnetz.de>
Subject: Re: [Qemu-devel] [PATCH v4 34/40] hw/net: Use the IEC binary prefix
 definitions
References: <20180611011501.10235-1-f4bug@amsat.org>
 <20180611011501.10235-35-f4bug@amsat.org>
In-Reply-To: <20180611011501.10235-35-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 11.06.2018 um 03:14 schrieb Philippe Mathieu-Daud=C3=A9:
> It eases code review, unit is explicit.
>=20
> Patch generated using:
>=20
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include=
/hw/
>=20
> and modified manually.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> ---
>  hw/net/ne2000.h                 | 5 +++--
>  include/hw/net/allwinner_emac.h | 5 +++--
>  hw/net/e1000e.c                 | 7 ++++---
>  hw/net/e1000x_common.c          | 3 ++-
>  hw/net/eepro100.c               | 3 +--
>  5 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/net/ne2000.h b/hw/net/ne2000.h
> index adb8021bd1..2cd193e4c6 100644
> --- a/hw/net/ne2000.h
> +++ b/hw/net/ne2000.h
> @@ -1,11 +1,12 @@
>  #ifndef HW_NE2000_H
>  #define HW_NE2000_H
> =20
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "net/net.h"
> =20
> -#define NE2000_PMEM_SIZE    (32*1024)
> -#define NE2000_PMEM_START   (16*1024)
> +#define NE2000_PMEM_SIZE    (32 * KiB)
> +#define NE2000_PMEM_START   (16 * KiB)
>  #define NE2000_PMEM_END     (NE2000_PMEM_SIZE+NE2000_PMEM_START)
>  #define NE2000_MEM_SIZE     NE2000_PMEM_END
> =20
> diff --git a/include/hw/net/allwinner_emac.h b/include/hw/net/allwinner=
_emac.h
> index 4cc8aab7ec..905a43deb4 100644
> --- a/include/hw/net/allwinner_emac.h
> +++ b/include/hw/net/allwinner_emac.h
> @@ -23,6 +23,7 @@
>  #ifndef ALLWINNER_EMAC_H
>  #define ALLWINNER_EMAC_H
> =20
> +#include "qemu/units.h"
>  #include "net/net.h"
>  #include "qemu/fifo8.h"
>  #include "hw/net/mii.h"
> @@ -125,8 +126,8 @@
>  #define EMAC_INT_RX         (1 << 8)
> =20
>  /* Due to lack of specifications, size of fifos is chosen arbitrarily =
*/
> -#define TX_FIFO_SIZE        (4 * 1024)
> -#define RX_FIFO_SIZE        (32 * 1024)
> +#define TX_FIFO_SIZE        (4 * KiB)
> +#define RX_FIFO_SIZE        (32 * KiB)
> =20
>  #define NUM_TX_FIFOS        2
>  #define RX_HDR_SIZE         8
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index cda8d48333..510ddb3897 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -34,6 +34,7 @@
>  */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "net/net.h"
>  #include "net/tap.h"
>  #include "qemu/range.h"
> @@ -81,10 +82,10 @@ typedef struct E1000EState {
>  #define E1000E_IO_IDX       2
>  #define E1000E_MSIX_IDX     3
> =20
> -#define E1000E_MMIO_SIZE    (128 * 1024)
> -#define E1000E_FLASH_SIZE   (128 * 1024)
> +#define E1000E_MMIO_SIZE    (128 * KiB)
> +#define E1000E_FLASH_SIZE   (128 * KiB)
>  #define E1000E_IO_SIZE      (32)
> -#define E1000E_MSIX_SIZE    (16 * 1024)
> +#define E1000E_MSIX_SIZE    (16 * KiB)
> =20
>  #define E1000E_MSIX_TABLE   (0x0000)
>  #define E1000E_MSIX_PBA     (0x2000)
> diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
> index eb0e097137..09047806f2 100644
> --- a/hw/net/e1000x_common.c
> +++ b/hw/net/e1000x_common.c
> @@ -23,6 +23,7 @@
>  */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/pci/pci.h"
>  #include "net/net.h"
> @@ -111,7 +112,7 @@ bool e1000x_is_oversized(uint32_t *mac, size_t size=
)
>      static const int maximum_ethernet_vlan_size =3D 1522;
>      /* this is the size past which hardware will
>         drop packets when setting LPE=3D1 */
> -    static const int maximum_ethernet_lpe_size =3D 16384;
> +    static const int maximum_ethernet_lpe_size =3D 16 * KiB;
> =20
>      if ((size > maximum_ethernet_lpe_size ||
>          (size > maximum_ethernet_vlan_size
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index a07a63247e..e761daf551 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -41,6 +41,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/pci/pci.h"
>  #include "net/net.h"
> @@ -60,8 +61,6 @@
>   * changed to pad short packets itself. */
>  #define CONFIG_PAD_RECEIVED_FRAMES
> =20
> -#define KiB 1024
> -
>  /* Debug EEPRO100 card. */
>  #if 0
>  # define DEBUG_EEPRO100
>=20

Reviewed-by: Stefan Weil <sw@weilnetz.de>

Thank you!



--kj7AYo4YczuQ8bsfCrBfJUyhkjyMLb4UX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESSNv6nXJXWmOwreK4Iwh1Wd0UK0FAlsey6IACgkQ4Iwh1Wd0
UK0H/g/9GCuOKU0kNMlzSz2P5k+R/1MzzSmYo0T8SHp+gV9PdXehvuYuIB8QRCOa
5/hkO/w/AcPiUS02J3F3eIb9OwCwaQriJub9n9y3OxSM2FD09UHWtp9nKeo+nTDm
PtNWCPyvYTZ0p8gXOkQ+nNeQy90JcAGKlZTcjDtb7bcbfgPsxd+KuvXVHpCQUal2
W+rrR4qkNBUEN8bTKNp1qwBdhTvuq8a6DReUD6C0pd+P8Qqu89FFh8ArGW7z/TZK
5vfVBwPtrbO6oVCtBbB3As3ZttG5vrKP398P4vB5moH/jrlVU47iHZb1pd5L8q41
4oUDLKGo6XqIcHXdj/zL4sCa9sRQdx2rCjK4KNi2w0hexxvgYbJVWi/FlSr/XS2W
1BlQGOs5P/EIJG1rhhbwi/mcH7R4Z7d/nx7SjK9JqvUJ+SAxGYzIMvKnXB7reSvY
/3aSUWK3hg3OfL5dY0Qux54hCYBqXKHtj8fstk1Ag6RzrN/57+S5kNmoLCmN+zgd
UCBtWzVt2avY1vtmCe6//B/qdcPrBG32x6DEoDlz5xKPqJE4A7U4Ti65nFn7fPBH
/mHuD30hAQzhmM7Mxae2eh7yX7FdpKy8OEZoKTIjHywfmQ9e6rYF1CUovM4YMrBn
5U18oN0I+RM9uAKU8nkPxYqPd1xw72Dgv+0masCi4YULdkC6hD4=
=gLba
-----END PGP SIGNATURE-----

--kj7AYo4YczuQ8bsfCrBfJUyhkjyMLb4UX--
