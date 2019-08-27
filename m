Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFCCC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7894F206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhK4u/Q3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7894F206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2aaV-00008e-Gp
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2aZW-0007mN-AD
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2aZV-0006l2-6z
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:27:38 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46291)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2aZV-0006ka-0y
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:27:37 -0400
Received: by mail-ot1-x342.google.com with SMTP id z17so18403843otk.13
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0oBjSKtf+OCsEs24h5eNAZGHMiiMtz+v3nB9gPfkpWo=;
 b=OhK4u/Q35g3dsaRTwTPbaChBkRLB7S8FXIP4N1wyRMp58vxdv4i+AOxh4x4T1LYr9c
 cw7I/gqe7rbHJVKQm5KmF17x/vsuk2WOWX0uCPUtnsNDK+esNUhx+p6knOaFp18iG1Tw
 iXMcHDmwE+pBTUBa9Vs3sGFquDgPZ33eW3zMAMtosmLbH2HnDbEb8w4KVR0IApNRmr4m
 ZGFoVXWlruBc5jzYNwDyq8EBRuH3eGcZvaOb0W91GjJVKSrGLOD5QkCxA+Hps01UxWLd
 dlci1iPlQRsxHj6LKOKrxNB/h6yhDR5cG8UZHK+9kiMy/syHmLMvrMBbOfcTNY/8d9qJ
 UNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0oBjSKtf+OCsEs24h5eNAZGHMiiMtz+v3nB9gPfkpWo=;
 b=jjCTt2uUlLTJx11XDgAOBzcoi9Hu39+8lVfdUBF5fp1ohIb3FTEauy1ga/mT/x6wDc
 Jcu6eBIehwvewm8WSr5xpwfSzOIAxtaRPPPUu0xqUqF6MyHtj5a0c1L0l7bLq5q1VUa9
 8iyg3FuFQQZLPWLfmcmbDykRkCJ+W9AGwjnbg7yHng24POqfTUmgJqOgkqUhKInYo+Vb
 Sy4Zp9oS1aW7USsfSf6Vg0uMQV+9BUeKazOoGK4AfJ/roa91RzntWCMc0KRlGrgQZOMd
 v8B2NVYJn8zUaTlazo7B/zO0aK0WC+1E2EredxKGb0Yk+xQsH5WLjYrkMIB137gt45ij
 iyhQ==
X-Gm-Message-State: APjAAAWDZSrLRspYR52hu9/As+NHL5KjhmGKTBesE7fPv6ZLSOD1kX0q
 m6slGAfYevvRV36J7RB6QOkac6QEFFoPf133XLBJ1Q==
X-Google-Smtp-Source: APXvYqwo6QamPyaxDeo6LW/CjU4E6dXwj35RS3ARC5QdZK3p1fOXP0/vbuAlirDXEBFPa1+neZaScMmkXStyunU6mJ4=
X-Received: by 2002:a9d:6a94:: with SMTP id l20mr18698667otq.221.1566908856093; 
 Tue, 27 Aug 2019 05:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-21-richard.henderson@linaro.org>
 <CAFEAcA85Ojy2u_G6frO_KL-kmTVCfpcOxsW5CCuKr=eKPcm+KQ@mail.gmail.com>
In-Reply-To: <CAFEAcA85Ojy2u_G6frO_KL-kmTVCfpcOxsW5CCuKr=eKPcm+KQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 13:27:25 +0100
Message-ID: <CAFEAcA_W54m7vOhPWNF6yHJC-9YjHLcnd=3eKMzwA1YJ2YYryw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 20/68] target/arm: Convert load/store
 (register, immediate, literal)
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

On Fri, 23 Aug 2019 at 15:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 19 Aug 2019 at 22:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/arm/translate.c | 797 ++++++++++++++++++-----------------------
> >  target/arm/a32.decode  | 120 +++++++
> >  target/arm/t32.decode  | 141 ++++++++
> >  3 files changed, 615 insertions(+), 443 deletions(-)
>
> This one is brutal to review. I got through review of all the
> decode file patterns but got bogged down when I started looking
> at the .c file changes... I might come back to it alter.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

