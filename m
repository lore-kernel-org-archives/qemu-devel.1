Received: from eggs.gnu.org ([209.51.188.92]:50089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpUxn-0003Og-JZ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:18:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpUxl-0007XP-6k
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:18:19 -0500
References: <20190130155733.32742-1-david@redhat.com>
	<4fec7d60-1d09-ba37-c66a-1d86088a1c0e@linux.ibm.com>
	<20190201093524.321787a2.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2bcb9cac-d8af-bfd4-e080-9650492ab770@redhat.com>
Date: Fri, 1 Feb 2019 10:18:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190201093524.321787a2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 0/6] s390x/pci: remaining
 hot/un)plug patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 01.02.19 09:35, Cornelia Huck wrote:
> On Thu, 31 Jan 2019 15:43:16 -0500
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> On 1/30/19 10:57 AM, David Hildenbrand wrote:
>>> These are all the patches that are not yet upstream (@Conny you might
>>> already picked some, including them for the full picture) and after
>>> a good discussion yesterday, including a patch t get rid of the release
>>> timer. I ran a couple of sanity tests on this series.
>>>
>>> #1 and #2 fix hotplugging of PCI bridges.
>>> #3 warns when "zpci=off"
>>> #4 refactors unplugging
>>> #5 get's rid of the release timer
>>> #6 processes all unplug requests on reboot
>>>
>>> @Colin, can you review/ack? Especially Patch #4 is needed for qdev
>>> patches already on the list. ("[PATCH RFCv2 0/9] qdev: Hotplug handler
>>> chaining + virtio-pmem")  
>>
>> I've given my r-b for 4, 5, and 6. IIRC, the other patches in this
>> series looked fine from previous versions, but I'd like to look at them
>> more carefully before ack'ing. Please allow me some time to devote to
>> them in the near future. Trying my best to balance things :)
> 
> Great, thanks for looking. If patches 4-6 can be applied without
> patches 1-3 (I think they can?), I'll go ahead and queue them.

Yes, I think they can, patch 1-3 mainly deals with plugging, these ones
with unplugging. Thanks Conny!

> 
> (I'll probably send a pull request next week, will be happy to include
> the other patches as well.)
> 


-- 

Thanks,

David / dhildenb
