Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70753C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3899A2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUsU741K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3899A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeg8D-000378-An
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeg7P-0002Kc-R1
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:36:20 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:45881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeg7O-0001Tt-MM
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:36:19 -0400
Received: by mail-oi1-x234.google.com with SMTP id d191so2699699oib.12
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=vGR2wio/JKO4J2X0utLN+i/G/7DvsIIas3y+8G+Y31w=;
 b=KUsU741KhUWxYpf9MYu1Lf8hP2sRVG6zSzYZOUYgifDq32XzjAF/yxswAk2J8TN6O9
 CMJG0XFfHad8T+v11ZrpVuUA/Zt3TUNxParVtDgTsY6HYvJahFI9FPADdkcWJXKtqa1h
 WOz8GkXMonXIcUc1zdlZ/yysOK49pRlidmsmeZZ8wftguJbgf+5CtCCzSqy4NZYxQ8Ix
 Vdnk5H1XzFYBxFzkZpkLHGzleDhtpjtn2rv5tS3dhY5XqpHtJyP7fjaoGDKo/bcW3ZsI
 AtyJWIwsfyxCOxg6oCUUbVM/f33+8F5kmPkEH0XAjLp9hgNh9SzM4lrYqRhXPKKCjuKT
 c8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=vGR2wio/JKO4J2X0utLN+i/G/7DvsIIas3y+8G+Y31w=;
 b=L/1meztN68R7QeI3a7Ylswpy/1yn8aw8pIDce7dxo3ZeHdCxIo+/1eHwW5r+xbjWea
 tfLUOwP8bpCDjnNf3DzfJUkjUKSvA7cgnAJw6r9XT47X2e12p7+AmPcqzHd4Cc+ME3I+
 kdD7NGwYYn4kO9duO9F4/JPOhaTxU83alBH4bVAEFVCS5hO6kays2tt+z7DmKP+ZKv6k
 ApYrv7qCg2cHtJRjkQJfMSJO09Pm59EzyclNPUxaPj2b4ZHyAYgD4Ox4w7ojL8afvZyC
 HIRav+mHnoRtRBRPBZWuvQLrizCLcpJBgaVp9inB/+plnpT0wr5krWQQ5pQUs4GFhT7W
 4EBQ==
X-Gm-Message-State: AOAM530vH4Nmydm7LU/9NLFYITYNlmbpwxd1kUqwF0azUHj4QjFJ2CUE
 cKnfhm/FLMNINj3CQQKJo+y9gteuKRFtqz3qd+WrI1jPUac=
X-Google-Smtp-Source: ABdhPJwyucmA6SOGlRL142vb0tB0E1nL74j7hyZLW4EsLMwoddcNL+Mi9fam0vdniTS0PnBzr3agZZYDF3Uoa8clPII=
X-Received: by 2002:aca:5451:: with SMTP id i78mr1277873oib.48.1590762976742; 
 Fri, 29 May 2020 07:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_Lr8ySUK_PUNVB+RRQhFhEQL2wFeJtdYAxZhhT1xEFNw@mail.gmail.com>
In-Reply-To: <CAFEAcA_Lr8ySUK_PUNVB+RRQhFhEQL2wFeJtdYAxZhhT1xEFNw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2020 15:36:05 +0100
Message-ID: <CAFEAcA_qiz6fa7sGJmqcHEwX9CirqXVrbVP6XaLcxfskrb6wYg@mail.gmail.com>
Subject: Re: 5.1 proposed schedule
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x234.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 May 2020 at 11:07, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Here's a draft schedule for 5.1:
>
> 2019-07-06: softfreeze

this should have read 2020-07-07 (Tuesday)...

> 2019-07-14: hardfreeze, rc0
> 2019-07-21: rc1
> 2019-07-28: rc2
> 2019-08-04: rc3
> 2019-08-11: release, or rc4 if we need it
> 2019-08-18: release if we needed an rc4

...and these are all obviously supposed to be 2020,
though the month/day numbers are otherwise correct.

thanks
-- PMM

