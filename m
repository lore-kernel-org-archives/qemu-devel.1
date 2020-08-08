Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A05FC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 15:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D102073E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 15:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tVcb95n0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D102073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4QsA-0008KG-6o
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 11:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k4Qrb-0007u7-SH
 for qemu-devel@nongnu.org; Sat, 08 Aug 2020 11:34:27 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k4QrZ-0007Dz-Px
 for qemu-devel@nongnu.org; Sat, 08 Aug 2020 11:34:27 -0400
Received: by mail-oi1-x243.google.com with SMTP id v13so4807276oiv.13
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2020 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7sftBr7LKTAk3RFrIYZ1neFv14Pai/abhc/5UKu9Szc=;
 b=tVcb95n0qsFX0ZO2OaejnvGcojOCLRAoAsKQP1yNUKf+3wHfnAvLoJ9TFR9aKe0liI
 +8z3flSORO5DRQwFS/GK3DvHj3Jmqm+4XRrvHwFVXiHlBkLj8VwcxqhSftZ3+JVoBHIv
 HBbmOrl3y2HGCc7DyybrQhdg/gEIoIOBkIa3y08Q53Qeww6uNTP+KgGeTb5eOhCTypDX
 B2/9yiK/oZWvIzx2D1bGXlk1c/kS0do4RAEKqNjznd/uL9g8Obi4MzvOVcYqSW7eGFTq
 2Lg/IySyj7XbxjJftFWlWcEtWYEEtkTL053Te84m26tY3cIydphjplcmf0lHZtpizWxQ
 IbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7sftBr7LKTAk3RFrIYZ1neFv14Pai/abhc/5UKu9Szc=;
 b=FrAwAsZ8K84HlzMww/SjtAsUEsgO67I+gjJl9223lwgSjOwVO4IUotbYX/I09f+lEU
 ou0BjxjwmYaOn7twkZ1v4dJHnXTuhpfD0iqnkcwatdd3v+LVbrOnuHog0EFJeafdHmEf
 1eChCviAwmGvjJKXnvyLUG0ykDXkW0uxNHptND6+uylSxIFxMRKJ2hB9PSEp5Pd7KwPF
 jI3G2CuBuLf1NuaBjMrek7/dY6e7FL1doCtsXj0SL9NOdqGlGnmTCKaT0An5xhSZDuLw
 5MU9C3hmz62OtO1bObGWDzcHstdUziKcP1fMNcswQjDgbXTzD29xyH9Wa1IFw5FqWFFG
 9P7Q==
X-Gm-Message-State: AOAM530GybJWttXKrPo61n5ARaCMKmZcI+mJJVzvTXTxgF3PkPc55CgH
 RmWAbJ/82g8XVuQW+NWqsjTyuT1/kq2f1gsyRzMttw==
X-Google-Smtp-Source: ABdhPJzcNaMFIezvZOMUNpzLYQmnmJdGcnh7kLxnde1C6bnuQ4YcJW8JYWw0EwkqWKdiqjChbokSA5TgtOORPwyrzsQ=
X-Received: by 2002:aca:50c4:: with SMTP id
 e187mr15161897oib.146.1596900863619; 
 Sat, 08 Aug 2020 08:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200615225827.183062-1-joe.slater@windriver.com>
 <CAFEAcA_ZU_w7PaYFVVaW1vzGySOLaNaThVcNQFNmd_GV-hG6Qw@mail.gmail.com>
 <CAFEAcA8BtVkBbHtLt-kB-AcZnN9YWtBahKTQ0wSvHWojF9CinQ@mail.gmail.com>
 <CAMxuvaxUqrq77_io9j6k7EU91vm7iEEBaTwLNsKd9YJ9NVR7rw@mail.gmail.com>
 <20200808013531.GA166030@google.com>
In-Reply-To: <20200808013531.GA166030@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Aug 2020 16:34:12 +0100
Message-ID: <CAFEAcA__4GwKKe9rY4ut41f-S-u_AnSkdwHvSX0YoaPwjO3ARw@mail.gmail.com>
Subject: Re: [PATCH 1/1] os_find_datadir: search as in version 4.2
To: Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Joe Slater <joe.slater@windriver.com>, "MacLeod,
 Randy" <randy.macleod@windriver.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Aug 2020 at 02:35, Brian Norris <briannorris@chromium.org> wrote:
>
> Hello!
>
> On Wed, Jul 15, 2020 at 11:57:14PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Jul 15, 2020 at 11:37 PM Peter Maydell <peter.maydell@linaro.or=
g> wrote:
> > >
> > > On Tue, 16 Jun 2020 at 10:19, Peter Maydell <peter.maydell@linaro.org=
> wrote:
> > > >
> > > > On Tue, 16 Jun 2020 at 00:00, Joe Slater <joe.slater@windriver.com>=
 wrote:
> > > > >
> > > > > Always look for ../share/qemu then ../pc-bios when looking for da=
tadir.
> > > >
> > > > Could you provide some more context, please? Why is this
> > > > change useful; presumably we broke some setup in 5.0, but
> > > > what exactly ?
> > > >
> > > > I'm guessing this might be a regression introduced by commit
> > > > 6dd2dacedd83d12328 so I'm ccing the relevant people.
> > >
> > > Marco, Paolo: ping? Another user has just asked me the status
> > > of this as they also ran into this regression in what directories
> > > we search...
> >
> > Thanks for the heads-up, I didn't see that bug/mail. Indeed, that
> > commit assumed that either we run from a build directory or from an
> > installed qemu. It seems this is hybrid approach, which I didn't know
> > we supported. I'll check it.
>
> Add one more to the pile! Chrome OS noticed this when upgrading to
> 5.0.0:
>
> https://bugs.chromium.org/p/chromium/issues/detail?id=3D1114204#c8
>
> I'd love to see this applied to a release.

It's just missed 5.1, unfortunately :-(

Marc-Andr=C3=A9, did you want to review it ?

thanks
-- PMM

