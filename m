Received: from eggs.gnu.org ([2001:4830:134:3::10]:44747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlDQZ-0003xK-Cj
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlDQW-0004qx-3Y
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:09:31 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlDQV-0004qq-Vq
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:09:28 -0400
Received: by mail-qk0-x242.google.com with SMTP id 130so1895804qkg.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 05:09:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170825032101.42538-1-aik@ozlabs.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8d8da4bf-feb8-5da1-cd7a-195e80d59d8a@amsat.org>
Date: Fri, 25 Aug 2017 09:09:24 -0300
MIME-Version: 1.0
In-Reply-To: <20170825032101.42538-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu] pci: Initialize pci_dev->name before
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 08/25/2017 12:21 AM, Alexey Kardashevskiy wrote:
> This moves pci_dev->name initialization earlier so
> pci_dev->bus_master_as could get a name instead of empry string.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/pci/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 258fbe51e2..852babe812 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1000,6 +1000,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>   
>       pci_dev->devfn = devfn;
>       pci_dev->requester_id_cache = pci_req_id_cache_get(pci_dev);
> +    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>   
>       memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
>                          "bus master container", UINT64_MAX);
> @@ -1009,7 +1010,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>       if (qdev_hotplug) {
>           pci_init_bus_master(pci_dev);
>       }
> -    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>       pci_dev->irq_state = 0;
>       pci_config_alloc(pci_dev);
>   
> 
