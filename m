Received: from eggs.gnu.org ([209.51.188.92]:42138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpJmn-0001bE-Bv
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:22:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpJmm-00049l-A1
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:22:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpJmm-00049Z-47
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:22:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so4000639wmb.3
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 13:22:11 -0800 (PST)
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-42-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1bd28f71-6c37-2739-f181-4d8796fedb2c@redhat.com>
Date: Thu, 31 Jan 2019 22:22:09 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-42-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 41/52] isa: express dependencies with
 kconfig
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
> Message-Id: <20190123065618.3520-36-yang.zhong@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/i386-softmmu.mak | 9 ---------
>  hw/audio/Kconfig                 | 2 ++
>  hw/block/Kconfig                 | 2 ++
>  hw/char/Kconfig                  | 6 ++++++
>  hw/display/Kconfig               | 3 +++
>  hw/dma/Kconfig                   | 1 +
>  hw/i386/Kconfig                  | 1 +
>  hw/ide/Kconfig                   | 1 +
>  hw/input/Kconfig                 | 2 ++
>  hw/isa/Kconfig                   | 7 +++++++
>  hw/misc/Kconfig                  | 4 ++++
>  hw/net/Kconfig                   | 3 +++
>  hw/sparc64/Kconfig               | 1 +
>  hw/watchdog/Kconfig              | 2 ++
>  14 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 4073c62..8e6a810 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -8,19 +8,12 @@ CONFIG_VGA_ISA=y
>  CONFIG_VMWARE_VGA=y
>  CONFIG_VMXNET3_PCI=y
>  CONFIG_VIRTIO_VGA=y
> -CONFIG_VMMOUSE=y
>  CONFIG_IPMI=y
>  CONFIG_IPMI_LOCAL=y
>  CONFIG_IPMI_EXTERN=y
>  CONFIG_ISA_IPMI_KCS=y
>  CONFIG_ISA_IPMI_BT=y
> -CONFIG_SERIAL=y
> -CONFIG_SERIAL_ISA=y
> -CONFIG_PARALLEL=y
>  CONFIG_I8254=y
> -CONFIG_PCSPK=y
> -CONFIG_PCKBD=y
> -CONFIG_FDC=y
>  CONFIG_ACPI=y
>  CONFIG_ACPI_X86=y
>  CONFIG_ACPI_X86_ICH=y
> @@ -30,14 +23,12 @@ CONFIG_APM=y
>  CONFIG_I8257=y
>  CONFIG_IDE_ISA=y
>  CONFIG_IDE_PIIX=y
> -CONFIG_NE2000_ISA=y
>  CONFIG_HPET=y
>  CONFIG_APPLESMC=y
>  CONFIG_I8259=y
>  CONFIG_PFLASH_CFI01=y
>  CONFIG_MC146818RTC=y
>  CONFIG_PCI_PIIX=y
> -CONFIG_WDT_IB700=y
>  CONFIG_ISA_DEBUG=y
>  CONFIG_ISA_TESTDEV=y
>  CONFIG_VMPORT=y
> diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
> index dedb513..01aea55 100644
> --- a/hw/audio/Kconfig
> +++ b/hw/audio/Kconfig
> @@ -35,6 +35,8 @@ config HDA
>  
>  config PCSPK
>      bool
> +    default y
> +    depends on I8254
>  
>  config WM8750
>      bool
> diff --git a/hw/block/Kconfig b/hw/block/Kconfig
> index f7b9d3a..dc91e67 100644
> --- a/hw/block/Kconfig
> +++ b/hw/block/Kconfig
> @@ -1,5 +1,7 @@
>  config FDC
>      bool
> +    default y
> +    depends on ISA_BUS
>  
>  config SSI_M25P80
>      bool
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 6eba69a..fc18481 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -3,6 +3,8 @@ config ESCC
>  
>  config PARALLEL
>      bool
> +    default y
> +    depends on ISA_BUS
>  
>  config PL011
>      bool
> @@ -12,11 +14,15 @@ config SERIAL
>  
>  config SERIAL_ISA
>      bool
> +    default y
> +    depends on ISA_BUS
> +    select SERIAL
>  
>  config SERIAL_PCI
>      bool
>      default y if PCI_DEVICES
>      depends on PCI
> +    select SERIAL
>  
>  config VIRTIO_SERIAL
>      bool
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index f8d63c6..64a5764 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -39,9 +39,12 @@ config VGA_PCI
>  
>  config VGA_ISA
>      bool
> +    depends on ISA_BUS
> +    select VGA
>  
>  config VGA_ISA_MM
>      bool
> +    select VGA
>  
>  config VMWARE_VGA
>      bool
> diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
> index b9ce1c5..751dec5 100644
> --- a/hw/dma/Kconfig
> +++ b/hw/dma/Kconfig
> @@ -9,6 +9,7 @@ config PL330
>  
>  config I82374
>      bool
> +    select I8257
>  
>  config I8257
>      bool
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 9a0e559..ff41be3 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -10,6 +10,7 @@ config I440FX
>  
>  config ISAPC
>      bool
> +    select ISA_BUS
>  
>  config Q35
>      bool
> diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
> index 246e27b..ab47b6a 100644
> --- a/hw/ide/Kconfig
> +++ b/hw/ide/Kconfig
> @@ -12,6 +12,7 @@ config IDE_PCI
>  
>  config IDE_ISA
>      bool
> +    depends on ISA_BUS
>      select IDE_QDEV
>  
>  config IDE_PIIX
> diff --git a/hw/input/Kconfig b/hw/input/Kconfig
> index 98a18a1..bdb4237 100644
> --- a/hw/input/Kconfig
> +++ b/hw/input/Kconfig
> @@ -6,6 +6,8 @@ config LM832X
>  
>  config PCKBD
>      bool
> +    default y
> +    depends on ISA_BUS
>  
>  config PL050
>      bool
> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> index b59d074..af68af9 100644
> --- a/hw/isa/Kconfig
> +++ b/hw/isa/Kconfig
> @@ -6,18 +6,25 @@ config APM
>  
>  config I82378
>      bool
> +    select ISA_BUS
>  
>  config PC87312
>      bool
> +    select ISA_BUS
>  
>  config PIIX4
>      bool
> +    select ISA_BUS
>  
>  config VT82C686
>      bool
> +    select ISA_BUS
>  
>  config SMC37C669
>      bool
> +    select ISA_BUS

I kinda disagree with the SuperIO generated configs here, but partly my
fault because the previous Makefile.objs missed the CONFIG_ISA_SUPERIO
(I missed to review eae2e2e96bf from Thomas where is introduced
CONFIG_SMC37C669).
So introducing ISA_SUPERIO simplifies this files and SouthBridge
devices. I'm not sure how to provide this patch:

 # generic SuperIO
 config ISA_SUPERIO
     bool
     select ISA_BUS
     select SERIAL_ISA
     select PARALLEL
     select FDC
     select IDE_ISA

 config PC87312
     bool
     select ISA_SUPERIO
     select I8259
     select I8254
     select I8257
     select MC146818RTC

 config SMC37C669
     bool
     select ISA_SUPERIO

I'll see, if the changes are trivial you can cherry-pick at the correct
place in your branch.

>  
>  config LPC_ICH9
>      bool
> +    select ISA_BUS
> +    select ACPI_X86_ICH
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index c85c085..ca051fb 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -1,5 +1,6 @@
>  config APPLESMC
>      bool
> +    depends on ISA_BUS
>  
>  config MAX111X
>      bool
> @@ -12,9 +13,11 @@ config TMP421
>  
>  config ISA_DEBUG
>      bool
> +    depends on ISA_BUS
>  
>  config SGA
>      bool
> +    depends on ISA_BUS
>  
>  config ISA_TESTDEV
>      bool
> @@ -93,6 +96,7 @@ config IOTKIT_SYSINFO
>  
>  config PVPANIC
>      bool
> +    depends on ISA_BUS
>  
>  config AUX
>      bool
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index d50e301..6d15720 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -48,6 +48,9 @@ config LAN9118
>  
>  config NE2000_ISA
>      bool
> +    default y
> +    depends on ISA_BUS
> +    depends on PCI # for NE2000State
>  
>  config OPENCORES_ETH
>      bool
> diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
> index 8c13345..41f7295 100644
> --- a/hw/sparc64/Kconfig
> +++ b/hw/sparc64/Kconfig
> @@ -1,5 +1,6 @@
>  config SUN4U
>      bool
> +    select ISA_BUS
>  
>  config NIAGARA
>      bool
> diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
> index edb3d42..35ccb72 100644
> --- a/hw/watchdog/Kconfig
> +++ b/hw/watchdog/Kconfig
> @@ -8,6 +8,8 @@ config WDT_IB6300ESB
>  
>  config WDT_IB700
>      bool
> +    default y
> +    depends on ISA_BUS
>  
>  config WDT_DIAG288
>      bool
> 
