Received: from eggs.gnu.org ([2001:4830:134:3::10]:45934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egv4j-0007X8-6J
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egv4d-0006aR-J7
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:17:29 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egv4d-0006Zh-B5
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:17:23 -0500
Received: by mail-lf0-x242.google.com with SMTP id a204so21586773lfa.2
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:17:23 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-3-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-3-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:16:51 -0800
Message-ID: <CAKmqyKOz8MLVd_CxjO+dSMqvC4MbGWo5C6wc4-h_svrO4ietkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/18] sdcard: update the CSD CRC
 register regardless the CSD structure version
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
>  hw/sd/sd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 20764451f2..f6318c6fdb 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -377,7 +377,6 @@ static void sd_reset_csd(SDState *sd, uint64_t size)
>          sd->csd[13] =3D 0x20 |   /* Max. write data block length */
>              ((HWBLOCK_SHIFT << 6) & 0xc0);
>          sd->csd[14] =3D 0x00;    /* File format group */
> -        sd->csd[15] =3D (sd_crc7(sd->csd, 15) << 1) | 1;
>      } else {                   /* SDHC */
>          size /=3D 512 * 1024;
>          size -=3D 1;
> @@ -396,8 +395,8 @@ static void sd_reset_csd(SDState *sd, uint64_t size)
>          sd->csd[12] =3D 0x0a;
>          sd->csd[13] =3D 0x40;
>          sd->csd[14] =3D 0x00;
> -        sd->csd[15] =3D 0x00;
>      }
> +    sd->csd[15] =3D (sd_crc7(sd->csd, 15) << 1) | 1;
>  }
>
>  static void sd_reset_rca(SDState *sd)
> --
> 2.15.1
>
>
