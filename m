Received: from eggs.gnu.org ([2001:4830:134:3::10]:60499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e4JzE-0007Fz-Cq
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 01:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e4Jz9-0003sE-A5
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 01:00:16 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:48416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e4Jz9-0003ra-46
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 01:00:11 -0400
Received: by mail-it0-x241.google.com with SMTP id c3so943908itc.3
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 22:00:10 -0700 (PDT)
References: <20171015042452.31714-1-aik@ozlabs.ru>
	<20171015080123.GB22780@pxdev.xzpeter.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <34e55f83-211c-2c08-2b56-1a1f936e5992@ozlabs.ru>
Date: Tue, 17 Oct 2017 16:00:05 +1100
MIME-Version: 1.0
In-Reply-To: <20171015080123.GB22780@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu v2 REPOST] pci: Initialize
 pci_dev->name before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On 15/10/17 19:01, Peter Xu wrote:
> On Sun, Oct 15, 2017 at 03:24:52PM +1100, Alexey Kardashevskiy wrote:
>> This moves pci_dev->name initialization earlier so
>> pci_dev->bus_master_as could get a name instead of an empty string.
> 
> Or use "name" instead of "pci_dev->name" when do address_space_init()?
> But I think this one works too.
> 
>>
>> Reviewed-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
> 
> Maybe "Philippe Mathieu-Daudé"?


Definitely. Repost?


> 
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
>> ---
>>
>> Changes:
>> v2:
>> * fixed mistype in the commit log
>> * added "rb"
>> ---
>>  hw/pci/pci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 1e6fb88eba..05c5f75ef0 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -1020,6 +1020,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>>  
>>      pci_dev->devfn = devfn;
>>      pci_dev->requester_id_cache = pci_req_id_cache_get(pci_dev);
>> +    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>>  
>>      memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
>>                         "bus master container", UINT64_MAX);
>> @@ -1029,7 +1030,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>>      if (qdev_hotplug) {
>>          pci_init_bus_master(pci_dev);
>>      }
>> -    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>>      pci_dev->irq_state = 0;
>>      pci_config_alloc(pci_dev);
>>  
>> -- 
>> 2.11.0
>>
>>
> 


-- 
Alexey
