Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B042EC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B79320767
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abuqhcJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B79320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRugK-00088M-HD
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 05:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRufV-0007am-C2
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRufT-0005Gf-Ss
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:30:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38444
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jRufT-00056M-A7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587720641;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GayJSxu31NJjkK+RV7rgcRrL2ypYdjoMkK5I24/4aV8=;
 b=abuqhcJw8wGEuiBp4cYKYMwMK61G3lZIgNFNbAKXHMhXr52vqOixYAmXSNHpfcnFAP4g6L
 9om6fsqoJEvZglOPMYrq1rVbdmC3GahjT/7RXXv1lAUHnIRAlqwYCpC2f5UuKN4oQ0xjDF
 XifZyzJ26k7nBcgNh1j/g9Axr4zK0gU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-BiKC4uJiObyqdSk2i5PKsw-1; Fri, 24 Apr 2020 05:30:35 -0400
X-MC-Unique: BiKC4uJiObyqdSk2i5PKsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F22591054F90;
 Fri, 24 Apr 2020 09:30:33 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C222560CD0;
 Fri, 24 Apr 2020 09:30:26 +0000 (UTC)
Date: Fri, 24 Apr 2020 10:30:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200424093023.GD1212635@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
 <20200423171322.GJ1077680@redhat.com>
 <348064782.9653447.1587663408130.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
In-Reply-To: <348064782.9653447.1587663408130.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:11:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Erik Skultety <eskultet@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 01:36:48PM -0400, Cleber Rosa wrote:
>=20
>=20
> ----- Original Message -----
> > From: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> > To: "Cleber Rosa" <crosa@redhat.com>
> > Cc: "Peter Maydell" <peter.maydell@linaro.org>, "Fam Zheng" <fam@euphon=
.net>, "Thomas Huth" <thuth@redhat.com>,
> > "Beraldo Leal" <bleal@redhat.com>, "Erik Skultety" <eskultet@redhat.com=
>, "Philippe Mathieu-Daud=C3=A9"
> > <philmd@redhat.com>, "Wainer Moschetta" <wmoschet@redhat.com>, "Markus =
Armbruster" <armbru@redhat.com>, "Wainer dos
> > Santos Moschetta" <wainersm@redhat.com>, "QEMU Developers" <qemu-devel@=
nongnu.org>, "Willian Rampazzo"
> > <wrampazz@redhat.com>, "Alex Benn=C3=A9e" <alex.bennee@linaro.org>, "Ed=
uardo Habkost" <ehabkost@redhat.com>
> > Sent: Thursday, April 23, 2020 1:13:22 PM
> > Subject: Re: [PATCH 0/5] QEMU Gating CI
> >=20
> > On Thu, Apr 23, 2020 at 01:04:13PM -0400, Cleber Rosa wrote:
> > >=20
> > >=20
> > > ----- Original Message -----
> > > > From: "Peter Maydell" <peter.maydell@linaro.org>
> > > > To: "Markus Armbruster" <armbru@redhat.com>
> > > > Cc: "Fam Zheng" <fam@euphon.net>, "Thomas Huth" <thuth@redhat.com>,
> > > > "Beraldo Leal" <bleal@redhat.com>, "Erik
> > > > Skultety" <eskultet@redhat.com>, "Alex Benn=C3=A9e" <alex.bennee@li=
naro.org>,
> > > > "Wainer Moschetta" <wmoschet@redhat.com>,
> > > > "QEMU Developers" <qemu-devel@nongnu.org>, "Wainer dos Santos Mosch=
etta"
> > > > <wainersm@redhat.com>, "Willian Rampazzo"
> > > > <wrampazz@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Philippe
> > > > Mathieu-Daud=C3=A9" <philmd@redhat.com>, "Eduardo
> > > > Habkost" <ehabkost@redhat.com>
> > > > Sent: Tuesday, April 21, 2020 8:53:49 AM
> > > > Subject: Re: [PATCH 0/5] QEMU Gating CI
> > > >=20
> > > > On Thu, 19 Mar 2020 at 16:33, Markus Armbruster <armbru@redhat.com>
> > > > wrote:
> > > > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > > > > I think we should start by getting the gitlab setup working
> > > > > > for the basic "x86 configs" first. Then we can try adding
> > > > > > a runner for s390 (that one's logistically easiest because
> > > > > > it is a project machine, not one owned by me personally or
> > > > > > by Linaro) once the basic framework is working, and expand
> > > > > > from there.
> > > > >
> > > > > Makes sense to me.
> > > > >
> > > > > Next steps to get this off the ground:
> > > > >
> > > > > * Red Hat provides runner(s) for x86 stuff we care about.
> > > > >
> > > > > * If that doesn't cover 'basic "x86 configs" in your judgement, w=
e
> > > > >   fill the gaps as described below under "Expand from there".
> > > > >
> > > > > * Add an s390 runner using the project machine you mentioned.
> > > > >
> > > > > * Expand from there: identify the remaining gaps, map them to peo=
ple /
> > > > >   organizations interested in them, and solicit contributions fro=
m
> > > > >   these
> > > > >   guys.
> > > > >
> > > > > A note on contributions: we need both hardware and people.  By pe=
ople I
> > > > > mean maintainers for the infrastructure, the tools and all the ru=
nners.
> > > > > Cleber & team are willing to serve for the infrastructure, the to=
ols
> > > > > and
> > > > > the Red Hat runners.
> > > >=20
> > > > So, with 5.0 nearly out the door it seems like a good time to check
> > > > in on this thread again to ask where we are progress-wise with this=
.
> > > > My impression is that this patchset provides most of the scripting
> > > > and config side of the first step, so what we need is for RH to pro=
vide
> > > > an x86 runner machine and tell the gitlab CI it exists. I appreciat=
e
> > > > that the whole coronavirus and working-from-home situation will hav=
e
> > > > upended everybody's plans, especially when actual hardware might
> > > > be involved, but how's it going ?
> > > >=20
> > >=20
> > > Hi Peter,
> > >=20
> > > You hit the nail in the head here.  We were affected indeed with our
> > > ability
> > > to move some machines from one lab to another (across the country), b=
ut
> > > we're
> > > actively working on it.
> >=20
> > For x86, do we really need to be using custom runners ?
> >=20
>=20
> Hi Daniel,
>=20
> We're already using the shared x86 runners, but with a different goal.  T=
he
> goal of the "Gating CI" is indeed to expand on non-x86 environments.  We'=
re
> in a "chicken and egg" kind of situation, because we'd like to prove that
> GitLab CI will allow QEMU to expand to very different runners and jobs, w=
hile
> not really having all that hardware setup and publicly available at this =
time.
>=20
> My experiments were really around that point, I mean, confirming that we =
can grow
> the number of architectures/runners/jobs/configurations to provide a cove=
rage
> equal or greater to what Peter already does.

So IIUC, you're saying that for x86 gating, the intention is to use shared
runners in general.

Your current work that you say is blocked on access to x86 hardware, is jus=
t
about demonstrating the concept of plugging in custom runners, while we wai=
t
for access to non-x86 hardware ?

> > With GitLab if someone forks the repo to their personal namespace, they
> > cannot use any custom runners setup by the origin project. So if we use
> > custom runners for x86, people forking won't be able to run the GitLab
> > CI jobs.
> >=20
>=20
> They will continue to be able use the jobs and runners already defined in
> the .gitlab-ci.yml file.  This work will only affect people pushing to th=
e/a
> "staging" branch.
>=20
> > As a sub-system maintainer I wouldn't like this, because I ideally want
> > to be able to run the same jobs on my staging tree, that Peter will run
> > at merge time for the PULL request I send.
> >=20
>=20
> If you're looking for symmetry between any PR and "merge time" jobs, the
> only solution is to allow any PR to access all the diverse set of non-sha=
red
> machines we're hoping to have in the near future.  This may be something
> we'll get to, but I doubt we can tackle it in the near future now.

It occurred to me that we could do this if we grant selective access to
the Gitlab repos, to people who are official subsystem maintainers.
GitLab has a concept of "protected branches", so you can control who is
allowed to push changes on a per-branch granularity.

So, for example, in the main qemu.git, we could create branches for each
subsystem tree eg

  staging-block
  staging-qapi
  staging-crypto
  staging-migration
  ....

and for each of these branches, we can grant access to relevant subsystem
maintainer(s).

When they're ready to send a pull request to Peter, they can push their
tree to this branch. Since the branch is in the main gitlab.com/qemu/qemu
project namespace, this branch can run CI using the private QEMU runners.
The subsystem maintainer can thus see the full set of CI results across
all platforms required by Gating, before Peter even gets the pull request.

So when Peter then looks at merging the pull request to master, the only
he's likely to see are the non-deterministic bugs, or issues caused by
semantic conflicts with other recently merged code.

It would even be possible to do the final merge into master entirely from
GitLab, no need to go via email. When the source branch & target branch are
within the same git repo, GitLab has the ability to run CI jobs against the
resulting merge commit in a strict gating manner, before it hits master.
They call this "Merge trains" in their documentation.

IOW, from Peter's POV, merging pull requests could be as simple as hitting
the merge button in GitLab merge request UI. Everything wrt CI would be
completely automated, and the subsystem maintainers would have the
responsibility to dealing with merge conflicts & CI failures, which is
more scalable for the person co-ordinating the merges into master.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


