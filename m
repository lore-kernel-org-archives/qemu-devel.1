Received: from eggs.gnu.org ([209.51.188.92]:35899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn36f-0003Ng-5g
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn345-0003T1-Tz
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:06:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gn345-0003SH-KO
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:06:41 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-8-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <efa50ee0-381b-ae3b-f1c5-3182a205439f@redhat.com>
Date: Fri, 25 Jan 2019 16:06:36 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-8-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/52] hw/arm/Makefile.objs: CONFIG_VIRT
 created for virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com

On 2019-01-25 11:06, Paolo Bonzini wrote:
> From: Yang Zhong <yang.zhong@intel.com>
> 
> make virt code configurable and the new CONFIG_VIRT definitions
> added to the default-configs/arm-softmmu.mak to replace CONFIG_ACPI
> in arm board.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20190123065618.3520-5-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 1 +
>  hw/arm/Makefile.objs            | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 107f801..68deb1c 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -147,6 +147,7 @@ CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
>  CONFIG_ACPI=y
> +CONFIG_VIRT=y
>  CONFIG_SMBIOS=y
>  CONFIG_ASPEED_SOC=y
>  CONFIG_GPIO_KEY=y
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 50c7b4a..41dab8a 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -1,4 +1,5 @@
> -obj-y += boot.o virt.o sysbus-fdt.o
> +obj-y += boot.o sysbus-fdt.o
> +obj-$(CONFIG_VIRT) += virt.o
>  obj-$(CONFIG_ACPI) += virt-acpi-build.o
>  obj-$(CONFIG_DIGIC) += digic_boards.o
>  obj-$(CONFIG_EXYNOS4) += exynos4_boards.o

<bikeshedding>
Maybe we should rather name that option CONFIG_ARM_VIRT, since other
targets like riscv have also a "virt" machine?
</bikeshedding>

 Thomas
