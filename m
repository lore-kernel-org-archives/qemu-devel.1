Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F77C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 03:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C386207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 03:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tpl/yD7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C386207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh34g-0002ya-MY
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 23:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh33q-0002Mh-Ce
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 23:30:26 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh33p-0007y6-5s
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 23:30:25 -0400
Received: by mail-pl1-x641.google.com with SMTP id v24so3073132plo.6
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 20:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=T7tfFGqFWJm7beKDzfuyU5uUicJlwCl5DwiAo7jIPM4=;
 b=Tpl/yD7YWVPOezF7lKEr+k7mM7Xtq3rtkopJO2DHKQVum2oHaPFNMnVumLcmXTMGtr
 zlcnQc1zwMW3VQv2lOyANeW32eYU4dgEjNNH6MCNXFG6XN7m2KaI6Mr5a36FZ0aGICiS
 CRqWoIMcK5opGVAUgTYnusLdNpR27tTH3tnAXW1igxr8dA+eTPaS9/22WILNB4le01OJ
 CO/Snbz7tJsg7dkF3H9S6KIRBO5xH+kehDb/tCMEfZ9ThJvQoMhVo74G6XWQ3wnZeG7m
 SjaH837H06Xkrx/55W/Ia3uiDga9Ic5lrlJhtnZXjL5jJLorVIiWV/ukl9CxQER8+APi
 CLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T7tfFGqFWJm7beKDzfuyU5uUicJlwCl5DwiAo7jIPM4=;
 b=L1hgVUjtLxC8AZu5aHlit23obiKhFg1GIvVOq8HIFB7gKKjLnYXKGXR7a9z4adAx2k
 2m+QFLVMyGSjVpbKhKdIxmOoRfX214qcdntf9AEEmTEvdC5UkF3oe2Y+z5gZf8jAcr0x
 E6hs9esxYiE2OmH4PVz5w8mRqRW91QuSKVUf4CGSfnsHtqm4qUltWjWmbFLt9Yp3NjcI
 CW1VeIF3mOCMk/WZV/trjn//dicyaTZ+o+FqDqDkUFLCQSOhf2FOSfqvVruUxANAP2fV
 mXekbjeLTwY7MXr5lkwbN4YUcmEToHddDF9WdCxIM4YUcVLcDTEcF1Y326jiNHN1Sntq
 IZDA==
X-Gm-Message-State: AOAM532388wvL76dI+fZT2WkLVm6zIDYwGQoLhGubGhXFO3Qs1Eo379Z
 qSnFAJeN1kNxLuVn4oPu/+gYBw==
X-Google-Smtp-Source: ABdhPJysH7mtpd9r1ZYUJuGCK6iuHSLbBULBiqmS3I2wQZ33uPUNidg/HsdqCuCVHIaRMNp1st2zqw==
X-Received: by 2002:a17:902:9b92:: with SMTP id
 y18mr7674823plp.93.1591327823167; 
 Thu, 04 Jun 2020 20:30:23 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id ds11sm6678664pjb.0.2020.06.04.20.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 20:30:22 -0700 (PDT)
Subject: Re: [PATCH v8 30/62] target/riscv: Update fp_status when float
 rounding mode changes
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-31-zhiwei_liu@c-sky.com>
 <7cb2aa5d-833a-8544-dadc-5aabba06ecd2@linaro.org>
 <ca1e71cd-c290-5fb9-e9bf-026c73e06560@c-sky.com>
 <7ec3d397-bf9a-07f5-3014-4acf47a4fd6e@linaro.org>
 <ba7ef161-8bc6-516f-b5a7-8133e3a89998@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dd721c20-fc04-49b8-0c5a-1b4761105461@linaro.org>
Date: Thu, 4 Jun 2020 20:30:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ba7ef161-8bc6-516f-b5a7-8133e3a89998@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, alistair.francis@wdc.com,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 7:50 PM, LIU Zhiwei wrote:
> So no scalar insns will require changes within a translation block.

Not true -- scalar insns can encode rm into the instruction.

> I think there is a error in gen_set_rm
> 
> static void gen_set_rm(DisasContext *ctx, int rm)
> {
>     TCGv_i32 t0;
> 
>     if (ctx->frm == rm) {
>         return;
>     }
>     ctx->frm = rm;
>     t0 = tcg_const_i32(rm);
>     gen_helper_set_rounding_mode(cpu_env, t0);
>     tcg_temp_free_i32(t0);
> }
> 
> I don't know why  updating ctx->frm in this function.

This is a cache of the current rm, as most recently stored in
env->fp_status.rounding_mode.

So if we have

	fadd.s  ft0, ft0, ft0, rtz
	fadd.s  ft0, ft0, ft0, rtz
	fadd.s  ft0, ft0, ft0, rtz

we will only switch to round_to_zero once.


r~

