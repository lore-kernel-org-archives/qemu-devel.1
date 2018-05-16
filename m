Received: from eggs.gnu.org ([2001:4830:134:3::10]:55173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIsmA-0006iQ-Eb
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIsm6-0000Y7-Gu
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:31:14 -0400
References: <20180514100023.12542-1-david@redhat.com>
	<20180514100023.12542-3-david@redhat.com>
	<20180515002043.GC12837@kermit-br-ibm-com>
	<3bc66ce9-7535-a75c-8cfc-d47fc5cd2b85@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5eb20368-8d97-6dfb-5c18-8ee6e5251d46@redhat.com>
Date: Wed, 16 May 2018 11:31:05 +0200
MIME-Version: 1.0
In-Reply-To: <3bc66ce9-7535-a75c-8cfc-d47fc5cd2b85@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 02/18] memory-device:
 introduce separate config option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 15.05.2018 17:21, Eric Blake wrote:
> On 05/14/2018 07:20 PM, Murilo Opsfelder Araujo wrote:
>> On Mon, May 14, 2018 at 12:00:07PM +0200, David Hildenbrand wrote:
>>> Some architectures might support memory devices, while they don't
>>> support DIMM/NVDIMM. So let's
>>> - Rename CONFIG_MEM_HOTPLUG to CONFIG_MEM_DEVICE
>>> - Intriduce CONFIG_DIMM and use it similarly to CONFIG NVDIMM
>>
>> Since you're resending it:
>>
>> s/Intriduce/Introduce
>>
> 
>>> +++ b/qapi/misc.json
>>> @@ -2060,7 +2060,7 @@
>>>   #
>>>   # @plugged-memory: size of memory that can be hot-unplugged. This field
>>>   #                  is omitted if target doesn't support memory hotplug
>>> -#                  (i.e. CONFIG_MEM_HOTPLUG not defined on build time).
>>> +#                  (i.e. CONFIG_MEM_DEVICE not defined on build time).
>>>   #
> 
> Also, it sounds better with: s/on/at/
> 

Yes, will include both, thanks!

-- 

Thanks,

David / dhildenb
