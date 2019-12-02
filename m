Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C7DC432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6566D20718
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8MFvvpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6566D20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibqD7-0002Wo-CW
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ibqCB-0001YV-Es
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ibqC7-0003U6-0n
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:13:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28772
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ibqC6-0003Ts-8u
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575310389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XBz9i7Yj9ah513e8gMUBYqCk3u93tUQH7G6AUKYOxVY=;
 b=V8MFvvprMIAWT6enxbfvAegAGDdcOV5G8gol3kD+Oid+ovO+IpfAJlIZU2fxiOg1vJacDP
 EBFuZxA7TQ0sXMaydywA8elcY2idoGUpKJV7WWrUn8hEBNYWlyIxo3vixlGVIRWqh4X+6N
 XlCZf+QEI2b7GBjJyIYYEqPUG82LUqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-e2pRFWNWOfiKDtWIm89LJA-1; Mon, 02 Dec 2019 13:13:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8508DB6B;
 Mon,  2 Dec 2019 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-75.rdu2.redhat.com
 [10.10.122.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 898ED5D6A7;
 Mon,  2 Dec 2019 18:12:56 +0000 (UTC)
Date: Mon, 2 Dec 2019 13:12:54 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC] QEMU Gating CI
Message-ID: <20191202181254.GA20551@localhost.localdomain>
References: <20191202140552.GA5353@localhost.localdomain>
 <20191202170018.GD139090@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191202170018.GD139090@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: e2pRFWNWOfiKDtWIm89LJA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jeff Nelson <jen@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 02, 2019 at 05:00:18PM +0000, Stefan Hajnoczi wrote:
> On Mon, Dec 02, 2019 at 09:05:52AM -0500, Cleber Rosa wrote:
> > RFC: QEMU Gating CI
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Excellent, thank you for your work on this!
>=20
> >=20
> > This RFC attempts to address most of the issues described in
> > "Requirements/GatinCI"[1].  An also relevant write up is the "State of
> > QEMU CI as we enter 4.0"[2].
> >=20
> > The general approach is one to minimize the infrastructure maintenance
> > and development burden, leveraging as much as possible "other people's"
> > infrastructure and code.  GitLab's CI/CD platform is the most relevant
> > component dealt with here.
> >=20
> > Problem Statement
> > -----------------
> >=20
> > The following is copied verbatim from Peter Maydell's write up[1]:
> >=20
> > "A gating CI is a prerequisite to having a multi-maintainer model of
> > merging. By having a common set of tests that are run prior to a merge
> > you do not rely on who is currently doing merging duties having access
> > to the current set of test machines."
> >=20
> > This is of a very simplified view of the problem that I'd like to break
> > down even further into the following key points:
> >=20
> >  * Common set of tests
> >  * Pre-merge ("prior to a merge")
> >  * Access to the current set of test machines
> >  * Multi-maintainer model
> >=20
> > Common set of tests
> > ~~~~~~~~~~~~~~~~~~~
> >=20
> > Before we delve any further, let's make it clear that a "common set of
> > tests" is really a "dynamic common set of tests".  My point is that a
> > set of tests in QEMU may include or exclude different tests depending
> > on the environment.
> >=20
> > The exact tests that will be executed may differ depending on the
> > environment, including:
> >=20
> >  * Hardware
> >  * Operating system
> >  * Build configuration
> >  * Environment variables
> >=20
> > In the "State of QEMU CI as we enter 4.0" Alex Benn=E9e listed some of
> > those "common set of tests":
> >=20
> >  * check
> >  * check-tcg
> >  * check-softfloat
> >  * check-block
> >  * check-acceptance
> >=20
> > While Peter mentions that most of his checks are limited to:
> >=20
> >  * check
> >  * check-tcg
> >=20
> > Our current inability to quickly identify a faulty test from test
> > execution results (and specially in remote environments), and act upon
> > it (say quickly disable it on a given host platform), makes me believe
> > that it's fair to start a gating CI implementation that uses this
> > rather coarse granularity.
> >=20
> > Another benefit is a close or even a 1:1 relationship between a common
> > test set and an entry in the CI configuration.  For instance, the
> > "check" common test set would map to a "make check" command in a
> > "script:" YAML entry.
> >=20
> > To exemplify my point, if one specific test run as part of "check-tcg"
> > is found to be faulty on a specific job (say on a specific OS), the
> > entire "check-tcg" test set may be disabled as a CI-level maintenance
> > action.  Of course a follow up action to deal with the specific test
> > is required, probably in the form of a Launchpad bug and patches
> > dealing with the issue, but without necessarily a CI related angle to
> > it.
>=20
> I think this coarse level of granularity is unrealistic.  We cannot
> disable 99 tests because of 1 known failure.  There must be a way of
> disabling individual tests.  You don't need to implement it yourself,
> but I think this needs to be solved by someone before a gating CI can be
> put into use.
>

IMO it should be realistic if you look at it from a "CI related
angle".  The pull request could still be revised and disable a single
test because of a known failure, but this would not be necessarily
related to the CI.

> It probably involves adding a "make EXCLUDE_TESTS=3Dfoo,bar check"
> variable so that .gitlab-ci.yml can be modified to exclude specific
> tests on certain OSes.
>

I certainly acknowledge the issue, but I don't think this (and many
other issues that will certainly come up) should be a blocker to the
transition to GitLab.

> >=20
> > If/when test result presentation and control mechanism evolve, we may
> > feel confident and go into finer grained granularity.  For instance, a
> > mechanism for disabling nothing but "tests/migration-test" on a given
> > environment would be possible and desirable from a CI management level.
> >=20
> > Pre-merge
> > ~~~~~~~~~
> >=20
> > The natural way to have pre-merge CI jobs in GitLab is to send "Merge
> > Requests"[3] (abbreviated as "MR" from now on).  In most projects, a
> > MR comes from individual contributors, usually the authors of the
> > changes themselves.  It's my understanding that the current maintainer
> > model employed in QEMU will *not* change at this time, meaning that
> > code contributions and reviews will continue to happen on the mailing
> > list.  A maintainer then, having collected a number of patches, would
> > submit a MR either in addition or in substitution to the Pull Requests
> > sent to the mailing list.
> >=20
> > "Pipelines for Merged Results"[4] is a very important feature to
> > support the multi-maintainer model, and looks in practice, similar to
> > Peter's "staging" branch approach, with an "automatic refresh" of the
> > target branch.  It can give a maintainer extra confidence that a MR
> > will play nicely with the updated status of the target branch.  It's
> > my understanding that it should be the "key to the gates".  A minor
> > note is that conflicts are still possible in a multi-maintainer model
> > if there are more than one person doing the merges.
>=20
> The intention is to have only 1 active maintainer at a time.  The
> maintainer will handle all merges for the current QEMU release and then
> hand over to the next maintainer after the release has been made.
>=20
> Solving the problem for multiple active maintainers is low priority at
> the moment.
>

Even so, I have the impression that the following workflow:

 - Look at Merge Results Pipeline for MR#1
 - Merge MR #1
 - Hack on something else
 - Look at *automatically updated* Merge Results Pipeline for MR#2
 - Merge MR #2

Is better than:

 - Push PR #1 to staging
 - Wait for PR #1 Pipeline to finish
 - Look at PR #1 Pipeline results
 - Push staging into master
 - Push PR #2 to staging=20
 - Wait for PR #2 Pipeline to finish
 - Push staging into master

But I don't think I'll be a direct user of those workflows, so I'm
completely open to feedback on it.

> > A worthy point is that the GitLab web UI is not the only way to create
> > a Merge Request, but a rich set of APIs are available[5].  This is
> > interesting for many reasons, and maybe some of Peter's
> > "apply-pullreq"[6] actions (such as bad UTF8 or bogus qemu-devel email
> > addresses checks could be made earlier) as part of a
> > "send-mergereq"-like script, bringing conformance earlier on the merge
> > process, at the MR creation stage.
> >=20
> > Note: It's possible to have CI jobs definition that are specific to
> > MR, allowing generic non-MR jobs to be kept on the default
> > configuration.  This can be used so individual contributors continue
> > to leverage some of the "free" (shared) runner made available on
> > gitlab.com.
>=20
> I expected this section to say:
> 1. Maintainer sets up a personal gitlab.com account with a qemu.git fork.
> 2. Maintainer adds QEMU's CI tokens to their personal account.
> 3. Each time a maintainer pushes to their "staging" branch the CI
>    triggers.
>=20
> IMO this model is simpler than MRs because once it has been set up the
> maintainer just uses git push.  Why are MRs necessary?
>

I am not sure GitLab "Specific Runners" can be used from other
accounts/forks.  AFAICT, you'd need a MR to send jobs that would run
on those machines, because (again AFAICT) the token used to register
those gitlab-runner instances on those machines is not shareable
across forks.  But, I'll double check that.

> > Multi-maintainer model
> > ~~~~~~~~~~~~~~~~~~~~~~
> >=20
> > The previous section already introduced some of the proposed workflow
> > that can enable such a multi-maintainer model.  With a Gating CI
> > system, though, it will be natural to have a smaller "Mean time
> > between (CI) failures", simply because of the expected increased
> > number of systems and checks.  A lot of countermeasures have to be
> > employed to keep that MTBF in check.
>=20
> I expect the CI to be in a state of partial failure all the time.
> Previously the idea of Tier 1 and Tier 2 platforms was raised where Tier
> 2 platforms can be failing without gating the CI.  I think this is
> reality for us.  Niche host OSes and features fail and remain in the
> failing state for days/weeks.  The CI should be designed to run in this
> mode all the time.
>

The most important tool we'd have at the CI level is to "allow
failures" indeed.  GitLab CI itself doesn't provide the concept of
different tiers, so effectively we'd have to mimic that with jobs that
will not be blocking.  What I think we should use is, have a well
defined methodology, and tools, to either promote or demote
failing/passing jobs.

For example, a newly introduced job will always be in "allow failure"
mode (similar to Tier 2), until it proves itself by running reliably
for 100 runs or 2 months, whatever comes last.  Likewise, a job that
is not allowed to fail (similar to a Tier 1) would be demoted if it
fails twice and is not repaired within 24 hours.

> > For once, it's imperative that the maintainers for such systems and
> > jobs are clearly defined and readily accessible.  Either the same
> > MAINTAINERS file or a more suitable variation of such data should be
> > defined before activating the *gating* rules.  This would allow a
> > routing to request the attention of the maintainer responsible.
> >=20
> > In case of unresposive maintainers, or any other condition that
> > renders and keeps one or more CI jobs failing for a given previously
> > established amount of time, the job can be demoted with an
> > "allow_failure" configuration[7].  Once such a change is commited, the
> > path to promotion would be just the same as in a newly added job
> > definition.
> >=20
> > Note: In a future phase we can evaluate the creation of rules that
> > look at changed paths in a MR (similar to "F:" entries on MAINTAINERS)
> > and the execution of specific CI jobs, which would be the
> > responsibility of a given maintainer[8].
> >=20
> > Access to the current set of test machines
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >=20
> > When compared to the various CI systems and services already being
> > employed in the QEMU project, this is the most striking difference in
> > the proposed model.  Instead of relying on shared/public/free
> > resources, this proposal also deals with privately owned and
> > operated machines.
> >=20
> > Even though the QEMU project operates with great cooperation, it's
> > crucial to define clear boundaries when it comes to machine access.
> > Restricted access to machines is important because:
> >=20
> >  * The results of jobs are many times directly tied to the setup and
> >    status of machines.  Even "soft" changes such as removing or updatin=
g
> >    packages can introduce failures in jobs (this is greatly minimized
> >    but not completely eliminated when using containers or VMs).
> >    Updating firmware or changing its settings are also examples of
> >    changes that may change the outcome of jobs.
> >=20
> >  * If maintainers will be accounted for the status of the jobs defined
> >    to run on specific machines, they must be sure of the status of the
> >    machines.
> >=20
> >  * Machines need regular monitoring and will receive required
> >    maintainance actions which can cause job regressions.
> >=20
> > Thus, there needs to be one clear way for machines to be *used* for
> > running jobs sent by different maintainers, while still prohibiting
> > any other privileged action that can cause permanent change to the
> > machine.  The GitLab agent (gitlab-runner) is designed to do just
> > that, and defining what will be excuted in a job (in a given system)
> > should be all that's generally allowed.  The job definition itself,
> > will of course be subject to code review before a maintainer decides
> > to send a MR containing such new or updated job definitions.
> >=20
> > Still related to machine maintanance, it's highly desirable for jobs
> > tied to specific host machines to be introduced alongside with
> > documentation and/or scripts that can replicate the machine setup.  If
> > the machine setup steps can be easily and reliably reproduced, then:
> >=20
> >  * Other people may help to debug issues and regressions if they
> >    happen to have the same hardware available
> >=20
> >  * Other people may provide more machines to run the same types of
> >    jobs
> >=20
> >  * If a machine maintainer goes MIA, it'd be easier to find another
> >    maintainer
>=20
> qemu.git has tests/vm for Ubuntu (i386), FreeBSD, NetBSD, OpenBSD,
> CentOS, Fedora and tests/docker for Debian cross-compilation.  These are
> a good starting point for automated/reproducible environments for
> running builds and tests.  It would be great to integrate with
> gitlab-runner.
>

Yes, the idea is to close the gap as much as possible, and make what
we already have on qemu.git available to CI/gitlab-runner and
vice-versa.

> >=20
> > GitLab Jobs and Pipelines
> > -------------------------
> >=20
> > GitLab CI is built around two major concepts: jobs and pipelines.  The
> > current GitLab CI configuration in QEMU uses jobs only (or putting it
> > another way, all jobs in a single pipeline stage).  Consider the
> > folowing job definition[9]:
> >=20
> >    build-tci:
> >     script:
> >     - TARGETS=3D"aarch64 alpha arm hppa m68k microblaze moxie ppc64 s39=
0x x86_64"
> >     - ./configure --enable-tcg-interpreter
> >          --target-list=3D"$(for tg in $TARGETS; do echo -n ${tg}'-softm=
mu '; done)"
> >     - make -j2
> >     - make tests/boot-serial-test tests/cdrom-test tests/pxe-test
> >     - for tg in $TARGETS ; do
> >         export QTEST_QEMU_BINARY=3D"${tg}-softmmu/qemu-system-${tg}" ;
> >         ./tests/boot-serial-test || exit 1 ;
> >         ./tests/cdrom-test || exit 1 ;
> >       done
> >     - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/p=
xe-test
> >     - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x" ./tests/pxe=
-test -m slow
> >=20
> > All the lines under "script" are performed sequentially.  It should be
> > clear that there's the possibility of breaking this down into multiple
> > stages, so that a build happens first, and then "common set of tests"
> > run in parallel.  Using the example above, it would look something
> > like:
> >=20
> >    +---------------+------------------------+
> >    |  BUILD STAGE  |        TEST STAGE      |
> >    +---------------+------------------------+
> >    |   +-------+   |  +------------------+  |
> >    |   | build |   |  | boot-serial-test |  |
> >    |   +-------+   |  +------------------+  |
> >    |               |                        |
> >    |               |  +------------------+  |
> >    |               |  | cdrom-test       |  |
> >    |               |  +------------------+  |
> >    |               |                        |
> >    |               |  +------------------+  |
> >    |               |  | x86_64-pxe-test  |  |
> >    |               |  +------------------+  |
> >    |               |                        |
> >    |               |  +------------------+  |
> >    |               |  | s390x-pxe-test   |  |
> >    |               |  +------------------+  |
> >    |               |                        |
> >    +---------------+------------------------+
> >=20
> > Of course it would be silly to break down that job into smaller jobs th=
at
> > would run individual tests like "boot-serial-test" or "cdrom-test".  St=
ill,
> > the pipeline approach is valid because:
> >=20
> >  * Common set of tests would run in parallel, giving a quicker result
> >    turnaround
> >=20
> >  * It's easier to determine to possible nature of the problem with
> >    just the basic CI job status
> >=20
> >  * Different maintainers could be defined for different "common set of
> >    tests", and again by leveraging the basic CI job status, automation
> >    for directed notification can be implemented
> >=20
> > In the following example, "check-block" maintainers could be left
> > undisturbed with failures in the "check-acceptance" job:
> >=20
> >    +---------------+------------------------+
> >    |  BUILD STAGE  |        TEST STAGE      |
> >    +---------------+------------------------+
> >    |   +-------+   |  +------------------+  |
> >    |   | build |   |  | check-block      |  |
> >    |   +-------+   |  +------------------+  |
> >    |               |                        |
> >    |               |  +------------------+  |
> >    |               |  | check-acceptance |  |
> >    |               |  +------------------+  |
> >    |               |                        |
> >    +---------------+------------------------+
> >=20
> > The same logic applies for test sets for different targets.  For
> > instance, combining the two previous examples, there could different
> > maintainers defined for the different jobs on the test stage:
> >=20
> >    +---------------+------------------------+
> >    |  BUILD STAGE  |        TEST STAGE      |
> >    +---------------+------------------------+
> >    |   +-------+   |  +------------------+  |
> >    |   | build |   |  | x86_64-block     |  |
> >    |   +-------+   |  +------------------+  |
> >    |               |                        |
> >    |               |  +------------------+  |
> >    |               |  | x86_64-acceptance|  |
> >    |               |  +------------------+  |
> >    |               |                        |
> >    |               |  +------------------+  |
> >    |               |  | s390x-block      |  |
> >    |               |  +------------------+  |
> >    |               |                        |
> >    |               |  +------------------+  |
> >    |               |  | s390x-acceptance |  |
> >    |               |  +------------------+  |
> >    +---------------+------------------------+
> >=20
> > Current limitations for a multi-stage pipeline
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >=20
> > Because it's assumed that each job will happen in an isolated and
> > independent execution environment, jobs must explicitly define the
> > resources that will be shared between stages.  GitLab will make sure
> > the same source code revision will be available on all jobs
> > automatically.  Additionaly, GitLab supports the concept of artifacts.
> > By defining artifacts in the "build" stage, jobs in the "test" stage
> > can expect to have a copy of those artifacts automatically.
> >=20
> > In theory, there's nothing that prevents an entire QEMU build
> > directory, to be treated as an artifact.  In practice, there are
> > predefined limits on GitLab that prevents that from being possible,
> > resulting in errors such as:
> >=20
> >    Uploading artifacts...
> >    build: found 3164 matching files                  =20
> >    ERROR: Uploading artifacts to coordinator... too large archive
> >           id=3Dxxxxxxx responseStatus=3D413 Request Entity Too Large
> >           status=3D413 Request Entity Too Large token=3Dyyyyyyyyy
> >    FATAL: too large                                  =20
> >    ERROR: Job failed: exit code 1
> >=20
> > As far as I can tell, this is an instance define limit that's clearly
> > influenced by storage costs.  I see a few possible solutions to this
> > limitation:
> >=20
> >  1) Provide our own "artifact" like solution that uses our own storage
> >     solution
> >=20
> >  2) Reduce or eliminate the dependency on a complete build tree
> >=20
> > The first solution can go against the general trend of not having to
> > maintain CI infrastructure.  It could be made simpler by using cloud
> > storage, but there would still be some interaction with another
> > external infrastructure component.
> >=20
> > I find the second solution preferrable, given that most tests depend
> > on having one or a few binaries available.  I've run multi-stage
> > pipelines with some of those binaries (qemu-img,
> > $target-softmmu/qemu-system-$target) defined as artifcats and they
> > behaved as expected.  But, this could require some intrusive changes
> > to the current "make"-based test invocation.
>=20
> I agree.  It should be possible to bring the necessary artifacts down to
> below the limit.  This wasn't a problem for the virtio-fs GitLab CI
> scripts I wrote that build a Linux kernel, QEMU, and guest image so I
> think will be possible for QEMU as a whole:
> https://gitlab.com/virtio-fs/virtio-fs-ci/


Cool, thanks for the pointer and feedback!

- Cleber.


