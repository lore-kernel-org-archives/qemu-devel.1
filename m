Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94518C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9EB20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuCSNsXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9EB20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j17bl-0006e1-J6
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 06:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j17bD-0006Ep-JU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j17bC-00023o-Ca
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:51:35 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:46729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j17bC-00023P-6N
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:51:34 -0500
Received: by mail-oi1-x229.google.com with SMTP id a22so8861466oid.13
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 03:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GilM3sA9V9556WKegD+/7f2jMaic0VKxSPeOHZRwe3U=;
 b=FuCSNsXKETaDZX16tdE0ckF3Gs9HlEat9xUVgIGX9mshnjPVV0R99lngPs+gInIxDe
 lOj+fLs+9YaYgFFWX0M2CLdFmTrOEBlAfBfzN4COQoDiMa5jQxB7/HXMPVhBkaSEHvdU
 oeNEdpoJYa+mLu7jAHr6z+89YlXT7RYBE9iko5EThXlyexDSEzmOAUAbXZ3uIjN7xzxl
 p3YFRY7mX+x4XTizGR5pj/epsL6IfeI4rFrfgpBl0lsBmBDYWHdtxIjTASc4Zj49orAR
 wzXFjwsyz24+XzO9xQ+a4cztWGLPhXtqfLMA2ZfnEsTTDmiwcKy+M1lPAAcbJqOBxqxc
 7AVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GilM3sA9V9556WKegD+/7f2jMaic0VKxSPeOHZRwe3U=;
 b=cALXoH0hkw6lJ6N3w6d57V0lBXztFe45kydQ0Eo/2gqN7O72EUecrXaEtG9zYegiZ0
 cQcmB2hwx1jhEn+YwWtJDS7oN+cqSc8VUgi7u45PAXGi5Obh/iv8431xAlc8emF3cnJn
 y+cTyqBI+lMQUdO3ByyYXIyLMCGdpmGGNHypsjPH6YGHFd81NHCOR0eaZ/uMYr+yDXik
 Bc9b0rxYh1Akw2yW2O1JaTl3lhzUgYDCWIWkMZ1KzywN+Mt/DMEOFz8TafNwvcaF+CoD
 ZGDpIgFE3/TvX48qZPOS6I0LrCNgYPzEKKSJZOW7Z28pZOSKOGoM8ztiY/PRgMW6fp2x
 v2Fw==
X-Gm-Message-State: APjAAAWUepBpIut3SaZqSZt/UYCt20qSIhgrfx/4lliNvmvIaxRqsBAt
 rrwpaDVlxBxriqlJyR2D//4Vzzk0j18mrx2BYxZvkia9
X-Google-Smtp-Source: APXvYqyAR+c7UoS1faAg1+d3brkE/JE211i8Wk6GwjUrj/YO5xwTyNPVXW4yKTKgsTFfjzEuwP9ok4Brl61qPHx5KpI=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr589680oiy.170.1581335493254; 
 Mon, 10 Feb 2020 03:51:33 -0800 (PST)
MIME-Version: 1.0
References: <20200107132715.722101-1-laurent@vivier.eu>
 <20200107132715.722101-3-laurent@vivier.eu>
 <CAFEAcA9pizjyZbNB1mhUTn40nRpzHw=GLMWRtYhra5G-ijDmSA@mail.gmail.com>
In-Reply-To: <CAFEAcA9pizjyZbNB1mhUTn40nRpzHw=GLMWRtYhra5G-ijDmSA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2020 11:51:22 +0000
Message-ID: <CAFEAcA_FZKgyJzKxX-Tvbsu1qZpqD58k+OpJr_YrY8_oUbBttg@mail.gmail.com>
Subject: Re: [PULL 2/4] q800: add a block backend to the PRAM
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 at 12:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 7 Jan 2020 at 14:40, Laurent Vivier <laurent@vivier.eu> wrote:
> >
> > This allows to save and restore the content of the PRAM.
> > It may be useful if we want to check the configuration or to change it.
> >
> > The backend is added using mtd interface, for instance:
> >
> >     ... -drive file=pram.img,format=raw,if=mtd ...
> >
> > where pram.img is the file where the data will be stored, its size must
> > be 256 bytes.
> >
> > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> > Message-Id: <20191219201439.84804-3-laurent@vivier.eu>
> > +static void pram_update(MacVIAState *m)
> > +{
> > +    if (m->blk) {
> > +        blk_pwrite(m->blk, 0, m->mos6522_via1.PRAM,
> > +                   sizeof(m->mos6522_via1.PRAM), 0);
> > +    }
> > +}
>
> Hi -- Coverity warns (CID 1412799) that this isn't checking
> the return value from blk_pwrite().

Ping -- what should we do about this Coverity issue ?

thanks
-- PMM

