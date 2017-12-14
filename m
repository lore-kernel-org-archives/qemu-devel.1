Received: from eggs.gnu.org ([2001:4830:134:3::10]:58385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ePTWq-00009l-OQ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ePTWn-0001Ls-K6
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:26:24 -0500
References: <20171211122146.162430-1-borntraeger@de.ibm.com>
	<20171214142138.3a5c9eef.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <aa2259c0-fc55-93eb-b4cd-9bab96d9c14f@redhat.com>
Date: Thu, 14 Dec 2017 14:26:17 +0100
MIME-Version: 1.0
In-Reply-To: <20171214142138.3a5c9eef.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] s390-ccw-virtio: allow for systems
 larger that 7.999TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 14.12.2017 14:21, Cornelia Huck wrote:
> On Mon, 11 Dec 2017 13:21:46 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> KVM does not allow memory regions > KVM_MEM_MAX_NR_PAGES, basically
>> limiting the memory per slot to 8TB-4k. As memory slots on s390/kvm must
>> be a multiple of 1MB we need start a new memory region if we cross
>> 8TB-1M.
>>
>> With that (and optimistic overcommitment in the kernel) I was able to
>> start a 24TB guest on a 1TB system.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 28 +++++++++++++++++++++++++---
>>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> Thanks, applied (with 1UL -> 1ULL).
> 

Can you add my

Reviewed-by: David Hildenbrand <david@redhat.com>

?

-- 

Thanks,

David / dhildenb
