Received: from eggs.gnu.org ([209.51.188.92]:49846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjjFz-0000N3-LX
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjjFy-0004NS-Gl
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:21:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjjFy-0004CV-4G
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:21:14 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-22-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <618d353e-94d2-6acc-1fa7-920983ec13f8@redhat.com>
Date: Wed, 16 Jan 2019 12:21:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-22-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 21/37] ide: express dependencies
 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, John Snow <jsnow@redhat.com>

On 2019-01-15 15:10, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/alpha-softmmu.mak |  2 --
>  default-configs/pci.mak           |  3 ---
>  hw/ide/Kconfig                    | 15 +++++++++++++++
>  3 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
> index 4d654eaa0b..62afa5ec16 100644
> --- a/default-configs/alpha-softmmu.mak
> +++ b/default-configs/alpha-softmmu.mak
> @@ -11,8 +11,6 @@ CONFIG_PARALLEL=y
>  CONFIG_FDC=y
>  CONFIG_PCKBD=y
>  CONFIG_VGA_CIRRUS=y
> -CONFIG_IDE_CORE=y
> -CONFIG_IDE_QDEV=y
>  CONFIG_VMWARE_VGA=y
>  CONFIG_IDE_CMD646=y
>  CONFIG_I8259=y
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> index 171bdf48bc..c1b64922b9 100644
> --- a/default-configs/pci.mak
> +++ b/default-configs/pci.mak
> @@ -23,9 +23,6 @@ CONFIG_MPTSAS_SCSI_PCI=y
>  CONFIG_RTL8139_PCI=y
>  CONFIG_E1000_PCI=y
>  CONFIG_E1000E_PCI=y
> -CONFIG_IDE_CORE=y
> -CONFIG_IDE_QDEV=y
> -CONFIG_IDE_PCI=y
>  CONFIG_AHCI=y
>  CONFIG_ESP=y
>  CONFIG_ESP_PCI=y
> diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
> index 5ec449525f..fe27705790 100644
> --- a/hw/ide/Kconfig
> +++ b/hw/ide/Kconfig
> @@ -3,33 +3,48 @@ config IDE_CORE
>  
>  config IDE_QDEV
>      bool
> +    select IDE_CORE
>  
>  config IDE_PCI
>      bool
> +    select IDE_CORE
>  
>  config IDE_ISA
>      bool
> +    select IDE_QDEV
>  
>  config IDE_PIIX
>      bool
> +    select IDE_PCI
> +    select IDE_QDEV
>  
>  config IDE_CMD646
>      bool
> +    select IDE_PCI
> +    select IDE_QDEV
>  
>  config IDE_MACIO
>      bool
> +    select IDE_QDEV
>  
>  config IDE_MMIO
>      bool
> +    select IDE_QDEV
>  
>  config IDE_VIA
>      bool
> +    select IDE_PCI
> +    select IDE_QDEV
>  
>  config MICRODRIVE
>      bool
> +    select IDE_QDEV
>  
>  config AHCI
>      bool
> +    select IDE_QDEV
>  
>  config IDE_SII3112
>      bool
> +    select IDE_PCI
> +    select IDE_QDEV
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
