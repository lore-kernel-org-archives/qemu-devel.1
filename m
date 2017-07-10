Received: from eggs.gnu.org ([2001:4830:134:3::10]:35719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dUT66-0005A4-Rh
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dUT65-0003uQ-Pg
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:27:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dUT65-0003tc-IN
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:27:09 -0400
References: <1499413442-5053-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1499413442-5053-3-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <8656a98b-f63e-ff74-4cc8-8abf0f7636d8@redhat.com>
Date: Mon, 10 Jul 2017 10:27:01 +0300
MIME-Version: 1.0
In-Reply-To: <1499413442-5053-3-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] pci: add dev_reserved_mask property to
 PCIBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com

On 07/07/2017 10:44, Mark Cave-Ayland wrote:
> This is just a simple bitmask indicating whether or not each PCI slot on the
> bus is reserved. Ensure that it is initialised to zero so that all bus slots
> are available by default.
> 

Hi Mark,

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/pci/pci.c             |    1 +
>   include/hw/pci/pci_bus.h |    1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 04e6edb..239161e 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -371,6 +371,7 @@ static void pci_bus_init(PCIBus *bus, DeviceState *parent,
>   {
>       assert(PCI_FUNC(devfn_min) == 0);
>       bus->devfn_min = devfn_min;
> +    bus->dev_reserved_mask = 0x0;

Not really necessary, the object are zeroed when created
(as far as I remember).

>       bus->address_space_mem = address_space_mem;
>       bus->address_space_io = address_space_io;
>   
> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> index 5484a9b..a0cf655 100644
> --- a/include/hw/pci/pci_bus.h
> +++ b/include/hw/pci/pci_bus.h
> @@ -23,6 +23,7 @@ struct PCIBus {
>       PCIIOMMUFunc iommu_fn;
>       void *iommu_opaque;
>       uint8_t devfn_min;
> +    uint32_t dev_reserved_mask;

I would merge this patch with the next one to
see the new field "in action".

Thanks,
Marcel

>       pci_set_irq_fn set_irq;
>       pci_map_irq_fn map_irq;
>       pci_route_irq_fn route_intx_to_irq;
> 
