Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099F2C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D1C206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHNuTvQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D1C206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOdnG-0006pH-4y
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOdmg-0006Eq-5L
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOdme-0006Az-NC
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:52:37 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOdme-0006A4-Aj
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:52:36 -0400
Received: by mail-ot1-x341.google.com with SMTP id f52so2630235otf.8
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 01:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=StL/cMMjJ5IslSOjhEF66nL7PCiS9iU4PqVnidvU0yI=;
 b=lHNuTvQDvCZ92UJ7lYJqHaS2SKp3NCkzTLYdtfn6FjfYBIo/ZbOMBYAe5FvcyMUdMD
 AOs3Z+mwR9boYBO8/2MecOkEj0N0eRoci0ah4aD1Z6gGbbKbKG/GF72IUIh5/PupCwRZ
 92xabGdCkM4Yo9l5n0yBTKeoWqVXv5Ck5Mf6+NWaO4BeSsNhpMSs75XzSOMTjnBs88mA
 5LzWUbs2gn+ZcVe4QlPmMLCZWgD4Zdhtpvab6Y3IQG5ML6ZBuF2KM5x5j16S4dcKAnkU
 Op5yyyyCWqB/y7lNQfxv0mRnpJadj2vQjYDm5LqA81vq9FdJ1xudQTLw8IOjrsB464dd
 bOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=StL/cMMjJ5IslSOjhEF66nL7PCiS9iU4PqVnidvU0yI=;
 b=IbvsFCjha/knISJGMOMaMMqnW6BJ157jyYH3AFnlSG7IOirAi+8Mv5jXt8IemdgGWR
 bTej5AmLZiApaqLsElwAM3fgRcigbUvJjkL3DFFy4+e1FefOPKH5Ob3akCWesZNU8jbt
 KmNaTXZaRYaUgqTf9MgYsqnvFWoeh4g3rY7fTxQKdfSQduSZzVn072BV6jOAdzmunm+X
 l3sC/1cg8kZpky+S14s//Bupy2YyuW06N03wB/KUBYPRZSSQhaaJUDCIM7jBFJ3mk/cj
 mQ6zxxmVM4nrPV5sRG7HkYJWfOLMej8w2x9g82LbV1J7uztKNJ36hLm5FJe2GL4uyPEo
 OH6Q==
X-Gm-Message-State: AGi0Pub4EtKZdmupTyN6DGYZwIkAErlY6MiphTKYfHbGWoJGjvT8myei
 kK9D2H2Ci+7o2AMGeFfiBvH0baGtvGNuyEGmjdnw6w==
X-Google-Smtp-Source: APiQypIaikqAvQ/igkvIrxKl0bArXMMmxTJ4XhHxaYBV+wgr77Flb9SYaVtOcqocoFoU5VTNjmvLzivGFgYyDyHYICY=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr3445572otj.91.1586940754865; 
 Wed, 15 Apr 2020 01:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200406153326.806024-1-berrange@redhat.com>
 <CAFEAcA8rXBty2tHZOoqQA+mEcxEYiBntjeKj07-NUiPH+NWxmg@mail.gmail.com>
 <87zhbdl1ip.fsf@dusky.pond.sub.org>
In-Reply-To: <87zhbdl1ip.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Apr 2020 09:52:23 +0100
Message-ID: <CAFEAcA-nCr81nkrtsncpqKkwe-D22smTdD4cG7SD-svnMNw56g@mail.gmail.com>
Subject: Re: [PATCH v5 for-5.0] configure: warn if not using a separate build
 directory
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Apr 2020 at 07:13, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Given where we are in the release cycle, I think this isn't
> > going to go in for 5.0; and it's not really that urgent now
> > we've decided we don't want to actually deprecate in-tree builds.
>
> Have we?
>
> We had a Aleksandar assert that out-of-tree builds can't do certain
> things, which led to the decision to soften this patch's warning from
> "deprecated; better use the grace period to adjust, and here's how to"
> to "not recommended; here's the recommended way".

This is not how I recall the discussion. The reason we decided to
soften this patche's warning was because there was a sizeable
contingent of people who said "I want the basic './configure; make'
commands to keep working and am willing to write the wrapper
makefile that wil cause those to automatically create and use
a build directory under the hood". If the commands will keep working
then there's nothing to deprecate.

("Stuff doesn't currently work with out-of-tree builds" is something
that I argued at that point in the thread was definitely not a reason
not to deprecate.)

> Whether we want to keep sinking time & energy into an extra way to build
> will become irrelevant once we move to Meson, unless Meson deviates from
> its "this is an opinionated build tool, not a 'give users all the rope
> they may possibly want, and then some'" approach in a surprising lapse
> of judgement.

And Meson is the other part of this -- if Meson is coming soon-ish
and will mean users having to change their build commands in some
way anyway, it's better for them if we only make them change once,
when Meson arrives, rather than once now and then again later.

> If we can't reach consensus in time for 5.0, that's regrettable, but I
> accept it.  Our decision making process is open and slow.  Hard to get
> one without the other.
>
> Much harder to accept is us once again defaulting to do nothing because
> deciding what to do involves a tradeoff.

My understanding of the consensus position was "we should stop
supporting in-tree build in the main makefile machinery but should
have a trivial wrapper that creates and uses a build directory
under the hood if the user does run configure/make from the
source tree". I think that should be much less painful to maintain
than handling both setups through the whole of our makefile system.
(I wouldn't personally bother to implement it, but several people
volunteered to do so.)

thanks
-- PMM

