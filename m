Received: from eggs.gnu.org ([2001:4830:134:3::10]:35449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQ6lE-0004yM-FM
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQ6l9-00025N-L5
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:52:08 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-8-david@redhat.com>
	<20180605010914.GG5140@umbus.fritz.box>
From: David Hildenbrand <david@redhat.com>
Message-ID: <09b8b883-c463-97b7-5fb9-1b77fe4effe9@redhat.com>
Date: Tue, 5 Jun 2018 09:51:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180605010914.GG5140@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 07/14] spapr: route all memory devices
 through the machine hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On 05.06.2018 03:09, David Gibson wrote:
> On Thu, May 17, 2018 at 10:15:20AM +0200, David Hildenbrand wrote:
>> Necessary to hotplug them cleanly later.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> As for PC, I think it would be nicer to drop the explicit check
> against PC_DIMM, since it is covered by MEMORY_DEVICE.

Indeed, already did that.

> 
>> ---
>>  hw/ppc/spapr.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index b7c5c95f7a..2f315f963b 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3666,6 +3666,7 @@ static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
>>                                                   DeviceState *dev)
>>  {
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
>> +        object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE) ||
>>          object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
>>          return HOTPLUG_HANDLER(machine);
>>      }
> 


-- 

Thanks,

David / dhildenb
