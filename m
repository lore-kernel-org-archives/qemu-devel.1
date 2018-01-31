Received: from eggs.gnu.org ([2001:4830:134:3::10]:45662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egv3i-0006qh-Os
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egv3h-000649-Od
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:16:26 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:44440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egv3h-00063u-GB
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:16:25 -0500
Received: by mail-lf0-x243.google.com with SMTP id v188so21547628lfa.11
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:16:25 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-2-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-2-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:15:53 -0800
Message-ID: <CAKmqyKPvQd=LqqSMb414WjXYFGPxekxWy7F8DDhZRG-srD-EYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/18] sdcard: Don't always set the high
 capacity bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jan 22, 2018 at 7:30 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Don't set the high capacity bit by default as it will be set if required
> in the sd_set_csd() function.
>
> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>  and Peter Ogden <ogden@xilinx.com> from qemu/xilinx tag xilinx-v2015.4]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 437ce25f79..20764451f2 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -289,6 +289,10 @@ static void sd_ocr_powerup(void *opaque)
>
>      /* card power-up OK */
>      sd->ocr =3D FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
> +
> +    if (sd->size > 1 * G_BYTE) {
> +        sd->ocr =3D FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
> +    }
>  }
>
>  static void sd_reset_scr(SDState *sd)
> @@ -393,7 +397,6 @@ static void sd_reset_csd(SDState *sd, uint64_t size)
>          sd->csd[13] =3D 0x40;
>          sd->csd[14] =3D 0x00;
>          sd->csd[15] =3D 0x00;
> -        sd->ocr |=3D 1 << 30;     /* High Capacity SD Memory Card */
>      }
>  }
>
> --
> 2.15.1
>
>
