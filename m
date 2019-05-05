Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F5BC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 14:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9D32082F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 14:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhePf3IV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9D32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41967 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNIF4-0005AM-Jt
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 10:35:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIED-0004ix-AX
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIEC-0006yu-Di
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:34:57 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNIEC-0006yM-5l
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:34:56 -0400
Received: by mail-pl1-x643.google.com with SMTP id z8so5049329pln.4
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 07:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=YXNXzh3ndtKQMB7Ka75W5UZuj30pVMuG1+R2kp65FYc=;
	b=NhePf3IVLSTiAyD+P1N48NOlt+QxnTmjjFbEvAnoqiJPA09zxlpwtoJGCbm63VSsah
	VDdRLW83L0fx/NU+mGKjWUWgkAARQdVJiWXTp0520jAipvC/61X5QZKfcP9Dmm1qHJjC
	ewhAJSuk+BnwA3u2cod0vwndEdqu+sJ015kEJblpI4JzzbRekhe6Ga+6dXvmFS4boYjj
	TX2xyU9eCfsmhh5OulPhIAgCSH0ikrYD/aiCXl9eKAbfLmmumV9H8xYWzGUYnLccm2Oi
	Blt0q72nYgc8GwXI8htfTctGMzy9qIHGNODgPm3Ke8eAHTerzje8b68m/gwOQbysktzG
	IWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=YXNXzh3ndtKQMB7Ka75W5UZuj30pVMuG1+R2kp65FYc=;
	b=AkexFlmJpxhYqkVKAb+Qlpp9emmHBGpVYDl5wfvlS1vWZCLMxJY4Q+xvADn7Z0J1eC
	hOw9fNfsLM+EMrUU/oa8mfmtDhDpmeq1Xcziw3rVM8/lgW1PORHUYxybCLEXbLX5NLN8
	gcXaY6q4xKdZiv62KIby09OXEmOuLjyGVFzaK0ZXpvLRBND1Sj9Y/D+M2nA3Au84fTwP
	vgyzHGYPJh1qRhv/dbUwNXNmQ8EE7jBDYKcUIXpJ+xvgtR2YVlImv5LAbciDZG7iaYVZ
	0z+P5iU4dty+aI2kLT2q0KAmJ55P891V57xBjUNJlbsA/HcjOP4+rHJLwuJ4Kl1WKqr2
	oEKw==
X-Gm-Message-State: APjAAAWImf1WkE7yDuTuzsiXRVNHc7rYM5f0UXS3/1MLD53qt0B5uFVc
	NDAS/3h1O7H5DJe11THwGYHhKg==
X-Google-Smtp-Source: APXvYqx2sIOD9b5fwdNBlja4zv0cNxKqs5OJzJtvOaKD4bZqq/IxNaya6D8W+tXPVTkN0kEUwq0gkw==
X-Received: by 2002:a17:902:2a07:: with SMTP id
	i7mr20251035plb.125.1557066894748; 
	Sun, 05 May 2019 07:34:54 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	k14sm23811476pfj.171.2019.05.05.07.34.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 07:34:54 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-3-mark.cave-ayland@ilande.co.uk>
	<55204805-9275-2bc4-2c38-51dc87aa836d@linaro.org>
	<7227a96f-ae59-3ed4-8b1f-9e92005b4a69@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <626519f6-28c2-9870-0c6d-12869fbf57f1@linaro.org>
Date: Sun, 5 May 2019 07:34:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7227a96f-ae59-3ed4-8b1f-9e92005b4a69@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH 02/14] target/ppc: remove getVSR()/putVSR()
 from mem_helper.c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505143452.6_ShHX6tou6WVuql2m0QgA0zPI7d3VWbmOBSN-VIfa4@z>

On 5/5/19 2:34 AM, Mark Cave-Ayland wrote:
>>>      EA = tcg_temp_new();                                        \
>>> -    xt = tcg_const_tl(xT(ctx->opcode));                         \
>>>      gen_set_access_type(ctx, ACCESS_INT);                       \
>>>      gen_addr_register(ctx, EA);                                 \
>>> -    gen_helper_##name(cpu_env, EA, xt, cpu_gpr[rB(ctx->opcode)]); \
>>> +    xt = tcg_const_tl(xT(ctx->opcode));                         \
>>> +    rb = tcg_const_tl(rB(ctx->opcode));                         \
>>> +    gen_helper_##name(cpu_env, EA, xt, rb);                     \
>>>      tcg_temp_free(EA);                                          \
>>>      tcg_temp_free(xt);                                          \
>>> +    tcg_temp_free(rb);                                          \
>>>  }
>>
>> Why are you adjusting the function to pass the rB register number rather than
>> the contents of rB?  That seems the wrong way around...
> 
> I think what I was trying to do here was eliminate the cpu_gpr since it
> feels to me that with the vector patchsets and your negative offset patches
> that this should be the way to go for accessing CPUState rather than using
> TCG globals.

Not for the integer register set.

> Looking at this again I realise the solution is really the same as is
> currently used
> for gen_load_spr() so I can use something like this:>
>     static inline void gen_load_gpr(TCGv t, int reg)
>     {
>         tcg_gen_ld_tl(t, cpu_env, offsetof(CPUPPCState, gpr[reg]));
>     }
> 
> Does this seem reasonable as a solution?

No, this will fail quickly.


r~

