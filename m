Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B3FC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF60206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF60206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kh6-0005qd-VC
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i0kfL-0004JM-Re
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i0kfK-0001fr-34
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:50:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59612)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i0kfJ-0001ef-QY
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:50:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 240A8307D930;
 Thu, 22 Aug 2019 10:49:59 +0000 (UTC)
Received: from localhost (ovpn-117-251.ams2.redhat.com [10.36.117.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE30610016EA;
 Thu, 22 Aug 2019 10:49:58 +0000 (UTC)
Date: Thu, 22 Aug 2019 11:49:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190822104957.GE20491@stefanha-x1.localdomain>
References: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 22 Aug 2019 10:49:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] more automated/public CI for QEMU pullreqs
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2019 at 07:16:55PM +0100, Peter Maydell wrote:
> We had a conversation some months back about ways we might switch
> away from the current handling of pull requests which I do via some
> hand-curated scripts and personal access to machines, to a more
> automated system that could be operated by a wider range of people.
> Unfortunately that conversation took place off-list (largely my fault
> for forgetting a cc: at the beginning of the email chain), and in any
> case it sort of fizzled out.  So let's restart it, on the mailing
> list this time.
>=20
> Here's a summary of stuff from the old thread and general
> explanation of the problem:
>=20
> My current setup is mostly just running the equivalent of
> "make && make check" on a bunch of machines and configs
> on the merge commit before I push it to master. I also do
> a 'make check-tcg' on one of the builds and run a variant
> of the 'linux-user-test' tarball of 'ls' binaries.
> The scripts do some simple initial checks which mostly are
> preventing problems seen in the past:
>  * don't allow submodules to be updated unless I kick the
>    merge off with a command line option saying submodule updates
>    are OK here (this catches accidental misdriving of git by
>    a submaintainer folding a submodule change into a patch
>    during a rebase)
>  * check we aren't trying to merge after tagging the final
>    release but before doing the 'reopen development tree'
>    commit that bumps the VERSION file
>  * check for bogus "author is qemu-devel@nongnu.org" commits
>  * check for UTF-8 mangling
>  * check the gpg signature on the pullreq
> A human needs to also eyeball the commits and the diffstat
> for weird stuff (usually cursory for frequent pullreq submitters,
> and more carefully for new submaintainers).
>=20
> I have this semi-automated with some hacky scripts.  The major thing we
> need for a replacement is the coverage of different host
> architectures and operating systems, which is a poor match to most of
> the cloud-CI services out there (including Travis).  We also want the
> tests to run in a reasonably short wall-clock time from being kicked
> off.
>=20
> Awkward bonus extra requirement: it would be useful to be
> able to do a merge CI run "privately", eg because the thing
> being tested is a fix for a security bug that's not yet
> public. But that's rare so we can probably do it by hand.
>=20
> There are some other parts to this, like getting some kind of
> project-role-account access to machines where that's OK, or finding
> replacements where the machines really are my personal ones or
> otherwise not OK for project access.  But I think that should be
> fairly easy to resolve so let's keep this thread to the
> automating-the-CI part.
>=20
> The two major contenders suggested were:
>=20
> (1) GitLab CI, which supports custom 'runners' which we can set
> up to run builds and tests on machines we have project access to
>=20
> (2) Patchew, which can handle running tests on multiple machines (eg
> we do s390 testing today for all patches on list), and which we could
> enhance to provide support for the release-manager to do their work
>=20
> Advantages of Gitlab CI:
>  * somebody else is doing the development and maintainance of the
>    CI tool -- bigger 'bus factor' than patchew
>  * already does (more or less) what we want without needing
>    extra coding work
>=20
> Advantages of Patchew:
>  * we're already using it for patch submissions, so we know it's
>    not going to go away
>  * it's very easy to deploy to a new host
>  * no dependencies except Python, so works anywhere we expect
>    to be able to build QEMU (whereas gitlab CI's runner is
>    written in Go, and there seem to be ongoing issues with getting
>    it actually to compile for other architectures than x86)
>=20
> I don't have an opinion really, but I think it would be good to
> make a choice and start working forwards towards getting this
> a bit less hacky and a bit more offloadable to other people.
>=20
> Perhaps a good first step would be to keep the 'simple checks
> of broken commits' part done as a local script but have the
> CI done via "push proposed merge commit to $SOMEWHERE to
> kick off the CI".
>=20
> Input, opinions, recommendations, offers to do some of the work? :-)

Thanks for writing up this summary!  The requirements and possible
solutions are now clear.

We need someone willing to set up and maintain the CI.

One-off tasks:

1. Create CI runners that offer similar cross-architecture coverage to
   Peter's current setup.  qemu.org has some x86, ppc, and s390 server
   resources available.  I'm not sure about ARM and other architectures.

2. Write CI configuration to run Peter's "make && make check && make
   check-tcg && linux-user-test".

3. Document the CI on wiki.qemu.org.

Ongoing responsibilities:

1. Triage failures that the qemu.git maintainer thinks are related to CI
   runners.

2. Keep the CI up-to-date and runners online.

Any volunteers?

Stefan

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ec1UACgkQnKSrs4Gr
c8jE9wgAyXzQlbwWVgaVfkNlRcMxKcOVxUlWwOLDcewg90rUMCAXzdF9h2KLGr1P
tZOA6YE6RgOmRSpQbuLG5lC054X6OoCgdNy2X2Lsk4KKiQGwwjrFw2lZETrgduv5
HFZ/MGjaS6CM65crnkY+Z9fVio1hz5EpqmJEOLzk+ypOkpiiaOD0up3kAJEgrHxk
ZJf3rinqZLf4c5fqlnnd8pd5AIiJ+ussomoJmUmepk25/j2Zd+zHS02R/8pRsHuD
DjEy10sKXVmBaMsPBjthN717M7wkQrmlwWdS/2ZU3oHgOOubJOv3QaTZadaA+owj
xhBK0yLd24doCxdK/nQ33a/VrQvQhQ==
=wPPJ
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--

