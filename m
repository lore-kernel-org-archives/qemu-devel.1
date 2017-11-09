Received: from eggs.gnu.org ([2001:4830:134:3::10]:59306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCmDl-0006fI-OW
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCmDk-00038n-SV
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:46:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eCmDk-00037L-MS
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:46:12 -0500
References: <20171109124312.117600-1-marcel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <44b9f472-ef9f-712e-62c3-419a4fdf9d8f@redhat.com>
Date: Thu, 9 Nov 2017 13:46:05 +0100
MIME-Version: 1.0
In-Reply-To: <20171109124312.117600-1-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2] hw/pcie-pci-bridge: restrict to X86 and
 ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, zuban32s@gmail.com, cohuck@redhat.com

On 09.11.2017 13:43, Marcel Apfelbaum wrote:
> The PCIE-PCI bridge is specific to "pure" PCIe systems
> (on QEMU we have X86 and ARM), it does not make sense to
> have if in other archs.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
> 
> V1 -> V2:
>  Addressed Thomas and Cornelia comments:
>  - Conditioned the pcie-pci-bridge compilation on
>    the PCIe Root CONFIG_PCIE_PORT
>  - Tweaked subject PCI -> PCIe
> 
>  Thanks,
>  Marcel
> 
>  hw/pci-bridge/Makefile.objs | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
> index 666db37da2..83539f02e5 100644
> --- a/hw/pci-bridge/Makefile.objs
> +++ b/hw/pci-bridge/Makefile.objs
> @@ -1,8 +1,10 @@
> -common-obj-y += pci_bridge_dev.o pcie_pci_bridge.o
> +common-obj-y += pci_bridge_dev.o
>  common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o
>  common-obj-$(CONFIG_PXB) += pci_expander_bridge.o
> +common-obj-$(CONFIG_PCIE_PCI_BRIDGE) += pcie_pci_bridge.o
>  common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
>  common-obj-$(CONFIG_IOH3420) += ioh3420.o
>  common-obj-$(CONFIG_I82801B11) += i82801b11.o
>  # NewWorld PowerMac
>  common-obj-$(CONFIG_DEC_PCI) += dec.o
> +CONFIG_PCIE_PCI_BRIDGE=$(CONFIG_PCIE_PORT)

Shouldn't that last line rather go into default-configs/pci.mak instead?
AFAIK we normally don't do "^CONFIG_xxx=" in normal Makefiles ... ?

 Thomas
