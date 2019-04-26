Received: from eggs.gnu.org ([209.51.188.92]:59151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJz7f-0005VR-3C
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJz7d-00063o-5D
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:34:31 -0400
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
	<20190426111003.21246-11-borntraeger@de.ibm.com>
	<f0984d7f-9a9e-49fd-1466-0b2d1fa8a058@redhat.com>
	<460c9a5c-8e2e-a9a3-78e9-eda7aa6e5563@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <252dfd60-4852-e8b7-f1e9-b54c07702f4e@redhat.com>
Date: Fri, 26 Apr 2019 13:34:24 +0200
MIME-Version: 1.0
In-Reply-To: <460c9a5c-8e2e-a9a3-78e9-eda7aa6e5563@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/10] s390x/cpumodel: wire up 8561 and
 8562 as gen15 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

On 26.04.19 13:24, Christian Borntraeger wrote:
> 
> 
> On 26.04.19 13:21, David Hildenbrand wrote:
>> On 26.04.19 13:10, Christian Borntraeger wrote:
>>> 8561 and 8562 will be gen15 machines. There is no name yet, lets us use
>>> the cpu id as base name. Later on we can provide aliases with the proper
>>> name.
>>>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  target/s390x/cpu_models.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>> index d683635eb5..dd6415103f 100644
>>> --- a/target/s390x/cpu_models.c
>>> +++ b/target/s390x/cpu_models.c
>>> @@ -83,6 +83,8 @@ static S390CPUDef s390_cpu_defs[] = {
>>>      CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
>>>      CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"),
>>>      CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
>>> +    CPUDEF_INIT(0x8561, 15, 1, 47, 0x08000000U, "8561", "IBM 8561 GA1"),
>>> +    CPUDEF_INIT(0x8562, 15, 1, 47, 0x08000000U, "8562", "IBM 8562 GA1"),
>>>  };
>>>  
>>>  #define QEMU_MAX_CPU_TYPE 0x2827
>>>
>>
>> Can you fixup the comment at the beginning of the definitions, stating
>> that base features of new HW are no longer a superset?
>>
> 
> Something like
> 
> /*
>  * CPU definition list in order of release. Up to generation 14 base features>  * of a following release have been a superset of the previous
release. With
>  * generation 15 two features have been deprecated.
>  */
> 

"one base feature and one optional feature" ?

-- 

Thanks,

David / dhildenb
