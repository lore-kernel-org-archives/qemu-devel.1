Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73725C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B65624671
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBDH8Zhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B65624671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irrCB-0007rE-1C
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 17:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irrB9-0006uw-LJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:30:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irrB8-0004sB-Ge
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:30:23 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irrB7-0004qm-9T
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:30:22 -0500
Received: by mail-pg1-x544.google.com with SMTP id z124so8849242pgb.13
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 14:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=F2YM0coMho0zfyacZVauDRrmmDVgAwf1jpXRKiD3Q0s=;
 b=WBDH8ZhhRhPwfZXWeN4r5ehaFjmF5O/LRya0wmV0RYui2nkS6kkGlabM6V2S2PTLjm
 /2nHF4GfLYOtEc8i1nw9AJ632brjGN7Gk99z024ai9aIOjI3jyoBMhxBUaK95/IBhBhg
 2VQo3imWwz8Nlq/+S4sm4nT1CjUq25GjWmVSVHBgx/cMxA/PYd///z5qNQEVeB3NJGMs
 kgUF3uIQ7Zj5TUiFR0gvoxPBc+q/cSMViSctFiA4YI3IA3W/R5SfCu0b/9g7L4+JZA8V
 uJ/STblN79HkhNzEjAv0ZDpbEposFQQrNDIRIk+qieY41MgVT9AAauaQfyMEsQRRkgIH
 XH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F2YM0coMho0zfyacZVauDRrmmDVgAwf1jpXRKiD3Q0s=;
 b=QbKESdZR7D4Fs94kb90RyFr1FEUasemrfoEYtOJP4m1PT8ahkoHPQCO3xtlSa0EiSw
 rtmNywxnEmuKCtU8j8PaYYwvZum9N0lwM6bZpuniZAmc3WDOGEltPwLsRrjlcEJdp9Ok
 Fg3U8VbkpC0QhrJZtS8D4GX3CbS03b4jMzECyDTIa6bwgHbtyF4mv7Fy4+fAhNovsmBp
 YMo6DNEtk+4MEvKlei6FJAzWRZfpQ68k1EXnFxoATlOfNh+WGRUbwpJF3bMC4huSORDH
 QqAGb0LmF3I6/kVdvMeBlf33JISCybLGrjXIhEMTbF5cg5h09ede5inb2s6qCHKAKo2A
 P5uQ==
X-Gm-Message-State: APjAAAUZfBfEukmo3wsSFFlLBazoRDS1PRTEVEFVorsPeIORAyd/EFET
 DRVzBjMRIXpNyHfgQBVClLLZ4Q==
X-Google-Smtp-Source: APXvYqx8k2Azsxe2t0C1unLgYeII6ednCZV2fg6hJ3gdK/DconTDmpGuS4kL+5GaImYPyAcgztGiaw==
X-Received: by 2002:a62:19d1:: with SMTP id 200mr32504405pfz.26.1579127419973; 
 Wed, 15 Jan 2020 14:30:19 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id z4sm22548739pfn.42.2020.01.15.14.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 14:30:19 -0800 (PST)
Subject: Re: [PATCH v5 15/22] tests/tcg/aarch64: userspace system register test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d0cc21da-aa30-bc6e-34f9-c922ba5d8cba@linaro.org>
Date: Wed, 15 Jan 2020 12:30:14 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114150953.27659-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 5:09 AM, Alex Bennée wrote:
> This tests a bunch of registers that the kernel allows userspace to
> read including the CPUID registers. We need a SVE aware compiler as we
> are testing the id_aa64zfr0_el1 register in the set.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20190205190224.2198-7-alex.bennee@linaro.org>
> 
> ---
> vgdbstub
>   - don't build unless using docker or CROSS_CC_HAS_SVE
> ---
>  tests/tcg/aarch64/sysregs.c       | 172 ++++++++++++++++++++++++++++++
>  tests/tcg/aarch64/Makefile.target |   6 ++
>  2 files changed, 178 insertions(+)
>  create mode 100644 tests/tcg/aarch64/sysregs.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

