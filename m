Received: from eggs.gnu.org ([2001:4830:134:3::10]:51058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eD6wu-0006dR-M4
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 05:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eD6wp-0001g9-7t
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 05:54:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eD6wp-0001f6-1L
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 05:54:07 -0500
Date: Fri, 10 Nov 2017 11:53:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171110115357.42672a46.cohuck@redhat.com>
In-Reply-To: <20171109154645.70920-1-marcel@redhat.com>
References: <20171109154645.70920-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V5] hw/pcie-pci-bridge: restrict to X86 and
 ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, thuth@redhat.com, zuban32s@gmail.com

On Thu,  9 Nov 2017 17:46:45 +0200
Marcel Apfelbaum <marcel@redhat.com> wrote:

> The PCIE-PCI bridge is specific to "pure" PCIe systems
> (on QEMU we have X86 and ARM), it does not make sense to
> have it in other archs.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
> 
> V4 -> V5
>   - Since all other tries failed, conditioned the
>     device on the PCIe Root Port.
> 
> V3 -> V4:
>  - Move the config line to pci.mak  (Thomas)
> 
> V2 -> V3:
>  - Another tweak in subject s/if/it (Cornelia) 
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
> 
>  hw/pci-bridge/Makefile.objs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
> index 666db37da2..1b05023662 100644
> --- a/hw/pci-bridge/Makefile.objs
> +++ b/hw/pci-bridge/Makefile.objs
> @@ -1,5 +1,5 @@
> -common-obj-y += pci_bridge_dev.o pcie_pci_bridge.o
> -common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o
> +common-obj-y += pci_bridge_dev.o
> +common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o pcie_pci_bridge.o
>  common-obj-$(CONFIG_PXB) += pci_expander_bridge.o
>  common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
>  common-obj-$(CONFIG_IOH3420) += ioh3420.o

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
