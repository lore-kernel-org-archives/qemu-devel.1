Received: from eggs.gnu.org ([2001:4830:134:3::10]:60275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePX97-0005rw-Vv
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePX92-0005ta-6E
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:18:09 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ePX91-0005sC-Um
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:18:04 -0500
Received: by mail-wm0-x241.google.com with SMTP id g130so27278166wme.0
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 09:18:03 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213195852.30439-3-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-3-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 09:17:31 -0800
Message-ID: <CAKmqyKPgtLM2akzsjoqsnrdfTuDkrhGob-OHDAgzG4Tv+cgJ+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/14] sdhci: clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci-internal.h | 4 ----
>  include/hw/sd/sdhci.h  | 4 +++-
>  hw/sd/sdhci.c          | 1 +
>  3 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
> index 161177cf39..248fd027f9 100644
> --- a/hw/sd/sdhci-internal.h
> +++ b/hw/sd/sdhci-internal.h
> @@ -24,8 +24,6 @@
>  #ifndef SDHCI_INTERNAL_H
>  #define SDHCI_INTERNAL_H
>
> -#include "hw/sd/sdhci.h"
> -
>  /* R/W SDMA System Address register 0x0 */
>  #define SDHC_SYSAD                     0x00
>
> @@ -227,6 +225,4 @@ enum {
>      sdhc_gap_write  =3D 2   /* SDHC stopped at block gap during write op=
eration */
>  };
>
> -extern const VMStateDescription sdhci_vmstate;
> -
>  #endif
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 0f0c3f1e64..1b6a98d578 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -26,17 +26,19 @@
>  #define SDHCI_H
>
>  #include "qemu-common.h"
> -#include "hw/block/block.h"
>  #include "hw/pci/pci.h"
>  #include "hw/sysbus.h"
>  #include "hw/sd/sd.h"
>
>  /* SD/MMC host controller state */
>  typedef struct SDHCIState {
> +    /*< private >*/
>      union {
>          PCIDevice pcidev;
>          SysBusDevice busdev;
>      };
> +
> +    /*< public >*/
>      SDBus sdbus;
>      MemoryRegion iomem;
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index e7cd3258a3..312b167bfa 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -28,6 +28,7 @@
>  #include "sysemu/dma.h"
>  #include "qemu/timer.h"
>  #include "qemu/bitops.h"
> +#include "hw/sd/sdhci.h"
>  #include "sdhci-internal.h"
>  #include "sd-internal.h"
>  #include "qemu/log.h"
> --
> 2.15.1
>
>
