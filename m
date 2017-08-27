Received: from eggs.gnu.org ([2001:4830:134:3::10]:51849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dlt39-0007QH-75
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 04:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dlt36-0004jZ-3v
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 04:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dlt35-0004j3-Qc
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 04:36:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFE8A4E4C2
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 08:36:02 +0000 (UTC)
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-4-ehabkost@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <8884ab94-9921-2eef-8d4f-a50c625e0f1c@redhat.com>
Date: Sun, 27 Aug 2017 11:35:56 +0300
MIME-Version: 1.0
In-Reply-To: <20170823221445.15243-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] pci: Add INTERFACE_PCIE_DEVICE to all
 PCIe devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laine Stump <laine@redhat.com>

Hi Eduardo,

On 24/08/2017 1:14, Eduardo Habkost wrote:
> Change all devices that set is_express=1 to implement
> INTERFACE_PCIE_DEVICE.
> 

Can this interface *replace* is_express field?

Thanks,
Marcel

> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   hw/block/nvme.c                    | 4 ++++
>   hw/net/e1000e.c                    | 4 ++++
>   hw/pci-bridge/pcie_root_port.c     | 4 ++++
>   hw/pci-bridge/xio3130_downstream.c | 4 ++++
>   hw/pci-bridge/xio3130_upstream.c   | 4 ++++
>   hw/pci-host/xilinx-pcie.c          | 4 ++++
>   hw/scsi/megasas.c                  | 6 ++++++
>   hw/usb/hcd-xhci.c                  | 4 ++++
>   8 files changed, 34 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 6071dc1..26d58b6 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1110,6 +1110,10 @@ static const TypeInfo nvme_info = {
>       .instance_size = sizeof(NvmeCtrl),
>       .class_init    = nvme_class_init,
>       .instance_init = nvme_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>   };
>   
>   static void nvme_register_types(void)
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index 6c42b44..81f7934 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -708,6 +708,10 @@ static const TypeInfo e1000e_info = {
>       .instance_size = sizeof(E1000EState),
>       .class_init = e1000e_class_init,
>       .instance_init = e1000e_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>   };
>   
>   static void e1000e_register_types(void)
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> index 4d588cb..9b6e4ce 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -161,6 +161,10 @@ static const TypeInfo rp_info = {
>       .class_init    = rp_class_init,
>       .abstract      = true,
>       .class_size = sizeof(PCIERootPortClass),
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>   };
>   
>   static void rp_register_types(void)
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index e706f36..7d2f762 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -195,6 +195,10 @@ static const TypeInfo xio3130_downstream_info = {
>       .name          = "xio3130-downstream",
>       .parent        = TYPE_PCIE_SLOT,
>       .class_init    = xio3130_downstream_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>   };
>   
>   static void xio3130_downstream_register_types(void)
> diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
> index a052224..227997c 100644
> --- a/hw/pci-bridge/xio3130_upstream.c
> +++ b/hw/pci-bridge/xio3130_upstream.c
> @@ -166,6 +166,10 @@ static const TypeInfo xio3130_upstream_info = {
>       .name          = "x3130-upstream",
>       .parent        = TYPE_PCIE_PORT,
>       .class_init    = xio3130_upstream_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>   };
>   
>   static void xio3130_upstream_register_types(void)
> diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
> index 4613dda..7659253 100644
> --- a/hw/pci-host/xilinx-pcie.c
> +++ b/hw/pci-host/xilinx-pcie.c
> @@ -317,6 +317,10 @@ static const TypeInfo xilinx_pcie_root_info = {
>       .parent = TYPE_PCI_BRIDGE,
>       .instance_size = sizeof(XilinxPCIERoot),
>       .class_init = xilinx_pcie_root_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>   };
>   
>   static void xilinx_pcie_register(void)
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index 734fdae..3641c30 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -2451,6 +2451,7 @@ typedef struct MegasasInfo {
>       int osts;
>       const VMStateDescription *vmsd;
>       Property *props;
> +    InterfaceInfo *interfaces;
>   } MegasasInfo;
>   
>   static struct MegasasInfo megasas_devices[] = {
> @@ -2480,6 +2481,10 @@ static struct MegasasInfo megasas_devices[] = {
>           .is_express = true,
>           .vmsd = &vmstate_megasas_gen2,
>           .props = megasas_properties_gen2,
> +        .interfaces = (InterfaceInfo[]) {
> +            { INTERFACE_PCIE_DEVICE },
> +            { }
> +        },
>       }
>   };
>   
> @@ -2531,6 +2536,7 @@ static void megasas_register_types(void)
>           type_info.parent = TYPE_MEGASAS_BASE;
>           type_info.class_data = (void *)info;
>           type_info.class_init = megasas_class_init;
> +        type_info.interfaces = info->interfaces;
>   
>           type_register(&type_info);
>       }
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 204ea69..d95ed4f 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3670,6 +3670,10 @@ static const TypeInfo xhci_info = {
>       .instance_size = sizeof(XHCIState),
>       .class_init    = xhci_class_init,
>       .abstract      = true,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>   };
>   
>   static void qemu_xhci_class_init(ObjectClass *klass, void *data)
> 
