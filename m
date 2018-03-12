Received: from eggs.gnu.org ([2001:4830:134:3::10]:44458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evL5i-0008Th-6R
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evL5f-0005pP-56
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:54:06 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evL5e-0005nP-Vp
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:54:03 -0400
Received: by mail-wr0-x241.google.com with SMTP id n12so4035814wra.2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 03:54:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180312094308.21716-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <18cdbf67-73ab-1cd0-abb9-7e1699dd67a3@amsat.org>
Date: Mon, 12 Mar 2018 11:54:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180312094308.21716-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/i386: make IOMMUs configurable via
 default-configs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

On 03/12/2018 10:43 AM, Paolo Bonzini wrote:
> Allow distributions to disable the Intel and/or AMD IOMMU devices.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>         v1->v2: don't include x86-iommu.o unconditionally
> 
>  default-configs/i386-softmmu.mak   | 2 ++
>  default-configs/x86_64-softmmu.mak | 2 ++
>  hw/i386/Makefile.objs              | 4 ++--
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 3326e3e0bb..9e5a29fa4a 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -63,3 +63,5 @@ CONFIG_PXB=y
>  CONFIG_ACPI_VMGENID=y
>  CONFIG_FW_CFG_DMA=y
>  CONFIG_I2C=y
> +CONFIG_VTD=y
> +CONFIG_AMD_IOMMU=y
> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
> index 1c6cda1d9a..7baf91b921 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -63,3 +63,5 @@ CONFIG_PXB=y
>  CONFIG_ACPI_VMGENID=y
>  CONFIG_FW_CFG_DMA=y
>  CONFIG_I2C=y
> +CONFIG_VTD=y
> +CONFIG_AMD_IOMMU=y
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index fd279e7584..fa87a14152 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -2,8 +2,8 @@ obj-$(CONFIG_KVM) += kvm/
>  obj-y += multiboot.o
>  obj-y += pc.o pc_piix.o pc_q35.o
>  obj-y += pc_sysfw.o
> -obj-y += x86-iommu.o intel_iommu.o
> -obj-y += amd_iommu.o
> +obj-$(CONFIG_VTD) += x86-iommu.o intel_iommu.o
> +obj-$(CONFIG_AMD_IOMMU) += x86-iommu.o amd_iommu.o
>  obj-$(CONFIG_XEN) += ../xenpv/ xen/
>  obj-$(CONFIG_VMPORT) += vmport.o
>  obj-$(CONFIG_VMMOUSE) += vmmouse.o
> 
