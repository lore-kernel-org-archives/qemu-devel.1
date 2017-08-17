Received: from eggs.gnu.org ([2001:4830:134:3::10]:47272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diKsd-0007al-2U
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diKsX-0005n7-4j
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:30:35 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diKsW-0005mU-Vs
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:30:29 -0400
Received: by mail-qk0-x243.google.com with SMTP id d21so4597831qke.3
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 06:30:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-10-david@redhat.com>
	<f2b025c6-bfd9-2b01-497c-d08f262bd0d5@amsat.org>
	<1cb3a142-be2d-920e-7b9e-f3ea3df0ad52@redhat.com>
	<c38eee58-0e16-1a3f-47f5-550f7cbc943f@redhat.com>
	<42546fae-b442-2061-1b70-9b5603cab21d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5e000894-664d-da8e-ac49-da8c76e5c36f@amsat.org>
Date: Thu, 17 Aug 2017 10:30:24 -0300
MIME-Version: 1.0
In-Reply-To: <42546fae-b442-2061-1b70-9b5603cab21d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 09/10] s390x/kvm: move KVM
 declarations and stubs to separate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 08/17/2017 10:06 AM, Thomas Huth wrote:
> On 17.08.2017 14:55, David Hildenbrand wrote:
>> On 17.08.2017 14:35, Thomas Huth wrote:
>>> On 17.08.2017 13:40, Philippe Mathieu-Daudé wrote:
>>>> On 08/17/2017 06:22 AM, David Hildenbrand wrote:
> [...]
>>>>>    feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
>>>>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>>>>> index 74d5b35..aeb730c 100644
>>>>> --- a/target/s390x/cpu.h
>>>>> +++ b/target/s390x/cpu.h
>>>>> @@ -41,6 +41,7 @@
>>>>>    #include "exec/cpu-all.h"
>>>>>      #include "fpu/softfloat.h"
>>>>> +#include "kvm_s390x.h"
>>>
>>> Do we still need that? cpu.h should theoretically be independent from
>>> kvm now, shouldn't it? And for the .c files, it's likely better to
>>> include kvm_s390x.h directly there if they require it.
>>
>> It should work if:
>>
>> a) we include "sysemu/kvm.h" in hw/s390x/s390-virtio-ccw.c
>> b) we include "target/s390x/kvm_s390x.h" in hw/intc/s390_flic_kvm.c

that sounds odd... but git grep gives:

hw/i386/kvm/apic.c:19:#include "target/i386/kvm_i386.h"
hw/ppc/spapr_cpu_core.c:17:#include "target/ppc/kvm_ppc.h"

>> c) we include "kvm_s390x.h" in "internal.h"
>> d) we drop the "KVMState" parameter from kvm_s390_get_memslot_count()
>> (separate patch)
> 
> Ok, that's rather a lot of changes already. Maybe that's rather
> something for a later patch instead, so I'm also fine if you keep in
> #include "kvm_s390x.h" in cpu.h here.

there is still time until 2.11 :)
