Received: from eggs.gnu.org ([2001:4830:134:3::10]:47741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvAM-0003NB-Ox
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvAL-00037B-Q8
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:23:18 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123020820.1288-16-f4bug@amsat.org>
References: <20180123020820.1288-1-f4bug@amsat.org>
	<20180123020820.1288-16-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:22:45 -0800
Message-ID: <CAKmqyKOanfqL7c1=VNN0LrPaOPDhn++aEif=wo-y_0KFkxW7=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 15/16] hw/arm/exynos4210: add a comment
 about a very similar SDHCI (Spec. v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Kevin O'Connor <kevin@koconnor.net>, "open list:Exynos" <qemu-arm@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>

On Mon, Jan 22, 2018 at 6:08 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/arm/exynos4210.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index d89322c7ea..06f9d1ffa4 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -377,6 +377,18 @@ Exynos4210State *exynos4210_init(MemoryRegion *syste=
m_mem)
>          BlockBackend *blk;
>          DriveInfo *di;
>
> +        /* Compatible with:
> +         * - SD Host Controller Specification Version 2.0
> +         * - SDIO Specification Version 2.0
> +         * - MMC Specification Version 4.3
> +         * - SDMA
> +         * - ADMA2
> +         *
> +         * As this part of the Exynos4210 is not publically available,
> +         * we used the "HS-MMC Controller S3C2416X RISC Microprocessor"
> +         * public datasheet which is very similar (implementing
> +         * MMC Specification Version 4.0 being the only difference noted=
)
> +         */
>          dev =3D qdev_create(NULL, TYPE_SYSBUS_SDHCI);
>          qdev_prop_set_uint64(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITI=
ES);
>          qdev_init_nofail(dev);
> --
> 2.15.1
>
>
