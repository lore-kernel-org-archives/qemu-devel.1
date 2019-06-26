Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBD6C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5032085A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5032085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgERH-0000f9-2q
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 16:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39455)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hgEQN-0000D7-2M
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hgEQM-0001zf-0r
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:21:47 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:28258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hgEQL-0001xr-N3
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:21:45 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 15C0B7461AE;
 Wed, 26 Jun 2019 22:21:39 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 744AC7461AA; Wed, 26 Jun 2019 22:21:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6904374569A;
 Wed, 26 Jun 2019 22:21:38 +0200 (CEST)
Date: Wed, 26 Jun 2019 22:21:38 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <9502af13-22b9-031e-2ba9-ec4ff75ccd0e@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.9999.1906262217430.56732@zero.eik.bme.hu>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
 <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
 <085d6881-f518-9888-a13e-081cdc09de46@ilande.co.uk>
 <0b9f4772-37f6-1453-e4ea-5ad9d0f52a5b@ilande.co.uk>
 <acc57487-c8a0-9380-bc2a-4de22541eabf@ilande.co.uk>
 <CAL1e-=iavFqEeFuNm2efVM7mu5OaABBVo90wqJEhmoWa4DQv=Q@mail.gmail.com>
 <ffae3651-5daf-e008-6562-2de09d82ace9@linaro.org>
 <b8aab3f4-e3eb-a137-62b4-ba5ac1a2ad8f@ilande.co.uk>
 <68facefc-b801-4902-11c0-4542662bfc4e@linaro.org>
 <d2c1f979-7ff2-946e-4863-c1be19c5f003@ilande.co.uk>
 <16f26b7f-2435-aa05-66a3-073e8310d5c8@linaro.org>
 <0ceec012-fcdc-ccde-291a-121a4e475f86@ilande.co.uk>
 <7b1699e1-28ca-a58f-787e-c0ca11666b90@linaro.org>
 <9502af13-22b9-031e-2ba9-ec4ff75ccd0e@ilande.co.uk>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019, Mark Cave-Ayland wrote:
> On 26/06/2019 19:42, Richard Henderson wrote:
>
>> On 6/26/19 7:00 PM, Mark Cave-Ayland wrote:
>>> Interestingly if I set a trap and then switch the opcode to "lis r4,0" (0x3c800000)
>>> then we carry on as normal until the next "lis r2,0" instruction. Looking through the
>>> whole output of -d out_asm this is the first mention of r2 which makes me wonder if
>>> it is special somehow? At least a quick search indicates that for 32-bit PPC r2 is
>>> supposed to be dedicated as a TOC pointer.
>>>
>>> Is there a quick way to disable r2 from the list of available registers to see if
>>> that gets things going?
>>
>> Interesting.  I'm not sure why that's happening.
>>
>> As a quick hack,
>>
>>
>>   /* For some memory operations, we need a scratch that isn't R0.  For the AIX
>>      calling convention, we can re-use the TOC register since we'll be reloading
>>      it at every call.  Otherwise R12 will do nicely as neither a call-saved
>>      register nor a parameter register.  */
>> - #ifdef _CALL_AIX
>> + #if 0
>>   # define TCG_REG_TMP1   TCG_REG_R2
>>   #else
>>   # define TCG_REG_TMP1   TCG_REG_R12
>>   #endif
>>
>>
>> But I thought that _CALL_AIX was only defined for ppc64 elf version 1.  I
>> thought that ppc32 used _CALL_SYSV instead.  Certainly that's what is used
>> elsewhere...
>
> No, that didn't work either. I've confirmed using #ifdef _CALL_AIX #error ERROR
> #endif that _CALL_AIX is *NOT* defined and _CALL_SYSV *is* defined.
>
> I've also tried removing TCG_REG_R2 from tcg_target_reg_alloc_order[] and
> tcg_regset_set_reg() for TCG_REG_R2 from tcg_target_init() and I'm still generating
> bad code that writes to r2(!).
>
> Since I can't find any other mentions of TCG_REG_TMP1 and TCG_REG_R2 that isn't
> inside an #ifdef _CALL_AIX ... #endif section I'm starting to get stuck. Is there any
> chance that the R_PPC_ADDR32 change could be causing this at all?

There's one more mention of TCG_REG_R2 in tcg-target.inc.c 
tcg_target_init() function where it's set as call clobber but then later 
in same func again as reserved if _CALL_SYSV or 64 bits. Not sure if the 
later tcg_regset_set_reg overrides the first one or that should be removed 
or put in an #else of the later conditional call. (Still don't know what 
I'm talking about just trowing random ideas.)

Regards,
BALATON Zoltan

