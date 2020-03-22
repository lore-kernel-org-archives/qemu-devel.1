Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FDAC1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B960206F9
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zOto86XY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B960206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG7xQ-0000jA-Cn
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 17:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jG7wZ-0000Ef-KX
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jG7wY-0001E2-2u
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:15:39 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:42123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jG7wX-0001Cc-LR
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:15:38 -0400
Received: by mail-oi1-x22c.google.com with SMTP id 13so12765851oiy.9
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NuFeQ3w1a7REoAi7X5IIzzqdfGr+nPTJNgmtPWrk2Vk=;
 b=zOto86XYGlXyQSFyqQgkJ5P7M/R0MHXE9MlJklwcURK3wGeSZg3yz9R+bJ0CAFNXrq
 DxsdkZa0U3JSfyjsV4isze+hJtHrqYnuVX+HO8urgRelNH5HnPpr9RyJ/rmLelK4x6VO
 /4BMJwlBZKFrXLV8zhhBv+JImXZ3CU5aIvd8A10pBN9crsMF34hh/6G8xLzO3uBYa06q
 Nn/nPKy5YtSRhHMK19pccF0L1UKTB3v2NmXjYmkOMGFg6yjSNCTMHuNltPQnWmXZJjBn
 D+mDIjGkJbcmY4Xe4wwjrDFh9QSPeX1pi4+g4HS1s0fFDa2xo8vIgDNniP8hDCh5hNjK
 T5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NuFeQ3w1a7REoAi7X5IIzzqdfGr+nPTJNgmtPWrk2Vk=;
 b=rnnAegj1BE/S6zON0HlCqFoxeRxKnycM4y3HgLGQmoKsutAH82eu+lKVTtXF2hJWC/
 9hgSwSzytQEDohADPsNspm1PoguP9/K+AEh2hFkSdAIEbA1GL022vp59Tau0IRAU4V3d
 N4mJ71xGNC+Hs9AdiKX2Pm4rENOWVzhHHScfuvizP7cflxmaWtB0Q5YOVBx0VbZOsWp4
 OVuDSBz8KlEvG+cY5U1m+Z7b7l4dMK8awNbOboVg94JJj0MoJL386d81VCRDhDPxjd1T
 g1Rt5AAt+5Cix+GwYbdWKQg8GCZF6fXdEE1DSYsRifABeuDMj723pI6vql5BJG1ZSdOd
 V8eQ==
X-Gm-Message-State: ANhLgQ2Jr79RGL+r1ZH8ruzoIggHL0AaDoMZA2SmSXvLAlbYssvDJuB7
 NzrHki9WopgxvHgQ0zbdmanQO7Hzurn9VA0lP6hCRg==
X-Google-Smtp-Source: ADFU+vv6MiUAacKHYUBYJMRzix/5y159n65Oj32GqhUFQDpmHPMSDLgcijVDOae6UpzV2mSKp4Gx5/2XNoeTcUDmQMs=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr4171038oih.146.1584911736508; 
 Sun, 22 Mar 2020 14:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <CAL1e-=gKB0qRxGntXrU0im2gjMh1tq_SLGTm+HsmgBRGXQ9+Bg@mail.gmail.com>
 <CAFEAcA-Yn_O=G-63O1Ug9=HYqN0_o_NH_nLpWmBv2bjk2Y_85A@mail.gmail.com>
 <CAHiYmc4Qv4yL8LMp_nFqx20bq-hRO-umh5R899H6hdSyKrpNBA@mail.gmail.com>
 <CAFEAcA_hfhusu8n8OXLg=vjiMSw09HVy2zhVr=R2hmGdEQJtew@mail.gmail.com>
 <alpine.BSF.2.22.395.2003222134560.60771@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2003222134560.60771@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 22 Mar 2020 21:15:25 +0000
Message-ID: <CAFEAcA_GR__MVOU=LVUuQwnwM23DYxbp4Gi00mKJCoLrxL9j0g@mail.gmail.com>
Subject: Re: deprecation of in-tree builds
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 22 Mar 2020 at 20:46, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Sun, 22 Mar 2020, Peter Maydell wrote:
> > Before you told me about the gprof issue, the *only* thing
>
> Was that gprof or gcov?

Sorry, gcov; I always get those two mixed up in my head.

> Plus potentially any scripts people might use to build stuff and distro
> packagers that might use in-tree build. They would suddently find their
> previously working scripts are now broken and they need to adapt.

It is to avoid the "suddenly" part that we announce in advance
that features are going away :-)  More generally, distro packagers
must adapt for any new QEMU release -- new features appear that
they may need to update their dependency lists to handle, old
features are sometimes removed and the corresponding configure
--enable-foo options stop working, existing features need new
dependencies.

Also, we've been recommending out-of-tree builds in our README
since 2015. They're hardly a new thing.

> While
> making sure running configure; make; make install in source tree even if
> it actually does a build in a new build dir it creates automatically would
> be less annoying change than having to manually manage out-of-tree build
> dirs by those who did not do that so far.
>
> Is it really that difficult to add a CI job to do a git clone then
> configure; make; make install in it to make sure it breaks less often?

To be honest, I don't feel very strongly here, except that
I didn't want us to drop in-tree builds without noting it
in the release notes, and my impression from previous list
discussions was that that was the way the project was heading.

If somebody wants to write patches to cause 'configure' to create
a new build tree that's OK I guess (though I'd be dubious because
I think that hidden magic like that is overall often going
to confuse people, and it's still extra machinery in the
makefile and the configure script). But I don't really see
much point in maintaining two different mechanisms which add
complication and where one of them is just not overall as useful
as the other.

I fairly often see posts from people on eg stackoverflow
who are trying to compile and modify QEMU, and they're
usually using in-tree build and I usually mention in a
PS to answering their question that they'd really be
better off with an out-of-tree build. I think we should
stop making it easy to default to a setup that we don't
recommend.

thanks
-- PMM

