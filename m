Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD2BC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE4522210
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xj6Ha22R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE4522210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6mR-0005tF-1k
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kT6iy-0002jK-F3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 13:07:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kT6iw-0003P5-2D
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 13:07:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id g29so2308936pgl.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A4vxSpqbWc/TY+Bd40PufIAYhCeEr6WaAxBYRp0RJps=;
 b=Xj6Ha22RSA//us0fRJSYBLWsJbgi9rm3142nEnftmd3M/50FMdNCy2/12N96Cb3Kjh
 YInVadEnY0mVv2a/28pER71srSILhATVMP4jYpzDn1uHUAGqOEg+Br+fVOk7sijjLTEk
 w2i7wtETTo+cJdZskNzq89/TSiutOYFgR0reWskmw1Rz4OSyBF1BOTP26Isr0FO8106R
 7PiRhsg+oFJHzom0mZaMlBkNNI+6jwym0az6+QIV3SU3dU5t25NEv9RCrKEzSIJcIhFR
 rIhBiq9FMhEmB/RGj3cOqNew+sLKeCzl/o50dkH8HSt/fiZ2NzmQ+vxP9h4y8hBOk1Ta
 FhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A4vxSpqbWc/TY+Bd40PufIAYhCeEr6WaAxBYRp0RJps=;
 b=flcQfAUToE4dGTJQQcAj7QSxSJqP029JkH+Eft10xwptU9iK8Yq0bLvVF6b9zGV1CL
 qZKac8wvOpPHscPix7TgsUl/WokX4BPMhDeem0aBUZK2y3jA/a1tDfJv4ySxgvLIORbC
 IzyfidGJ/mplFyMYFN6hd/jcvw1znG3dg1yLOvtXqn0YDsmryOyK3dzUiMEbdStuJE/S
 UkhOYHzmS8avmEx+/KYppYbebZZT1Kw4lSO5lHFhJTEXk6Eds+bY+8z4DhT17PU3MYWh
 Q9i0RLiTIWzrzn23UPVWaEsq5JZt0uPrTejlSW6D0Frl6tMiRFoxEk1CxR5QmlgKhMIJ
 +7NA==
X-Gm-Message-State: AOAM530fBF1Tm8cl8SJYduBaDP+FIT40LjJJaHj7jufigPbJo9Gd5Vzt
 /nvRNPFJI6eiAnoAlwQ9NM3Eaw==
X-Google-Smtp-Source: ABdhPJwE2ufofkeFtq6cwnjeL2J4s2dNK5KhVg/AKb2SIhK1JYqRHItyw9mauguMJaUEgXcj+vx24Q==
X-Received: by 2002:a63:c44c:: with SMTP id m12mr3977379pgg.92.1602781648653; 
 Thu, 15 Oct 2020 10:07:28 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w16sm3987261pfn.148.2020.10.15.10.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 10:07:27 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] [RISCV_PM] Implement address masking functions
 required for RISC-V Pointer Masking extension
To: Alexey Baturo <baturo.alexey@gmail.com>
References: <20201015152139.28903-1-space.monkey.delivers@gmail.com>
 <20201015152139.28903-5-space.monkey.delivers@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3975e121-fb59-ffaa-456b-13e1a1b871be@linaro.org>
Date: Thu, 15 Oct 2020 10:07:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015152139.28903-5-space.monkey.delivers@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.019,
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 space.monkey.delivers@gmail.com, Alistair.Francis@wdc.com,
 kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 8:21 AM, Alexey Baturo wrote:
> +        switch (priv) {
> +        case PRV_U:
> +            pm_enabled = env->mmte & U_PM_ENABLE;
> +            break;
> +        case PRV_S:
> +            pm_enabled = env->mmte & S_PM_ENABLE;
> +            break;
> +        case PRV_M:
> +            pm_enabled = env->mmte & M_PM_ENABLE;
> +            break;
> +        default:
> +            assert(0 && "Unreachable");

g_assert_not_reached();

> +    /* PointerMasking extension */
> +    uint8_t pm_enabled;

bool

> +    if (s->pm_enabled == 0) {

!s->pm_enabled

> +    if (riscv_has_ext(env, RVJ)) {
> +        ctx->pm_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_ENABLED);
> +        int priv = cpu_mmu_index(env, false);
> +        ctx->pm_mask = pm_mask[priv];
> +        ctx->pm_base = pm_base[priv];
> +    } else {
> +        ctx->pm_enabled = 0;
> +    }

Don't need the if.  And should it in fact be placed outside the ifdef?  This
shouldn't be related to !CONFIG_USER_ONLY here and nowhere else.


r~

