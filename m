Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BCCC54E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AB9206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dhjcqlt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AB9206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCo1-00067R-MT
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCmP-0004pD-FS
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:03:53 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:34184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCmO-000197-Dn
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:03:53 -0400
Received: by mail-pj1-x1042.google.com with SMTP id h12so7646826pjz.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mIBc+kNvyU30Y+hJkEQrlzH5jKYhD4liX7QQU/Ik81E=;
 b=Dhjcqlt4gsnjd4W/zsWZd75GuJnCDvKQO0vhiG7/L538EjXmIGcZMGbVK/DlpaMtpx
 Lllk75aFj0Sg5SAVBmpmUy7x/wScg7lMJhRlOGIwf7E5tRbUckTxocqeAzF2M4RVM56b
 pGL+yt5Wl/BkPmGvHtMVZsd2Wu4kTVpieEmHBtiUfHBTTJFiMvG2otyfCcMU7Eh8p8h7
 +AjpBWELyGShJ988GJLMoNGX19uwqBLvYh7yZ2Hwt+Kfv4/FFL64y1OzqeTG5JRFuj4q
 mNrjG/QL1EtLJIImBDchn/3ThZSSOrYVkyJ3its8zHkfW97H6/u+V/NT9W2CUiEo9Rgy
 bAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mIBc+kNvyU30Y+hJkEQrlzH5jKYhD4liX7QQU/Ik81E=;
 b=EkTbzTOk5gsBg/miFcNuzDGAyKYY7TwT63lCqGMyZkcJTPTZOcM+Y664/LUJO6JyWx
 WJrGXbxPg533peyl6ybUV6l5Ii6wV1U76RtlpvxpYLbTGDjCVTKTvi5gPoA80zJXK+Xr
 rfEFyUSv/AexMInVdNXdu6ccppphOTSK038qo3fxLr9N3L0Zx51a1hvZV9dN3R9+/ga+
 T/E8+nUnScPKj1511q6xkMnwjtjlyugqqzjcu7zsyWXNmSIdCVMmV267fCZ+e3plkHrX
 Evuxca5S+9rCGQmtJONK1iHL17h0HtfWkDpYcxN+UIKibe475NMIxMu9HalCvlDHYKek
 pxUw==
X-Gm-Message-State: AGi0PuYdYDWPHxSoBIVN2nAH7kl5Nm2n2JP0PdFARynP/fj/8rnC6DT7
 PBYWMP4KiEgCPpjMbOf1ZCtx3A==
X-Google-Smtp-Source: APiQypK9zkLgCIXLUJn1nQWGILAEfE1lLpAtd0YwxAaW/EFzHwriaG9fY9QnIrx4wCwvHQwncsUr3Q==
X-Received: by 2002:a17:90a:23e2:: with SMTP id
 g89mr24049256pje.105.1589220230648; 
 Mon, 11 May 2020 11:03:50 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id k27sm8359720pgb.30.2020.05.11.11.03.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 11:03:49 -0700 (PDT)
Subject: Re: [RFC PATCH 4/8] riscv: Implement payload load interfaces
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, peter.maydell@linaro.org
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
 <20200430072139.4602-5-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5a960977-eb88-1fc1-ae45-b10812777e04@linaro.org>
Date: Mon, 11 May 2020 11:03:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430072139.4602-5-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com, alistair23@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:21 AM, LIU Zhiwei wrote:
> +void reginfo_init(struct reginfo *ri, ucontext_t *uc)
> +{
> +    int i;
> +    union __riscv_mc_fp_state *fp;
> +    /* necessary to be able to compare with memcmp later */
> +    memset(ri, 0, sizeof(*ri));
> +
> +    for (i = 0; i < 32; i++) {
> +        ri->regs[i] = uc->uc_mcontext.__gregs[i];
> +    }
> +
> +    ri->sp = 0xdeadbeefdeadbeef;
> +    ri->regs[2] = 0xdeadbeefdeadbeef;
> +    ri->regs[3] = 0xdeadbeefdeadbeef;
> +    ri->regs[4] = 0xdeadbeefdeadbeef;
> +    ri->pc = uc->uc_mcontext.__gregs[0] - image_start_address;
> +    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.__gregs[0]);
> +    fp = &uc->uc_mcontext.__fpregs;
> +    ri->fcsr = fp->__d.__fcsr;
> +
> +    for (i = 0; i < 32; i++) {
> +        ri->fregs[i] = fp->__d.__f[i];
> +    }
> +}

Perhaps wrap the fp bits here in

#if __riscv_flen == 64
    ri->fcsr = fp->__d.__fscr;
    ...
#else
# error "Unsupported fp length"
#endif

> +        if (m->regs[i] != a->regs[i]) {
> +            fprintf(f, "  X%-2d    : %016" PRIx64 " vs %016" PRIx64 "\n",
> +                    i, m->regs[i], a->regs[i]);
> +        }

riscv doesn't name its registers with an x.


r~

