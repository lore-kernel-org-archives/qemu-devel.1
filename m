Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95529C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F5020720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAAwM3UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F5020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06Tq-0007Wo-Gy
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j06TD-0006tc-DE
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j06TB-0002Km-Th
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:27:07 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j06TB-0002It-Ne
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:27:05 -0500
Received: by mail-ot1-x343.google.com with SMTP id h9so2651632otj.11
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 08:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=upod4aUb/SI3ylNWoOZvHfrbH9kC8Aab+nACy1Fo47k=;
 b=qAAwM3UHRkdXUMpX+E0r83d2KZR6sTFLnqnCiYGd6b2t6q4/LQ8iVYp+t5Lq69xXQ5
 str3S2c23Yxceb+lJ21pft3/a2aRwj4QVvHHFJn3l7mRlDFvnt1dYksPWH5hOoOzs4+W
 IdgNb9OM2jrWW3/9ZqWXGqt4KIdKZRPnwc8HAwtvkVSr2IB/mw/1lXY0tXsF/b4efOo9
 1FMgSqLxmkocQJzRn4ZlWrOyFrz3Re9yb0JmAj8GxwsMyfn+EGFKGYaptm6+ZWW3TOCQ
 hVCrDnBcMnzS9zXX2JXT2i6Al75g3wio4r69kzGOiXBi332dWf7g0tOobQLNXkPRmk/a
 NUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=upod4aUb/SI3ylNWoOZvHfrbH9kC8Aab+nACy1Fo47k=;
 b=CsIAGLlFveM+wDGk1NOA/VdZk5k9mPK/1g0UedtltV9RuRr8RjPaqMwqiQbbMEssaN
 XaOU5P340IXuBrbiHu4pODJWB08qY2HiJfL34H3tkqUkpcPwlInmCCiSpRhOwFaCsBbi
 xW79YyDuHpOnF+dhc/fn0RoVqNPJbVTEOuzfi8hYgS4AHTqwR9B4we5Twbz+Q1X6Wx8W
 TgSsJ47I91Bn11ci58q7hlzD2UIcgOj8UVxABPDR2xQ0XxuaSzeEb4zgZ7OTFXfnwN1Y
 OX6/rtO5crFbCMCgg6EWwmUVz+4xsjgH7ye7zkJSRKVCiM/x1eGrnoYe1K9vmhjCLFh0
 v6Zw==
X-Gm-Message-State: APjAAAWvch+1S/KDZIWKoz5Mwuz0EDKE6EeToIh6RsYgekUsB0xQuSdk
 2XT5i5Zv+67mARQLdIxKcCfjGQGsEfDZ43yTAcVyqQ==
X-Google-Smtp-Source: APXvYqwXiJmgD4Yww/9ez3szrehg/4a+lWp33J4dAHau6Zx78lcpAmDdZeX6ZG33iiXsQzZuOhpaFGKt7VjPufXUDWg=
X-Received: by 2002:a05:6830:4a4:: with SMTP id l4mr129113otd.91.1581092824684; 
 Fri, 07 Feb 2020 08:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <5d0def0e-0943-3345-784d-80f8ccc318b9@redhat.com>
In-Reply-To: <5d0def0e-0943-3345-784d-80f8ccc318b9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 16:26:53 +0000
Message-ID: <CAFEAcA8HPvzaxA1pguscX5FsuWvpJhkDAuFSApofabEWVzzjQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 08:37, Thomas Huth <thuth@redhat.com> wrote:
> Question to Peter/Alex/Stefan/Howevermergespullreqsinthefuture:
>
> Should the above jobs really be skipped for pull requests, or would it
> be ok to include them there, too? (in the latter case, the above changes
> could just be dropped)

I don't mind, as long as the CI run doesn't take more than (say)
1h to 1h30 elapsed time to complete from kicking it off to getting
all the results back. The specific set of x86 configs tested don't
really worry me (as long as we do have a reasonable spread):
the thing I really care about is that we get the multiple
host architectures and the BSDs into the test setup. (We already
have about five different ways of doing CI testing of x86 Linux
hosts, which is the least likely setup to break. It's the
other host configs that I'm really keen to see progress on
automation of, because that's what's really blocking us from
being able to move off my hand-coded scripting.)

In the long run we should probably aim for being consistent about
what we test between the pull-request tests and whatever the
'public-facing CI' part is.

> > +ubuntu-18.04.3-x86_64-notcg:
> > + tags:
> > + - ubuntu_18.04.3
> > + - x86_64
> > + rules:
> > + - if: '$CI_COMMIT_REF_NAME == "staging"'
> > + script:
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n35
> > + - ./configure --disable-libssh --enable-debug --disable-tcg
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n35
> > + - make
> > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n39
> > + # Question: check is disabled on the original script, because the machine
> > + # is said to be running VirtualBox.  Should this be dropped or should the
> > + # machine be tweaked or substituted?
> > + - make check V=1
>
> Without TCG, you definitely need a host that can do KVM for running make
> check.
> Question for Peter: Would it be ok to drop this job and simply always
> use the "build-tcg-disabled" job that is already available in
> .gitlab-ci.yml ?

If we have a CI setup where KVM reliably works then we should
ideally test a --disable-tcg setup somehow. Right now my pullreq
tests don't test that because I run them on my work desktop box
and (as the config says) sometimes I'm running VirtualBox which
causes KVM to fail -- but that should be irrelevant to our CI
runners...

thanks
-- PMM

