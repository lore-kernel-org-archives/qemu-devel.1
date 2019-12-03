Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B827DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E77206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JkrfwZhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E77206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icCqm-0005JI-Kc
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 13:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1icCON-00012D-6K
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1icCO1-0005ye-AQ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:54:59 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:41119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1icCO1-0005dk-2P
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:54:57 -0500
Received: by mail-oi1-x230.google.com with SMTP id i1so52241oie.8
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2X391B/GagSeaNyVnYDRJI75Q0YwtkeLxnObUvCMQ0E=;
 b=JkrfwZhYz9RvGLbvJYc9UvhID+46AZdvohKFHj8/ZOuGaU1lerbKLZji9Mzqmt7Pa9
 BuWdFANMTwbQ9Xho+FjvC75P/liP0oVE3lCaqKxe5LDBug8IhqFBTQWra+abDk/Q2Zs9
 szuvW6DcdBj3VGi4auqdrXA0bYaPAHC5QpxByJdS3gj8szS24IaWcgeQyqQSWUfTuO1d
 s6jbTIRBh1PODHHVPo3HV1Qoq3xvzcoRoKTYdPzL7YskKlNJ80VU0qT+iq4VFAdMJOSz
 QNeBXVNw9pWBExor0AVjJNcz5TKW0XRvAz9MD2tFoq9QDJpFq8pE/BLu7QF+ZtojKD70
 I22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2X391B/GagSeaNyVnYDRJI75Q0YwtkeLxnObUvCMQ0E=;
 b=IxbDj0q/GKxdBzmRyXeboHmFh3B6m7Dqey1lMnBqOfTDxdGuqqWDx8SjTHgKsAApMB
 UAePzWFXkTeJhV85zS5Yk/RXHUtNhQ4e1kIxYOOsmm8rutsOlF/qSO9vi3axsyYLfcia
 zJzQKNEK2eB+Qz/Aid6Erhgu0ps5X5iwPIJjMsWSyGu+a8r1dX7q2fRQqnG+ZBACfzvR
 bxxENEH7mYw/01T8sXpF8xE+Ynw+cd5t9UBbt5EQNR5zyjJfn/U3+N72b4WTwUzC40DW
 d2+cpA/Zt54SmHQcHnhzsxWsJAswgcA1bpsuzoY29jcQqqHeuk3HFUUzRAM4V4iq5cn/
 Zf4Q==
X-Gm-Message-State: APjAAAVdYFr82c7wJZH8wfXiqOLPbi5x3Glm4iiQ8P4NBMjCpOvSDfW5
 gGcmfJ1Vmoa8M6w3fND+Ng2zomuU4ZndJJs9u2kFYg==
X-Google-Smtp-Source: APXvYqzIeoUHCm1ssZorXmTLd5hSYuV05lKdZLwN1EfPQ6uQyU5EfrHtXklUvlcvnHHyYkX65DWGlt5NQO81vGrFxNU=
X-Received: by 2002:aca:f5cc:: with SMTP id t195mr4675868oih.163.1575395689042; 
 Tue, 03 Dec 2019 09:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20191202140552.GA5353@localhost.localdomain>
In-Reply-To: <20191202140552.GA5353@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2019 17:54:38 +0000
Message-ID: <CAFEAcA-pOBjia36W3n1Sz-5EsUfT8gkzzn2Gpb7J6Zrjfbu6XQ@mail.gmail.com>
Subject: Re: [RFC] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
Cc: Jeff Nelson <jen@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Dec 2019 at 14:06, Cleber Rosa <crosa@redhat.com> wrote:
>
> RFC: QEMU Gating CI
> ===================
>
> This RFC attempts to address most of the issues described in
> "Requirements/GatinCI"[1].  An also relevant write up is the "State of
> QEMU CI as we enter 4.0"[2].
>
> The general approach is one to minimize the infrastructure maintenance
> and development burden, leveraging as much as possible "other people's"
> infrastructure and code.  GitLab's CI/CD platform is the most relevant
> component dealt with here.

Thanks for writing up this RFC.

My overall view is that there's some interesting stuff in
here and definitely some things we'll want to cover at some
point, but there's also a fair amount that is veering away
from solving the immediate problem we want to solve, and
which we should thus postpone for later (beyond making some
reasonable efforts not to design something which paints us
into a corner so it's annoyingly hard to improve later).

> To exemplify my point, if one specific test run as part of "check-tcg"
> is found to be faulty on a specific job (say on a specific OS), the
> entire "check-tcg" test set may be disabled as a CI-level maintenance
> action.  Of course a follow up action to deal with the specific test
> is required, probably in the form of a Launchpad bug and patches
> dealing with the issue, but without necessarily a CI related angle to
> it.
>
> If/when test result presentation and control mechanism evolve, we may
> feel confident and go into finer grained granularity.  For instance, a
> mechanism for disabling nothing but "tests/migration-test" on a given
> environment would be possible and desirable from a CI management level.

For instance, we don't have anything today for granularity of
definition of what tests we run where or where we disable them.
So we don't need it in order to move away from the scripting
approach I have at the moment. We can just say "the CI system
will run make and make check (and maybe in some hosts some
additional test-running commands) on these hosts" and hardcode
that into whatever yaml file the CI system's configured in.

> Pre-merge
> ~~~~~~~~~
>
> The natural way to have pre-merge CI jobs in GitLab is to send "Merge
> Requests"[3] (abbreviated as "MR" from now on).  In most projects, a
> MR comes from individual contributors, usually the authors of the
> changes themselves.  It's my understanding that the current maintainer
> model employed in QEMU will *not* change at this time, meaning that
> code contributions and reviews will continue to happen on the mailing
> list.  A maintainer then, having collected a number of patches, would
> submit a MR either in addition or in substitution to the Pull Requests
> sent to the mailing list.

Eventually it would be nice to allow any submaintainer
to send a merge request to the CI system (though you would
want it to have a "but don't apply until somebody else approves it"
gate as well as the automated testing part). But right now all
we need is for the one person managing merges and releases
to be able to say "here's the branch where I merged this
pullrequest, please test it". At any rate, supporting multiple
submaintainers all talking to the CI independently should be
out of scope for now.

> Multi-maintainer model
> ~~~~~~~~~~~~~~~~~~~~~~
>
> The previous section already introduced some of the proposed workflow
> that can enable such a multi-maintainer model.  With a Gating CI
> system, though, it will be natural to have a smaller "Mean time
> between (CI) failures", simply because of the expected increased
> number of systems and checks.  A lot of countermeasures have to be
> employed to keep that MTBF in check.
>
> For once, it's imperative that the maintainers for such systems and
> jobs are clearly defined and readily accessible.  Either the same
> MAINTAINERS file or a more suitable variation of such data should be
> defined before activating the *gating* rules.  This would allow a
> routing to request the attention of the maintainer responsible.
>
> In case of unresposive maintainers, or any other condition that
> renders and keeps one or more CI jobs failing for a given previously
> established amount of time, the job can be demoted with an
> "allow_failure" configuration[7].  Once such a change is commited, the
> path to promotion would be just the same as in a newly added job
> definition.
>
> Note: In a future phase we can evaluate the creation of rules that
> look at changed paths in a MR (similar to "F:" entries on MAINTAINERS)
> and the execution of specific CI jobs, which would be the
> responsibility of a given maintainer[8].

All this stuff is not needed to start with. We cope at the
moment with "everything is gating, and if something doesn't
pass it needs to be fixed or manually removed from the setup".

> GitLab Jobs and Pipelines
> -------------------------
>
> GitLab CI is built around two major concepts: jobs and pipelines.  The
> current GitLab CI configuration in QEMU uses jobs only (or putting it
> another way, all jobs in a single pipeline stage).  Consider the
> folowing job definition[9]:
>
>    build-tci:
>     script:
>     - TARGETS="aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x86_64"
>     - ./configure --enable-tcg-interpreter
>          --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
>     - make -j2
>     - make tests/boot-serial-test tests/cdrom-test tests/pxe-test
>     - for tg in $TARGETS ; do
>         export QTEST_QEMU_BINARY="${tg}-softmmu/qemu-system-${tg}" ;
>         ./tests/boot-serial-test || exit 1 ;
>         ./tests/cdrom-test || exit 1 ;
>       done
>     - QTEST_QEMU_BINARY="x86_64-softmmu/qemu-system-x86_64" ./tests/pxe-test
>     - QTEST_QEMU_BINARY="s390x-softmmu/qemu-system-s390x" ./tests/pxe-test -m slow
>
> All the lines under "script" are performed sequentially.  It should be
> clear that there's the possibility of breaking this down into multiple
> stages, so that a build happens first, and then "common set of tests"
> run in parallel.

We could do this, but we don't do it today, so we don't need
to think about this at all to start with.

> In theory, there's nothing that prevents an entire QEMU build
> directory, to be treated as an artifact.  In practice, there are
> predefined limits on GitLab that prevents that from being possible,

...so we don't need to worry about somehow defining some
cut-down "build artefact" that we provide to the testing
phase. Just do a build and test run as a single thing.
We can always come back and improve later.


Have you been able to investigate and confirm that we can
get a gitlab-runner setup that works on non-x86 ? That seems
to me like an important thing we should be confident about
early before we sink too much effort into a gitlab-based
solution.

thanks
-- PMM

