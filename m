Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65726C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E562087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XrXyBbfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E562087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itXLa-0002YW-DP
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itXKP-0001Ng-CV
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:42:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itXKO-0002ac-BM
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:42:53 -0500
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:45510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itXKO-0002aA-7c
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:42:52 -0500
Received: by mail-ua1-x943.google.com with SMTP id 59so11470566uap.12
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 05:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kdNEsOiVaIODjv6dgkstvRzqdNiV8ZCDhWNk6pNFEro=;
 b=XrXyBbfDBJEPfmFTbgFFEgHOKg+Pq9bdOvewvjb6SyiMeF+KxuiUDaWFXZQNzKXEjO
 KPNFrEaeF8FBZNCvgtO6CIiMYlBJKQ6L//66uj2hDxIkDvVJZ9uGLVBLXUzIH4n+MdYI
 Kb+q3SfpAAtbsNptWwYpkVpBOC21Rr0d7ae/bxuEIlXA/BbMcqYuONdD9LoiE429hj5T
 nXDWxW7IWbM1FrIGnPrNdsQOL20VH5ABMEWc+iW3YB+ZbHzFouLIv5HCJnrw8zRWf0yh
 unK+H4W2AFu8URlyvd47Xu/EOcvIIME61vMG/AKRmyMIfWtsZBri4naQkatA11M8JQk5
 kmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kdNEsOiVaIODjv6dgkstvRzqdNiV8ZCDhWNk6pNFEro=;
 b=VTxwiOEOyI7nIQredzkaPGKFUWNg2iHAMOhYa+bBkKe9TLdZyQsJNToR9tcf9Im4FV
 ii+LVl+G09+mC/DSoAtldIYjSX8Gw6JQUj6sTZGMlVET3h0YJoaxJ7NS7wrCk+TlscHY
 /yZWKUgAUHPMe9GnPva09oSvgiAyr4kTzbTFhBtjZNAxBt3giKmYE6vWkc+acVlBWnvG
 ycL7wuUGl2f37HyLXAHXAaSLVxVpXIFpvoTkAH4ELeZbeSe67UmUPQyntgDSDiu3kaDw
 r0X+RclUel8BUjU7woQVZeiJ+k1evGa5InQzVpvcuwt4jdx0OvnD6tc1JhBqdT0W0dSD
 MiQw==
X-Gm-Message-State: APjAAAWctBNiMfOtuy7JjLhLVUdoQXOypfV1azkwGzcTeOfocxKNf/BW
 ptrOyAZzanZDTR8xco9bOOdnZBSBBcbxv2lY5lHU2b90peQ=
X-Google-Smtp-Source: APXvYqyz14Whinftt58haUZdM9rlT4qzb3y41WFSwBtd4QPExsoDN3aeLx8v1b+hXUDexb+CIsNoyJIouWvhraiWWa8=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr15109614otq.97.1579527338736; 
 Mon, 20 Jan 2020 05:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20200118164229.22539-1-linux@roeck-us.net>
 <20200118164229.22539-3-linux@roeck-us.net>
In-Reply-To: <20200118164229.22539-3-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jan 2020 13:35:27 +0000
Message-ID: <CAFEAcA8yH8deTL6PrX42Lh_TbR=gx4QbukuKUOo1XgLod=2ZXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] hw/arm/exynos4210: Fix DMA initialization
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::943
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 18 Jan 2020 at 16:42, Guenter Roeck <linux@roeck-us.net> wrote:
>
> First parameter to exynos4210_get_irq() is not the SPI port number,
> but the interrupt group number. Interrupt groups are 20 for mdma
> and 21 for pdma. Interrupts are not inverted. Controllers support 32
> events (pdma) or 31 events (mdma). Events must all be routed to a single
> interrupt line. Set other parameters as documented in Exynos4210 datasheet,
> section 8 (DMA controller).
>
> Reduce the number of DMA events to 30 for both pdma and mdma. QEMU's OR
> interrupt gates are currently limited to less than 32, and we would need
> 33 gates to support 32 event interrupts plus the abort interrupt.
> Operationally this should not make a difference since they are all
> routed to a single interrupt line anyway.
>
> Fixes: 59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Use interrupt combiner instead of connecting all events to a
>     single interrupt. Limit number of events per DMA channel
>     to 31 to meet qemu interrupt combiner limitations.
>     [Not sure if "assert(s->num_lines < MAX_OR_LINES);" should be
>      "assert(s->num_lines <= MAX_OR_LINES);"]

Yes, that looks like a bug in or-irq.c -- it should be using <=,
so 32 is permissible.

As the comment in or-irq.h notes, we can safely simply bump the
#define value without breaking anything if you need more input
OR lines than 32.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

