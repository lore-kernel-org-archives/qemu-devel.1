Received: from eggs.gnu.org ([2001:4830:134:3::10]:52817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfMu-0004JY-6v
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfMt-00069Q-E6
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:54:08 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180108154303.6522-9-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
	<20180108154303.6522-9-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 8 Jan 2018 13:53:35 -0800
Message-ID: <CAKmqyKMaGf=OwErtFZe-KsdQnGPgNy-1KmNz+OvKeHEU5d2Jaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 08/31] hw/sd: clean/reorder the Makefile
 adding few comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?Q?Gr=C3=A9gory_Estrade?= <gregory.estrade@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Clement Deschamps <clement.deschamps@antfield.fr>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Jan 8, 2018 at 7:42 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/Makefile.objs | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
> index c2b7664264..0fe2501017 100644
> --- a/hw/sd/Makefile.objs
> +++ b/hw/sd/Makefile.objs
> @@ -1,9 +1,14 @@
> +# SD/MMC subsystem core
> +common-obj-$(CONFIG_SD) +=3D core.o
> +
> +# SD/MMC host adapters
>  common-obj-$(CONFIG_PL181) +=3D pl181.o
>  common-obj-$(CONFIG_SSI_SD) +=3D ssi-sd.o
> -common-obj-$(CONFIG_SD) +=3D sd.o core.o
>  common-obj-$(CONFIG_SDHCI) +=3D sdhci.o
> -
>  obj-$(CONFIG_MILKYMIST) +=3D milkymist-memcard.o
>  obj-$(CONFIG_OMAP) +=3D omap_mmc.o
>  obj-$(CONFIG_PXA2XX) +=3D pxa2xx_mmci.o
>  obj-$(CONFIG_RASPI) +=3D bcm2835_sdhost.o
> +
> +# emulated SD/MMC devices
> +common-obj-$(CONFIG_SD) +=3D sd.o
> --
> 2.15.1
>
>
