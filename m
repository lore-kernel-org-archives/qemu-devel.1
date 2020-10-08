Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE9AC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18859206E5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="muqzXu2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18859206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVfn-0000lj-5F
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQVWS-0006Ne-I4
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:59:52 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:39758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQVWG-0002FF-CL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:59:51 -0400
Received: by mail-ej1-x643.google.com with SMTP id lw21so7971736ejb.6
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OGY/uIp2EDPhm6ZC96lZgvI3+mtwjY2iX53QRwnCPxY=;
 b=muqzXu2+kq4+YjZIs2kroXkbvrqVObe4XtuZp5AfdTUM4zh3xdepJId80zkZEhB3T4
 PSB6SUMZ6ZvTbHHKDHgHgh8NyWFQuUR+TfJLvweI33wby20MLg6pkdqdRxz98KUnGc1n
 sKavpN98NG9ZhWXiSPxnt/iVs0zpGwkbRVqj1WYvZc8Y7QxYeCZucqxdjcgFh1QakkBR
 rljuXZCbzQUoyXqZypl48CBDFry4/0b6KtnrU5xxTfQDNuPNd/hyOaThTppkDxWEc3pc
 hF+Gf8OgFDFVvNc7matcjWO5hWayT/N/Ejq4zPjKgY+6ohiFaekOZfqqEc9NEsy1MOJy
 Zp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OGY/uIp2EDPhm6ZC96lZgvI3+mtwjY2iX53QRwnCPxY=;
 b=ilHycrRL/X9SXkAU4Q63V2q5U40JnJPdZuFwOR7UZDO89innCbwmOAhaOyvwzpGQyG
 vCLGlwcyGhIaqcnAnYHgy7yisqMJzWpmqZOyXo+f9czrlxfoL7EFlSOxd1EgEev0dntK
 uTqOYmIEepod6PcKZDP7TLU+NjWkp4GO8m6jEZYrG0XNX8jD00KQJfWD2uQWPmEdxaHK
 +sV+pNLvUVbHCPDMMJIFHCU/3fR+7nRq64yWinzTOGg0cWThO9Wm1G9COSheSHKvable
 /immefe0bkpMORTRcUC3J26XzqbjWYwE4tYWYlZ9nd9WzoMJjG/b4adDG/a+HsZZQoDc
 WQ/g==
X-Gm-Message-State: AOAM531NZZadRvpWTCQo65DSyVBW7asPx7bYuaiROOFbiNIOAsNFEAyj
 k8+MMC7CmnxuKOPIOcz1pFvp/6Ii6QRF8qoqbHpv3w==
X-Google-Smtp-Source: ABdhPJz3AW/zWW8rw9qHFR15rAMB+LySpjAsC8NGgNETyC7TM6djxlZ4Xa3g4ZE1xON9GIZ2XZIJ7Z7wmHtgryNwrKI=
X-Received: by 2002:a17:907:4365:: with SMTP id
 nd5mr8867865ejb.56.1602161978581; 
 Thu, 08 Oct 2020 05:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201001170752.82063-1-richard.henderson@linaro.org>
 <20201001170752.82063-3-richard.henderson@linaro.org>
In-Reply-To: <20201001170752.82063-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 13:59:27 +0100
Message-ID: <CAFEAcA8pgsS8rKaSZcs3Dq5yGepV7h2v4AOtRrRMAAkPbNGezQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] target/arm: Use tlb_flush_page_bits_by_mmuidx*
To: Richard Henderson <richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Jordan Frank <jordanfrank@fb.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 18:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When TBI is enabled in a given regime, 56 bits of the address
> are significant and we need to clear out any other matching
> virtual addresses with differing tags.
>
> The other uses of tlb_flush_page (without mmuidx) in this file
> are only used by aarch32 mode.
>
> Fixes: 38d931687fa1
> Reported-by: Jordan Frank <jordanfrank@fb.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

