Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A9DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B779020720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3vVLg/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B779020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtxR5-0006oz-W1
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 14:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtxQN-0006P0-RK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 14:07:03 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:37425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtxQL-00038R-VG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 14:07:03 -0400
Received: by mail-pg1-x52d.google.com with SMTP id d4so2863651pgk.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ucp5d4dL3vJ9H0Aep9vCc+dnoOzT2R8NaA85KEAUyos=;
 b=w3vVLg/wA9/uVfFXYdLU7mOQ19oVB9mI0Du+ELfYwVWJpkVYSUQ3g4HWDUQRpW2jKT
 7v/YvEiyqH1nPrubAFgLqwnsyYQn3kOPGmgKZtyeBpFUsovTQshOA8AUcVBED+pkBHN5
 fm7gGAmkrlXKFoQ4HEV8sLvK0BIBaCSuHZtY/3V5+1UXZII3D5i9rkY9bYyLmeDkH5CH
 CRKFVHQV2R4hkdwTqWA5gb6vNSXwMP05ATCWTmxWb57DbACri0cXFaSbW66arPNAaR5Y
 L5+G/13wSHuAq/nHkhdYHaF87uHBZ/WC59p+HuN680vXo44UQkeAx3eKfW2RSNlpC9q0
 S/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ucp5d4dL3vJ9H0Aep9vCc+dnoOzT2R8NaA85KEAUyos=;
 b=lfv2Zthb2UKIMQxdbDY4BmxNMDChwqAvXoyjh4wm3ozDeNcxba7A+g2829Uo1GgZQ6
 /c0AAi3fMdG4YoXSIKuul93ukGYpZODfW+/lxZCggbWZ2RikKgDAjA6o+GmFa1YLq7tJ
 Our9+S+hQeZVtnSwaxuUScXcOCBmWF3gPI7Oy3eR5+m7W+jiE5m8VyRxJH3w1fiSmgWv
 3HKx2nTCHVTGg8H3IcA7LGWbBK+36RcJ25mClVMFGnb9rSdW+w/tCOGg/+JVCVdcTPRs
 m1yqIyHaPRmggva7D6/1dcl9O6mYDDlmh5rI7HMKaxW9rJXrgKPy4VqTJMdotiBnJ/hZ
 xppA==
X-Gm-Message-State: AOAM530xRBuwIjJ2BmJ8yvDQ4PSPtwuL4QlKs9XI2LbJEoGc3/j0Z5Js
 5S5bow3gln0l6A40yDGRsbMyEg==
X-Google-Smtp-Source: ABdhPJwEoebs6DW//hj9nZ+hlv0MH6TvgoEK2oMknVczX+noXjtCHuQCcfJcVuWS4QHlBTfgo9Vhag==
X-Received: by 2002:aa7:8d95:: with SMTP id i21mr16118927pfr.240.1594404420012; 
 Fri, 10 Jul 2020 11:07:00 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id v8sm6354241pjf.46.2020.07.10.11.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 11:06:59 -0700 (PDT)
Subject: Re: [RFC 13/65] target/riscv: rvv-0.9: configure instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-14-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <facf726b-d355-b0af-3f7f-5574593aa44c@linaro.org>
Date: Fri, 10 Jul 2020 11:06:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710104920.13550-14-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
> -static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
> +static bool trans_vsetvl(DisasContext *s, arg_vsetvl *a)

Do not mix this change with anything else.

> +    rd = tcg_const_i32(a->rd);
> +    rs1 = tcg_const_i32(a->rs1);

Any time you put a register number into a tcg const, there's probably a better
way to do things.

> -    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
> -    if (a->rs1 == 0) {
> -        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
> -        s1 = tcg_const_tl(RV_VLEN_MAX);
> -    } else {
> -        s1 = tcg_temp_new();
> -        gen_get_gpr(s1, a->rs1);
> -    }

E.g. this code should be kept, and add

    if (a->rd == 0 && a->rs1 == 0) {
        s1 = tcg_temp_new();
        tcg_gen_mov_tl(s1, cpu_vl);
    } else ...


> +    if ((sew > cpu->cfg.elen)
> +        || vill
> +        || vflmul < ((float)sew / cpu->cfg.elen)
> +        || (ediv != 0)
> +        || (reserved != 0)) {
>          /* only set vill bit. */
>          env->vtype = FIELD_DP64(0, VTYPE, VILL, 1);
> -        env->vl = 0;
> -        env->vstart = 0;
>          return 0;
>      }

You do need to check 0.7.1 so long as it's supported.


r~

