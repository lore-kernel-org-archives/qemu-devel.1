Received: from eggs.gnu.org ([2001:4830:134:3::10]:49102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfFc-0007Y7-KA
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfFb-00017E-Oo
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:46:36 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:45754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eYfFb-00016J-Hj
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:46:35 -0500
Received: by mail-wm0-x244.google.com with SMTP id i186so524674wmi.4
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 13:46:35 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103212436.15762-2-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
	<20180103212436.15762-2-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 8 Jan 2018 13:46:03 -0800
Message-ID: <CAKmqyKMV9zch9==e+ZMqncbErh1wc1NMe105NE+UxbVvAnYvCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/25] sdcard: reorder SDState struct
 members
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
> place card registers first, this will ease further code movements.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 7755bedfa0..180c43e218 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -89,16 +89,15 @@ enum SDCardStates {
>  struct SDState {
>      DeviceState parent_obj;
>
> -    uint32_t mode;    /* current card mode, one of SDCardModes */
> -    int32_t state;    /* current card state, one of SDCardStates */
> +    /* SD Memory Card Registers */
>      uint32_t ocr;
> -    QEMUTimer *ocr_power_timer;
>      uint8_t scr[8];
>      uint8_t cid[16];
>      uint8_t csd[16];
>      uint16_t rca;
>      uint32_t card_status;
>      uint8_t sd_status[64];
> +
>      uint32_t vhs;
>      bool wp_switch;
>      unsigned long *wp_groups;
> @@ -113,6 +112,9 @@ struct SDState {
>      uint8_t function_group[6];
>
>      bool spi;
> +
> +    uint32_t mode;    /* current card mode, one of SDCardModes */
> +    int32_t state;    /* current card state, one of SDCardStates */
>      uint8_t current_cmd;
>      /* True if we will handle the next command as an ACMD. Note that thi=
s does
>       * *not* track the APP_CMD status bit!
> @@ -125,6 +127,7 @@ struct SDState {
>      qemu_irq readonly_cb;
>      qemu_irq inserted_cb;
>      BlockBackend *blk;
> +    QEMUTimer *ocr_power_timer;
>
>      bool enable;
>  };
> --
> 2.15.1
>
>
