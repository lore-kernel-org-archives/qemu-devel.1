Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7FDC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9065E20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9HOCs6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9065E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaXK-0006O4-Oe
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaWb-0005vO-2W
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaWZ-0000bf-TH
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:58:52 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHaWZ-0000aj-My
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:58:51 -0400
Received: by mail-ot1-x342.google.com with SMTP id c9so7632642otl.12
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VpA+MTR0hU2CVFAffSAMw46wA6WHYIW3H0aK+pyev2A=;
 b=y9HOCs6tQ8nBWSHamCUwlzXSI54Z3BiQsTlI6ve55pirUphO/UZCwa9FaTUzzYAKzp
 wmzoaKHvZ2fzbxe4heU0NMN6VP4IOxDHOLmdCRRYczCErPHR5ZOxuueGBJY3uhV7oEJL
 C9ht7X296lUvJWLCg5GV5H/dT3kAtunMf+uBkQpYraoLod0ctlkGxx230zK6MeWsRFzq
 PInORWnGwJcWK+QM5h6CY6AvSb+KP277y/5EBWP0RC5owHxtBooakl23CidPrnYTkk5K
 mrjDaXwaycUgedq7UJ590iUBwI9TwqYDAIi1W4uVCK8qdkYZsKoLQh2RbvdQrY/3gXdx
 flGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VpA+MTR0hU2CVFAffSAMw46wA6WHYIW3H0aK+pyev2A=;
 b=fuUNtt2XjhSSrk84qBoR6w21Ta0SlcGfygCEqUUjvMxxbCIwn1InkKdLWf4tlDJ+RK
 ZqHd45zB6LuHq671byYx+hyHhLHNf8caTGm6lo3WQDJwZEcdWhHjH77RGU8oPbOQko00
 JahivqNXS7YkChX7qFlatRZgJOSJVqOax0aV1Cv+gcHxuJ5HxLY5KD/38cLaqZba8L/A
 J+CsmF9VWLKpt9AoxWjtlMSDhIXTOGdKD/OsDGlvKrC7NF1/ZeJzI69+y+f8fHUbPqnr
 Uy8oGUiWwpYAcpy9+dc7O0sQXvMFAb/p/l3ceyg3A88S23SR0xOFmeK94BM90w7XW4A7
 8jFg==
X-Gm-Message-State: ANhLgQ080R5SP4XLVQ/7cDF3GxhV0/cyLQn0cgbH17/jCpj26TgkMM16
 ADQgzNEe5XzYlMj++HiQSpU7U6Uwp9YnkVtoGYdPZQ==
X-Google-Smtp-Source: ADFU+vtjdsCeRfv91ofH9QsnkGhor0D22HBe6qiPCZ/KMYmEYuSICgGVIp19eH1Am6DgHaWE32Y2ATpAdMU5r7B2J6I=
X-Received: by 2002:a05:6830:18f4:: with SMTP id
 d20mr5453583otf.91.1585259930738; 
 Thu, 26 Mar 2020 14:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200326072352.2056553-1-laurent@vivier.eu>
 <CAFEAcA92zU5Dy9mZNTv1KtO_ApVRXvdxBZh1wsNGEyWAxAeLKQ@mail.gmail.com>
 <8a0be652-78fd-a016-dde1-3cd0f6769a9d@vivier.eu>
In-Reply-To: <8a0be652-78fd-a016-dde1-3cd0f6769a9d@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:58:39 +0000
Message-ID: <CAFEAcA-zZMj5YqQ6E9Sm1Gsi++RK3fmHO4S+bXHG5k+AHQi6YA@mail.gmail.com>
Subject: Re: [PULL 0/6] Linux user for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Mar 2020 at 16:43, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 26/03/2020 =C3=A0 16:42, Peter Maydell a =C3=A9crit :
> > On Thu, 26 Mar 2020 at 07:24, Laurent Vivier <laurent@vivier.eu> wrote:
> >>
> >> The following changes since commit 736cf607e40674776d752acc201f565723e=
86045:
> >>
> >>   Update version for v5.0.0-rc0 release (2020-03-24 17:50:00 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-reques=
t
> >>
> >> for you to fetch changes up to a52f5f87bece827a338d6eb3332e3def86fb9c3=
3:
> >>
> >>   linux-user: Flush out implementation of gettimeofday (2020-03-26 08:=
08:54 +0100)
> >>
> >> ----------------------------------------------------------------
> >> Emulate x86_64 vsyscalls
> >> Fix syscall_nr.h cleanup
> >>
> >> ----------------------------------------------------------------
> >
> > Still fails :-(
>
> I would say it was expected...
>
> I think your build dir is corrupted by a previous build.
>
> You should have old .o file without .d file, and thus the .o file is not
> refreshed (check the date of cpu_loop.o). We cannot cleanup that before
> starting the build. The purpose of the cleanup in configure was to avoid
> this kind of problem but I did it badly.
>
> If you want to check incremental build, cleanup your build dir, checkout
> v4.20 or master, build it, and then build the PR branch. it will work:
> it's tested.

Seems like it. I blew away and recreated the build tree, did a build
with master, and then applied this pullreq with my usual process
(so incremental build from there), and it was fine.

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

