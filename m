Received: from eggs.gnu.org ([2001:4830:134:3::10]:60083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dlJGU-0001ma-4J
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dlJGS-0006cA-UK
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:23:30 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dlJGS-0006an-LH
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:23:28 -0400
Received: by mail-wm0-x244.google.com with SMTP id r187so587396wma.2
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 11:23:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170823221445.15243-4-ehabkost@redhat.com>
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-4-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 25 Aug 2017 11:22:57 -0700
Message-ID: <CAKmqyKN5w9Jw-EG8A9c6aCT7N0PwVj+hPWBD0L4W7T6446uFOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Aug 23, 2017 at 3:14 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Change all devices that set is_express=1 to implement
> INTERFACE_PCIE_DEVICE.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/block/nvme.c                    | 4 ++++
>  hw/net/e1000e.c                    | 4 ++++
>  hw/pci-bridge/pcie_root_port.c     | 4 ++++
>  hw/pci-bridge/xio3130_downstream.c | 4 ++++
>  hw/pci-bridge/xio3130_upstream.c   | 4 ++++
>  hw/pci-host/xilinx-pcie.c          | 4 ++++
>  hw/scsi/megasas.c                  | 6 ++++++
>  hw/usb/hcd-xhci.c                  | 4 ++++
>  8 files changed, 34 insertions(+)

For the Xilinx devices.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 6071dc1..26d58b6 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1110,6 +1110,10 @@ static const TypeInfo nvme_info = {
>      .instance_size = sizeof(NvmeCtrl),
>      .class_init    = nvme_class_init,
>      .instance_init = nvme_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>  };
>
>  static void nvme_register_types(void)
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index 6c42b44..81f7934 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -708,6 +708,10 @@ static const TypeInfo e1000e_info = {
>      .instance_size = sizeof(E1000EState),
>      .class_init = e1000e_class_init,
>      .instance_init = e1000e_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>  };
>
>  static void e1000e_register_types(void)
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> index 4d588cb..9b6e4ce 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -161,6 +161,10 @@ static const TypeInfo rp_info = {
>      .class_init    = rp_class_init,
>      .abstract      = true,
>      .class_size = sizeof(PCIERootPortClass),
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>  };
>
>  static void rp_register_types(void)
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index e706f36..7d2f762 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -195,6 +195,10 @@ static const TypeInfo xio3130_downstream_info = {
>      .name          = "xio3130-downstream",
>      .parent        = TYPE_PCIE_SLOT,
>      .class_init    = xio3130_downstream_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>  };
>
>  static void xio3130_downstream_register_types(void)
> diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
> index a052224..227997c 100644
> --- a/hw/pci-bridge/xio3130_upstream.c
> +++ b/hw/pci-bridge/xio3130_upstream.c
> @@ -166,6 +166,10 @@ static const TypeInfo xio3130_upstream_info = {
>      .name          = "x3130-upstream",
>      .parent        = TYPE_PCIE_PORT,
>      .class_init    = xio3130_upstream_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>  };
>
>  static void xio3130_upstream_register_types(void)
> diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
> index 4613dda..7659253 100644
> --- a/hw/pci-host/xilinx-pcie.c
> +++ b/hw/pci-host/xilinx-pcie.c
> @@ -317,6 +317,10 @@ static const TypeInfo xilinx_pcie_root_info = {
>      .parent = TYPE_PCI_BRIDGE,
>      .instance_size = sizeof(XilinxPCIERoot),
>      .class_init = xilinx_pcie_root_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>  };
>
>  static void xilinx_pcie_register(void)
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index 734fdae..3641c30 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -2451,6 +2451,7 @@ typedef struct MegasasInfo {
>      int osts;
>      const VMStateDescription *vmsd;
>      Property *props;
> +    InterfaceInfo *interfaces;
>  } MegasasInfo;
>
>  static struct MegasasInfo megasas_devices[] = {
> @@ -2480,6 +2481,10 @@ static struct MegasasInfo megasas_devices[] = {
>          .is_express = true,
>          .vmsd = &vmstate_megasas_gen2,
>          .props = megasas_properties_gen2,
> +        .interfaces = (InterfaceInfo[]) {
> +            { INTERFACE_PCIE_DEVICE },
> +            { }
> +        },
>      }
>  };
>
> @@ -2531,6 +2536,7 @@ static void megasas_register_types(void)
>          type_info.parent = TYPE_MEGASAS_BASE;
>          type_info.class_data = (void *)info;
>          type_info.class_init = megasas_class_init;
> +        type_info.interfaces = info->interfaces;
>
>          type_register(&type_info);
>      }
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 204ea69..d95ed4f 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3670,6 +3670,10 @@ static const TypeInfo xhci_info = {
>      .instance_size = sizeof(XHCIState),
>      .class_init    = xhci_class_init,
>      .abstract      = true,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
>  };
>
>  static void qemu_xhci_class_init(ObjectClass *klass, void *data)
> --
> 2.9.4
>
>
