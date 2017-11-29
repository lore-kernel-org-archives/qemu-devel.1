Received: from eggs.gnu.org ([2001:4830:134:3::10]:32831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK4YE-0003Fp-59
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK4Y9-00081d-5h
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:45:30 -0500
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-5-david@redhat.com>
	<20171129161351.7908b6b0.cohuck@redhat.com>
	<40e115a4-476b-4b0a-c151-3f708b9e0a80@redhat.com>
	<20171129163501.1e83432c.cohuck@redhat.com>
	<39bdd9f7-9510-48ab-9a17-1a53bcc7f029@redhat.com>
	<20171129163908.38ae0bd9.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6e321ddc-0df5-d1f9-97c3-6372acf0fd33@redhat.com>
Date: Wed, 29 Nov 2017 16:45:21 +0100
MIME-Version: 1.0
In-Reply-To: <20171129163908.38ae0bd9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 04/15] s390x/ioinst: pass the
 retaddr to all IO instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 29.11.2017 16:39, Cornelia Huck wrote:
> On Wed, 29 Nov 2017 16:38:03 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 29.11.2017 16:35, Cornelia Huck wrote:
>>> On Wed, 29 Nov 2017 16:14:40 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> On 29.11.2017 16:13, Cornelia Huck wrote:  
>>>>> On Tue, 28 Nov 2017 21:33:14 +0100
>>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>>     
>>>>>> TCG needs the retaddr when injecting an interrupt. Let's just pass it
>>>>>> along and use 0 for KVM. The value will be completely ignored for KVM.    
>>>>>
>>>>> Can we get a #define for that? Just to make it clear at a glance that
>>>>> we're passing an ignored value and not some magic thing.    
>>>>
>>>> If you can come up with a good name, I can't :)  
>>>
>>> KVM_FAKE_RA
>>> KVM_RA_UNUSED
>>> KVM_RA_IGNORED
>>>
>>> ?
>>>   
>>
>> KVM_RA ? (to keep lines short?)
>>
> 
> That sounds too much like a magic value IMO (and not something that is
> ignored).
> 

Passing 0 will actually also ignore it for TCG. So it is actually a
magic value :) (just that more gets ignore din case of KVM ...)

RA_NONE ?


-- 

Thanks,

David / dhildenb
