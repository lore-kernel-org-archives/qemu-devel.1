Received: from eggs.gnu.org ([2001:4830:134:3::10]:46452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egv6R-0000Ro-4F
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egv6H-0007jS-Fu
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:19:15 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egv6H-0007j5-81
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:19:05 -0500
Received: by mail-lf0-x241.google.com with SMTP id a204so21595461lfa.2
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:19:05 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-5-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-5-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:18:33 -0800
Message-ID: <CAKmqyKMUb=Hj-F5uZJci8P2VVeZQEPXNEndGu_ZkrWX9W18+mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/18] sdcard: clean the SCR register
 and add few comments
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 56df5b660a..5d50d48097 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -297,10 +297,13 @@ static void sd_ocr_powerup(void *opaque)
>
>  static void sd_reset_scr(SDState *sd)
>  {
> -    sd->scr[0] =3D 0x00;         /* SCR Structure */
> -    sd->scr[1] =3D 0x2f;         /* SD Security Support */
> -    sd->scr[2] =3D 0x00;
> +    sd->scr[0] =3D (0 << 4)       /* SCR version 1.0 */
> +                 | 0;           /* Spec Versions 1.0 and 1.01 */
> +    sd->scr[1] =3D (2 << 4)       /* SDSC Card (Security Version 1.01) *=
/
> +                 | 0b0101;      /* 1-bit or 4-bit width bus modes */
> +    sd->scr[2] =3D 0x00;          /* Extended Security is not supported.=
 */
>      sd->scr[3] =3D 0x00;
> +    /* reserved for manufacturer usage */
>      sd->scr[4] =3D 0x00;
>      sd->scr[5] =3D 0x00;
>      sd->scr[6] =3D 0x00;
> --
> 2.15.1
>
>
