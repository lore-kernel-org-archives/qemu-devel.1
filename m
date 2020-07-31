Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17681C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61FD21744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dn1joeRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61FD21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1XQD-0007N8-71
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 11:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1XPY-0006uA-Q5
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:57:32 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:41420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1XPV-0004Fe-DH
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:57:32 -0400
Received: by mail-pg1-x52b.google.com with SMTP id s15so4696901pgc.8
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TQzd750oWY6KNbNwxdj7BgOtLVA7/KAhlkj25Iz7Rk4=;
 b=Dn1joeRXQhWFdq1p/5MlD1RgDVmC5qXVJz6ZcK5JdNmoMZxqvOKWk3CRYtz7/AW2GO
 nVxay2BMvzVthgFmDT8L/VIYmTYyEKAN1L3ZBW4GR/LWE+DDPeOiEcAkbE+4RuJ3iBUh
 kHj0yaWFF0ayrnBZpLtkrThj+4oYJxDe1A9rwrYiSkyScCPDrU1B5v+dNWB0D6oYcIVN
 mhazKWIZnUVr4GFqDRR5GEhGgIGu1O7C7gA11GcOsu5gf3FY5Hc7XhfiCL/EBq9FjAE0
 0AwIrTSyMeS9cBgp7OF5bPXTghBeYVN96mNGr1VFTrHRckJG7/UjyD8fyaQBVQUBelZ4
 Zu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TQzd750oWY6KNbNwxdj7BgOtLVA7/KAhlkj25Iz7Rk4=;
 b=P0Pzf2GhdxsuZlr015WBQaSNUd3iBRECrdurcaQugPPiFi9EB3I0iIWjKivILW5iSJ
 D+LWXjNc7DDDmJ5hwo0uJUos+Yb0TxRxGEIl7X+HBzB9aEYyqQwS7hWhh9A/q0oJpGHc
 n6DFJE1b0Xiu8FmJxOcRlhQ2X2PTTF3C6JH8Ldq7O1f/BMbpqylVgjejXSQJDuuOEMqX
 Q0FbGTdE+yAndDmNmvTfltJtdI9gZSxe9C7Y9Xc4p9mm0VVotxu/gfoJJB8ekWejBfK5
 t1uJ6L3cnYQji88qbSFxXIIJSXElXIei0D6cmmXIS2Bc10DhcHHl/4yDmCZek4jL+7Sy
 8nPA==
X-Gm-Message-State: AOAM531PLVs+1JGWxS770nWR3s/jTiyCtfEORHcvC5sCmADQVRxzxKUO
 sgGYRbuhnGtFWp+gmoImgJ/TcA==
X-Google-Smtp-Source: ABdhPJygbS7jS5Tldp6WcszuBp5SEfn9gb6ThM6QG5rJkcqsOqbR/Vh9dYjVH94C6xxaHJGkxFHqQw==
X-Received: by 2002:a63:de4b:: with SMTP id y11mr4362328pgi.26.1596211047599; 
 Fri, 31 Jul 2020 08:57:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id my16sm9890508pjb.43.2020.07.31.08.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 08:57:26 -0700 (PDT)
Subject: Re: [RFC v2 58/76] target/riscv: rvv-0.9: slide instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-59-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d39ec02d-8d73-7991-cb06-ce03fbe65e4e@linaro.org>
Date: Fri, 31 Jul 2020 08:57:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-59-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> -#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H, CLEAR_FN)                  \
> +#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H)                            \
>  void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>                    CPURISCVState *env, uint32_t desc)                      \
>  {                                                                         \
> -    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
> +    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
>      uint32_t vm = vext_vm(desc);                                          \
> -    uint32_t vta = vext_vta(desc);                                        \
>      uint32_t vl = env->vl;                                                \
>      target_ulong offset = s1, i;                                          \
>                                                                            \
>      for (i = 0; i < vl; ++i) {                                            \
> +        /* offset may be a large value, which j may overflow */           \
>          target_ulong j = i + offset;                                      \
> +        bool is_valid = (offset >= vlmax || j >= vlmax) ? false : true;   \

This is... silly verbose.
But also, the test is partially loop invariant and entirely predictable,
allowing loop fission.

>          if (!vm && !vext_elem_mask(v0, i)) {                              \
>              continue;                                                     \
>          }                                                                 \
> -        *((ETYPE *)vd + H(i)) = j >= vlmax ? 0 : *((ETYPE *)vs2 + H(j));  \
> +        *((ETYPE *)vd + H(i)) = is_valid ? *((ETYPE *)vs2 + H(j)) : 0;  \
>      }                                                                     \
> -    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
>  }

E.g.

    i_max = s1 < vlmax ? vlmax - s1 : 0;
    for (i = 0; i < i_max; ++i) {
        if (vext_elem_mask(v0, i)) {
            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + s1));
        }
    }
    for (i = i_max; i < vl; ++i) {
        if (vext_elem_mask(v0, i)) {
            *((ETYPE *)vd + H(i)) = 0;
        }
    }


r~

