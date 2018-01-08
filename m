Received: from eggs.gnu.org ([2001:4830:134:3::10]:48706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfEu-0007AT-DR
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfEt-0000eT-OL
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:45:52 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:40106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eYfEt-0000dv-FA
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:45:51 -0500
Received: by mail-wm0-x236.google.com with SMTP id f206so16868765wmf.5
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 13:45:51 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103212436.15762-10-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
	<20180103212436.15762-10-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 8 Jan 2018 13:45:19 -0800
Message-ID: <CAKmqyKOEiM4=DvnWB5H8ByJMQ_eXrNCY59SeTc-EN_Y4ZSmY0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/25] sdcard: use G_BYTE from cutils
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Olbrich <m.olbrich@pengutronix.de>, Andrzej Zaborowski <balrogg@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paul Brook <paul@codesourcery.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Wed, Jan 3, 2018 at 1:24 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> code is now easier to read.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 1f209b8199..d4aa7b4a92 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -38,6 +38,7 @@
>  #include "hw/sd/sdcard_legacy.h"
>  #include "qapi/error.h"
>  #include "qemu/bitmap.h"
> +#include "qemu/cutils.h"
>  #include "hw/qdev-properties.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
> @@ -369,7 +370,7 @@ static void sd_reset_csd(SDState *sd, uint64_t size)
>      uint32_t sectsize =3D (1 << (SECTOR_SHIFT + 1)) - 1;
>      uint32_t wpsize =3D (1 << (WPGROUP_SHIFT + 1)) - 1;
>
> -    if (size <=3D 0x40000000) {  /* Standard Capacity SD */
> +    if (size <=3D 1 * G_BYTE /* FIXME 2GB? */) { /* Standard Capacity SD=
 */
>          sd->csd[0] =3D 0x00;     /* CSD structure */
>          sd->csd[1] =3D 0x26;     /* Data read access-time-1 */
>          sd->csd[2] =3D 0x00;     /* Data read access-time-2 */
> --
> 2.15.1
>
>
