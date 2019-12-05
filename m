Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D886CC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 05:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABCF206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 05:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7WfDctZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABCF206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icjLu-0001nx-Pu
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 00:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1icjKp-0000v2-6j
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 00:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1icjKm-0002Ik-31
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 00:05:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38571
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1icjKl-0002Fm-Ga
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 00:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575522346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Su50AQySwUQzDkyzjok5Ulxx+oWaZqAM79M+cL2fXno=;
 b=S7WfDctZh7hR6QInKveOiTp1donmfiB///iYSDzcxROlnqXIPRI2izAdHFxCVPmUmR5OUV
 okZB5fbhbqE9LDbL8fSOIa8r/935Z7iLb4a3Ivt1LXNFnSEnpN5Di8tl75IgSa26QyR+JY
 BkoDu0XCXmSniMfDcJBxR47uJIdfGI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-rhKp8iiNNryHoOrM9AE1tg-1; Thu, 05 Dec 2019 00:05:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 221871005509;
 Thu,  5 Dec 2019 05:05:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-37.rdu2.redhat.com
 [10.10.125.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8E1E5D9C5;
 Thu,  5 Dec 2019 05:05:38 +0000 (UTC)
Date: Thu, 5 Dec 2019 00:05:37 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] QEMU Gating CI
Message-ID: <20191205050537.GA19290@localhost.localdomain>
References: <20191202140552.GA5353@localhost.localdomain>
 <CAFEAcA-pOBjia36W3n1Sz-5EsUfT8gkzzn2Gpb7J6Zrjfbu6XQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-pOBjia36W3n1Sz-5EsUfT8gkzzn2Gpb7J6Zrjfbu6XQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: rhKp8iiNNryHoOrM9AE1tg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 03, 2019 at 05:54:38PM +0000, Peter Maydell wrote:
> On Mon, 2 Dec 2019 at 14:06, Cleber Rosa <crosa@redhat.com> wrote:
> >
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
>=20
> Thanks for writing up this RFC.
>=20
> My overall view is that there's some interesting stuff in
> here and definitely some things we'll want to cover at some
> point, but there's also a fair amount that is veering away
> from solving the immediate problem we want to solve, and
> which we should thus postpone for later (beyond making some
> reasonable efforts not to design something which paints us
> into a corner so it's annoyingly hard to improve later).
>

Right.  I think this is a valid perspective to consider as we define
the order and scope of thanks.  I'll follow up with a more
straightforward suggestion with the bare minimum actions for a first
round.

> > To exemplify my point, if one specific test run as part of "check-tcg"
> > is found to be faulty on a specific job (say on a specific OS), the
> > entire "check-tcg" test set may be disabled as a CI-level maintenance
> > action.  Of course a follow up action to deal with the specific test
> > is required, probably in the form of a Launchpad bug and patches
> > dealing with the issue, but without necessarily a CI related angle to
> > it.
> >
> > If/when test result presentation and control mechanism evolve, we may
> > feel confident and go into finer grained granularity.  For instance, a
> > mechanism for disabling nothing but "tests/migration-test" on a given
> > environment would be possible and desirable from a CI management level.
>=20
> For instance, we don't have anything today for granularity of
> definition of what tests we run where or where we disable them.
> So we don't need it in order to move away from the scripting
> approach I have at the moment. We can just say "the CI system
> will run make and make check (and maybe in some hosts some
> additional test-running commands) on these hosts" and hardcode
> that into whatever yaml file the CI system's configured in.
>

I absolutely agree.  That's why I even considered *if* this will done,
and not only *when*.  Because I happen to be biased from working on a
test runner/framework, this is something that I had to at least talk
about, so that it can be evaluated and maybe turned into a goal.

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
>=20
> Eventually it would be nice to allow any submaintainer
> to send a merge request to the CI system (though you would
> want it to have a "but don't apply until somebody else approves it"
> gate as well as the automated testing part). But right now all
> we need is for the one person managing merges and releases
> to be able to say "here's the branch where I merged this
> pullrequest, please test it". At any rate, supporting multiple
> submaintainers all talking to the CI independently should be
> out of scope for now.
>

OK, noted.

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
>=20
> All this stuff is not needed to start with. We cope at the
> moment with "everything is gating, and if something doesn't
> pass it needs to be fixed or manually removed from the setup".
>

OK, I get your point.  But, I think it's fair to say though, that one
big motivation that we also have for this work, is to be able to
provide new machines and jobs into the Gating CI in the very near
future.  And to do that, we must set common rules so that anyone
else can do the same and abide by the same terms.

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
> > run in parallel.
>=20
> We could do this, but we don't do it today, so we don't need
> to think about this at all to start with.
>

So, in your opinion, this is phase >=3D 1 material.  Noted.

> > In theory, there's nothing that prevents an entire QEMU build
> > directory, to be treated as an artifact.  In practice, there are
> > predefined limits on GitLab that prevents that from being possible,
>=20
> ...so we don't need to worry about somehow defining some
> cut-down "build artefact" that we provide to the testing
> phase. Just do a build and test run as a single thing.
> We can always come back and improve later.
>=20
>=20
> Have you been able to investigate and confirm that we can
> get a gitlab-runner setup that works on non-x86 ? That seems
> to me like an important thing we should be confident about
> early before we sink too much effort into a gitlab-based
> solution.
>

I've successfully built gitlab-runner and run jobs on aarch64, ppc64le
and s390x.  The binaries are available here:

   https://cleber.fedorapeople.org/gitlab-runner/v12.4.1/

But, with the "shell" executor (given that Docker helper images are
not available for those architectures).  I don't think we'd have to
depend on GitLab providing those images though, it should be possible
to create them for different architectures and tweak the gitlab-runner
code to use different image references on those architectures.

Does this answer this specific question?

Best,
- Cleber.

> thanks
> -- PMM
>=20


