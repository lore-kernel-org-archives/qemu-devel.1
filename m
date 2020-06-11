Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ABAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C1520829
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9hwL2W4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C1520829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQ3D-0002Kf-KT
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjPvH-00060h-67
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:19:23 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44130)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjPvF-0004rn-NF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:19:22 -0400
Received: by mail-pl1-x643.google.com with SMTP id bh7so2495108plb.11
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=JMgVZBpQsVqjjzrt3FEEL2BmvL+TKkXC5putLbsRUi4=;
 b=l9hwL2W4iL4gJVwrG94/i8KResUW30BysvX4u8zlFqzopqI9lQ+/UfYxLYNM4ncvOW
 fAFKvIysZxRcMjgPl+kHKldpm6PkrmTmScRGAwxOfLU3vcpQbexPvZ+NwsMnReEc5hG3
 dXkEIcJViHdmGMBaekT/fvuuAKv2gCkP9nCl5G7lcNuRv3QLDXEvs0CLqTMeNRtw5yAh
 Osff4txd+vZA2shXMo8wQukVm0aRiU0VZDny75U6m6oyUuQ+toOlCCoP60HqqXwlL2hi
 4Pv9aP8ea34rmRIJOBKqt8qoEMmGs2jbZ+l+Ya7K1PYLhBxjya+L000j7TwSq0jAOH0l
 BBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JMgVZBpQsVqjjzrt3FEEL2BmvL+TKkXC5putLbsRUi4=;
 b=hrbtsUvvomjWBjhwi8yApAX/EircTyWcTtQQnXEHX3sFwFkJQsCflV6wZfQsMzDzAX
 zszKydCaa64lt4G/gENAYvIdcwyT6z1z5TnjGsmyqI9eXHSDiPVg2NzwbPD/xgALrjsJ
 BdySGr8+EZCUzxhMiZfwn0c7jEHTbeVTUw4UTWUU8brBTBpRUC0tP/OqhW4CoYoJuh/G
 hXXhxahR4ktjzBN6yrPwgL5NHLStV2LUgrcJKJxXYR7iPTjrtaWUODBjiDyV60OTJsFu
 VleWev4oD0gRotCwegG1tOwFz+vPgOS8+Um+NjftQZT6eok9t2HtMEbwx8sVA6s/IXlE
 HRiA==
X-Gm-Message-State: AOAM5328Ek/bFpCcyTm2jlhy1SrPRZVHWiyhZwoC5kMxgXmTinCgfcqX
 GqYrNm0u5rqPLAwhsuFUd/fU3G4x7dI=
X-Google-Smtp-Source: ABdhPJzZvE/xhE4GYx60iLv9OBQaSHVeV1lHlgjRUM4cGlzvT45B90zH3T3s6bvGCZxMcxhArMqLPQ==
X-Received: by 2002:a17:902:8681:: with SMTP id
 g1mr7626176plo.161.1591892350833; 
 Thu, 11 Jun 2020 09:19:10 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id c9sm3620563pfp.100.2020.06.11.09.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 09:19:10 -0700 (PDT)
Subject: Re: [PATCH 06/10] target/arm: Convert Neon 2-reg-scalar VQRDMLAH,
 VQRDMLSH to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611144529.8873-1-peter.maydell@linaro.org>
 <20200611144529.8873-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df607881-4573-68bf-d70a-6cdebd232ae6@linaro.org>
Date: Thu, 11 Jun 2020 09:19:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611144529.8873-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
> Convert the VQRDMLAH and VQRDMLSH insns in the 2-reg-scalar
> group to decodetree.
...
> +static bool do_vqrdmlah_2sc(DisasContext *s, arg_2scalar *a,
> +                            NeonGenThreeOpEnvFn *opfn)
> +{
> +    /*
> +     * VQRDMLAH/VQRDMLSH: this is like do_2scalar, but the opfn
> +     * performs a kind of fused op-then-accumulate using a helper
> +     * function that takes all of rd, rn and the scalar at once.
> +     */
> +    TCGv_i32 scalar;
> +    int pass;
> +
> +    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
> +        return false;
> +    }
> +
> +    if (!dc_isar_feature(aa32_rdm, s)) {
> +        return 1;
> +    }

return false;

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

