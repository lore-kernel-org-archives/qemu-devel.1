Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DF8C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43046214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUE/LgQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43046214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06is-0006Mv-Gh
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j06i0-0005tX-BA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j06hz-0006N5-4q
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:42:24 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:41857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j06hy-0006LR-VR
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:42:23 -0500
Received: by mail-oi1-x235.google.com with SMTP id i1so2558102oie.8
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 08:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QJFKsOcIk3ON0G2kSq5Rrvi0YsDiotvf4wEUfu6aI+I=;
 b=gUE/LgQaowt+HNylFLnrGaQISdiTV5gV+aqRR1NWoQA+OgRs7u8PEjqvcHv5sT6k8J
 7wAV2Hrwxdy9N5ZFEyWz9hTmvQIx736LmcATK8b3swmsSJ/Z5Z+mwWg+9E34+vH+MT40
 sn4N6f8u+eWwnhsqrMMk6JzAIiNCIhrRT/9Xl3bkBMCusiZvHWQdM2ydUX5u9jfkkolH
 uR5fT7g2LHKvY5uCcYInHi7wkxof0USuxf6qFbf2+QH+8ltNA+es2cEJ7gI3kTJMb0MB
 ji5ggynyj6Q9GKBpwFaoWVXYJbzGbuHEouvt9Vd7Fyeyp97q1QtB8xDKqfpMi3Nj3pC0
 fkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QJFKsOcIk3ON0G2kSq5Rrvi0YsDiotvf4wEUfu6aI+I=;
 b=PXlJ+YfIrBOoQgTyV/mv41EplO0PNLSfsDNs3HWRBkfApoVJ7Daz2LXpR9QrqYXxDV
 ttgfNiz4pkO3viAUHg3+v6ndeYWA8JPfK8mXUSqUwQBspnFwzFfP4vMOcjPEwJCq/WNo
 xs8Vl/iU3rhdD31KhWao4Mf8BIsw+hq6WFhonBIDtMsi0RwJTKbwNX8EccSH69E0xlEd
 JnMvJTnkp6hr5bri+TfJJsQlam4tHaPBi2oFrMUUBfa6BLWJ93uCJHqr22CCu1IsshBU
 nPjZTALRr4EAF0cyOp01GaBfTqE3mqiZOhQ3+6T17CmmWYu3gwen/OvHBeEeKyqz4zfy
 iR4Q==
X-Gm-Message-State: APjAAAV+Q7FPeyyHXnzJqE/FBeTKjfYv37l4vcuoVSVeB0chgn8VokTn
 zNwXK8HkHFlGSloqRPEwCsievExeAX5MeH4U6gvlTQ==
X-Google-Smtp-Source: APXvYqy3q3f0BIm6MbccUdbkKt5C3dy70Qwg3Y6kmAZGinE6dGm6a+pkr2er14m33GherrtBVweeDXzgm7FHnhP0rVo=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2738412oiy.170.1581093741926; 
 Fri, 07 Feb 2020 08:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20191202140552.GA5353@localhost.localdomain>
 <CAFEAcA--Rag8JzvPP+Pvkebv1ifeZkpcx7zSXdDBkpZWmpZwxQ@mail.gmail.com>
 <20200203032700.GA12127@localhost.localdomain>
In-Reply-To: <20200203032700.GA12127@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 16:42:10 +0000
Message-ID: <CAFEAcA-h3fJaBm+DSn6VQ=sgdS4x67MT_biyeTohk__JzkACMw@mail.gmail.com>
Subject: Re: [RFC] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: Jeff Nelson <jen@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 03:28, Cleber Rosa <crosa@redhat.com> wrote
>    >>> Testing process:
>    >>>
>    >>>  * I get an email which is a pull request, and I run the
>    >>>    "apply-pullreq" script, which takes the GIT URL and tag/branch name
>    >>>    to test.
>    >>>  * apply-pullreq performs the merge into a 'staging' branch
>    >>>  * apply-pullreq also performs some simple local tests:
>    >>>     * does git verify-tag like the GPG signature?
>    >>>     * are we trying to apply the pull before reopening the dev tree
>    >>>       for a new release?
>    >>>     * does the pull include commits with bad UTF8 or bogus qemu-devel
>    >>>       email addresses?
>    >>>     * submodule updates are only allowed if the --submodule-ok option
>    >>>       was specifically passed
>
> These steps could go unchanged at this point.  One minor remark is
> that the repo hosted at gitlab.com would be used instead.  The
> 'staging' branch can be protected[4] so that only authorized people
> can do it (and trigger the pipeline and its jobs).
>
>    >>>  * apply-pullreq then invokes parallel-buildtest to do the actual
>    >>>    testing
>
> This would be done by GitLab instead.  The dispatching of jobs is
> based on the tags given to jobs and machines.  IMO at least the OS
> version and architecture should be given as tags, and the machine
> needs proper setup to run a job, such as having the right packages
> installed.  It can start with a proper documentation for every type of
> OS and version (and possibly job type), and evolve into scripts
> or other type of automation.
>
> These are usuall identical or very similar to what is defined in
> "tests/docker/dockerfiles", but need to be done at the machine level
> because of the "shell" executor.
>
>    >>>  * parallel-buildtest is a trivial wrapper around GNU Parallel which
>    >>>    invokes 'mergebuild' on each of the test machines
>    >>>  * if all is OK then the user gets to do the 'git push' to push the
>    >>>    staging branch to master
>
> The central place to check for success or failure would be the
> pipeline page.  Also, there's a configurable notification system that
> should (I've not tested it throughly) send failed and/or successful
> pipeline results to the pipeline author.  IIUC, this means whoever
> pushed to the 'staging' branch that caused the pipeline to be
> triggered.
>
> Let me know if this makes sense to you, and if so, we can arrange
> a real world PoC.  FIY, I've run hundreds of jobs in an internal
> GitLab instance, and GitLab itself (server and runner) seems very
> stable.

This all sounds like the right thing and great progress. So yes,
I agree that the next step would be to get to a point where you
can give me some instructions on how to say "OK, here's my staging
branch" and run it through the new test process and look at the
results.

thanks
-- PMM

