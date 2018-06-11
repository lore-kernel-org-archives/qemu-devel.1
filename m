Received: from eggs.gnu.org ([2001:4830:134:3::10]:55006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fSSTB-0007yo-U0
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fSSTA-000794-V2
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:27:13 -0400
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-3-f4bug@amsat.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <59507b40-1c5e-8782-1b3b-3690e73563ec@weilnetz.de>
Date: Mon, 11 Jun 2018 21:27:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180611011501.10235-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 02/40] vdi: Use definitions from
 "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:VDI" <qemu-block@nongnu.org>

Am 11.06.2018 um 03:14 schrieb Philippe Mathieu-Daud=C3=A9:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  block/vdi.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/vdi.c b/block/vdi.c
> index 668af0a828..35b51dc5c5 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -50,6 +50,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qobject-input-visitor.h"
> @@ -83,9 +84,6 @@
>  /* Command line option for static images. */
>  #define BLOCK_OPT_STATIC "static"
> =20
> -#define KiB     1024
> -#define MiB     (KiB * KiB)
> -
>  #define SECTOR_SIZE 512
>  #define DEFAULT_CLUSTER_SIZE (1 * MiB)
> =20
> @@ -250,7 +248,7 @@ static void vdi_header_print(VdiHeader *header)
>      logout("heads       0x%04x\n", header->heads);
>      logout("sectors     0x%04x\n", header->sectors);
>      logout("sector size 0x%04x\n", header->sector_size);
> -    logout("image size  0x%" PRIx64 " B (%" PRIu64 " MiB)\n",
> +    logout("image size  0x%" PRIx64 " B (%llu MiB)\n",
>             header->disk_size, header->disk_size / MiB);
>      logout("block size  0x%04x\n", header->block_size);
>      logout("block extra 0x%04x\n", header->block_extra);
> @@ -434,7 +432,7 @@ static int vdi_open(BlockDriverState *bs, QDict *op=
tions, int flags,
>          goto fail;
>      } else if (header.block_size !=3D DEFAULT_CLUSTER_SIZE) {
>          error_setg(errp, "unsupported VDI image (block size %" PRIu32
> -                   " is not %u)", header.block_size, DEFAULT_CLUSTER_S=
IZE);
> +                   " is not %llu)", header.block_size, DEFAULT_CLUSTER=
_SIZE);
>          ret =3D -ENOTSUP;
>          goto fail;
>      } else if (header.disk_size >
>=20

Reviewed-by: Stefan Weil <sw@weilnetz.de>
