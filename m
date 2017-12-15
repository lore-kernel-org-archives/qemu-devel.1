Received: from eggs.gnu.org ([2001:4830:134:3::10]:56183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ePmvN-0007I1-Dk
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ePmvJ-0004WP-DU
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:09:01 -0500
References: <20171214171004.25058-1-cohuck@redhat.com>
	<CAFEAcA8tY9=jtsw-MtjWTceLizvpH8oui_+6xf7V6K5o5BLf-A@mail.gmail.com>
	<cf44ca76-d581-8d96-3e2b-78c698dda446@de.ibm.com>
	<1a45723d-3731-17e9-98af-8d52312915e2@redhat.com>
	<e5f8d9d6-82e2-a59f-eedd-dc93526195d2@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <dedd222b-be78-8b6d-1f68-e2e463e07bdf@redhat.com>
Date: Fri, 15 Dec 2017 11:08:53 +0100
MIME-Version: 1.0
In-Reply-To: <e5f8d9d6-82e2-a59f-eedd-dc93526195d2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL 00/46] First batch of s390x
 patches for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 15.12.2017 10:53, Christian Borntraeger wrote:
> 
> 
> On 12/15/2017 10:53 AM, David Hildenbrand wrote:
>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index 80e753a5ef..9abb8de9f9 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -172,9 +172,10 @@ static void s390_memory_init(ram_addr_t mem_size)
>>>      name = g_strdup_printf("s390.ram");
>>>      while (mem_size) {
>>>          MemoryRegion *ram = g_new(MemoryRegion, 1);
>>> +       unsigned long long size = mem_size;
>>>  
>>>          /* KVM does not allow memslots >= 8 TB */
>>> -        chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
>>> +        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
>>
>> directly cast inline?
> As I said, this still triggers the warning. gcc 7 is too clever.

Whoops missed that.


-- 

Thanks,

David / dhildenb
