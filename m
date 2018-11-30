Received: from eggs.gnu.org ([2001:4830:134:3::10]:38961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gSml6-0003e4-9e
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gSml4-0000Um-0z
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:39:20 -0500
MIME-Version: 1.0
References: <20181129163655.20370-1-edgar.iglesias@gmail.com>
	<20181129163655.20370-4-edgar.iglesias@gmail.com>
In-Reply-To: <20181129163655.20370-4-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 Nov 2018 09:38:43 -0800
Message-ID: <CAKmqyKOrVy5EhWCemPfkLEYWhi7N8jbyzN98KYmVsw=Kde6KEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 3/4] hw/arm: versal: Use IRQs 111 - 118
 for virtio-mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Iglesias <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, KONRAD Frederic <frederic.konrad@adacore.com>, muhammad_bilal@mentor.com, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Luc Michel <luc.michel@greensocs.com>

On Thu, Nov 29, 2018 at 8:39 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Use IRQs 111 - 118 for virtio-mmio. The interrupts we're currently
> using 160+ are not available in the Versal GIC.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/xlnx-versal-virt.c    | 4 ++--
>  include/hw/arm/xlnx-versal.h | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 2ed6ee9934..c6feeac532 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -351,7 +351,7 @@ static void create_virtio_regions(VersalVirt *s)
>      for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
>          char *name = g_strdup_printf("virtio%d", i);;
>          hwaddr base = MM_TOP_RSVD + i * virtio_mmio_size;
> -        int irq = VERSAL_RSVD_HIGH_IRQ_FIRST + i;
> +        int irq = VERSAL_RSVD_IRQ_FIRST + i;
>          MemoryRegion *mr;
>          DeviceState *dev;
>          qemu_irq pic_irq;
> @@ -368,7 +368,7 @@ static void create_virtio_regions(VersalVirt *s)
>
>      for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
>          hwaddr base = MM_TOP_RSVD + i * virtio_mmio_size;
> -        int irq = VERSAL_RSVD_HIGH_IRQ_FIRST + i;
> +        int irq = VERSAL_RSVD_IRQ_FIRST + i;
>          char *name = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
>
>          qemu_fdt_add_subnode(s->fdt, name);
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 9da621e4b6..76fb9de391 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -75,9 +75,9 @@ typedef struct Versal {
>  #define VERSAL_GEM1_IRQ_0          58
>  #define VERSAL_GEM1_WAKE_IRQ_0     59
>
> -/* Architecturally eserved IRQs suitable for virtualization.  */
> -#define VERSAL_RSVD_HIGH_IRQ_FIRST 160
> -#define VERSAL_RSVD_HIGH_IRQ_LAST  255
> +/* Architecturally reserved IRQs suitable for virtualization.  */
> +#define VERSAL_RSVD_IRQ_FIRST 111
> +#define VERSAL_RSVD_IRQ_LAST  118
>
>  #define MM_TOP_RSVD                 0xa0000000U
>  #define MM_TOP_RSVD_SIZE            0x4000000
> --
> 2.17.1
>
>
