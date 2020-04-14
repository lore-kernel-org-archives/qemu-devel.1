Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18576C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8F520767
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlGtoP8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8F520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOP6Y-0006i9-2g
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jOOzY-0003ye-3I
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jOOzW-0005L3-Vr
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:04:56 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jOMql-00047Q-UE
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 10:47:44 -0400
Received: by mail-pf1-x443.google.com with SMTP id m21so1026pff.13
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6zBODJds4+fSTJpYuEtmzFzjzEaKbjVXEFHVqO+Gaqo=;
 b=HlGtoP8hEKRc1QZED6Q1w6frytsbMTjixH+IopFibt8RgaC1filGd/sKRKAJcZEq1D
 QKmGMitNsZdKOVQuh6pbp6bwGJsk2uRbMqj3+k6tNWR4orp06j91jH+lp8voFltpFZ6e
 6WAQc86PX+L9bqBq9ZZ/DNSP/lQXwvrwPnvNv9/gfca4YDpkVQwLH77HV4GI/J4irgcX
 IhMd9F8CNwwSvimZtUaqq5s7pUOkTeYnsZuD477WAViKyTHWOB3Gl7nOxE83GvbutVqq
 fXVU5AVIq4edWDIYjY0BNmWzEZ5MozOU478ERX23ecAmyAkknPkxpOlcf3cfauMmiGRp
 Q/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6zBODJds4+fSTJpYuEtmzFzjzEaKbjVXEFHVqO+Gaqo=;
 b=P6bKnszgJPirQFYWMPqh+xX9CAHo1wP9F8B5xoA+uW1p5D7Qnx4h2biqBRZ1rWqHlZ
 7B3RYWW6sPIeUBRC7qIsN5G59JYWLb4b5BVzTIAA1YXUpn/rx0dtE3L+44Txq5SRVy4z
 coomm8zdZd7dOwkgos1RghRhpOkoBvJ54draQphUY1LneJ53fOZ4/12yyb2/RGfiqD4f
 zwkwS1x/a1Lrg8gSeU3Qc/fWiRRXcJFobfGmnrtoO+ablIQPH3RgG0DjKX6eJGuhr9r4
 osj7GjdsR76+9Q2ptAKde55ZREi3qQJeaUZxWRMbG+XMfTh9MN8td112fDHSx82nymup
 PZvQ==
X-Gm-Message-State: AGi0PuZk+p73hsudmeho1EheZLFhec4/Lh4+LdYsO93z7k8MCeVolhu7
 gx0vQJwLX/7v/UbOCjp1U3Yt+w==
X-Google-Smtp-Source: APiQypJQ4YR2BY2wYRkv2TRiwBc3oA8Ql7QWV/mqQj3xWZApBb8yBWwJPOHPqx3yKuEp0gmsseT/EA==
X-Received: by 2002:a62:e414:: with SMTP id r20mr22767777pfh.96.1586875662596; 
 Tue, 14 Apr 2020 07:47:42 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id r28sm5007678pfg.186.2020.04.14.07.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 07:47:41 -0700 (PDT)
Subject: Re: [PATCH RFC] target/arm: Implement SVE2 MATCH, NMATCH
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200413234224.12005-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <895cd38f-f957-5328-6b61-c6f2b0d02788@linaro.org>
Date: Tue, 14 Apr 2020 07:47:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200413234224.12005-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: apazos@quicinc.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/13/20 4:42 PM, Stephen Long wrote:
> +#define DO_ZPZZ_CHAR_MATCH(NAME, TYPE, H, EQUALS)                            \
> +void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)     \
> +{                                                                            \
> +    intptr_t i, opr_sz = simd_oprsz(desc);                                   \
> +    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {                             \
> +        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                      \
> +        uint16_t *pd = (uint16_t *)(vd + H1_2(i >> 3));                      \
> +        *pd = (*pd & ~1) | ((0 & EQUALS) | (1 & !EQUALS));                   \
> +        if (pg & 1) {                                                        \

The important error here is that the predicate is not always the low bit.  When
operating on bytes, every bit of the predicate is significant.  When operating
on halfwords, every even bit of the predicate is significant.  In addition,
when operating on halfwords, every odd bit of the result predicate must be zero.

Which is why, generally, I have constructed the output predicate as we go.
See, for instance, DO_CMP_PPZZ.

> +            TYPE nn = *(TYPE *)(vn + H(i));                                  \
> +            for (intptr_t j = 0; j < 16; j += sizeof(TYPE)) {                \
> +                TYPE mm = *(TYPE *)(vm + H(i * 16 + j));                     \

mm needs to start at the beginning of the segment, which in this case is (i &
-16).  You don't need the elements of mm in any particular order (all of them
are significant), so you can drop the use of H() here.

Therefore the indexing for mm should be vm + (i & -16) + j.

> +                bool eq = nn == mm;                                          \
> +                if ((eq && EQUALS) || (!eq && !EQUALS)) {                    \
> +                    *pd = (*pd & ~1) | ((1 & EQUALS) | (0 & !EQUALS));       \
> +                }                                                            \

It might be handy to split out the inner loop to a helper function, as, while
the basic loop is ok, there are tricks that can improve it, so that we're
comparing 8 bytes at a time.


> +static bool do_sve2_zpzz_char_match(DisasContext *s, arg_rprr_esz *a,
> +                                    gen_helper_gvec_4 *fn)
> +{
> +    if (!dc_isar_feature(aa64_sve2, s)) {
> +        return false;
> +    }
> +    if (fn == NULL) {
> +        return false;
> +    }
> +    if (sve_access_check(s)) {
> +        unsigned vsz = vec_full_reg_size(s);
> +        unsigned psz = pred_full_reg_size(s);
> +        int dofs = pred_full_reg_offset(s, a->rd);
> +        int nofs = vec_full_reg_offset(s, a->rn);
> +        int mofs = vec_full_reg_offset(s, a->rm);
> +        int gofs = pred_full_reg_offset(s, a->pg);
> +
> +        /* Save a copy if the destination overwrites the guarding predicate */
> +        int tofs = gofs;
> +        if (a->rd == a->pg) {
> +            tofs = offsetof(CPUARMState, vfp.preg_tmp);
> +            tcg_gen_gvec_mov(0, tofs, gofs, psz, psz);
> +        }
> +
> +        tcg_gen_gvec_4_ool(dofs, nofs, mofs, gofs, vsz, vsz, 0, fn);
> +        do_predtest(s, dofs, tofs, psz / 8);

You can avoid the copy and the predtest by using the iter_predtest_* functions
and returning the flags result directly from the helper.  Again, see DO_CMP_PPZZ.


r~

