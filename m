Received: from eggs.gnu.org ([2001:4830:134:3::10]:53052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e3ZlQ-0006hZ-Lr
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e3ZlM-0006U8-QO
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:38:56 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:56455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e3ZlM-0006T2-KK
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:38:52 -0400
Received: by mail-pg0-x244.google.com with SMTP id m18so4187029pgd.13
	for <qemu-devel@nongnu.org>; Sat, 14 Oct 2017 20:38:52 -0700 (PDT)
References: <20170915063552.33868-1-aik@ozlabs.ru>
	<2e1b8655-5d47-965c-3d54-1ac1a531afe8@ozlabs.ru>
	<03c58335-8ca2-a812-5259-a5a41b9e0a87@ozlabs.ru>
	<20171015063012-mutt-send-email-mst@kernel.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f63e872d-28f1-233a-9c1e-2e87a54771fb@ozlabs.ru>
Date: Sun, 15 Oct 2017 14:38:46 +1100
MIME-Version: 1.0
In-Reply-To: <20171015063012-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On 15/10/17 14:31, Michael S. Tsirkin wrote:
> On Sun, Oct 15, 2017 at 02:24:17PM +1100, Alexey Kardashevskiy wrote:
>> On 03/10/17 13:10, Alexey Kardashevskiy wrote:
>>> On 15/09/17 16:35, Alexey Kardashevskiy wrote:
>>>> This moves pci_dev->name initialization earlier so
>>>> pci_dev->bus_master_as could get a name instead of an empty string.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>
>>> Ping?
>>
>> Ping?
> 
> I can't find v2 in either qemu or my personal mailbox.


Few weeks ago qemu-devel@ list admins were playing with list-id, may be
that's why it missed your inbox.

It hit patchwork though: https://patchwork.ozlabs.org/patch/814085/


> 
>>
>>>
>>>
>>>> ---
>>>> Changes:
>>>> v2:
>>>> * fixed mistype in the commit log
>>>> * added "rb"
>>>> ---
>>>>  hw/pci/pci.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>> index 21e203b056..353195d154 100644
>>>> --- a/hw/pci/pci.c
>>>> +++ b/hw/pci/pci.c
>>>> @@ -1020,6 +1020,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>>>>  
>>>>      pci_dev->devfn = devfn;
>>>>      pci_dev->requester_id_cache = pci_req_id_cache_get(pci_dev);
>>>> +    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>>>>  
>>>>      memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
>>>>                         "bus master container", UINT64_MAX);
>>>> @@ -1029,7 +1030,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>>>>      if (qdev_hotplug) {
>>>>          pci_init_bus_master(pci_dev);
>>>>      }
>>>> -    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>>>>      pci_dev->irq_state = 0;
>>>>      pci_config_alloc(pci_dev);
>>>>  
>>>>
>>>
>>>
>>
>>
>> -- 
>> Alexey


-- 
Alexey
