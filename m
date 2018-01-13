Received: from eggs.gnu.org ([2001:4830:134:3::10]:38941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eaACl-0005DP-ID
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 20:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eaACk-00042F-Pt
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 20:01:51 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180111205626.23291-11-f4bug@amsat.org>
References: <20180111205626.23291-1-f4bug@amsat.org>
	<20180111205626.23291-11-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 12 Jan 2018 17:01:18 -0800
Message-ID: <CAKmqyKPK9nwQd959-AoV6b=Fj5YJt8CGufYQqiGau0PVQWe7Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 10/21] hw/arm/exynos4210: implement
 SDHCI Spec v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?Q?Gr=C3=A9gory_Estrade?= <gregory.estrade@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Clement Deschamps <clement.deschamps@antfield.fr>, Andrew Baumann <Andrew.Baumann@microsoft.com>

On Thu, Jan 11, 2018 at 12:56 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/arm/exynos4210.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index e8e1d81e62..0e6acac784 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -75,7 +75,6 @@
>  #define EXYNOS4210_INT_COMBINER_BASE_ADDR   0x10448000
>
>  /* SD/MMC host controllers */
> -#define EXYNOS4210_SDHCI_CAPABILITIES       0x05E80080
>  #define EXYNOS4210_SDHCI_BASE_ADDR          0x12510000
>  #define EXYNOS4210_SDHCI_ADDR(n)            (EXYNOS4210_SDHCI_BASE_ADDR =
+ \
>                                                  0x00010000 * (n))
> @@ -377,8 +376,18 @@ Exynos4210State *exynos4210_init(MemoryRegion *syste=
m_mem)
>          BlockBackend *blk;
>          DriveInfo *di;
>
> +        /* Compatible with:
> +         * - SD Host Controller Specification Version 2.0
> +         * - SDIO Specification Version 2.0
> +         * - MMC Specification Version 4.3
> +         *
> +         * - SDMA
> +         * - ADMA
> +         */
>          dev =3D qdev_create(NULL, TYPE_SYSBUS_SDHCI);
> -        qdev_prop_set_uint32(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITI=
ES);
> +        qdev_prop_set_uint8(dev, "sd-spec-version", 2);
> +        qdev_prop_set_bit(dev, "suspend", true);
> +        qdev_prop_set_bit(dev, "1v8", true);
>          qdev_init_nofail(dev);
>
>          busdev =3D SYS_BUS_DEVICE(dev);
> --
> 2.15.1
>
>
