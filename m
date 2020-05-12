Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AEBC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BDDE20722
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHWhCnWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDDE20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVuO-0007Yj-Cz
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVtb-0006YU-17
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:28:35 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVtZ-0006ox-TE
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:28:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id i27so10604031ota.7
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H4Da6L3O2goxUvulLcusGZ7jcx6jhPhu1kVkaSvOW5M=;
 b=SHWhCnWJP/cLf1Ja0nqqDBgOHkFzlgLpoOq5/yOElyK1CzPYb8s7QNZW2DUyH9xGer
 Ad8o8X78nR+hyf1jhhBrUJfN4uttrYIOum1sJuIpyiKwQd+smB9RkHMlhZcmOqD7blh3
 s74kq2znvW1rQ7J6aDmLQYQGn3sXNasUvQF8SZ+ev59beo0TpACZzLIs/uT0QtGMcL9h
 /10TZCX0Cook+t1X/C2sO3shlWm0ml8w3xgKZm3+svm6zyVTnFWsZcnTtYfAe3zOhrhE
 mNqBHQ/CtAIVwFUFjgKxketWraNk/6MKdyzSo7VU+c8eJV+idJzy5VnzljuOxixGQvmP
 eBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H4Da6L3O2goxUvulLcusGZ7jcx6jhPhu1kVkaSvOW5M=;
 b=YnKs1B+iW1Gw5erWDovc4RvLTeknDvVU1tBolOirE8pQF4IfOaU50NVwqoolF6fTEP
 KVH79zhwlwV8LL5oAZVdcHqrpby+IocEaLRhMKBpFTjgfcHgiCVE2VCtl8pIowm1UXla
 Nyxchaju/nOwnzSXmaJz9Doqjn69H2uHl+gvMQKXkqejBPdDAnc3yv59eA8NmUNetnLO
 nU6H45HN3FcC5V5+qRH2+YOLh1x13DpK/YzQFpBjopb+b/PEeRNFG7ztv/spKamiWqx9
 0nokivp2CEdD2WlAdkyKpCupPnMVDWia5bIPUranuaGfvO7ayK3IX7LYMuOnl2+Uuf7Z
 ZZHA==
X-Gm-Message-State: AGi0PuYNklmo5C9fVF1fIkD8R8md3EqnAO1mF7IMh9yB1kdLPErXOs9h
 BcDRcHKG/OEdQQO5Zn1mRh+4LerAqcZwJPE4/Z7/zw==
X-Google-Smtp-Source: APiQypKleR88+KPMEIcVxj7Afakb7buyCLkrTMC3W8KAY8HMo9ljpOU+4kGC413Si6YUj/qJvn9Lj1+wgpNRV6S8HDE=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr16057106otc.221.1589293712048; 
 Tue, 12 May 2020 07:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-14-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 15:28:20 +0100
Message-ID: <CAFEAcA9Ey-5827RSaPDeeRccdQTL6qJX=jT5ox9b977W2idGQA@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] target/arm: Pass pointer to qc to qrdmla/qrdmls
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Pass a pointer directly to env->vfp.qc[0], rather than env.
> This will allow SVE2, which does not modify QC, to pass a
> pointer to dummy storage.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

>  /* Signed saturating rounding doubling multiply-accumulate high half, 16-bit */
> -static uint16_t inl_qrdmlah_s16(CPUARMState *env, int16_t src1,
> -                                int16_t src2, int16_t src3)
> +static int16_t inl_qrdmlah_s16(int16_t src1, int16_t src2,
> +                               int16_t src3, uint32_t *sat)

Why has the return type changed here ? The new type does make
more sense (there's no behaviour change since the return value
is always assigned to either an int16_t or uint16_t lvalue),
but it also doesn't seem related to the passing-of-QC that
this patch is doing.

>  {
>      /* Simplify:
>       * = ((a3 << 16) + ((e1 * e2) << 1) + (1 << 15)) >> 16

>  /* Signed saturating rounding doubling multiply-subtract high half, 16-bit */
> -static uint16_t inl_qrdmlsh_s16(CPUARMState *env, int16_t src1,
> -                                int16_t src2, int16_t src3)
> +static int16_t inl_qrdmlsh_s16(int16_t src1, int16_t src2,
> +                               int16_t src3, uint32_t *sat)

Ditto.


Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

