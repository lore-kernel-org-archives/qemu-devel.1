Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8F9C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 19:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC62216FD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 19:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC62216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgDiJ-0005NK-Fz
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 15:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57032)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hgDfr-00046D-0w
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 15:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hgDfn-0005GP-Dy
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 15:33:40 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:34460
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hgDfh-0004oc-PF
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 15:33:37 -0400
Received: from host86-173-229-95.range86-173.btcentralplus.com
 ([86.173.229.95] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hgDed-0003B1-Ho; Wed, 26 Jun 2019 20:32:27 +0100
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20190319172126.7502-1-richard.henderson@linaro.org>
 <20190319172126.7502-13-richard.henderson@linaro.org>
 <alpine.BSF.2.21.9999.1906262030380.23988@zero.eik.bme.hu>
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
Message-ID: <4a9eb686-8b7e-1bf3-3787-112f4ee45cac@ilande.co.uk>
Date: Wed, 26 Jun 2019 20:32:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1906262030380.23988@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.173.229.95
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: Re: [Qemu-devel] [PATCH for-4.1 v3 12/17] tcg/ppc: Initial backend
 support for Altivec
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/06/2019 19:36, BALATON Zoltan wrote:

> On Tue, 19 Mar 2019, Richard Henderson wrote:
>> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
>> index ec8e336be8..70a64dd214 100644
>> --- a/tcg/ppc/tcg-target.inc.c
>> +++ b/tcg/ppc/tcg-target.inc.c
>> @@ -42,6 +42,9 @@
>> # define TCG_REG_TMP1   TCG_REG_R12
>> #endif
>>
>> +#define TCG_VEC_TMP1    TCG_REG_V0
>> +#define TCG_VEC_TMP2    TCG_REG_V1
>> +
>> #define TCG_REG_TB     TCG_REG_R31
>> #define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
>>
>> @@ -61,6 +64,7 @@
>>
>> static tcg_insn_unit *tb_ret_addr;
>>
>> +bool have_isa_altivec;
>> bool have_isa_2_06;
>> bool have_isa_3_00;
>>
>> @@ -72,39 +76,15 @@ bool have_isa_3_00;
>> #endif
>>
>> #ifdef CONFIG_DEBUG_TCG
>> -static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
>> -    "r0",
>> -    "r1",
>> -    "r2",
>> -    "r3",
>> -    "r4",
>> -    "r5",
>> -    "r6",
>> -    "r7",
>> -    "r8",
>> -    "r9",
>> -    "r10",
>> -    "r11",
>> -    "r12",
>> -    "r13",
>> -    "r14",
>> -    "r15",
>> -    "r16",
>> -    "r17",
>> -    "r18",
>> -    "r19",
>> -    "r20",
>> -    "r21",
>> -    "r22",
>> -    "r23",
>> -    "r24",
>> -    "r25",
>> -    "r26",
>> -    "r27",
>> -    "r28",
>> -    "r29",
>> -    "r30",
>> -    "r31"
>> +static const char tcg_target_reg_names[TCG_TARGET_NB_REGS][4] = {
>> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
>> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
>> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
>> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
>> +    "v0",  "v1",  "v2",  "v3",  "v4",  "v5",  "v6",  "v7",
>> +    "v8",  "v9",  "v10", "v11", "v12", "v13", "v14", "v15",
>> +    "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
>> +    "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31",
>> };
>> #endif
>>
>> @@ -139,6 +119,26 @@ static const int tcg_target_reg_alloc_order[] = {
>>     TCG_REG_R5,
>>     TCG_REG_R4,
>>     TCG_REG_R3,
> 
> Purely guessing without knowing anything about this but would removing TCG_REG_R2
> from this tcg_target_reg_alloc_order[] list help? Question is why it was not a
> problem before?

Thanks for the suggestion, but I've just tried it and it doesn't seem to make any
difference :(


ATB,

Mark.

