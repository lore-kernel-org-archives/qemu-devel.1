Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDBEC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE5020848
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgCHkCce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE5020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Yqk-0001GJ-26
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 11:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1Yph-0000EG-Mx
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1Ypf-0001Bg-Q7
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:56:21 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1Ypd-00019M-Pr
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:56:17 -0500
Received: by mail-pl1-x641.google.com with SMTP id e8so4483305plt.9
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 08:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=T7byQEFxk6g6vGuiKIqMAt4ogqiEkEp0yqp3zDMrrYo=;
 b=CgCHkCceCAORMdXzvKHGH6UatUgg716Wwv+sjfEwVxQVpYZVTTXtgrvTtFGlQxy+lz
 wtJbVv2evhjoxtZ0p8adpuIVKJUGBM+oW+Fs5eU1py/XUbfJxzEYpdR1c4oIBK7hx60g
 uZG2z1SbWkXtmtCRBOTjnLG7e9PSjIKCpGb9wORk0ybEihYyrnZ3X9FMomZrd6PCbHVu
 a+W9DvRB7v+uEf/cHgPy79G6kEvt0Uy2RL7gICRYhXVxsWpRcWNbtklLg15wIb8kkPGa
 703WaKh2oNVv4wtCvmx7NNBSwDBEowGYq6fhabWWCqv6IAgX6VcvKRpWp161eImvp13m
 RavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T7byQEFxk6g6vGuiKIqMAt4ogqiEkEp0yqp3zDMrrYo=;
 b=ElIFeuDW1cdYcwuCu3r+pyVSRJeIm05iTYRbC1COhW2Qrendjo40JJvN/SPWPD5now
 kv4FrtJZUuAajK8jKWgD8lYzEWDeYJRZRCO/IrcGU34nQt0IIgvtx9ddjrA2nZRGuLFq
 24ng0O2vuh3iJoS+aQCcCzH7fGThNkLU/1Me6mhAHpnfjPERbAyTzWWPT5x6KYzaW6S3
 vMgl/xuZwA47WiHFh/RAQD5bIioSaUqZj3uofBnCiF7lm7I2s4uQhtSyVVYQHIYlCni+
 V3PgSG1MRNdnkFxXTLJD2IsQB+bUmB6YGCBuIJ6nCwStuGeHVFGBaHQkFMRhFCcfHMOw
 hCeQ==
X-Gm-Message-State: APjAAAUmVYQaHKdWSLiCgY0ucJVljIjRNAAi8sOqltaepz6g+xQ4mxNl
 KHYd0n3Pgkw7Mp7bLjTJh0N8KQ==
X-Google-Smtp-Source: APXvYqx5IWgRfl9XXcSGr8mZ0b3r5+O8ApEzBuS+sLXOPpcKeBuy2voiMKGetpwmRF6BNxIE7u1HbA==
X-Received: by 2002:a17:902:7244:: with SMTP id
 c4mr3962158pll.49.1581440176422; 
 Tue, 11 Feb 2020 08:56:16 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 gc1sm3868883pjb.20.2020.02.11.08.56.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 08:56:15 -0800 (PST)
Subject: Re: [PATCH v4 4/4] target/riscv: add vector configure instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200210081240.11481-1-zhiwei_liu@c-sky.com>
 <20200210081240.11481-5-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <053777e2-7180-5584-cf7f-7876800d9dc8@linaro.org>
Date: Tue, 11 Feb 2020 08:56:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210081240.11481-5-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 8:12 AM, LIU Zhiwei wrote:
>  static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
> -                                        target_ulong *cs_base, uint32_t *flags)
> +                                        target_ulong *cs_base, uint32_t *pflags)
>  {
> +    uint32_t flags = 0;
> +    uint32_t vlmax;
> +    uint8_t vl_eq_vlmax;

bool.

> +
>      *pc = env->pc;
>      *cs_base = 0;
> +
> +    if (env->misa & RVV) {
> +        vlmax = vext_get_vlmax(env_archcpu(env), env->vext.vtype);
> +        vl_eq_vlmax = (env->vext.vstart == 0) && (vlmax == env->vext.vl);

You might as well move the variable declarations inside this block.

> +target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
> +     target_ulong s2)

Indentation.

> +{
> +    int vlmax, vl;
> +    RISCVCPU *cpu = env_archcpu(env);
> +    uint16_t sew = 1 << FIELD_EX64(s2, VTYPE, SEW);
> +
> +    if (sew > cpu->cfg.elen) { /* only set vill bit. */
> +        env->vext.vtype = FIELD_DP64(0, VTYPE, VILL, 1);
> +        env->vext.vl = 0;
> +        env->vext.vstart = 0;
> +        return 0;
> +    }

You're missing checks against EDIV, VILL and the RESERVED field == 0.

> +
> +    vlmax = vext_get_vlmax(cpu, s2);
> +    if (s1 <= vlmax) {
> +        vl = s1;
> +    } else {
> +        vl = vlmax;
> +    }
> +    env->vext.vl = vl;
> +    env->vext.vtype = s2;
> +    env->vext.vstart = 0;
> +    return vl;
> +}
> 


r~

