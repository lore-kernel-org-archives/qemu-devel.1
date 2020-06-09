Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17999C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6496207F9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fkX1yFRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6496207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiPB-0003AX-21
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jii1Z-0006XG-TO
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:26:57 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jii1Z-00034b-3q
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:26:57 -0400
Received: by mail-pl1-x642.google.com with SMTP id v24so8294204plo.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 10:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=i936mZVtVtxy9RPT3DWE+9QTa+HnOcLpjk01aJFQCKY=;
 b=fkX1yFRNOBzvw6jPmKDbp1PWHfJpRqHj/mxHyttJnyqhp2qwkTZmGSpyKHWqbwYMmw
 jZeENiYNi8S9/5MA+BAoRJfEOojvRTNdcTTC9LqpYsHlOuBKVI0QkH1g7urLBQf1l1Fz
 aHvR0TJcO49eXwSNdwKL53OD3hYzzoru1hERhYOX62TA02wACqqFCx5NSGUqtAFHCiwD
 CV7lmoSL1V5Id1KXp8+ESlEArBvC5d91/9pfX0cTdkW7vWebBUD5SEOS4YmdbarTG8f4
 kqeUM3HHyNPPHMZuLKAGbsiBaST36txdn+l37JqG7oqYKYG7JnCz9SBPTAtPy1faRSMl
 12Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i936mZVtVtxy9RPT3DWE+9QTa+HnOcLpjk01aJFQCKY=;
 b=S67jgiO7sNJPLaZuIn6XObteKLDMdFguZjnIyMyZW28xvOzXE2VH6lnE4ZFyDBI7/i
 msJ20bjGss62zjPJ99lm2rHMgjes6emX2llF1L1X4Y+JcSdnymXQXPlVeAq2aAE3/OfM
 n1KrVvcYHDhWopb060CHTjaGKP6/UO3zRJBK0DtykFVLKpmif++Etj6tZcmSou7wRVhX
 jwnyf/cYWN2nWrTfhcat30yZ2A+XH/avu8QUX/QpR/RDLxl9/P/rUopSDnraWExdlBHL
 pYGLcWzWeWBjYsgkm19NVguyoMMNU6flhc4sd5PaTb2OEeapQcVpSrkIJfZwYVIEXc/e
 saXg==
X-Gm-Message-State: AOAM532LiIrsWgvn4KxotUEVVPGAdFqGn8hwddnsLjfe9zAH2cKEIHzm
 vW0vSyI3YLQWltYwIBUYAYQzRSvva7Y=
X-Google-Smtp-Source: ABdhPJy8lT4MwD/f3W7eysERX/vm7Po87Qh1c2pNBEbrNs8HxmCqGvXJlKMfLr9Cq4mkm8QWNkt+9Q==
X-Received: by 2002:a17:902:6b49:: with SMTP id
 g9mr4233015plt.66.1591723614104; 
 Tue, 09 Jun 2020 10:26:54 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id np5sm3299311pjb.43.2020.06.09.10.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 10:26:53 -0700 (PDT)
Subject: Re: [PATCH 2/7] target/arm: Convert Neon 3-reg-diff prewidening ops
 to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200609160209.29960-1-peter.maydell@linaro.org>
 <20200609160209.29960-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3d1b2ba3-25c6-eca8-bd63-c70b7b6ae1cb@linaro.org>
Date: Tue, 9 Jun 2020 10:26:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609160209.29960-3-peter.maydell@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/9/20 9:02 AM, Peter Maydell wrote:
 +#define DO_PREWIDEN(INSN, S, EXT, OP, SRC1WIDE)                         \
> +    static bool trans_##INSN##_3d(DisasContext *s, arg_3diff *a)        \
> +    {                                                                   \
> +        NeonGenWidenFn *widenfn[] = {                                   \
> +            gen_helper_neon_widen_##S##8,                               \
> +            gen_helper_neon_widen_##S##16,                              \
> +            tcg_gen_##EXT##_i32_i64,                                    \
> +            NULL,                                                       \
> +        };                                                              \
> +        NeonGenTwo64OpFn *addfn[] = {                                   \

Missing const here.

Actually, patch 1 made me look back and we missed it, and static, in
trans_VSHLL_*_2sh.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

