Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1293FC47420
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDBA20848
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ztsVsP5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDBA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1MO-0000PX-5E
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO1CZ-0004ZI-4M
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:13:03 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:39181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO1CX-0000mk-7j
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:13:02 -0400
Received: by mail-oo1-xc44.google.com with SMTP id c4so1616812oou.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IHOjYe7oDzCnj805svwsbcofM2wKXLlVaNOsxvItj6o=;
 b=ztsVsP5K6YhYhT2HdNs6Nb1RZS9ctsG3I0MqvYPax2RF4+VPKMd1pI3rTz0OmX9X9h
 ruEhCeUSAQDkkiaQiFo3aIB/zbsPmGC41QzT8n40RORw2GRGeo6/k1v4R9oluH1w0aCr
 TsH3YoOP9VxsHeB+TGqF1CTeyHa1qyz9ZYOYOQJQFhfPoGxbnyvSK3TdE+Ifr9GdlyRX
 CZXN2xR6ApRSKTa/UNCfrix513+85DeRhbOiZ03XVfx3tMC9pRO3Xq09VRK4P0d7ERxH
 ariZ4lUh+BG/FAESmtsKbnnUfwobW+n1gpJMQ6sMyWXKFSbaGDfua0aCz7uhCKclQkMC
 hXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IHOjYe7oDzCnj805svwsbcofM2wKXLlVaNOsxvItj6o=;
 b=Os1sq8hirA7dJZ6x5EOt7lfzr8064zngouy9pbWJwKCtsEd/9c1C3MUplTvlrh6ZzW
 hBr+7OEgwuEGL1GmYyou740C755+HUlgPZ+okbcDBVSaj9sfXt8IllvS2azHux9FrBtO
 2VPKijUfOPUJ3r3uBN9A3Kogv1KjRVlMyixkN07IQVKoc+h5kCE9/hPd0hU9Gt5tFowd
 c+eBH8rvajZ8fCD+WGJjrxC5BBx5nldjSxQQEKv2uU4PVfsN+xMDB6KA6Wu0MW3MTZwm
 i6usHXfUPsgaz/bWUfgrR4xRUhvIWK42d6frEsQ56YA1hmIN9W0l1zsy1wYK6d1b0PF7
 4rfQ==
X-Gm-Message-State: AOAM532IMlDt+3KmKWMb2uUGXv/ggweslxuw6VQN8VEdPaO+JZHuzYob
 xdeQlVjrBvk9JWldBBQLAkxabZuPIjLAqtb7
X-Google-Smtp-Source: ABdhPJyZLTApMzQ3om4i3+lpMl7g9RAG6y1PBvu/SAizGbAKQ0o+LB3cHgz3QNhUAW3Db7pfi0QnCA==
X-Received: by 2002:a4a:91db:: with SMTP id e27mr6203596ooh.59.1601568779980; 
 Thu, 01 Oct 2020 09:12:59 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id r33sm1378175ooi.48.2020.10.01.09.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 09:12:58 -0700 (PDT)
Subject: Re: [PATCH v1 09/20] s390x/tcg: Implement 32/128 bit for VECTOR FP
 COMPARE *
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200930145523.71087-1-david@redhat.com>
 <20200930145523.71087-10-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e91bc9ef-0031-1d85-b518-a00026fa4672@linaro.org>
Date: Thu, 1 Oct 2020 11:12:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930145523.71087-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 9:55 AM, David Hildenbrand wrote:
> -void HELPER(gvec_vfce64)(void *v1, const void *v2, const void *v3,
> -                         CPUS390XState *env, uint32_t desc)
> -{
> -    vfc64(v1, v2, v3, env, false, float64_eq_quiet, GETPC());
> +#define DEF_GVEC_VFCE(BITS)                                                    \
> +void HELPER(gvec_vfce##BITS)(void *v1, const void *v2, const void *v3,         \
> +                             CPUS390XState *env, uint32_t desc)                \
> +{                                                                              \
> +    const bool sq = simd_data(desc);                                           \
> +                                                                               \
> +    vfc##BITS(v1, v2, v3, env, false,                                          \
> +              sq ? float##BITS##_eq : float##BITS##_eq_quiet, GETPC());        \
>  }
> +DEF_GVEC_VFCE(32)
> +DEF_GVEC_VFCE(64)
> +DEF_GVEC_VFCE(128)
>  
> -void HELPER(gvec_vfce64s)(void *v1, const void *v2, const void *v3,
> -                          CPUS390XState *env, uint32_t desc)
> -{
> -    vfc64(v1, v2, v3, env, true, float64_eq_quiet, GETPC());
> +#define DEF_GVEC_VFCE_S(BITS)                                                  \
> +void HELPER(gvec_vfce##BITS##s)(void *v1, const void *v2, const void *v3,      \
> +                                CPUS390XState *env, uint32_t desc)             \
> +{                                                                              \
> +    const bool sq = simd_data(desc);                                           \
> +                                                                               \
> +    vfc##BITS(v1, v2, v3, env, true,                                           \
> +              sq ? float##BITS##_eq : float##BITS##_eq_quiet, GETPC());        \
>  }
> +DEF_GVEC_VFCE_S(32)
> +DEF_GVEC_VFCE_S(64)
>  
> -void HELPER(gvec_vfce64_cc)(void *v1, const void *v2, const void *v3,
> -                            CPUS390XState *env, uint32_t desc)
> -{
> -    env->cc_op = vfc64(v1, v2, v3, env, false, float64_eq_quiet, GETPC());
> +#define DEF_GVEC_VFCE_CC(BITS)                                                 \
> +void HELPER(gvec_vfce##BITS##_cc)(void *v1, const void *v2, const void *v3,    \
> +                                  CPUS390XState *env, uint32_t desc)           \
> +{                                                                              \
> +    const bool sq = simd_data(desc);                                           \
> +                                                                               \
> +    env->cc_op = vfc##BITS(v1, v2, v3, env, false,                             \
> +                           sq ? float##BITS##_eq : float##BITS##_eq_quiet,     \
> +                           GETPC());                                           \
>  }
> +DEF_GVEC_VFCE_CC(32)
> +DEF_GVEC_VFCE_CC(64)
> +DEF_GVEC_VFCE_CC(128)
>  
> -void HELPER(gvec_vfce64s_cc)(void *v1, const void *v2, const void *v3,
> -                            CPUS390XState *env, uint32_t desc)
> -{
> -    env->cc_op = vfc64(v1, v2, v3, env, true, float64_eq_quiet, GETPC());
> +#define DEF_GVEC_VFCE_S_CC(BITS)                                               \
> +void HELPER(gvec_vfce##BITS##s_cc)(void *v1, const void *v2, const void *v3,   \
> +                                   CPUS390XState *env, uint32_t desc)          \
> +{                                                                              \
> +    const bool sq = simd_data(desc);                                           \
> +                                                                               \
> +    env->cc_op = vfc##BITS(v1, v2, v3, env, true,                              \
> +                           sq ? float##BITS##_eq : float##BITS##_eq_quiet,     \
> +                           GETPC());                                           \
>  }
> +DEF_GVEC_VFCE_S_CC(32)
> +DEF_GVEC_VFCE_S_CC(64)

These macros are at the wrong level.  You shouldn't need separate macros for EQ
vs LT, etc.


r~

