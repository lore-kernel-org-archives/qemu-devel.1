Received: from eggs.gnu.org ([209.51.188.92]:43499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpJrB-0005ey-6N
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpJr9-0005cl-EV
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:26:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpJr9-0005WN-4S
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:26:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so3068073wmd.1
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 13:26:31 -0800 (PST)
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-51-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fc7d7eaa-90c7-4c45-d885-0ce5d39bce0e@redhat.com>
Date: Thu, 31 Jan 2019 22:26:29 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-51-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 50/52] isa: express SuperIO dependencies
 with Kconfig
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

On 1/25/19 11:07 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/alpha-softmmu.mak |  5 -----
>  default-configs/ppc-softmmu.mak   |  9 ---------
>  default-configs/sh4-softmmu.mak   |  9 ++-------
>  default-configs/sh4eb-softmmu.mak |  6 ------
>  hw/isa/Kconfig                    | 21 +++++++++++++++++++++
>  5 files changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
> index f44c5bc..2ad4d40 100644
> --- a/default-configs/alpha-softmmu.mak
> +++ b/default-configs/alpha-softmmu.mak
> @@ -2,13 +2,8 @@
>  
>  CONFIG_PCI=y
>  CONFIG_PCI_DEVICES=y
> -CONFIG_SERIAL=y
> -CONFIG_SERIAL_ISA=y
>  CONFIG_I82374=y
>  CONFIG_I8254=y
> -CONFIG_I8257=y
> -CONFIG_PARALLEL=y
> -CONFIG_FDC=y
>  CONFIG_PCKBD=y
>  CONFIG_VGA_CIRRUS=y
>  CONFIG_VMWARE_VGA=y
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
> index f38c14c..87c2d6d 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -8,12 +8,10 @@ CONFIG_ISA_BUS=y
>  CONFIG_PPC4XX=y
>  CONFIG_M48T59=y
>  CONFIG_SERIAL=y
> -CONFIG_I8257=y
>  CONFIG_OPENPIC=y
>  CONFIG_PPCE500_PCI=y
>  CONFIG_PFLASH_CFI01=y
>  CONFIG_PFLASH_CFI02=y
> -CONFIG_I8259=y
>  CONFIG_XILINX=y
>  CONFIG_XILINX_ETHLITE=y
>  CONFIG_E500=y
> @@ -59,18 +57,11 @@ CONFIG_MAC_NEWWORLD=y
>  # For PReP
>  CONFIG_PREP=y
>  CONFIG_PREP_PCI=y
> -CONFIG_SERIAL_ISA=y
> -CONFIG_MC146818RTC=y
>  CONFIG_ISA_TESTDEV=y
>  CONFIG_RS6000_MC=y
> -CONFIG_PARALLEL=y
>  CONFIG_I82374=y
>  CONFIG_I82378=y
> -CONFIG_I8254=y
>  CONFIG_PCKBD=y
> -CONFIG_FDC=y
>  CONFIG_NE2000_ISA=y
>  CONFIG_PC87312=y
> -CONFIG_PCSPK=y
> -CONFIG_IDE_ISA=y
>  CONFIG_CS4231A=y
> diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
> index 9e8e487..1b4582a 100644
> --- a/default-configs/sh4-softmmu.mak
> +++ b/default-configs/sh4-softmmu.mak
> @@ -1,9 +1,8 @@
> -# Default configuration for sh4-softmmu
> +# Default configuration for sh4eb-softmmu
>  
>  CONFIG_PCI=y
>  CONFIG_PCI_DEVICES=y
>  CONFIG_SERIAL=y
> -CONFIG_SERIAL_ISA=y
>  CONFIG_PFLASH_CFI02=y
>  CONFIG_SH4=y
>  CONFIG_IDE_MMIO=y
> @@ -12,11 +11,7 @@ CONFIG_I2C=y
>  CONFIG_DDC=y
>  CONFIG_ISA_TESTDEV=y
>  CONFIG_I82378=y
> -CONFIG_I8259=y
> -CONFIG_I8254=y
> -CONFIG_PCSPK=y
>  CONFIG_I82374=y
> -CONFIG_I8257=y
> -CONFIG_MC146818RTC=y
>  CONFIG_R2D=y
>  CONFIG_SHIX=y
> +CONFIG_TEST_DEVICES=y
> diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
> index 2a26946..baed9a4 100644
> --- a/default-configs/sh4eb-softmmu.mak
> +++ b/default-configs/sh4eb-softmmu.mak
> @@ -3,7 +3,6 @@
>  CONFIG_PCI=y
>  CONFIG_PCI_DEVICES=y
>  CONFIG_SERIAL=y
> -CONFIG_SERIAL_ISA=y
>  CONFIG_PFLASH_CFI02=y
>  CONFIG_SH4=y
>  CONFIG_IDE_MMIO=y
> @@ -12,11 +11,6 @@ CONFIG_I2C=y
>  CONFIG_DDC=y
>  CONFIG_ISA_TESTDEV=y
>  CONFIG_I82378=y
> -CONFIG_I8259=y
> -CONFIG_I8254=y
> -CONFIG_PCSPK=y
>  CONFIG_I82374=y
> -CONFIG_I8257=y
> -CONFIG_MC146818RTC=y
>  CONFIG_R2D=y
>  CONFIG_SHIX=y
> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> index fcd87b4..34711d0 100644
> --- a/hw/isa/Kconfig
> +++ b/hw/isa/Kconfig
> @@ -7,26 +7,47 @@ config APM
>  config I82378
>      bool
>      select ISA_BUS
> +    select I8259
> +    select I8254
> +    select I8257
> +    select MC146818RTC
>  
>  config PC87312
>      bool
>      select ISA_BUS
> +    select I8259
> +    select I8254
> +    select I8257
> +    select MC146818RTC
> +    select SERIAL_ISA
> +    select PARALLEL
> +    select FDC
> +    select IDE_ISA
>  
>  config PIIX4
>      bool
> +    # For historical reasons, SuperIO devices are created in the board
> +    # for PIIX4.
>      select ISA_BUS
>  
>  config VT82C686
>      bool
>      select ISA_BUS
>      select ACPI_SMBUS
> +    select SERIAL_ISA
> +    select FDC
>  
>  config SMC37C669
>      bool
>      select ISA_BUS
> +    select SERIAL_ISA
> +    select PARALLEL
> +    select FDC
>  
>  config LPC_ICH9
>      bool
> +    # For historical reasons, SuperIO devices are created in the board
> +    # for ICH9.
>      select ISA_BUS
>      select ACPI_SMBUS
>      select ACPI_X86_ICH
> 

Now I see this patch, so my suggestions on patch #41 of this series go here.
