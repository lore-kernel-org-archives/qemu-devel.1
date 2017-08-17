Received: from eggs.gnu.org ([2001:4830:134:3::10]:42963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diKbK-0006er-U6
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diKbF-0000e8-VQ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:12:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1diKbF-0000dr-PO
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:12:37 -0400
References: <20170817092225.4264-1-david@redhat.com>
	<20170817151134.612bcb0e.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f522a6ef-608f-c148-48b3-9d62b7530eb7@redhat.com>
Date: Thu, 17 Aug 2017 15:12:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170817151134.612bcb0e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 00/10] target/s390x: cleanup
 cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com

On 17.08.2017 15:11, Cornelia Huck wrote:
> On Thu, 17 Aug 2017 11:22:15 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> cpu.h is accessed outside of target/s390x. It should only contain
>> what is expected to be accessed outside of this folder. Therefore, create
>> internal.h and move a lot to that file. In addition, introduce
>> kvm-stub.c and kvm_390x.h for kvm specific functions.
>>
>> Let's see what compilers think about this version.
> 
> It seems they like it :)
> 
>>
>> RFC -> v1:
>> - (hopefully) fixed a compile error
>> - move some functions from cpu.h to the only c file they are used in
>> - move kvm function and stubs to kvm_s390x.h and kvm-stub.c
>> - smaller requested style fixes
>>
>>
>> David Hildenbrand (10):
>>   target/s390x: move cc_name() to cc_helper.c
>>   target/s390x: move cpu_mmu_idx_to_asc() to excp_helper.c
>>   target/s390x: move psw_key_valid() to mem_helper.c
>>   target/s390x: move s390_do_cpu_reset() to diag.c
>>   target/s390x: move get_per_in_range() to misc_helper.c
>>   target/s390x: introduce internal.h
>>   target/s390x: move a couple of functions to cpu.c
>>   s390x: avoid calling kvm_ functions outside of target/s390x/
>>   s390x/kvm: move KVM declarations and stubs to separate files
>>   target/s390x: cleanup cpu.h
> 
> Generally, this looks good. I'll probably apply patches 1-8. For patch
> 9, I'll wait for an update (no need to resend the whole series). Still
> undecided about patch 10.
> 

I'll do another complete resend, cleaned up KVM_STATE parameter from two
functions which resulted in some conflicts when moving this stuff.

-- 

Thanks,

David
