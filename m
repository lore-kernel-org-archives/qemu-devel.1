Received: from eggs.gnu.org ([2001:4830:134:3::10]:52404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gL7p5-0002lv-Mw
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gL7p1-0007Cq-Ht
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:31:47 -0500
Date: Fri, 9 Nov 2018 15:30:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181109153048.34fa61f2@redhat.com>
In-Reply-To: <20181105014047.26447-10-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-10-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 09/24] hw: i386: Move PCI host
 definitions to pci_host.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

On Mon,  5 Nov 2018 02:40:32 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> The PCI hole properties are not pc or i386 specific. They belong to the
> PCI host header instead.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  include/hw/i386/pc.h      | 5 -----
>  include/hw/pci/pci_host.h | 6 ++++++
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index fed136fcdd..bbbdb33ea3 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -182,11 +182,6 @@ void pc_acpi_init(const char *default_dsdt);
>  
>  void pc_guest_info_init(PCMachineState *pcms);
>  
> -#define PCI_HOST_PROP_PCI_HOLE_START   "pci-hole-start"
> -#define PCI_HOST_PROP_PCI_HOLE_END     "pci-hole-end"
> -#define PCI_HOST_PROP_PCI_HOLE64_START "pci-hole64-start"
> -#define PCI_HOST_PROP_PCI_HOLE64_END   "pci-hole64-end"
> -#define PCI_HOST_PROP_PCI_HOLE64_SIZE  "pci-hole64-size"
>  #define PCI_HOST_BELOW_4G_MEM_SIZE     "below-4g-mem-size"
>  #define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
>  
> diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> index ba31595fc7..e343f4d9ca 100644
> --- a/include/hw/pci/pci_host.h
> +++ b/include/hw/pci/pci_host.h
> @@ -38,6 +38,12 @@
>  #define PCI_HOST_BRIDGE_GET_CLASS(obj) \
>       OBJECT_GET_CLASS(PCIHostBridgeClass, (obj), TYPE_PCI_HOST_BRIDGE)
>  
> +#define PCI_HOST_PROP_PCI_HOLE_START   "pci-hole-start"
> +#define PCI_HOST_PROP_PCI_HOLE_END     "pci-hole-end"
> +#define PCI_HOST_PROP_PCI_HOLE64_START "pci-hole64-start"
> +#define PCI_HOST_PROP_PCI_HOLE64_END   "pci-hole64-end"
> +#define PCI_HOST_PROP_PCI_HOLE64_SIZE  "pci-hole64-size"
these are pc/q53 machine specific properties and do not belong here


> +
>  struct PCIHostState {
>      SysBusDevice busdev;
>  
