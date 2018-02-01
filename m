Received: from eggs.gnu.org ([2001:4830:134:3::10]:34935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh2jO-0005nS-Fj
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh2jN-0006o7-M1
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:27:58 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eh2jN-0006nP-Cg
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:27:57 -0500
Received: by mail-lf0-x242.google.com with SMTP id t139so23522170lff.0
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 16:27:57 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-12-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-12-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 16:27:25 -0800
Message-ID: <CAKmqyKPWKR8LOdUYPqxAj4Y1eNGw-cqnp-nYOfEBPjrG2F+HPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/18] sdcard: check the card is in
 correct state for APP CMD (CMD55)
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
>  hw/sd/sd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index bbf9496e8a..434d1fbc47 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1389,6 +1389,14 @@ static sd_rsp_type_t sd_normal_command(SDState *sd=
, SDRequest req)
>
>      /* Application specific commands (Class 8) */
>      case 55:   /* CMD55:  APP_CMD */
> +        switch (sd->state) {
> +        case sd_ready_state:
> +        case sd_identification_state:
> +        case sd_inactive_state:
> +            return sd_illegal;
> +        default:
> +            break;
> +        }
>          if (!sd->spi) {
>              if (sd->rca !=3D rca) {
>                  return sd_r0;
> --
> 2.15.1
>
>
