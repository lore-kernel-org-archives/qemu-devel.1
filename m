Received: from eggs.gnu.org ([208.118.235.92]:35755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfOJA-0003Xf-5A
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 07:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfOJ6-0005i4-N7
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 07:10:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gfOJ6-0005dJ-DE
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 07:10:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so970075wmd.1
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 04:10:27 -0800 (PST)
References: <20190104104749.5314-1-edgar.iglesias@gmail.com>
	<20190104104749.5314-2-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ae299994-887b-395c-880c-8c69a02e2ef3@redhat.com>
Date: Fri, 4 Jan 2019 13:10:23 +0100
MIME-Version: 1.0
In-Reply-To: <20190104104749.5314-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] hw/arm: versal: Plug memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, luc.michel@greensocs.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On 1/4/19 11:47 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Plug a couple of "board creation time" memory leaks.
> 

Fixes 6f16da53ffe

> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/xlnx-versal-virt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index c6feeac532..f95fde2309 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -130,6 +130,7 @@ static void fdt_add_gic_nodes(VersalVirt *s)
>                                   2, MM_GIC_APU_REDIST_0_SIZE);
>      qemu_fdt_setprop_cell(s->fdt, nodename, "#interrupt-cells", 3);
>      qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "arm,gic-v3");
> +    g_free(nodename);
>  }
>  
>  static void fdt_add_timer_nodes(VersalVirt *s)
> @@ -364,6 +365,7 @@ static void create_virtio_regions(VersalVirt *s)
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
>          mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>          memory_region_add_subregion(&s->soc.mr_ps, base, mr);
> +        g_free(name);
>      }
>  
>      for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
> 
