Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81522C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C8F2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C8F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60823 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRJJB-0002b6-42
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 12:32:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRJHh-0001k4-F2
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRJHf-0002hJ-SC
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:31:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRJHf-0002fe-Lk
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:31:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so4072177wrq.12
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 09:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=LIurXMSJmXU6vCy+NHcAmHy2hxO7o3vwPkFQiG77T+k=;
	b=pBOUWHLkL8MCvpvcBy2iymeNGbeipKIA1GhSY/4Zrb7IiVxpTvjIlEkFPGW4wMtiqF
	CDhC4HuKIBi/Qj2B/+jhwqTb7HUbebEHnE290s0G6TX5Mnb/ofOeaIXnKpp3ZiMZYBVa
	R8Nzb9c/cWMDJLsssrhNvaDY9qP+X9+UUKReIFuhi3nnDgiDpKaqWA0qD0mH5gYoe6nT
	knu3V24fxIUeLQVmkXO0XR8qjtfd6+8GkXJtrcisSgajIbCUBr97ayhdqwQ3k1M5ihAp
	0fKzX1/t2RlwXL2MNjnXpEEFZsYwcYxx8SC9tictajsOVoanXrf2oMVEAdlpCI9hdyJe
	Vswg==
X-Gm-Message-State: APjAAAWceYPdC9+Q/A//XJMZ6u3SreZGGrkpX2qeh2Mr3QLl9TS/a9yF
	VLSk+Qzji2m8jXJxws60j5PH7A==
X-Google-Smtp-Source: APXvYqycqsH3dGKkqnoxEj+GPCx8SoG4tSfFcYBe0o4bkbV2OR0Z1TIw12AlwhlqnZJkE6YE6oWl2A==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr24583449wrn.29.1558024265581; 
	Thu, 16 May 2019 09:31:05 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	l21sm5160583wmh.35.2019.05.16.09.31.04
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 09:31:05 -0700 (PDT)
To: Jakub Jermar <jakub.jermar@kernkonzept.com>, qemu-devel@nongnu.org
References: <20190423110034.1260142-1-jakub.jermar@kernkonzept.com>
	<ab4b6d04-74f9-2f12-829d-9df8c1b1c4ca@redhat.com>
	<6ae8d347-149d-e7eb-bb02-90aba44c5bbd@kernkonzept.com>
	<1e9a8595-4653-4900-b747-236f9888b893@kernkonzept.com>
	<04a4fcca-0db9-46f8-ac41-0d770b0dc5d6@kernkonzept.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f9f1b930-2381-b343-854f-70e2590c9b73@redhat.com>
Date: Thu, 16 May 2019 18:31:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <04a4fcca-0db9-46f8-ac41-0d770b0dc5d6@kernkonzept.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
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
	Leon Alrae <leon.alrae@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jakub,

On 5/16/19 3:10 PM, Jakub Jermar wrote:
> Hi,
> 
> On 5/3/19 12:02 PM, Jakub Jermar wrote:
>> Hi,
>>
>> On 4/23/19 4:58 PM, Jakub Jermar wrote:
>>> Hi Philippe!
>>>
>>> On 4/23/19 3:48 PM, Philippe Mathieu-Daudé wrote:
>>>> Hi Jakub,
>>>>
>>>> On 4/23/19 1:00 PM, Jakub Jermář wrote:
>>>>> This commit addresses QEMU Bug #1825311:
>>>>>
>>>>>   mips_cpu_handle_mmu_fault renders all accessed pages executable
>>>>>
>>>>> It allows finer-grained control over whether the accessed page should be
>>>>> executable by moving the decision to the underlying map_address
>>>>> function, which has more information for this.
>>>>>
>>>>> As a result, pages that have the XI bit set in the TLB and are accessed
>>>>> for read/write, don't suddenly end up being executable.
>>>>>
>>>>
>>>> Fixes: https://bugs.launchpad.net/qemu/+bug/1825311
>>>>
>>>>> Signed-off-by: Jakub Jermář <jakub.jermar@kernkonzept.com>
>>>>> ---
>>>>>  target/mips/helper.c | 17 ++++++++++-------
>>>>>  1 file changed, 10 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/target/mips/helper.c b/target/mips/helper.c
>>>>> index c44cdca3b5..132d073fbe 100644
>>>>> --- a/target/mips/helper.c
>>>>> +++ b/target/mips/helper.c
>>>>> @@ -43,7 +43,7 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>>>>>                          target_ulong address, int rw, int access_type)
>>>>>  {
>>>>>      *physical = address;
>>>>> -    *prot = PAGE_READ | PAGE_WRITE;
>>>>> +    *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>>>>>      return TLBRET_MATCH;
>>>>>  }
>>>>>  
>>>>> @@ -61,7 +61,7 @@ int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>>>>>      else
>>>>>          *physical = address;
>>>>>  
>>>>> -    *prot = PAGE_READ | PAGE_WRITE;
>>>>> +    *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>>>>>      return TLBRET_MATCH;
>>>>>  }
>>>>>  
>>>>> @@ -101,6 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>>>>>                  *prot = PAGE_READ;
>>>>>                  if (n ? tlb->D1 : tlb->D0)
>>>>>                      *prot |= PAGE_WRITE;
>>>>> +                if (!(n ? tlb->XI1 : tlb->XI0)) {
>>>>> +                    *prot |= PAGE_EXEC;
>>>>> +                }
>>>>
>>>> This was indeed missed in commit 2fb58b73746e.

Aleksandar, if this patch is OK with you, can you amend this comment,
and add the "Fixes:" tag too when applying? Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>>>>
>>>>>                  return TLBRET_MATCH;
>>>>>              }
>>>>>              return TLBRET_DIRTY;
>>>>> @@ -182,7 +185,7 @@ static int get_seg_physical_address(CPUMIPSState *env, hwaddr *physical,
>>>>>      } else {
>>>>>          /* The segment is unmapped */
>>>>>          *physical = physical_base | (real_address & segmask);
>>>>> -        *prot = PAGE_READ | PAGE_WRITE;
>>>>> +        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>>>>>          return TLBRET_MATCH;
>>>>>      }
>>>>>  }
>>>>> @@ -913,8 +916,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>>>>>      }
>>>>>      if (ret == TLBRET_MATCH) {
>>>>>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>>>>> -                     physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
>>>>> -                     mmu_idx, TARGET_PAGE_SIZE);
>>>>> +                     physical & TARGET_PAGE_MASK, prot, mmu_idx,
>>>>> +                     TARGET_PAGE_SIZE);
>>>>>          ret = 0;
>>>>>      } else if (ret < 0)
>>>>>  #endif
>>>>> @@ -936,8 +939,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>>>>>                                             address, rw, access_type, mmu_idx);
>>>>>                  if (ret == TLBRET_MATCH) {
>>>>>                      tlb_set_page(cs, address & TARGET_PAGE_MASK,
>>>>> -                            physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
>>>>> -                            mmu_idx, TARGET_PAGE_SIZE);
>>>>> +                            physical & TARGET_PAGE_MASK, prot, mmu_idx,
>>>>> +                            TARGET_PAGE_SIZE);
>>>>>                      ret = 0;
>>>>>                      return ret;
>>>>>                  }
>>>>>
>>>>
>>>> Your patch looks correct, but I'd like to test it.
>>>> Do you have a reproducer?
>>>> Can you describe the command line you used?
>>>
>>> I've just attached a reproducer image and script to the bug. It's a
>>> 32-bit little-endian test binary running on top of the L4Re microkernel.

I can't get the "TAP" output you described on launchpad.

>>> Let me know if you also need a 64-bit version.

64-bit version is welcomed.

>>> I tested both 32 and 64-bit versions of the reproducer and also checked
>>> to see that the the other images I have lying around here (Linux 2.6.32
>>> big endian and HelenOS master little-endian, both 32-bit for 4Kc)
>>> continue to run without regressions.

Yes, definitively an improvement:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Regards,

Phil.

