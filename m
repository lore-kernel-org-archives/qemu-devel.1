Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E8CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 02:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D5320789
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 02:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnbL2g/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D5320789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSWRz-0005SA-Ts
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 22:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSWRE-00051x-Lb
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:22:49 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSWRA-0008SN-Bj
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:22:47 -0400
Received: by mail-pg1-x544.google.com with SMTP id x16so1015794pgj.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 19:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BVokIJQto8uj/fI7EFWrYsqZIYTVTkFkRpzdaxLDSvY=;
 b=hnbL2g/oTLT6icOu4DyZtAOimDFrOWPg8NqbZf2SBRg56A2kSo/Xt7D0A/KYHr7EYk
 5XMS6j/tc0BWUUQEuIpayHsGNN8xieqO5959LRWQWH5cH/QZsrWomXB8QqqKYWnOtCNJ
 fj/pcOLypWMqDeCMwbX1Kx0h2qPRStUbbEyPRR0LQXOfLFlLPJKeeBuqwAI1u5qdD7Q+
 viv9FLSeLrnf1G32qtO4l253QBNfftFnqco0SG2j0eYvPteF1cvU0d4gk/sPcba3xTEE
 pU78rt1eqL+x8yEIaKVgYtDUTmZwwNuTFCYd5MOFw8qz61kcPKHqpqf6dhgEOHGlflI1
 PhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BVokIJQto8uj/fI7EFWrYsqZIYTVTkFkRpzdaxLDSvY=;
 b=Y0dBdRuqDScXS/S07OITqnWJhrGPwFSxZmbRt19z1mb0/S34x3Y8bH3UtKvzMovOkg
 DHMx3sB7xuqTCDK+SLsmw17JQ9NxdO5v2z7l5R7J6VaYXq9rbCNaEsQMl0IgiYUdGBt2
 2rtOtOq8XTej9MOkHd2+M9LPLNGlpRwr5yxAAGXonXgiYPiGlemYVLcMhpHRT6fcsxQm
 wIXm3Iy34RhKHPIAdIwMlctIkepf9nj7kn80ou+XY+awY9+PB/goC095mOFMb4G9ZKRL
 Z86T4Wtm2ucbwNs4ix1F7hGte/qtXfA9KodwYBMdKjnk7oJZjBJ5+wrai0qRPk+b3cRc
 UkPA==
X-Gm-Message-State: AOAM5328BlfRZ43mqtVz0KZvIswcy4hu+wImcDxkhSOMDucVVAnczrCU
 MtpkRFisfOv3wZzGGBexANfvwg==
X-Google-Smtp-Source: ABdhPJzfIilheomDesfO89xg469sRah4qjmkdDBSB0aYXrkpdSewY7n5FEcnp8P9LDvKSMThdkOSMA==
X-Received: by 2002:a62:42:0:b029:152:4ed9:1f6d with SMTP id
 63-20020a6200420000b02901524ed91f6dmr2457883pfa.32.1602642162495; 
 Tue, 13 Oct 2020 19:22:42 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id z142sm1051161pfc.179.2020.10.13.19.22.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 19:22:41 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a CPU
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Victor Kamensky <kamensky@cisco.com>
References: <20201013132535.3599453-1-f4bug@amsat.org>
 <7b059e2f-b868-82b3-3d96-bd4e93d36368@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b4818cf4-4598-b7ac-a640-145eaab57f7f@linaro.org>
Date: Tue, 13 Oct 2020 19:22:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7b059e2f-b868-82b3-3d96-bd4e93d36368@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Khem Raj <raj.khem@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 4:11 PM, Richard Henderson wrote:
> On 10/13/20 6:25 AM, Philippe Mathieu-Daudé wrote:
>> Yocto developers have expressed interest in running MIPS32
>> CPU with custom number of TLB:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html
>>
>> Help them by making the number of TLB entries a CPU property,
>> keeping our set of CPU definitions in sync with real hardware.
> 
> You mean keeping the 34kf model within qemu in sync, rather than creating a
> nonsense model that doesn't exist.
> 
> Question: is this cpu parameter useful for anything else?
> 
> Because the ideal solution for a CI loop is to use one of the mips cpu models
> that has the hw page table walker (CP0C3_PW).  Having qemu being able to refill
> the tlb itself is massively faster.
> 
> We do not currently implement a mips cpu that has the PW.  When I downloaded

Bah, "mips32 cpu".

We do have the P5600 that does has it, though the code is wrapped up in
TARGET_MIPS64.  I'll also note that the code could be better placed [*]

> (1) anyone know if the PW incompatible with mips32?

I've since found a copy of the mips32-pra in the wayback machine and have
answered this as "no" -- PW is documented for mips32.

> (2) if not, was there any mips32 hw built with PW
>     that we could model?

But I still don't know about this.

A further question for the Yocto folks: could you make use of a 64-bit kernel
in testing a 32-bit userspace?

And I guess maybe we should update our recommendations in the docs.  Thoughts
on this, Phil?


r~


[*] Where it is now, it can't be used for gdb (mips_cpu_get_phys_page_debug).
When used there, we should not modify cpu state, i.e. actually insert the PTE
into the MIPS TLB, but we could still make use of the information available.

