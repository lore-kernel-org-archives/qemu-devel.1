Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46CAC2D0EF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 04:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790E62076A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 04:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNasLt21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790E62076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOwNC-0006bO-NT
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 00:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jOwMe-00065E-3t
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 00:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jOwMc-00053x-SQ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 00:42:59 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jOwMc-00051m-F1
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 00:42:58 -0400
Received: by mail-pl1-x641.google.com with SMTP id g2so920780plo.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 21:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jFVN1Wp427ZYbguIcMyVTf/NpzQB6iKlqCd1bbX5ME4=;
 b=BNasLt21KAenDohSuccIEC3baLcROeUsFB8N+K5aguK4GIR/wmqnfNTdWHFAHmkXd9
 s4Sn5zkDQ9JwSpGuU37fvdUslnqELX08WQHX+ynw1c0XjC/IwiccEwa/FcCmsGR7Bb1F
 4fAhaQjsU3+mATMdB4cvSCH02h4YhgfDbnvlKLZPLzichiiKv87l7pzFXA1itC5FAcpT
 zv758EfPCHS5h5lY+jUCtdYSAnhXx+xHfY/ipJtGyNH0D04f1Az01WoM4JhKmDtVnS5y
 gZ/nLPl/DjeL5tAMV1Q9qMCIISeVI6GC6nLXIgVV4KLrITcQQ6f9/0cweJ9fX68s+CwC
 e+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jFVN1Wp427ZYbguIcMyVTf/NpzQB6iKlqCd1bbX5ME4=;
 b=ZKoyNkq8UOo/9g6nNYlSE8OmLBDsuieNE+fyRfWGDGJlTCSAZqEyr4cD8bgpCP+kLD
 Tt0Y21OpWOqlxrGALmKonPTRjmL/ISTei/PzkqB23pLfas94ngTR9EJ1qYLU3o4xoBON
 4KbFcBKG77EgoVlzUsquOjAw4RsQo5Jj4MUuuXM3YnPsOijm6LGSUywEhX+YWNY5IESZ
 bFyH4qAwi9TDDmwimp0Ke0UGr6KGAzpRld5vOml/3oD1U6mdkT/uPdXatAMwfUp/c/Bu
 wW5PiHrcBd31itgXBE6xMU9GYaefZf2ESM0P9tFnY0+bjVt4srVfFGzGgZq9CxpAIdh9
 cDGA==
X-Gm-Message-State: AGi0Pub22yw5K+yHmAFWwYH1BU92kxu4bzIwXzYhYN9JzY6zJpu035iC
 Sk8laJpfdHti9LDQs0Y7ZfLuIQ==
X-Google-Smtp-Source: APiQypK/qLBZvFJFrflPGVBqnSsy0PbnzslruL+DLjxPK41HaZXvjDxAoMI+Md+DtQf1IhVjqj8TLw==
X-Received: by 2002:a17:902:820f:: with SMTP id
 x15mr8209449pln.180.1587012176584; 
 Wed, 15 Apr 2020 21:42:56 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a138sm1865417pfd.32.2020.04.15.21.42.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 21:42:55 -0700 (PDT)
Subject: Re: [PATCH RFC v2] target/arm: Implement SVE2 HISTCNT, HISTSEG
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200415190708.16914-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9390d7ed-b4ff-e284-0114-ba70ed16ff2c@linaro.org>
Date: Wed, 15 Apr 2020 21:42:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415190708.16914-1-steplong@quicinc.com>
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 12:07 PM, Stephen Long wrote:
> +++ b/target/arm/sve.decode
> @@ -147,6 +147,7 @@
>                  &rprrr_esz rn=%reg_movprfx
>  @rdn_pg_rm_ra   ........ esz:2 . ra:5  ... pg:3 rm:5 rd:5 \
>                  &rprrr_esz rn=%reg_movprfx
> +@rd5_pg_rn_rm   ........ esz:2 . rm:5 ... pg:3 rn:5 rd:5       &rprr_esz

To retain the pattern this should drop the 5; there's no existing rd_pg_rn_rm
with which to conflict.


> +++ b/target/arm/sve_helper.c
> @@ -7016,3 +7016,68 @@ DO_PPZZ_MATCH(sve2_nmatch_ppzz_b, MO_8, true)
>  DO_PPZZ_MATCH(sve2_nmatch_ppzz_h, MO_16, true)
>  
>  #undef DO_PPZZ_MATCH
> +
> +#define DO_HISTCNT(NAME, TYPE, H)                                            \
> +void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)     \
> +{                                                                            \
> +    intptr_t i, j;                                                           \
> +    intptr_t opr_sz = simd_oprsz(desc) / 8;                                  \

Divide by sizeof(TYPE).

> +    TYPE *d = vd, *n = vn, *m = vm;                                          \
> +    uint8_t *pg = vg;                                                        \
> +    for (i = 0; i < opr_sz; ++i) {                                           \
> +        TYPE count = 0;                                                      \
> +        uint8_t pred = pg[H1(i)] >> ((i & 1) * 4);                           \

The indexing isn't correct.

You've got a mix of uint32_t and uint64_t here.
Indeed, it's probably simpler to not try to do both functions with a macro, but
just split them.

For uint64_t,

    uint8_t pred = pg[H1(i)];

for uint32_t,

    uint8_t pred = pg[H1(i >> 1)] >> ((i & 1) * 4);

or when i is in units of bytes instead of elements,

    uint8_t pred = pg[H1(i >> 3)] >> (i & 7);

> +        if (pred & 1) {                                                      \
> +            TYPE nn = n[H(i)];                                               \
> +            for (j = 0; j <= i; ++j) {                                       \
> +                uint8_t pred = pg[H1(j)] >> ((j & 1) * 4);                   \
> +                if (pred & 1 && nn == m[H(j)]) {                             \
> +                    ++count;                                                 \
> +                }                                                            \
> +            }                                                                \
> +        }                                                                    \
> +        d[H(i)] = count;                                                     \
> +    }                                                                        \
> +}
> +
> +DO_HISTCNT(sve2_histcnt_s, uint32_t, H1_2)

H4 for uint32_t when indexing by elements or H1_4 when indexing by bytes.

> +DO_HISTCNT(sve2_histcnt_d, uint64_t,     )
> +
> +#undef DO_HISTCNT
> +
> +static inline uint8_t get_count(uint8_t n, uint64_t m)
> +{
> +    int i;
> +    uint8_t count = 0;
> +
> +    for (i = 0; i < 64; i += 8) {
> +        if (n == extract64(m, i, 8)) {
> +            ++count;
> +        }
> +    }
> +    return count;
> +}

This can use the same logic as do_match2, except that you use ctpop64 at the
end to count the bits instead of turning into a boolean.

> +
> +void HELPER(sve2_histseg)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    intptr_t i, j;
> +    intptr_t opr_sz = simd_oprsz(desc);
> +    uint64_t *m = vm;
> +
> +    for (i = 0; i < opr_sz; i += 8) {
> +        uint64_t n = *(uint64_t *)(vn + i);
> +        uint64_t out = 0;
> +
> +        for (j = 0; j < 64; j += 8) {
> +            uint64_t m0 = *m;
> +            uint64_t m1 = *(m + 1);

The m values need to be loaded from the segment, just like MATCH.

> +
> +            uint8_t count = get_count(n >> j, m0) + get_count(n >> j, m1);
> +            out |= count << j;
> +
> +            m += 2;
You're adding 2 uint64_t per input byte, which is going to run well past the
end of the input vector.

> +static bool trans_HISTCNT(DisasContext *s, arg_rprr_esz *a)
> +{
> +    if (a->esz > 1) {
> +        return false;
> +    }

ESZ must be 2 or 3, not 0 or 1.  Note near the top:

    if size == '0x' then UNDEFINED;

thus only size == '1x' is valid, and thus size<0> does in fact select 2 vs 3
for S and D.

Missing the sve2 check.

> +    static gen_helper_gvec_4 * const fns[2] = {
> +        gen_helper_sve2_histcnt_s, gen_helper_sve2_histcnt_d
> +    };
> +    return do_zpzz_ool(s, a, fns[a->esz]);
> +}


r~

