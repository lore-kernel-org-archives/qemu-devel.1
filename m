Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E86EC5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 17:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9C620665
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 17:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9C620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhe0f-0000mr-8J
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 13:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33285)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hhdzF-0000K4-HU
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 13:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hhdzD-0005fv-GE
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 13:51:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hhdzD-0005fW-7f
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 13:51:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C427309175E;
 Sun, 30 Jun 2019 17:51:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-238.rdu2.redhat.com
 [10.10.120.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D03DC1001B21;
 Sun, 30 Jun 2019 17:51:27 +0000 (UTC)
Date: Sun, 30 Jun 2019 13:51:26 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <20190630175126.GC2820@localhost.localdomain>
References: <20190621060925.16214-1-crosa@redhat.com>
 <20190621060925.16214-2-crosa@redhat.com>
 <f18a5df8-201e-b8a1-1a3e-3e2254ce8b1e@redhat.com>
 <20190621143816.GA24282@localhost.localdomain>
 <785c89ed-a7a4-78f6-972a-e36615017268@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <785c89ed-a7a4-78f6-972a-e36615017268@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Sun, 30 Jun 2019 17:51:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] Acceptance tests: exclude "flaky" tests
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 28, 2019 at 05:43:09PM -0300, Wainer dos Santos Moschetta wro=
te:
>=20
> On 06/21/2019 11:38 AM, Cleber Rosa wrote:
> > On Fri, Jun 21, 2019 at 09:03:33AM +0200, Philippe Mathieu-Daud=E9 wr=
ote:
> > > On 6/21/19 8:09 AM, Cleber Rosa wrote:
> > > > It's a fact that some tests may not be 100% reliable in all
> > > > environments.  While it's a tough call to remove a useful test th=
at
> > > > from the tree because it may fail every 1/100th time (or so), hav=
ing
> > > > human attention drawn to known issues is very bad for humans and =
for
> > > > the projects they manage.
> > > >=20
> > > > As a compromise solution, this marks tests that are known to have
> > > > issues, or that exercises known issues in QEMU or other component=
s,
> > > > and excludes them from the entry point.  As a consequence, tests
> > > > marked as "flaky" will not be executed as part of "make
> > > > check-acceptance".
> > > >=20
> > > > Because such tests should be forgiven but never be forgotten, it'=
s
> > > > possible to list them with (assuming "make check-venv" or "make
> > > > check-acceptance" has already initiatilized the venv):
> > > >=20
> > > >    $ ./tests/venv/bin/avocado list -t flaky tests/acceptance
>=20
> It needs a Make target to run those flaky tests (If we ever agree on th=
is
> idea of flaky tests). Other Avocado flags are passed (e.g. -t for tags)=
 that
> can happen to fail tests on their absent. One clear example is the spic=
e
> test on patch 02 of this series...
>

I was trying to avoid having so make "check-acceptance-*" rules that just
choosing one would be harder than writing an Avocado command line from
scratch... but I think you have a point here.  For once, this can be
used in a Travis job with an special "allow_failures" option set.

> Side note: check-acceptance seems to get growing in complexity that I w=
orry
> will end up in pitfalls. is a Make target the proper way to implement
> complex test runs (I don't think so). Perhaps Avocado runner concept co=
uld
> help somehow?
>

I guess you mean the Avocado Job concept, and writing your own runner
based on those APIs.  If so, then absolutely yes.  I've shared with
Eduardo some of the use cases that we can solve much easily.  But, we
need to finish the last bits on the Avocado side, properly document
and support the API before attempting to use it here on QEMU.

> > > >=20
> > > > The current list of tests marked as flaky are a result of running
> > > > the entire set of acceptance tests around 20 times.  The results
> > > > were then processed with a helper script[1].  That either confirm=
ed
> > > > known issues (in the case of aarch64 and arm)[2] or revealed new
> > > > ones (mips).
> > > >=20
> > > > This also bumps the Avocado version to one that includes a fix to=
 the
> > > > parsing of multiple and mix "key:val" and simple tag values.
> > > >=20
> > > > [1] https://raw.githubusercontent.com/avocado-framework/avocado/m=
aster/contrib/scripts/summarize-job-failures.py
> > > > [2] https://bugs.launchpad.net/qemu/+bug/1829779
> > > >=20
> > > > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > > > ---
> > > >   docs/devel/testing.rst                   | 17 +++++++++++++++++
> > > >   tests/Makefile.include                   |  6 +++++-
> > > >   tests/acceptance/boot_linux_console.py   |  2 ++
> > > >   tests/acceptance/linux_ssh_mips_malta.py |  2 ++
> > > >   tests/requirements.txt                   |  2 +-
> > > >   5 files changed, 27 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> > > > index da2d0fc964..ff4d8e2e1c 100644
> > > > --- a/docs/devel/testing.rst
> > > > +++ b/docs/devel/testing.rst
> > > > @@ -574,6 +574,23 @@ may be invoked by running:
> > > >     tests/venv/bin/avocado run $OPTION1 $OPTION2 tests/acceptance=
/
> > > > +Tagging tests
> > > > +-------------
> > > > +
> > > > +flaky
> > > > +~~~~~
> > > > +
> > > > +If a test is known to fail intermittently, even if only every on=
e
> > > > +hundredth time, it's highly advisable to mark it as a flaky test=
.
> > > > +This will prevent these individual tests from failing much large=
r
> > > > +jobs, will avoid human interaction and time wasted to verify a k=
nown
> > > > +issue, and worse of all, can lead to the discredit of automated
> > > > +testing.
> > > > +
> > > > +To mark a test as flaky, add to its docstring.::
> > > > +
> > > > +  :avocado: tags=3Dflaky
> > > I certainly disagree with this patch, failing tests have to be fixe=
d.
> > > Why not tag all the codebase flaky and sing "happy coding"?
> > >=20
> > That's a great idea! :)
> >=20
> > Now, seriously, I also resisted this for quite a long time.  The
> > reality, though, is that intermittent failures will continue to
> > appear, and letting tests (and jobs, and CI pipelines, and whatnot)
> > fail is a very bad idea.  We all agree that real fixes are better tha=
n
> > this, but many times they don't come quickly.
>=20
> It seems to me that flaky test is just a case in a broaden scenario: ru=
n (or
> not) grouped tests. You may have tests indeed broken or that takes
> considerable time (those tagged "slow") which one may fairly want to ex=
clude
> from `make check-acceptance` as well. Thus some way to group tests plus
> define run inclusion/exclusion patterns seems the ultimate goal here.
>

Yes, you have a point about "yet another set of tests".  I think that,
whenever we break the limit of expressiveness with something like the
current incarnation of tags (which shouldn't need much explanation)
then it's time to rely on something that has all the expressiveness
and doesn't impose any other restrictions.

I'm refering to the previous idea about using the Job API, and
creating customized runner that, with the expressiveness of Python
code, can choose tests for different scenarios.  What I don't think
we should try to do, is to come up with yet another language, or YAML
parser, or anything along those lines.

> >=20
> > > Anyway if this get accepted, 'flaky' tags must have the intermitten=
t
> > > failure well described, and a Launchpad/Bugzilla tracking ticket re=
ferenced.
> > >=20
> > And here you have a key point that I absolutely agree with.  The
> > "flaky" approach can either poison a lot of tests, and be seen as
> > quick way out of a difficult issue revealed by a test.  Or, it can
> > serve as an effective tool to keep track of these very important
> > issues.
> >=20
> > If we add:
> >=20
> >     # https://bugs.launchpad.net/qemu/+bug/1829779
> >     :avocado: flaky
> >=20
> > Topped with some human, I believe this can be very effective.  This g=
oes
> > without saying, but comments here are very much welcome.
>=20
> I agree that all flaky test should have a tracking bug. In the end it
> represents a technical debit that we should address.
>=20
> - Wainer
>

Yep, that I also agree 100%.
- Cleber.

> >=20
> > - Cleber.
> >=20
> > > > +
> > > >   Manual Installation
> > > >   -------------------
> > > > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > > > index db750dd6d0..4c97da2878 100644
> > > > --- a/tests/Makefile.include
> > > > +++ b/tests/Makefile.include
> > > > @@ -1125,7 +1125,11 @@ TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/res=
ults
> > > >   # Any number of command separated loggers are accepted.  For mo=
re
> > > >   # information please refer to "avocado --help".
> > > >   AVOCADO_SHOW=3Dapp
> > > > -AVOCADO_TAGS=3D$(patsubst %-softmmu,-t arch:%, $(filter %-softmm=
u,$(TARGET_DIRS)))
> > > > +
> > > > +# Additional tags that are added to each occurence of "--filter-=
by-tags"
> > > > +AVOCADO_EXTRA_TAGS :=3D ,-flaky
> > > > +
> > > > +AVOCADO_TAGS=3D$(patsubst %-softmmu,--filter-by-tags=3Darch:%$(A=
VOCADO_EXTRA_TAGS), $(filter %-softmmu,$(TARGET_DIRS)))
> > > >   ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
> > > >   $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
> > > > diff --git a/tests/acceptance/boot_linux_console.py b/tests/accep=
tance/boot_linux_console.py
> > > > index 32159503e9..6bd5c1ab53 100644
> > > > --- a/tests/acceptance/boot_linux_console.py
> > > > +++ b/tests/acceptance/boot_linux_console.py
> > > > @@ -249,6 +249,7 @@ class BootLinuxConsole(Test):
> > > >           """
> > > >           :avocado: tags=3Darch:aarch64
> > > >           :avocado: tags=3Dmachine:virt
> > > > +        :avocado: tags=3Dflaky
> > > >           """
> > > >           kernel_url =3D ('https://download.fedoraproject.org/pub=
/fedora/linux/'
> > > >                         'releases/29/Everything/aarch64/os/images=
/pxeboot/vmlinuz')
> > > > @@ -270,6 +271,7 @@ class BootLinuxConsole(Test):
> > > >           """
> > > >           :avocado: tags=3Darch:arm
> > > >           :avocado: tags=3Dmachine:virt
> > > > +        :avocado: tags=3Dflaky
> > > >           """
> > > >           kernel_url =3D ('https://download.fedoraproject.org/pub=
/fedora/linux/'
> > > >                         'releases/29/Everything/armhfp/os/images/=
pxeboot/vmlinuz')
> > > > diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acc=
eptance/linux_ssh_mips_malta.py
> > > > index aafb0c39f6..ae70b658e0 100644
> > > > --- a/tests/acceptance/linux_ssh_mips_malta.py
> > > > +++ b/tests/acceptance/linux_ssh_mips_malta.py
> > > > @@ -208,6 +208,7 @@ class LinuxSSH(Test):
> > > >           :avocado: tags=3Dmachine:malta
> > > >           :avocado: tags=3Dendian:big
> > > >           :avocado: tags=3Ddevice:pcnet32
> > > > +        :avocado: tags=3Dflaky
> > > >           """
> > > >           kernel_url =3D ('https://people.debian.org/~aurel32/qem=
u/mips/'
> > > >                         'vmlinux-3.2.0-4-5kc-malta')
> > > > @@ -222,6 +223,7 @@ class LinuxSSH(Test):
> > > >           :avocado: tags=3Dmachine:malta
> > > >           :avocado: tags=3Dendian:little
> > > >           :avocado: tags=3Ddevice:pcnet32
> > > > +        :avocado: tags=3Dflaky
> > > >           """
> > > >           kernel_url =3D ('https://people.debian.org/~aurel32/qem=
u/mipsel/'
> > > >                         'vmlinux-3.2.0-4-5kc-malta')
> > > > diff --git a/tests/requirements.txt b/tests/requirements.txt
> > > > index 3ae0e29ad7..58d63d171f 100644
> > > > --- a/tests/requirements.txt
> > > > +++ b/tests/requirements.txt
> > > > @@ -1,5 +1,5 @@
> > > >   # Add Python module requirements, one per line, to be installed
> > > >   # in the tests/venv Python virtual environment. For more info,
> > > >   # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> > > > -avocado-framework=3D=3D68.0
> > > > +avocado-framework=3D=3D69.1
> > > >   paramiko
> > > >=20
>=20

