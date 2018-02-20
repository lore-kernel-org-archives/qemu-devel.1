Received: from eggs.gnu.org ([2001:4830:134:3::10]:35380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eo9UX-0000zV-K8
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eo9US-0007j8-Mi
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:06:01 -0500
References: <20180219174231.10874-1-david@redhat.com>
	<493dbfb3-086b-cc89-2d8d-4298345c6bb2@de.ibm.com>
	<ef55dc18-971f-b012-40cc-0c32f24664cf@redhat.com>
	<20180220155759.17dfd955.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <aeb36cb1-aadf-6146-9e59-549998538db1@redhat.com>
Date: Tue, 20 Feb 2018 16:05:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180220155759.17dfd955.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFCv2] s390x/sclp: remove memory hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 20.02.2018 15:57, Cornelia Huck wrote:
> On Tue, 20 Feb 2018 13:16:37 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 20.02.2018 13:05, Christian Borntraeger wrote:
>>>
>>>
>>> On 02/19/2018 06:42 PM, David Hildenbrand wrote:  
>>>> From an architecture point of view, nothing can be mapped into the address
>>>> space on s390x. All there is is memory. Therefore there is also not really
>>>> an interface to communicate such information to the guest. All we can do is
>>>> specify the maximum ram address and guests can probe in that range if
>>>> memory is available and usable (TPROT).  
>>>
>>> In fact there is an interface in SCLP that describes the memory sizes (maximum in 
>>> read scp info) and the details (read_storage_element0_info).  I am asking myself
>>> if we should re-introduce read_storage_element_info and use that to avoid tprot  
>>
>> Yes, we could do that (basically V1 of this patch) but have to glue it
>> to the a compatibility machine then.
> 
> Actually, this makes quite a bit of sense (introduce the interface for
> everyone in 2.12 and turn it off in compat machines).

Jup, either 2.12 or 2.13, no need to hurry.

> 
> Does real hardware have configurations where you can get the memory
> sizes, but not the attach/deattach support? (Hardware with the feature,
> but no standby memory defined?)

I would guess that "0" for standby memory is valid but only people with
access to documentation can answer that :)

>> Interesting, didn't know about that. Will rephrase then to
>>
>> "While the hypervisor can deny to online an increment, all increments
>> have to be predefined and there is no way of telling the guest about a
>> newly "hotplugged" increment."
> 
> Rephrase which part? :)

"And nobody can really hinder it from doing so."

Thanks!

-- 

Thanks,

David / dhildenb
