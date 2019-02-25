Received: from eggs.gnu.org ([209.51.188.92]:40125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gyBsP-00079b-6q
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 03:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gyBsO-0005aW-6C
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 03:44:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gyBsN-0005Z6-Vb
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 03:44:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id o17so8898438wrw.3
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 00:44:39 -0800 (PST)
Date: Mon, 25 Feb 2019 09:44:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190225084428.c7qon3btox2jvxq2@steredhat>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-18-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549562254-41157-18-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/51] i386: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Yang Zhong <yang.zhong@intel.com>, thuth@redhat.com, philmd@redhat.com

On Thu, Feb 07, 2019 at 06:57:00PM +0100, Paolo Bonzini wrote:
> This way, the default-configs file only need to specify the boards
> and any optional devices.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Message-Id: <20190123065618.3520-37-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/i386-softmmu.mak | 45 ++++++++----------------------------
>  hw/acpi/Kconfig                  |  3 +++
>  hw/i2c/Makefile.objs             |  2 +-
>  hw/i386/Kconfig                  | 50 ++++++++++++++++++++++++++++++++++++++++
>  hw/i386/Makefile.objs            |  5 ++--
>  hw/isa/Kconfig                   |  1 +
>  hw/pci-host/Kconfig              |  4 ++++
>  hw/tpm/Kconfig                   |  2 ++
>  8 files changed, 73 insertions(+), 39 deletions(-)
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 54b571f..ed234c1 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -1,12 +1,6 @@
>  # Default configuration for i386-softmmu
>  
> -CONFIG_PCI=y
> -CONFIG_PCI_DEVICES=y
> -CONFIG_ISA_BUS=y
>  include hyperv.mak
> -CONFIG_TEST_DEVICES=y
> -CONFIG_VGA_ISA=y
> -CONFIG_VMWARE_VGA=y
>  CONFIG_VMXNET3_PCI=y
>  CONFIG_VIRTIO_VGA=y
>  CONFIG_IPMI=y
> @@ -14,49 +8,28 @@ CONFIG_IPMI_LOCAL=y
>  CONFIG_IPMI_EXTERN=y
>  CONFIG_ISA_IPMI_KCS=y
>  CONFIG_ISA_IPMI_BT=y
> -CONFIG_I8254=y
> -CONFIG_ACPI=y
> -CONFIG_ACPI_X86=y
> -CONFIG_ACPI_X86_ICH=y
> -CONFIG_ACPI_MEMORY_HOTPLUG=y
> -CONFIG_ACPI_CPU_HOTPLUG=y
> -CONFIG_APM=y
> -CONFIG_I8257=y
> -CONFIG_IDE_ISA=y
> -CONFIG_IDE_PIIX=y
> +
> +# Optional devices:
> +#
>  CONFIG_HPET=y
>  CONFIG_APPLESMC=y
> -CONFIG_I8259=y
>  CONFIG_PFLASH_CFI01=y
> -CONFIG_MC146818RTC=y
> -CONFIG_PCI_PIIX=y
>  CONFIG_ISA_DEBUG=y
>  CONFIG_ISA_TESTDEV=y
> -CONFIG_VMPORT=y
> +CONFIG_TEST_DEVICES=y
>  CONFIG_SGA=y
> -CONFIG_LPC_ICH9=y
> -CONFIG_PCI_EXPRESS=y
> -CONFIG_PCI_EXPRESS_Q35=y
> -CONFIG_APIC=y
> -CONFIG_IOAPIC=y
>  CONFIG_PVPANIC=y
>  CONFIG_MEM_DEVICE=y
> -CONFIG_DIMM=y
>  CONFIG_NVDIMM=y
>  CONFIG_ACPI_NVDIMM=y
> -CONFIG_XIO3130=y
> -CONFIG_IOH3420=y
> -CONFIG_I82801B11=y
> -CONFIG_SMBIOS=y
>  CONFIG_PXB=y
>  CONFIG_ACPI_VMGENID=y
> -CONFIG_ACPI_SMBUS=y
>  CONFIG_SMBUS_EEPROM=y
> -CONFIG_FW_CFG_DMA=y
>  CONFIG_I2C=y
> -CONFIG_VTD=y
> -CONFIG_AMD_IOMMU=y
> -CONFIG_PAM=y
> -CONFIG_PC=y
> +CONFIG_PCI_DEVICES=y
> +
> +# Boards:
> +#
> +CONFIG_ISAPC=y
>  CONFIG_I440FX=y
>  CONFIG_Q35=y
> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> index c485a34..035a28f 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -3,15 +3,18 @@ config ACPI
>  
>  config ACPI_X86
>      bool
> +    select ACPI
>  
>  config ACPI_X86_ICH
>      bool
> +    select ACPI_X86
>  
>  config ACPI_CPU_HOTPLUG
>      bool
>  
>  config ACPI_MEMORY_HOTPLUG
>      bool
> +    select MEM_DEVICE
>  
>  config ACPI_NVDIMM
>      bool
> diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
> index cecee48..aaa3997 100644
> --- a/hw/i2c/Makefile.objs
> +++ b/hw/i2c/Makefile.objs
> @@ -2,7 +2,7 @@ common-obj-$(CONFIG_I2C) += core.o smbus.o
>  common-obj-$(CONFIG_SMBUS_EEPROM) += smbus_eeprom.o
>  common-obj-$(CONFIG_DDC) += i2c-ddc.o
>  common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
> -common-obj-$(CONFIG_ACPI_X86) += smbus_ich9.o
> +common-obj-$(CONFIG_ACPI_X86_ICH) += smbus_ich9.o
>  common-obj-$(CONFIG_ACPI_SMBUS) += pm_smbus.o
>  common-obj-$(CONFIG_BITBANG_I2C) += bitbang_i2c.o
>  common-obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 0f94ae1..daf2015 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -7,16 +7,65 @@ config PC
>      imply QXL
>      imply SEV
>      imply TPM_TIS
> +    select I8259
> +    select I8254
> +    select PCSPK
> +    select I82374
> +    select I8257
> +    select MC146818RTC
> +
> +config PC_PCI
> +    bool
> +    select APIC
> +    select IOAPIC
> +    select APM
> +    select PC
> +
> +config PC_ACPI
> +    bool
> +    select ACPI_X86
> +    select ACPI_CPU_HOTPLUG
> +    select ACPI_MEMORY_HOTPLUG
> +    depends on ACPI_SMBUS
>  
>  config I440FX
>      bool
> +    select PC_PCI
> +    select PC_ACPI
> +    select ACPI_SMBUS
> +    select PCI_PIIX
> +    select FDC

Should we move "select FDC" under "config PC"?

I'm not able to build the Q35 machine without enable FDC, since some fdc
functions are used in hw/i386/pc.c (eg. isa_fdc_get_drive_type())

Thanks,
Stefano
