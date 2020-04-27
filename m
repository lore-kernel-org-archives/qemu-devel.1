Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC9AC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 05:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACB4206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 05:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUscohWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACB4206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSwGS-0005ph-0i
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 01:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jSwFk-0005Hi-I1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 01:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jSwFi-00063k-V1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 01:24:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39409
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jSwFi-00062V-Ik
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 01:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587965060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obEKgbb4FzvRCfi92y9U0x4pBSuEa7pIi76iFLBUMG4=;
 b=RUscohWBBeUrbF6SuL7JsQTmUaBo3+ed+bOCpsHkPxQGfYQO6tugQXLvRxlmpPrad/FWaf
 9KimrWFMF2CMNKHK4/PSl2q1SKLHWwhP7qKH+Qly+OB+fkAtmAKLO/w8ihWiAtMZXOQ29o
 cKCFVdDVoeXaR/m5BeP3Gpd+/n+BS/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-U6rpNC6oPrC9KWlk4NjowQ-1; Mon, 27 Apr 2020 01:24:18 -0400
X-MC-Unique: U6rpNC6oPrC9KWlk4NjowQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0D8D80B702;
 Mon, 27 Apr 2020 05:24:16 +0000 (UTC)
Received: from localhost (ovpn-112-178.rdu2.redhat.com [10.10.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D1B95D9D7;
 Mon, 27 Apr 2020 05:24:12 +0000 (UTC)
Date: Mon, 27 Apr 2020 01:24:04 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Erik Skultety <eskultet@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200427012404.4ecf7b71@redhat.com>
In-Reply-To: <20200424065746.GB372397@sturgeon.usersys.redhat.com>
References: <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
 <20200423171322.GJ1077680@redhat.com>
 <69e77a6e-8db8-f617-bfe6-1c8f39ec81b4@redhat.com>
 <20200424065746.GB372397@sturgeon.usersys.redhat.com>
Organization: Red Hat, Inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 Thomas Huth <thuth@redhat.com>, "Daniel
 P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
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

On Fri, 24 Apr 2020 08:57:46 +0200
Erik Skultety <eskultet@redhat.com> wrote:

> On Thu, Apr 23, 2020 at 11:28:21PM +0200, Philippe Mathieu-Daud=C3=A9
> wrote:
> > On 4/23/20 7:13 PM, Daniel P. Berrang=C3=A9 wrote:
> > > On Thu, Apr 23, 2020 at 01:04:13PM -0400, Cleber Rosa wrote:
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
> > > > > >=20
> > > > > > Makes sense to me.
> > > > > >=20
> > > > > > Next steps to get this off the ground:
> > > > > >=20
> > > > > > * Red Hat provides runner(s) for x86 stuff we care about.
> > > > > >=20
> > > > > > * If that doesn't cover 'basic "x86 configs" in your
> > > > > > judgement, we fill the gaps as described below under
> > > > > > "Expand from there".
> > > > > >=20
> > > > > > * Add an s390 runner using the project machine you
> > > > > > mentioned.
> > > > > >=20
> > > > > > * Expand from there: identify the remaining gaps, map them
> > > > > > to people / organizations interested in them, and solicit
> > > > > > contributions from these guys.
> > > > > >=20
> > > > > > A note on contributions: we need both hardware and people.
> > > > > > By people I mean maintainers for the infrastructure, the
> > > > > > tools and all the runners. Cleber & team are willing to
> > > > > > serve for the infrastructure, the tools and the Red Hat
> > > > > > runners.
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
> > > > with our ability to move some machines from one lab to another
> > > > (across the country), but we're actively working on it.
> > >=20
> > > For x86, do we really need to be using custom runners ?
> > >=20
> > > With GitLab if someone forks the repo to their personal
> > > namespace, they cannot use any custom runners setup by the origin
> > > project. So if we use custom runners for x86, people forking
> > > won't be able to run the GitLab CI jobs.
> > >=20
> > > As a sub-system maintainer I wouldn't like this, because I
> > > ideally want to be able to run the same jobs on my staging tree,
> > > that Peter will run at merge time for the PULL request I send.
> > >=20
> > > Thus my strong preference would be to use the GitLab runners in
> > > every scenario where they are viable to use. Only use custom
> > > runners in the cases where GitLab runners are clearly inadequate
> > > for our needs.
> > >=20
> > > Based on what we've setup in GitLab for libvirt,  the shared
> > > runners they have work fine for x86. Just need the environments
> > > you are testing to be provided as Docker containers (you can
> > > actually build and cache the container images during your CI job
> > > too).  IOW, any Linux distro build and test jobs should be able
> > > to use shared runners on x86, and likewise mingw builds. Custom
> > > runners should only be needed if the jobs need todo *BSD / macOS
> > > builds, and/or have access to specific hardware devices for some
> > > reason.
>=20
> Not just ^that, you also want custom VM runners to run integration
> tests, e.g. in libvirt, we'd have to put systemd and a lof of other
> cruft into the container to be able to run the tests at which point
> you must ask yourself, whyt not go with a VM instead in which case
> we're limited in terms of infrastructure...
>=20

I'm completely in agreement that a lot of the jobs will be suitable to
be run on containers, but like you exemplified here Erik, we must take
into account the ones that won't be suitable.

For instance, a very real use case is testing KVM on bare metal.  One
could argue that "QEMU running on a container making use of
KVM would suffice". It may be true, it may not.  But even that=20
won't be possible Today on a CentOS/RHEL 8 machine, because
gitlab-runner knows nothing about podman, so full blown x86
physical boxes may be the "cheaper" and more practical solution, at
least initially. Trying to use other architectures would surely have
similar issues.

> >=20
> > Thanks to insist with that point Daniel. I'd rather see every
> > configuration reproducible, so if we loose a hardware sponsor, we
> > can find another one and start another runner.
> > Also note, if it is not easy to reproduce a runner, it will be very
> > hard to debug a reported build/test error.
>=20
> (Thanks for bringing ^this point up Philippe)
>=20
> ...However, what we've been actively working on in libvirt is to
> extend the lcitool we have (which can spawn local test VMs) to the
> point where we're able to generate machines that would be the
> reproducible. Right now I'm playing with cloud-init integration with
> lcitool (patches coming soon) that would allow us to use the same
> machines locally as we'd want to have in, say, OpenStack and share
> them as compressed images, so even when updated/managed by lcitool
> locally, you'd get the same environment.
>=20
> Regards,
>=20

This is great, and it aligns with my previous point that reproducibility
it's not *just* about the hardware, but about diligently documenting
and automating the environments, be them mundane or super specialized.
And IMO that should score some points when it comes to being
promoted/demoted as a Gating machine/job.

Thanks for the feedback Erik!
- Cleber.


