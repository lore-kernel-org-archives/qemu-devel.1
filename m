Received: from eggs.gnu.org ([2001:4830:134:3::10]:49683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evGUD-0002K0-QC
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 01:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evGU9-0000nA-SH
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 01:59:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38290 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1evGU9-0000mw-Nf
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 01:59:01 -0400
References: <1520786414-8806-1-git-send-email-aishwaryakadlag@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6666720e-6f5c-0e8c-6c5a-ac36d708e314@redhat.com>
Date: Mon, 12 Mar 2018 06:58:50 +0100
MIME-Version: 1.0
In-Reply-To: <1520786414-8806-1-git-send-email-aishwaryakadlag@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V1]sm501: dead code removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aishwarya Kadlag <aishwaryakadlag@gmail.com>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>

On 11.03.2018 17:40, Aishwarya Kadlag wrote:
> From: Aishwarya Kadlag <aishwaryakadlag@gmail.com>
>=20
> Remove support for DEPTH !=3D 32 values from hw/display/*_template.h=20
> files and other files that include them. Only DEPTH =3D=3D 32 case is=20
> supported.
>=20
> Signed-off-by: Aishwarya Kadlag <aishwaryakadlag@gmail.com>
> ---
> hw/display/sw501_1.c              |   36 ------------------------------=
------=20
> hw/display/sw501_template_1.h     |    4 +++-=20
> 2 files changed, 3 insertions(+), 37 deletions(-)
>=20
>=20
> diff -u sm501.c sm501_1.c > sm501.patch -s

Patches should be applicable from the the top directory. It's best if
you create the patches with "git format-patch", see:

https://wiki.qemu.org/Contribute/SubmitAPatch#Use_git_format-patch

> --- sm501.c	2018-03-11 17:46:33.621452968 +0530
> +++ sm501_1.c	2018-03-11 17:53:26.933445566 +0530
> @@ -1358,22 +1358,6 @@
>                                  int width, const uint8_t *palette,
>                                  int c_x, int c_y);
> =20
> -#define DEPTH 8
> -#include "sm501_template.h"
> -
> -#define DEPTH 15
> -#include "sm501_template.h"
> -
> -#define BGR_FORMAT
> -#define DEPTH 15
> -#include "sm501_template.h"
> -
> -#define DEPTH 16
> -#include "sm501_template.h"
> -
> -#define BGR_FORMAT
> -#define DEPTH 16
> -#include "sm501_template.h"
> =20
>  #define DEPTH 32
>  #include "sm501_template.h"
> @@ -1383,43 +1367,23 @@
>  #include "sm501_template.h"
> =20
>  static draw_line_func *draw_line8_funcs[] =3D {
> -    draw_line8_8,
> -    draw_line8_15,
> -    draw_line8_16,
>      draw_line8_32,
>      draw_line8_32bgr,
> -    draw_line8_15bgr,
> -    draw_line8_16bgr,
>  };
> =20
>  static draw_line_func *draw_line16_funcs[] =3D {
> -    draw_line16_8,
> -    draw_line16_15,
> -    draw_line16_16,
>      draw_line16_32,
>      draw_line16_32bgr,
> -    draw_line16_15bgr,
> -    draw_line16_16bgr,
>  };
> =20
>  static draw_line_func *draw_line32_funcs[] =3D {
> -    draw_line32_8,
> -    draw_line32_15,
> -    draw_line32_16,
>      draw_line32_32,
>      draw_line32_32bgr,
> -    draw_line32_15bgr,
> -    draw_line32_16bgr,
>  };
> =20
>  static draw_hwc_line_func *draw_hwc_line_funcs[] =3D {
> -    draw_hwc_line_8,
> -    draw_hwc_line_15,
> -    draw_hwc_line_16,
>      draw_hwc_line_32,
>      draw_hwc_line_32bgr,
> -    draw_hwc_line_15bgr,
> -    draw_hwc_line_16bgr,
>  };
> =20
>  static inline int get_depth_index(DisplaySurface *surface)
>=20
>=20
>=20
> diff -u sm501_template.h sm501_template_1.h > sm501_template.patch -s
> --- sm501_template.h    2018-03-11 17:25:36.816653718 +0530
> +++ sm501_template_1.h  2018-03-11 17:25:16.828654076 +0530
> @@ -22,13 +22,15 @@
>   * THE SOFTWARE.
>   */
> =20
> +/*
>  #if DEPTH =3D=3D 8
>  #define BPP 1
>  #define PIXEL_TYPE uint8_t
>  #elif DEPTH =3D=3D 15 || DEPTH =3D=3D 16
>  #define BPP 2
>  #define PIXEL_TYPE uint16_t
> -#elif DEPTH =3D=3D 32
> +*/
> +#if DEPTH =3D=3D 32
>  #define BPP 4
>  #define PIXEL_TYPE uint32_t
>  #else
>=20

I don't know the hw/display code very well, but I think it's not that
easy... Putting Gerd on CC:, maybe he can describe the details of that
BiteSizeTask a little bit better.

(When sending patches, please also always use the get_maintainers.pl
script to get a set of people who should be put on CC: or the patch
might get lost in the high traffic of the qemu-devel mailing list).

 Thomas
