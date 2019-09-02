Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79648C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 13:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451CA21882
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 13:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codyprime-org.20150623.gappssmtp.com header.i=@codyprime-org.20150623.gappssmtp.com header.b="B4DMUfDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451CA21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codyprime.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4mFM-0003h1-E4
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 09:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jeff@codyprime.org>) id 1i4jgh-000093-BD
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jeff@codyprime.org>) id 1i4jgf-0004Xc-VB
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:35:55 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jeff@codyprime.org>) id 1i4jgf-0004VP-HN
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:35:53 -0400
Received: by mail-lj1-x241.google.com with SMTP id h3so5553920ljb.5
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codyprime-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FM6ZJLlJRM5u33MEB9CGkhMZke21GuuxxpB1m2wcl8Q=;
 b=B4DMUfDS/ok79QAB00d82Sqnu2kuWHlOTao5oPFdxK7LepLYI4juv+IfEYSiJ/uM1/
 pMsCRpB1/ZU22+fQ7X5BnmBHICpvfsPb3+N+0CKk1kgS612Z+tNtStzGzKuwOvbIS7To
 pzLSx+zf+lCbixMHjZOAVC/x03tv7w+MmLRbkDbRFoGN0SlxXQoF+mVvNJkaL/BtuYtH
 EPrPiCZ9VC/fGZLNyMiGPUqRr7mr8WC7bYmQ7LdnGH2a9h5KcyfT9xQkciyPBK9nFAvf
 1Ua47tjaBLwMAAkS/ofJFIgKKRjL+EPQTZllbi4EfgVelk2ygz/XHgiI8xohTAPQZiud
 ccXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FM6ZJLlJRM5u33MEB9CGkhMZke21GuuxxpB1m2wcl8Q=;
 b=MD3gxZeg+/9cY3lfo4My/eOpT30BcRBF5e7/rNCh1twXT0EaXxp6ytJPDvuDJ9PzqO
 bRzl9A10DDD0KaNCDmVOTlX3aMorq1h28igci4ApbHCSU4zTQ2x2f79dCqbzfVbm1XAx
 y9lUXI2uJ2QZdra/S1gH8wa615/Rr+rOe1g3GJrKg14hBtmeF6ajfT/ohCKwB4irqws9
 ufRpFP229SwvWvxw6wTmBiNqhs76gPj//lpO4Aoh2YUidqn2uVxoRzmibZWnC8/WcsEk
 PAyWEMASHcecEztOFDclLaC8eABlXURXsn7Vcl6ooX1u8RGM0k+dMGv19d0G5LOoIIi5
 0HKQ==
X-Gm-Message-State: APjAAAUgBdulrFoXeWjsmhAjBEs5dN0Cz3OivMMOs5BJz4q39TISFnXT
 Bllo8HtrAuQqzyW4dHYXoWrXskHCu5ZCSKeKCg7juA==
X-Google-Smtp-Source: APXvYqzDHFyWXYUrZflI90oJLimNGVJpgaJlmMvzurFbybJVAl0rc4RtmnLIiLnueYG553401Yi5vX1UBEKmPAsMjec=
X-Received: by 2002:a2e:3109:: with SMTP id x9mr7836685ljx.19.1567420551411;
 Mon, 02 Sep 2019 03:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190829154851.GA26717@stefanha-x1.localdomain>
 <3fce8d5a5fcccbff8f27f681eb685167d2c0845f.camel@redhat.com>
 <20190902092509.GC9069@stefanha-x1.localdomain>
In-Reply-To: <20190902092509.GC9069@stefanha-x1.localdomain>
From: Jeff Cody <jeff@codyprime.org>
Date: Mon, 2 Sep 2019 06:35:40 -0400
Message-ID: <CAGwXPVpN0ndzAEpDtV+-mAgmGZOv5gL2_=5sBka0iHRg6drCrA@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
X-Mailman-Approved-At: Mon, 02 Sep 2019 09:18:00 -0400
Subject: Re: [Qemu-devel] git.qemu.org gitweb misrenders on git/ URLs
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 2, 2019 at 5:25 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Thu, Aug 29, 2019 at 06:13:34PM +0200, Andrea Bolognani wrote:
> > On Thu, 2019-08-29 at 16:48 +0100, Stefan Hajnoczi wrote:
> > > Hi Jeff,
> > > Philippe noticed that the git HTTPS clone URL
> > > https://git.qemu.org/git/libslirp.git renders a gitweb page that looks
> > > right but has broken links.  The correct gitweb URL listed on
> > > https://git.qemu.org/ is https://git.qemu.org/?p=libslirp.git;a=summary,
> > > but there's a chance that people will open the HTTPS clone URL in their
> > > browser and expect to see gitweb working.
> > >
> > > Is it possible to tweak the Apache configuration so that
> > > https://git.qemu.org/git/libslirp.git[/] redirects to the working gitweb
> > > URL?
> > >
> > > The tricky part is not breaking HTTPS git clone, which accesses URLs
> > > below https://git.qemu.org/git/libslirp.git/ :).
> >
> > I know that's not quite the answer to your question, but if you look
> > for example at
> >
> >   https://git.zx2c4.com/cgit
> >
> > you'll see that the same URL can be used both for viewing with a
> > browser *and* cloning.
> >
> > Basically with cgit all requests go through the CGI script, and an
> > advantage of that is that you don't even need to call
> >
> >   git update-server-info
> >
> > to make the repository accessible via HTTPs. It's also pretty fast
> > and extremely easy to setup. Maybe consider switching from gitweb
> > to it?
>
> Thanks, switching to cgit is an option.  Let's see what Jeff thinks.
>

Hi Stefan & Andrea,

I'm not familiar with cgit, but I am happy to investigate it as an
option if it looks to be a better fit.  I can't get to it until this weekend
however (Sept 7), as I'm traveling right now.   Is that soon enough?

Thanks,
Jeff

