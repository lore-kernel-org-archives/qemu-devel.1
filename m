Received: from eggs.gnu.org ([209.51.188.92]:48413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gp7pQ-00053X-FV
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gp7pO-0001pM-IC
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:36:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gp7pM-0001oG-Ii
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:36:06 -0500
References: <20190131073234.18037-1-yang.zhong@intel.com>
	<20190131073234.18037-8-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5eb05d1b-871c-7e2d-f463-b7eb121e9be9@redhat.com>
Date: Thu, 31 Jan 2019 09:36:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190131073234.18037-8-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/27] hw/arm/Makefile.objs: CONFIG_VIRT
 created for virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 2019-01-31 08:32, Yang Zhong wrote:
> make virt code configurable and the new CONFIG_VIRT definitions
> added to the default-configs/arm-softmmu.mak to replace CONFIG_ACPI
> in arm board.

I think the patch description needs a refresh. It's CONFIG_ARM_VIRT now,
and CONFIG_ACPI is not replaced anymore.

> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 1 +
>  hw/arm/Makefile.objs            | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 107f801367..d3fc82256f 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -147,6 +147,7 @@ CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
>  CONFIG_ACPI=y
> +CONFIG_ARM_VIRT=y
>  CONFIG_SMBIOS=y
>  CONFIG_ASPEED_SOC=y
>  CONFIG_GPIO_KEY=y
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 50c7b4a927..dab3f88a7c 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -1,4 +1,5 @@
> -obj-y += boot.o virt.o sysbus-fdt.o
> +obj-y += boot.o sysbus-fdt.o
> +obj-$(CONFIG_ARM_VIRT) += virt.o
>  obj-$(CONFIG_ACPI) += virt-acpi-build.o
>  obj-$(CONFIG_DIGIC) += digic_boards.o
>  obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
> 
