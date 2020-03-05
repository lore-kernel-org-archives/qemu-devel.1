Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E25EC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27AE62072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrsfFiIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AE62072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ssq-0000uY-CO
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 10:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j9ss4-0000JA-Nj
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j9ss3-0006H1-I6
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:57:12 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:45721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j9ss3-0006CL-AE
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:57:11 -0500
Received: by mail-pg1-x52d.google.com with SMTP id m15so2944537pgv.12
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Aj1j9q1kdsqVBtMkYyKH6uLYz+CzIcrft2h4WyHB374=;
 b=WrsfFiIOoOSxyg7SwnEQQFTzLIRNB7y7s0CCodvj4PemhQ4u3eWG5WUOGPAD0n7+2I
 9CtcUizxuCyvKa7H6MNtb3mgP93I5n+Y0EyMSNCRNYKjTllYAbMPTfgmI4fCIJVDcJ9D
 hKAHE0XX9wNsUz9BGQL9j6ET0Mj2gPfuHqcniOHXBoTGOX3SWCeTMm8D68YYs93MdNzp
 7LktxyUofFyo3an3rTpuPESn+2+l1yWCuhrVlUanlIa9u1ZJ2Bf1KgrjTCXtDf3yec3y
 0IxlygAOdD5ggkU5PvCy1UdOArPdGD3AtfjR5EQijzCk7NkYenmfWMMPJaPT4EmPff3J
 fmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Aj1j9q1kdsqVBtMkYyKH6uLYz+CzIcrft2h4WyHB374=;
 b=SaE/sb05I5zNQmYm1jlc2sC86gSeycUoo/vne0kiKvKVLexRNL0SZlnhDycXJa6n0C
 M7CWSV+O+pd5fx7+8m2dNxDQPOP9Ecn2OXPZCPgqLOWjFzIpaDgMABliLzmmqK9S+oUC
 aeiCJSFLdY20bL2lvpwYwiETWk2hfxJlY11pAndmXMln9Atknjv+X05mtjuPoPclWMIF
 pdyWyj/2qOfuRXL3QyPI5fy6B+uvY6rmXFUHP6hx86GLcsougckicPhuYD3AABpM4wIN
 amlMmdFWE6+yUlC1UU/mPeKTpPw+bQt/6tv6AfdEH3Qd8WFnYkIPWKJOyUYmX5MoQOMc
 Krow==
X-Gm-Message-State: ANhLgQ1FGbYvEwyIN/kJc22GVJSxMepYjF8rXb20ncm1uNmPyzUF3FjK
 KKG7wfhKpUZc6b0UlfkjYdSDDQ==
X-Google-Smtp-Source: ADFU+vuRvfy6kRhtrNmfuqsxLcngbxNmBEHoWCwSUzXmYtYz2HPQ11w2v/QHz1W3MUS0JvChnMgBlg==
X-Received: by 2002:a62:3603:: with SMTP id d3mr8574284pfa.37.1583423828401;
 Thu, 05 Mar 2020 07:57:08 -0800 (PST)
Received: from [10.0.3.1] ([156.19.247.250])
 by smtp.gmail.com with ESMTPSA id w195sm30122629pfd.65.2020.03.05.07.57.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 07:57:07 -0800 (PST)
Subject: Re: [PATCH v2 8/9] target/arm: Check addresses for disabled regimes
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200302175829.2183-1-richard.henderson@linaro.org>
 <20200302175829.2183-9-richard.henderson@linaro.org>
 <CAFEAcA8vEHctFuYfaziQs1QobbrHJgMioATwF7QkWL-e=gLxJw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d74accc4-7671-2d91-8acb-206487f0a915@linaro.org>
Date: Thu, 5 Mar 2020 07:57:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8vEHctFuYfaziQs1QobbrHJgMioATwF7QkWL-e=gLxJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 6:21 AM, Peter Maydell wrote:
>>      if (regime_translation_disabled(env, mmu_idx)) {
>> -        /* MMU disabled. */
>> +        /*
>> +         * MMU disabled.  S1 addresses are still checked for bounds.
>> +         * C.f. AArch64.TranslateAddressS1Off.
>> +         */
>> +        if (is_a64(env) && mmu_idx != ARMMMUIdx_Stage2) {
> 
> This looks weird -- why do we care about whether the current
> EL is aarch64, rather than looking at the controlling EL
> for the translation regime ?

You're right, it should be the aa64-ness of the regime_el.
Thanks,


r~

