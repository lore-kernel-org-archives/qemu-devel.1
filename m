Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E16C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3001E2078A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HI3gUSAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3001E2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrkw-0003Mi-Gi
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jkrjP-0001nk-3Z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:13:07 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jkrjM-0003AM-1j
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:13:05 -0400
Received: by mail-pf1-x442.google.com with SMTP id z63so7087262pfb.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=0F61GR9Yb98dXuR5nFbrZYM4/fo1i+Zd1ehqQrfzwKA=;
 b=HI3gUSAndLqIejRQtzLzfcKJ++R8ruohWKu3wJ88cDqLgO4gdx8Pndx3T/GpSRxmi5
 sEXm/YL7BCyqFt//52AuVHp30kA8rHPUE7dL9C7acUrBUEgACpNrRFJ/KD0zQfafeVpR
 xg1/KQ2D4MiGCnRm0tenssWgWjtU7fQYqHb6d7yWVxK7lCvS26Ow3jls5n0AALG9IEJm
 LmfoLUuevZba0RNY+vGzmI0GinK6iZpd/zmN0NCkfmcOsA/iXDbAkBFKKprFb0xGXsnR
 hExRGVEc7BtHPBtlgzVwDEaQVCOmIrlNq//IP4pTaEFIoP8/So2xxlL4cKWGlj0khftp
 sVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0F61GR9Yb98dXuR5nFbrZYM4/fo1i+Zd1ehqQrfzwKA=;
 b=M0eV3Z+8idCuEf5hRcUDtrkNqnSF4c7r2QFybDcXFFEunvVWvqW2QjXmACi1xn+yQn
 Tg/pEkcMTAiRTIL0+2xdYvdZxLWjJT5XSN3GxzvKL4fQdcdG6Ke4oqrLkMz6mz+x5mNg
 T1xpf0dnSxIBaefDK+pPBN2TjRqEsknV3ig6MJT+1j+ppHoELxtw30gWO4jg9nN4rAW6
 V+OFTE+YjllcTYQ+mAKRTeNhElgQvKnuYADc4wMxSIqtChi3By7msdVVFbS3J9CSBFFI
 /8dTXzP+Hf7QMqDbgWlu5ZUO2CZjB8yE3zRfHCtWpGtSWQEQUzjVnHTOBFupmdbUpX7I
 b8Vg==
X-Gm-Message-State: AOAM532PG6wpfM9AchUZFxDpyjWrO6UV8ozn4+JrXAjpa6TYnSdVqqFc
 OAtOMP+jOfTEMDilS0bREcoqvDbohUo=
X-Google-Smtp-Source: ABdhPJwFr1KxiY4ZBBxGOunU3AUIk3yCKW/QCZooIeL6RnUcy+hUvY7P6x6U4yUoGKGqC1mtTtQKjw==
X-Received: by 2002:aa7:9d9a:: with SMTP id f26mr23143478pfq.229.1592237581829; 
 Mon, 15 Jun 2020 09:13:01 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id v7sm11668829pfn.147.2020.06.15.09.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 09:13:01 -0700 (PDT)
Subject: Re: [PATCH v2] target/ppc: add vmsumudm vmsumcud instructions
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200613035546.22041-1-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4f0e24af-5043-98d3-0f7b-e8d460bac617@linaro.org>
Date: Mon, 15 Jun 2020 09:12:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200613035546.22041-1-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/12/20 8:55 PM, Lijun Pan wrote:
> vmsumudm (Power ISA 3.0) - Vector Multiply-Sum Unsigned Doubleword Modulo
> VA-form.
> vmsumcud (Power ISA 3.1) - Vector Multiply-Sum & write Carry-out Unsigned
> Doubleword VA-form.
> 
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---
> v2: move vmsumcudm() to qemu/int128.h as Richard Henderson suggested,
>     also rename addu128() to uint128_add() and include it in qemu/int128.h
> 
>  disas/ppc.c                         |  2 +
>  include/qemu/int128.h               | 97 +++++++++++++++++++++++++++++
>  target/ppc/helper.h                 |  4 +-
>  target/ppc/int_helper.c             | 19 +++++-
>  target/ppc/translate.c              |  1 -
>  target/ppc/translate/vmx-impl.inc.c | 39 ++++++------
>  target/ppc/translate/vmx-ops.inc.c  |  2 +
>  7 files changed, 143 insertions(+), 21 deletions(-)
> 
> diff --git a/disas/ppc.c b/disas/ppc.c
> index 63e97cfe1d..3ed4d23ed3 100644
> --- a/disas/ppc.c
> +++ b/disas/ppc.c
> @@ -2261,7 +2261,9 @@ const struct powerpc_opcode powerpc_opcodes[] = {
>  { "vmsumshs",  VXA(4,  41), VXA_MASK,	PPCVEC,		{ VD, VA, VB, VC } },
>  { "vmsumubm",  VXA(4,  36), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
>  { "vmsumuhm",  VXA(4,  38), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
> +{ "vmsumudm",  VXA(4,  35), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
>  { "vmsumuhs",  VXA(4,  39), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
> +{ "vmsumcud",  VXA(4,  23), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
>  { "vmulesb",   VX(4,  776), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
>  { "vmulesh",   VX(4,  840), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
>  { "vmuleub",   VX(4,  520), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
> diff --git a/include/qemu/int128.h b/include/qemu/int128.h
> index 5c9890db8b..3362973cc5 100644
> --- a/include/qemu/int128.h
> +++ b/include/qemu/int128.h
> @@ -3,6 +3,7 @@
>  
>  #ifdef CONFIG_INT128
>  #include "qemu/bswap.h"
> +#include "qemu/host-utils.h"
>  
>  typedef __int128_t Int128;
>  
> @@ -143,6 +144,55 @@ static inline Int128 bswap128(Int128 a)
>      return int128_make128(bswap64(int128_gethi(a)), bswap64(int128_getlo(a)));
>  }
>  
> +/**
> + * uint128_add - add two 128-bit values (r=a+b, ca=carry-out)
> + * @ah: high 64 bits of a
> + * @al: low 64 bits of a
> + * @bh: high 64 bits of b
> + * @bl: low 64 bits of b
> + * @rh: high 64 bits of r to be returned
> + * @rl: low 64 bits of r to be returned
> + * @ca: carry out to be returned.
> + */
> +static inline void uint128_add(uint64_t ah, uint64_t al, uint64_t bh,
> +		uint64_t bl, uint64_t *rh, uint64_t *rl, uint64_t *ca)
> +{
> +	__uint128_t a = (__uint128_t)ah << 64 | (__uint128_t)al;
> +	__uint128_t b = (__uint128_t)bh << 64 | (__uint128_t)bl;
> +	__uint128_t r = a + b;
> +
> +	*rh = (uint64_t)(r >> 64);
> +	*rl = (uint64_t)r;
> +	*ca = (~a < b);
> +}

This is *not* what I had in mind at all.

int128.h should be operating on Int128, and *not* component uint64_t values.


> +
> +/**
> + * mulsum - (rh, rl) = ah*bh + al*bl + (ch, cl)
> + * @ah: high 64 bits of a
> + * @al: low 64 bits of a
> + * @bh: high 64 bits of b
> + * @bl: low 64 bits of b
> + * @ch: high 64 bits of c
> + * @cl: low 64 bits of c
> + * @rh: high 64 bits of r to be returned
> + * @rl: low 64 bits of r to be returned
> + * @ca: carry-out to be returned.
> + */
> +static inline void mulsum(uint64_t ah, uint64_t al, uint64_t bh,
> +		uint64_t bl, uint64_t ch, uint64_t cl, uint64_t *rh,
> +		uint64_t *rl, uint64_t *ca)
> +{
> +	__uint128_t prod1, prod2, r;
> +	__uint128_t c = (__uint128_t)ch << 64 | (__uint128_t)cl;
> +
> +	prod1 = (__uint128_t)ah * (__uint128_t)bh;
> +	prod2 = (__uint128_t)al * (__uint128_t)bl;
> +	r = prod1 + prod2 + c;
> +	*rh = (uint64_t)(r >> 64);
> +	*rl = (uint64_t)r;
> +	*ca = (~prod1 < prod2) + (~c < (prod1 + prod2));
> +}

Why is mulsum an interesting primitive for int128.h?
I would think int128_mul and int128_add sufficient here.

I did not ask you to place the entire ppc instruction in int128.h.


r~

