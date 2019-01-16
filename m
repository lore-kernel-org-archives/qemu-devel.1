Received: from eggs.gnu.org ([209.51.188.92]:54744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjjIN-0001R7-Kp
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjjIL-0004Wl-Ac
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:23:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjjIK-00048s-Ur
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:23:41 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-23-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <629e41a6-0408-d8d9-df5e-d388d97c19e5@redhat.com>
Date: Wed, 16 Jan 2019 12:23:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-23-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 22/37] hw/pci/Makefile.objs: make
 pcie configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 2019-01-15 15:10, Yang Zhong wrote:
> Make pcie splited from pci and make it configurable.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/pci.mak | 1 +
>  hw/pci/Kconfig          | 3 +++
>  hw/pci/Makefile.objs    | 5 +++--
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> index c1b64922b9..553b1905de 100644
> --- a/default-configs/pci.mak
> +++ b/default-configs/pci.mak
> @@ -1,4 +1,5 @@
>  CONFIG_PCI=y
> +CONFIG_PCIE=y
>  # For now, CONFIG_IDE_CORE requires ISA, so we enable it here
>  CONFIG_ISA_BUS=y
>  CONFIG_VIRTIO_PCI=y
> diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
> index d3d2205577..a717a26995 100644
> --- a/hw/pci/Kconfig
> +++ b/hw/pci/Kconfig
> @@ -1,2 +1,5 @@
>  config PCI
>      bool
> +
> +config PCIE
> +    bool
> diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
> index 9f905e6344..a995795a47 100644
> --- a/hw/pci/Makefile.objs
> +++ b/hw/pci/Makefile.objs
> @@ -2,8 +2,9 @@ common-obj-$(CONFIG_PCI) += pci.o pci_bridge.o
>  common-obj-$(CONFIG_PCI) += msix.o msi.o
>  common-obj-$(CONFIG_PCI) += shpc.o
>  common-obj-$(CONFIG_PCI) += slotid_cap.o
> -common-obj-$(CONFIG_PCI) += pci_host.o pcie_host.o
> -common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o pcie_port.o
> +common-obj-$(CONFIG_PCI) += pci_host.o
> +common-obj-$(CONFIG_PCIE) += pcie.o pcie_aer.o
> +common-obj-$(CONFIG_PCIE) += pcie_port.o pcie_host.o
>  
>  common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
>  common-obj-$(CONFIG_ALL) += pci-stub.o
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
