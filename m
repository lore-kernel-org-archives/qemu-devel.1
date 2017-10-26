Received: from eggs.gnu.org ([2001:4830:134:3::10]:54994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7Xo3-0003R1-MF
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 22:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7Xnz-0005gK-MX
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 22:22:03 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e7Xnz-0005eJ-DN
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 22:21:59 -0400
Received: by mail-pf0-x244.google.com with SMTP id x7so1396909pfa.1
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 19:21:58 -0700 (PDT)
References: <20171019021505.30576-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <49acf956-eb59-2171-6c2c-23d69148efd8@ozlabs.ru>
Date: Thu, 26 Oct 2017 13:21:53 +1100
MIME-Version: 1.0
In-Reply-To: <20171019021505.30576-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu v3] pci: Initialize pci_dev->name
 before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 19/10/17 13:15, Alexey Kardashevskiy wrote:
> This moves pci_dev->name initialization earlier so
> pci_dev->bus_master_as could get a name instead of an empty string.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>



Ping?

> ---
> 
> Changes:
> v3:
> * more "reviewed-by"
> * fixed spelling in commit log
> 
> v2:
> * fixed mistype in the commit log
> * added "rb"
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
