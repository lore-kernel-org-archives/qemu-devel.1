Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86402C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 17:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0FF20663
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 17:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0FF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34368 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfpgW-0000Qg-CN
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 13:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42287)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hfpg1-0008QI-MB
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 13:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hfpg0-0005xM-Hc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 13:56:17 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:60128
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hfpg0-0005oG-Ah
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 13:56:16 -0400
Received: from host86-173-229-95.range86-173.btcentralplus.com
 ([86.173.229.95] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hfpfI-0007jW-QT; Tue, 25 Jun 2019 18:55:33 +0100
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
Message-ID: <d2c1f979-7ff2-946e-4863-c1be19c5f003@ilande.co.uk>
Date: Tue, 25 Jun 2019 18:55:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <68facefc-b801-4902-11c0-4542662bfc4e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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

On 25/06/2019 16:56, Richard Henderson wrote:

> On 6/25/19 5:37 PM, Mark Cave-Ayland wrote:
>> The problem is that in tcg/tcg-op.h we define "DEF(dup2_vec, 1, 2, 0, IMPLVEC |
>> IMPL(TCG_TARGET_REG_BITS == 32))" and in the last patchset dup2_vec isn't introduced
>> until towards the end. Unfortunately it's not a simple as bringing the patch forward
>> within the series to maintain bisectability because the current implementation
>> depends on VMRG which only appears in the patch just before it...
> 
> Ah, that would explain it.  I admit I haven't looked at v5 that closely.

It's actually the same in both patchsets: I'm still playing with v4 at the moment
since I have a few hacks in place to help me figure out what's going on.

>> Next to try and figure out what exactly is causing the fault. Just a quick question
>> out of curiosity: is your Power9 system BE or LE?
> 
> The Power9 is LE.
> 
> I do have access to a Power7 BE system, and that worked last time I checked.
> I'll try that again tomorrow to be sure.

And here's where we are blowing up according to -d in_asm,op_out_asm:

IN:
0x00f22ca0:  101ffc84  vor      v0, v31, v31

OP:
 ld_i32 tmp0,env,$0xfffffff8
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,lt,$L0

 ---- 00f22ca0
 ld_vec v128,e8,tmp2,env,$0xd6b0
 st_vec v128,e8,tmp2,env,$0xd4c0
 movi_i32 nip,$0xf22ca4
 movi_i32 nip,$0xf22ca4
 movi_i32 tmp0,$0x10002
 call raise_exception,$0x2,$0,env,tmp0
 exit_tb $0x0
 set_label $L0
 exit_tb $0xa4e7f0c3

OUT: [size=96]
0xa4e7f120:  81dbfff8  lwz      r14, -8(r27)
0xa4e7f124:  2f8e0000  cmpwi    cr7, r14, 0
0xa4e7f128:  419c004c  blt      cr7, 0xa4e7f174
0xa4e7f12c:  3c400000  lis      r2, 0
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

Any ideas what might be going on here?


ATB,

Mark.

