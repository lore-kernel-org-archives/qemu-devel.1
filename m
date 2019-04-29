Received: from eggs.gnu.org ([209.51.188.92]:33322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL2Gs-0001VE-2I
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL24x-00062R-R6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:56:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hL24x-000622-GW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:56:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3T8rlCm049534
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 04:56:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s5vdqm58j-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 04:56:00 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Apr 2019 09:55:58 +0100
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
	<20190426111003.21246-11-borntraeger@de.ibm.com>
	<71955bba-ef04-1677-b7f0-bb1675bad12a@redhat.com>
	<07252560-1eed-8fd5-ee94-6bcea6cf99bc@de.ibm.com>
	<10d43e6e-ee8c-cd65-e724-354e0f40c79f@redhat.com>
	<057d438c-2062-1aa7-887a-918f076911c5@de.ibm.com>
	<93f0ecac-47cc-c791-9e32-ad5743489bf3@redhat.com>
	<20190426145506.409b53cf.cohuck@redhat.com>
	<7157e9b3-4432-32cc-9327-22e0d0124987@de.ibm.com>
	<20190429105332.14434866.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 29 Apr 2019 10:55:53 +0200
MIME-Version: 1.0
In-Reply-To: <20190429105332.14434866.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b3e4dda2-2a74-718e-102d-14532607ddb3@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 10/10] s390x/cpumodel: wire
 up 8561 and 8562 as gen15 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>



On 29.04.19 10:53, Cornelia Huck wrote:
> On Mon, 29 Apr 2019 09:51:39 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 26.04.19 14:55, Cornelia Huck wrote:
>>> On Fri, 26 Apr 2019 14:05:30 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> On 26.04.19 14:01, Christian Borntraeger wrote:  
>>>>>
>>>>>
>>>>> On 26.04.19 13:52, David Hildenbrand wrote:    
>>>>>> On 26.04.19 13:36, Christian Borntraeger wrote:    
>>>>>>>
>>>>>>>
>>>>>>> On 26.04.19 13:32, David Hildenbrand wrote:    
>>>>>>>> On 26.04.19 13:10, Christian Borntraeger wrote:    
>>>>>>>>> 8561 and 8562 will be gen15 machines. There is no name yet, lets us use
>>>>>>>>> the cpu id as base name. Later on we can provide aliases with the proper
>>>>>>>>> name.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>>>>>> ---
>>>>>>>>>  target/s390x/cpu_models.c | 2 ++
>>>>>>>>>  1 file changed, 2 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>>>>>>>> index d683635eb5..dd6415103f 100644
>>>>>>>>> --- a/target/s390x/cpu_models.c
>>>>>>>>> +++ b/target/s390x/cpu_models.c
>>>>>>>>> @@ -83,6 +83,8 @@ static S390CPUDef s390_cpu_defs[] = {
>>>>>>>>>      CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
>>>>>>>>>      CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"),
>>>>>>>>>      CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
>>>>>>>>> +    CPUDEF_INIT(0x8561, 15, 1, 47, 0x08000000U, "8561", "IBM 8561 GA1"),
>>>>>>>>> +    CPUDEF_INIT(0x8562, 15, 1, 47, 0x08000000U, "8562", "IBM 8562 GA1"),
>>>>>>>>>  };    
>>>>>>>>
>>>>>>>> Thinking out loud, I know that official names are not published yet.
>>>>>>>> Looking at the recent history (z13, z14), my educated guess would be
>>>>>>>> z15. I guess pretty much everybody would guess that.    
>>>>>>>
>>>>>>> Not sure about trademark aspects - especially if this really becomes z15. The smaller
>>>>>>> machine has no real history (ZR1 vs. s vs BC). So I think I would rather have a correct
>>>>>>> number than a partially correct name.    
>>>>>>
>>>>>> We could also use "gen15a" and "gen15b", still better to get than magic
>>>>>> numbers. (yeah well, they are not magic)
>>>>>>
>>>>>> If you want to stick with numbers, be aware that cpu numbers are not
>>>>>> injective, so at some point we will need e.g. "8561.2", just so you're
>>>>>> aware of the implications.    
>>>>>
>>>>> I think whatever we have here is only used internally for expansion (host-model)
>>>>> and the user will use later the real name when available. (custom). So probably this
>>>>> does not matter for a long time. But I might be wrong.
>>>>> I tend to prefer gen15 over z15 but 856x has also its charm.  
>>>
>>> FWIW, I'd prefer gen15 over 856x, but...  
>>
>> I actually think that the cpu id would be a nice name for expansion because it is
>> guarenteed to stay and it is unique and it allows to have a different content (if
>> that would be necessary) for 2 gen15 machines.
>>>   
>>>>>     
>>>>
>>>> Another question would be, can we rename before the next QEMU release,
>>>> so it will never be officially part of QEMU? Then we don't need aliases
>>>> after all. Of course, distros have to take care of that as well, but
>>>> that shouldn't be upstream QEMUs business.  
>>>
>>> ...if we could do that, I'd like that even better.  
>>
>> I dont think that I know the name in time before the next release.
>> So lets go with gen15a/gen15b or 8561/8562?
> 
> I always have trouble remembering number combinations, so I'd vote for
> gen15a/gen15b if the official names are not an option.

OK, I will respin with gen15a/gen15b.
