Received: from eggs.gnu.org ([2001:4830:134:3::10]:45551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK5Aa-0005Zw-Ku
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK5AY-0004gO-29
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:25:08 -0500
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-8-david@redhat.com>
	<20171129165049.1c446263.cohuck@redhat.com>
	<77eab778-87d4-c16e-2407-5437f51c4b04@redhat.com>
	<20171129165917.0d163823.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <dda9d255-f242-7eb5-9801-c5e9f35751ce@redhat.com>
Date: Wed, 29 Nov 2017 17:25:02 +0100
MIME-Version: 1.0
In-Reply-To: <20171129165917.0d163823.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 07/15] s390x: handle exceptions
 during s390_cpu_virt_mem_rw() correctly (TCG)
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

On 29.11.2017 16:59, Cornelia Huck wrote:
> On Wed, 29 Nov 2017 16:54:30 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
> 
>>>> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
>>>> index 31e3f3f415..39da9aeef4 100644
>>>> --- a/target/s390x/mmu_helper.c
>>>> +++ b/target/s390x/mmu_helper.c
>>>> @@ -22,6 +22,7 @@
>>>>  #include "internal.h"
>>>>  #include "kvm_s390x.h"
>>>>  #include "sysemu/kvm.h"
>>>> +#include "exec/exec-all.h"
>>>>  #include "trace.h"
>>>>  #include "hw/s390x/storage-keys.h"
>>>>  
>>>> @@ -458,7 +459,7 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
>>>>          }
>>>>          if (!address_space_access_valid(&address_space_memory, pages[i],
>>>>                                          TARGET_PAGE_SIZE, is_write)) {
>>>> -            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
>>>> +            trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);  
>>>
>>> Why did you change this?  
>>
>> "For TCG, there was one case where a cpu loop exit was triggered. Fix
>> that up."
>>
>> Wasn't worth a separate patch :)
> 
> Well, maybe it is, to avoid dumb questions :)

... splitting it up :) Thanks!

-- 

Thanks,

David / dhildenb
