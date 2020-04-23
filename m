Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51129C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF7220781
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THX+L/y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF7220781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfV2-0008Kf-5k
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRfPw-0001WX-TM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRfPv-0000KP-Fy
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:13:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34963
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jRfPv-0000K0-0Q
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587662017;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBTMgvWVqB+Rl6glkU5oLmh8M/ZNcy9xnUh7AtdAXmE=;
 b=THX+L/y0QlXTlGfPd7+ON0XGCjVzP1aEgoZ+wCVzFKvafy+3xcH3OZFdvjmkDmoxM5oehZ
 MGCUMHdr0IecKk8MkP/65xMrBvpd1aEDQ4abt3rXRKsEWdH1mLC5go36bJ10rytt73p1yf
 efsEtUxQ4B1VMMveU6XI5pVjVuv7PZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-zL14Dy02OOulEU_CarG5wg-1; Thu, 23 Apr 2020 13:13:33 -0400
X-MC-Unique: zL14Dy02OOulEU_CarG5wg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CB9E18A076B;
 Thu, 23 Apr 2020 17:13:32 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83A1F101E678;
 Thu, 23 Apr 2020 17:13:25 +0000 (UTC)
Date: Thu, 23 Apr 2020 18:13:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200423171322.GJ1077680@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
In-Reply-To: <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
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

On Thu, Apr 23, 2020 at 01:04:13PM -0400, Cleber Rosa wrote:
>=20
>=20
> ----- Original Message -----
> > From: "Peter Maydell" <peter.maydell@linaro.org>
> > To: "Markus Armbruster" <armbru@redhat.com>
> > Cc: "Fam Zheng" <fam@euphon.net>, "Thomas Huth" <thuth@redhat.com>, "Be=
raldo Leal" <bleal@redhat.com>, "Erik
> > Skultety" <eskultet@redhat.com>, "Alex Benn=C3=A9e" <alex.bennee@linaro=
.org>, "Wainer Moschetta" <wmoschet@redhat.com>,
> > "QEMU Developers" <qemu-devel@nongnu.org>, "Wainer dos Santos Moschetta=
" <wainersm@redhat.com>, "Willian Rampazzo"
> > <wrampazz@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Philippe Math=
ieu-Daud=C3=A9" <philmd@redhat.com>, "Eduardo
> > Habkost" <ehabkost@redhat.com>
> > Sent: Tuesday, April 21, 2020 8:53:49 AM
> > Subject: Re: [PATCH 0/5] QEMU Gating CI
> >=20
> > On Thu, 19 Mar 2020 at 16:33, Markus Armbruster <armbru@redhat.com> wro=
te:
> > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > > I think we should start by getting the gitlab setup working
> > > > for the basic "x86 configs" first. Then we can try adding
> > > > a runner for s390 (that one's logistically easiest because
> > > > it is a project machine, not one owned by me personally or
> > > > by Linaro) once the basic framework is working, and expand
> > > > from there.
> > >
> > > Makes sense to me.
> > >
> > > Next steps to get this off the ground:
> > >
> > > * Red Hat provides runner(s) for x86 stuff we care about.
> > >
> > > * If that doesn't cover 'basic "x86 configs" in your judgement, we
> > >   fill the gaps as described below under "Expand from there".
> > >
> > > * Add an s390 runner using the project machine you mentioned.
> > >
> > > * Expand from there: identify the remaining gaps, map them to people =
/
> > >   organizations interested in them, and solicit contributions from th=
ese
> > >   guys.
> > >
> > > A note on contributions: we need both hardware and people.  By people=
 I
> > > mean maintainers for the infrastructure, the tools and all the runner=
s.
> > > Cleber & team are willing to serve for the infrastructure, the tools =
and
> > > the Red Hat runners.
> >=20
> > So, with 5.0 nearly out the door it seems like a good time to check
> > in on this thread again to ask where we are progress-wise with this.
> > My impression is that this patchset provides most of the scripting
> > and config side of the first step, so what we need is for RH to provide
> > an x86 runner machine and tell the gitlab CI it exists. I appreciate
> > that the whole coronavirus and working-from-home situation will have
> > upended everybody's plans, especially when actual hardware might
> > be involved, but how's it going ?
> >=20
>=20
> Hi Peter,
>=20
> You hit the nail in the head here.  We were affected indeed with our abil=
ity
> to move some machines from one lab to another (across the country), but w=
e're
> actively working on it.

For x86, do we really need to be using custom runners ?

With GitLab if someone forks the repo to their personal namespace, they
cannot use any custom runners setup by the origin project. So if we use
custom runners for x86, people forking won't be able to run the GitLab
CI jobs.

As a sub-system maintainer I wouldn't like this, because I ideally want
to be able to run the same jobs on my staging tree, that Peter will run
at merge time for the PULL request I send.

Thus my strong preference would be to use the GitLab runners in every
scenario where they are viable to use. Only use custom runners in the
cases where GitLab runners are clearly inadequate for our needs.

Based on what we've setup in GitLab for libvirt,  the shared runners
they have work fine for x86. Just need the environments you are testing
to be provided as Docker containers (you can actually build and cache
the container images during your CI job too).  IOW, any Linux distro
build and test jobs should be able to use shared runners on x86, and
likewise mingw builds. Custom runners should only be needed if the
jobs need todo *BSD / macOS builds, and/or have access to specific
hardware devices for some reason.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


