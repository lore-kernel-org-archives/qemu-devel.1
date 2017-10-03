Received: from eggs.gnu.org ([2001:4830:134:3::10]:53229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzCfE-0006Nr-25
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 22:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzCfA-000053-0n
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 22:10:27 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:32954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dzCf9-0008TD-Fs
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 22:10:23 -0400
Received: by mail-pf0-x241.google.com with SMTP id m28so7312904pfi.0
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 19:10:22 -0700 (PDT)
References: <20170915063552.33868-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2e1b8655-5d47-965c-3d54-1ac1a531afe8@ozlabs.ru>
Date: Tue, 3 Oct 2017 13:10:17 +1100
MIME-Version: 1.0
In-Reply-To: <20170915063552.33868-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] pci: Initialize pci_dev->name
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

On 15/09/17 16:35, Alexey Kardashevskiy wrote:
> This moves pci_dev->name initialization earlier so
> pci_dev->bus_master_as could get a name instead of an empty string.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Ping?


> ---
> Changes:
> v2:
> * fixed mistype in the commit log
> * added "rb"
> ---
>  hw/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 21e203b056..353195d154 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1020,6 +1020,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>  
>      pci_dev->devfn = devfn;
>      pci_dev->requester_id_cache = pci_req_id_cache_get(pci_dev);
> +    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>  
>      memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
>                         "bus master container", UINT64_MAX);
> @@ -1029,7 +1030,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
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
