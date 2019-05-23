Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB05C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543D02075B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i2EuFDH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543D02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnc9-0006PP-Dq
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:18:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTnMg-0000WM-Jb
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTnMf-0006o4-ME
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:02:34 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:33281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTnMf-0006nZ-HD
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:02:33 -0400
Received: by mail-yw1-xc43.google.com with SMTP id v81so2234819ywe.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=FRXAPmgejnkokyUn5/u6JjUKO4+pIqALDaTI9FL0/Qs=;
	b=i2EuFDH/Djtiz7jpC8oGaolNRNCmw8tTcG17wTdtIrdbQ3W4lCFwetCwML766LRZKI
	4q9QeBuEdLbUgwy6lCrRT+vCWEsBocxajXMafSbYbcHOPNlMG481H+NRhwfkhQ/1eAMR
	Q3zvO2pTaGiFA65a9rVAOFQpYGQf/Mu6Od+cJvNnz3gvux6YXWss4hC2/y08v0dTq5vN
	pDG6fIshnb8VDIjERiIqW/NB+Rea5pCdUvN9yrAShBmZvzCcGsIm/nRbvav/BLyZkvwb
	KhdBhXE9Qstb7G5A0uxSyox0Ash8MWn3GquPAaea/gV5kNdL8f3fL8WeiF9Yfq/Xk/v+
	CeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=FRXAPmgejnkokyUn5/u6JjUKO4+pIqALDaTI9FL0/Qs=;
	b=UCzB8mc9Vt2clx9nsS98RThLUE6A/RF8qFQ7UTr8cq5SJm3gOw9GcBl7HVReklZJ5A
	D/Iv7SdEOhAMp+Fe5NeReYGDZqGr+NpY1kGdn8O2yLhiXCM3lvTio5wwAVtK8Jn3qhXs
	SDcXo8x/x4C1hWoExTFARg+jN/4iM+PoJpLjceTDVuy8ZWvYDmlCaMs0ehdl5mbsnQM4
	0HP4kuF665gH7Pwc66ZpHg1pXFblkOGkLL7uqDlYmZd5LJGaM42JDiXw/JYsW6iBXZMK
	dz3gkZjyS8puOyK5yXW5V/Mdu2SrSPQJ+Ecyv2BjLGPcSE0+yB8FOSazrWfrTtPaalhs
	1BpA==
X-Gm-Message-State: APjAAAV+DVKaLKToTOgSQPgwJHN0A29Xxpq9Eq3kzBRa94lxopsRopvU
	SqHWjsDphhuJmndfrq5I75sOxQ==
X-Google-Smtp-Source: APXvYqwDZkRF9n6SyMxi+ruCmk9egs+YRXMgYgLTgDkFs3436gJNHyJIbtmU3Gc1cdHHOJJwVdik5A==
X-Received: by 2002:a81:5e84:: with SMTP id s126mr23702300ywb.32.1558616552359;
	Thu, 23 May 2019 06:02:32 -0700 (PDT)
Received: from [10.240.8.143] ([71.46.56.63]) by smtp.gmail.com with ESMTPSA id
	e6sm7294374ywe.104.2019.05.23.06.02.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 06:02:31 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190518191934.21887-1-richard.henderson@linaro.org>
	<20190518191934.21887-3-richard.henderson@linaro.org>
	<CAFEAcA88nA_2u1Yc-9ZPAy2w6LVk5f9Rrss0e53E11W4Xb4YpA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e177b43a-2abc-3aee-461c-2cfd9a8a0a20@linaro.org>
Date: Thu, 23 May 2019 09:02:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA88nA_2u1Yc-9ZPAy2w6LVk5f9Rrss0e53E11W4Xb4YpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Use tcg_gen_gvec_bitsel
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 8:46 AM, Peter Maydell wrote:
> On Sat, 18 May 2019 at 20:19, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This replaces 3 target-specific implementations for BIT, BIF, and BSL.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> @@ -10916,13 +10925,13 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
>>          return;
>>
>>      case 5: /* BSL bitwise select */
>> -        gen_gvec_op3(s, is_q, rd, rn, rm, &bsl_op);
>> +        gen_gvec_fn4(s, is_q, rd, rd, rn, rm, tcg_gen_gvec_bitsel, 0);
>>          return;
>>      case 6: /* BIT, bitwise insert if true */
>> -        gen_gvec_op3(s, is_q, rd, rn, rm, &bit_op);
>> +        gen_gvec_fn4(s, is_q, rd, rm, rn, rd, tcg_gen_gvec_bitsel, 0);
>>          return;
>>      case 7: /* BIF, bitwise insert if false */
>> -        gen_gvec_op3(s, is_q, rd, rn, rm, &bif_op);
>> +        gen_gvec_fn4(s, is_q, rd, rm, rd, rn, tcg_gen_gvec_bitsel, 0);
>>          return;
> 
> We were previously doing different operations for these three
> different instructions. Now we seem to always be doing the same
> thing but with randomly reshuffled register arguments. How
> does this work ?

Because the three different instructions perform the same operation with
reshuffled register arguments.

I'm not sure why we were using different operations in the beginning.  Possibly
because those formulations do not require a temporary?  Possibly that's how
they're written in the ARM ARM pseudocode?


r~

