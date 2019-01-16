Received: from eggs.gnu.org ([209.51.188.92]:49642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjfJ5-0001XM-5Q
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 02:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjfJ1-0006jW-Cl
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 02:08:09 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-4-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8af053ed-ba84-6cfa-fbf0-04a3c483109a@redhat.com>
Date: Wed, 16 Jan 2019 08:07:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-4-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 03/37] hw/arm/Makefile.objs:
 CONFIG_VIRT created for virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, qemu-arm@nongnu.org

On 2019-01-15 15:10, Yang Zhong wrote:
> make virt code configurable and the new CONFIG_VIRT definitions
> added to the default-configs/arm-softmmu.mak to replace CONFIG_ACPI
> in arm board.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/arm-softmmu.mak | 2 +-
>  hw/arm/Makefile.objs            | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 2420491aac..3903d1ada3 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -147,7 +147,7 @@ CONFIG_PCIE_PORT=y
>  CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
> -CONFIG_ACPI=y
> +CONFIG_VIRT=y
>  CONFIG_SMBIOS=y
>  CONFIG_ASPEED_SOC=y
>  CONFIG_GPIO_KEY=y
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 50c7b4a927..25ff98fdbc 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -1,5 +1,5 @@
> -obj-y += boot.o virt.o sysbus-fdt.o
> -obj-$(CONFIG_ACPI) += virt-acpi-build.o
> +obj-y += boot.o sysbus-fdt.o
> +obj-$(CONFIG_VIRT) += virt.o virt-acpi-build.o
>  obj-$(CONFIG_DIGIC) += digic_boards.o
>  obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
>  obj-$(CONFIG_HIGHBANK) += highbank.o
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
