Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC00C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 19:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D062F20776
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 19:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMO/lljB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D062F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC6JM-000808-34
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 15:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC6I9-0007Pj-Hf
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 15:13:33 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:38719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC6I7-0000QX-LA
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 15:13:33 -0400
Received: by mail-pg1-x52a.google.com with SMTP id l191so2081767pgd.5
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 12:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7vfRGmvkycs9b3PuqV/xniTiuFAdsTo4TrtMviFYgBk=;
 b=IMO/lljBaMXOewAtRdX4VzIyawiG7t5MKSUYFZFKaHB63MgKSGbnHNvUvZ17YhmFkE
 aRrumI3ymWmvfjgTrF2ueVSln6000gS9+18NcCCopS9vGLzeHL9/7Zl8sDxNP/vXGPWF
 C0iyhKZlmhjwNPbHBswdGkZK/wmOrwy+uIAm5OLpEJZGAhZLPocUf9eH/2wiVBT/Ectp
 V1FjlbmfBWQw/syXmGpgH6HRlKgkybhedSPNEm6L3yNqN59uQE+eNwginLW98twfxOQ4
 yMOpbfySoT7srQi/Z84nXoExx0u9GGYhsV9EjslXdMcFVr2VM1Cw+41jq2PnFEhL+Fyl
 fwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7vfRGmvkycs9b3PuqV/xniTiuFAdsTo4TrtMviFYgBk=;
 b=p5Ql3xdWyzeQpN5dnl/MMsLbrSiDr9QRNoARdYECUH3n5wMJ/PdE92guY8OngTR1HG
 zMN7wIFP9xHm1OchTtZ1XBk2dH34z9WayNwNCt2HsVRV4pWd3rmh99AGDJdf/3Px3QyM
 25Zk5Dm4xthYAfzew+P5Br0BnKoJmzl+xlKZSrimxfmgDwFsGX8I6IxTENjcK9NIXTlS
 HQl/fpEXElxbf1WpFeSptLc0wT1mWdKYcYoPoWn4Kr1thZ+tZEmkMo1JNtuOkgOXMIqX
 B43u0Ay7LjuWUX3RWuX08uQ63h9I3z8Cx5EJsey4yxDG5HrIZyvVRDmVde1YdKG3IvcI
 977A==
X-Gm-Message-State: AOAM530dbiesHqsBQmxDW2QPzBgDLNjcXQduQ2gtOyH3Q6/H2bOfEbD9
 StSqUBshTC/9i5Chx88/FTl85g==
X-Google-Smtp-Source: ABdhPJyg1xkldLFDozBvoG2w4pgeHaykLBNAEiv+rukkfj3tQguixGQUy5zffFIdgHm6hKikHhBaVQ==
X-Received: by 2002:aa7:850b:: with SMTP id v11mr3891961pfn.240.1598728409888; 
 Sat, 29 Aug 2020 12:13:29 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r186sm3616310pfr.162.2020.08.29.12.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 12:13:29 -0700 (PDT)
Subject: Re: [RFC v4 23/70] target/riscv: rvv-1.0: load/store whole register
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-24-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2c43a438-e9ae-6e8f-0d52-066278756c14@linaro.org>
Date: Sat, 29 Aug 2020 12:13:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-24-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> +/*
> + * load and store whole register instructions ignore vtype and vl setting.
> + * Thus, we don't need to check vill bit. (Section 7.9)
> + */
> +#define GEN_LDST_WHOLE_TRANS(NAME, EEW, ARGTYPE, ARG_NF, IS_STORE)     \
> +static bool trans_##NAME(DisasContext *s, arg_##ARGTYPE * a)           \
> +{                                                                      \
> +    if (require_rvv(s) &&                                              \
> +        QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                              \
> +        uint32_t data = 0;                                             \
> +        bool ret;                                                      \
> +        data = FIELD_DP32(data, VDATA, NF, ARG_NF);                    \
> +        ret = ldst_whole_trans(a->rd, a->rs1, data, gen_helper_##NAME, \
> +                               s, IS_STORE);                           \
> +        return ret;                                                    \
> +    }                                                                  \
> +    return false;                                                      \
> +}

Decodetree is intentionally organized such that ARGTYPE = NAME.  There's no
point in duplicating that.  Move everything besides the call to
ldst_whole_trans into ldst_whole_trans.


r~

