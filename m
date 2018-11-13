Received: from eggs.gnu.org ([2001:4830:134:3::10]:38381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gMXTC-00047D-9q
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gMXT7-0004Tl-3Z
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:07:02 -0500
References: <20181105110313.29312-1-david@redhat.com>
	<20181112181454.13efd2af.cohuck@redhat.com>
	<8aaa3434-cb48-6adf-d716-c391eb3123f5@redhat.com>
	<20181113100313.307711b0.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <84c46d77-4ebc-0754-de83-751aa7ed32dc@redhat.com>
Date: Tue, 13 Nov 2018 13:06:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181113100313.307711b0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 0/4] s390x/zpci: some
 hotplug handler cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Collin Walling <walling@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 13.11.18 10:03, Cornelia Huck wrote:
> On Mon, 12 Nov 2018 18:34:34 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 12.11.18 18:14, Cornelia Huck wrote:
>>> On Mon,  5 Nov 2018 12:03:09 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> The hotplug code needs more love, but let's do some obvious cleanups
>>>> first. In the future, we want to propery make use of unplug_request() +
>>>> unplug(), instead of routing everything (especially two separate but
>>>> linked) devices via a single unplug call. Also, we want to move all
>>>> errors in plug() into the pre_plug() handler, but this will require
>>>> general PCI refactorings (moving stuff from realize() to the pre_plug/plug
>>>> handler).
>>>>
>>>> This series is based on "[PATCH v2 00/10] pci: hotplug handler reworks",
>>>> which contains one cleanup for s390x.
>>>>
>>>> David Hildenbrand (4):
>>>>   s390x/zpci: drop msix.available  
>>>
>>> queued to s390-next
>>>   
>>>>   s390x/zpci: use hotplug_dev instead of looking up the host bridge  
>>>
>>> Do we have consensus on that one yet? I can take it or leave it :)
>>>   
>>>>   s390x/zpci: move some hotplug checks to the pre_plug handler  
>>>
>>> depends on the handler rework  
>>
>> I can pull that one out from the general handler rework (still need
>> review either way so it could take a while).
> 
> It's 4.0 material anyway, so no need to hurry.
> 
>>
>>>   
>>>>   s390x/zpci: properly fail if the zPCI device cannot be created  
>>>
>>> Waiting for a fixed patch... can queue to s390-fixes if it arrives
>>> soon(tm).  
>>
>> Thanks!
>>
>> Shall I resend all or only this one?
> 
> The last one would be great, as I think it's still 3.1 material.
> 

Alrighty, so I'll resend (after testing this time ;) ) the last patch.

-- 

Thanks,

David / dhildenb
