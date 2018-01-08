Received: from eggs.gnu.org ([2001:4830:134:3::10]:49672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfHA-0000CO-Kr
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfH9-0001vH-Nj
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:48:12 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:32822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eYfH9-0001uZ-Fu
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:48:11 -0500
Received: by mail-wr0-x242.google.com with SMTP id p6so12233883wrd.0
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 13:48:11 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103212436.15762-5-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
	<20180103212436.15762-5-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 8 Jan 2018 13:47:39 -0800
Message-ID: <CAKmqyKNUxWs-dO_6bsqWfNXxmcyVNP3KQqxc=vcYOCnMeGBnVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/25] sdcard: define SDCARD_CMD_MAX
 instead of using the magic '64'
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index f0eaac4d42..489d13681d 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -56,6 +56,8 @@ do { fprintf(stderr, "SD: " fmt , ## __VA_ARGS__); } wh=
ile (0)
>  #define OCR_POWER_UP            0x80000000
>  #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
>
> +#define SDCARD_CMD_MAX 64
> +
>  typedef enum {
>      sd_r0 =3D 0,    /* no response */
>      sd_r1,        /* normal response command */
> @@ -176,18 +178,21 @@ static void sd_set_mode(SDState *sd)
>      }
>  }
>
> -static const sd_cmd_type_t sd_cmd_type[64] =3D {
> +static const sd_cmd_type_t sd_cmd_type[SDCARD_CMD_MAX] =3D {
>      sd_bc,   sd_none, sd_bcr,  sd_bcr,  sd_none, sd_none, sd_none, sd_ac=
,
>      sd_bcr,  sd_ac,   sd_ac,   sd_adtc, sd_ac,   sd_ac,   sd_none, sd_ac=
,
> +    /* 16 */
>      sd_ac,   sd_adtc, sd_adtc, sd_none, sd_none, sd_none, sd_none, sd_no=
ne,
>      sd_adtc, sd_adtc, sd_adtc, sd_adtc, sd_ac,   sd_ac,   sd_adtc, sd_no=
ne,
> +    /* 32 */
>      sd_ac,   sd_ac,   sd_none, sd_none, sd_none, sd_none, sd_ac,   sd_no=
ne,
>      sd_none, sd_none, sd_bc,   sd_none, sd_none, sd_none, sd_none, sd_no=
ne,
> +    /* 48 */
>      sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_ac=
,
>      sd_adtc, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_no=
ne,
>  };
>
> -static const int sd_cmd_class[64] =3D {
> +static const int sd_cmd_class[SDCARD_CMD_MAX] =3D {
>      0,  0,  0,  0,  0,  9, 10,  0,  0,  0,  0,  1,  0,  0,  0,  0,
>      2,  2,  2,  2,  3,  3,  3,  3,  4,  4,  4,  4,  6,  6,  6,  6,
>      5,  5, 10, 10, 10, 10,  5,  9,  9,  9,  7,  7,  7,  7,  7,  7,
> @@ -787,8 +792,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
>      /* Not interpreting this as an app command */
>      sd->card_status &=3D ~APP_CMD;
>
> -    if (sd_cmd_type[req.cmd & 0x3F] =3D=3D sd_ac
> -        || sd_cmd_type[req.cmd & 0x3F] =3D=3D sd_adtc) {
> +    if (sd_cmd_type[req.cmd] =3D=3D sd_ac
> +        || sd_cmd_type[req.cmd] =3D=3D sd_adtc) {
>          rca =3D req.arg >> 16;
>      }
>
> @@ -1495,8 +1500,8 @@ static int cmd_valid_while_locked(SDState *sd, SDRe=
quest *req)
>      if (req->cmd =3D=3D 16 || req->cmd =3D=3D 55) {
>          return 1;
>      }
> -    return sd_cmd_class[req->cmd & 0x3F] =3D=3D 0
> -            || sd_cmd_class[req->cmd & 0x3F] =3D=3D 7;
> +    return sd_cmd_class[req->cmd] =3D=3D 0
> +            || sd_cmd_class[req->cmd] =3D=3D 7;
>  }
>
>  int sd_do_command(SDState *sd, SDRequest *req,
> @@ -1515,6 +1520,12 @@ int sd_do_command(SDState *sd, SDRequest *req,
>          goto send_response;
>      }
>
> +    if (req->cmd >=3D SDCARD_CMD_MAX) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "SD: incorrect command 0x%02x\n",
> +                      req->cmd);
> +        req->cmd &=3D 0x3f;
> +    }
> +
>      if (sd->card_status & CARD_IS_LOCKED) {
>          if (!cmd_valid_while_locked(sd, req)) {
>              sd->card_status |=3D ILLEGAL_COMMAND;
> --
> 2.15.1
>
>
