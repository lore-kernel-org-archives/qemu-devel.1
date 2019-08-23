Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AC9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26EE21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sv0UYFYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26EE21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i18et-000561-Sg
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i18YO-0007sN-Nm
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i18YN-0002Uc-AR
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:20:28 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i18YL-0002OQ-Ea
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:20:26 -0400
Received: by mail-oi1-x241.google.com with SMTP id g128so6867979oib.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 05:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=81SiMvlJs7t1RqWDKJaXA8T7nW9rMSm+rqMKJ0GJdrc=;
 b=sv0UYFYco8pL5q2lIHVtpH5o42n96/JhSMPV6jEH43VkXrTgO9YXu/jdj8YJ0J4wt0
 crC70QpSC9t/OqZF7FbJ/pOLyBGB885IzcShQQ13NuTZFH5odH0TxtTksP7AjuV4hnIC
 nwA83FRX2uHyUdIlwFDd9vijKOWF3hZPUAk2mF/A5yNGe5jcRaHttq2knnk1gzmZJZaM
 tdVJRsqJyB77SH7vg1JQE6ZeFp+lUHWJPe9AWxZbwdZY4szDYOCHK5b35NqBWhL+ezGG
 hR2ajsYl/pMIg6LMulW8HXvhoDthW+6PDClMkWFhdhWdQmvxvYFv8oksoyqYIhLjr6Fw
 0cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=81SiMvlJs7t1RqWDKJaXA8T7nW9rMSm+rqMKJ0GJdrc=;
 b=mc5CAiA0dp9QDI7UpiL1HI+bN/tu1jouG+KuKY/V9Bh2COQbh2E57kHaCJIZKNCxuP
 mjSdUdYRSwjnoOakUEY5KOhYy7nq5aAo8iLVbbTXX2xv//Gk4pf8/w54gl0g5eumLuiV
 nt7vJeMFH+MdNqOXcjHwTJ1MsvUvweEamBFsS9cZSpcIuy6hIOFYv44TG7y7OzmwI3/R
 so4uUUXR5W2hsWWZKjg/5++kzGG/QvX5zUUMbMm4Z0Bbq2+D3e5TJ5a4KsdtnBZZxWLp
 qWVmSU9mDdRV9jNZnCGSu1sPjxfCC5gI1MuYmePPDddfZd9IrWpKsXGtx5QGyzqbznJi
 LjlQ==
X-Gm-Message-State: APjAAAV7vqcIVpuVNYNFsbsNYL0vIFOSKYmVWhJaR42nicSnCQIjbFl1
 sSWBWrvfZMR/Cjjb782iRVbv+n9f9IEgE6MZtdrCOg==
X-Google-Smtp-Source: APXvYqz8qCuSI8GnISFidhq1Tyd5mH8f9dmGw1cn9tFm6/XyAPo+2afQ1wVyG77LhzvrUmdYPirafTj1CnSr5od/Qoc=
X-Received: by 2002:aca:4814:: with SMTP id v20mr2974639oia.98.1566562820056; 
 Fri, 23 Aug 2019 05:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-8-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 13:20:09 +0100
Message-ID: <CAFEAcA_zScEjd8YT24cUQwXvqT4waCAdvWcNzRQby_6euzzzCA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2 07/68] target/arm: Simplify UMAAL
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Since all of the inputs and outputs are i32, dispense with
> the intermediate promotion to i64 and use tcg_gen_mulu2_i32
> and tcg_gen_add2_i32.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>8
> ---
>  target/arm/translate.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

