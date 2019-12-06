Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D206C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096022053B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGCtfOPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096022053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIwk-0003ZW-RN
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1idItQ-0001R6-LD
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:04:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1idItL-0002rK-UI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:03:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29769
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1idItL-0002nr-K5
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575659030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VAfLLhDM1Im6U4kL5ERHHofNIM9dUz2K93mZjmZj6RA=;
 b=QGCtfOPdOYfKAs62oiLam4NFrCxPsq6U2SVqLEyVBnkvXCUf8LFnfY1P0yAQ2rdzLbM0ox
 w5SComvfKSd4J5Ryq5ljUwAGx9XLbS0NBHwYfskotBp9XS933KxOlDTqsARxLB3zMccmOS
 1fWwtNtIoH0PUKNAao5+UJNeNx6YzOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-1LROoOJePhSWD6gN3X1wzQ-1; Fri, 06 Dec 2019 14:03:47 -0500
X-MC-Unique: 1LROoOJePhSWD6gN3X1wzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E01F80269B;
 Fri,  6 Dec 2019 19:03:46 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
 [10.18.17.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57EF6100164D;
 Fri,  6 Dec 2019 19:03:38 +0000 (UTC)
Date: Fri, 6 Dec 2019 14:03:36 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC] QEMU Gating CI
Message-ID: <20191206190336.GD23522@dhcp-17-72.bos.redhat.com>
References: <20191202140552.GA5353@localhost.localdomain>
 <87a789bizf.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87a789bizf.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jeff Nelson <jen@redhat.com>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2019 at 02:07:32PM +0000, Alex Benn=E9e wrote:
>=20
> Cleber Rosa <crosa@redhat.com> writes:
>=20
> > RFC: QEMU Gating CI
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This RFC attempts to address most of the issues described in
> > "Requirements/GatinCI"[1].  An also relevant write up is the "State of
> > QEMU CI as we enter 4.0"[2].
> >
> > The general approach is one to minimize the infrastructure maintenance
> > and development burden, leveraging as much as possible "other people's"
> > infrastructure and code.  GitLab's CI/CD platform is the most relevant
> > component dealt with here.
> >
> > Problem Statement
> > -----------------
> >
> > The following is copied verbatim from Peter Maydell's write up[1]:
> >
> > "A gating CI is a prerequisite to having a multi-maintainer model of
> > merging. By having a common set of tests that are run prior to a merge
> > you do not rely on who is currently doing merging duties having access
> > to the current set of test machines."
> >
> > This is of a very simplified view of the problem that I'd like to break
> > down even further into the following key points:
> >
> >  * Common set of tests
> >  * Pre-merge ("prior to a merge")
> >  * Access to the current set of test machines
> >  * Multi-maintainer model
> >
> > Common set of tests
> > ~~~~~~~~~~~~~~~~~~~
> >
> > Before we delve any further, let's make it clear that a "common set of
> > tests" is really a "dynamic common set of tests".  My point is that a
> > set of tests in QEMU may include or exclude different tests depending
> > on the environment.
> >
> > The exact tests that will be executed may differ depending on the
> > environment, including:
> >
> >  * Hardware
> >  * Operating system
> >  * Build configuration
> >  * Environment variables
> >
> > In the "State of QEMU CI as we enter 4.0" Alex Benn=E9e listed some of
> > those "common set of tests":
> >
> >  * check
>=20
> Check encompasses a subset of the other checks - currently:
>=20
>  - check-unit
>  - check-qtest
>  - check-block
>
> The thing that stops other groups of tests being included is generally
> are they solid on all the various hw/os/config/env setups you describe.
> For example check-tcg currently fails gloriously on non-x86 with docker
> enabled as it tries to get all the cross compiler images working.
>

Right.

> >  * check-tcg
> >  * check-softfloat
> >  * check-block
> >  * check-acceptance
> >
> > While Peter mentions that most of his checks are limited to:
> >
> >  * check
> >  * check-tcg
> >
> > Our current inability to quickly identify a faulty test from test
> > execution results (and specially in remote environments), and act upon
> > it (say quickly disable it on a given host platform), makes me believe
> > that it's fair to start a gating CI implementation that uses this
> > rather coarse granularity.
> >
> > Another benefit is a close or even a 1:1 relationship between a common
> > test set and an entry in the CI configuration.  For instance, the
> > "check" common test set would map to a "make check" command in a
> > "script:" YAML entry.
> >
> > To exemplify my point, if one specific test run as part of "check-tcg"
> > is found to be faulty on a specific job (say on a specific OS), the
> > entire "check-tcg" test set may be disabled as a CI-level maintenance
> > action.
>=20
> This would in this example eliminate practically all emulation testing
> apart from the very minimal boot-codes that get spun up by the various
> qtest migration tests. And of course the longer a group of tests is
> disabled the larger the window for additional regressions to get in.
>=20
> It may be a reasonable approach but it's not without consequence.
>

Thanks for the insights.  I agree that there are tradeoffs, and I bet
that I'm speculating a lot, and there's just to much to be learned here.

My main point in proposing this very crude rule, though, is trying to
address the operational difficulties when such a Gating CI grows
beyond a single *machine* and *job* maintainer.  A practical example
may help.  Let's consider the following jobs are initially (on phase
1) active and *gating*:

 * test-qtest-ubuntu19.04-x86_64
 * test-qtest-ubuntu19.04-aarch64
 * test-qtest-ubuntu19.04-s390x

Then, because the model has proven successful, a new job that has
already being running for a while with successful results, but with no
influence to gating, is added to the gating group.  This job is being
run on a machine that is managed by a different maintainer:

 * test-qtest-centos8.0-ppc64le

After some time, the test-qtest-centos8.0-ppc64le job starts to fail,
with seemingly no relation to recently merged code.  From a CI
management perspective, disabling the job completely is reasonable if:

 * the machine seems to be faulty
 * ppc64le machine maintainer is unresponsive
 * there's no mechanism to disable a portion of the job (such as an
   specific test)
 * bug has been found but there's no short-term fix

This doesn't mean that a lot of test will be eliminated for good.
Unless the machine is faulty, it's expected that the tests will
continue to run, but not with Gating powers.  Also, it's expected that
the same (or similar) tests will be running on other machines/jobs.

IMO, it can be actually the opposite, when "skip test y on platform x"
conditions hidden in test code can survive a lot longer than a
disabled job/machine with a frustrated (and engaged) maintainer trying
to get it back to a "green" status, and then to a reliable status for
a given time so that it can be considered a gating job again.

> > Of course a follow up action to deal with the specific test
> > is required, probably in the form of a Launchpad bug and patches
> > dealing with the issue, but without necessarily a CI related angle to
> > it.
> >
> > If/when test result presentation and control mechanism evolve, we may
> > feel confident and go into finer grained granularity.  For instance, a
> > mechanism for disabling nothing but "tests/migration-test" on a given
> > environment would be possible and desirable from a CI management
> > level.
>=20
> The migration tests have found regressions although the problem has
> generally been they were intermittent failures and hard to reproduce
> locally. The last one took a few weeks of grinding to reproduce and get
> patches together.
>

Right.  So I believe we are in sync with the nature of the problem,
that is, that some tests would benefit from individually being pulled
from specific jobs until a permanent solution can be applied to them.

At the same time, if we can't do that (see the conditions that may
render us unable to do it), it would be fair to remove a CI job from
being gating.

> > Pre-merge
> > ~~~~~~~~~
> >
> > The natural way to have pre-merge CI jobs in GitLab is to send "Merge
> > Requests"[3] (abbreviated as "MR" from now on).  In most projects, a
> > MR comes from individual contributors, usually the authors of the
> > changes themselves.  It's my understanding that the current maintainer
> > model employed in QEMU will *not* change at this time, meaning that
> > code contributions and reviews will continue to happen on the mailing
> > list.  A maintainer then, having collected a number of patches, would
> > submit a MR either in addition or in substitution to the Pull Requests
> > sent to the mailing list.
> >
> > "Pipelines for Merged Results"[4] is a very important feature to
> > support the multi-maintainer model, and looks in practice, similar to
> > Peter's "staging" branch approach, with an "automatic refresh" of the
> > target branch.  It can give a maintainer extra confidence that a MR
> > will play nicely with the updated status of the target branch.  It's
> > my understanding that it should be the "key to the gates".  A minor
> > note is that conflicts are still possible in a multi-maintainer model
> > if there are more than one person doing the merges.
> >
> > A worthy point is that the GitLab web UI is not the only way to create
> > a Merge Request, but a rich set of APIs are available[5].  This is
> > interesting for many reasons, and maybe some of Peter's
> > "apply-pullreq"[6] actions (such as bad UTF8 or bogus qemu-devel email
> > addresses checks could be made earlier) as part of a
> > "send-mergereq"-like script, bringing conformance earlier on the merge
> > process, at the MR creation stage.
> >
> > Note: It's possible to have CI jobs definition that are specific to
> > MR, allowing generic non-MR jobs to be kept on the default
> > configuration.  This can be used so individual contributors continue
> > to leverage some of the "free" (shared) runner made available on
> > gitlab.com.
> >
> > Multi-maintainer model
> > ~~~~~~~~~~~~~~~~~~~~~~
> >
> > The previous section already introduced some of the proposed workflow
> > that can enable such a multi-maintainer model.  With a Gating CI
> > system, though, it will be natural to have a smaller "Mean time
> > between (CI) failures", simply because of the expected increased
> > number of systems and checks.  A lot of countermeasures have to be
> > employed to keep that MTBF in check.
> >
> > For once, it's imperative that the maintainers for such systems and
> > jobs are clearly defined and readily accessible.  Either the same
> > MAINTAINERS file or a more suitable variation of such data should be
> > defined before activating the *gating* rules.  This would allow a
> > routing to request the attention of the maintainer responsible.
> >
> > In case of unresposive maintainers, or any other condition that
> > renders and keeps one or more CI jobs failing for a given previously
> > established amount of time, the job can be demoted with an
> > "allow_failure" configuration[7].  Once such a change is commited, the
> > path to promotion would be just the same as in a newly added job
> > definition.
> >
> > Note: In a future phase we can evaluate the creation of rules that
> > look at changed paths in a MR (similar to "F:" entries on MAINTAINERS)
> > and the execution of specific CI jobs, which would be the
> > responsibility of a given maintainer[8].
> >
> > Access to the current set of test machines
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > When compared to the various CI systems and services already being
> > employed in the QEMU project, this is the most striking difference in
> > the proposed model.  Instead of relying on shared/public/free
> > resources, this proposal also deals with privately owned and
> > operated machines.
> >
> > Even though the QEMU project operates with great cooperation, it's
> > crucial to define clear boundaries when it comes to machine access.
> > Restricted access to machines is important because:
> >
> >  * The results of jobs are many times directly tied to the setup and
> >    status of machines.  Even "soft" changes such as removing or updatin=
g
> >    packages can introduce failures in jobs (this is greatly minimized
> >    but not completely eliminated when using containers or VMs).
> >    Updating firmware or changing its settings are also examples of
> >    changes that may change the outcome of jobs.
> >
> >  * If maintainers will be accounted for the status of the jobs defined
> >    to run on specific machines, they must be sure of the status of the
> >    machines.
> >
> >  * Machines need regular monitoring and will receive required
> >    maintainance actions which can cause job regressions.
> >
> > Thus, there needs to be one clear way for machines to be *used* for
> > running jobs sent by different maintainers, while still prohibiting
> > any other privileged action that can cause permanent change to the
> > machine.  The GitLab agent (gitlab-runner) is designed to do just
> > that, and defining what will be excuted in a job (in a given system)
> > should be all that's generally allowed.  The job definition itself,
> > will of course be subject to code review before a maintainer decides
> > to send a MR containing such new or updated job definitions.
> >
> > Still related to machine maintanance, it's highly desirable for jobs
> > tied to specific host machines to be introduced alongside with
> > documentation and/or scripts that can replicate the machine setup.  If
> > the machine setup steps can be easily and reliably reproduced, then:
> >
> >  * Other people may help to debug issues and regressions if they
> >    happen to have the same hardware available
> >
> >  * Other people may provide more machines to run the same types of
> >    jobs
> >
> >  * If a machine maintainer goes MIA, it'd be easier to find another
> >    maintainer
> >
> > GitLab Jobs and Pipelines
> > -------------------------
> >
> > GitLab CI is built around two major concepts: jobs and pipelines.  The
> > current GitLab CI configuration in QEMU uses jobs only (or putting it
> > another way, all jobs in a single pipeline stage).  Consider the
> > folowing job definition[9]:
> >
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
> >
> > All the lines under "script" are performed sequentially.  It should be
> > clear that there's the possibility of breaking this down into multiple
> > stages, so that a build happens first, and then "common set of tests"
> > run in parallel.  Using the example above, it would look something
> > like:
> >
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
> >
> > Of course it would be silly to break down that job into smaller jobs th=
at
> > would run individual tests like "boot-serial-test" or "cdrom-test".  St=
ill,
> > the pipeline approach is valid because:
> >
> >  * Common set of tests would run in parallel, giving a quicker result
> >    turnaround
>=20
> check-unit is a good candidate for parallel tests. The others depends -
> I've recently turned most make check's back to -j 1 on travis because
> it's a real pain to see what test has hung when other tests keep
> running.
>

Agreed.  Running tests in parallel while keeping/presenting traceable
results is a real problem, specially in a remote environment such as
in a CI.

FIY, slightly off-topic and Avocado specific: Avocado keeps each test
result in a separate directory and log file, which helps with that.
I'm bridging the parallel test runner (introduced a few releases back)
to the existing result/reporting infrastructure.  My goal is to have
that running the acceptance tests shortly.

> >
> >  * It's easier to determine to possible nature of the problem with
> >    just the basic CI job status
> >
> >  * Different maintainers could be defined for different "common set of
> >    tests", and again by leveraging the basic CI job status, automation
> >    for directed notification can be implemented
> >
> > In the following example, "check-block" maintainers could be left
> > undisturbed with failures in the "check-acceptance" job:
> >
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
> >
> > The same logic applies for test sets for different targets.  For
> > instance, combining the two previous examples, there could different
> > maintainers defined for the different jobs on the test stage:
> >
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
> >
> > Current limitations for a multi-stage pipeline
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Because it's assumed that each job will happen in an isolated and
> > independent execution environment, jobs must explicitly define the
> > resources that will be shared between stages.  GitLab will make sure
> > the same source code revision will be available on all jobs
> > automatically.  Additionaly, GitLab supports the concept of artifacts.
> > By defining artifacts in the "build" stage, jobs in the "test" stage
> > can expect to have a copy of those artifacts automatically.
> >
> > In theory, there's nothing that prevents an entire QEMU build
> > directory, to be treated as an artifact.  In practice, there are
> > predefined limits on GitLab that prevents that from being possible,
> > resulting in errors such as:
> >
> >    Uploading artifacts...
> >    build: found 3164 matching files                  =20
> >    ERROR: Uploading artifacts to coordinator... too large archive
> >           id=3Dxxxxxxx responseStatus=3D413 Request Entity Too Large
> >           status=3D413 Request Entity Too Large token=3Dyyyyyyyyy
> >    FATAL: too large                                  =20
> >    ERROR: Job failed: exit code 1
> >
> > As far as I can tell, this is an instance define limit that's clearly
> > influenced by storage costs.  I see a few possible solutions to this
> > limitation:
> >
> >  1) Provide our own "artifact" like solution that uses our own storage
> >     solution
> >
> >  2) Reduce or eliminate the dependency on a complete build tree
> >
> > The first solution can go against the general trend of not having to
> > maintain CI infrastructure.  It could be made simpler by using cloud
> > storage, but there would still be some interaction with another
> > external infrastructure component.
> >
> > I find the second solution preferrable, given that most tests depend
> > on having one or a few binaries available.  I've run multi-stage
> > pipelines with some of those binaries (qemu-img,
> > $target-softmmu/qemu-system-$target) defined as artifcats and they
> > behaved as expected.  But, this could require some intrusive changes
> > to the current "make"-based test invocation.
>=20
> It would be nice if the make check could be run with a make install'ed
> set of binaries. I'm not sure how much hackery would be required to get
> that to work nicely. Does specifying QEMU and QEMU_IMG prevent make
> trying to re-build everything in situ?
>

At this point, I don't know how hard it'd be.  I'll certainly give it
a try.  Thomas has provided some extra info on another response to
this thread too.

> >
> > Job Naming convention
> > ---------------------
> >
> > Based only on the very simple examples job above, it should already be
> > clear that there's a lot of possibility for confusion and chaos.  For
> > instance, by looking at the "build" job definition or results, it's
> > very hard to tell what's really about.  A bit more could be inferred by
> > the "x86_64-block" job name.
> >
> > Still, the problem we have to address here is not only about the
> > amount of information easily obtained from a job name, but allowing
> > for very similar job definitions within a global namespace.  For
> > instance, if we add an Operating Systems component to the mix, we need
> > an extra qualifier for unique job names.
> >
> > Some of the possible components in a job definition are:
> >
> >  * Stage
> >  * Build profile
> >  * Test set (a shorter name for what was described in the "Common set
> >    of tests" section)
> >  * Host architecture
> >  * Target architecture
> >  * Host Operating System identification (name and version)
> >  * Execution mode/environment (bare metal, container, VM, etc)
> >
> > Stage
> > ~~~~~
> >
> > The stage of a job (which maps roughly to its purpose) should be
> > clearly defined.  A job that builds QEMU should start with "build" and
> > a job that tests QEMU should start with "test".
> >
> > IMO, in a second phase, once multi-stage pipelines are taken for
> > granted, we could evaluate dropping this component altogether from the
> > naming convention, and relying purely on the stage classification.
> >
> > Build profile
> > ~~~~~~~~~~~~~
> >
> > Different build profiles already abound in QEMU's various CI
> > configuration files.  It's hard to put a naming convention here,
> > except that it should represent the most distinguishable
> > characteristics of the build configuration.  For instance, we can find
> > a "build-disabled" job in the current ".gitlab-ci.yml" file that is
> > aptly named, as it forcefully disables a lot of build options.
> >
> > Test set
> > ~~~~~~~~
> >
> > As mentioned in the "Common set of tests" section, I believe that the
> > make target name can be used to identify the test set that will be
> > executed in a job.  That is, if a job is to be run at the "test"
> > stage, and will run "make check", its name should start with
> > "test-check".
> >
> > QEMU Targets
> > ~~~~~~~~~~~~
> >
> > Because a given job could, and usually do, involve multiple targets, I
> > honestly can not think of how to add this to the naming convention.
> > I'll ignore it for now, and consider the targets are defined in the
> > build profile.
>=20
> I like to think of three groups:
>=20
>   Core SoftMMU - the major KVM architectures
>   The rest of SoftMMU - all our random emulation targets
>   linux-user
>

OK, makes sense.  It'd be nice to know if other share the same general
idea.  I'll check how pervasive this general definition is on the
documentation too.

> >
> > Host Architecture
> > ~~~~~~~~~~~~~~~~~
> >
> > The host architecture name convention should be an easy pick, given
> > that QEMU itself employes a architecture convention for its targets.
> >
> > Host OS
> > ~~~~~~~
> >
> > The suggestion I have for the host OS name is to follow the
> > libosinfo[10] convention as closely as possible.  libosinfo's "Short
> > ID" should be well suitable here.  Examples include: "openbsd4.2",
> > "opensuse42.3", "rhel8.0", "ubuntu9.10" and "win2k12r2".
> >
> > Execution Environment
> > ~~~~~~~~~~~~~~~~~~~~~
> >
> > Distinguishing between running tests in a bare-metal versus a nested
> > VM environment is quite significant to a number of people.
> >
> > Still, I think it could probably be optional for the initial
> > implementation phase, like the naming convention for the QEMU Targets.
> >
> > Example 1
> > ~~~~~~~~~
> >
> > Defining a job that will build QEMU with common debug options, on
> > a RHEL 8.0 system on a x86_64 host:
> >
> >    build-debug-rhel8.0-x86_64:
> >      script:
> >        - ./configure --enable-debug
> >        - make
> >
> > Example 2
> > ~~~~~~~~~
> >
> > Defining a job that will run the "qtest" test set on a NetBSD 8.1
> > system on an aarch64 host:
> >
> >    test-qtest-netbsd8.1-aarch64:
> >      script:
> >        - make check-qtest
> >
> > Job and Machine Scheduling
> > --------------------------
> >
> > While the naming convention gives some information to human beings,
> > and hopefully allows for some order and avoids collusions on the
> > global job namespace, it's not enough to define where those jobs
> > should run.
> >
> > Tags[11] is the available mechanism to tie jobs to specific machines
> > running the GitLab CI agent, "gitlab-runner".  Unfortunately, some
> > duplication seems unavoidable, in the sense that some of the naming
> > components listed above are machine specific, and will then need to be
> > also given as tags.
> >
> > Note: it may be a good idea to be extra verbose with tags, by having a
> > qualifier prefix.  The justification is that tags also live in a
> > global namespace, and in theory, at a given point, tags of different
> > "categories", say a CPU name and Operating System name may collide.
> > Or, it may just be me being paranoid.
> >
> > Example 1
> > ~~~~~~~~~
> >
> >    build-debug-rhel8.0-x86_64:
> >      tags:
> >        - rhel8.0
> >        - x86_64
> >      script:
> >        - ./configure --enable-debug
> >        - make
> >
> > Example 2
> > ~~~~~~~~~
> >
> >    test-qtest-netbsd8.1-aarch64:
> >      tags:
> >        - netbsd8.1
> >        - aarch64
> >      script:
> >        - make check-qtest
>=20
> Where are all these going to go? Are we overloading the existing
> gitlab.yml or are we going to have a new set of configs for the GatingCI
> and keep gitlab.yml as the current subset that people run on their own
> accounts?
>

These will have to go into the existing ".gitlab-ci.yml" file, because
current GitLab has no support for multiple pipelines, and no support
for multiple "gitlab.yml" files.  That's one of the reasons why I took
the time to describe the proposal, because normalizing the current
file to receive extra jobs is, if not necessary, highly desirable.

Thanks for the feedback and insights,
- Cleber.

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3qpgUACgkQZX6NM6Xy
CfPuww/+JvTcKuHRHMzmSALMd+lScQck25WrAHI4C79aRcg2UdR5SISiBstYL0Fm
fwDacHHuinXKGhTp10e8Qb4fLhFjDpGEJe9qkrqRR5v3S8SG4nCVjqmoFIha2dpK
itYm86EQxVkjNdPhjyGh+a0rhkIAbUJuPBvmxvndV18znUchfN9Fx4VvNW5cfYDO
T0n53N3cehcxxIfjR/0Eq80Y7k+HQmyi/I5nX2ssOaQKV1pSPXE6jlCBo9bXt0xW
DKQ7XYHNMfMTajKDr2XAivi78Cd1FzZTU9lF30ccEz4eeXFiCy7osP/6E7+NmoD+
eII5ZX3ke5eeg/0pC48V/knW+pwybRSh6SuTbCcsOQaeXsjjHYM38fWVXqlX3P+E
VVPXDu6riKM3DKc6Ls66QZFrYOCl0y6TU5jqKTN+Pi02UGPH6N/YOi9f6RX5Fkm8
BE9PcCK1cBL4CxFXV6VdEcysDqOfR1/Mxww4spfr4kZgVnuVOoUCybsZqe1il8gX
WXFOKHI5ynItN4v9GDUN2iN9yB9hKKK1Jwsoamj/IUQlWRGS4O76pG4D7qWBkwBn
SInKvRb4yN8kXp/iWrq5dMmYwekNBvjLH+LPJw3JiNJUMrr1pUEBxFVP9lZLhUDp
RE8T8oUcAYf+3WFf/0CltMQ3AH6roWEfu9tbvVPlzK8pRjfBReg=
=smXM
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--


