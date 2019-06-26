Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8B8C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 17:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6236F20665
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 17:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6236F20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgBMH-0004XS-FD
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 13:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43285)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hgBKY-0003Qw-SV
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 13:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hgBKX-0002k3-Mg
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 13:03:34 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:34248
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hgBKX-0001tC-GK
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 13:03:33 -0400
Received: from host86-173-229-95.range86-173.btcentralplus.com
 ([86.173.229.95] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hgBGz-0002nR-4P; Wed, 26 Jun 2019 17:59:53 +0100
To: Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
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
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <0ceec012-fcdc-ccde-291a-121a4e475f86@ilande.co.uk>
Date: Wed, 26 Jun 2019 18:00:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <16f26b7f-2435-aa05-66a3-073e8310d5c8@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.173.229.95
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/06/2019 08:45, Richard Henderson wrote:

> On 6/25/19 7:55 PM, Mark Cave-Ayland wrote:
>> And here's where we are blowing up according to -d in_asm,op_out_asm:
>>
>> IN:
>> 0x00f22ca0:  101ffc84  vor      v0, v31, v31
>>
>> OP:
>>  ld_i32 tmp0,env,$0xfffffff8
>>  movi_i32 tmp1,$0x0
>>  brcond_i32 tmp0,tmp1,lt,$L0
>>
>>  ---- 00f22ca0
>>  ld_vec v128,e8,tmp2,env,$0xd6b0
>>  st_vec v128,e8,tmp2,env,$0xd4c0
> 
> Yep, that looks right.
> 
> As an aside, this does suggest to me that target/ppc might be well served in
> moving the ppc_vsr_t members of CPUPPCState earlier, so that this offset is
> smaller.
> 
>>  movi_i32 nip,$0xf22ca4
>>  movi_i32 nip,$0xf22ca4
>>  movi_i32 tmp0,$0x10002
>>  call raise_exception,$0x2,$0,env,tmp0
> 
> And this, presumably is the single-step debug exception.
> 
>> 0xa4e7f12c:  3c400000  lis      r2, 0
>> 0xa4e7f130:  6042d6b0  ori      r2, r2, 0xd6b0
>> 0xa4e7f134:  7c5b10ce  lvx      v2, r27, r2
> 
>> 0xa4e7f138:  3c400000  lis      r2, 0
>> 0xa4e7f13c:  6042d4c0  ori      r2, r2, 0xd4c0
>> 0xa4e7f140:  7c5b11ce  stvx     v2, r27, r2
> 
> These also look correct.  Form an offset into r2, load or store from env+r2.
> 
> This also shows what I mention above re offset.  For a ppc host, the offset is
> large enough to require two instructions to form them.
> 
>> Any ideas what might be going on here?
> 
> What is the observed problem that makes you think that this is the incorrect
> instruction?

What I've been doing is set a breakpoint a few instructions before and then issuing
"stepi" commands via the gdbstub. As I step over the "vor v0, v31, v31" instruction
then either the qemu-system-ppc process segfaults outside of gdb, or inside gdb it
goes to bg. Bringing it back to fg just causes gdb to get confused and in the end the
only thing I can do is kill the gdb process.

On the plus side I've managed to work out where we are faulting by hacking the load
and store functions to inject trap opcodes in the ld_vec and st_vec and it appears
that we are segfaulting here:

OUT: [size=96]
0xa4e7f120:  81dbfff8  lwz      r14, -8(r27)
0xa4e7f124:  2f8e0000  cmpwi    cr7, r14, 0
0xa4e7f128:  419c004c  blt      cr7, 0xa4e7f174
0xa4e7f12c:  3c400000  lis      r2, 0
                       ^^^^^^^^^^^^^^
0xa4e7f130:  6042d6b0  ori      r2, r2, 0xd6b0
0xa4e7f134:  7c5b10ce  lvx      v2, r27, r2
0xa4e7f138:  3c400000  lis      r2, 0
0xa4e7f13c:  6042d4c0  ori      r2, r2, 0xd4c0
0xa4e7f140:  7c5b11ce  stvx     v2, r27, r2
0xa4e7f144:  3dc000f2  lis      r14, 0xf2
0xa4e7f148:  61ce2ca4  ori      r14, r14, 0x2ca4
0xa4e7f14c:  91db016c  stw      r14, 0x16c(r27)
0xa4e7f150:  7f63db78  mr       r3, r27
0xa4e7f154:  3c800001  lis      r4, 1
0xa4e7f158:  60840002  ori      r4, r4, 2
0xa4e7f15c:  3c000087  lis      r0, 0x87
0xa4e7f160:  6000b618  ori      r0, r0, 0xb618
0xa4e7f164:  7c0903a6  mtctr    r0
0xa4e7f168:  4e800421  bctrl
0xa4e7f16c:  38600000  li       r3, 0
0xa4e7f170:  4bfffef0  b        0xa4e7f060
0xa4e7f174:  3c60a4e7  lis      r3, -0x5b19
0xa4e7f178:  6063f0c3  ori      r3, r3, 0xf0c3
0xa4e7f17c:  4bfffee4  b        0xa4e7f060

Interestingly if I set a trap and then switch the opcode to "lis r4,0" (0x3c800000)
then we carry on as normal until the next "lis r2,0" instruction. Looking through the
whole output of -d out_asm this is the first mention of r2 which makes me wonder if
it is special somehow? At least a quick search indicates that for 32-bit PPC r2 is
supposed to be dedicated as a TOC pointer.

Is there a quick way to disable r2 from the list of available registers to see if
that gets things going?


ATB,

Mark.

