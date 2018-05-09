Received: from eggs.gnu.org ([2001:4830:134:3::10]:38497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGREu-0003tv-91
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGREt-0004DE-9s
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:42:48 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:37075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fGREt-0004Be-1y
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:42:47 -0400
Received: by mail-lf0-x243.google.com with SMTP id r2-v6so15487966lff.4
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 08:42:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509060104.4458-2-f4bug@amsat.org>
References: <20180509060104.4458-1-f4bug@amsat.org>
	<20180509060104.4458-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 9 May 2018 08:42:15 -0700
Message-ID: <CAKmqyKO8BsN2P9FCOyh0=nwx+4kcPf7nz=ym=ZF6hiwxKOdXaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] sdcard: Update the SDState
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, May 8, 2018 at 11:01 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Add more descriptive comments to keep a clear separation
> between static property vs runtime changeable.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sd.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 235e0518d6..5fb4787671 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -90,12 +90,15 @@ struct SDState {
>      uint32_t card_status;
>      uint8_t sd_status[64];
>
> -    /* Configurable properties */
> +    /* Static properties */
> +
>      BlockBackend *blk;
>      bool spi;
>
> -    uint32_t mode;    /* current card mode, one of SDCardModes */
> -    int32_t state;    /* current card state, one of SDCardStates */
> +    /* Runtime changeables */
> +
> +    uint32_t mode;    /** current card mode, one of #SDCardModes */
> +    int32_t state;    /** current card state, one of #SDCardStates */
>      uint32_t vhs;
>      bool wp_switch;
>      unsigned long *wp_groups;
> @@ -109,8 +112,9 @@ struct SDState {
>      uint32_t pwd_len;
>      uint8_t function_group[6];
>      uint8_t current_cmd;
> -    /* True if we will handle the next command as an ACMD. Note that thi=
s does
> -     * *not* track the APP_CMD status bit!
> +    /**
> +     * #True if we will handle the next command as an ACMD.

Why do we need a # here?

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair


> +     * Note that this does *not* track the APP_CMD status bit!
>       */
>      bool expecting_acmd;
>      uint32_t blk_written;
> --
> 2.17.0
>
>
