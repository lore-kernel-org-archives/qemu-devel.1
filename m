Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C839C3524A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 03:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C6420679
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 03:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpYhJ++9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C6420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iySPi-0002Ad-1C
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 22:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iySP3-0001Tj-1F
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iySP1-0004Pt-FE
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:28:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52799
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iySP1-0004Pb-Ak
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580700478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JpUBP0rzWHzrG2IuCdmY/OmpyfaCup3X78R5wRU9/jw=;
 b=hpYhJ++9yyr/IZRN2AhtkENKUV3kIh5bvj3V4IUTarpjb4bSWKxhdr5xke7VSEuND95Z3+
 Re7vJl3bNqKKAyIKc3bPLzAtH3dvr/39tQlGUXXR77VgtLt7JvKa8lxvN23CIpwpntDqaS
 PmdHhFsE0UAun4b1bxW+rnXI5q/C+ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-dePlOIJXPaaQxlbq4X2yZw-1; Sun, 02 Feb 2020 22:27:14 -0500
X-MC-Unique: dePlOIJXPaaQxlbq4X2yZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA9BF800D54;
 Mon,  3 Feb 2020 03:27:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-247.rdu2.redhat.com
 [10.10.120.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E41B5C1D8;
 Mon,  3 Feb 2020 03:27:02 +0000 (UTC)
Date: Sun, 2 Feb 2020 22:27:00 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] QEMU Gating CI
Message-ID: <20200203032700.GA12127@localhost.localdomain>
References: <20191202140552.GA5353@localhost.localdomain>
 <CAFEAcA--Rag8JzvPP+Pvkebv1ifeZkpcx7zSXdDBkpZWmpZwxQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA--Rag8JzvPP+Pvkebv1ifeZkpcx7zSXdDBkpZWmpZwxQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2020 at 02:33:54PM +0000, Peter Maydell wrote:
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
> Happy New Year! Now we're in 2020, any chance of an update on
> plans/progress here? I would very much like to be able to hand
> processing of pull requests over to somebody else after the
> 5.0 cycle, if not before. (I'm quite tempted to make that a
> hard deadline and just say that somebody else will have to
> pick it up for 5.1, regardless...)
>=20
> thanks
> -- PMM
>=20

Hi Peter,

Last time I believe the take was to be as simplistic as possible, and
try to focus on the bare mininum necessary to implement the workflow
you described[1].  The following lines preceded by ">>>" were
extracted from the Wiki and will be used to explain those points.

   >>> The set of machine I currently test on are:
   >>>
   >>>  * an S390x box (this is provided to the project by IBM's Community
   >>>    Cloud so can be used for the new CI setup)
   >>>  * aarch32 (as a chroot on an aarch64 system)
   >>>  * aarch64
   >>>  * ppc64 (on the GCC compile farm)

I've built an updated gitlab-runner version for s390x, aarch64 and
ppc64[2].  I've now tested its behavior with the shell executor
(instead of docker) on aarch64 and ppc64.  I did not get a chance yet
to test this new version and executor with s390x, but I'm planning
to do it soon.

   >>>  * OSX
   >>>  * Windows crossbuilds
   >>>  * NetBSD, FreeBSD and OpenBSD using the tests/vm VMs

gitlab-runner clients are available for Darwin, Windows (native)
and FreeBSD.  I have *not* tested any of those, though.   I've
tried a Windows crossbuild, and with the right packages installed,
and worked like a charm on a Fedora machine.

   >>>  * x86-64 Linux with a variety of different build configs (see the
   >>>    'remake-merge-builds' script for how these are set up)

This is of course the more standard setup for gitlab-runner, and the
bulk of the work that I'm posting here is related to those different
build configs.  I assumed those x86-64 machines had some sort version
of Ubuntu, so I used 18.04.3 LTS.  Hopefully it maches most or all of
the current environment.  Please refer to messages on the mailing list
with $SUBJECT:

 [RFC PATCH 1/2] GitLab CI: avoid calling before_scripts on unintended jobs
 [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs

There are few question in there which I'd appreciate help with.

   >>> Testing process:
   >>>
   >>>  * I get an email which is a pull request, and I run the
   >>>    "apply-pullreq" script, which takes the GIT URL and tag/branch na=
me
   >>>    to test.
   >>>  * apply-pullreq performs the merge into a 'staging' branch
   >>>  * apply-pullreq also performs some simple local tests:
   >>>     * does git verify-tag like the GPG signature?
   >>>     * are we trying to apply the pull before reopening the dev tree
   >>>       for a new release?
   >>>     * does the pull include commits with bad UTF8 or bogus qemu-deve=
l
   >>>       email addresses?
   >>>     * submodule updates are only allowed if the --submodule-ok optio=
n
   >>>       was specifically passed

These steps could go unchanged at this point.  One minor remark is
that the repo hosted at gitlab.com would be used instead.  The
'staging' branch can be protected[4] so that only authorized people
can do it (and trigger the pipeline and its jobs).

   >>>  * apply-pullreq then invokes parallel-buildtest to do the actual
   >>>    testing

This would be done by GitLab instead.  The dispatching of jobs is
based on the tags given to jobs and machines.  IMO at least the OS
version and architecture should be given as tags, and the machine
needs proper setup to run a job, such as having the right packages
installed.  It can start with a proper documentation for every type of
OS and version (and possibly job type), and evolve into scripts
or other type of automation.

These are usuall identical or very similar to what is defined in
"tests/docker/dockerfiles", but need to be done at the machine level
because of the "shell" executor.

   >>>  * parallel-buildtest is a trivial wrapper around GNU Parallel which
   >>>    invokes 'mergebuild' on each of the test machines
   >>>  * if all is OK then the user gets to do the 'git push' to push the
   >>>    staging branch to master

The central place to check for success or failure would be the
pipeline page.  Also, there's a configurable notification system that
should (I've not tested it throughly) send failed and/or successful
pipeline results to the pipeline author.  IIUC, this means whoever
pushed to the 'staging' branch that caused the pipeline to be
triggered.

Let me know if this makes sense to you, and if so, we can arrange
a real world PoC.  FIY, I've run hundreds of jobs in an internal
GitLab instance, and GitLab itself (server and runner) seems very
stable.

Regards,
- Cleber.

---

[1] - https://wiki.qemu.org/Requirements/GatingCI
[2] - https://cleber.fedorapeople.org/gitlab-runner/v12.7.0/
[3] - https://docs.gitlab.com/runner/install/bleeding-edge.html#download-th=
e-standalone-binaries
[4] - https://docs.gitlab.com/ee/user/project/protected_branches.html
[5] - https://docs.gitlab.com/ee/user/profile/notifications.html#issue--epi=
cs--merge-request-events

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl43kwAACgkQZX6NM6Xy
CfMJhA/7BdNFD5y1EEd4sbsVz/DU7ZZRy2fAQ97TovMJXIBlyJFaQkFBYujocFec
aMByCRwjzxvZCaepq6ww1rBZX7Z6iuqEaqHeDYXCSO+pAewajqEQ8HGNbcPm3itX
TlR/JblzvkGfQ3DFGdZg8JkYNhhWEUZ5AGkj72Iv8PSmhC8UpZfFhMWtUixFmcDj
nZUGi5yj8POWpMSX6WUaAIZCm4xfES0tF8RS9G46OTXteLuvkYajfbLHAWTw+JRZ
aoz15+vuys0B+nuuOZ9a7wzF4MgMKIx/e+WlpMPPKJKB6AaF4txWNXfp0SwjLHSv
ifXbIJGRX5gc60BmMHNJeu0rEbxlNje172+FxjQzOlyRDKkeSb1XI0n0PFXzO7L6
K/cBrzOcgBwPzI0luODaoCGLoVKB/QitJiaJ89UC6HbGbyqIyTWtOtrENIaulJvB
TEr1zPVO5KYfi9pj6SoV1OyVD7D42jw0YH/iSeP8ECieUBfr1KB80F+2GuS4Nnj4
pu4ir0BT75I/NAOENp1U/dAHmYt73wEwNuHzC7C2W2PXqtYjVm2q2PGXq3v1ccyi
Y0AeLI+8SdJTBCK4y4cAi9KKAF2np1Fz2bEk0R42E6StbbjOz3ZJA+1Batqf27wl
CGON8bb8pGK295F1jOD1Og2OeE61tQdx6BgQoKSMYCoT9XaS12E=
=95RK
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--


