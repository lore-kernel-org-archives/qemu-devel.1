Received: from eggs.gnu.org ([2001:4830:134:3::10]:50937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eorpn-0001dU-Pw
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eorpm-0001wE-Ry
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:26:55 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:43471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eorpm-0001vt-MN
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:26:54 -0500
Received: by mail-ot0-x244.google.com with SMTP id q12so4745340otg.10
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 06:26:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215221325.7611-21-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
	<20180215221325.7611-21-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 14:26:33 +0000
Message-ID: <CAFEAcA_x_pubHXUkAe-mFD5Xw2L4Uo+3sYFYd=c+yV2+NuSDmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 20/20] sdcard: add an enum for the SD
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

On 15 February 2018 at 22:13, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> So far this device intends to model the Spec v1.10
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>  hw/sd/sd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index b9429b06ca..d4565626ce 100644
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
> @@ -2169,6 +2175,7 @@ static void sd_realize(DeviceState *dev, Error **er=
rp)
>      int ret;
>
>      sd->proto_name =3D sd->spi ? "SPI" : "SD";
> +    sd->spec_version =3D SD_PHY_SPEC_VER_1_10;
>
>      if (sd->blk && blk_is_read_only(sd->blk)) {
>          error_setg(errp, "Cannot use read-only drive as SD card");

I think I'd prefer to see this patch with the ones that actually use
the field -- as it stands it's never used.

thanks
-- PMM
