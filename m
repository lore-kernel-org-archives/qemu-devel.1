Received: from eggs.gnu.org ([2001:4830:134:3::10]:41708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7LP-0004s6-Oo
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7LO-0004TX-2J
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:47:07 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123030630.26613-10-f4bug@amsat.org>
References: <20180123030630.26613-1-f4bug@amsat.org>
	<20180123030630.26613-10-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 14:46:33 -0800
Message-ID: <CAKmqyKM3TpAF3bJMpiYF=JVRpiuMJbfSTMOeRgm2i3EerTeadQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 09/14] hw/arm/fsl-imx6: implement SDHCI
 Spec. v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, "open list:ARM" <qemu-arm@nongnu.org>

On Mon, Jan 22, 2018 at 7:06 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
> various FreeBSD console output from google search show this register havi=
ng
> a value of 0x0377c800.
>
>  hw/arm/fsl-imx6.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index b0d4088290..1f4607f206 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -27,6 +27,8 @@
>  #include "chardev/char.h"
>  #include "qemu/error-report.h"
>
> +#define IMX6_ESDHC_CAPABILITIES     0x057834b4
> +
>  #define NAME_SIZE 20
>
>  static void fsl_imx6_init(Object *obj)
> @@ -348,6 +350,11 @@ static void fsl_imx6_realize(DeviceState *dev, Error=
 **errp)
>              { FSL_IMX6_uSDHC4_ADDR, FSL_IMX6_uSDHC4_IRQ },
>          };
>
> +        /* UHS-I SDIO3.0 SDR104 1.8V ADMA */
> +        object_property_set_uint(OBJECT(&s->esdhc[i]), 3, "sd-spec-versi=
on",
> +                                 &err);
> +        object_property_set_uint(OBJECT(&s->esdhc[i]), IMX6_ESDHC_CAPABI=
LITIES,
> +                                 "capareg", &err);
>          object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized",=
 &err);
>          if (err) {
>              error_propagate(errp, err);
> --
> 2.15.1
>
>
