Received: from eggs.gnu.org ([2001:4830:134:3::10]:56241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eCeY5-00022O-AD
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 23:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eCeY2-0002qA-6i
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 23:34:41 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:55520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eCeY2-0002pz-0R
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 23:34:38 -0500
Received: by mail-it0-x243.google.com with SMTP id l196so9170883itl.4
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 20:34:37 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20171019021505.30576-1-aik@ozlabs.ru>
	<49acf956-eb59-2171-6c2c-23d69148efd8@ozlabs.ru>
Message-ID: <f055ed7b-caca-d1b6-1e85-0c27055c905a@ozlabs.ru>
Date: Thu, 9 Nov 2017 15:34:32 +1100
MIME-Version: 1.0
In-Reply-To: <49acf956-eb59-2171-6c2c-23d69148efd8@ozlabs.ru>
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

On 26/10/17 13:21, Alexey Kardashevskiy wrote:
> On 19/10/17 13:15, Alexey Kardashevskiy wrote:
>> This moves pci_dev->name initialization earlier so
>> pci_dev->bus_master_as could get a name instead of an empty string.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> 
> 
> Ping?


Ping?


> 
>> ---
>>
>> Changes:
>> v3:
>> * more "reviewed-by"
>> * fixed spelling in commit log
>>
>> v2:
>> * fixed mistype in the commit log
>> * added "rb"
>> ---
>>  hw/pci/pci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 5ed3c8dca4..b2d139bd9a 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -1030,6 +1030,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>>  
>>      pci_dev->devfn = devfn;
>>      pci_dev->requester_id_cache = pci_req_id_cache_get(pci_dev);
>> +    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>>  
>>      memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
>>                         "bus master container", UINT64_MAX);
>> @@ -1039,7 +1040,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>>      if (qdev_hotplug) {
>>          pci_init_bus_master(pci_dev);
>>      }
>> -    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>>      pci_dev->irq_state = 0;
>>      pci_config_alloc(pci_dev);
>>  
>>
> 
> 


-- 
Alexey
