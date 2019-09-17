Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2720CC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956CE214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSCoHq0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956CE214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAKQA-0000D2-Qm
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 16:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAKM1-0002Mk-9T
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAKLz-0004a0-Tb
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:45:40 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAKLz-0004Zh-N0
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:45:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id 4so2005688pld.10
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=j3S3FT/g8j42w7nyqeQTYQ9+mhXd4SLzvays0WaTKGk=;
 b=vSCoHq0W1350Df+h9DNBFxK6GPl4PiUIye4aqGjpu3hKLsruMkEPDdzweM3xOMggEq
 v/W47xZivAvZoRhqsPlcjJkX5ooes3SCqr3Q+ob7YoIcjfsTFj0YwZqYQatdfrD4/n/b
 lD0Qdl2h8N2bjEAmdxjpb/b8sU/swQU/KZkS33swyM0UEMrgsKjKKI9zt8X5oYp5WttI
 OszrElX3MvgwUflIAR89n7/nX+yeDI0TPdW8NwaOwbZD8f9G0ttsmmb7SJd7pZ/GW/mE
 1wA9SbA4ffjHjR9Hq2VQT6arSYowoQLVnUIHXgmHFo7pZWQITBJb64PaonCGNh0652/7
 jaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j3S3FT/g8j42w7nyqeQTYQ9+mhXd4SLzvays0WaTKGk=;
 b=pdzSJsVqTCelkC7qumrYzh5qt0p+nTD6xBQarAokVSQyBV7TL+NUuGVRLto0C8Tr1y
 mmSOVDcv279z6P8x1ckAD7sNa8IynSpTYKC0KDw1nuSaQhMjMOzARisYXNFrNWk5GBkK
 92koVqrmxKeb6JPRt4bKfL7PA0zJxxD3kOxq0+ChamWGpB5bAlncn5OUTdgyfzi3tMjn
 j+OY/1od3lslNpZ951NFSi1x9Y7mjIIoWKnE53kPfj7oLMsSPNkUQx3HqGIfPOSRfMEL
 ObgS9oKl1aed3/AQo+LD1J+E7JYUyRuxFIsoU7+oQOPDEkP0+hBEu2aMpz5crwevVsmj
 h09Q==
X-Gm-Message-State: APjAAAWji+NcONKMYH8q2E6e3HszajHQ01F3+dmzv+yKvXHes17aXeo/
 hZJsLW5nQOK82z6iPXFFvl23TQ==
X-Google-Smtp-Source: APXvYqwz4gDdqUMQXj2iA9v5hGtqDe//5AA2veLu3jpzA0AYElE2U4O2DqInDeCO0Ripqp5QhWH+4Q==
X-Received: by 2002:a17:902:8649:: with SMTP id
 y9mr557879plt.252.1568753138461; 
 Tue, 17 Sep 2019 13:45:38 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r23sm2952882pjo.22.2019.09.17.13.45.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 13:45:37 -0700 (PDT)
To: "Paul A. Clarke" <pc@us.ibm.com>, qemu-devel@nongnu.org
References: <1568653336-16819-1-git-send-email-pc@us.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a561c80e-68b0-bd56-2718-6c3325d27716@linaro.org>
Date: Tue, 17 Sep 2019 13:45:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568653336-16819-1-git-send-email-pc@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc: Add support for 'mffscrn',
 'mffscrni' instructions
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 1:02 PM, Paul A. Clarke wrote:
> +#define FP_DRN2         (1ull << FPSCR_DRN2)
> +#define FP_DRN1         (1ull << FPSCR_DRN1)
> +#define FP_DRN0         (1ull << FPSCR_DRN0)
> +#define FP_DRN          (FP_DRN2 | FP_DRN1 | FP_DRN0)

Why not just 7ull << FPSCR_DRN?
Are the individual DRN bits separately useful?
They don't appear to be...

> -#define FP_MODE         FP_RN
> +#define FP_MODE         (FP_DRN | FP_RN)

This, I think, isn't helpful.

> +static void gen_helper_mffscrn(DisasContext *ctx, TCGv_i64 t1)
> +{
> +    TCGv_i64 t0 = tcg_temp_new_i64();
> +    TCGv_i32 mask = tcg_const_i32(0x0001);
> +
> +    gen_reset_fpstatus();
> +    tcg_gen_extu_tl_i64(t0, cpu_fpscr);
> +    tcg_gen_andi_i64(t0, t0, FP_MODE | FP_ENABLES);
> +    set_fpr(rD(ctx->opcode), t0);
> +
> +    /* Mask FPSCR value to clear RN.  */
> +    tcg_gen_andi_i64(t0, t0, ~FP_MODE);

Because here,

> +static void gen_mffscrn(DisasContext *ctx)
> +{
> +    TCGv_i64 t1;
> +
> +    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300))) {
> +        return gen_mffs(ctx);
> +    }
> +
> +    if (unlikely(!ctx->fpu_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_FPU);
> +        return;
> +    }
> +
> +    t1 = tcg_temp_new_i64();
> +    get_fpr(t1, rB(ctx->opcode));
> +    /* Mask FRB to get just RN.  */
> +    tcg_gen_andi_i64(t1, t1, FP_MODE);

and here, we're only interested in RN, not DRN.

Possibly FP_MODE should itself be removed.  It's used
exactly once, in mffsl, which could just as easily
reference FP_RN | FP_DRN.


r~

