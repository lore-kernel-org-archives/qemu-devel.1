Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11E0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C74D206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vyex3gPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C74D206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPqJ-0006Q6-PO
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjPlc-0005nZ-Lz
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:09:24 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36522)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjPla-0002CC-NU
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:09:24 -0400
Received: by mail-pl1-x642.google.com with SMTP id bg4so2497488plb.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=HmzbD5r9ZmIXlBwfVAybbPhriqGbw0DowzngQ2ANp8s=;
 b=Vyex3gPL6Z2tpv6u6NJQiZN8xApkf0/+zEi6BF7Jqq8h+szd3RNz9GzD9ZBCS9tBHk
 A9OOqgsc7i4PJv7qf6BDrvcZTRtsdoYOWhLqwHo/Bf4Y+Z6kwYBcJnz6B32TEKw86G/K
 g/MCOKOYF6fa3it1hxj2DGyQQlfm4fX6mV0Ss6+b6Z9gM81WsXVteiobGsagZRZJS1oq
 HD2UwjqPbHEVomgJv4tgNUD5enkGMB+e5Tt88FTlDpdHqWy87qjQ8ROB4tP7R+5vod8L
 BLj6xwPQMg7SandPtD8xlgXLBoAz4zjI/6DlmTejQgWGlAS10LWS+olJ2YfFUrrpVTpx
 qcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HmzbD5r9ZmIXlBwfVAybbPhriqGbw0DowzngQ2ANp8s=;
 b=Be9IwL39njVXJZzOoun4XnKrhw4SXz5EcMmtYQ2sk2RG3K/L1YHe18fG4pI+q3OrZj
 44ObbuOc+bNnPJe95mY81h/RmmEZuWA0oCm9kNvcmGlFsmRGzOZLI/DywBtg5Hal2FYT
 ctzX9oEIsqk7a+TPXFr2nyHRsnDoi4at0R5NJfQ7zVh+BTeEajmuF4AzAyphfmubXI1c
 6e0sJ9XLj41c8kRUS5eBOmrpQ7y/DL5ccMk7ZdrXeDHKjqHrkC8/Xm3hRCwZdgAoSBmO
 amWDsJln9xE/J6ijnEwNhS7RXas6Iwn5QH1sf8ap+ULdIK+Z1VxXNuUWnSLj0mvVL7V5
 DCpA==
X-Gm-Message-State: AOAM533GpZ8/OJMIlQ8iGlZW8/ShZw0gBqX4fKF0SioX0sdruUuP3Fnm
 vZIdX2JyTfprkMSOBpyWN65A3zrybHQ=
X-Google-Smtp-Source: ABdhPJwtDMxLpFGMIbVBuTxEalJ6In+kjsdYVztvwjYxTHhyot6m+Kw06oTyiFqjjAL210RoUTte8w==
X-Received: by 2002:a17:90a:886:: with SMTP id
 v6mr8297144pjc.161.1591891754412; 
 Thu, 11 Jun 2020 09:09:14 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id z1sm3522424pfr.88.2020.06.11.09.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 09:09:13 -0700 (PDT)
Subject: Re: [PATCH 03/10] target/arm: Convert Neon 2-reg-scalar integer
 multiplies to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611144529.8873-1-peter.maydell@linaro.org>
 <20200611144529.8873-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e1c9363-2c6e-dd3b-3e2c-c28b9bd42c54@linaro.org>
Date: Thu, 11 Jun 2020 09:09:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611144529.8873-4-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 7:45 AM, Peter Maydell wrote:
> Convert the VMLA, VMLS and VMUL insns in the Neon "2 registers and a
> scalar" group to decodetree.  These are 32x32->32 operations where
> one of the inputs is the scalar, followed by a possible accumulate
> operation of the 32-bit result.
> 
> The refactoring removes some of the oddities of the old decoder:
>  * operands to the operation and accumulation were often
>    reversed (taking advantage of the fact that most of these ops
>    are commutative); the new code follows the pseudocode order
>  * the Q bit in the insn was in a local variable 'u'; in the
>    new code it is decoded into a->q
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> +static void gen_neon_dup_low16(TCGv_i32 var)
> +{
> +    TCGv_i32 tmp = tcg_temp_new_i32();
> +    tcg_gen_ext16u_i32(var, var);
> +    tcg_gen_shli_i32(tmp, var, 16);
> +    tcg_gen_or_i32(var, var, tmp);
> +    tcg_temp_free_i32(tmp);
> +}
> +
> +static void gen_neon_dup_high16(TCGv_i32 var)
> +{
> +    TCGv_i32 tmp = tcg_temp_new_i32();
> +    tcg_gen_andi_i32(var, var, 0xffff0000);
> +    tcg_gen_shri_i32(tmp, var, 16);
> +    tcg_gen_or_i32(var, var, tmp);
> +    tcg_temp_free_i32(tmp);
> +}

I was going to quibble about this implementation, but see that it's a straight
move from translate.c.

The real TODO should be a conversion to tcg_gen_gvec_2s(), so that we use real
vector multiplies and adds here, with the scalar duped across the vector, not
just an i32.


r~

