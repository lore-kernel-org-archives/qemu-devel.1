Received: from eggs.gnu.org ([2001:4830:134:3::10]:33743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee95N-0003UP-Nn
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee94T-0001Ly-CQ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:38:41 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123020820.1288-15-f4bug@amsat.org>
References: <20180123020820.1288-1-f4bug@amsat.org>
	<20180123020820.1288-15-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 16:37:13 -0800
Message-ID: <CAKmqyKOP13qWi4a9376zFEM7_E8YBvmzH=FvL0LHE=AHDivUNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 14/16] hw/arm/exynos4210: access the
 64-bit capareg with qdev_prop_set_uint64()
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
> We only set a 32-bit value, but this is a good practice in case this
> code is used as reference.
>
> (missed in 5efc9016e52)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/arm/exynos4210.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index e8e1d81e62..d89322c7ea 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -378,7 +378,7 @@ Exynos4210State *exynos4210_init(MemoryRegion *system=
_mem)
>          DriveInfo *di;
>
>          dev =3D qdev_create(NULL, TYPE_SYSBUS_SDHCI);
> -        qdev_prop_set_uint32(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITI=
ES);
> +        qdev_prop_set_uint64(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITI=
ES);
>          qdev_init_nofail(dev);
>
>          busdev =3D SYS_BUS_DEVICE(dev);
> --
> 2.15.1
>
>
