Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC07C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E492620708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RyFcJVC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E492620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6iZ-0007uT-5V
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY6ND-0007YN-7p
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:13:27 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY6NC-0006Ix-Dp
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:13:26 -0400
Received: by mail-ot1-x344.google.com with SMTP id j26so7232522ots.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IMDbJBu5+Rd0eP4QGCJnPPGRd2XqPGZu1QMu29plVuk=;
 b=RyFcJVC0xhi2jPq4KWOP/f3G3rVzh4eo7EmdCswcGRde8sxNpf5fHeYJhVa3gOMMKe
 0MYwkN1ISxuRPZWsVd/b5h/2EsasiYNOFNgbn82BUHslSixptrSffqSX3rwTaLAc+9zp
 AJXZbDpuUFQ+KyfMkhlOhOGjcYCFE9XPbho9wEmXrqKWijVjSISwtZlsvto+L/99MbDz
 qyZ+pLyPpTr+pAhm+cMLF0hq2m+lptm559WOh1g77KvzLOkyTvjJE6npuRiruCdbLNPD
 Ba8o8nOp6+Kt8vFQ9qHUndXCpfK9VbrQIbIFlobAKQ01fCBlgwXVHCbwCflySbkxbSVL
 1KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IMDbJBu5+Rd0eP4QGCJnPPGRd2XqPGZu1QMu29plVuk=;
 b=a/9pyj8RYTJ39E6URN/pb6Ja+LruFHPspy5S6wD1jVl8UZi7inOU70McIxZdODLTgn
 DQ5y+D9ZHW1WadIkUbS0LiGmkINo8aWwPUJrWATdhZEG2LA1VZ555+hvrPRp/L09kJ6e
 XrCDgWU5/oE7kBT2s/fnBH/19nU1Z1AGuvXyokAijl+hh+cku08ktAe1SeJzVgW7RsRD
 g5xkEPxy5mCYZ2GWIYts7y6pABnRQ9WVX5B5E+B2UF8trSWdmnFaxFQDiSdj3Wb/NOr0
 SchaFp/xMEEIz9e3yWB0wJ6ujzfjj2mHh+64+4HgQ+0vVqr9jKiH0nWp9QHDKXZ5XRIQ
 WwGQ==
X-Gm-Message-State: AGi0PuZis+HvKDu+BSdX8nDgyhvWGCm8RPGeOZWMqBK3cVaN5DL+GLP8
 inncHAlz+RZ/HVDAESaU0Lk6c80tipFgMhuayVs1IA==
X-Google-Smtp-Source: APiQypKRqrOsnBkUVQa2sGZlRFy0PFIKLlSWxXCWIz5SoPIsdZhjggSABwpbiITEVnW7RFpSuEu4HAAuZfH3j9E5Zgo=
X-Received: by 2002:a9d:398b:: with SMTP id y11mr68131otb.135.1589195604991;
 Mon, 11 May 2020 04:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200507202429.1643202-1-amanieu@gmail.com>
In-Reply-To: <20200507202429.1643202-1-amanieu@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 12:13:14 +0100
Message-ID: <CAFEAcA_doVoCbX9y=UEJp11wjrpuS8+oS8OL=dz200SiULmEjw@mail.gmail.com>
Subject: Re: [PATCH] linux-user/arm: Reset CPSR_E when entering a signal
 handler
To: "Amanieu d'Antras" <amanieu@gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 May 2020 at 21:25, Amanieu d'Antras <amanieu@gmail.com> wrote:
>
> This fixes signal handlers running with the wrong endianness if the
> interrupted code used SETEND to dynamically switch endianness.
>
> Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
> ---
>  linux-user/arm/signal.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
> index d96fc27ce1..8aca5f61b7 100644
> --- a/linux-user/arm/signal.c
> +++ b/linux-user/arm/signal.c
> @@ -244,6 +244,12 @@ setup_return(CPUARMState *env, struct target_sigaction *ka,
>      } else {
>          cpsr &= ~CPSR_T;
>      }
> +    cpsr &= ~CPSR_E;
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    if (env->cp15.sctlr_el[1] & SCTLR_E0E) {
> +        cpsr |= CPSR_E;
> +    }
> +#endif

The #ifdef isn't incorrect, but I don't think we need it --
if we're emulating a little-endian binary then SCTLR_E0E will
be 0 and we won't set CPSR.E. So we can drop the #ifdef and
the code is a little cleaner to read.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

