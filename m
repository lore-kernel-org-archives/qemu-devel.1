Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C6CC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6C920679
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6C920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35758 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heKtn-0000xs-4W
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 10:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45910)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1heKoU-0003ID-Ge
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1heKga-0002oK-0R
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:38:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1heKgZ-0002oB-Nt
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:38:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D866F6EB82;
 Fri, 21 Jun 2019 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-204.rdu2.redhat.com
 [10.10.120.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB2F160572;
 Fri, 21 Jun 2019 14:38:18 +0000 (UTC)
Date: Fri, 21 Jun 2019 10:38:16 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190621143816.GA24282@localhost.localdomain>
References: <20190621060925.16214-1-crosa@redhat.com>
 <20190621060925.16214-2-crosa@redhat.com>
 <f18a5df8-201e-b8a1-1a3e-3e2254ce8b1e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f18a5df8-201e-b8a1-1a3e-3e2254ce8b1e@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 21 Jun 2019 14:38:38 +0000 (UTC)
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
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 21, 2019 at 09:03:33AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 6/21/19 8:09 AM, Cleber Rosa wrote:
> > It's a fact that some tests may not be 100% reliable in all
> > environments.  While it's a tough call to remove a useful test that
> > from the tree because it may fail every 1/100th time (or so), having
> > human attention drawn to known issues is very bad for humans and for
> > the projects they manage.
> >=20
> > As a compromise solution, this marks tests that are known to have
> > issues, or that exercises known issues in QEMU or other components,
> > and excludes them from the entry point.  As a consequence, tests
> > marked as "flaky" will not be executed as part of "make
> > check-acceptance".
> >=20
> > Because such tests should be forgiven but never be forgotten, it's
> > possible to list them with (assuming "make check-venv" or "make
> > check-acceptance" has already initiatilized the venv):
> >=20
> >   $ ./tests/venv/bin/avocado list -t flaky tests/acceptance
> >=20
> > The current list of tests marked as flaky are a result of running
> > the entire set of acceptance tests around 20 times.  The results
> > were then processed with a helper script[1].  That either confirmed
> > known issues (in the case of aarch64 and arm)[2] or revealed new
> > ones (mips).
> >=20
> > This also bumps the Avocado version to one that includes a fix to the
> > parsing of multiple and mix "key:val" and simple tag values.
> >=20
> > [1] https://raw.githubusercontent.com/avocado-framework/avocado/maste=
r/contrib/scripts/summarize-job-failures.py
> > [2] https://bugs.launchpad.net/qemu/+bug/1829779
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  docs/devel/testing.rst                   | 17 +++++++++++++++++
> >  tests/Makefile.include                   |  6 +++++-
> >  tests/acceptance/boot_linux_console.py   |  2 ++
> >  tests/acceptance/linux_ssh_mips_malta.py |  2 ++
> >  tests/requirements.txt                   |  2 +-
> >  5 files changed, 27 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> > index da2d0fc964..ff4d8e2e1c 100644
> > --- a/docs/devel/testing.rst
> > +++ b/docs/devel/testing.rst
> > @@ -574,6 +574,23 @@ may be invoked by running:
> > =20
> >    tests/venv/bin/avocado run $OPTION1 $OPTION2 tests/acceptance/
> > =20
> > +Tagging tests
> > +-------------
> > +
> > +flaky
> > +~~~~~
> > +
> > +If a test is known to fail intermittently, even if only every one
> > +hundredth time, it's highly advisable to mark it as a flaky test.
> > +This will prevent these individual tests from failing much larger
> > +jobs, will avoid human interaction and time wasted to verify a known
> > +issue, and worse of all, can lead to the discredit of automated
> > +testing.
> > +
> > +To mark a test as flaky, add to its docstring.::
> > +
> > +  :avocado: tags=3Dflaky
>=20
> I certainly disagree with this patch, failing tests have to be fixed.
> Why not tag all the codebase flaky and sing "happy coding"?
>

That's a great idea! :)

Now, seriously, I also resisted this for quite a long time.  The
reality, though, is that intermittent failures will continue to
appear, and letting tests (and jobs, and CI pipelines, and whatnot)
fail is a very bad idea.  We all agree that real fixes are better than
this, but many times they don't come quickly.

> Anyway if this get accepted, 'flaky' tags must have the intermittent
> failure well described, and a Launchpad/Bugzilla tracking ticket refere=
nced.
>

And here you have a key point that I absolutely agree with.  The
"flaky" approach can either poison a lot of tests, and be seen as
quick way out of a difficult issue revealed by a test.  Or, it can
serve as an effective tool to keep track of these very important
issues.

If we add:

   # https://bugs.launchpad.net/qemu/+bug/1829779
   :avocado: flaky

Topped with some human, I believe this can be very effective.  This goes
without saying, but comments here are very much welcome.

- Cleber.

> > +
> >  Manual Installation
> >  -------------------
> > =20
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index db750dd6d0..4c97da2878 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -1125,7 +1125,11 @@ TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
> >  # Any number of command separated loggers are accepted.  For more
> >  # information please refer to "avocado --help".
> >  AVOCADO_SHOW=3Dapp
> > -AVOCADO_TAGS=3D$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(=
TARGET_DIRS)))
> > +
> > +# Additional tags that are added to each occurence of "--filter-by-t=
ags"
> > +AVOCADO_EXTRA_TAGS :=3D ,-flaky
> > +
> > +AVOCADO_TAGS=3D$(patsubst %-softmmu,--filter-by-tags=3Darch:%$(AVOCA=
DO_EXTRA_TAGS), $(filter %-softmmu,$(TARGET_DIRS)))
> > =20
> >  ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
> >  $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptanc=
e/boot_linux_console.py
> > index 32159503e9..6bd5c1ab53 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -249,6 +249,7 @@ class BootLinuxConsole(Test):
> >          """
> >          :avocado: tags=3Darch:aarch64
> >          :avocado: tags=3Dmachine:virt
> > +        :avocado: tags=3Dflaky
> >          """
> >          kernel_url =3D ('https://download.fedoraproject.org/pub/fedo=
ra/linux/'
> >                        'releases/29/Everything/aarch64/os/images/pxeb=
oot/vmlinuz')
> > @@ -270,6 +271,7 @@ class BootLinuxConsole(Test):
> >          """
> >          :avocado: tags=3Darch:arm
> >          :avocado: tags=3Dmachine:virt
> > +        :avocado: tags=3Dflaky
> >          """
> >          kernel_url =3D ('https://download.fedoraproject.org/pub/fedo=
ra/linux/'
> >                        'releases/29/Everything/armhfp/os/images/pxebo=
ot/vmlinuz')
> > diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/accepta=
nce/linux_ssh_mips_malta.py
> > index aafb0c39f6..ae70b658e0 100644
> > --- a/tests/acceptance/linux_ssh_mips_malta.py
> > +++ b/tests/acceptance/linux_ssh_mips_malta.py
> > @@ -208,6 +208,7 @@ class LinuxSSH(Test):
> >          :avocado: tags=3Dmachine:malta
> >          :avocado: tags=3Dendian:big
> >          :avocado: tags=3Ddevice:pcnet32
> > +        :avocado: tags=3Dflaky
> >          """
> >          kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mip=
s/'
> >                        'vmlinux-3.2.0-4-5kc-malta')
> > @@ -222,6 +223,7 @@ class LinuxSSH(Test):
> >          :avocado: tags=3Dmachine:malta
> >          :avocado: tags=3Dendian:little
> >          :avocado: tags=3Ddevice:pcnet32
> > +        :avocado: tags=3Dflaky
> >          """
> >          kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mip=
sel/'
> >                        'vmlinux-3.2.0-4-5kc-malta')
> > diff --git a/tests/requirements.txt b/tests/requirements.txt
> > index 3ae0e29ad7..58d63d171f 100644
> > --- a/tests/requirements.txt
> > +++ b/tests/requirements.txt
> > @@ -1,5 +1,5 @@
> >  # Add Python module requirements, one per line, to be installed
> >  # in the tests/venv Python virtual environment. For more info,
> >  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> > -avocado-framework=3D=3D68.0
> > +avocado-framework=3D=3D69.1
> >  paramiko
> >=20
>=20

