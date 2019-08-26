Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA9CC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 21:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B53A21872
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 21:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cKdPB7au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B53A21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2MHd-0001LA-EN
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 17:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1i2MGW-0000hf-HS
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 17:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1i2MGU-00063v-PJ
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 17:11:04 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1i2MGU-000624-GZ
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 17:11:02 -0400
Received: by mail-pg1-x544.google.com with SMTP id i18so11321171pgl.11
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z8ZIExFHtrlKt7DHcnRJlAw2R9efWUXORN53HJrWQMo=;
 b=cKdPB7auUFwld61wp0mwxwO0cvr++TE8t/Gbmh9rISkfSr5fiJzQvZGGaXse2GCLDN
 Ubyp4Nm0mp9eONSjbjZyrCVF3YsyWq0J2LVzF3Jll0NEmUVcP4gaxL7jmVT1cNrU9K5R
 6kNdaiRru/1AU88aSPbylC3hbdUqO0Z9+37idDrx7qS3DOZvRNMUb2nCcbocBpyN6HVx
 GUQTBmIPhR5OiI9LF/Dc0m2dmDvI9GAb+xgChsPIX7EOTMaNamcvme4IVQZ4f5PC+aBe
 HChp53Sz4paSko7jdSVexZhfzGU0Wia5PWJRTHW6ebFHtG0RxvFICZrrorS5JczI9Cmt
 sY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z8ZIExFHtrlKt7DHcnRJlAw2R9efWUXORN53HJrWQMo=;
 b=RYy6V1v2t5F3/90/ZsSns4bdSevsuYDTi1t8h0gKG+wD1NPWgIF4zdl7DMXeddqOXx
 MzphOSj8TP9DWcV5Fl9UF+KNDytKi/fzLgJlB0vg3j+RsF2L9fe2s2HmehAIvZ7GPP+D
 jnGdZUK9fbcHisRGdcgiWj8QW2YrQPIwMxO/MmVrC6vCfF0nJVxKOaWrja200sj+doCR
 FHWvafwpQkBo6UJdJ7JWP3NynDI+ojOEZEMzPDspjpxSEDFqvAx6R/kR7RNVAZEXGcwm
 65evFP0CENVRaomToiviHcs8izjxXHsqyy6By7YRNm/IimS2pX38F9WBKjWkvFD6ebMk
 HTdg==
X-Gm-Message-State: APjAAAXTaa/HdgkvnmyHlHi8lBHa/QyLpHVqa/THMbm6x0JO2ApTVwMe
 D9146EgDIS4vsPoGJfor3q0EEEHAs67GLW1OQ/01sA==
X-Google-Smtp-Source: APXvYqyaDO6+AT99PLb3/AhO/c3C+gmncs7UQtnkvhT7sf4SrGLRO5s2T5lOxp2QwlRudWRzkunwnC76jHkMWxsG04Q=
X-Received: by 2002:aa7:96b3:: with SMTP id g19mr21578265pfk.26.1566853857932; 
 Mon, 26 Aug 2019 14:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <CADgy-2vznasvwaUwNSi96Sy=ucPC=-3e=O9irqc5DSpV_uhWUg@mail.gmail.com>
 <abf5f3b6-7c05-a85b-051f-9905b8f50041@vivier.eu>
In-Reply-To: <abf5f3b6-7c05-a85b-051f-9905b8f50041@vivier.eu>
Date: Mon, 26 Aug 2019 14:10:46 -0700
Message-ID: <CADgy-2va2xVmO_a1gDwg+zkpNcLJTW5D1j=2kk1TnRMxyPaLMg@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and SIGRTMAX - 1
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
From: Josh Kunz via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Josh Kunz <jkz@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 riku.voipio@iki.fi, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, marlies.ruck@gmail.com,
 Aleksandar Markovic <amarkovic@wavecomp.com>, milos.stojanovic@rt-rk.com,
 Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 2:28 AM Laurent Vivier <laurent@vivier.eu> wrote:

> Le 19/08/2019 =C3=A0 23:46, Josh Kunz via Qemu-devel a =C3=A9crit :
> > Hi all,
> >
> > I have also experienced issues with SIGRTMIN + 1, and am interested in
> > moving this patch forwards. Anything I can do here to help? Would the
> > maintainers prefer myself or Marli re-submit the patch?
> >
> > The Go issue here seems particularly sticky. Even if we update the Go
> > runtime, users may try and run older binaries built with older versions
> of
> > Go for quite some time (months? years?). Would it be better to hide thi=
s
> > behind some kind of build-time flag (`--enable-sigrtmin-plus-one-proxy`
> or
> > something), so that some users can opt-in, but older binaries still wor=
k
> as
> > expected?
> >
> > Also, here is a link to the original thread this message is in reply to
> > in-case my mail-client doesn't set up the reply properly:
> > https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg01303.html
>
> The problem here is we break something to fix something else.
>
> I'm wondering if the series from Aleksandar Markovic, "linux-user:
> Support signal passing for targets having more signals than host" [1]
> can fix the problem in a better way?
>

That patch[1] (which I'll refer to as the MUX patch to avoid confusion)
does not directly fix the issue addressed by this patch (re-wiring
SIGRTMIN+1), but since it basically implements generic signal multiplexing,
it could be re-worked to address this case as well. The way it handles
`si_code` spooks me a little bit. It could easily be broken by a kernel
version change, and such a breakage could be hard to detect or lead to
surprising results. Other than that, it looks like a reasonable
implementation.

That said, overall, fixing the SIGRTMIN+1 issue using a more-generic
signal-multiplexing mechanism doesn't seem *that* much better to me. It
adds a lot of complexity, and only saves a single signal (assuming glibc
doesn't add more reserved signals). The "big win" is additional emulation
features, like those introduced in MUX patch (being able to utilize signals
outside of the host range). If having those features in QEMU warrants the
additional complexity, then re-working this patch on-top of that
infrastructure seems like a good idea.

If the maintainers want to go down that route, then I would be happy to
re-work this patch utilizing the infrastructure from the MUX patch.
Unfortunately it will require non-trivial changes, so it may be best to
wait until that patch is merged. I could also provide a patch "on top of"
the MUX patch, if that's desired/more convenient.

Just one last note, if you do decide to merge the MUX patch, then it would
be best to use SIGRTMAX (instead of SIGRTMAX-1) as the multiplexing signal
if possible, to avoid breaking go binaries.

Thanks again for taking a look at this issue.

Cheers,
Josh Kunz

[1] http://patchwork.ozlabs.org/cover/1103565/
