Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765D2C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3036B20684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGWkxLqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3036B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic90P-00070I-Sz
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 09:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ic8qs-0002B2-Lg
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ic8qG-000184-Cl
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:07:57 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ic8q8-0000zF-4h
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:07:51 -0500
Received: by mail-wr1-x442.google.com with SMTP id a15so3805570wrf.9
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 06:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=63L/uB3wsiSJVS66jNLNHAGEcuh3laIFH4uatnAHI10=;
 b=eGWkxLqzFKcyjUTHuFxnckM52T2vLpp6c8Zh+BbVoLlsx3rP6NQFZ/CdR+WU4IuywQ
 o/D+H6D6k6aUtYkLyeRieJ+KLDzQiOlrbfKqF8ERBInSChPtZaIlf/lpXJxdcpFjPh6D
 4HwYXcM9zn4kikrfqTn1nALD9qx6UTWE+I/RIcI1XF7pCQM0//77xO7ZIq7ru2lKlozB
 +NavUOpW/XCmOfA04TzGcqkmEV4csTn+R3QbxB4AsauYDfgoT8YH0L3L5D8gWZoSUezJ
 LJIlyGSV0Bn3aw4EpbWyMnAFyVRZLiLEm+rh1G81Ut/Oqtn6oQsDGTUatvDD+HFbsfIT
 Uq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=63L/uB3wsiSJVS66jNLNHAGEcuh3laIFH4uatnAHI10=;
 b=sbMWJhAMDh+tBd4/8TFmWk8bAcOGa/yPQQIWRCuxtiDo9jzV5yP4Cno71Xory3IHqg
 +NPxAYHdtwDL4rfnkj+v4YU4IGo+g1BD55mIbvobekHR/TKVT+uMNcbzrgFHFGDXGIbT
 FNwJenDz62nKofOovTC6Qhp12ATmMaf4GkndgPI/5q1znbEpbyEutJgP17smpmP2kLhm
 eBrTfN6ZFwUReZ81/0ZkTwhAa3Vtyoz6n2gC7yyBAM4HkMEpEihqNY79srwWhVeXn1md
 hl+PY6w2f5HQPQCocNzdjt4U72fv8YtHxXzFDLXiesmtj6ajcylFxSgoJc+YIm8LJyEe
 B2eQ==
X-Gm-Message-State: APjAAAWWT49CpFAt8qBqPM6bB8e7DazkoFYoYIZ/NDmvuowctSnktXE2
 xvDdH7OjjyJA55QyFqC2gKcyvg==
X-Google-Smtp-Source: APXvYqwU4/4BdRZ2meVelLparifNJSUl8ta3ixlcEtuGeTtm3Zs0163loAihnY187azOzQnqCa1crg==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr3408336wrj.325.1575382055590; 
 Tue, 03 Dec 2019 06:07:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f67sm3112109wme.16.2019.12.03.06.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 06:07:33 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E27031FF87;
 Tue,  3 Dec 2019 14:07:32 +0000 (GMT)
References: <20191202140552.GA5353@localhost.localdomain>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC] QEMU Gating CI
In-reply-to: <20191202140552.GA5353@localhost.localdomain>
Date: Tue, 03 Dec 2019 14:07:32 +0000
Message-ID: <87a789bizf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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


Cleber Rosa <crosa@redhat.com> writes:

> RFC: QEMU Gating CI
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This RFC attempts to address most of the issues described in
> "Requirements/GatinCI"[1].  An also relevant write up is the "State of
> QEMU CI as we enter 4.0"[2].
>
> The general approach is one to minimize the infrastructure maintenance
> and development burden, leveraging as much as possible "other people's"
> infrastructure and code.  GitLab's CI/CD platform is the most relevant
> component dealt with here.
>
> Problem Statement
> -----------------
>
> The following is copied verbatim from Peter Maydell's write up[1]:
>
> "A gating CI is a prerequisite to having a multi-maintainer model of
> merging. By having a common set of tests that are run prior to a merge
> you do not rely on who is currently doing merging duties having access
> to the current set of test machines."
>
> This is of a very simplified view of the problem that I'd like to break
> down even further into the following key points:
>
>  * Common set of tests
>  * Pre-merge ("prior to a merge")
>  * Access to the current set of test machines
>  * Multi-maintainer model
>
> Common set of tests
> ~~~~~~~~~~~~~~~~~~~
>
> Before we delve any further, let's make it clear that a "common set of
> tests" is really a "dynamic common set of tests".  My point is that a
> set of tests in QEMU may include or exclude different tests depending
> on the environment.
>
> The exact tests that will be executed may differ depending on the
> environment, including:
>
>  * Hardware
>  * Operating system
>  * Build configuration
>  * Environment variables
>
> In the "State of QEMU CI as we enter 4.0" Alex Benn=C3=A9e listed some of
> those "common set of tests":
>
>  * check

Check encompasses a subset of the other checks - currently:

 - check-unit
 - check-qtest
 - check-block

The thing that stops other groups of tests being included is generally
are they solid on all the various hw/os/config/env setups you describe.
For example check-tcg currently fails gloriously on non-x86 with docker
enabled as it tries to get all the cross compiler images working.

>  * check-tcg
>  * check-softfloat
>  * check-block
>  * check-acceptance
>
> While Peter mentions that most of his checks are limited to:
>
>  * check
>  * check-tcg
>
> Our current inability to quickly identify a faulty test from test
> execution results (and specially in remote environments), and act upon
> it (say quickly disable it on a given host platform), makes me believe
> that it's fair to start a gating CI implementation that uses this
> rather coarse granularity.
>
> Another benefit is a close or even a 1:1 relationship between a common
> test set and an entry in the CI configuration.  For instance, the
> "check" common test set would map to a "make check" command in a
> "script:" YAML entry.
>
> To exemplify my point, if one specific test run as part of "check-tcg"
> is found to be faulty on a specific job (say on a specific OS), the
> entire "check-tcg" test set may be disabled as a CI-level maintenance
> action.

This would in this example eliminate practically all emulation testing
apart from the very minimal boot-codes that get spun up by the various
qtest migration tests. And of course the longer a group of tests is
disabled the larger the window for additional regressions to get in.

It may be a reasonable approach but it's not without consequence.

> Of course a follow up action to deal with the specific test
> is required, probably in the form of a Launchpad bug and patches
> dealing with the issue, but without necessarily a CI related angle to
> it.
>
> If/when test result presentation and control mechanism evolve, we may
> feel confident and go into finer grained granularity.  For instance, a
> mechanism for disabling nothing but "tests/migration-test" on a given
> environment would be possible and desirable from a CI management
> level.

The migration tests have found regressions although the problem has
generally been they were intermittent failures and hard to reproduce
locally. The last one took a few weeks of grinding to reproduce and get
patches together.

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
>
> "Pipelines for Merged Results"[4] is a very important feature to
> support the multi-maintainer model, and looks in practice, similar to
> Peter's "staging" branch approach, with an "automatic refresh" of the
> target branch.  It can give a maintainer extra confidence that a MR
> will play nicely with the updated status of the target branch.  It's
> my understanding that it should be the "key to the gates".  A minor
> note is that conflicts are still possible in a multi-maintainer model
> if there are more than one person doing the merges.
>
> A worthy point is that the GitLab web UI is not the only way to create
> a Merge Request, but a rich set of APIs are available[5].  This is
> interesting for many reasons, and maybe some of Peter's
> "apply-pullreq"[6] actions (such as bad UTF8 or bogus qemu-devel email
> addresses checks could be made earlier) as part of a
> "send-mergereq"-like script, bringing conformance earlier on the merge
> process, at the MR creation stage.
>
> Note: It's possible to have CI jobs definition that are specific to
> MR, allowing generic non-MR jobs to be kept on the default
> configuration.  This can be used so individual contributors continue
> to leverage some of the "free" (shared) runner made available on
> gitlab.com.
>
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
>
> Access to the current set of test machines
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> When compared to the various CI systems and services already being
> employed in the QEMU project, this is the most striking difference in
> the proposed model.  Instead of relying on shared/public/free
> resources, this proposal also deals with privately owned and
> operated machines.
>
> Even though the QEMU project operates with great cooperation, it's
> crucial to define clear boundaries when it comes to machine access.
> Restricted access to machines is important because:
>
>  * The results of jobs are many times directly tied to the setup and
>    status of machines.  Even "soft" changes such as removing or updating
>    packages can introduce failures in jobs (this is greatly minimized
>    but not completely eliminated when using containers or VMs).
>    Updating firmware or changing its settings are also examples of
>    changes that may change the outcome of jobs.
>
>  * If maintainers will be accounted for the status of the jobs defined
>    to run on specific machines, they must be sure of the status of the
>    machines.
>
>  * Machines need regular monitoring and will receive required
>    maintainance actions which can cause job regressions.
>
> Thus, there needs to be one clear way for machines to be *used* for
> running jobs sent by different maintainers, while still prohibiting
> any other privileged action that can cause permanent change to the
> machine.  The GitLab agent (gitlab-runner) is designed to do just
> that, and defining what will be excuted in a job (in a given system)
> should be all that's generally allowed.  The job definition itself,
> will of course be subject to code review before a maintainer decides
> to send a MR containing such new or updated job definitions.
>
> Still related to machine maintanance, it's highly desirable for jobs
> tied to specific host machines to be introduced alongside with
> documentation and/or scripts that can replicate the machine setup.  If
> the machine setup steps can be easily and reliably reproduced, then:
>
>  * Other people may help to debug issues and regressions if they
>    happen to have the same hardware available
>
>  * Other people may provide more machines to run the same types of
>    jobs
>
>  * If a machine maintainer goes MIA, it'd be easier to find another
>    maintainer
>
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
>     - TARGETS=3D"aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x=
 x86_64"
>     - ./configure --enable-tcg-interpreter
>          --target-list=3D"$(for tg in $TARGETS; do echo -n ${tg}'-softmmu=
 '; done)"
>     - make -j2
>     - make tests/boot-serial-test tests/cdrom-test tests/pxe-test
>     - for tg in $TARGETS ; do
>         export QTEST_QEMU_BINARY=3D"${tg}-softmmu/qemu-system-${tg}" ;
>         ./tests/boot-serial-test || exit 1 ;
>         ./tests/cdrom-test || exit 1 ;
>       done
>     - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/pxe=
-test
>     - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x" ./tests/pxe-t=
est -m slow
>
> All the lines under "script" are performed sequentially.  It should be
> clear that there's the possibility of breaking this down into multiple
> stages, so that a build happens first, and then "common set of tests"
> run in parallel.  Using the example above, it would look something
> like:
>
>    +---------------+------------------------+
>    |  BUILD STAGE  |        TEST STAGE      |
>    +---------------+------------------------+
>    |   +-------+   |  +------------------+  |
>    |   | build |   |  | boot-serial-test |  |
>    |   +-------+   |  +------------------+  |
>    |               |                        |
>    |               |  +------------------+  |
>    |               |  | cdrom-test       |  |
>    |               |  +------------------+  |
>    |               |                        |
>    |               |  +------------------+  |
>    |               |  | x86_64-pxe-test  |  |
>    |               |  +------------------+  |
>    |               |                        |
>    |               |  +------------------+  |
>    |               |  | s390x-pxe-test   |  |
>    |               |  +------------------+  |
>    |               |                        |
>    +---------------+------------------------+
>
> Of course it would be silly to break down that job into smaller jobs that
> would run individual tests like "boot-serial-test" or "cdrom-test".  Stil=
l,
> the pipeline approach is valid because:
>
>  * Common set of tests would run in parallel, giving a quicker result
>    turnaround

check-unit is a good candidate for parallel tests. The others depends -
I've recently turned most make check's back to -j 1 on travis because
it's a real pain to see what test has hung when other tests keep
running.

>
>  * It's easier to determine to possible nature of the problem with
>    just the basic CI job status
>
>  * Different maintainers could be defined for different "common set of
>    tests", and again by leveraging the basic CI job status, automation
>    for directed notification can be implemented
>
> In the following example, "check-block" maintainers could be left
> undisturbed with failures in the "check-acceptance" job:
>
>    +---------------+------------------------+
>    |  BUILD STAGE  |        TEST STAGE      |
>    +---------------+------------------------+
>    |   +-------+   |  +------------------+  |
>    |   | build |   |  | check-block      |  |
>    |   +-------+   |  +------------------+  |
>    |               |                        |
>    |               |  +------------------+  |
>    |               |  | check-acceptance |  |
>    |               |  +------------------+  |
>    |               |                        |
>    +---------------+------------------------+
>
> The same logic applies for test sets for different targets.  For
> instance, combining the two previous examples, there could different
> maintainers defined for the different jobs on the test stage:
>
>    +---------------+------------------------+
>    |  BUILD STAGE  |        TEST STAGE      |
>    +---------------+------------------------+
>    |   +-------+   |  +------------------+  |
>    |   | build |   |  | x86_64-block     |  |
>    |   +-------+   |  +------------------+  |
>    |               |                        |
>    |               |  +------------------+  |
>    |               |  | x86_64-acceptance|  |
>    |               |  +------------------+  |
>    |               |                        |
>    |               |  +------------------+  |
>    |               |  | s390x-block      |  |
>    |               |  +------------------+  |
>    |               |                        |
>    |               |  +------------------+  |
>    |               |  | s390x-acceptance |  |
>    |               |  +------------------+  |
>    +---------------+------------------------+
>
> Current limitations for a multi-stage pipeline
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Because it's assumed that each job will happen in an isolated and
> independent execution environment, jobs must explicitly define the
> resources that will be shared between stages.  GitLab will make sure
> the same source code revision will be available on all jobs
> automatically.  Additionaly, GitLab supports the concept of artifacts.
> By defining artifacts in the "build" stage, jobs in the "test" stage
> can expect to have a copy of those artifacts automatically.
>
> In theory, there's nothing that prevents an entire QEMU build
> directory, to be treated as an artifact.  In practice, there are
> predefined limits on GitLab that prevents that from being possible,
> resulting in errors such as:
>
>    Uploading artifacts...
>    build: found 3164 matching files=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
>    ERROR: Uploading artifacts to coordinator... too large archive
>           id=3Dxxxxxxx responseStatus=3D413 Request Entity Too Large
>           status=3D413 Request Entity Too Large token=3Dyyyyyyyyy
>    FATAL: too large=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>    ERROR: Job failed: exit code 1
>
> As far as I can tell, this is an instance define limit that's clearly
> influenced by storage costs.  I see a few possible solutions to this
> limitation:
>
>  1) Provide our own "artifact" like solution that uses our own storage
>     solution
>
>  2) Reduce or eliminate the dependency on a complete build tree
>
> The first solution can go against the general trend of not having to
> maintain CI infrastructure.  It could be made simpler by using cloud
> storage, but there would still be some interaction with another
> external infrastructure component.
>
> I find the second solution preferrable, given that most tests depend
> on having one or a few binaries available.  I've run multi-stage
> pipelines with some of those binaries (qemu-img,
> $target-softmmu/qemu-system-$target) defined as artifcats and they
> behaved as expected.  But, this could require some intrusive changes
> to the current "make"-based test invocation.

It would be nice if the make check could be run with a make install'ed
set of binaries. I'm not sure how much hackery would be required to get
that to work nicely. Does specifying QEMU and QEMU_IMG prevent make
trying to re-build everything in situ?

>
> Job Naming convention
> ---------------------
>
> Based only on the very simple examples job above, it should already be
> clear that there's a lot of possibility for confusion and chaos.  For
> instance, by looking at the "build" job definition or results, it's
> very hard to tell what's really about.  A bit more could be inferred by
> the "x86_64-block" job name.
>
> Still, the problem we have to address here is not only about the
> amount of information easily obtained from a job name, but allowing
> for very similar job definitions within a global namespace.  For
> instance, if we add an Operating Systems component to the mix, we need
> an extra qualifier for unique job names.
>
> Some of the possible components in a job definition are:
>
>  * Stage
>  * Build profile
>  * Test set (a shorter name for what was described in the "Common set
>    of tests" section)
>  * Host architecture
>  * Target architecture
>  * Host Operating System identification (name and version)
>  * Execution mode/environment (bare metal, container, VM, etc)
>
> Stage
> ~~~~~
>
> The stage of a job (which maps roughly to its purpose) should be
> clearly defined.  A job that builds QEMU should start with "build" and
> a job that tests QEMU should start with "test".
>
> IMO, in a second phase, once multi-stage pipelines are taken for
> granted, we could evaluate dropping this component altogether from the
> naming convention, and relying purely on the stage classification.
>
> Build profile
> ~~~~~~~~~~~~~
>
> Different build profiles already abound in QEMU's various CI
> configuration files.  It's hard to put a naming convention here,
> except that it should represent the most distinguishable
> characteristics of the build configuration.  For instance, we can find
> a "build-disabled" job in the current ".gitlab-ci.yml" file that is
> aptly named, as it forcefully disables a lot of build options.
>
> Test set
> ~~~~~~~~
>
> As mentioned in the "Common set of tests" section, I believe that the
> make target name can be used to identify the test set that will be
> executed in a job.  That is, if a job is to be run at the "test"
> stage, and will run "make check", its name should start with
> "test-check".
>
> QEMU Targets
> ~~~~~~~~~~~~
>
> Because a given job could, and usually do, involve multiple targets, I
> honestly can not think of how to add this to the naming convention.
> I'll ignore it for now, and consider the targets are defined in the
> build profile.

I like to think of three groups:

  Core SoftMMU - the major KVM architectures
  The rest of SoftMMU - all our random emulation targets
  linux-user

>
> Host Architecture
> ~~~~~~~~~~~~~~~~~
>
> The host architecture name convention should be an easy pick, given
> that QEMU itself employes a architecture convention for its targets.
>
> Host OS
> ~~~~~~~
>
> The suggestion I have for the host OS name is to follow the
> libosinfo[10] convention as closely as possible.  libosinfo's "Short
> ID" should be well suitable here.  Examples include: "openbsd4.2",
> "opensuse42.3", "rhel8.0", "ubuntu9.10" and "win2k12r2".
>
> Execution Environment
> ~~~~~~~~~~~~~~~~~~~~~
>
> Distinguishing between running tests in a bare-metal versus a nested
> VM environment is quite significant to a number of people.
>
> Still, I think it could probably be optional for the initial
> implementation phase, like the naming convention for the QEMU Targets.
>
> Example 1
> ~~~~~~~~~
>
> Defining a job that will build QEMU with common debug options, on
> a RHEL 8.0 system on a x86_64 host:
>
>    build-debug-rhel8.0-x86_64:
>      script:
>        - ./configure --enable-debug
>        - make
>
> Example 2
> ~~~~~~~~~
>
> Defining a job that will run the "qtest" test set on a NetBSD 8.1
> system on an aarch64 host:
>
>    test-qtest-netbsd8.1-aarch64:
>      script:
>        - make check-qtest
>
> Job and Machine Scheduling
> --------------------------
>
> While the naming convention gives some information to human beings,
> and hopefully allows for some order and avoids collusions on the
> global job namespace, it's not enough to define where those jobs
> should run.
>
> Tags[11] is the available mechanism to tie jobs to specific machines
> running the GitLab CI agent, "gitlab-runner".  Unfortunately, some
> duplication seems unavoidable, in the sense that some of the naming
> components listed above are machine specific, and will then need to be
> also given as tags.
>
> Note: it may be a good idea to be extra verbose with tags, by having a
> qualifier prefix.  The justification is that tags also live in a
> global namespace, and in theory, at a given point, tags of different
> "categories", say a CPU name and Operating System name may collide.
> Or, it may just be me being paranoid.
>
> Example 1
> ~~~~~~~~~
>
>    build-debug-rhel8.0-x86_64:
>      tags:
>        - rhel8.0
>        - x86_64
>      script:
>        - ./configure --enable-debug
>        - make
>
> Example 2
> ~~~~~~~~~
>
>    test-qtest-netbsd8.1-aarch64:
>      tags:
>        - netbsd8.1
>        - aarch64
>      script:
>        - make check-qtest

Where are all these going to go? Are we overloading the existing
gitlab.yml or are we going to have a new set of configs for the GatingCI
and keep gitlab.yml as the current subset that people run on their own
accounts?

>
> Operating System definition versus Container Images
> ---------------------------------------------------
>
> In the previous section and examples, we're assuming that tests will
> run on machines that have registered "gitlab-runner" agents with
> matching tags.  The tags given at gitlab-runner registration time
> would of course match the same naming convention defined earlier.
>
> So, if one is registering a "gitlab-runner" instance on a x86_64
> machine, running RHEL 8.0, the tags "rhel8.0" and "x86_64" would be
> given (possibly among others).
>
> Nevertheless, most deployment scenarios will probably rely on jobs
> being executed by gitlab-runner's container executor (currently
> Docker-only).  This means that tags given to a job *may* drop the tag
> associated with the host operating system selection, and instead
> provide the ".gitlab-ci.yml" configuration directive that determines
> the container image to be used.
>
> Most jobs would probably *not* require a matching host operating
> system and container images, but there should still be the capability
> to make it a requirement.  For instance, jobs containing tests that
> require the KVM accelerator on specific scenarios may require a
> matching host Operating System.
>
> Note: What was mentioned in the "Execution Environment" section under
> the naming conventions section, is also closely related to this
> requirement, that is, one may require a job to run under a container,
> VM or bare metal.
>
> Example 1
> ~~~~~~~~~
>
> Build QEMU on a "rhel8.0" image hosted under the "qemuci" organization
> and require the runner to support container execution:
>
>    build-debug-rhel8.0-x86_64:
>      tags:
>        - x86_64
>        - container
>      image: qemuci/rhel8.0
>      script:
>        - ./configure --enable-debug
>        - make
>
> Example 2
> ~~~~~~~~~
>
> Run check QEMU on a "rhel8.0" image hosted under the "qemuci"
> organization and require the runner to support container execution and
> be on a matching host:
>
>    test-check-rhel8.0-x86_64:
>      tags:
>        - x86_64
>        - rhel8.0
>        - container
>      image: qemuci/rhel8.0
>      script:
>        - make check
>
> Next
> ----
>
> Because this document is already too long and that can be distracting,
> I decided to defer many other implementation level details to a second
> RFC, alongside some code.
>
> Some completementary topics that I have prepared include:
>
>  * Container images creation, hosting and management
>  * Advanced pipeline definitions
>    - Job depedencies
>    - Artifacts
>    - Results
>  * GitLab CI for Individial Contributors
>  * GitLab runner:
>    - Official and Custom Binaries
>    - Executors
>    - Security implications
>    - Helper container images for non supported architectures
>  * Checklists for:
>    - Preparing and documenting machine setup
>    - Proposing new runners and jobs
>    - Runners and jobs promotions and demotions
>
> Of course any other topics that spurr from this discussion will also
> be added to the following threads.
>
> References:
> -----------
>  [1] https://wiki.qemu.org/Requirements/GatingCI
>  [2] https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04909.html
>  [3] https://docs.gitlab.com/ee/gitlab-basics/add-merge-request.html
>  [4] https://docs.gitlab.com/ee/ci/merge_request_pipelines/pipelines_for_=
merged_results/index.html
>  [5] https://docs.gitlab.com/ee/api/merge_requests.html#create-mr-pipeline
>  [6] https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/ap=
ply-pullreq
>  [7] https://docs.gitlab.com/ee/ci/yaml/README.html#allow_failure
>  [8] https://docs.gitlab.com/ee/ci/yaml/README.html#using-onlychanges-wit=
h-pipelines-for-merge-requests
>  [9] https://github.com/qemu/qemu/blob/fb2246882a2c8d7f084ebe0617e97ac784=
67d156/.gitlab-ci.yml#L70=20
>  [10] https://libosinfo.org/
>  [11] https://docs.gitlab.com/ee/ci/runners/README.html#using-tags


--=20
Alex Benn=C3=A9e

