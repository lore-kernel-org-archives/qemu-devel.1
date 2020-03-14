Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA08C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 07:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331062074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 07:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="otjGv07f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331062074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD1L4-0006YW-DR
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 03:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD1KM-0005dn-8R
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD1KL-0003d6-4q
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:35:22 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD1KK-0003YN-UA
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:35:21 -0400
Received: by mail-pf1-x441.google.com with SMTP id b72so6663869pfb.11
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L6PnIl46SHmSjcpt8xU/K11ykKRTer8M9KJmMkyuEM8=;
 b=otjGv07fDRlrVn9szVvYefGYRvNIwws85KkZguxUJKQMvvf7+3vcGu04led6/YlPUA
 mRSaDnxBbZq6BYrJCDobdQmAxu8VEV2TMh7IUutKBvbORl19hAKSrcz1eL1SGNfX1FPI
 rpUHjXyHw1Rr0OOJN6dYRorXXIqJZslJO8OzDB2EUr0O58lk5obUXNB0LS1I5FDzbVx8
 wrSBy0CljRmz/z9i+60dkYBWkD/116yOXMXXuOGlxV7TXH0JMVTvDZj6xemfRrQ+FxHg
 TbyIFXrbVpKanrk2zWt0cc6jW37JbfWd/yriHV+MgawpOMG4xp97+lP2AS2W4nqlkZ1m
 ojOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L6PnIl46SHmSjcpt8xU/K11ykKRTer8M9KJmMkyuEM8=;
 b=ocaNaw/pVVjxq1JoIXbQrdJ1uhxu0eg4lXMPiDP0zEAqx+WQCB8jEnxsBJrFqqId10
 RBOYR26Ja63oF85evos94A5F2hUZbXyomyGLwDSQUe+7QNTIxBvEMlCKt9Jnvz0yyo80
 B2opu4rJVJe10MiQvRL4UNwbCbL4yUKY3twLtUxYYz8dcoZYPLJCZt2pA/jQMkwvugGw
 4s21BjZUIHJ43q/T3BQymEH+rh5ZJrDPVCUGoZDYmeZtgaQe/BzM527I631huaXQI2QA
 heY6txn849wz3ppwtbSN07hZePFuAxmgC9oPvp0m+l3aLORGcmce3dqxztzVPxl168PH
 hzmA==
X-Gm-Message-State: ANhLgQ0CacXAOMm9n/9Ny7VfMc8fwhbPPJQPp0+sC6S1xY35/LwhZ5c0
 a7IDtHxqJI2sn4hqut20XqRMUw==
X-Google-Smtp-Source: ADFU+vuKxTtEkv18LgiguhQ5qrCJM674cJA0jNL96BSm6f6hc0Wfco2oiYo3o8JW5lg6stqidtG3vA==
X-Received: by 2002:a62:194c:: with SMTP id 73mr17968393pfz.159.1584171319900; 
 Sat, 14 Mar 2020 00:35:19 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 p1sm20760144pfq.114.2020.03.14.00.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 00:35:19 -0700 (PDT)
Subject: Re: [PATCH v5 22/60] target/riscv: vector integer merge and move
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-23-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <daeefcff-c444-b289-abcf-74301b09cce9@linaro.org>
Date: Sat, 14 Mar 2020 00:27:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-23-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +/* Vector Integer Merge and Move Instructions */
> +static bool opivv_vmerge_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s, RVV) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
> +            vext_check_reg(s, a->rd, false) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            vext_check_reg(s, a->rs1, false) &&
> +            ((a->vm == 0) || (a->rs2 == 0)));
> +}
> +GEN_OPIVV_TRANS(vmerge_vvm, opivv_vmerge_check)
> +
> +static bool opivx_vmerge_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s, RVV) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
> +            vext_check_reg(s, a->rd, false) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            ((a->vm == 0) || (a->rs2 == 0)));
> +}
> +GEN_OPIVX_TRANS(vmerge_vxm, opivx_vmerge_check)
> +
> +GEN_OPIVI_TRANS(vmerge_vim, 0, vmerge_vxm, opivx_vmerge_check)

I think you need to special case these.  The unmasked instructions are the
canonical move instructions: vmv.v.*.

You definitely want to use tcg_gen_gvec_mov (vv), tcg_gen_gvec_dup_i{32,64}
(vx) and tcg_gen_gvec_dup{8,16,32,64}i (vi).

> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                   \
> +            ETYPE s2 = *((ETYPE *)vs2 + H(i));                       \
> +            *((ETYPE *)vd + H1(i)) = s2;                             \
> +        } else {                                                     \
> +            ETYPE s1 = *((ETYPE *)vs1 + H(i));                       \
> +            *((ETYPE *)vd + H(i)) = s1;                              \
> +        }                                                            \

Perhaps better as

ETYPE *vt = (!vm && !vext_elem_mask(v0, mlen, i) ? vs2 : vs1);
*((ETYPE *)vd + H(i)) = *((ETYPE *)vt + H(i));

> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                   \
> +            ETYPE s2 = *((ETYPE *)vs2 + H(i));                       \
> +            *((ETYPE *)vd + H1(i)) = s2;                             \
> +        } else {                                                     \
> +            *((ETYPE *)vd + H(i)) = (ETYPE)(target_long)s1;          \
> +        }                                                            \

Perhaps better as

ETYPE s2 = *((ETYPE *)vs2 + H(i));
ETYPE d = (!vm && !vext_elem_mask(v0, mlen, i)
           ? s2 : (ETYPE)(target_long)s1);
*((ETYPE *)vd + H(i)) = d;

as most host platforms have a conditional reg-reg move, but not a conditional load.


r~

