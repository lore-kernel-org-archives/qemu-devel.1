Received: from eggs.gnu.org ([209.51.188.92]:51602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpKVG-0000cg-AR
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpKH2-0000oJ-9X
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:53:30 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:54294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpKH0-0000nf-TI
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:53:28 -0500
Received: by mail-wm1-f51.google.com with SMTP id a62so4054523wmh.4
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 13:53:26 -0800 (PST)
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-32-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <522a9a68-8fbc-b808-1098-97377aafabb5@redhat.com>
Date: Thu, 31 Jan 2019 22:53:24 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-32-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 31/52] hw/display: make edid configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

On 1/25/19 11:06 AM, Paolo Bonzini wrote:
> From: Yang Zhong <yang.zhong@intel.com>
> 
> Use CONFIG_EDID to make edid-generate.c and edid-region.c
> configurable.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20190123065618.3520-26-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/pci.mak  | 1 +
>  hw/display/Makefile.objs | 4 +---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> index 037636f..0552190 100644
> --- a/default-configs/pci.mak
> +++ b/default-configs/pci.mak
> @@ -49,3 +49,4 @@ CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
>  CONFIG_ROCKER=y
>  CONFIG_VFIO=$(CONFIG_LINUX)
>  CONFIG_VFIO_PCI=y
> +CONFIG_EDID=y
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index 97acd5b..a8e23c8 100644
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
> 
