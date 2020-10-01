Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29BAC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F41A20872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cO6n5khr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F41A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0yh-0005Vk-DP
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO0ld-0007SI-MH
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:45:15 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:47007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO0lb-0004ZX-MK
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:45:13 -0400
Received: by mail-ot1-x342.google.com with SMTP id a13so3075632otl.13
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SAx4gnhtdHruOhWaRLw9QvsHsofhvpQMskdiZBpshkk=;
 b=cO6n5khrUYR6utXhHKtrbdCabb1XzKu+EWxLF8SXEOHiqz2iD8EFJleoLTSc9/CbeP
 UXupQl98+OcTvrznecDsdLEtbh8VrXwiKVNrUnP5PDdSZ0CL0ci8DVXAGBD3ttYk2zUu
 basVG/IbQlAeFzcA3G+/8sJLOS1awoyQBAquw5T5Q7YFnhVT+LlmIgXwH/nBf2McbGQv
 uZ5hbvjfA+yMGvnYH1rlkAqpT6n/FW0zgbq40/gzBz/0A1OR+rNSwrUD1kXd9YH16Q1+
 r2xZu9Cs7UTTP7oDNdRJD+0EqqZ46d54zAJGJlHohr7g2PPMbJ1zXr3qbcIkL5iKhcpE
 XEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SAx4gnhtdHruOhWaRLw9QvsHsofhvpQMskdiZBpshkk=;
 b=ppHPFGuiTnIC5WrN35MgcsWny1CjeDo107Cv7UZ05fil7WGmZCXtGh6qToiuTusbjA
 PQ2SwYMzIs9uNgZvrLNS6g6hwnUmXx7ZUdLjZf0/qTzRUr/oTiqTx+xcl1E/oBJkbYtf
 YptcTevPGh0tobBnZAHIlHZglbH9sVZ2G+yGI45OFZgIJrSrY7rjshR3QO01IWQjHDh7
 3TrQJqAvpCdelSUqrAFQzI4FSu8jpSnVhPKTs1vwUACVmFBhLEDO9AD/VaZcFawFP/Re
 +s01RTfeTqfYJEZ/E0P/V1fjQb919ulZG7BregMSHXeZlrGu41UeclgiutpNdag0gTSc
 yeUg==
X-Gm-Message-State: AOAM533NneTTpOCviOCJ2hHgroCa30OFV0kBng/xDcOc2TWKoeKugvc9
 iBln9SEFlf02SVeRHN5oM1LDwQ==
X-Google-Smtp-Source: ABdhPJz4nfPUAh28uZWhzPAS0sOQDHroJeGdceP2lELr6+QRo0bjwpiIprfn+SQ6rdxY8dqQk9tIPw==
X-Received: by 2002:a05:6830:1bf9:: with SMTP id
 k25mr5382059otb.310.1601567110235; 
 Thu, 01 Oct 2020 08:45:10 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id 187sm1113366oie.42.2020.10.01.08.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 08:45:09 -0700 (PDT)
Subject: Re: [PATCH v1 04/20] s390x/tcg: Implement 32/128 bit for VECTOR FP ADD
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200930145523.71087-1-david@redhat.com>
 <20200930145523.71087-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eda4575a-574b-1aa9-c51b-cb205786130c@linaro.org>
Date: Thu, 1 Oct 2020 10:45:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930145523.71087-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x342.google.com
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
> -typedef uint64_t (*vop64_3_fn)(uint64_t a, uint64_t b, float_status *s);
> -static void vop64_3(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
> -                    CPUS390XState *env, bool s, vop64_3_fn fn,
> -                    uintptr_t retaddr)
> -{
> -    uint8_t vxc, vec_exc = 0;
> -    S390Vector tmp = {};
> -    int i;
> -
> -    for (i = 0; i < 2; i++) {
> -        const uint64_t a = s390_vec_read_element64(v2, i);
> -        const uint64_t b = s390_vec_read_element64(v3, i);
> -
> -        s390_vec_write_element64(&tmp, i, fn(a, b, &env->fpu_status));
> -        vxc = check_ieee_exc(env, i, false, &vec_exc);
> -        if (s || vxc) {
> -            break;
> -        }
> -    }
> -    handle_ieee_exc(env, vxc, vec_exc, retaddr);
> -    *v1 = tmp;
> -}
...
> +#define DEF_VOP_3(BITS)                                                        \
> +typedef float##BITS (*vop##BITS##_3_fn)(float##BITS a, float##BITS b,          \
> +                                        float_status *s);                      \
> +static void vop##BITS##_3(S390Vector *v1, const S390Vector *v2,                \
> +                          const S390Vector *v3, CPUS390XState *env, bool s,    \
> +                          vop##BITS##_3_fn fn, uintptr_t retaddr)              \
> +{                                                                              \
> +    uint8_t vxc, vec_exc = 0;                                                  \
> +    S390Vector tmp = {};                                                       \
> +    int i;                                                                     \
> +                                                                               \
> +    for (i = 0; i < (128 / BITS); i++) {                                       \
> +        const float##BITS a = s390_vec_read_float##BITS(v2, i);                \
> +        const float##BITS b = s390_vec_read_float##BITS(v3, i);                \
> +                                                                               \
> +        s390_vec_write_float##BITS(&tmp, i, fn(a, b, &env->fpu_status));       \
> +        vxc = check_ieee_exc(env, i, false, &vec_exc);                         \
> +        if (s || vxc) {                                                        \
> +            break;                                                             \
> +        }                                                                      \
> +    }                                                                          \
> +    handle_ieee_exc(env, vxc, vec_exc, retaddr);                               \
> +    *v1 = tmp;                                                                 \
> +}
> +DEF_VOP_3(32)
> +DEF_VOP_3(64)
> +DEF_VOP_3(128)

While this works, you won't be able to step through this function in the
debugger anymore, because it now has one source line: at the point of expansion.

We do have plenty of these around the code base, I know.  This is small enough
that I think it's reasonable to simply have three copies, one for each type.

> +#define DEF_GVEC_FVA(BITS)                                                     \
> +void HELPER(gvec_vfa##BITS)(void *v1, const void *v2, const void *v3,          \
> +                            CPUS390XState *env, uint32_t desc)                 \
> +{                                                                              \
> +    vop##BITS##_3(v1, v2, v3, env, false, float##BITS##_add, GETPC());         \
> +}
> +DEF_GVEC_FVA(32)
> +DEF_GVEC_FVA(64)
> +DEF_GVEC_FVA(128)
> +
> +#define DEF_GVEC_FVA_S(BITS)                                                   \
> +void HELPER(gvec_vfa##BITS##s)(void *v1, const void *v2, const void *v3,       \
> +                               CPUS390XState *env, uint32_t desc)              \
> +{                                                                              \
> +    vop##BITS##_3(v1, v2, v3, env, true, float##BITS##_add, GETPC());          \
> +}
> +DEF_GVEC_FVA_S(32)
> +DEF_GVEC_FVA_S(64)
I think you're defining these macros with the wrong parameters.  Think of how
to use the same macros for all of add/sub/etc.

E.g.

#define DEF_FOP3_B(NAME, OP, BITS) \...
  void HELPER(gvec_##NAME##BITS)(void *v1, const void *v2,
      const void *v3, CPUS390XState *env, uint32_t desc)
  {
    vop##BITS##_3(v1, v2, v3, env, false,
                  float##BITS##_##OP, GETPC());
  }
  void HELPER(gvec_##NAME##BITS##s)(void *v1, const void *v2,
      const void *v3, CPUS390XState *env, uint32_t desc)
  {
    vop##BITS##_3(v1, v2, v3, env, true,
                  float##BITS##_##OP, GETPC());
  }

#define DEF_FOP3(NAME, OP) \
  DEF_FOP3_B(NAME, OP, 32) \
  DEF_FOP3_B(NAME, OP, 64) \
  DEF_FOP3_B(NAME, OP, 128)

DEF_FOP3(vfa, add)
DEF_FOP3(vfd, div)
DEF_FOP3(vfm, mul)

etc.


r~

