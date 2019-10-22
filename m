Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6559CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 05:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900552075A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 05:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bROnbmHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900552075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMmdR-0004nJ-QY
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 01:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1iMmcQ-0004Ib-Sl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 01:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1iMmcP-0001Dq-6N
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 01:22:06 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33419)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
 id 1iMmcO-0001DP-UB
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 01:22:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id s1so7645771wro.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 22:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZYOxxP50io5lpq8ssBTLBHQEwXkdhKjah0kpaP00H9g=;
 b=bROnbmHfINc7kTaUffVc5dtWcLXKlwVcF7GgzQGaNblJG4yylxdmtoXlkOdt3MdzSL
 tZVjeUpR022aRNLTjGkk9otiR6GCs488zQzP9i0j/tyoIRCE7qzY7xv1dweF0IqZK9Br
 qCVzqLyOW/XRid8dTD3qzWDylwBYfeKJH75ie4Vea4K+8FPMzngMyUCqgLlr3Ueczf+7
 V86ihVmlx2SNOCiQzstBnsAVCkPODx3rs8ugzIrx62me+LArwSRV8GiJ901o50pt5IhY
 1F3Pi1Qgx+cCpOaeINTfllUxeuyXONYyHjUJ3pFx+mMHhh68IL7UsvehM6MbVNv+q37w
 uudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZYOxxP50io5lpq8ssBTLBHQEwXkdhKjah0kpaP00H9g=;
 b=NL8Ai7Ws56FjkeIsmTx//Ut7vxjqCMGhOeyNlsTPuQhP6HHKgZ0GGIrfxZh79N5SV6
 mQfmcX0we9tGeCqRJE0UVXbix1gQZV/zSLZitcjfYiNnEsCMzOfYFhYWhDyAG8XqCkzC
 h0Eo1HgrxybOmylSJ3c9TRIKfS0wUMG7ms276sZoEpLGwtadFDII1OGxElnhWWvKBhfC
 JM6G6fIGA4pYQEHYgTsg/1RR0uS/EuhfqFrmmifXjdLozinmRupJsayptF0A57xbVq5e
 G2zIIBtqHXDwmVzk1s6YSB32XV9j/v60INTqyzwz8zCC5Dh+urf5doTUuzts48V38iLh
 4ozQ==
X-Gm-Message-State: APjAAAWq7Ak1+oPQnMbZfUN21XdmhwtodE/c7Hg33qMagKI6/DfATM6h
 QvXJB9TcDOwr1CUh+jc8PadrgjTiA3AyPSYWjRmL1g==
X-Google-Smtp-Source: APXvYqwfB9A1hWxgO9Z8qjHBMAT9HGQzJCM0yiguWj6fLo/1CzACt6+a+b9Xt9FJBmFb72nGsleoRRMQUVYE1U23t5Y=
X-Received: by 2002:adf:fd88:: with SMTP id d8mr1514082wrr.200.1571721723118; 
 Mon, 21 Oct 2019 22:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191021145839.12684-1-peter.maydell@linaro.org>
 <06e15851-0b4e-63c3-001d-dd7ea5855872@linaro.org>
 <5dc0737a-f1b0-24aa-015a-1806a6d61e69@redhat.com>
 <CAKv+Gu-QkvyLoJ6jW7eMm48hKKO9pf6r53m6Qi1cvCDt9WJx5g@mail.gmail.com>
In-Reply-To: <CAKv+Gu-QkvyLoJ6jW7eMm48hKKO9pf6r53m6Qi1cvCDt9WJx5g@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 22 Oct 2019 07:21:57 +0200
Message-ID: <CAKv+Gu-pv-dP1yTTU8q5AUgidH8E6UZESUZFvyE2sLrOQsQibQ@mail.gmail.com>
Subject: Re: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
To: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(uses Alex's working email address)

On Mon, 21 Oct 2019 at 21:52, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Mon, 21 Oct 2019 at 19:57, Laszlo Ersek <lersek@redhat.com> wrote:
> >
> > (+Ard, Alex)
> >
> > On 10/21/19 17:52, Richard Henderson wrote:
> > > On 10/21/19 7:58 AM, Peter Maydell wrote:
> > >> Since 2008 the tcg/LICENSE file has not changed: it claims that
> > >> everything under tcg/ is BSD-licensed.
> > >>
> > >> This is not true and hasn't been true for years: in 2013 we
> > >> accepted the tcg/aarch64 target code under a GPLv2-or-later
> > >> license statement. We don't really consider the tcg
> > >> subdirectory to be a distinct part of QEMU anyway.
> > >>
> > >> Remove the LICENSE file, since claiming false information
> > >> about the license of the code is confusing, and update
> > >> the main project LICENSE file also to be clearer about
> > >> the license used by TCG.
> > >>
> > >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > >> ---
> > >> This patch takes the simple approach of just documenting
> > >> the de-facto current reality; does anybody want to argue
> > >> for something else? Other possibilities I guess would be
> > >> specifically documenting tcg/aarch64 as an accidental
> > >> exception to the general licensing rule for tcg/, or even
> > >> trying to get it relicensed.
> > >>
> > >> Does having tcg/ be BSD-licensed gain the project anything?
> > >> From my point of view I don't really see it as a cleanly
> > >> separable module of code -- it's quite tightly integrated
> > >> with the rest of QEMU, including code in accel/tcg which
> > >> is variously GPL or LGPL.
> > >
> > > I think this is the best solution.  I've never been convinced that TCG can
> > > usefully be extracted and reused for something else.
> >
> > Side comment:
> >
> > Ard and Alex extracted TCG to run x86 PCIe UEFI option ROMs on aarch64
> > hardware.
> >
> > https://github.com/ardbiesheuvel/X86EmulatorPkg
> > https://kvmforum2017.sched.com/event/Bo0S/qemu-in-uefi-alexander-graf-suse
> > https://www.youtube.com/watch?v=uxvAH1Q4Mx0
> >
> > If I remember correctly, they specifically picked a git commit hash that
> > was still purely BSD licensed.
> >
> > FWIW,
> > <https://github.com/ardbiesheuvel/X86EmulatorPkg/blob/master/LICENSE> is
> > not any BSD license, so I'm almost surely out of date on that aspect;
> > just wanted to confirm that TCG has been usefully extracted.
> >
>
> This commit has the background info
> https://github.com/ardbiesheuvel/X86EmulatorPkg/commit/552c44d2cbc778f3e53d6d3985a8787c7df99733

