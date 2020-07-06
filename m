Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D81EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3739120715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1vMQcoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3739120715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsP0r-0001DG-EE
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 07:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsP0E-0000mt-6l
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:09:38 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:33474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsP0C-00062a-D1
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:09:37 -0400
Received: by mail-io1-xd41.google.com with SMTP id i25so38979723iog.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 04:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L30KsAPbRvJcMeiN/KECssLlOTsFgKjRXa/ojXIIlOc=;
 b=X1vMQcoVzGoLQquN2Rz3gWVV8tbSIdnyCBYRIfBHVqzyYDHAQgGzfpj8u7spAT1MzW
 T0KJ8gXLiso15/meS5n3Pu8qXff4Vo5j1jOfPg3jMtc9hml6vGNSu4q6sobdipnnzQp6
 WhptfpaPMRS4Nis9TGR0sP6UsyUhC3mGBTlBzi5FPT0o2upFJ6Kb80e4ClAgOEwQmipd
 h7uRHQ8KHa6FmvfvObSyfHsXv0COq4YNf1f6vXDlWZ1Yd9Yo5uDGNaJI+yJRWKeEC+E9
 wAB8XkTdubtwVpvS8xiDRFyQoKB31PHuCDLhyd24fgdDK9Do96fXZpjWPbGzByYOKwtH
 78NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L30KsAPbRvJcMeiN/KECssLlOTsFgKjRXa/ojXIIlOc=;
 b=sShD3fKCGsG9DtcHTKFOhdWE/c3aMXO19Mu16rHXlZet9Xwbq0pBVUxWnswsdcMpF2
 9mhimLc26WFdOvVb5oahQ/GYv2K8eoJMPJ2f65aVZGdsKmk5DGPQBztAYmsQI7iH2jyr
 mOkU7irP0/FciAS8jkoIbNwDvZlP401/0M3FgSuXgWzmAnTd/8Ap1Lq2r/bOuxDvGD1a
 7472BA4uayzV1PnUFmzc113tn1KMm5oMe3N84olWEGiolEhAY3E9lNY5COWWsXQ1//Ze
 Be2w46Pha6lk9sjyjo9cDF+ZnmVMAYlE5uXMv26jU+Hez2LE10VDoIkN7JRoeXXbcWIs
 sHzg==
X-Gm-Message-State: AOAM532/zo8MPwQt+b2y4v7BemkPn7jn3IECuNpD9RPcvp6qps0xlfRt
 vSA6rUWHRKdQeI91VHupNgBEjGMd0dK6Fb9ggeoSig==
X-Google-Smtp-Source: ABdhPJxddr5s7zJYo7P5iVf5li/1Y85k7suwqgSYDPKHTGhquzC/W7rmWFlWYxv943fyPH4DDdDrp5EeHvApXBZFWbc=
X-Received: by 2002:a02:b18b:: with SMTP id t11mr48354980jah.46.1594033775188; 
 Mon, 06 Jul 2020 04:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200520172800.8499-1-richard.henderson@linaro.org>
 <20200520172800.8499-3-richard.henderson@linaro.org>
In-Reply-To: <20200520172800.8499-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2020 12:09:23 +0100
Message-ID: <CAFEAcA_gABHKZnSc=btdAinG5=N50kARCMg=+aCLp3dE4XZBPg@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] linux-user: Set PAGE_TARGET_1 for TARGET_PROT_BTI
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=peter.maydell@linaro.org; helo=mail-io1-xd41.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 at 18:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Transform the prot bit to a qemu internal page bit, and save
> it in the page tables.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h     |  2 ++
>  linux-user/syscall_defs.h  |  4 ++++
>  linux-user/mmap.c          | 16 ++++++++++++++++
>  target/arm/translate-a64.c |  6 +++---
>  4 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index d14374bdd4..2bd023d692 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -276,6 +276,8 @@ extern intptr_t qemu_host_page_mask;
>  /* FIXME: Code that sets/uses this is broken and needs to go away.  */
>  #define PAGE_RESERVED  0x0020
>  #endif
> +/* Target-specific bits that will be used via page_get_flags().  */
> +#define PAGE_TARGET_1  0x0080

I think it would also be nice to have

/* Target-specific names for the target-specific bits */
#ifdef TARGET_AARCH64
#define PAGE_BTI PAGE_TARGET_1
#endif

which can then (a) act as documentation of which PAGE_TARGET_n
each target is actually using and (b) mean that code that's
using the target-specific bits can use more friendly names.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

