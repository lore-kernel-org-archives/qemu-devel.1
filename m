Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78742C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A672133D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A672133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59352 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUG3k-0005Lx-0b
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 15:40:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUG2v-0004yY-Oo
	for qemu-devel@nongnu.org; Fri, 24 May 2019 15:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUG2u-0001Nu-DE
	for qemu-devel@nongnu.org; Fri, 24 May 2019 15:40:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hUG2u-0001N9-4p
	for qemu-devel@nongnu.org; Fri, 24 May 2019 15:40:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F1F03082A27;
	Fri, 24 May 2019 19:40:01 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7FC4760610;
	Fri, 24 May 2019 19:39:58 +0000 (UTC)
Date: Fri, 24 May 2019 16:39:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Message-ID: <20190524193955.GN10764@habkost.net>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
	<CAL1e-=iW2honEgNfrsFoA0tU1wMq0mw5LuoRbWVmRDBMA22ELA@mail.gmail.com>
	<1094559891.24356881.1558619101528.JavaMail.zimbra@redhat.com>
	<CAL1e-=ikyNrfwBR_UW8wwCNHQjLWxhcfrTdde54OP4phkdvqHA@mail.gmail.com>
	<b4252e21-a82c-2e1b-7a3f-ed13cb3fba36@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4252e21-a82c-2e1b-7a3f-ed13cb3fba36@amsat.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 24 May 2019 19:40:01 +0000 (UTC)
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
	Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cleber Rosa <crosa@redhat.com>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 23, 2019 at 07:27:35PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 5/23/19 7:11 PM, Aleksandar Markovic wrote:
> > On May 23, 2019 3:45 PM, "Cleber Rosa" <crosa@redhat.com> wrote:
> >>> From: "Aleksandar Markovic" <aleksandar.m.mail@gmail.com>
> >>> On May 22, 2019 11:46 PM, "Cleber Rosa" <crosa@redhat.com> wrote:
> >>>>> From: "Eduardo Habkost" <ehabkost@redhat.com>
> >>>>>
> >>>>> Until we actually have a mechanism to exclude the test case on
> >>>>> travis-ci, I will remove patch 4/4 from the queue.  Aleksandar,
> >>>>> please don't merge patch 4/4 yet or it will break travis-ci.
> >>>>>
> >>>>> Cleber, Wainer, is it already possible to make "avocado run" skip
> >>>>> tests tagged with "slow"?
> >>>>>
> >>>>
> >>>> The mechanism exists, but we haven't tagged any test so far as slo=
w.
> >>>>
> >>>
> >>> Cleber,
> >>>
> >>> For the test from patch 4/4, there is no dilemma - it should be in =
the
> >>> =E2=80=9Cslow=E2=80=9D group, as Philippe envisioned and said, so t=
hat it is not
> > humpered
> >>> with stricter requirements for =E2=80=9Cfast=E2=80=9D (default) gro=
up. Could you
> > explain us
> >>> how to do it, so that we can hopefully finally proceed?
> >>>
> >>
> >> Hi Aleksandar,
> >>
> >> The point is that there's no "group" definition at this point.  This=
 is
> > the
> >> core of the discussion.
> >>
> >> I think we're close to converging to something simple and effective.
> > Please
> >> let us know what you think of the proposals given.
> >>
> >> Thanks!
> >> - Cleber.
> >>
> >=20
> > Cleber, hi.
> >=20
> > Thanks for responding.
> >=20
> > My views are very similar to Philippe's, but I will provide you with =
more
> > details of our (mips) perspective.
> >=20
> > As far as black/whitelist issues that is a moot point for us - we onl=
y want
> > to be able to have a way to tag a test within the test itself (so, wi=
thout
> > updating some common files, external lists,etc.)
> >=20
> > In general, we would like to have a test environment where we would b=
e able
> > to test what WE deem suitable for us, without feeling that we bother =
you or
> > anybody else, or that we are bothered by others.
> >=20
> > Let me give you a little extreme example: Let's say we want a complex=
 test
> > that downloads components from let's say fifty internet location, exe=
cutes
> > zillion test cases, and last two days. I wouldn't like anybody to ask=
 me
> > =E2=80=9CWhy would you that?=E2=80=9D or tell me =E2=80=9CYou can't d=
o this.=E2=80=9D or say =E2=80=9CNo, we did
> > not anticipate such tests, patch rejected.=E2=80=9D I (we, people fro=
m mips) should
> > be able to define what I (we) need.
>=20
> Maybe we can use subdirectory like we do for the TCG tests (Aleksandar
> maintains tests/tcg/mips/). We should try to keep contribution upstream=
,
> so good idea/pattern can be reused by others.
>=20
> What I'd like to have with those tests is, at least:
>=20
> 1/ we don't need to run all the tests (but there is a set of 'quick'
> tests we can run on daily basis)
>=20
> 2/ maintainers can run their default tests easily (using a combination
> of Avocado tags)
>=20
> 3/ if a developer working on the PCI subsystem has to modify the MIPS
> subsystem (for example), he should be able to run the MIPS tests before
> sending his series.

Keeping the test cases organized in subdirectories are a good
idea, but don't think this is going to help us when we need to
quickly enable/disable specific test cases on some CI systems.

Disabling a test case (or an entire category of test cases) known
to be failing on some CI systems should require a one line patch,
not moving files to a separate directory.

>=20
> > Having such test would be a big deal for me, not only that I could ru=
n it
> > manually or automatically every weekend, but I could ask submitters o=
f
> > critical changes: =E2=80=9CDid you run this test that we have in Avoc=
ado dir?=E2=80=9D,
> > without specifying test details, procedures, etc. All this is a BIG d=
eal
> > for me.
> >=20
> > On the other hand, I agree that certain group of tests (envisioned fo=
r
> > daily or so Travis CI) should have some stricter limitations and stru=
cture.
> > But right now I feel humpered by it, and this is counterproductive.
> >=20
> > So, we want freedom, responsibility and ownersheep of our tests. Plea=
se
> > give us the opportunity to get down on business and start writing tes=
ts and
> > start testing.
> >=20
> > Yours,
> > Aleksandar

--=20
Eduardo

