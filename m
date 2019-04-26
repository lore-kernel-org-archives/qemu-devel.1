Received: from eggs.gnu.org ([209.51.188.92]:37830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJzbl-00020Z-F6
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJzbk-0000nD-Dw
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:05:37 -0400
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
	<20190426111003.21246-11-borntraeger@de.ibm.com>
	<71955bba-ef04-1677-b7f0-bb1675bad12a@redhat.com>
	<07252560-1eed-8fd5-ee94-6bcea6cf99bc@de.ibm.com>
	<10d43e6e-ee8c-cd65-e724-354e0f40c79f@redhat.com>
	<057d438c-2062-1aa7-887a-918f076911c5@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <93f0ecac-47cc-c791-9e32-ad5743489bf3@redhat.com>
Date: Fri, 26 Apr 2019 14:05:30 +0200
MIME-Version: 1.0
In-Reply-To: <057d438c-2062-1aa7-887a-918f076911c5@de.ibm.com>
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

On 26.04.19 14:01, Christian Borntraeger wrote:
> 
> 
> On 26.04.19 13:52, David Hildenbrand wrote:
>> On 26.04.19 13:36, Christian Borntraeger wrote:
>>>
>>>
>>> On 26.04.19 13:32, David Hildenbrand wrote:
>>>> On 26.04.19 13:10, Christian Borntraeger wrote:
>>>>> 8561 and 8562 will be gen15 machines. There is no name yet, lets us use
>>>>> the cpu id as base name. Later on we can provide aliases with the proper
>>>>> name.
>>>>>
>>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>> ---
>>>>>  target/s390x/cpu_models.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>>>> index d683635eb5..dd6415103f 100644
>>>>> --- a/target/s390x/cpu_models.c
>>>>> +++ b/target/s390x/cpu_models.c
>>>>> @@ -83,6 +83,8 @@ static S390CPUDef s390_cpu_defs[] = {
>>>>>      CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
>>>>>      CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"),
>>>>>      CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
>>>>> +    CPUDEF_INIT(0x8561, 15, 1, 47, 0x08000000U, "8561", "IBM 8561 GA1"),
>>>>> +    CPUDEF_INIT(0x8562, 15, 1, 47, 0x08000000U, "8562", "IBM 8562 GA1"),
>>>>>  };
>>>>
>>>> Thinking out loud, I know that official names are not published yet.
>>>> Looking at the recent history (z13, z14), my educated guess would be
>>>> z15. I guess pretty much everybody would guess that.
>>>
>>> Not sure about trademark aspects - especially if this really becomes z15. The smaller
>>> machine has no real history (ZR1 vs. s vs BC). So I think I would rather have a correct
>>> number than a partially correct name.
>>
>> We could also use "gen15a" and "gen15b", still better to get than magic
>> numbers. (yeah well, they are not magic)
>>
>> If you want to stick with numbers, be aware that cpu numbers are not
>> injective, so at some point we will need e.g. "8561.2", just so you're
>> aware of the implications.
> 
> I think whatever we have here is only used internally for expansion (host-model)
> and the user will use later the real name when available. (custom). So probably this
> does not matter for a long time. But I might be wrong.
> I tend to prefer gen15 over z15 but 856x has also its charm.
> 

Another question would be, can we rename before the next QEMU release,
so it will never be officially part of QEMU? Then we don't need aliases
after all. Of course, distros have to take care of that as well, but
that shouldn't be upstream QEMUs business.

-- 

Thanks,

David / dhildenb
