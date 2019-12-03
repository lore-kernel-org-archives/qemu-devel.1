Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F272C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76E120674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCeaC2DG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76E120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic95T-0000m7-PS
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 09:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ic8xl-0005vJ-Tr
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ic8xd-0005gO-09
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:15:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ic8xa-0005bS-0Z
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575382523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2EvUkgUoElt+4gOecoHRs8opscjw0lyEi06Co2MPp3o=;
 b=GCeaC2DGnYb7PoV9OdmUEtHxGbX2JguMxFlylBbR+5uxDyWMNIt6YJjA5r20Ho6lk57Whd
 DIXfM1ADw0B6ejLdbZ92Lu9zUFpowJrS9TM7UBQ0Qe8kqx4tXYughsExZmHez1DBeZlxn3
 HwTb5oFtgUEeJtwLjaHAM785L1MNzhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-LYhuw10fOQyuAbk8ZHxnQg-1; Tue, 03 Dec 2019 09:15:14 -0500
X-MC-Unique: LYhuw10fOQyuAbk8ZHxnQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3877593B4;
 Tue,  3 Dec 2019 14:15:13 +0000 (UTC)
Received: from localhost (ovpn-116-133.ams2.redhat.com [10.36.116.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04AD0600C8;
 Tue,  3 Dec 2019 14:15:00 +0000 (UTC)
Date: Tue, 3 Dec 2019 14:14:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC] QEMU Gating CI
Message-ID: <20191203141456.GB230219@stefanha-x1.localdomain>
References: <20191202140552.GA5353@localhost.localdomain>
 <20191202170018.GD139090@stefanha-x1.localdomain>
 <20191202181254.GA20551@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191202181254.GA20551@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
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

--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2019 at 01:12:54PM -0500, Cleber Rosa wrote:
> On Mon, Dec 02, 2019 at 05:00:18PM +0000, Stefan Hajnoczi wrote:
> > On Mon, Dec 02, 2019 at 09:05:52AM -0500, Cleber Rosa wrote:
> > > RFC: QEMU Gating CI
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Excellent, thank you for your work on this!
> >=20
> > >=20
> > > This RFC attempts to address most of the issues described in
> > > "Requirements/GatinCI"[1].  An also relevant write up is the "State o=
f
> > > QEMU CI as we enter 4.0"[2].
> > >=20
> > > The general approach is one to minimize the infrastructure maintenanc=
e
> > > and development burden, leveraging as much as possible "other people'=
s"
> > > infrastructure and code.  GitLab's CI/CD platform is the most relevan=
t
> > > component dealt with here.
> > >=20
> > > Problem Statement
> > > -----------------
> > >=20
> > > The following is copied verbatim from Peter Maydell's write up[1]:
> > >=20
> > > "A gating CI is a prerequisite to having a multi-maintainer model of
> > > merging. By having a common set of tests that are run prior to a merg=
e
> > > you do not rely on who is currently doing merging duties having acces=
s
> > > to the current set of test machines."
> > >=20
> > > This is of a very simplified view of the problem that I'd like to bre=
ak
> > > down even further into the following key points:
> > >=20
> > >  * Common set of tests
> > >  * Pre-merge ("prior to a merge")
> > >  * Access to the current set of test machines
> > >  * Multi-maintainer model
> > >=20
> > > Common set of tests
> > > ~~~~~~~~~~~~~~~~~~~
> > >=20
> > > Before we delve any further, let's make it clear that a "common set o=
f
> > > tests" is really a "dynamic common set of tests".  My point is that a
> > > set of tests in QEMU may include or exclude different tests depending
> > > on the environment.
> > >=20
> > > The exact tests that will be executed may differ depending on the
> > > environment, including:
> > >=20
> > >  * Hardware
> > >  * Operating system
> > >  * Build configuration
> > >  * Environment variables
> > >=20
> > > In the "State of QEMU CI as we enter 4.0" Alex Benn=E9e listed some o=
f
> > > those "common set of tests":
> > >=20
> > >  * check
> > >  * check-tcg
> > >  * check-softfloat
> > >  * check-block
> > >  * check-acceptance
> > >=20
> > > While Peter mentions that most of his checks are limited to:
> > >=20
> > >  * check
> > >  * check-tcg
> > >=20
> > > Our current inability to quickly identify a faulty test from test
> > > execution results (and specially in remote environments), and act upo=
n
> > > it (say quickly disable it on a given host platform), makes me believ=
e
> > > that it's fair to start a gating CI implementation that uses this
> > > rather coarse granularity.
> > >=20
> > > Another benefit is a close or even a 1:1 relationship between a commo=
n
> > > test set and an entry in the CI configuration.  For instance, the
> > > "check" common test set would map to a "make check" command in a
> > > "script:" YAML entry.
> > >=20
> > > To exemplify my point, if one specific test run as part of "check-tcg=
"
> > > is found to be faulty on a specific job (say on a specific OS), the
> > > entire "check-tcg" test set may be disabled as a CI-level maintenance
> > > action.  Of course a follow up action to deal with the specific test
> > > is required, probably in the form of a Launchpad bug and patches
> > > dealing with the issue, but without necessarily a CI related angle to
> > > it.
> >=20
> > I think this coarse level of granularity is unrealistic.  We cannot
> > disable 99 tests because of 1 known failure.  There must be a way of
> > disabling individual tests.  You don't need to implement it yourself,
> > but I think this needs to be solved by someone before a gating CI can b=
e
> > put into use.
> >
>=20
> IMO it should be realistic if you look at it from a "CI related
> angle".  The pull request could still be revised and disable a single
> test because of a known failure, but this would not be necessarily
> related to the CI.

That sounds fine, thanks.  I interpreted the text a little differently.
I agree this functionality doesn't need to present in order to move to
GitLab.

>=20
> > It probably involves adding a "make EXCLUDE_TESTS=3Dfoo,bar check"
> > variable so that .gitlab-ci.yml can be modified to exclude specific
> > tests on certain OSes.
> >
>=20
> I certainly acknowledge the issue, but I don't think this (and many
> other issues that will certainly come up) should be a blocker to the
> transition to GitLab.
>=20
> > >=20
> > > If/when test result presentation and control mechanism evolve, we may
> > > feel confident and go into finer grained granularity.  For instance, =
a
> > > mechanism for disabling nothing but "tests/migration-test" on a given
> > > environment would be possible and desirable from a CI management leve=
l.
> > >=20
> > > Pre-merge
> > > ~~~~~~~~~
> > >=20
> > > The natural way to have pre-merge CI jobs in GitLab is to send "Merge
> > > Requests"[3] (abbreviated as "MR" from now on).  In most projects, a
> > > MR comes from individual contributors, usually the authors of the
> > > changes themselves.  It's my understanding that the current maintaine=
r
> > > model employed in QEMU will *not* change at this time, meaning that
> > > code contributions and reviews will continue to happen on the mailing
> > > list.  A maintainer then, having collected a number of patches, would
> > > submit a MR either in addition or in substitution to the Pull Request=
s
> > > sent to the mailing list.
> > >=20
> > > "Pipelines for Merged Results"[4] is a very important feature to
> > > support the multi-maintainer model, and looks in practice, similar to
> > > Peter's "staging" branch approach, with an "automatic refresh" of the
> > > target branch.  It can give a maintainer extra confidence that a MR
> > > will play nicely with the updated status of the target branch.  It's
> > > my understanding that it should be the "key to the gates".  A minor
> > > note is that conflicts are still possible in a multi-maintainer model
> > > if there are more than one person doing the merges.
> >=20
> > The intention is to have only 1 active maintainer at a time.  The
> > maintainer will handle all merges for the current QEMU release and then
> > hand over to the next maintainer after the release has been made.
> >=20
> > Solving the problem for multiple active maintainers is low priority at
> > the moment.
> >
>=20
> Even so, I have the impression that the following workflow:
>=20
>  - Look at Merge Results Pipeline for MR#1
>  - Merge MR #1
>  - Hack on something else
>  - Look at *automatically updated* Merge Results Pipeline for MR#2
>  - Merge MR #2
>=20
> Is better than:
>=20
>  - Push PR #1 to staging
>  - Wait for PR #1 Pipeline to finish
>  - Look at PR #1 Pipeline results
>  - Push staging into master
>  - Push PR #2 to staging=20
>  - Wait for PR #2 Pipeline to finish
>  - Push staging into master
>=20
> But I don't think I'll be a direct user of those workflows, so I'm
> completely open to feedback on it.

If the goal is to run multiple trees through the CI in parallel then
multiple branches can be used.  I guess I'm just

>=20
> > > A worthy point is that the GitLab web UI is not the only way to creat=
e
> > > a Merge Request, but a rich set of APIs are available[5].  This is
> > > interesting for many reasons, and maybe some of Peter's
> > > "apply-pullreq"[6] actions (such as bad UTF8 or bogus qemu-devel emai=
l
> > > addresses checks could be made earlier) as part of a
> > > "send-mergereq"-like script, bringing conformance earlier on the merg=
e
> > > process, at the MR creation stage.
> > >=20
> > > Note: It's possible to have CI jobs definition that are specific to
> > > MR, allowing generic non-MR jobs to be kept on the default
> > > configuration.  This can be used so individual contributors continue
> > > to leverage some of the "free" (shared) runner made available on
> > > gitlab.com.
> >=20
> > I expected this section to say:
> > 1. Maintainer sets up a personal gitlab.com account with a qemu.git for=
k.
> > 2. Maintainer adds QEMU's CI tokens to their personal account.
> > 3. Each time a maintainer pushes to their "staging" branch the CI
> >    triggers.
> >=20
> > IMO this model is simpler than MRs because once it has been set up the
> > maintainer just uses git push.  Why are MRs necessary?
> >
>=20
> I am not sure GitLab "Specific Runners" can be used from other
> accounts/forks.  AFAICT, you'd need a MR to send jobs that would run
> on those machines, because (again AFAICT) the token used to register
> those gitlab-runner instances on those machines is not shareable
> across forks.  But, I'll double check that.

Another question:
Is a Merge Request necessary in order to trigger the CI or is just
pushing to a branch enough?  With GitHub + Travis just pushing is
enough.

Stefan

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3mbeAACgkQnKSrs4Gr
c8j0awgAvuLHUZg5rYvm4mZF1kTM5EU/SO6u3U0w3ijmz2pcbo0j1rgycUgGmngz
8vrB+GNhhRBrxVTYJoLUsTkAwc9yQrQEJQbSy5iswlw//EdGZzQJ/MqcaiWYNYDA
Z+mB3qEVvJS1H6VihVBVnWGLqtkOBDLeI0XkK/i9bGxCR/hoBtqR+Tt1wUaQfC4B
izAabFE2zhuaGGHJRNsWmTssOd6/6y85kdLAL6XdpERaUFRnH4jlpgEdGjIK/uxJ
yLB0FxlkSucBjkgXv6uHF2nS1kS//1hK0weqt3UM0RBFYtIF0X66Wi4+QR+rceZn
r+btyJdPwl3yDT1r/aYurffpKlGnPA==
=1e+B
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--


