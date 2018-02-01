Received: from eggs.gnu.org ([2001:4830:134:3::10]:60481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh2UT-0000Gd-EL
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh2US-0003y1-IA
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:12:33 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:43949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eh2US-0003xh-Aw
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:12:32 -0500
Received: by mail-lf0-x242.google.com with SMTP id o89so23445029lfg.10
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 16:12:32 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-11-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-11-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 16:12:00 -0800
Message-ID: <CAKmqyKPm7Gr=dFipseO60XbND3i-fuBVuz42yn8qtev48yL_Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 10/18] sdcard: handle CMD54 (SDIO)
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
> Linux uses it to poll the bus before polling for a card.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 07424aa56e..bbf9496e8a 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1378,9 +1378,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,=
 SDRequest req)
>          }
>          break;
>
> -    case 52:
> -    case 53:
> -        /* CMD52, CMD53: reserved for SDIO cards
> +    case 52 ... 54:
> +        /* CMD52, CMD53, CMD54: reserved for SDIO cards
>           * (see the SDIO Simplified Specification V2.0)
>           * Handle as illegal command but do not complain
>           * on stderr, as some OSes may use these in their
> --
> 2.15.1
>
>
