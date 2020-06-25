Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC66C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8261D20775
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbGS7xiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8261D20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joV2y-0002yk-PZ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joV1s-0002RV-Aq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:47:12 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joV1p-000135-Vu
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:47:12 -0400
Received: by mail-ot1-x344.google.com with SMTP id n6so5916079otl.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X/dmt1z3SR/RosjGKp389EiA+2Iau2aevOIL5Oyzxso=;
 b=AbGS7xiUjLul0kg7rnkxRgV9QON76PXNZDV2Rpm6jFoAygs3V5Va1FBUJ/BzMJpknp
 XIQwAQtwKoIubj/Y7yTN2e3upcY+2Jk4IjWQjRZ/KfKsdnXz/zF6txSNnMD0wtM/dhmR
 WDqI4q9rdJoEzaGu6scWJGvvFqvX2uJtOpe9ctoBA/Woq8de5oK73TjKxHjkC+yCH0bK
 puYIMO4QmBBIvqFnsh1d7qnasfPb+bI4Ny5S6Kqp1IFvYS3j1mkCD2NumxPYp6cptVER
 HpMlQYNh7v3avCrBCD7aQ0idvcQK3jvy+5y1MW9eNhC3y1l7bg3JLTFvaCP7nWMPd9Rh
 b+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X/dmt1z3SR/RosjGKp389EiA+2Iau2aevOIL5Oyzxso=;
 b=XRKCqhBDHgzP3lvvhM0Eh2iXyR7c0W4dtkpDKyaeqOVJC09Ewg17orbiyxVla+rhrO
 RBtcjlsN10O35pjjekly+wqgdoJxV2CnRQrnJf+W6XgwFYwLcI7Jz9AlkuptMXBXKSz3
 WJ0y2Tr7jM8T97YOMpwV6VzM8QvbouPg4zvGabYiqjVuOfrE8WPxtqw02zf1XWiIh/s5
 TJWcDS+hNYr1Z/M6/rchXVJv05LxaP7QqA6IiHVmKB+VHdMADDDzASl2XuFsBo8wk6Nz
 mBYDOawP/FAQFi1HFC7DST+dvs1Zn3fPZMApZnviJLD19AK8Z2x+smHgJf8TiZeHFDqu
 w2kA==
X-Gm-Message-State: AOAM5337n5aknGDORRc/Ue2fxSp/S2Mj5hvWDs3I+KIJrqbdxzWDhB0B
 neK4/EBHWJjp8FOnwRBO9mqBS0p/KlA8cAPDURjHUw==
X-Google-Smtp-Source: ABdhPJykkcFvGw3FWk4UPm8baGh4Rfc7lpaKDiRQ0KmYf3m72bIIIYIkGBHRNuPUNBppZb7DXhOdy0IyXwkU5axoqWw=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr13786378oth.135.1593103625773; 
 Thu, 25 Jun 2020 09:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-10-richard.henderson@linaro.org>
In-Reply-To: <20200605041733.415188-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 17:46:53 +0100
Message-ID: <CAFEAcA_Jd7Y1uEZsfCgKgicPjZOVe1LAAwOr4T5uRs7jjBSyPQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] linux-user/aarch64: Implement
 PR_TAGGED_ADDR_ENABLE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is the prctl bit that controls whether syscalls accept tagged
> addresses.  See Documentation/arm64/tagged-address-abi.rst in the
> linux kernel.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_syscall.h |  4 ++++
>  linux-user/syscall.c                | 23 +++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>

> +        case TARGET_PR_SET_TAGGED_ADDR_CTRL:
> +            {
> +                abi_ulong valid_mask = TARGET_PR_TAGGED_ADDR_ENABLE;
> +
> +                if ((arg2 & ~valid_mask) || arg3 || arg4 || arg5) {
> +                    return -TARGET_EINVAL;
> +                }
> +                untagged_addr_mask = (arg2 & TARGET_PR_TAGGED_ADDR_ENABLE
> +                                      ? MAKE_64BIT_MASK(0, 56) : -1);
> +                return 0;
> +            }

The spec says the tagged-address control is thread-scoped, not process-wide.

thanks
-- PMM

