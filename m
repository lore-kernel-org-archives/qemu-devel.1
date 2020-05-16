Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CDCC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 02:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0648320728
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 02:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHGNfYex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0648320728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZmvX-0001vf-5U
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 22:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZmuo-0001E4-EH
 for qemu-devel@nongnu.org; Fri, 15 May 2020 22:51:06 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZmul-0008K9-68
 for qemu-devel@nongnu.org; Fri, 15 May 2020 22:51:06 -0400
Received: by mail-pj1-x1042.google.com with SMTP id n15so1835746pjt.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 19:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=0X0Zx6pEY1UHzRJ1SYAG9EDHSAXIFkMXfeOz/bWm+bE=;
 b=rHGNfYexiIg+HWlfZRVVBtzUzT+dLX4kBQ5wTRYQd7BC5yD9GJ3LHWd1JWrn3xXBWG
 16M6olHT3lMhzNcUJ6fRCGmTgPemxk1OhXDfpoO3T7f6GACOYC7/y8TwzonP5vx0PCnp
 EobhLT3VWFgxqnIY4DMCNKJOf1c9kqG1vONFcuw8APAiMS5Qc7k0+ik//cbdhzcKvImQ
 tiHcQ0gHDauDNqaW3QrWiDvVRyPoI3TCdWoj40Xx8JcwkvLllGWAw9CisNbP6+YDkMTb
 0LqVAK+U2utnHTXaUMFKvyGj0A954LK3e23meqJr9TnujiqwV5F90Iob+NYtoM4v7Pkk
 RtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0X0Zx6pEY1UHzRJ1SYAG9EDHSAXIFkMXfeOz/bWm+bE=;
 b=RhMP3v/u/BOtzxKEK85fw+SwpsBIs269T9Z541cP1CkhQPfyUsOVeQszK7mi9p7hay
 zlDzYPMYJM3sif/Qqecc3+Cw7k9sxWnAZiYhTkAGyHLSvOHjdgE41ahZ62A7GGjwlmuf
 ixouTd86Zg5rFeUxK5UFwcOKtnFLUSKggHOpSfE3euVZS5BRuOBg9v0a8kW9hcckQ2uV
 ufkcBoU28uECBK9+xRRk1VLApCYUj5V6hswb9fE16Zrb6et7xX41UqmBq20H5qtwbkKx
 5Uv9GSUYjww70q42JO9GTcBxMsdsBWm3g70Wm3RccOA+tdnr2QZQsJo887bZQwfkjHq3
 nHIw==
X-Gm-Message-State: AOAM531fXOhqNzDYU+KHY+ASPhYwkUk+ewbnGcf/xJ8FbNLj5yQvMZfl
 rH1jMDV6Lt7fSrU0hqp+NneqB8PR5GM=
X-Google-Smtp-Source: ABdhPJx1ZQTl/nzkJQ08ZF7kS0dLECXgEJ2mpPE1/2IqGfRlL9csOZgrcH2YKJQ7oiYqIh/VskUdzQ==
X-Received: by 2002:a17:902:7202:: with SMTP id
 ba2mr5420393plb.93.1589597461198; 
 Fri, 15 May 2020 19:51:01 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s136sm3057676pfc.29.2020.05.15.19.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 19:51:00 -0700 (PDT)
Subject: Re: [PATCH 10/10] target/arm: Convert Neon one-register-and-immediate
 insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200515142056.21346-1-peter.maydell@linaro.org>
 <20200515142056.21346-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96522b6c-8d33-51b4-cbdb-e8973f6487b5@linaro.org>
Date: Fri, 15 May 2020 19:50:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515142056.21346-11-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 7:20 AM, Peter Maydell wrote:
> diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
> index f27fe769f85..f4eeb84541f 100644
> --- a/target/arm/translate-neon.inc.c
> +++ b/target/arm/translate-neon.inc.c
> @@ -1821,3 +1821,154 @@ DO_FP_2SH(VCVT_SF, gen_helper_vfp_sltos)
>  DO_FP_2SH(VCVT_UF, gen_helper_vfp_ultos)
>  DO_FP_2SH(VCVT_FS, gen_helper_vfp_tosls_round_to_zero)
>  DO_FP_2SH(VCVT_FU, gen_helper_vfp_touls_round_to_zero)
> +
> +static uint32_t asimd_imm_const(uint32_t imm, int cmode, int op)

It would be better to match AdvSIMDExpandImm and return uint64_t.

> +    case 14:
> +        imm |= (imm << 8) | (imm << 16) | (imm << 24);
> +        if (op) {
> +            imm = ~imm;
> +        }

You could then handle case 14 op == 1 properly here,

> +static bool trans_VMVN_14_1r(DisasContext *s, arg_1reg_imm *a)

and you wouldn't have to special case this at all.

> +{
> +  # Logic operations, ie not VMOV or VMVN: (cmode & 1) && cmode < 12
> +  VORR_1r        1111 001 . 1 . 000 ... .... 0001 0 . 0 1 .... \
> +                 @1reg_imm cmode=1 op=0
> +  VORR_1r        1111 001 . 1 . 000 ... .... 0011 0 . 0 1 .... \
> +                 @1reg_imm cmode=3 op=0
> +  VORR_1r        1111 001 . 1 . 000 ... .... 0101 0 . 0 1 .... \
> +                 @1reg_imm cmode=5 op=0
> +  VORR_1r        1111 001 . 1 . 000 ... .... 0111 0 . 0 1 .... \
> +                 @1reg_imm cmode=7 op=0
> +  VORR_1r        1111 001 . 1 . 000 ... .... 1001 0 . 0 1 .... \
> +                 @1reg_imm cmode=9 op=0
> +  VORR_1r        1111 001 . 1 . 000 ... .... 1011 0 . 0 1 .... \
> +                 @1reg_imm cmode=11 op=0
> +
> +  VBIC_1r        1111 001 . 1 . 000 ... .... 0001 0 . 1 1 .... \
> +                 @1reg_imm cmode=1 op=1
> +  VBIC_1r        1111 001 . 1 . 000 ... .... 0011 0 . 1 1 .... \
> +                 @1reg_imm cmode=3 op=1
> +  VBIC_1r        1111 001 . 1 . 000 ... .... 0101 0 . 1 1 .... \
> +                 @1reg_imm cmode=5 op=1
> +  VBIC_1r        1111 001 . 1 . 000 ... .... 0111 0 . 1 1 .... \
> +                 @1reg_imm cmode=7 op=1
> +  VBIC_1r        1111 001 . 1 . 000 ... .... 1001 0 . 1 1 .... \
> +                 @1reg_imm cmode=9 op=1
> +  VBIC_1r        1111 001 . 1 . 000 ... .... 1011 0 . 1 1 .... \
> +                 @1reg_imm cmode=11 op=1
> +
> +  # A VMVN special case: cmode == 14 op == 1
> +  VMVN_14_1r     1111 001 . 1 . 000 ... .... 1110 0 . 1 1 .... \
> +                 @1reg_imm cmode=14 op=1
> +
> +  # VMOV, VMVN: all other cmode/op combinations
> +  VMOV_1r        1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... \
> +                 @1reg_imm
> +}

I wonder if it's worth repeating VORR/VBIC so many times.
You can just as well do the (cmode & 1) && cmode < 12 check in the trans_ function.


r~

