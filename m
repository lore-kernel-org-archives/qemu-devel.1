Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EB2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 18:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F3D3208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 18:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyDR/TmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3D3208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlyxw-0007UL-SJ
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 14:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlyxM-00074g-7H
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 14:08:08 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlyxK-0004jA-Kp
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 14:08:07 -0400
Received: by mail-pl1-x642.google.com with SMTP id n9so2769724plk.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Z3+kvQldQpd8Zn3aWmFzLh5TijCBEHEmhWjVeMlFYz0=;
 b=QyDR/TmGcb9+x6c1RUsAXHwnMoCsoD75LoamB5TvMMfzgp/Yinn9ItRtfiuUUOMPEP
 8hepNuMOWrni/hAoUKo/V9/EeDTTN2V/H6nkh6rHa0t6OMgDa/HZudr7Dnz+2mjHHMOM
 2PmNMzToKA/C0EMXciBTJSLBMfLMzvpzXjEb1cdV0j5iQJlhwbLXJazwO86tGkiVkgBR
 UT/YLX92hV1DxOUWPNQWdmV5+cPyQEYfNPkZyE3icxuxtaQOh8/LuzvpY2VJ+tvpuybm
 aLv4JAARLIH2ZG65z87eynZiL5b6JbeXB6qxopi7/gnMFyNKGphTyvj/IF81vNhqzKwd
 jjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z3+kvQldQpd8Zn3aWmFzLh5TijCBEHEmhWjVeMlFYz0=;
 b=tWn6XZlsEnlvoxZ6m/owFEl6jPRRQ/rHjXBMn6HjNIG9eEiNDfchG9X9g0oao3514e
 YPN3MC4RM4OM7UvlldqWxUZkuWoQiXON9azHHx4cJNffdxQSodguQhf2n9N+zZZ6xFqL
 GBm++mj0yc+pDAENLJ6i7Xs32j7KtvDVjapg9qJQUhqtrjXOu446V8vJhAQK477iQewX
 E9vo2XzRomJJnS1OZZqPekFgc/1T/DOJVOHSPIl6YaoArNCbIVOtgxRw+Om3xHEXkHRi
 riBpne84B11DxOFUqp3tek86Fq9TuzKe0uENd1p7dGvfkb7N8B1zC5ZFNd91cLX2ke7a
 UXaQ==
X-Gm-Message-State: AOAM530cSIm3FLA3r/lo5qQbrQjxk0QpMt5bcSDjY5XSXc91GpT7gep8
 Yl/TPUa1P6RN5DNFRuWcNZY4Gw==
X-Google-Smtp-Source: ABdhPJwDu8GrEQHBLjfF/nkPpWAsOHyBaKACfMiCbhca9XCtIeGjj0O42oHwCEr0yUK6vcyr8PzdFg==
X-Received: by 2002:a17:90a:bd09:: with SMTP id
 y9mr5305510pjr.233.1592503684892; 
 Thu, 18 Jun 2020 11:08:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id j6sm3551339pfi.183.2020.06.18.11.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 11:08:04 -0700 (PDT)
Subject: Re: [PATCH v7 03/42] target/arm: Add support for MTE to SCTLR_ELx
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-4-richard.henderson@linaro.org>
 <CAFEAcA9bAt=cG9nSWP6JaVyx4jf2UGmYLKzvaJ7rVCdLVpw2ig@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f2b5b9fc-0586-1716-e5bf-c04db454f745@linaro.org>
Date: Thu, 18 Jun 2020 11:08:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9bAt=cG9nSWP6JaVyx4jf2UGmYLKzvaJ7rVCdLVpw2ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 3:52 AM, Peter Maydell wrote:
>> +    if (ri->state == ARM_CP_STATE_AA64 && !cpu_isar_feature(aa64_mte, cpu)) {
>> +        if (ri->opc1 == 6) { /* SCTLR_EL3 */
>> +            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA);
>> +        } else {
>> +            value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
>> +                       SCTLR_ATA0 | SCTLR_ATA);
>> +        }
> 
> Doesn't SCTLR_EL2 have the same "no ATA0 and no TCF0" that
> SCTLR_EL3 does?

No.  With HCR.{E2H,TGE} = '11', those fields are present.


r~

