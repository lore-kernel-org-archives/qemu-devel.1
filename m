Received: from eggs.gnu.org ([209.51.188.92]:43571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn3cs-0004eV-BA
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn3cr-0000CU-AE
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:42:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gn3cr-0000A0-27
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:42:37 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-27-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <84d32e76-a6be-a1c6-5d03-2e17022649fd@redhat.com>
Date: Fri, 25 Jan 2019 16:42:23 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-27-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 26/52] hw/i2c/Makefile.objs: Create new
 CONFIG_* variables for EEPROM and ACPI controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Magnus Damm <magnus.damm@gmail.com>

On 2019-01-25 11:06, Paolo Bonzini wrote:
> Create separate variables for these components, they are used in many boards
> but not all.  This allows finer-grain selection of the included code with
> default-configs/*.mak.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20190123065618.3520-10-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/arm-softmmu.mak         | 1 +
>  default-configs/i386-softmmu.mak        | 2 ++
>  default-configs/mips-softmmu-common.mak | 2 ++
>  default-configs/ppc-softmmu.mak         | 1 +
>  hw/i2c/Makefile.objs                    | 5 +++--
>  5 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 68deb1c..caf7d7e 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -150,6 +150,7 @@ CONFIG_ACPI=y
>  CONFIG_VIRT=y
>  CONFIG_SMBIOS=y
>  CONFIG_ASPEED_SOC=y
> +CONFIG_SMBUS_EEPROM=y
>  CONFIG_GPIO_KEY=y
>  CONFIG_MSF2=y
>  CONFIG_FW_CFG_DMA=y
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 71c9f6f..15b6287 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -62,6 +62,8 @@ CONFIG_I82801B11=y
>  CONFIG_SMBIOS=y
>  CONFIG_PXB=y
>  CONFIG_ACPI_VMGENID=y
> +CONFIG_ACPI_SMBUS=y
> +CONFIG_SMBUS_EEPROM=y
>  CONFIG_FW_CFG_DMA=y
>  CONFIG_I2C=y
>  CONFIG_SEV=$(CONFIG_KVM)
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
> index 479fb4d..ded7498 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -39,3 +39,5 @@ CONFIG_I2C=y
>  CONFIG_R4K=y
>  CONFIG_MALTA=y
>  CONFIG_MIPSSIM=y
> +CONFIG_ACPI_SMBUS=y
> +CONFIG_SMBUS_EEPROM=y
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
> index 7f80f0c..52acb7c 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -36,6 +36,7 @@ CONFIG_AT24C=y
>  CONFIG_BITBANG_I2C=y
>  CONFIG_M41T80=y
>  CONFIG_VGA_CIRRUS=y
> +CONFIG_SMBUS_EEPROM=y
>  
>  # For Macs
>  CONFIG_ESCC=y
> diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
> index 37cacde..61ac50a 100644
> --- a/hw/i2c/Makefile.objs
> +++ b/hw/i2c/Makefile.objs
> @@ -1,8 +1,9 @@
> -common-obj-$(CONFIG_I2C) += core.o smbus.o smbus_eeprom.o
> +common-obj-$(CONFIG_I2C) += core.o smbus.o
> +common-obj-$(CONFIG_SMBUS_EEPROM) += smbus_eeprom.o
>  common-obj-$(CONFIG_DDC) += i2c-ddc.o
>  common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
>  common-obj-$(CONFIG_ACPI_X86) += smbus_ich9.o
> -common-obj-$(CONFIG_APM) += pm_smbus.o
> +common-obj-$(CONFIG_ACPI_SMBUS) += pm_smbus.o
>  common-obj-$(CONFIG_BITBANG_I2C) += bitbang_i2c.o
>  common-obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o
>  common-obj-$(CONFIG_IMX_I2C) += imx_i2c.o

smbus_eeprom.o is now not linked into the sh4 executables anymore. But
as far as I can see, this should be ok, since they don't use this device.

Reviewed-by: Thomas Huth <thuth@redhat.com>
