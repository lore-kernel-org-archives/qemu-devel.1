Received: from eggs.gnu.org ([209.51.188.92]:52657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpKY7-0003cl-5J
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpKY5-0001gX-VD
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:11:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpKY5-0001RR-Li
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:11:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so4978298wrs.10
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 14:10:19 -0800 (PST)
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-44-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3e4a6b11-cd87-7596-b151-f2b86426b301@redhat.com>
Date: Thu, 31 Jan 2019 23:10:16 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-44-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 43/52] i2c: express dependencies with
 Kconfig
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

Hi Paolo,

On 1/25/19 11:07 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20190123065618.3520-38-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/i386-softmmu.mak | 2 --
>  hw/Makefile.objs                 | 2 +-
>  hw/audio/Kconfig                 | 1 +
>  hw/display/Kconfig               | 3 +++
>  hw/gpio/Kconfig                  | 1 +
>  hw/i2c/Kconfig                   | 6 ++++++
>  hw/i386/Kconfig                  | 1 +
>  hw/input/Kconfig                 | 1 +
>  hw/isa/Kconfig                   | 1 +
>  hw/misc/Kconfig                  | 4 ++++
>  hw/timer/Kconfig                 | 3 +++
>  11 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 9eb9a5e..4aa04e4 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -22,8 +22,6 @@ CONFIG_NVDIMM=y
>  CONFIG_ACPI_NVDIMM=y
>  CONFIG_PXB=y
>  CONFIG_ACPI_VMGENID=y
> -CONFIG_SMBUS_EEPROM=y
> -CONFIG_I2C=y
>  CONFIG_PCI_DEVICES=y
>  
>  # Boards:
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index e2fcd6a..225f6cc 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -10,7 +10,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += display/
>  devices-dirs-$(CONFIG_SOFTMMU) += dma/
>  devices-dirs-$(CONFIG_SOFTMMU) += gpio/
>  devices-dirs-$(CONFIG_HYPERV) += hyperv/
> -devices-dirs-$(CONFIG_SOFTMMU) += i2c/
> +devices-dirs-$(CONFIG_I2C) += i2c/
>  devices-dirs-$(CONFIG_SOFTMMU) += ide/
>  devices-dirs-$(CONFIG_SOFTMMU) += input/
>  devices-dirs-$(CONFIG_SOFTMMU) += intc/
> diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
> index 01aea55..e9c6fed 100644
> --- a/hw/audio/Kconfig
> +++ b/hw/audio/Kconfig
> @@ -40,6 +40,7 @@ config PCSPK
>  
>  config WM8750
>      bool
> +    depends on I2C
>  
>  config PL041
>      bool
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 64a5764..66044ca 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -24,9 +24,11 @@ config PL110
>  
>  config SII9022
>      bool
> +    depends on I2C
>  
>  config SSD0303
>      bool
> +    depends on I2C
>  
>  config SSD0323
>      bool
> @@ -71,6 +73,7 @@ config MILKYMIST_TMU2
>  
>  config SM501
>      bool
> +    depends on I2C
>  
>  config TCX
>      bool
> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
> index d0a4abf..9227cb5 100644
> --- a/hw/gpio/Kconfig
> +++ b/hw/gpio/Kconfig
> @@ -1,5 +1,6 @@
>  config MAX7310
>      bool
> +    depends on I2C
>  
>  config PL061
>      bool
> diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
> index d6d4402..74c9328 100644
> --- a/hw/i2c/Kconfig
> +++ b/hw/i2c/Kconfig
> @@ -3,18 +3,24 @@ config I2C
>  
>  config SMBUS_EEPROM
>      bool
> +    depends on I2C


Can we have:

  config SMBUS
      bool
      select I2C

  config SMBUS_EEPROM
      bool
      select SMBUS

(or 'depends on')

>  
>  config DDC
>      bool
> +    depends on I2C
>  
>  config VERSATILE_I2C
>      bool
> +    select I2C
>  
>  config ACPI_SMBUS
>      bool
> +    select I2C

       select SMBUS

>  
>  config BITBANG_I2C
>      bool
> +    select I2C
>  
>  config IMX_I2C
>      bool
> +    select I2C
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 8814b7c..966c97c 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -27,6 +27,7 @@ config PC_ACPI
>      select ACPI_X86
>      select ACPI_CPU_HOTPLUG
>      select ACPI_MEMORY_HOTPLUG
> +    select SMBUS_EEPROM
>      depends on ACPI_SMBUS
>  
>  config I440FX
> diff --git a/hw/input/Kconfig b/hw/input/Kconfig
> index bdb4237..ec014a9 100644
> --- a/hw/input/Kconfig
> +++ b/hw/input/Kconfig
> @@ -3,6 +3,7 @@ config ADB
>  
>  config LM832X
>      bool
> +    depends on I2C
>  
>  config PCKBD
>      bool
> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> index 6f0812d..fcd87b4 100644
> --- a/hw/isa/Kconfig
> +++ b/hw/isa/Kconfig
> @@ -19,6 +19,7 @@ config PIIX4
>  config VT82C686
>      bool
>      select ISA_BUS
> +    select ACPI_SMBUS
>  
>  config SMC37C669
>      bool
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index ca051fb..0680d1e 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -7,9 +7,11 @@ config MAX111X
>  
>  config TMP105
>      bool
> +    depends on I2C
>  
>  config TMP421
>      bool
> +    depends on I2C
>  
>  config ISA_DEBUG
>      bool
> @@ -34,6 +36,7 @@ config EDU
>  
>  config PCA9552
>      bool
> +    depends on I2C
>  
>  config PL310
>      bool
> @@ -100,3 +103,4 @@ config PVPANIC
>  
>  config AUX
>      bool
> +    select I2C
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index 7dbc121..e1a6e74 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -9,6 +9,7 @@ config A9_GTIMER
>  
>  config DS1338
>      bool
> +    depends on I2C
>  
>  config HPET
>      bool
> @@ -18,6 +19,7 @@ config I8254
>  
>  config M41T80
>      bool
> +    depends on I2C
>  
>  config M48T59
>      bool
> @@ -27,6 +29,7 @@ config PL031
>  
>  config TWL92230
>      bool
> +    depends on I2C
>  
>  config XLNX_ZYNQMP
>      bool
> 
