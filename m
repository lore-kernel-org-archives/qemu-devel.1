Received: from eggs.gnu.org ([2001:4830:134:3::10]:41302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8SsV-0005ym-5z
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8SsU-0000uP-CT
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:22:59 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1g8SsU-0000sU-1s
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:22:58 -0400
Received: by mail-lj1-x244.google.com with SMTP id v7-v6so11673106ljg.5
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 09:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181005160147.892-1-kraxel@redhat.com>
	<20181005160147.892-2-kraxel@redhat.com>
In-Reply-To: <20181005160147.892-2-kraxel@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 5 Oct 2018 09:22:29 -0700
Message-ID: <CAKmqyKNY+Yziwq_82Oz4yueAvYAzrOev5=0taNm6qpUFcGZcnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] display: add separate config option
 for bochs-display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Oct 5, 2018 at 9:13 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> This allows modern architectures which don't care about vga
> compatibility (risc-v for example) build bochs-display without
> including all vga emulation too.

For RISC-V we end up including pci.mak anyway for other things such as
NVMe drives. So we don't really need this, but it still seems useful.

>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  default-configs/pci.mak  | 1 +
>  hw/display/Makefile.objs | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> index de53d20ac6..6c7be12779 100644
> --- a/default-configs/pci.mak
> +++ b/default-configs/pci.mak
> @@ -44,5 +44,6 @@ CONFIG_SDHCI=y
>  CONFIG_EDU=y
>  CONFIG_VGA=y
>  CONFIG_VGA_PCI=y
> +CONFIG_BOCHS_DISPLAY=y
>  CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
>  CONFIG_ROCKER=y
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index 780a76b9f0..2a0de16a55 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -14,11 +14,11 @@ common-obj-$(CONFIG_SSD0323) += ssd0323.o
>  common-obj-$(CONFIG_XEN) += xenfb.o
>
>  common-obj-$(CONFIG_VGA_PCI) += vga-pci.o
> -common-obj-$(CONFIG_VGA_PCI) += bochs-display.o
>  common-obj-$(CONFIG_VGA_PCI) += edid-region.o
>  common-obj-$(CONFIG_VGA_ISA) += vga-isa.o
>  common-obj-$(CONFIG_VGA_ISA_MM) += vga-isa-mm.o
>  common-obj-$(CONFIG_VMWARE_VGA) += vmware_vga.o
> +common-obj-$(CONFIG_BOCHS_DISPLAY) += bochs-display.o
>
>  common-obj-$(CONFIG_BLIZZARD) += blizzard.o
>  common-obj-$(CONFIG_EXYNOS4) += exynos4210_fimd.o
> --
> 2.9.3
>
>
