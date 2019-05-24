Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED01C282E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 21:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 730EA21773
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 21:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730EA21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60288 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUHcV-0002mP-Gy
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 17:20:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUHbM-000264-8W
	for qemu-devel@nongnu.org; Fri, 24 May 2019 17:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUHbK-0000ti-Cs
	for qemu-devel@nongnu.org; Fri, 24 May 2019 17:19:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hUHbK-0000r1-3T
	for qemu-devel@nongnu.org; Fri, 24 May 2019 17:19:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A506308624C;
	Fri, 24 May 2019 21:19:40 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 23C285C1B4;
	Fri, 24 May 2019 21:19:36 +0000 (UTC)
Date: Fri, 24 May 2019 18:19:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Message-ID: <20190524211935.GX10764@habkost.net>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
	<CAL1e-=iW2honEgNfrsFoA0tU1wMq0mw5LuoRbWVmRDBMA22ELA@mail.gmail.com>
	<1094559891.24356881.1558619101528.JavaMail.zimbra@redhat.com>
	<CAL1e-=ikyNrfwBR_UW8wwCNHQjLWxhcfrTdde54OP4phkdvqHA@mail.gmail.com>
	<b4252e21-a82c-2e1b-7a3f-ed13cb3fba36@amsat.org>
	<20190524193955.GN10764@habkost.net>
	<CAL1e-=h-4RNGYtBPL9PEHux6qYUXAmi_2BqpgPM+j4MiWfn3iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL1e-=h-4RNGYtBPL9PEHux6qYUXAmi_2BqpgPM+j4MiWfn3iA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 24 May 2019 21:19:40 +0000 (UTC)
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
	Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 24, 2019 at 10:32:36PM +0200, Aleksandar Markovic wrote:
> On May 24, 2019 9:40 PM, "Eduardo Habkost" <ehabkost@redhat.com> wrote:
> >
> > On Thu, May 23, 2019 at 07:27:35PM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
> > > On 5/23/19 7:11 PM, Aleksandar Markovic wrote:
> > > > On May 23, 2019 3:45 PM, "Cleber Rosa" <crosa@redhat.com> wrote:
> > > >>> From: "Aleksandar Markovic" <aleksandar.m.mail@gmail.com>
> > > >>> On May 22, 2019 11:46 PM, "Cleber Rosa" <crosa@redhat.com> wrot=
e:
> > > >>>>> From: "Eduardo Habkost" <ehabkost@redhat.com>
> > > >>>>>
> > > >>>>> Until we actually have a mechanism to exclude the test case o=
n
> > > >>>>> travis-ci, I will remove patch 4/4 from the queue.  Aleksanda=
r,
> > > >>>>> please don't merge patch 4/4 yet or it will break travis-ci.
> > > >>>>>
> > > >>>>> Cleber, Wainer, is it already possible to make "avocado run" =
skip
> > > >>>>> tests tagged with "slow"?
> > > >>>>>
> > > >>>>
> > > >>>> The mechanism exists, but we haven't tagged any test so far as
> slow.
> > > >>>>
> > > >>>
> > > >>> Cleber,
> > > >>>
> > > >>> For the test from patch 4/4, there is no dilemma - it should be=
 in
> the
> > > >>> =E2=80=9Cslow=E2=80=9D group, as Philippe envisioned and said, =
so that it is not
> > > > humpered
> > > >>> with stricter requirements for =E2=80=9Cfast=E2=80=9D (default)=
 group. Could you
> > > > explain us
> > > >>> how to do it, so that we can hopefully finally proceed?
> > > >>>
> > > >>
> > > >> Hi Aleksandar,
> > > >>
> > > >> The point is that there's no "group" definition at this point.  =
This
> is
> > > > the
> > > >> core of the discussion.
> > > >>
> > > >> I think we're close to converging to something simple and effect=
ive.
> > > > Please
> > > >> let us know what you think of the proposals given.
> > > >>
> > > >> Thanks!
> > > >> - Cleber.
> > > >>
> > > >
> > > > Cleber, hi.
> > > >
> > > > Thanks for responding.
> > > >
> > > > My views are very similar to Philippe's, but I will provide you w=
ith
> more
> > > > details of our (mips) perspective.
> > > >
> > > > As far as black/whitelist issues that is a moot point for us - we
> only want
> > > > to be able to have a way to tag a test within the test itself (so=
,
> without
> > > > updating some common files, external lists,etc.)
> > > >
> > > > In general, we would like to have a test environment where we wou=
ld
> be able
> > > > to test what WE deem suitable for us, without feeling that we bot=
her
> you or
> > > > anybody else, or that we are bothered by others.
> > > >
> > > > Let me give you a little extreme example: Let's say we want a com=
plex
> test
> > > > that downloads components from let's say fifty internet location,
> executes
> > > > zillion test cases, and last two days. I wouldn't like anybody to=
 ask
> me
> > > > =E2=80=9CWhy would you that?=E2=80=9D or tell me =E2=80=9CYou can=
't do this.=E2=80=9D or say =E2=80=9CNo, we
> did
> > > > not anticipate such tests, patch rejected.=E2=80=9D I (we, people=
 from mips)
> should
> > > > be able to define what I (we) need.
> > >
> > > Maybe we can use subdirectory like we do for the TCG tests (Aleksan=
dar
> > > maintains tests/tcg/mips/). We should try to keep contribution upst=
ream,
> > > so good idea/pattern can be reused by others.
> > >
> > > What I'd like to have with those tests is, at least:
> > >
> > > 1/ we don't need to run all the tests (but there is a set of 'quick=
'
> > > tests we can run on daily basis)
> > >
> > > 2/ maintainers can run their default tests easily (using a combinat=
ion
> > > of Avocado tags)
> > >
> > > 3/ if a developer working on the PCI subsystem has to modify the MI=
PS
> > > subsystem (for example), he should be able to run the MIPS tests be=
fore
> > > sending his series.
> >
> > Keeping the test cases organized in subdirectories are a good
> > idea, but don't think this is going to help us when we need to
> > quickly enable/disable specific test cases on some CI systems.
> >
>=20
> Well, Eduardo, nobody said that directory locations should be used for
> enabling/disabling or tagging/untagging tests in the first place. I thi=
nk
> it was clear for everybody from the outset that these features should h=
ave
> their own mechanisms, which Cleber says already exist, but can't be use=
d
> because the test group still can't figure out (in some hamletesque way)
> whether to blacklist or to whitelist, or how to name the tag for travis=
,
> and tag for not travis, and if such tags should even exist, etc. - that=
 is
> my layman impression from recent discussions. And now when Philippe
> suggested (in my opinion logical and reasonable) subdirectory, an endle=
ss
> discussion begins: =E2=80=9CTo subdirectory or not to subdirectory? Tha=
t is the
> question.=E2=80=9D Meanwhile, 4.1 is inexorably getting closer and clos=
er, and with
> each day, the value of any potential tests is decreasing.

I understand that seeing the discussions going on and the patches
taking too long to be included might be frustrating.

These discussions shouldn't get into the way of addressing other
problems.  We don't need to wait until all discussions have
finished before proposing new patches or before merging patches
that are considered good.


>=20
> Directory structure should be used in its usual and basic way: for
> clustering files of similar nature, purpose, or origin, and I do certai=
nly
> support any reasonable subdirectory organization for your directory - a=
nd
> you should think about it, and probably while doing that consult a litt=
le
> bit other people from all walks of QEMU. We are ready to comply with yo=
ur
> final decision.

About subdirectories, specifically, note that I explicitly said
it was a good idea.  If somebody wants to send patches, they are
welcome.

If I'm doing something else that could be blocking people from
getting work done, I'd like to fix that.  I'm aware that
sometimes I take too long to review patches, but I hope other
developers can help us on the review work.

>=20
> The good thing is that nothing is set in stone, everything can be chang=
ed
> and improved, moving files is easy in git.
>=20
> All that said, many thanks for reviewing patch 4/4.
>=20
> Aleksandar
>=20
>=20
>=20
> > Disabling a test case (or an entire category of test cases) known
> > to be failing on some CI systems should require a one line patch,
> > not moving files to a separate directory.
> >
> > >
> > > > Having such test would be a big deal for me, not only that I coul=
d
> run it
> > > > manually or automatically every weekend, but I could ask submitte=
rs of
> > > > critical changes: =E2=80=9CDid you run this test that we have in =
Avocado
> dir?=E2=80=9D,
> > > > without specifying test details, procedures, etc. All this is a B=
IG
> deal
> > > > for me.
> > > >
> > > > On the other hand, I agree that certain group of tests (envisione=
d for
> > > > daily or so Travis CI) should have some stricter limitations and
> structure.
> > > > But right now I feel humpered by it, and this is counterproductiv=
e.
> > > >
> > > > So, we want freedom, responsibility and ownersheep of our tests.
> Please
> > > > give us the opportunity to get down on business and start writing
> tests and
> > > > start testing.
> > > >
> > > > Yours,
> > > > Aleksandar
> >
> > --
> > Eduardo

--=20
Eduardo

