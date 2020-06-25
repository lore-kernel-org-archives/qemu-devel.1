Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922CAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5996B206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuEoc4T/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5996B206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joV5r-0004LB-LO
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joV5B-0003jv-J2
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:50:37 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joV59-0002f5-Am
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:50:37 -0400
Received: by mail-oi1-x243.google.com with SMTP id w17so4840231oie.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HPPTVWJE7It0f22V0h1/ishDkdVhCDtBrga3G/+KN78=;
 b=RuEoc4T/WE2RcXjs/3Ms1nyVmIGJMkCO2Vfe2AQRs5dvWm0eX15l3DimmNfLjy7fLz
 8NhrqU93saZwBysQ/juaaS0j9bCPjKXKvpO2u37gIPKtPxKjrSxvBLvcY3td6QfdCJAh
 G2Xh4rLCU/AOApyoWzidbZJ4XmO//92zug0Q3RzPHa7XYL638pJQrJnXQKqY+NAj20CZ
 D0Ac22xUGJtTeRFmMAZhhPV10AUd14O/D7xHW40cVY9L1pjwy3i13PrBcdHSHkghl0O4
 RS66yBQ01+Cx65zcWnaLfeZ074K9/9o2ZVNMUlJdM97uPDQfbR6t/uVFcQkOKDjMJTnm
 KihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HPPTVWJE7It0f22V0h1/ishDkdVhCDtBrga3G/+KN78=;
 b=RBKUMbvcJFnZRRfO/1C4yDwzVKCtPBEN35d7BWTXOR7LPoSgYzgBx/qoMMBt/LakfP
 cdwaAi8cSJY+fYYpW0tfuRHcRNSMMlBV5EQcN5X6sc7R8/GvVJWuMC5znAbb9o1Jsuz0
 2s3riUfEEG+O9MRd7u/b6eHpCgNHkgoWsH74klgnEmy4vsth3cQcFLfLcs2W/KzCNvF2
 CDgDeLRx+EsA45yflDa3gl0+7/yeUYSddHVYycZNKXZruqWZV6zGfarNWnnS9iv5+G9a
 AV1iY14ruOrkXgZHt29I6949t1S2YKKkAlaAtYOeGXOeUg0F1evC2D+IAj2EojnEohQI
 JBqA==
X-Gm-Message-State: AOAM531okGC2UkvRgahVffK/3p2zM4RjAVyZ76XiwDnFgea194nbkktX
 F/5XSBOuNPXTGsn8XbWgFUVj7hfUZ82pnqWtShyoVw==
X-Google-Smtp-Source: ABdhPJwSyNPe8W4St5XSxj+zi6WJMORSa4nOx0E9OgNa+NvakIGoTJBmnoyJjKOtyq3sBJLBfcr2nZ8/5frYiLBgY0E=
X-Received: by 2002:a54:4694:: with SMTP id k20mr2942673oic.146.1593103833892; 
 Thu, 25 Jun 2020 09:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-11-richard.henderson@linaro.org>
In-Reply-To: <20200605041733.415188-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 17:50:22 +0100
Message-ID: <CAFEAcA8fAB_DDrBjjVCCKwiE_n=05q1KYyWMR_2EuhOa0+EKww@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] linux-user/aarch64: Implement PR_MTE_TCF and
 PR_MTE_TAG
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
> These prctl fields are required for the function of MTE.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This API doesn't seem to be in the upstream kernel yet, right?

> +                    /*
> +                     * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
> +                     * Note that the syscall values are consistent with hw.
> +                     */
> +                    env->cp15.sctlr_el[1] =
> +                        deposit64(env->cp15.sctlr_el[1], 38, 2,
> +                                  arg2 >> TARGET_PR_MTE_TCF_SHIFT);

This actually will be per-thread since each linux-user thread has
its own CPU. You probably need to do something to make it be
inherited across clone and fork, though (assuming those are
the required semantics).

thanks
-- PMM

