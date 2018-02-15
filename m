Received: from eggs.gnu.org ([2001:4830:134:3::10]:41612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1emSS8-0007ii-JB
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1emSS7-00072T-PQ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:56:32 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1emSS7-000721-H9
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:56:31 -0500
Received: by mail-lf0-x244.google.com with SMTP id l191so1771071lfe.1
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:56:31 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180215221325.7611-20-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
	<20180215221325.7611-20-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 15 Feb 2018 14:55:59 -0800
Message-ID: <CAKmqyKPdYw52=yp2y2GTaKcBZS16m7uob9cHqud3=tg6PvvsNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 19/20] sdcard: add a 'uhs' property,
 update the OCR register ACCEPT_SWITCH_1V8 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Feb 15, 2018 at 2:13 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index ada96f5574..b9429b06ca 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -93,6 +93,7 @@ struct SDState {
>      /* Configurable properties */
>      BlockBackend *blk;
>      bool spi;
> +    uint8_t uhs_supported;
>
>      uint32_t mode;    /* current card mode, one of SDCardModes */
>      int32_t state;    /* current card state, one of SDCardStates */
> @@ -292,6 +293,8 @@ static void sd_set_ocr(SDState *sd)
>  {
>      /* All voltages OK */
>      sd->ocr =3D R_OCR_VDD_VOLTAGE_WIN_HI_MASK;
> +
> +    sd->ocr =3D FIELD_DP32(sd->ocr, OCR, ACCEPT_SWITCH_1V8, !!sd->uhs_su=
pported);
>  }
>
>  static void sd_ocr_powerup(void *opaque)
> @@ -2189,6 +2192,7 @@ static Property sd_properties[] =3D {
>       * board to ensure that ssi transfers only occur when the chip selec=
t
>       * is asserted.  */
>      DEFINE_PROP_BOOL("spi", SDState, spi, false),
> +    DEFINE_PROP_UINT8("uhs", SDState, uhs_supported, UHS_NOT_SUPPORTED),
>      DEFINE_PROP_END_OF_LIST()
>  };
>
> --
> 2.16.1
>
>
