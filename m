Received: from eggs.gnu.org ([2001:4830:134:3::10]:55466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eI1g0-0006ml-H7
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 19:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eI1fw-0001SM-Mf
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 19:17:04 -0500
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:34859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eI1fw-0001Rj-Db
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 19:17:00 -0500
Received: by mail-pl0-x22d.google.com with SMTP id 62so3422588plc.2
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 16:16:59 -0800 (PST)
References: <20171123092333.16085-1-peterx@redhat.com>
	<20171123092333.16085-2-peterx@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0be0e8b5-c697-3cd4-45ea-e53c28047bb0@ozlabs.ru>
Date: Fri, 24 Nov 2017 11:16:53 +1100
MIME-Version: 1.0
In-Reply-To: <20171123092333.16085-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] pci: Initialize pci_dev->name before
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>

On 23/11/17 20:23, Peter Xu wrote:
> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> This moves pci_dev->name initialization earlier so
> pci_dev->bus_master_as could get a name instead of an empty string.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Peter Xu <peterx@redhat.com>


It is in upstream:

https://git.qemu.org/?p=qemu.git;a=commitdiff;h=d06bce95ff8c6e2f290db150695f826c3d57324f


> ---
>  hw/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 5ed3c8dca4..b2d139bd9a 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1030,6 +1030,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>  
>      pci_dev->devfn = devfn;
>      pci_dev->requester_id_cache = pci_req_id_cache_get(pci_dev);
> +    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>  
>      memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
>                         "bus master container", UINT64_MAX);
> @@ -1039,7 +1040,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>      if (qdev_hotplug) {
>          pci_init_bus_master(pci_dev);
>      }
> -    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>      pci_dev->irq_state = 0;
>      pci_config_alloc(pci_dev);
>  
> 


-- 
Alexey
