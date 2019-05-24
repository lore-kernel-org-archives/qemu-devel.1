Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B8C282E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5402D206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5402D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUGBM-0007pj-KT
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 15:48:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUGAW-0007W7-0t
	for qemu-devel@nongnu.org; Fri, 24 May 2019 15:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUGAU-0007ns-3g
	for qemu-devel@nongnu.org; Fri, 24 May 2019 15:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hUGAS-0007kk-6O
	for qemu-devel@nongnu.org; Fri, 24 May 2019 15:47:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC806C056899;
	Fri, 24 May 2019 19:47:44 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A606F19C6A;
	Fri, 24 May 2019 19:47:38 +0000 (UTC)
Date: Fri, 24 May 2019 16:47:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Message-ID: <20190524194734.GO10764@habkost.net>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
	<20190522230705.GB10764@habkost.net>
	<7a046f76-c892-a796-e7d0-b0eda92075d9@redhat.com>
	<1319868675.24353089.1558618080629.JavaMail.zimbra@redhat.com>
	<20190523213031.GE10764@habkost.net>
	<CAL1e-=jqVWxtOCoBayiYhA6D1yxZDA3a3+JrqV3wTDaGbS-eHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAL1e-=jqVWxtOCoBayiYhA6D1yxZDA3a3+JrqV3wTDaGbS-eHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 24 May 2019 19:47:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado tests
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cleber Rosa <crosa@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 24, 2019 at 03:45:56PM +0200, Aleksandar Markovic wrote:
> On May 23, 2019 11:31 PM, "Eduardo Habkost" <ehabkost@redhat.com> wrote=
:
> >
> > On Thu, May 23, 2019 at 09:28:00AM -0400, Cleber Rosa wrote:
> > >
> > >
> > > ----- Original Message -----
> > > > From: "Philippe Mathieu-Daud=E9" <philmd@redhat.com>
> > > > To: "Eduardo Habkost" <ehabkost@redhat.com>, "Cleber Rosa" <
> crosa@redhat.com>
> > > > Cc: "Aleksandar Rikalo" <arikalo@wavecomp.com>, "Philippe
> Mathieu-Daud=E9" <f4bug@amsat.org>, "Wainer dos Santos
> > > > Moschetta" <wainersm@redhat.com>, qemu-devel@nongnu.org, "Aleksan=
dar
> Markovic" <aleksandar.m.mail@gmail.com>,
> > > > "Aleksandar Markovic" <amarkovic@wavecomp.com>, "Aurelien Jarno" =
<
> aurelien@aurel32.net>
> > > > Sent: Thursday, May 23, 2019 5:38:34 AM
> > > > Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado test=
s
> > > >
> > > > On 5/23/19 1:07 AM, Eduardo Habkost wrote:
> > > > > On Wed, May 22, 2019 at 05:46:06PM -0400, Cleber Rosa wrote:
> > > > >> ----- Original Message -----
> > > > >>> From: "Eduardo Habkost" <ehabkost@redhat.com>
> > > > >>> On Tue, May 21, 2019 at 01:19:06AM +0200, Philippe Mathieu-Da=
ud=E9
> wrote:
> > > > >>>> Hi,
> > > > >>>>
> > > > >>>> It was a rainy week-end here, so I invested it to automatize=
 some
> > > > >>>> of my MIPS tests.
> > > > >>>>
> > > > >>>> The BootLinuxSshTest is not Global warming friendly, it is n=
ot
> > > > >>>> meant to run on a CI system but rather on a workstation prev=
ious
> > > > >>>> to post a pull request.
> > > > >>>> It can surely be improved, but it is a good starting point.
> > > > >>>
> > > > >>> Until we actually have a mechanism to exclude the test case o=
n
> > > > >>> travis-ci, I will remove patch 4/4 from the queue.  Aleksanda=
r,
> > > > >>> please don't merge patch 4/4 yet or it will break travis-ci.
> > > > >>>
> > > > >>> Cleber, Wainer, is it already possible to make "avocado run" =
skip
> > > > >>> tests tagged with "slow"?
> > > > >>>
> > > > >>
> > > > >> The mechanism exists, but we haven't tagged any test so far as
> slow.
> > > > >>
> > > > >> Should we define/document a criteria for a test to be slow?  G=
iven
> > > > >> that this is highly subjective, we have to think of:
> > > > >>
> > > > >>  * Will we consider the average or maximum run time (the timeo=
ut
> > > > >>    definition)?
> > > > >>
> > > > >>  * For a single test, what is "slow"? Some rough numbers from
> Travis
> > > > >>    CI[1] to help us with guidelines:
> > > > >>    - boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:  P=
ASS
> (6.04 s)
> > > > >>    - boot_linux_console.py:BootLinuxConsole.test_arm_virt:  PA=
SS
> (2.91 s)
> > > > >>    -
> > > > >>
> linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_work_with_linux_=
v4_16:
> > > > >>    PASS (18.14 s)
> > > > >>    - boot_linux.py:BootLinuxAarch64.test_virt:  PASS (396.88 s=
)
> > > > >
> > > > > I don't think we need to overthink this.  Whatever objective
> > > > > criteria we choose, I'm sure we'll have to adapt them later due
> > > > > to real world problems.
> > > > >
> > > > > e.g.: is 396 seconds too slow?  I don't know, it depends: does =
it
> > > > > break Travis and other CI systems often because of timeouts?  I=
f
> > > > > yes, then we should probably tag it as slow.
> > > > >
> > > > > If having subjective criteria is really a problem (I don't thin=
k
> > > > > it is), then we can call the tag "skip_travis", and stop worryi=
ng
> > > > > about defining what exactly is "slow".
> > > >
> > > > I'd go with a simpler "tags:travis-ci" whitelisting any job expec=
ting
> to
> > > > run smoothly there.
> > > >
> > >
> > > My concern is what becomes of "make check-acceptance".  Should we
> introduce
> > > another target, say, "make check-acceptance-ci" or just change its
> meaning
> > > and reuse it?
> >
> > What about "make check-acceptance TAG=3Dtravis-ci"?
> >
> > >
> > > > Then we can add "slow" tests without having to worry about
> blacklisting
> > > > for Travis CI.
> > > > Also, Other CI can set different timeouts.
> > > >
> > > > I'd like maintainers to add as many tests as they want to upstrea=
m, so
> > > > these tests can eventually run by anyone, then each maintainer is=
 free
> > > > to select which particular set he wants to run as default.
> > > >
> > >
> > > OK, so this matches the idea of carefully curating a set of tests f=
or
> > > CI.  WRT white or blacklisting, I favor the approach that requires =
the
> > > least effort from the developer to have its test enabled, so I'd go
> > > with blacklisting.  I fear that simple tests will just sit on the r=
epo
> > > without being properly exercised if we need to whitelist them.
> > >
> >
> > I agree.  I'd prefer the default case to be simple and not
> > require extra tags.  (i.e. tests without any tags would be run in
> > Travis by default).
> >
>=20
> Eduardo,
>=20
> You are confusing me here.
>=20
> You first suggest:
>=20
> > What about "make check-acceptance TAG=3Dtravis-ci"?
>=20

I was just trying to suggest using make variables as input to
check-acceptance, instead of creating separate makefile rules for
each set of test cases.  But you are right:

> ... and then say:
>=20
> > ...tests without any tags would be run in Travis by default.
>=20
> For casual observers like me it is contradictory, I must be missing
> something here, no?

Yes, if we use tags to exclude tests, the command line would look
different.  Maybe something like:

  make check-acceptance EXCLUDE_TAGS=3Dskip-travis

The exact format of the arguments don't matter to me, as long as
we don't require people to write new makefile rules just because
they want to run a different set of test cases.

--=20
Eduardo

