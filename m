Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3B5C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 05:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DFF2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 05:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT+mVQXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DFF2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSw5C-000289-CC
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 01:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jSw4E-0001Xf-GL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 01:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jSw4C-0006XI-Q7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 01:12:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jSw4C-0006X3-Bs
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 01:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587964346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhugMm4iNt+p9y4MHIePHw3IXC/vW92Xr8e3nsTFymI=;
 b=XT+mVQXWZXMHriV2aeOvhBrodTX8ZaX/VEMagbDl/+0BuQ4TkhK9OFyAyiDpj3/XAeJkAL
 qeQ96FVyWJEyGwALEfFQAg5SXg9hw31B8yARNhC6eSKbDx2DIn/8iPXcGsc4FdfzXuASmW
 Atxzs/nGxAMIxIH9G5Clr8a6rdLfqqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-vvr6F38tO_WvnK-94dlaJg-1; Mon, 27 Apr 2020 01:12:24 -0400
X-MC-Unique: vvr6F38tO_WvnK-94dlaJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C598E835B41;
 Mon, 27 Apr 2020 05:12:22 +0000 (UTC)
Received: from localhost (ovpn-112-178.rdu2.redhat.com [10.10.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7DA46062B;
 Mon, 27 Apr 2020 05:12:17 +0000 (UTC)
Date: Mon, 27 Apr 2020 01:12:10 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200427011210.745db351@redhat.com>
In-Reply-To: <69e77a6e-8db8-f617-bfe6-1c8f39ec81b4@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
 <20200423171322.GJ1077680@redhat.com>
 <69e77a6e-8db8-f617-bfe6-1c8f39ec81b4@redhat.com>
Organization: Red Hat, Inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Apr 2020 23:28:21 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 4/23/20 7:13 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Apr 23, 2020 at 01:04:13PM -0400, Cleber Rosa wrote:
> >> ----- Original Message -----
> >>> From: "Peter Maydell" <peter.maydell@linaro.org>
> >>> To: "Markus Armbruster" <armbru@redhat.com>
> >>> Cc: "Fam Zheng" <fam@euphon.net>, "Thomas Huth"
> >>> <thuth@redhat.com>, "Beraldo Leal" <bleal@redhat.com>, "Erik
> >>> Skultety" <eskultet@redhat.com>, "Alex Benn=C3=A9e"
> >>> <alex.bennee@linaro.org>, "Wainer Moschetta"
> >>> <wmoschet@redhat.com>, "QEMU Developers" <qemu-devel@nongnu.org>,
> >>> "Wainer dos Santos Moschetta" <wainersm@redhat.com>, "Willian
> >>> Rampazzo" <wrampazz@redhat.com>, "Cleber Rosa"
> >>> <crosa@redhat.com>, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>=
,
> >>> "Eduardo Habkost" <ehabkost@redhat.com> Sent: Tuesday, April 21,
> >>> 2020 8:53:49 AM Subject: Re: [PATCH 0/5] QEMU Gating CI
> >>>
> >>> On Thu, 19 Mar 2020 at 16:33, Markus Armbruster
> >>> <armbru@redhat.com> wrote:
> >>>> Peter Maydell <peter.maydell@linaro.org> writes:
> >>>>> I think we should start by getting the gitlab setup working
> >>>>> for the basic "x86 configs" first. Then we can try adding
> >>>>> a runner for s390 (that one's logistically easiest because
> >>>>> it is a project machine, not one owned by me personally or
> >>>>> by Linaro) once the basic framework is working, and expand
> >>>>> from there.
> >>>>
> >>>> Makes sense to me.
> >>>>
> >>>> Next steps to get this off the ground:
> >>>>
> >>>> * Red Hat provides runner(s) for x86 stuff we care about.
> >>>>
> >>>> * If that doesn't cover 'basic "x86 configs" in your judgement,
> >>>> we fill the gaps as described below under "Expand from there".
> >>>>
> >>>> * Add an s390 runner using the project machine you mentioned.
> >>>>
> >>>> * Expand from there: identify the remaining gaps, map them to
> >>>> people / organizations interested in them, and solicit
> >>>> contributions from these guys.
> >>>>
> >>>> A note on contributions: we need both hardware and people.  By
> >>>> people I mean maintainers for the infrastructure, the tools and
> >>>> all the runners. Cleber & team are willing to serve for the
> >>>> infrastructure, the tools and the Red Hat runners.
> >>>
> >>> So, with 5.0 nearly out the door it seems like a good time to
> >>> check in on this thread again to ask where we are progress-wise
> >>> with this. My impression is that this patchset provides most of
> >>> the scripting and config side of the first step, so what we need
> >>> is for RH to provide an x86 runner machine and tell the gitlab CI
> >>> it exists. I appreciate that the whole coronavirus and
> >>> working-from-home situation will have upended everybody's plans,
> >>> especially when actual hardware might be involved, but how's it
> >>> going ?
> >>>
> >>
> >> Hi Peter,
> >>
> >> You hit the nail in the head here.  We were affected indeed with
> >> our ability to move some machines from one lab to another (across
> >> the country), but we're actively working on it.
> >=20
> > For x86, do we really need to be using custom runners ?
> >=20
> > With GitLab if someone forks the repo to their personal namespace,
> > they cannot use any custom runners setup by the origin project. So
> > if we use custom runners for x86, people forking won't be able to
> > run the GitLab CI jobs.
> >=20
> > As a sub-system maintainer I wouldn't like this, because I ideally
> > want to be able to run the same jobs on my staging tree, that Peter
> > will run at merge time for the PULL request I send.
> >=20
> > Thus my strong preference would be to use the GitLab runners in
> > every scenario where they are viable to use. Only use custom
> > runners in the cases where GitLab runners are clearly inadequate
> > for our needs.
> >=20
> > Based on what we've setup in GitLab for libvirt,  the shared runners
> > they have work fine for x86. Just need the environments you are
> > testing to be provided as Docker containers (you can actually build
> > and cache the container images during your CI job too).  IOW, any
> > Linux distro build and test jobs should be able to use shared
> > runners on x86, and likewise mingw builds. Custom runners should
> > only be needed if the jobs need todo *BSD / macOS builds, and/or
> > have access to specific hardware devices for some reason.
>=20
> Thanks to insist with that point Daniel. I'd rather see every=20
> configuration reproducible, so if we loose a hardware sponsor, we can=20
> find another one and start another runner.

I also believe that having jobs that can be reproducible is key, but I
differ when it comes to believing that the hardware *alone* should
define if a job is gating or not.

My point is that even with easily accessible systems and software,
different jobs can easily yield different results, because of how the
underlying system is configured.  Sure, containers, but again, we have
to consider non container usage too.

In the RFC I tried to gather feedback on a plan to promote and demote
jobs from a gating status.  IMO, most jobs would begin their lives
being non-gating, and would prove both their stability and their
mantainer's responsiveness.  Even when such jobs are already gating,
it should be trivial to simply demote a gating job because of (and
not limited to) any of the following reasons:

 * job fails in a non-reproducible way
 * hardware is unresponsive and takes too long to produce results
 * maintainer is MIA

Some or all of the gating runners could also pick up jobs sent to
a branch other than "staging", say, a branch called "reproducer". That
branch could be writable by maintainers that need to reproduce a given
failure.

> Also note, if it is not easy to reproduce a runner, it will be very
> hard to debug a reported build/test error.
>=20

One of the goals of the patches you'll find on this series is to
propose (I would say *require*) that new jobs that require new hardware
(even easily accessible systems such as x86) should provide easy to run
scripts to recreate those environments.  This is inline with my previous
point that it's not enough to just have the same hardware.

> A non-reproducible runner can not be used as gating, because if they=20
> fail it is not acceptable to lock the project development process.
>=20

Other people may be more familiar with this, but I do remember projects
such as OpenStack deferring test of hardware/software combinations to
other entities.  One specific party won't be able to
reproduce all configurations unless it's decided to be kept really
small.  In my opinion, it's better to face it and acknowledge that
fact, and have plans to be put to action in the exceptional cases where
the environment to reproduce a test is now unavailable.

>=20
> In some cases custom runners are acceptable. These runners won't be=20
> "gating" but can post informative log and status.
>=20

Well, I have the feeling that some people maintaining those runners
will *not* want to have them as "informational" only.  If they invest a
good amount of time on them, I believe they'll want to reap the
benefits such as other not breaking the code they rely on.  If their
system is not gating, they lose that and may find breakage that CI did
not catch.  Again, I don't think "easily accessible" hardware should be
the only criteria for gating/non-gating status.

For instance, would you consider, say, a "Raspberry Pi 4 Model
B", running KVM jobs to be a reproducible runner?  Would you blame a
developer that breaks a Gating CI job on such a platform and says that
he can not reproduce it?

> [*] Specific hardware that is not easily available.
>=20
> - Alistair at last KVM forum talked about a RISCV board
>    (to test host TCG)
> - Aleksandar said at last KVM forum Wavecomp could plug a CI20 MIPS
>    (to test host TCG)
> - Lemote seems interested to setup some Loongson MIPSr6 board
>    (to test interaction with KVM)
>=20
> [*] To run code requiring accepting License Agreements
>=20
> [*] To run non Free / Open Source code
>=20
>=20
> Owner of these runners take the responsibility to provide enough=20
> time/information about reported bugs, or to debug them themselves.
>=20

I do think that the owner of such runners may *not* want to have them
with Gating jobs, but I don't think the opposite should be the case,
because I find it very hard to define, without some prejudice, what
"easily available runner" means.

>=20
> Now the problem is GitLab runner is not natively available on the=20
> architectures listed in this mail, so custom setup is required. A
> dumb script running ssh to a machine also works (tested) but lot of
> manual tuning/maintenance expected.
>=20

That's where I'm trying to help.  I built and tested the gitlab-runner
for a number of non-supported environments, and I expect to build
further on that (say contributing code or feedback back to GitLab so
they become official builds?).

Cheers,
- Cleber.=20


