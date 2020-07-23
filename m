Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA60AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CC7206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kjnEQxbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CC7206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYXJ-0003La-P4
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyYWc-0002T2-Qf
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:32:30 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyYWb-0004yQ-1X
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:32:30 -0400
Received: by mail-oi1-x243.google.com with SMTP id y22so4552315oie.8
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FUtjYM9yrc/7go4GZXMe/dstoEMEM0uxT/hAhyiYI6k=;
 b=kjnEQxbtytQAt0bfmPUw5thIxOwF3VGr+u0YhcS+Wt+p2wzJo4mKc1KGdWncOXkHy5
 QsrQb5McpM/X258cx8+FvHfRcNQBiaEN5iIW1OCCTbQLxoU+Eqmcb6alo8Lelcdd8BWs
 w1WpJfKG12E5WmFG6hAkO57GX9XEkqIEInkop4dvelHWu5SSb9U5rTHgz4qllr82JeJ0
 Z6Y3hGZYnL0bmwiZWChMk7kNr5VHWTfDTKaTZuQLDLPZMi1CzfUtZzV/rQc2yEVhq5NI
 5MjWSUUJvxCmK4obUVQv6JUl2+J182E6qSlTGfD9+/tySyrwn+y+q5iibzeuRd2ra4Ap
 qrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FUtjYM9yrc/7go4GZXMe/dstoEMEM0uxT/hAhyiYI6k=;
 b=DqUs6vjKPPdYXB9Sc7dqsB0RdKX4jVYV4INxR+Xy/t9mWUL+no6lmTscYbexSfbKhO
 2G9RRzkt8tfpa27K+Nrz7pQd8B/q+XfqRDdPwnhrd6/WFHyNvcSD0breM7w06+Qs/6dr
 KD8FsjXP8co/HRDA4Y6w77Gm/epBRjXKAIt582W8hW1cbB/AwqJ8v9tM/uAZu9X3f1vK
 U36ocBnNElj2YKJj0j3yavHHQru7aY3pR7uBguBxJwKzC41lfOnzs5Ig4ydJwEs8uXL6
 eLnPchhNe9D/UpGnFAg6J9xxv2D2+5cg5oC/hCrG3ESeS6lKT1tlUzg55/8bCNWNntag
 9wlw==
X-Gm-Message-State: AOAM531QZc0hAtGlU5aCTqaCuBNiFqmZVPkYQazCNbmQjSR9FIn+vJs7
 ZmWwPfQsAm1fupA6zDr/khly2/XygOQaz2cz/MdvmpOT
X-Google-Smtp-Source: ABdhPJzNn/Jmp7CS2NSODceDEOIkKuIIBC1yTwjkB/lfAb4WO5negL+Htpc3pDIhnavx42TeRbcsdaPdsOEKP0ClmQQ=
X-Received: by 2002:aca:2819:: with SMTP id 25mr2966152oix.48.1595500347423;
 Thu, 23 Jul 2020 03:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200722210536.1414936-1-sw@weilnetz.de>
In-Reply-To: <20200722210536.1414936-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jul 2020 11:32:16 +0100
Message-ID: <CAFEAcA9bDJj5q-xZs5dRaogVCBRK_NV+FvCdyL2=Zcd4LxfVEQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1] Fix grammar in documentation
To: Stefan Weil <sw@weilnetz.de>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jul 2020 at 22:06, Stefan Weil <sw@weilnetz.de> wrote:
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  docs/system/build-platforms.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/docs/system/build-platforms.rst b/docs/system/build-platforms.rst
> index c2b92a9698..9734eba2f1 100644
> --- a/docs/system/build-platforms.rst
> +++ b/docs/system/build-platforms.rst
> @@ -57,12 +57,12 @@ macOS

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

