Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB68CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85ED42082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCB03aqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85ED42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k184V-0004R0-Li
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 08:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k183W-0003jT-5y
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:53:06 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:34600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k183U-00018a-3S
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:53:05 -0400
Received: by mail-pl1-x632.google.com with SMTP id o1so14038928plk.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gmKrgMtQHadv1YxK5nuclZtAf0KcbltmnzqFTwLu2hE=;
 b=jCB03aqTzSbwGe4ym8Vk+bmdznuL8S/BoubvTQuuC6Wb4ff+l0i7Ry0YRoOxT056B0
 ABQHZbcYc9yOjmEOTiWp1To9FizaBfhfgBMY/i9omOUDLDsykIwZE8oYUbiJgVIL5nTR
 A7lFlI7vRTgp2MOHHzd1U53p+q4SVYBlMqy7Sr7xb/Xl6sNcFx7Y5rKtYp8JEwz2v4Eu
 O4SJrr07g5AlUr1laTYTJW1hixSj8Te4nhwWZwP9T8LtV+GihNeH8yWaix6k8EEH+VdG
 pWjADy1JmHqykLLvEhlodSb506+QeUvrc6bz9Nd98JM/T4Tu/zFpJtJfjtm6nubvNfju
 eXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gmKrgMtQHadv1YxK5nuclZtAf0KcbltmnzqFTwLu2hE=;
 b=aL6uboBmDON9FLjvVFkw+GMGnNVSFHFKcJHYYRGydOLe3dlRrsNE1OSOR2KmGKnQ2l
 h3mdvwRW2zyZj+M9bXK9ELvSo7pkZmQ+nSJQYC5ess/BJxPDiEJrQqxzqP4OXLkMnfxU
 kKV3TWaR571ilwXwkxlZxPQfsUHtc3A8h6h9xWIQBNzckdLCfcXDeHOwmbjQytJEYUs7
 nvmZG61vK3cywnsetT1f/l6w5oWwOlN8mfqVyR8QpaaqImlPzyOij731GJ+FyZe3VRuP
 picgKvab60savzNAAYP4VmcSwGLP2bTbTA+qlxcWhstTNGdYE+BvPaDnk/HQKcK2q8Fa
 /zyw==
X-Gm-Message-State: AOAM533D5oS5Af8tL1Seon+qAAaaR/3b2ogh6IBgbfSMI/m0/6uBsBO+
 eyf/Q8lfzcIX0ASTk88ceaJLaw==
X-Google-Smtp-Source: ABdhPJzULxmUI8/tOLxQMawIKduXlo7uo88DMZ0NmetdLSS219+W1JJkfgAyQ1itcYyIx/72DkpG3w==
X-Received: by 2002:a63:d30a:: with SMTP id b10mr33732357pgg.430.1596113581078; 
 Thu, 30 Jul 2020 05:53:01 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id z20sm5138165pjr.43.2020.07.30.05.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 05:53:00 -0700 (PDT)
Subject: Re: [RFC v2 29/76] target/riscv: rvv-0.9: take fractional LMUL into
 vector max elements calculation
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-30-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b2cae719-8441-efe6-b6ea-3acf07194f30@linaro.org>
Date: Thu, 30 Jul 2020 05:52:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-30-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> -/*
> - * A simplification for VLMAX
> - * = (1 << LMUL) * VLEN / (8 * (1 << SEW))
> - * = (VLEN << LMUL) / (8 << SEW)
> - * = (VLEN << LMUL) >> (SEW + 3)
> - * = VLEN >> (SEW + 3 - LMUL)
> - */
>  static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
>  {
>      uint8_t sew, lmul;
> -
>      sew = FIELD_EX64(vtype, VTYPE, VSEW);
> -    lmul = FIELD_EX64(vtype, VTYPE, VLMUL);
> -    return cpu->cfg.vlen >> (sew + 3 - lmul);
> +    lmul = (FIELD_EX64(vtype, VTYPE, VFLMUL) << 2)
> +            | FIELD_EX64(vtype, VTYPE, VLMUL);
> +    float flmul = flmul_table[lmul];
> +    return cpu->cfg.vlen * flmul / (1 << (sew + 3));
>  }

I think if you encode lmul differently, the original formulation can still work.

E.g. LMUL = 1   -> lmul = 0
     LMUL = 2   -> lmul = 1
     LMUL = 1/2 -> lmul = -1

so that, for SEW=8 and LMUL=1/2 we get

  cfg.vlen >> (0 + 3 - (-1))
= cfg.vlen >> (0 + 3 + 1)
= cfg.vlen >> 4

Which neatly avoids the floating-point calculation that I don't like.


r~

