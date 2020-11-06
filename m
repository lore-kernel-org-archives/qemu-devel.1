Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3A1C55178
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4B32078B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1Bj5Xht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4B32078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5UU-0005Bx-6X
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kb5Re-0002WT-No
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:22:40 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kb5RZ-0004dQ-2S
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:22:38 -0500
Received: by mail-pg1-x544.google.com with SMTP id e21so1418111pgr.11
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ffpiPj+4vvUW3xYWlHRtHIXj9KPXMOoU00dSpOC1llM=;
 b=W1Bj5XhtL2QpVclVwqkHmme/DQ/juSwac9QmUcs+faYaHPmsB1iyc8fuUYcRAHGRjO
 i3Xk7jE3cOmaDl4/f9kjNWc9NmJApRr51XMIBdrqpVLt8GDH+VYU7SGsbXTfieWzu5rq
 vHyoycCfcAicQRf8qDIcntZI7YYcMLU7gSuFAAHmcjQ/ZTCcg1gLbp7qmowoXWV8Zts7
 DM0zxWs0ptPyKvPh7nLiFppD4GwSWshCDMJ/LDIHAY1ThKgU6pgaKEXpJpTwm/dYfLN7
 iKF8/5yGuNjqaoxM8ELPFQ6sCp8h+y9kU0LCIcvBeje1vXGMzDVn5LTZ3QcnOxX3ANgZ
 6XQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ffpiPj+4vvUW3xYWlHRtHIXj9KPXMOoU00dSpOC1llM=;
 b=b3/EQ9VMxx9T/cy1XZfR6C3CbmxpWhwtzur/JIQhXIo/u1m50SdWsT+IP/XY/iPRMw
 jpEW/xLehQPh5qQfpqWZ64dNOjb3MLXASMCxAECcwNJnby8td8SEkYw2PdibsUmGS5Qf
 3pC+lFRjgW572giJrgJi8ir3biHuy3R8uBODhNtoVUznfWKIcyP2cRK9nh0KQTFfVuCb
 oFW8fOzxjTQRTOlChku1RtwqoVYAiKrpp9kZq6ln1nEYFOLSLTqwA0wZmXOVxac8a/yC
 KN2zUIdbCJnRzyUZ5Y3BSHViPK+6oNZtRBGEimvkD5Ront98ZlrANPM0/q/RoD/oLH9o
 xh0g==
X-Gm-Message-State: AOAM530uYbJH2botHHuYFVIx2LfODCCqUuI96rlM0s609ka52taYRVXL
 QJ9Oo/ewGXnSIpTdiDE+f+gHKA==
X-Google-Smtp-Source: ABdhPJy39eL5uaYlWraSPDyIjyQBB8uKLpjLQCYuOJlAtOA72I7JUz5d9KBhkpEC1IS84narVu1Olw==
X-Received: by 2002:a17:90a:8c89:: with SMTP id b9mr668925pjo.34.1604683351543; 
 Fri, 06 Nov 2020 09:22:31 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id m129sm2945169pfd.177.2020.11.06.09.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 09:22:30 -0800 (PST)
Subject: Re: [PATCH v2 4/4] linux-user/sparc: Handle tstate in
 sparc64_get/set_context()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106152738.26026-1-peter.maydell@linaro.org>
 <20201106152738.26026-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a0444a23-3f89-8d72-6fc5-13414e0c96a5@linaro.org>
Date: Fri, 6 Nov 2020 09:22:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106152738.26026-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 7:27 AM, Peter Maydell wrote:
> +#ifdef TARGET_SPARC64
> +/* win_helper.c */
> +target_ulong cpu_get_ccr(CPUSPARCState *env1);
> +void cpu_put_ccr(CPUSPARCState *env1, target_ulong val);
> +target_ulong cpu_get_cwp64(CPUSPARCState *env1);
> +void cpu_put_cwp64(CPUSPARCState *env1, int cwp);
> +
> +static inline uint64_t sparc64_tstate(CPUSPARCState *env)
> +{
> +    uint64_t tstate = (cpu_get_ccr(env) << 32) |
> +        ((env->asi & 0xff) << 24) | ((env->pstate & 0xf3f) << 8) |
> +        cpu_get_cwp64(env);
> +
> +    if (env->def.features & CPU_FEATURE_GL) {
> +        tstate |= (env->gl & 7ULL) << 40;
> +    }
> +    return tstate;
> +}
> +#endif

Given that this inline function calls 2 other out-of-line functions, I think it
might as well be out-of-line itself.
I'd place it in win_helper.c alongside the functions that it calls.

But either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

