Received: from eggs.gnu.org ([2001:4830:134:3::10]:35025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh2jt-000689-77
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:28:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh2js-0007IC-B8
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:28:29 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eh2js-0007Gf-33
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:28:28 -0500
Received: by mail-lf0-x242.google.com with SMTP id t139so23523457lff.0
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 16:28:27 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-13-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-13-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 16:27:56 -0800
Message-ID: <CAKmqyKNKeiOwz074788ZNGVpDWi8wt82Qyyzr_K-Q5odx-Mzig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/18] sdcard: warn if host uses an
 incorrect address for APP CMD (CMD55)
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
>  hw/sd/sd.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 434d1fbc47..b5c947df62 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1394,6 +1394,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd=
, SDRequest req)
>          case sd_identification_state:
>          case sd_inactive_state:
>              return sd_illegal;
> +        case sd_idle_state:
> +            if (rca) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "SD: illegal RCA 0x%04x for APP_CMD\n", re=
q.cmd);
> +            }
>          default:
>              break;
>          }
> --
> 2.15.1
>
>
