Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA22FC54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC96E2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8zWcjVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC96E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50953 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT5aC-00028G-SU
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 11:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jT5Z8-0000a3-7V
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jT5Z2-0003px-QT
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:21:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42900
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jT5Z2-0003ON-CS
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588000851;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9RfsftBIQkIbPtPvwLFbQ9i7OHhaqSTHoPEQ1dSEY0c=;
 b=A8zWcjVAAakeDvtIJ9dI1mBdva3Ine92qDO1EcSahmz+5NXWpRSNAuDluZJ7bm0r0JuP2b
 /FRB6RHKnokkqOYrqZxJ9gO3Wvs+hBR3IHjFMKP8XdrJKbrh1SVcfOmFFSsSY2/Y6W+VVx
 nceKz9AJlEwfNqMNj3YMesmEQVu+n0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-OC2cYvWtMDiyU3iobR1SlA-1; Mon, 27 Apr 2020 11:20:47 -0400
X-MC-Unique: OC2cYvWtMDiyU3iobR1SlA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D070546B;
 Mon, 27 Apr 2020 15:20:46 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B1B919C58;
 Mon, 27 Apr 2020 15:20:39 +0000 (UTC)
Date: Mon, 27 Apr 2020 16:20:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200427152036.GI1244803@redhat.com>
References: <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
 <20200423171322.GJ1077680@redhat.com>
 <69e77a6e-8db8-f617-bfe6-1c8f39ec81b4@redhat.com>
 <20200427011210.745db351@redhat.com>
 <05670290-5ba0-8be0-624b-da1c95f3e820@redhat.com>
 <20200427102835.6f625859@redhat.com>
 <48b0d8e6-3b9d-981d-c6a3-bdee5580f701@redhat.com>
MIME-Version: 1.0
In-Reply-To: <48b0d8e6-3b9d-981d-c6a3-bdee5580f701@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Erik Skultety <eskultet@redhat.com>, Wainer Moschetta <wmoschet@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 04:41:38PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On 4/27/20 4:28 PM, Cleber Rosa wrote:
> > On Mon, 27 Apr 2020 12:51:36 +0200
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >=20
> > > On 4/27/20 7:12 AM, Cleber Rosa wrote:
> > > > On Thu, 23 Apr 2020 23:28:21 +0200
> > > > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> > > [...]
> > > > > In some cases custom runners are acceptable. These runners won't =
be
> > > > > "gating" but can post informative log and status.
> > > > >=20
> > > >=20
> > > > Well, I have the feeling that some people maintaining those runners
> > > > will *not* want to have them as "informational" only.  If they
> > > > invest a good amount of time on them, I believe they'll want to
> > > > reap the benefits such as other not breaking the code they rely on.
> > > >   If their system is not gating, they lose that and may find
> > > > breakage that CI did not catch.  Again, I don't think "easily
> > > > accessible" hardware should be the only criteria for
> > > > gating/non-gating status.
> > > >=20
> > > > For instance, would you consider, say, a "Raspberry Pi 4 Model
> > > > B", running KVM jobs to be a reproducible runner?  Would you blame =
a
> > > > developer that breaks a Gating CI job on such a platform and says
> > > > that he can not reproduce it?
> > >=20
> > > I'm not sure I understood the problem, as I'd answer "yes" but I
> > > guess you expect me to say "no"?
> > >=20
> >=20
> > What I mean is: would you blame such a developer for *not* having a
> > machine himself/herself that he/she can try to reproduce the failure?
> > And would you consider a "Raspberry Pi 4 Model B" an easily available
> > hardware?
>=20
> My view on this is if someone merged code in mainstream QEMU and maintain=
s
> it, and if it is not easy to reproduce the setup (for a bug reported by a=
 CI
> script), then it is the responsibility of the maintainer to resolve it.
> Either by providing particular access to the hardware, or be ready to spe=
nd
> a long debugging session over email and multiple time zones.
>=20
> If it is not possible, then this specific code/setup can not claim for
> gating CI, and eventually mainstream isn't the best place for it.

I'd caution to be wary about using gating CI as a big stick for hitting
contributors with. The more rules we put in place whicih contributors
have to follow before their work gets accepted for merge, the less likely
someone is to have a positive experiance contributing to the project, or
even be willing to try. This view of gating CI requirements was a negative
aspect of contributing to the OpenStack project, which drove people away.
There was pushback against contributing work because it lacked CI, but
there was often no viable way for to actually provide CI in a feasible
timeframe, especially for stuff only testable in physical hardware and
not VMs. Even if you work for a big company, it doesn't make it easy to
magic up money to spend on hardware & hosting to provide CI, as corporate
beaurcracy & priorities will get in your way.

I'd really encourage the more nuanced approach of thinking in terms of
tiered support levels:

  - Tier 1: features that we have gating CI tests for. Will always work.

  - Tier 2: features that we have non-gating CI test for. Should work at
            time of release, but may be broken for periods in git master.
=09   =20
  - Tier 3: features that we don't have CI tests for. Compile tested only,
            relying on end user manual testing, so may or may not work
=09    at any time or in release.

Obviously tier 1 is the gold standard that we would like everything to
achieve but we'll never achieve that reality unless we cull 90% of QEMU's
code. I don't think that's in the best interests of our users, because
clearly stuff in Tier 2 and Tier 3 is still useful for a large portion of
our end users - not least because Tier 3 is the level everything is at
right now in QEMU unless using a downstream vendor's packages.

The tier levels and CI are largely around setting reasonable quality
expectations. Right now we often have a problem that poeople want to
re-factor code but are afraid of breaking existing functionality that
guests rely on. This causes delays in merging code or causes people to
not even attempt the refactoring in the first place. This harms our
forward progress in QEMU.

With gating CI, we are declaring that contributors should feel free to
refactor anything as long as it passes gating CI. IOW, contributors only
have to care about Tier 1 features continuing to work. It would be nice
if refactoring does not breaks stuff in Tier 2 / 3, but if it does, then
that is acceptable collatoral damage. We would not block the merge on
stuff that is Tier 2 / 3.

Based on what I experianced in OpenStack the other big challenge is
deciding when something can be promoted from Tier 2 to Tier 1. They
had the official gating CI (for Tier 1) being maintained by the core
project infrastructure team. Any CI provided by third party companies
was non-gating (Tier 2) (at least in the time I was involved) because
they did not want code merge blocked on ability to communicate with
third party companies who were often hard to contact when CI broke.
So the only real path from Tier 2 to Tier 1 was to give the project
direct access to the CI hardware, instead of having the providing
company self-manage it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


