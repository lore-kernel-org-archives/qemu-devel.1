Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB86C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0909B2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbN5jS+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0909B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtxBe-0003j1-6k
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 13:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtxB4-0003HU-5P
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:51:14 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d]:50495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtxB2-00018B-M9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:51:13 -0400
Received: by mail-pj1-x102d.google.com with SMTP id k71so2930429pje.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=avoF3qspIGHMxjGxvwi7YRJvZdniZ+4Dd1+ivub60iA=;
 b=nbN5jS+lTu337pJoHX2dGDwkV78iU/btb0VR8nrGOxJ0/mnlD3sS6ij/8EjqFuFF1I
 IJk7IkLYzdT2c1Jt9zsXj+bId7XK+2EmlC2XpB3MQ863aSaB2vavJFp3PuIjozlTvHrL
 zDf0c7QlUdjNlHAnacc8x5ra67jUhs9TUfdbfgdSDdnS3YQMaB1flAAmI+EOwm5sgohv
 G/Pw6V9UqX/ySdHjf/mxBeHNNtIVBrdrhY+V4CM+122FSjae2geIT8fD45n5563CX6jE
 VZgXcDq15Rc6FRE9eM3PdCeTpnv0FLVORDTeIp7An74PhQX9JiLWjhIXfV3PohFHTPRb
 X4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=avoF3qspIGHMxjGxvwi7YRJvZdniZ+4Dd1+ivub60iA=;
 b=ZMjJrVyu0LiWGXvwQu9SIJcPtRcPp2Pjc9TkAEyudUr05mfSEHlS8rWds0QoBmTaed
 e7J3KSCVLpCr8VtlRt4LmowRD91CQlGIIySA0VlSv6wtmwiuuW5qkOJTkFIKb4igs0AP
 5cb0ZiaXnmPjYGjZyk+RYMp7pIKIX3cqORJKeLxIszJ7aKwOUPchhLKdFbNN6AgWxo1y
 QpFx5HeufwGWlCNMSyMQ3xONlWO8Vq3OP0kY5Zer82J2cB7uyBdh219twJ9sBVSls585
 +rsGiqOCYgMR9W7T1sA16ji+AuaPkMMB7pjM4L2iPb0lbbyQrhitmiBfGgKDukInQIe7
 5I6w==
X-Gm-Message-State: AOAM5330Y+1YF85L9aDqcx9y9CO8MdIoR/byaqVi988TIgMtzkvEAbKC
 EL45GHcwLDm//kku0AaqBJ4i3A==
X-Google-Smtp-Source: ABdhPJyEBQjzs5f8x9Rlt7AFj6JiR0v3u6GSNK4++N0Jp9TKE6KGaZc8lviaiTswaLtbcOHjo9xAAA==
X-Received: by 2002:a17:90a:ff16:: with SMTP id
 ce22mr7220765pjb.160.1594403471087; 
 Fri, 10 Jul 2020 10:51:11 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id ml8sm6051475pjb.47.2020.07.10.10.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 10:51:09 -0700 (PDT)
Subject: Re: [RFC 12/65] target/riscv: rvv-0.9: update check functions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-13-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ea39eb18-20fe-eecf-454c-6afc04d711f7@linaro.org>
Date: Fri, 10 Jul 2020 10:51:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710104920.13550-13-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
> +#define REQUIRE_RVV do {    \
> +    if (s->mstatus_vs == 0) \
> +        return false;       \
> +} while (0)

You've used this macro already back in patch 7.  I guess it should not have
been there?  Or this bit belongs there, one or the other.

I think this patch requires a description and justification.  I have no idea
why you are replacing

> -    return (vext_check_isa_ill(s) &&
> -            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
> -            vext_check_reg(s, a->rd, false) &&
> -            vext_check_reg(s, a->rs2, false) &&
> -            vext_check_reg(s, a->rs1, false));

with invisible returns

> +    REQUIRE_RVV;
> +    VEXT_CHECK_ISA_ILL(s);
> +    VEXT_CHECK_SSS(s, a->rd, a->rs1, a->rs2, a->vm, true);
> +    return true;


r~

