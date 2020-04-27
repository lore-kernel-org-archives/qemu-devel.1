Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDB5C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 05:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD52206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 05:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKMsGxxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD52206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSwST-0000a3-Il
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 01:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jSwRk-0008Sf-C0
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 01:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jSwRj-0002RX-7O
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 01:36:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jSwRi-0002Ku-Qs
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 01:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587965805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B1r4Fq7K9BrtOn+OYZkWNes2oHMQha/xtXJJhxfsN1Y=;
 b=ZKMsGxxBZ1vpsMvSCz/O1m+I7X5hjPE+1s1iWxRGVrbrxaJpMWLIEW1f2y3byrslVx9Mzl
 IXW5o3zgX+dfiROiovwpwXGJjAA6wr49MnPMQyFXca5BOgpsGG0GHZGCMxcMb9pDTx3PQv
 gyHBhpimZTx583eztkjo54/aVZkTCGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-95CGWV5XMYeWxnRNGu8e8g-1; Mon, 27 Apr 2020 01:36:42 -0400
X-MC-Unique: 95CGWV5XMYeWxnRNGu8e8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD392800C78;
 Mon, 27 Apr 2020 05:36:40 +0000 (UTC)
Received: from localhost (ovpn-112-178.rdu2.redhat.com [10.10.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B5421000327;
 Mon, 27 Apr 2020 05:36:36 +0000 (UTC)
Date: Mon, 27 Apr 2020 01:36:30 -0400
From: Cleber Rosa <crosa@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200427013630.6c8e96d2@redhat.com>
In-Reply-To: <20200424093023.GD1212635@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
 <20200423171322.GJ1077680@redhat.com>
 <348064782.9653447.1587663408130.JavaMail.zimbra@redhat.com>
 <20200424093023.GD1212635@redhat.com>
Organization: Red Hat, Inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:32:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Erik Skultety <eskultet@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Apr 2020 10:30:23 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Thu, Apr 23, 2020 at 01:36:48PM -0400, Cleber Rosa wrote:
> >=20
> >=20
> > ----- Original Message -----
> > > From: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> > > To: "Cleber Rosa" <crosa@redhat.com>
> > > Cc: "Peter Maydell" <peter.maydell@linaro.org>, "Fam Zheng"
> > > <fam@euphon.net>, "Thomas Huth" <thuth@redhat.com>, "Beraldo
> > > Leal" <bleal@redhat.com>, "Erik Skultety" <eskultet@redhat.com>,
> > > "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>, "Wainer Moschetta"
> > > <wmoschet@redhat.com>, "Markus Armbruster" <armbru@redhat.com>,
> > > "Wainer dos Santos Moschetta" <wainersm@redhat.com>, "QEMU
> > > Developers" <qemu-devel@nongnu.org>, "Willian Rampazzo"
> > > <wrampazz@redhat.com>, "Alex Benn=C3=A9e" <alex.bennee@linaro.org>,
> > > "Eduardo Habkost" <ehabkost@redhat.com> Sent: Thursday, April 23,
> > > 2020 1:13:22 PM Subject: Re: [PATCH 0/5] QEMU Gating CI
> > >=20
> > > On Thu, Apr 23, 2020 at 01:04:13PM -0400, Cleber Rosa wrote:
> > > >=20
> > > >=20
> > > > ----- Original Message -----
> > > > > From: "Peter Maydell" <peter.maydell@linaro.org>
> > > > > To: "Markus Armbruster" <armbru@redhat.com>
> > > > > Cc: "Fam Zheng" <fam@euphon.net>, "Thomas Huth"
> > > > > <thuth@redhat.com>, "Beraldo Leal" <bleal@redhat.com>, "Erik
> > > > > Skultety" <eskultet@redhat.com>, "Alex Benn=C3=A9e"
> > > > > <alex.bennee@linaro.org>, "Wainer Moschetta"
> > > > > <wmoschet@redhat.com>, "QEMU Developers"
> > > > > <qemu-devel@nongnu.org>, "Wainer dos Santos Moschetta"
> > > > > <wainersm@redhat.com>, "Willian Rampazzo"
> > > > > <wrampazz@redhat.com>, "Cleber Rosa" <crosa@redhat.com>,
> > > > > "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>, "Eduardo
> > > > > Habkost" <ehabkost@redhat.com> Sent: Tuesday, April 21, 2020
> > > > > 8:53:49 AM Subject: Re: [PATCH 0/5] QEMU Gating CI
> > > > >=20
> > > > > On Thu, 19 Mar 2020 at 16:33, Markus Armbruster
> > > > > <armbru@redhat.com> wrote:
> > > > > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > > > > > I think we should start by getting the gitlab setup
> > > > > > > working for the basic "x86 configs" first. Then we can
> > > > > > > try adding a runner for s390 (that one's logistically
> > > > > > > easiest because it is a project machine, not one owned by
> > > > > > > me personally or by Linaro) once the basic framework is
> > > > > > > working, and expand from there.
> > > > > >
> > > > > > Makes sense to me.
> > > > > >
> > > > > > Next steps to get this off the ground:
> > > > > >
> > > > > > * Red Hat provides runner(s) for x86 stuff we care about.
> > > > > >
> > > > > > * If that doesn't cover 'basic "x86 configs" in your
> > > > > > judgement, we fill the gaps as described below under
> > > > > > "Expand from there".
> > > > > >
> > > > > > * Add an s390 runner using the project machine you
> > > > > > mentioned.
> > > > > >
> > > > > > * Expand from there: identify the remaining gaps, map them
> > > > > > to people / organizations interested in them, and solicit
> > > > > > contributions from these
> > > > > >   guys.
> > > > > >
> > > > > > A note on contributions: we need both hardware and people.
> > > > > > By people I mean maintainers for the infrastructure, the
> > > > > > tools and all the runners. Cleber & team are willing to
> > > > > > serve for the infrastructure, the tools and
> > > > > > the Red Hat runners.
> > > > >=20
> > > > > So, with 5.0 nearly out the door it seems like a good time to
> > > > > check in on this thread again to ask where we are
> > > > > progress-wise with this. My impression is that this patchset
> > > > > provides most of the scripting and config side of the first
> > > > > step, so what we need is for RH to provide an x86 runner
> > > > > machine and tell the gitlab CI it exists. I appreciate that
> > > > > the whole coronavirus and working-from-home situation will
> > > > > have upended everybody's plans, especially when actual
> > > > > hardware might be involved, but how's it going ?
> > > > >=20
> > > >=20
> > > > Hi Peter,
> > > >=20
> > > > You hit the nail in the head here.  We were affected indeed
> > > > with our ability
> > > > to move some machines from one lab to another (across the
> > > > country), but we're
> > > > actively working on it.
> > >=20
> > > For x86, do we really need to be using custom runners ?
> > >=20
> >=20
> > Hi Daniel,
> >=20
> > We're already using the shared x86 runners, but with a different
> > goal.  The goal of the "Gating CI" is indeed to expand on non-x86
> > environments.  We're in a "chicken and egg" kind of situation,
> > because we'd like to prove that GitLab CI will allow QEMU to expand
> > to very different runners and jobs, while not really having all
> > that hardware setup and publicly available at this time.
> >=20
> > My experiments were really around that point, I mean, confirming
> > that we can grow the number of
> > architectures/runners/jobs/configurations to provide a coverage
> > equal or greater to what Peter already does.
>=20
> So IIUC, you're saying that for x86 gating, the intention is to use
> shared runners in general.
>=20

No, I've said that whenever possible we could use containers and thus
shared runners.  For instance, testing QEMU running on the x86 CentOS 8
KVM is not something we could do with shared runners.=20

> Your current work that you say is blocked on access to x86 hardware,
> is just about demonstrating the concept of plugging in custom
> runners, while we wait for access to non-x86 hardware ?
>=20

Short answer is no.  The original scope and goal was to have the same or
very similar jobs that Peter runs himself in his own machines.  So it
was/is not about just x86 hardware, but x86 that can run a couple of
different OSs, and non-x86 hardware too.  We're basically scaling down
and changing the scope (for instance adding the s390 machine here) in
an attempt to get this moving forward.

> > > With GitLab if someone forks the repo to their personal
> > > namespace, they cannot use any custom runners setup by the origin
> > > project. So if we use custom runners for x86, people forking
> > > won't be able to run the GitLab CI jobs.
> > >=20
> >=20
> > They will continue to be able use the jobs and runners already
> > defined in the .gitlab-ci.yml file.  This work will only affect
> > people pushing to the/a "staging" branch.
> >=20
> > > As a sub-system maintainer I wouldn't like this, because I
> > > ideally want to be able to run the same jobs on my staging tree,
> > > that Peter will run at merge time for the PULL request I send.
> > >=20
> >=20
> > If you're looking for symmetry between any PR and "merge time"
> > jobs, the only solution is to allow any PR to access all the
> > diverse set of non-shared machines we're hoping to have in the near
> > future.  This may be something we'll get to, but I doubt we can
> > tackle it in the near future now.
>=20
> It occurred to me that we could do this if we grant selective access
> to the Gitlab repos, to people who are official subsystem maintainers.
> GitLab has a concept of "protected branches", so you can control who
> is allowed to push changes on a per-branch granularity.
>=20
> So, for example, in the main qemu.git, we could create branches for
> each subsystem tree eg
>=20
>   staging-block
>   staging-qapi
>   staging-crypto
>   staging-migration
>   ....
>=20
> and for each of these branches, we can grant access to relevant
> subsystem maintainer(s).
>=20
> When they're ready to send a pull request to Peter, they can push
> their tree to this branch. Since the branch is in the main
> gitlab.com/qemu/qemu project namespace, this branch can run CI using
> the private QEMU runners. The subsystem maintainer can thus see the
> full set of CI results across all platforms required by Gating,
> before Peter even gets the pull request.
>=20

Sure, this is actually an extrapolation/extension of what we're
proposing to do here with the unique "staging" branch.  I see no issues
at all to have more than one (one per subsystem/maintainer) staging
branches.

> So when Peter then looks at merging the pull request to master, the
> only he's likely to see are the non-deterministic bugs, or issues
> caused by semantic conflicts with other recently merged code.
>=20
> It would even be possible to do the final merge into master entirely
> from GitLab, no need to go via email. When the source branch & target
> branch are within the same git repo, GitLab has the ability to run CI
> jobs against the resulting merge commit in a strict gating manner,
> before it hits master. They call this "Merge trains" in their
> documentation.
>=20
> IOW, from Peter's POV, merging pull requests could be as simple as
> hitting the merge button in GitLab merge request UI. Everything wrt
> CI would be completely automated, and the subsystem maintainers would
> have the responsibility to dealing with merge conflicts & CI
> failures, which is more scalable for the person co-ordinating the
> merges into master.
>=20

This is very much aligned to some previous discussions, I believe, at
the RFC thread.  But for practical purposes, the general direction was
to scale down to the bare minimum to replicate Peter's setup and
workflow, and then move from there to possibly something very similar
to what you're describing here.

>=20
> Regards,
> Daniel


Thanks a *whole lot* for the feedback Daniel!
- Cleber.


