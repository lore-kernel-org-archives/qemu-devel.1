Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F0BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70AE720884
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdKSbcPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AE720884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlt2o-0002yt-Mn
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 07:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlt1w-0002Ll-Kf
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:48:28 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlt1v-0004dx-1g
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:48:28 -0400
Received: by mail-ot1-x342.google.com with SMTP id u23so4259408otq.10
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D22VcfyRjlQuALjFU0ECZnILjd/N66CzW7Qs8JAQl+I=;
 b=bdKSbcPujoI86voW0veg6fvB6cwyUYUn1icJB4A/TEa9GlUrWJ6/tG/fZIrj+or0Xh
 v9VGalXTiXrpH/v3SZ5MdnRei/MXxpRPapvzIHF79q3Z+kTeI52sUMtxqYY4uBKfqBTJ
 bF+9tHs4nzu02UFMDzfLSTTYqpHfUwW0U5ynt0Uoedv4jwtdrCcZA55Z6V9m38jm8DVo
 7gtzgO2hiOPhst5DXlK1b3giKqp+DxlOJ4XYAyKk6QTEW+ADAvM8srfiu8Z6JBaMRZcg
 LjjLW8MkjXTTE0zWtqJEfXWzU+7XFsZBlPaJy6OZQUvgyFlmmbAxKeaR2NXV9jH91Dx1
 8OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D22VcfyRjlQuALjFU0ECZnILjd/N66CzW7Qs8JAQl+I=;
 b=XGfO1BzgfYog9t3JH8x/ZBAdZZIYG6YCYXRE9YbMHDGuskSrdiPxrlYuZ2j+uGsJgw
 gODmPdtbGZ84LOkVR+wet8pfFL37g81ZKb5oX3hSKwgXtjNcp4U6JJCpay512UK0vpSl
 WxzBe6meqYeSD2IAKBm7aRUrED4VyanBozrn6WYtO3xoJqF587xNKWmQQYWBFYKbi0Vg
 Rtn2Bew6by+IM/pEgSdf8VN49OpO24p8WlGob10Xv6potfZckP7IMXrE21AlZGhRIt/N
 8UOoHYg4IZMG85vPlW3dqkESztfUWzq7Dxx3UrWsIVS59PiY+mcRc2Bto4bLPuLOMUiX
 cR7w==
X-Gm-Message-State: AOAM530oCR+VxvWjyKg7mKLATBwbp4tJWCngxPdYr2pE6fFBJpSdVxeH
 0R2YVO5dqCFcC8Wk7o2gKyG/QI/cEtZ8/+GOitiXQA==
X-Google-Smtp-Source: ABdhPJzhWm+BIvMXj3WN+D/womX5V2+YmxlLLVsmdGfXzLAN51pEP3+o11sgJrMBRnVpfk0bLpTTVTRFKHFS6pHWt1Q=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr3120733ote.135.1592480905704; 
 Thu, 18 Jun 2020 04:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-10-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 12:48:15 +0100
Message-ID: <CAFEAcA9pgcfCrTXX6_9_ULhdiBDXhwdZw0Mv3prCcf_Po6H=wA@mail.gmail.com>
Subject: Re: [PATCH v7 09/42] target/arm: Implement the IRG instruction
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Update to 00eac5.
>     Merge choose_random_nonexcluded_tag into helper_irg since
>     that pseudo function no longer exists separately.
> v6: Remove obsolete logical/physical tag distinction;
>     implement inline for !ATA.
> ---

> +static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
> +{
> +    if (exclude == 0xffff) {
> +        return 0;
> +    }
> +    if (offset == 0) {
> +        while (exclude & (1 << tag)) {
> +            tag = (tag + 1) & 15;
> +        }
> +    } else {
> +        do {
> +            do {
> +                tag = (tag + 1) & 15;
> +            } while (exclude & (1 << tag));
> +        } while (--offset > 0);
> +    }

Not the way the pseudocode is phrased, but the effect seems to
be the same.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

