Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A91C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59551205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59551205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55804 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRGBg-0002wr-Hi
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 09:12:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jakub.jermar@kernkonzept.com>) id 1hRG9l-0001Y1-1g
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jakub.jermar@kernkonzept.com>) id 1hRG9f-0006Sg-Or
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:10:43 -0400
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]:54075
	helo=mx.kernkonzept.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jakub.jermar@kernkonzept.com>)
	id 1hRG9e-0006Nu-Bo
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:10:38 -0400
Received: from 93-153-64-87.customers.tmcz.cz ([93.153.64.87]
	helo=[192.168.0.108]) by mx.kernkonzept.com with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	id 1hRG9T-0003i2-9V; Thu, 16 May 2019 15:10:27 +0200
From: Jakub Jermar <jakub.jermar@kernkonzept.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190423110034.1260142-1-jakub.jermar@kernkonzept.com>
	<ab4b6d04-74f9-2f12-829d-9df8c1b1c4ca@redhat.com>
	<6ae8d347-149d-e7eb-bb02-90aba44c5bbd@kernkonzept.com>
	<1e9a8595-4653-4900-b747-236f9888b893@kernkonzept.com>
Organization: Kernkonzept
Message-ID: <04a4fcca-0db9-46f8-ac41-0d770b0dc5d6@kernkonzept.com>
Date: Thu, 16 May 2019 15:10:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1e9a8595-4653-4900-b747-236f9888b893@kernkonzept.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a01:4f8:1c1c:b490::2
Subject: Re: [Qemu-devel] [PATCH v2] mips: Decide to map PAGE_EXEC in
 map_address
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Leon Alrae <leon.alrae@imgtec.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 5/3/19 12:02 PM, Jakub Jermar wrote:
> Hi,
> 
> On 4/23/19 4:58 PM, Jakub Jermar wrote:
>> Hi Philippe!
>>
>> On 4/23/19 3:48 PM, Philippe Mathieu-Daudé wrote:
>>> Hi Jakub,
>>>
>>> On 4/23/19 1:00 PM, Jakub Jermář wrote:
>>>> This commit addresses QEMU Bug #1825311:
>>>>
>>>>   mips_cpu_handle_mmu_fault renders all accessed pages executable
>>>>
>>>> It allows finer-grained control over whether the accessed page should be
>>>> executable by moving the decision to the underlying map_address
>>>> function, which has more information for this.
>>>>
>>>> As a result, pages that have the XI bit set in the TLB and are accessed
>>>> for read/write, don't suddenly end up being executable.
>>>>
>>>
>>> Fixes: https://bugs.launchpad.net/qemu/+bug/1825311
>>>
>>>> Signed-off-by: Jakub Jermář <jakub.jermar@kernkonzept.com>
>>>> ---
>>>>  target/mips/helper.c | 17 ++++++++++-------
>>>>  1 file changed, 10 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/target/mips/helper.c b/target/mips/helper.c
>>>> index c44cdca3b5..132d073fbe 100644
>>>> --- a/target/mips/helper.c
>>>> +++ b/target/mips/helper.c
>>>> @@ -43,7 +43,7 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>>>>                          target_ulong address, int rw, int access_type)
>>>>  {
>>>>      *physical = address;
>>>> -    *prot = PAGE_READ | PAGE_WRITE;
>>>> +    *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>>>>      return TLBRET_MATCH;
>>>>  }
>>>>  
>>>> @@ -61,7 +61,7 @@ int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>>>>      else
>>>>          *physical = address;
>>>>  
>>>> -    *prot = PAGE_READ | PAGE_WRITE;
>>>> +    *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>>>>      return TLBRET_MATCH;
>>>>  }
>>>>  
>>>> @@ -101,6 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>>>>                  *prot = PAGE_READ;
>>>>                  if (n ? tlb->D1 : tlb->D0)
>>>>                      *prot |= PAGE_WRITE;
>>>> +                if (!(n ? tlb->XI1 : tlb->XI0)) {
>>>> +                    *prot |= PAGE_EXEC;
>>>> +                }
>>>
>>> This was indeed missed in commit 2fb58b73746e.
>>>
>>>>                  return TLBRET_MATCH;
>>>>              }
>>>>              return TLBRET_DIRTY;
>>>> @@ -182,7 +185,7 @@ static int get_seg_physical_address(CPUMIPSState *env, hwaddr *physical,
>>>>      } else {
>>>>          /* The segment is unmapped */
>>>>          *physical = physical_base | (real_address & segmask);
>>>> -        *prot = PAGE_READ | PAGE_WRITE;
>>>> +        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>>>>          return TLBRET_MATCH;
>>>>      }
>>>>  }
>>>> @@ -913,8 +916,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>>>>      }
>>>>      if (ret == TLBRET_MATCH) {
>>>>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>>>> -                     physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
>>>> -                     mmu_idx, TARGET_PAGE_SIZE);
>>>> +                     physical & TARGET_PAGE_MASK, prot, mmu_idx,
>>>> +                     TARGET_PAGE_SIZE);
>>>>          ret = 0;
>>>>      } else if (ret < 0)
>>>>  #endif
>>>> @@ -936,8 +939,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>>>>                                             address, rw, access_type, mmu_idx);
>>>>                  if (ret == TLBRET_MATCH) {
>>>>                      tlb_set_page(cs, address & TARGET_PAGE_MASK,
>>>> -                            physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
>>>> -                            mmu_idx, TARGET_PAGE_SIZE);
>>>> +                            physical & TARGET_PAGE_MASK, prot, mmu_idx,
>>>> +                            TARGET_PAGE_SIZE);
>>>>                      ret = 0;
>>>>                      return ret;
>>>>                  }
>>>>
>>>
>>> Your patch looks correct, but I'd like to test it.
>>> Do you have a reproducer?
>>> Can you describe the command line you used?
>>
>> I've just attached a reproducer image and script to the bug. It's a
>> 32-bit little-endian test binary running on top of the L4Re microkernel.
>> Let me know if you also need a 64-bit version.
>>
>> I tested both 32 and 64-bit versions of the reproducer and also checked
>> to see that the the other images I have lying around here (Linux 2.6.32
>> big endian and HelenOS master little-endian, both 32-bit for 4Kc)
>> continue to run without regressions.
>>
>> Best regards,
>> Jakub
> 
> (ping)
> 
> Is there anything else I can do to help to get this merged?
> 
> https://patchew.org/QEMU/20190423110034.1260142-1-jakub.jermar@kernkonzept.com/

Has anyone managed to have a look at this?

Thanks,
Jakub

> 
> Thanks,
> Jakub
> 

-- 
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael
Hohmuth

