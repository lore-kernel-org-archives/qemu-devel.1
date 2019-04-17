Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37736C10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 08:21:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098842073F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 08:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098842073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48847 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGfoV-0003ud-QT
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 04:21:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hGfnN-0003J8-3D
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hGfnM-0001OF-1I
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:19:53 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48971 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hGfnL-0000c8-KN
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:19:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 0DDAC1A4143;
	Wed, 17 Apr 2019 10:18:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.97] (rtrkw310-lin.domain.local [10.10.13.97])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 07AEF1A245E;
	Wed, 17 Apr 2019 10:17:00 +0200 (CEST)
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554383690-28338-5-git-send-email-mateja.marjanovic@rt-rk.com>
	<CAL1e-=i3H+aMaOCqMBkK4r9E4Ezqtyqw=VbwNmJZ6Wnc3in5PA@mail.gmail.com>
	<bcc405c5-2e96-19a9-123e-bc607c243209@rt-rk.com>
	<BN6PR2201MB1251458C6A26DEE093C282EEC6240@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <e6bd1e28-d0a1-9e86-d249-37ab16bb8de8@rt-rk.com>
Date: Wed, 17 Apr 2019 10:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251458C6A26DEE093C282EEC6240@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: Re: [Qemu-devel] [PATCH v6 4/4] target/mips: Optimize
 ILVR.<B|H|W|D> MSA instructions
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
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417081659.OURALf9yfKOnW28kLpU-_QoOoNi4VaHaY6DB8Gf7ZOM@z>


On 16.4.19. 23:20, Aleksandar Markovic wrote:
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>>> +void helper_msa_ilvr_b(CPUMIPSState *env, uint32_t wd,
>>>> +                       uint32_t ws, uint32_t wt)
>>>> +{
>>>> +    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
>>>> +    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
>>>> +    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
>>>> +
>>> Why do we use here env->active_fpu.fpr[wd].wr, while for other instructions in
>>> this patch, we access msa_wr_d<b|h|w|d[] directly?
>> With a pointer to wr_t we have an array of bytes, halfwords, words or
>> doublewords
>> and can read from them and change them like an ordinary array. In other
>> cases
>> we use a variable that is TCGv_i64 and would have to use tcg_gen
>> functions to
>> modify the value of the register. Before my changes in ilvr instruction
>> helpers
>> env->active_fpu.fpr[wd].wr was used, so I just copy-pasted that.
>>
> Your answer touches just surface, and doesn't fully answer my question.
> I would like you to show deeper understanding of the code you are working
> with. You can't just copy/paste without thinking.
>
> Why do majority of MSA helpers use env->active_fpu.fpr[<index>].wr, while
> your code mostly reference the MSA register directly? Is this the same
> thing? If yes, why all MSA code doesn't use registers directly, which
> would certainly be simpler than referencing active_fpu? What is the role
> of "active_fpu"? Can it be changed? Can you analyze the underlying
> reasons for referencing "active_fpu", and can you claim that it is safe
> to circumvent it and reference the MSA registers directly?
I will look into that, and try to analyze it and understand it.
Thanks,
Mateja
> Thanks,
> Aleksandar

