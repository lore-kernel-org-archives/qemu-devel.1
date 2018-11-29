Received: from eggs.gnu.org ([2001:4830:134:3::10]:49346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gSTJ3-0000r6-Oa
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gSTJ3-0008Aq-4P
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:53:05 -0500
MIME-Version: 1.0
References: <20181129163655.20370-1-edgar.iglesias@gmail.com>
	<20181129163655.20370-3-edgar.iglesias@gmail.com>
In-Reply-To: <20181129163655.20370-3-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Nov 2018 12:52:36 -0800
Message-ID: <CAKmqyKPu-8T=vxdr6fN+2iZMBhBqAu60M7YuRkLnCySaPGqK4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/4] hw/arm: versal: Reduce number of
 virtio-mmio instances
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

On Thu, Nov 29, 2018 at 8:37 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Reduce number of virtio-mmio instances. This is in preparation
> for correcting the interrupt setup for Versal.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/xlnx-versal-virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 41b8d801c8..2ed6ee9934 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -342,7 +342,7 @@ static void *versal_virt_get_dtb(const struct arm_boot_info *binfo,
>      return board->fdt;
>  }
>
> -#define NUM_VIRTIO_TRANSPORT 32
> +#define NUM_VIRTIO_TRANSPORT 8
>  static void create_virtio_regions(VersalVirt *s)
>  {
>      int virtio_mmio_size = 0x200;
> --
> 2.17.1
>
>
