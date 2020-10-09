Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E4C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1343322283
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvL84/Rw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1343322283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR0zQ-0003kH-W6
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 18:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kR0xm-00033r-Ij
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 18:34:10 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kR0xk-0007YJ-81
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 18:34:10 -0400
Received: by mail-oi1-x243.google.com with SMTP id n2so11825296oij.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s+SoOCi13C4EVmQ8xozsTYLCeZGrYVp/feQrf9CbVsY=;
 b=KvL84/RwEvQV9V2wvU1YiCjWSWECbRrqHRGS6AltcC/ip9gnwoEXs5+Oym4JuvQOav
 LqjbqBy7N7dSQlAkoAkwuVFbjMpKOPL2fiMoo4T7NBnBsjUKXx5gRcYinIZeH6oVkg+7
 wCKo6yY6g02GDccnvR0NT9TGOUS7XQ58L+WO1SAdh75XAZSV+k55VeFeK/WZo+PhaU3M
 K04yHNUGJ/1wVy/rppjyJk+tMF/t9ZbYU7L0aWv5G4P60VUaNrdsiaMlklRV7hVvZ41s
 XvR+dfTjwOgZLD7w72swJpz57OQlhb6hDxTjsDHEpWGncw0Rqn59UlQC8m861ZmANyuJ
 GOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s+SoOCi13C4EVmQ8xozsTYLCeZGrYVp/feQrf9CbVsY=;
 b=BAcwkDmcit69/HuHblpa3gG4Gq46ZgsG/6Z5Y6m+IziM7RUyPlDUdsFiU+kBrtdDQT
 Z0TbIx3G1jAQPQs50w+DXSR1wyYQV+bhG8etR32qOLuZ7vZNB8cQLcH/vZhPl6xXVaZx
 YiRy+Fp5G7dL9wg6S0IRKXge+rmmphtlReCyZ9m1HXNMCQbbgRMSBU0Q105zmN3j1Lbv
 5aqEIH5CSEwGHxCBtiOohS5Z7MkPTfh2pom8Zb8wmuLrTpgroEKHwmKkzUwaZUuIFctX
 7w7wz9otFnRRWrSSJwtTpJaVAyEPy86SoJ4jSer2LY7vrHGURYUzda1uiILvr5gF1eJi
 L+jg==
X-Gm-Message-State: AOAM532QIM1DzOY/BmYVp+RGnyUbqiBGk5Xg6Jaz3MbNAhBPaxPXxB3O
 nVqa3EUrzTxMiUwU0MkFIA+75H8TmsyC+NsC
X-Google-Smtp-Source: ABdhPJx4enhGLEtUuU5pQdBadaswTjsWUxzqrJfvDS4+6+mpzkQ8UYNvz1S1T7EFIf9vFQh1vIJRYg==
X-Received: by 2002:aca:d856:: with SMTP id p83mr4123655oig.57.1602282846596; 
 Fri, 09 Oct 2020 15:34:06 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id b3sm7492159oie.49.2020.10.09.15.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 15:34:05 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Fix SMLAD incorrect setting of Q bit
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201009144712.11187-1-peter.maydell@linaro.org>
 <9b6bcfac-922d-675c-d7b4-35491a3efe60@linaro.org>
 <CAFEAcA_TZQOFtQn=MhvaF7wvXCgQLHfhpekHb29kb-p8VgWfYA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5702c321-0d70-6e26-4aea-8ac9e6f90cbc@linaro.org>
Date: Fri, 9 Oct 2020 17:34:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_TZQOFtQn=MhvaF7wvXCgQLHfhpekHb29kb-p8VgWfYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.208,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 1:47 PM, Peter Maydell wrote:
> On Fri, 9 Oct 2020 at 18:57, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 10/9/20 9:47 AM, Peter Maydell wrote:
>>> +        /*
>>> +         * t1 is the low half of the result which goes into Rd.
>>> +         * We have overflow and must set Q if the high half (t2)
>>> +         * is different from the sign-extension of t1.
>>> +         */
>>> +        t3 = tcg_temp_new_i32();
>>> +        tcg_gen_sari_i32(t3, t1, 31);
>>> +        qf = load_cpu_field(QF);
>>> +        one = tcg_const_i32(1);
>>> +        tcg_gen_movcond_i32(TCG_COND_NE, qf, t2, t3, one, qf);
>>> +        store_cpu_field(qf, QF);
>>
>> This works, however, QF is not restricted to {0,1}.
> 
> I'm not sure if you mean "this code doesn't maintain that
> invariant" or "there is no such invariant". If the former,
> the declaration of the field in cpu.h disagrees:
>     uint32_t QF; /* 0 or 1 */

Oops, I confused QF with QC, the neon saturation bit.


r~

