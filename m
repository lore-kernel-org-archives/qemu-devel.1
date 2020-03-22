Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E60C4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 20:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A120206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 20:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLGYregA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A120206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG70L-0008KW-EH
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 16:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jG6zX-0007gc-7P
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jG6zV-0001Uk-Df
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:14:38 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:43739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jG6zV-0001Ty-36
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:14:37 -0400
Received: by mail-ot1-x334.google.com with SMTP id a6so11296288otb.10
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 13:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0OKjznXIQq39G5WV8wDKjOLj8w++VwuhSW5jB0pD0JE=;
 b=VLGYregAPZ+OPXXnmNe8XMkv9NttHl18O6/3K/neNUHj6Mrq5Qw4BoemB7CCLXxZmR
 RCpeEKo1ENvM3k17L/G8fIHO6m84WaoIiygOblL9wYkjhAFLqlx5/wsjTQgPNNQKL5q+
 Gcs8ohSoQOHqg/uYa5vBbSnsIPA+kaFGO6+qoMrzzPDwjZm/JhzBM46ha6UOKeP4c4CN
 IOueshmIPIoZjutD1rAv9SmR2dd1sgv+u5CCfEGj1at989LiluJW5Fn2kbSvjywovYYr
 TyarWDf0c4k1CoLfaNDwJskIZ0NETjK+JfMM3BsrafmAlEUrFKf+GDQH6W2qeM0S8WzL
 NlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0OKjznXIQq39G5WV8wDKjOLj8w++VwuhSW5jB0pD0JE=;
 b=jXTnQzp+Fisy+dE6O83bF3GCV2rrTEjS9/zOF1V9GsY7xrtBfQatkQ0TTUOx95edr1
 hCLijFSRj130mkJ7pSv2Ctxk+2QaIQbz5128pNOoZPCddLFy4DAHiIFMXtm1+BHjbx+i
 Ofs3nh3gtjQO03FIyib3dF9F7/B88uPYUS2H39LXMISRAzarLMNh0kHL/a+JLTjCPhFN
 a56QWK/O9XONUx9NY/FBn9g8CUkfw7qhRCYdfMr86cQpxnMgcA5E03D/3BjGaPH1lpsP
 8s6PWO6/5JC8WojPKwNiB/S7JhVFxVVJ+L+BZb2KyjgmOSCfyqZp7no+U26j8XN6UbVZ
 hOdA==
X-Gm-Message-State: ANhLgQ18q/tydU1NOv9a3olih+VQb2Zc41OjGLcDQAhvOc2Ro4ECFGEq
 8cfiFSgkg2ZZ8LsvgJCXZ0nT3CwhWOhXoG0LsWHcyw==
X-Google-Smtp-Source: ADFU+vtImPb7liZV14qPhnrakv6pyIcCCJtsGWilC5lmhQzz7R9ZSTmzsRfrrs1tZyaCC4kZtzjKKmqEzcI5Mf7ZlmY=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr386042oth.135.1584908075821; 
 Sun, 22 Mar 2020 13:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <CAL1e-=gKB0qRxGntXrU0im2gjMh1tq_SLGTm+HsmgBRGXQ9+Bg@mail.gmail.com>
 <CAFEAcA-Yn_O=G-63O1Ug9=HYqN0_o_NH_nLpWmBv2bjk2Y_85A@mail.gmail.com>
 <CAHiYmc4Qv4yL8LMp_nFqx20bq-hRO-umh5R899H6hdSyKrpNBA@mail.gmail.com>
In-Reply-To: <CAHiYmc4Qv4yL8LMp_nFqx20bq-hRO-umh5R899H6hdSyKrpNBA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 22 Mar 2020 20:14:24 +0000
Message-ID: <CAFEAcA_hfhusu8n8OXLg=vjiMSw09HVy2zhVr=R2hmGdEQJtew@mail.gmail.com>
Subject: Re: deprecation of in-tree builds
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 22 Mar 2020 at 19:52, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
> If an end-user feature works only in in-tree builds (so,
> explitely said: not in out-of-tree builds), this is not
> a build-time stuff, but user-facing feature issue.

gprof is a developer feature, not an end-user-facing
feature. By the latter I mean "some feature that users
who have installed a built binary might be using":
command line stuff, actual functionality in the QEMU
binary, QMP protocol, that kind of thing.

> If someone is keen on removing any feature (as is truly in this case), I =
expect at least some moderate investigation being done on what could be aff=
ected (prior to announcing deprecation), rather than attitude "ok, let's an=
nounce deprecation, see if someone start clamoring, and, if not, we are goo=
d to go with removing". For me, this slightly disappointing.

Before you told me about the gprof issue, the *only* thing
I was aware of that might break was the coverity scan build,
which is a purely project internal bit of infrastructure.
From my point of view, we did the investigation, in the
sense that for years we have had out-of-tree as our standard
recommended way of building QEMU and the thing we test
in our CI. Anything that breaks out-of-tree is by definition
something that fell through the gaps in our CI and which
we couldn't know about unless somebody tells us about it.
The "announce deprecation" part is the final part of the
process, and sometimes it does, yes, result in somebody
saying "you missed this thing", because we know our CI
is far from perfect.

> I haven't seen anyone doing a sufficiently thourough analysis
>on what happens without in-tree builds, and doesn't work in
>out-of-tree builds in a proper way.

*Everything* is supposed to work in out of tree builds.
If it doesn't that's a bug -- unless people report bugs
we'll never know to fix them. Most developers use out
of tree builds and all our CI is out of tree builds, so
they actually get better ad-hoc and CI coverage than
in-tree. Out-of-tree is overwhelmingly what we build and
what we test, so it's in-tree that breaks more often and
where I'd expect to find more things we didn't realise
were broken.

To be clear, I'm not saying we should pull the rug out
from anybody. I'm saying:
 * we should clearly say what our plans are, with a
   long warning if we can reasonably give longer warning
 * if there's anything that we would accidentally
   be breaking with those plans, we should adjust the
   plans so we don't break things we didn't mean to break

This doesn't seem controversial to me...

thanks
-- PMM

