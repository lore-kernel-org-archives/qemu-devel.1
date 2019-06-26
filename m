Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B2FC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3946121726
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3946121726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCWV-0004gt-8u
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41492)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hgCUv-00042V-Ox
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hgCUt-0000X5-GU
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:18:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:14230)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hgCUt-0000Qu-53
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:18:19 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 942777461AA;
 Wed, 26 Jun 2019 20:18:05 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5510C7456B4; Wed, 26 Jun 2019 20:18:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 434B174569A;
 Wed, 26 Jun 2019 20:18:05 +0200 (CEST)
Date: Wed, 26 Jun 2019 20:18:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <0ceec012-fcdc-ccde-291a-121a4e475f86@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.9999.1906262010500.23988@zero.eik.bme.hu>
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
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
> On 26/06/2019 08:45, Richard Henderson wrote:
>> On 6/25/19 7:55 PM, Mark Cave-Ayland wrote:
>>> And here's where we are blowing up according to -d in_asm,op_out_asm:
>>>
>>> IN:
>>> 0x00f22ca0:  101ffc84  vor      v0, v31, v31
>>>
>>> OP:
>>>  ld_i32 tmp0,env,$0xfffffff8
>>>  movi_i32 tmp1,$0x0
>>>  brcond_i32 tmp0,tmp1,lt,$L0
>>>
>>>  ---- 00f22ca0
>>>  ld_vec v128,e8,tmp2,env,$0xd6b0
>>>  st_vec v128,e8,tmp2,env,$0xd4c0
>>
>> Yep, that looks right.
>>
>> As an aside, this does suggest to me that target/ppc might be well served in
>> moving the ppc_vsr_t members of CPUPPCState earlier, so that this offset is
>> smaller.
>>
>>>  movi_i32 nip,$0xf22ca4
>>>  movi_i32 nip,$0xf22ca4
>>>  movi_i32 tmp0,$0x10002
>>>  call raise_exception,$0x2,$0,env,tmp0
>>
>> And this, presumably is the single-step debug exception.
>>
>>> 0xa4e7f12c:  3c400000  lis      r2, 0
>>> 0xa4e7f130:  6042d6b0  ori      r2, r2, 0xd6b0
>>> 0xa4e7f134:  7c5b10ce  lvx      v2, r27, r2
>>
>>> 0xa4e7f138:  3c400000  lis      r2, 0
>>> 0xa4e7f13c:  6042d4c0  ori      r2, r2, 0xd4c0
>>> 0xa4e7f140:  7c5b11ce  stvx     v2, r27, r2
>>
>> These also look correct.  Form an offset into r2, load or store from env+r2.
>>
>> This also shows what I mention above re offset.  For a ppc host, the offset is
>> large enough to require two instructions to form them.
>>
>>> Any ideas what might be going on here?
>>
>> What is the observed problem that makes you think that this is the incorrect
>> instruction?
>
> What I've been doing is set a breakpoint a few instructions before and then issuing
> "stepi" commands via the gdbstub. As I step over the "vor v0, v31, v31" instruction
> then either the qemu-system-ppc process segfaults outside of gdb, or inside gdb it
> goes to bg. Bringing it back to fg just causes gdb to get confused and in the end the
> only thing I can do is kill the gdb process.
>
> On the plus side I've managed to work out where we are faulting by hacking the load
> and store functions to inject trap opcodes in the ld_vec and st_vec and it appears
> that we are segfaulting here:
>
> OUT: [size=96]
> 0xa4e7f120:  81dbfff8  lwz      r14, -8(r27)
> 0xa4e7f124:  2f8e0000  cmpwi    cr7, r14, 0
> 0xa4e7f128:  419c004c  blt      cr7, 0xa4e7f174
> 0xa4e7f12c:  3c400000  lis      r2, 0
>                       ^^^^^^^^^^^^^^
> 0xa4e7f130:  6042d6b0  ori      r2, r2, 0xd6b0
> 0xa4e7f134:  7c5b10ce  lvx      v2, r27, r2
> 0xa4e7f138:  3c400000  lis      r2, 0
> 0xa4e7f13c:  6042d4c0  ori      r2, r2, 0xd4c0
> 0xa4e7f140:  7c5b11ce  stvx     v2, r27, r2
> 0xa4e7f144:  3dc000f2  lis      r14, 0xf2
> 0xa4e7f148:  61ce2ca4  ori      r14, r14, 0x2ca4
> 0xa4e7f14c:  91db016c  stw      r14, 0x16c(r27)
> 0xa4e7f150:  7f63db78  mr       r3, r27
> 0xa4e7f154:  3c800001  lis      r4, 1
> 0xa4e7f158:  60840002  ori      r4, r4, 2
> 0xa4e7f15c:  3c000087  lis      r0, 0x87
> 0xa4e7f160:  6000b618  ori      r0, r0, 0xb618
> 0xa4e7f164:  7c0903a6  mtctr    r0
> 0xa4e7f168:  4e800421  bctrl
> 0xa4e7f16c:  38600000  li       r3, 0
> 0xa4e7f170:  4bfffef0  b        0xa4e7f060
> 0xa4e7f174:  3c60a4e7  lis      r3, -0x5b19
> 0xa4e7f178:  6063f0c3  ori      r3, r3, 0xf0c3
> 0xa4e7f17c:  4bfffee4  b        0xa4e7f060
>
> Interestingly if I set a trap and then switch the opcode to "lis r4,0" (0x3c800000)
> then we carry on as normal until the next "lis r2,0" instruction. Looking through the
> whole output of -d out_asm this is the first mention of r2 which makes me wonder if
> it is special somehow? At least a quick search indicates that for 32-bit PPC r2 is
> supposed to be dedicated as a TOC pointer.

According to a PowerPC ABI doc: 
http://refspecs.linux-foundation.org/elf/elfspec_ppc.pdf
r2 is system reserved and should not be used by application code and 
another one (probably the same you were referring to mentions TOC 
https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#REG. 
I'm not sure if that's relevant for the above but it looks like clobbering 
r2 might cause problems.

Regards,
BALATON Zoltan

