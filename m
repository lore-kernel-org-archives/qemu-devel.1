Received: from eggs.gnu.org ([209.51.188.92]:41664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLA5j-0004TG-Tx
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLA5j-0006Ae-2N
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:29:23 -0400
MIME-Version: 1.0
References: <20190427141459.19728-1-philmd@redhat.com>
	<20190427141459.19728-2-philmd@redhat.com>
In-Reply-To: <20190427141459.19728-2-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2019 10:28:49 -0700
Message-ID: <CAKmqyKOESUfmvHY73k6NsnZ0Gr9LXuHwOUDSn2vXQGXRfmWkOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/Kconfig: Move the generic
 XLNX_ZYNQMP to the root hw/Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Sat, Apr 27, 2019 at 7:15 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The XLNX_ZYNQMP config is used in multiple subdirectories
> (timer, intc). Move it to the root hw/Kconfig.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/Kconfig       | 3 +++
>  hw/timer/Kconfig | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/Kconfig b/hw/Kconfig
> index 88b9f150070..c3c78f43eb5 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -72,3 +72,6 @@ config XILINX
>  config XILINX_AXI
>      bool
>      select PTIMER # for hw/dma/xilinx_axidma.c
> +
> +config XLNX_ZYNQMP
> +    bool
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index 51921eb63f1..eefc95f35ec 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -34,9 +34,6 @@ config TWL92230
>      bool
>      depends on I2C
>
> -config XLNX_ZYNQMP
> -    bool
> -
>  config ALTERA_TIMER
>      bool
>      select PTIMER
> --
> 2.20.1
>
>
