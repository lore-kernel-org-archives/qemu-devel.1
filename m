Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9BDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 12:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DEC2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 12:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1WFxhOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DEC2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAYHZ-0003Nk-6i
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 08:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAYGz-0002pg-PB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:41:57 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:46918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAYGx-0007b3-Ad
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:41:57 -0400
Received: by mail-ej1-x643.google.com with SMTP id d11so16115702ejt.13
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YKuOCtrYI1+bfbchmMVw4JJG2LSPRY5Rygktu8WTf/Q=;
 b=D1WFxhOZvERQDFkwbGWcW+r66aFMy6goaxvqUwx3Ha5PTZJh/bpc7ijVOvaMh5jtTq
 0FtkEVA6azE9Nl5zU+Fz/XdJhFHUM8jC9I0eHDbJ0sGJL5hZSE1lRtXqFfFydtoTw3r2
 aGjDI4wYs4ujagsnUkM73Pbmf2zYgwQjrbYuOWwXE94NsBuUpXzLp9UYr7Ib1MLEqUgQ
 tEDKy+Sfib6+L5msRubLhx/z7e9JasuZPRuze5BlHMpTByCIOKDFx4tNvkb5BdCt82og
 tyFvnpAYiYeHlRErQTmz21ElXhYN6JpkRtkelgWUYqjRImEoWWifGWYeoKjntsq5br60
 kMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YKuOCtrYI1+bfbchmMVw4JJG2LSPRY5Rygktu8WTf/Q=;
 b=byVw1g2IvrlnNmjJ+Ge98UHR/xRNPac4Y/9Gq8XnnRfuob9L10UJbgAKdVJi5v26yT
 jGB1fjGLVj7VqZbJXVCtHNRB8d+4gDBe3mW5S2+W4ASCnTq4j5hUnQrdgeOm27qlYTn9
 HOdt5ZWc0zUTbCBN0b2jgGh4LUpBSXNJHmhihV0z9MIWPqgMMCxsatK4J9HntV30RlEJ
 ieTQDnJDc6h8ts+CeJkVkhY3tuTXk+24Qwl1DxZQIYu1/2l91Xks7BEUn80Ik9tTTxGz
 D8/ssNLPZQz6S/IpQL8cUs1OIi9U35PxzLj0E6e0kDF83ipLg9WO8cJDzBAJFIjusvjy
 S+fA==
X-Gm-Message-State: AOAM5321JUF3CX4oP66TLvT8ZYWNAjwSdJcbHQZfL0b26VHFH5Tkjlyb
 nHKzaWa5dkzQX/wKNdzrZdI8ONsrBTkQAy06fmdo/Q==
X-Google-Smtp-Source: ABdhPJzP56krYpT7iNRRTMUIv9vSOKbIgN3ReReoeRT9cutjSD8sysGtpVqznvPXqlS4LCKPMrRuFeWwD18CZqBmR4I=
X-Received: by 2002:a17:906:2b0b:: with SMTP id
 a11mr720287ejg.250.1598359313839; 
 Tue, 25 Aug 2020 05:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-10-kuhn.chenqun@huawei.com>
In-Reply-To: <20200825112447.126308-10-kuhn.chenqun@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 13:41:42 +0100
Message-ID: <CAFEAcA_SLjM28bHH8WxBdHAFdLgE6zgqNAj9EpOVp77WL-iqKg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] hw/intc: Remove redundant statement in
 exynos4210_combiner_read()
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 12:26, Chen Qun <kuhn.chenqun@huawei.com> wrote:
>
> Clang static code analyzer show warning:
> hw/intc/exynos4210_combiner.c:231:9: warning: Value stored to 'val' is never read
>         val = s->reg_set[offset >> 2];
>
> The default value of 'val' is '0', so we can break the 'default' branch and return 'val'.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/exynos4210_combiner.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
> index b8561e4180..e2e745bbaa 100644
> --- a/hw/intc/exynos4210_combiner.c
> +++ b/hw/intc/exynos4210_combiner.c
> @@ -228,8 +228,7 @@ exynos4210_combiner_read(void *opaque, hwaddr offset, unsigned size)
>              hw_error("exynos4210.combiner: overflow of reg_set by 0x"
>                      TARGET_FMT_plx "offset\n", offset);
>          }
> -        val = s->reg_set[offset >> 2];
> -        return 0;
> +        break;
>      }
>      return val;
>  }

The code as it stands is definitely wrong, but I'm not sure
this is the correct fix. Surely the intention must have been
to return the actual register value from the reg_set[] array,
not to return 0 ?

I suspect the correct fix here is simply to delete the
"return 0" line and leave the assignment to val as it is.
Ideally you should check the h/w datasheet to confirm.

thanks
-- PMM

