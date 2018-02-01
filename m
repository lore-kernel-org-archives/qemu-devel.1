Received: from eggs.gnu.org ([2001:4830:134:3::10]:37473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh2wy-0003vX-AW
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:42:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh2wx-0008Gk-Hg
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:42:00 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:45247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eh2wx-0008Fo-A6
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:41:59 -0500
Received: by mail-lf0-x242.google.com with SMTP id x196so23522662lfd.12
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 16:41:59 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-19-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-19-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 16:41:27 -0800
Message-ID: <CAKmqyKNXL1VjybGTd83SYAC0VybTXF2tJUi2n=sPaR2t9eRTMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 18/18] sdcard: add an enum for the SD
 PHY Spec version
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
> So far this device intends to model the Spec v1.10
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 1f6c4ce2a4..9880a5d090 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -47,6 +47,11 @@
>
>  //#define DEBUG_SD 1
>
> +typedef enum {
> +    SD_PHY_SPEC_VER_1_10 =3D 110,
> +    SD_PHY_SPEC_VER_2_00 =3D 200, /* not yet supported */
> +} sd_phy_spec_ver_t;
> +
>  typedef enum {
>      sd_r0 =3D 0,    /* no response */
>      sd_r1,        /* normal response command */
> @@ -122,6 +127,7 @@ struct SDState {
>      qemu_irq inserted_cb;
>      QEMUTimer *ocr_power_timer;
>      const char *proto_name;
> +    int spec_version;
>      bool enable;
>      uint8_t dat_lines;
>      bool cmd_line;
> @@ -2191,6 +2197,7 @@ static void sd_realize(DeviceState *dev, Error **er=
rp)
>      int ret;
>
>      sd->proto_name =3D sd->spi ? "SPI" : "SD";
> +    sd->spec_version =3D SD_PHY_SPEC_VER_1_10;
>
>      if (sd->blk && blk_is_read_only(sd->blk)) {
>          error_setg(errp, "Cannot use read-only drive as SD card");
> --
> 2.15.1
>
>
