Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F21C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DE0206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gfj7ycDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DE0206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6Z6-0006i0-E2
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kT6QR-0006sL-AE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:48:23 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kT6QO-0000tR-Ck
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:48:22 -0400
Received: by mail-pl1-x642.google.com with SMTP id y1so1920863plp.6
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UvhsZGgMHqu6IDXgm3a7sou65oEWD68CgiWOS6Kzp4c=;
 b=Gfj7ycDgKmcRXgSecJT+WECivUEyjA8C+RYu6T3oX9xNKaHzq9YGJJKYNeR2RhTqAm
 oo2xB/ArBs51CkU6kX5PXRaOk7p1huxqRho7XFmX/IUz1DE6BRTBoQROe6q124beK9lE
 tKwg9NKCuFCyGB4DF4/8imUPpMflwwT1enASL3lQWn/mYYpBtNFbazTXPqI1WRTb3WDc
 ELQ5m7CkLvra1JbWVB94diJOirauSB88Um842n9wMOyZO4gt3XDQg/E3JDD6/UT34SD+
 cJV5AYFptYg3U39ckUIrl3y1MYkb3jMGSuMuplXQ9TCNHe4lHp4vwnct2gMHaJ/D31Cd
 VDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UvhsZGgMHqu6IDXgm3a7sou65oEWD68CgiWOS6Kzp4c=;
 b=OI1BDVS8SdBvP4aQ1rIimOXSadOAWUj8FbhTfZAARjzhZ1m20f+YVv/rgBC5fn8kja
 YE9s9lMTaUS82J7orJ83Nf3ou29fIQCjCAP+IIYlX4eQn7JcAt+synsyk1mwKfzySq6I
 VHfdQMaMOFzm59eSMPpr5jTp3a/QHsIjFClfnxB9pXIBzlrVEXrszRBEfr60IR0sro/R
 XNwd8zoBQu/feJuXBrht15oqWAA4Cn3IRkkzCvgavKp4mox0cLLnJoiMnvuXoQhAlXaB
 xkNZLRjeDV5lJ4NO0TRmrZdjhK0hzUvEFu9XL9Md0bNCm19FFwS7imsq3TcJ0vrRv9JH
 W+yA==
X-Gm-Message-State: AOAM533HIY+eMg3OCU9aG433G3UCTY7Mvh+Mh8tEau9mtVR1ZFCMBMx5
 q3mZF2XgsFuLw2USRpqQJP2U5g==
X-Google-Smtp-Source: ABdhPJzJSnOFWPEgKMiKAXVNWqajNjpo8T5Mb+0MjQIHSdv3aGc6Rl/9diPnxrXi3e7Xy2wP+B9ZrQ==
X-Received: by 2002:a17:90a:73c9:: with SMTP id
 n9mr5173916pjk.90.1602780498395; 
 Thu, 15 Oct 2020 09:48:18 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id i25sm3799202pgi.9.2020.10.15.09.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 09:48:17 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] [RISCV_PM] Support CSRs required for RISC-V PM
 extension except for ones in hypervisor mode
To: Alexey Baturo <baturo.alexey@gmail.com>
References: <20201015152139.28903-1-space.monkey.delivers@gmail.com>
 <20201015152139.28903-2-space.monkey.delivers@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d39e0c59-3b04-6401-aaac-8e202fb5036a@linaro.org>
Date: Thu, 15 Oct 2020 09:48:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015152139.28903-2-space.monkey.delivers@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.019,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> +/* Functions to access Pointer Masking feature registers 
> + * We have to check if current priv lvl could modify
> + * csr in given mode
> + */
> +static int check_pm_current_disabled(CPURISCVState *env, int csrno)
> +{
> +    /* m-mode is always allowed to modify registers, so allow */
> +    if (env->priv == PRV_M) {
> +        return 0;
> +    }
> +    int csr_priv = get_field(csrno, 0xC00);
> +    /* If priv lvls differ that means we're accessing csr from higher priv lvl, so allow */
> +    if (env->priv != csr_priv) {
> +        return 0;
> +    }
> +    int cur_bit_pos = (env->priv == PRV_U) ? U_PM_CURRENT :
> +                      (env->priv == PRV_S) ? S_PM_CURRENT : -1;
> +    assert(cur_bit_pos != -1);

This is a bit clumsy.  I suggest

    int cur_bit_pos;
    switch (env->priv) {
    case PRV_M:
        return 0;
    case PRV_S:
        cur_bit_pos = S_PM_CURRENT;
        break;
    case PRV_U:
        cur_bit_pos = U_PM_CURRENT;
        break;
    default:
        g_assert_not_reached();
    }

> +static int read_mmte(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +#if !defined(CONFIG_USER_ONLY)
> +    if (!riscv_has_ext(env, RVJ)) {
> +        *val = 0;
> +        return 0;
> +    }
> +#endif

This ifdef is wrong.  CONFIG_USER_ONLY doesn't have anything to do with what
features the cpu supports.  Nor can it be correct.  If you try to read this on
current hardware, without J, then you get an exception not zero.

I would have expected this check would actually go into the csr predicate function.

> +    *val = env->mmte & MMTE_MASK;

Surely you don't need MMTE_MASK here because you used it when writing.

That said, don't you also need to mask vs the current priv level?  There's
language in your doc that says "XS bits are available in..." and "PM bits are
available in...".

I'll also note that it says "by default only higher priv code can set the value
for PM bits", while surely it's a security bug for lower priv code to read
anything related to a higher priv.


> +    target_ulong wpri_val = val & SMTE_MASK;
> +    assert(val == wpri_val);

Incorrect assert.  This value is under guest control.  Do not crash qemu
because the guest is doing silly things.  Raise an exception if you like, and
perhaps qemu_log_mask with LOG_GUEST_ERROR.

> +    if (check_pm_current_disabled(env, csrno))
> +        return 0;

Missing braces.


r~

