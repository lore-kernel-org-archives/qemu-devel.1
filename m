Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44476C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1122A207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYSTaiLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1122A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9wDb-00049W-2n
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9wCG-0003Ri-Le
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:30:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9wCF-0000Gh-Ko
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:30:16 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37764)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9wCF-0000GG-Ey
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:30:15 -0500
Received: by mail-ot1-x342.google.com with SMTP id b3so19538otp.4
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 11:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v9QggBIEmSoZGmgupBp1v67qDm64qmC/63NMF4LdOOg=;
 b=LYSTaiLoUzY4MJJ3WqmdbnISImWXlmm9BFjoHYo7MRUa19XG/kwH7f6vZcA4cmY7Os
 TyXn+KB8nysDK5ngafuM0Nx2nqJX0UZ9lG1M1Jt3yVlttFwfljCADib8X7csHHKAmsmT
 uEJXPIXh5dNdngNOGY+zrfITnp6SBe6eOZv+Fr8jTY5+CW6Jq0z7wke+OlfljPPRAGXm
 dVDyNMC4cIVWQpxzOZR+ZT/SCvBy6Av1U5beblwNkBoR1fVjjsDicJn0CYjSaIvRVLFs
 UWt2KRVLICWD1j+y8cdWcV5xD6M3PF33g5qhgcG7QEV56YUsA7+ZJrogk6U2mjcRKBny
 o7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v9QggBIEmSoZGmgupBp1v67qDm64qmC/63NMF4LdOOg=;
 b=SBPPtMJ2mlprucYwKjZosxFuZvVs/wTPzKgq59x58a3KNuivHhJwpw5Nn3aJMhC0Yi
 Ol3IA5QdebBByEVvwduLahi/s0r7T9vD24uc4yWHTUsi6Rwr7plrejyBjJVuMEGjdiYF
 xYlLBj8s0TymiHq4bdFd+mAzLt/BfjDIUcBkI8QK9LAzBpABfsf4+6FfUSx2J2GPUPUJ
 7hKel82L2KMpwulp41sQMHd1UO7W12VO/9bR9PV6mdQiT0DCApzp7MM17GtyKzh5JcCN
 PhXfeb5GWoSYAicJgAIzfXeDnXoZg7eSqWJsONSuu1hnTi3rMRWxReZbAcQVDt0fXYVo
 DFmw==
X-Gm-Message-State: ANhLgQ3PVtTJfArol611IfJ/rhUX3/7NeT3Cs3nXYm6WRyKqWjQZ+wIR
 l0gXVcZjTAf+PgZASlxCt9bhzWLVx/EwtfHVc304zA==
X-Google-Smtp-Source: ADFU+vvOzjlg6Kshde2hFXoUecSoFaaCv4KBJXvzx6vXHNHH79Uoo+ffz2/x6ZShaTuTE9Rx16bEml3niUZRk46XkSM=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr20859otl.135.1583436614587;
 Thu, 05 Mar 2020 11:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20200229141011.58989-1-root@stephanos.io>
 <CAKmqyKP1QFiWSQzUsoV9TLWBQ8hrx+yg7UM2=DnAoCAanLRuwA@mail.gmail.com>
In-Reply-To: <CAKmqyKP1QFiWSQzUsoV9TLWBQ8hrx+yg7UM2=DnAoCAanLRuwA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2020 19:30:03 +0000
Message-ID: <CAFEAcA_O6ScMF0fJgHORVXDQ+PvFNW4w6kBkeeB0vHixHo0zqA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/stm32f405: Add preliminary RCC emulation support
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Alistair Francis <alistair@alistair23.me>,
 Stephanos Ioannidis <root@stephanos.io>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Mar 2020 at 19:24, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Sat, Feb 29, 2020 at 6:12 AM Stephanos Ioannidis <root@stephanos.io> wrote:

> > +typedef union {
> > +    struct {
> > +        uint32_t hsion : 1;
> > +        uint32_t hsirdy : 1;
> > +        uint32_t reserved0 : 1;
> > +        uint32_t hsitrim : 5;
> > +        uint32_t hsical : 8;
> > +        uint32_t hseon : 1;
> > +        uint32_t hserdy : 1;
> > +        uint32_t hsebyp : 1;
> > +        uint32_t csson : 1;
> > +        uint32_t reserved1 : 4;
> > +        uint32_t pllon : 1;
> > +        uint32_t pllrdy : 1;
> > +        uint32_t plli2son : 1;
> > +        uint32_t plli2srdy : 1;
> > +        uint32_t reserved2 : 4;
> > +    };
> > +    uint32_t reg;
> > +} RccCrType;
>
> This is a pretty interesting way to represent the registers

Is it portable, though? I thought C bitfield order and
packing was implementation-defined, which would mean that
you can't guarantee that this union will give you the
required thing in the uint32_t half.

I think it would be better to do this the way that
other device models do it, and avoid bitfields.

thanks
-- PMM

