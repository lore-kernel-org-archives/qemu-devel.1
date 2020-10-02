Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FF4C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C3520644
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJNpL5XI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C3520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKKl-00055u-N2
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOKII-0002Ip-71
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:36:14 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:42144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOKIE-0006cU-Ll
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:36:13 -0400
Received: by mail-ed1-x542.google.com with SMTP id j2so1457826eds.9
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z1MGB7e7iKO9Iof+fHKLrEADbXc8otwFgEoTiN8RdEs=;
 b=wJNpL5XI0DYUQPokkb3KXSs83dG8hKfRFsg1xfN6kGMPm5WetlAVeUBmB8PkFTPbw+
 o+Xn4ABpf9/GDYgncAkCe6KcKa5myJaf+SGPXvjY0EnVUsaJLbw8uZl19Aw1VO0hk4Sb
 qfgpRszpvtzKdIsdr7rnLXYdcnIWUt0R43bDv73v42yr/7wyTdoWXrs/45ktIW/3Zvhi
 tSxZVxIwATIXQKBCsPLsqTf5qIhs+nuAbuwAhmzsN+bltCBQ0LCwYDf2YjaOc55mXDPC
 mY4l5dwggu+Bo3eBHv3KMwI+r+Aqho/7sDzn1iervC/8cBnQHxnOJ2FUBUjJMXvN4n6u
 5XhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z1MGB7e7iKO9Iof+fHKLrEADbXc8otwFgEoTiN8RdEs=;
 b=qP6CxrjrrNtzfa7ICNIdgrgCd86rXrcfBzpGFZbzsPa26FVgMlkBNI/+SaXeu7/yMs
 Dgye8OxWXUXtXQXTKqSMzoJJVKgAnfj8eVcnHrHt9sewp6PI3Sobh/ag2kN5FagjtVwW
 YSM2Ga4MjL4KS6A/4sJDzF+GymBFcCoHu7oj7dApeuEvrZmJMtD/ra8rTO1kACVTBpsG
 OlT+bZjuKmQdmBJUZNgp7wykCM9eEL099gfg2t3q5y+PE0JGA5INORJ7bz3ekBX8Fl+t
 pjpIwzwnxP7jayjSEdh7FqslFCQOh8u5PaExP7Cozs5A24czZjEJNoOtx1jpYMJgtmoc
 iEzw==
X-Gm-Message-State: AOAM531A5dae0i7j6CYkXP9R5vjoIgFztlJHDICXh5u3mxmrSlx12lSY
 O3VUCoII3XUr+QsgOSDBmitDV3eFVNPrsCHw9nNB/A==
X-Google-Smtp-Source: ABdhPJyvgOLbhf2J1lol8SnE8icQP506VtEOJ0QJatpoHvbjCZFBKjg8hGnmSaK+wo8/wLz0St14eRCs+u3zGNKwcBo=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr2153957edm.100.1601642168977; 
 Fri, 02 Oct 2020 05:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
In-Reply-To: <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 13:35:57 +0100
Message-ID: <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 13:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/10/20 12:52, Peter Maydell wrote:
> > commit f01496a314d916 moved the logic for detecting libudev from
> > configure to meson.build, but in the process it dropped the condition
> > that meant we only ask pkg-config about libudev for a non-static
> > build.
> >
> > This breaks static builds of the system emulators on at least Ubuntu
> > 18.04.4, because on that host there is no static libudev but
> > pkg-config still claims it exists.
> >
> > Reinstate the logic that we had in the configure check.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> I don't think this is a good idea.  Having a completely new build system
> also lets us notice all these weird one-off tests, decide whether they
> are worth being kept (like the SDL -Wno-undef workaround) or not, and
> possibly come up with a policy that avoids having to make one-off decisions.
>
> If "../configure --static" worked and now doesn't then it would be a
> clear regression, but a one off check should have a bigger justification
> than "39 --disable switches have worked so far and 39 < 40".

My configure command line used to work and now it doesn't.
There is no workaround that I'm aware of that I can use
by tweaking the configure options. That's a clear regression.

> Here are three alternatives to the patch:
>
> - the workaround: just leave things as they are and add
> --disable-libudev to your script.

There is no --disable-udev ! If there was I'd just have
used it.

e104462:bionic:static-sys$  '../../configure'
'--target-list=arm-softmmu' '--enable-debug' '--static'
'--disable-tools' '--disable-sdl' '--disable-gtk' '--disable-vnc'
'--disable-virtfs' '--disable-attr' '--disable-libiscsi'
'--disable-libnfs' '--disable-libusb' '--disable-opengl'
'--disable-numa' '--disable-usb-redir' '--disable-bzip2'
'--audio-drv-list=' '--disable-guest-agent' '--disable-vte'
--disable-udev
ERROR: unknown option --disable-udev
Try '../../configure --help' for more information

> We have just added a month ago a
> completely new dependency that would have the same issue (libu2f); we
> didn't add "test $static" just because you don't have libu2f installed
> and therefore you didn't notice.  The day you updated your system ended
> up with libu2f-dev installed, you would probably just add
> --disable-libu2f instead of adding a test for $static.  So why should
> libudev be treated differently?

The last time this came up it was in an all-in-configure
test, so I took the approach of making the test a bit smarter
to sanity check that what it was getting from pkg-config
really worked:
https://patchew.org/QEMU/20200928160402.7961-1-peter.maydell@linaro.org/
I don't know enough meson to do that in meson, so this patch is
the simple change that fixes the regression by reinstating the
logic configure had.

> - the complicated fix: check which statically linked libraries are
> available in e.g. Debian and disable _all_ other dependencies with
> --static (most of them will be the ones that you already have to disable
>  in your script, and most of them will be in configure).  Based on the
> outcome, decide whether it's actually possible to build a statically
> linked emulator that makes sense.

I don't think we want to try to say "look at what statically
linked libraries are in Debian". The point of configure
style logic is to look at what is present when we try to compile
and, when something is an optional feature, only compile it
in if it's going to work.

It would be better to do the "see if a static library is present"
test. This isn't too hard to do in configure (compare that
six line fix to the detection of libgio). Hopefully it is
not too hard to do in meson ?

> Finally, no matter how we proceed, static building of system emulators
> is not covered by either CI or tests/docker (only user-mode emulators
> are).  Even if we deprecate it, we should make sure that your
> configuration is reproduced in either Travis or GitLab, otherwise people
> will keep on breaking it.  That would also document that building a
> statically-linked system emulator is messy and requires a few dozen
> --disable options.

I agree that we don't really very solidly support this use case,
and it's pretty much "if it doesn't work we accept point-fixes
to the build machinery and/or recommend more use of --disable-foo".
But it is still useful sometimes to have.

thanks
-- PMM

