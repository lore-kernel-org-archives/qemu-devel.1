Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3482AC54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF503206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J71KcQzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF503206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4lu-0007g7-Ta
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jT4lD-00071B-9f
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jT4lB-0005N1-Do
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:29:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38089
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jT4lA-0005AK-Uo
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587997763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gRtU0gmOFavXoKOs2WjqwJpLiAZ/lkEkPNM1sqbtnT0=;
 b=J71KcQzn6p5YkHXtIrod3IN5Gls67f1sb8rxN+FLVwUXplExZLJoZ9BkWshIDP+kBepTs1
 PpvTjw9fcQxFf4vF3/SHlizoy2TqWfP/netjpMwC45P9NNdd7qhMyUu/WvpnpwG9u0SQcn
 ekXaVEw7Cc7d0OMXFHvQqvc1nfAXW5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-LIrFKY70PxGIxJ1jKVj0GA-1; Mon, 27 Apr 2020 10:29:19 -0400
X-MC-Unique: LIrFKY70PxGIxJ1jKVj0GA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51202801504;
 Mon, 27 Apr 2020 14:29:18 +0000 (UTC)
Received: from localhost (ovpn-112-178.rdu2.redhat.com [10.10.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 940D360C18;
 Mon, 27 Apr 2020 14:28:41 +0000 (UTC)
Date: Mon, 27 Apr 2020 10:28:35 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200427102835.6f625859@redhat.com>
In-Reply-To: <05670290-5ba0-8be0-624b-da1c95f3e820@redhat.com>
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
 <20200427011210.745db351@redhat.com>
 <05670290-5ba0-8be0-624b-da1c95f3e820@redhat.com>
Organization: Red Hat, Inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:33:12
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

On Mon, 27 Apr 2020 12:51:36 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 4/27/20 7:12 AM, Cleber Rosa wrote:
> > On Thu, 23 Apr 2020 23:28:21 +0200
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> [...]
> >> In some cases custom runners are acceptable. These runners won't be
> >> "gating" but can post informative log and status.
> >>
> >=20
> > Well, I have the feeling that some people maintaining those runners
> > will *not* want to have them as "informational" only.  If they
> > invest a good amount of time on them, I believe they'll want to
> > reap the benefits such as other not breaking the code they rely on.
> >  If their system is not gating, they lose that and may find
> > breakage that CI did not catch.  Again, I don't think "easily
> > accessible" hardware should be the only criteria for
> > gating/non-gating status.
> >=20
> > For instance, would you consider, say, a "Raspberry Pi 4 Model
> > B", running KVM jobs to be a reproducible runner?  Would you blame a
> > developer that breaks a Gating CI job on such a platform and says
> > that he can not reproduce it?
>=20
> I'm not sure I understood the problem, as I'd answer "yes" but I
> guess you expect me to say "no"?
>=20

What I mean is: would you blame such a developer for *not* having a
machine himself/herself that he/she can try to reproduce the failure?
And would you consider a "Raspberry Pi 4 Model B" an easily available
hardware?

> [...]
> >> Now the problem is GitLab runner is not natively available on the
> >> architectures listed in this mail, so custom setup is required. A
> >> dumb script running ssh to a machine also works (tested) but lot of
> >> manual tuning/maintenance expected.
> >>
> >=20
> > That's where I'm trying to help.  I built and tested the
> > gitlab-runner for a number of non-supported environments, and I
> > expect to build further on that (say contributing code or feedback
> > back to GitLab so they become official builds?).
>=20
> Good luck with that, it took more that 2 years to GitLab to
> officially support AMD64:
> https://gitlab.com/gitlab-org/gitlab-runner/-/merge_requests/725
>=20

You mean aarch64, sure.  I'm not holding my breath, because we can
always have our own binaries/ports (or other executors such as ssh) but
I'm optimistic...

> Hopefully the first non-x86 user was the hardest one who had to do
> all the bad work, and next architecture might get supported quicker...
>=20

... and this point is one of the reasons.  The other is competition
from Travis-CI (and others).

Cheers,
- Cleber.


