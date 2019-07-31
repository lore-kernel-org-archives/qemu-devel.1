Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873A2C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566E3208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEpxoE6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566E3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsuOl-0001o9-Ma
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 15:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43363)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsuOC-0001MG-LB
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsuOB-0000f9-KH
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:35:56 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsuOB-0000er-Aa
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:35:55 -0400
Received: by mail-pg1-x541.google.com with SMTP id u17so32560059pgi.6
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JaGSxodXv4hswMEiRb8HfD/p2DF1lVhhouD5ZaRLGnc=;
 b=DEpxoE6AfRKRH/KsGMKGdR6019kvjdnGMOdQBgNPFYDaQMISvcxZ7/klTrMEATfujc
 Qlb4WeRy1FnB5uDiIQTgvwu4kr/t7lzL+Im+t+DVxWN40P+7c6fw+uHaDHK9Kfry4aa2
 F2QGJXxV52P3HvmPzJ0oqYzXMDtFMN5s9j3/9w5PcrflVRYCQEb1Cun7DYsm2ZlnjB46
 3wNhOwGkiiW+cqOFXdk05sl2Ks1imlFaNHB+EXXIPugIJDZZ1ciAECjIB9EO4FsxjJ8v
 Sal4VR8fgrYtqQR2gVrrQvAaoVuwLouyTGZZz3tcIQYcrGHToZujsWUuRt4WLCP0SeTQ
 m3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JaGSxodXv4hswMEiRb8HfD/p2DF1lVhhouD5ZaRLGnc=;
 b=Jv08tVLnLsZIblLQHTnzK+AaLwhGhShO8sMsokH8Blpbj4xLmF7y8kiUL3PirXlX0a
 /O5p1i53LCXnSA18RNc2t5LpDJmoJ0/9RhBRK3Bv+vDqcd5O8+Z2ka7hPlHGoP7X13/0
 wbPSUiooAgiDvLGNyUoPTEYePmK9k67Yjm/+5w5w0J7cc69qyHPp5Kxnz0DZO1kxXaMG
 eEYufvc5I7ab458G7Yd9CTpHerp2fzccDmLDzU1F5qyyAcf7U+1zPjYVZZ7BbLps81Vi
 R6ufrxCDKe7KlwTHq2O9dnniK55FRMEuJCkt4QdZuW8fPad05JN9cTAfySPTIhRkxnzq
 xP1g==
X-Gm-Message-State: APjAAAXLVnxiCHlHIq1aSDe36iaN5pmDnmbnxxAK+ZRF5OCJ0KarLQTX
 1avPm54tbo1H9MD8wzSpNIKl2g==
X-Google-Smtp-Source: APXvYqww/WwJ+IP1n7R/M2wGtjgDi6RA16vMAycxhTcb3AtrI/Rr63eBXHXPWnn5xk4hVFy6fqwVlw==
X-Received: by 2002:aa7:8641:: with SMTP id a1mr49294016pfo.177.1564601753620; 
 Wed, 31 Jul 2019 12:35:53 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 11sm69613994pfw.33.2019.07.31.12.35.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 12:35:52 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-9-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6d2c01c9-17a4-163c-349c-537bc54289fb@linaro.org>
Date: Wed, 31 Jul 2019 12:35:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731175702.4916-9-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [RFC PATCH v1 08/22] target/i386: reimplement
 (V)PAND, (V)ANDPS, (V)ANDPD
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 10:56 AM, Jan Bobek wrote:
> +#define gen_pand_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
> +#define gen_pand_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
> +#define gen_vpand_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0123)
> +#define gen_vpand_ymm(env, s, modrm) gen_gvec_ld_modrm_vymm((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0123)
> +#define gen_andps_xmm  gen_pand_xmm
> +#define gen_vandps_xmm gen_vpand_xmm
> +#define gen_vandps_ymm gen_vpand_ymm
> +#define gen_andpd_xmm  gen_pand_xmm
> +#define gen_vandpd_xmm gen_vpand_xmm
> +#define gen_vandpd_ymm gen_vpand_ymm


Why all of these extra defines?

> +    enum {
> +        M_0F    = 0x01 << 8,
> +        M_0F38  = 0x02 << 8,
> +        M_0F3A  = 0x04 << 8,
> +        P_66    = 0x08 << 8,
> +        P_F3    = 0x10 << 8,
> +        P_F2    = 0x20 << 8,
> +        VEX_128 = 0x40 << 8,
> +        VEX_256 = 0x80 << 8,
> +    };
> +
> +    switch(b | M_0F
> +           | (s->prefix & PREFIX_DATA ? P_66 : 0)
> +           | (s->prefix & PREFIX_REPZ ? P_F3 : 0)
> +           | (s->prefix & PREFIX_REPNZ ? P_F2 : 0)
> +           | (s->prefix & PREFIX_VEX ? (s->vex_l ? VEX_256 : VEX_128) : 0)) {

I think you can move this above almost everything in this function, so that all
of the legacy bits follow this switch.

> +    case 0xdb | M_0F:                  gen_pand_mm(env, s, modrm); return;

You'll want to put these on the next lines -- checkpatch.pl again.

> +    case 0xdb | M_0F | P_66:           gen_pand_xmm(env, s, modrm); return;
> +    case 0xdb | M_0F | P_66 | VEX_128: gen_vpand_xmm(env, s, modrm); return;
> +    case 0xdb | M_0F | P_66 | VEX_256: gen_vpand_ymm(env, s, modrm); return;
> +    case 0x54 | M_0F:                  gen_andps_xmm(env, s, modrm); return;
> +    case 0x54 | M_0F | VEX_128:        gen_vandps_xmm(env, s, modrm); return;
> +    case 0x54 | M_0F | VEX_256:        gen_vandps_ymm(env, s, modrm); return;
> +    case 0x54 | M_0F | P_66:           gen_andpd_xmm(env, s, modrm); return;
> +    case 0x54 | M_0F | P_66 | VEX_128: gen_vandpd_xmm(env, s, modrm); return;
> +    case 0x54 | M_0F | P_66 | VEX_256: gen_vandpd_ymm(env, s, modrm); return;
> +    default: break;
> +    }

Perhaps group cases together?

    case 0xdb | M_0F | P_66:  /* PAND */
    case 0x54 | M_0F:         /* ANDPS */
    case 0x54 | M_0F | P_66:  /* ANDPD */
       gen_gvec_ld_modrm_xmm(env, s, modrm, MO_64, tcg_gen_gvec_and, 0112);
       return;

How are you planning to handle CPUID checks?  I know the currently handling is
quite spotty, but with a reorg we might as well fix that too.


r~

