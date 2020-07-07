Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF45C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150D62065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJtsZVTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150D62065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqqT-0007yK-A3
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsqXq-0003fP-LR
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:34:10 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsqXo-0003iM-UF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:34:10 -0400
Received: by mail-pf1-x442.google.com with SMTP id a14so14076074pfi.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 09:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J3qxzDNJI9UUewVlmppSN6RGnOmfF/5m0rbuflEbyMg=;
 b=MJtsZVTuDScd4uJ+2gefnLvFpOfLHwYRLtn3DD10fC5Zl4Es9Ggq0F7GrpNehtQq78
 AdT1dliGq+6r2fouZXwaCwz83JyEkt5RH+fs+DbnSfUJCP2oDxuGgsAw1PLNamUP2NC2
 ubnh8shPDUWWG8pLpMgIsDPG3718Gg+osApL78fhGXfxPEaJFzyN9Bg/lRW63ijfz3CV
 v/2yidDRFEgTNrIqJprR1TQ0y6N+qfavOoNa/D9CJrb+5A8/YZRxOq1EomJUCjAoujQS
 qKSAB1t3CuOFeiCCmTwVFEx0skGflQ9lNHlKO1Lb70XGAEZoMQ0wkHfP4S9WM+qzQCFN
 RLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J3qxzDNJI9UUewVlmppSN6RGnOmfF/5m0rbuflEbyMg=;
 b=c1UKD5Z7QjaCpoGegVjnwC+ZuM8kXz0+uufIbH1HV6xhImq51wTo6h2hw4wbvUe/V0
 yR1vlRiZ8MuJhhCycVh0EwVdzax44COrqC3dX+80XWZpjpZDasKX0F9I9W9dgU1EonxP
 UJsWQOrWT+3aRlqOVOxG/9yvbBeMg2G/t4myA808sze6tCjx85W/tV2OzqUzcr7/Mp2F
 n5GTJR+WYcCJmjiGCtdEX8x1Cpx26JlKsDSMeQmRgAYIs7kS/GScODgYoFJ9m7yVr2Of
 ZkXbvEa0v1k1Q9jIPSqpF5+3priuO6WFvhqC2UjH4vwZH2d6F/zNjh45Ze6SbN8mDOx8
 CmfA==
X-Gm-Message-State: AOAM532ZkljVeCU9fAhxQI9zc84stBU+2GsElYTQQKTaq7EGbETfKG7S
 HC+28mrMtkpMj98fzLnJ1GBNJQ==
X-Google-Smtp-Source: ABdhPJxeh8bFDZwuZaNzyU+e/90ss5IpG5/N+09Ga1vou51fsXBmjNEpgpA+nsMF5cg0zJfAUhMvEw==
X-Received: by 2002:a63:d208:: with SMTP id a8mr44854706pgg.351.1594139647370; 
 Tue, 07 Jul 2020 09:34:07 -0700 (PDT)
Received: from [192.168.149.206] (097-090-106-114.biz.spectrum.com.
 [97.90.106.114])
 by smtp.gmail.com with ESMTPSA id t29sm22939662pfq.50.2020.07.07.09.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 09:34:06 -0700 (PDT)
Subject: Re: [RFC PATCH v2 4/4] target/avr/translate: Fix SBRC/SBRS
 instructions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200707070021.10031-1-f4bug@amsat.org>
 <20200707070021.10031-5-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9c799b29-baa9-82c1-7329-aa9a3bff4664@linaro.org>
Date: Tue, 7 Jul 2020 09:34:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707070021.10031-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, Michael Rolnik <mrolnik@gmail.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 12:00 AM, Philippe Mathieu-Daudé wrote:
> @@ -1385,7 +1385,7 @@ static bool trans_SBRC(DisasContext *ctx, arg_SBRC *a)
>  {
>      TCGv Rr = cpu_r[a->rr];
>  
> -    ctx->skip_cond = TCG_COND_EQ;
> +    ctx->skip_cond = TCG_COND_NE;
>      ctx->skip_var0 = tcg_temp_new();
>      ctx->free_skip_var0 = true;

This is wrong.  The next line is

>     tcg_gen_andi_tl(ctx->skip_var0, Rr, 1 << a->bit);

So we compute "var = R & bit", which should be zero for "Skip if Bit in
Register Clear".  Thus "var EQ 0" is the correct test.


> @@ -1401,7 +1401,7 @@ static bool trans_SBRS(DisasContext *ctx, arg_SBRS *a)
>  {
>      TCGv Rr = cpu_r[a->rr];
>  
> -    ctx->skip_cond = TCG_COND_NE;
> +    ctx->skip_cond = TCG_COND_EQ;
>      ctx->skip_var0 = tcg_temp_new();
>      ctx->free_skip_var0 = true;

Similarly this is "var NE 0".


r~

