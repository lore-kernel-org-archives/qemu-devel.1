Received: from eggs.gnu.org ([2001:4830:134:3::10]:40650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0oZ-0003ci-5K
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0oV-0001wS-79
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:33:11 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ff0oU-0001w6-Ui
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:33:07 -0400
Received: by mail-wm0-x22d.google.com with SMTP id y22-v6so796461wma.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 03:33:06 -0700 (PDT)
References: <20180712194522.31063-1-ehabkost@redhat.com>
	<20180712194522.31063-4-ehabkost@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <c8ec6d82-9d1c-056b-2b27-1c4c48ad72ff@gmail.com>
Date: Mon, 16 Jul 2018 13:33:01 +0300
MIME-Version: 1.0
In-Reply-To: <20180712194522.31063-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC 3/3] pci: Document ownership rules of
 pci_root_bus_new*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>



On 07/12/2018 10:45 PM, Eduardo Habkost wrote:
> The ownership rules of pci_root_bus_new*() aren't trivial: the
> caller owns the new object if parent is NULL, otherwise ownership
> is transferred to the parent.  Clarify that on comments.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   include/hw/pci/pci.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 990d6fcbde..5d445c431c 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -396,15 +396,30 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque, int pin);
>   
>   bool pci_bus_is_express(PCIBus *bus);
>   bool pci_bus_is_root(PCIBus *bus);
> +
> +/**
> + * pci_root_bus_new_inplace:
> + *
> +* If @parent is not NULL the returned object will be owned by @parent,
> +* otherwise it will be owned by the caller.
> +*/
>   void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                                 const char *name,
>                                 MemoryRegion *address_space_mem,
>                                 MemoryRegion *address_space_io,
>                                 uint8_t devfn_min, const char *typename);
> +
> +/**
> + * pci_root_bus_new:
> + *
> +* If @parent is not NULL the returned object will be owned by @parent,
> +* otherwise it will be owned by the caller.
> +*/
>   PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
>                            MemoryRegion *address_space_mem,
>                            MemoryRegion *address_space_io,
>                            uint8_t devfn_min, const char *typename);
> +
>   void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
>                     void *irq_opaque, int nirq);
>   int pci_bus_get_irq_level(PCIBus *bus, int irq_num);

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
