Received: from eggs.gnu.org ([208.118.235.92]:52915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf4Jr-0003CY-Gi
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf4Jo-0006gb-5A
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:49:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gf4Jn-0006g9-TU
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:49:56 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-7-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <70311c4e-5f73-ca49-3f62-4ef9f0930acc@redhat.com>
Date: Thu, 3 Jan 2019 15:49:49 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-7-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 06/25] hw/display: make edid
 configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

On 2018-12-27 07:34, Yang Zhong wrote:
> Use CONFIG_EDID to make edid-generate.c and edid-region.c
> configurable.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/pci.mak  | 1 +
>  hw/display/Makefile.objs | 4 +---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> index 6c7be12779..171bdf48bc 100644
> --- a/default-configs/pci.mak
> +++ b/default-configs/pci.mak
> @@ -47,3 +47,4 @@ CONFIG_VGA_PCI=y
>  CONFIG_BOCHS_DISPLAY=y
>  CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
>  CONFIG_ROCKER=y
> +CONFIG_EDID=y
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index 97acd5b6cb..a8e23c8501 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -1,4 +1,4 @@
> -common-obj-y += edid-generate.o
> +common-obj-$(CONFIG_EDID) += edid-generate.o edid-region.o
>  
>  common-obj-$(CONFIG_FW_CFG_DMA) += ramfb.o
>  common-obj-$(CONFIG_FW_CFG_DMA) += ramfb-standalone.o
> @@ -15,12 +15,10 @@ common-obj-$(CONFIG_SSD0323) += ssd0323.o
>  common-obj-$(CONFIG_XEN) += xenfb.o
>  
>  common-obj-$(CONFIG_VGA_PCI) += vga-pci.o
> -common-obj-$(CONFIG_VGA_PCI) += edid-region.o
>  common-obj-$(CONFIG_VGA_ISA) += vga-isa.o
>  common-obj-$(CONFIG_VGA_ISA_MM) += vga-isa-mm.o
>  common-obj-$(CONFIG_VMWARE_VGA) += vmware_vga.o
>  common-obj-$(CONFIG_BOCHS_DISPLAY) += bochs-display.o
> -common-obj-$(CONFIG_BOCHS_DISPLAY) += edid-region.o
>  
>  common-obj-$(CONFIG_BLIZZARD) += blizzard.o
>  common-obj-$(CONFIG_EXYNOS4) += exynos4210_fimd.o

Reviewed-by: Thomas Huth <thuth@redhat.com>
