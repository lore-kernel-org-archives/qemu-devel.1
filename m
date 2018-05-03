Received: from eggs.gnu.org ([2001:4830:134:3::10]:54425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEGe3-0000Ky-A7
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEGe2-0000Pe-JV
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:59:47 -0400
MIME-Version: 1.0
References: <20180503115620.10596-1-edgar.iglesias@gmail.com>
	<20180503115620.10596-3-edgar.iglesias@gmail.com>
In-Reply-To: <20180503115620.10596-3-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 15:59:18 +0000
Message-ID: <CAKmqyKPYuyHS46XXgNLBZh146=h4mScBQAAdiSxR7HxnK2YDTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/2] xlnx-zynqmp: Swap Cortex-R5 for
 Cortex-R5F
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Iglesias <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>

On Thu, May 3, 2018 at 4:56 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
wrote:

> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

> The ZynqMP has Cortex-R5Fs with the optional FPU enabled.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   hw/arm/xlnx-zynqmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 505253e0d2..efeb53c732 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -116,7 +116,7 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState
*s, const char *boot_cpu,
>           char *name;

>           object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
> -                          "cortex-r5-" TYPE_ARM_CPU);
> +                          "cortex-r5f-" TYPE_ARM_CPU);
>           object_property_add_child(OBJECT(s), "rpu-cpu[*]",
>                                     OBJECT(&s->rpu_cpu[i]), &error_abort);

> --
> 2.14.1
