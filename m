Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12C1C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 13:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59A4222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 13:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59A4222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDTOr-0003oi-E0
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 09:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iDTMI-0001m5-I3
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iDTMH-0003KX-89
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1iDTM7-0003BP-QV; Thu, 26 Sep 2019 08:58:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FA6530BBE8A;
 Thu, 26 Sep 2019 12:58:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29E95194B6;
 Thu, 26 Sep 2019 12:58:45 +0000 (UTC)
Date: Thu, 26 Sep 2019 13:58:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] configure: deprecate 32 bit build hosts
Message-ID: <20190926125817.GB19660@redhat.com>
References: <20190925233013.6449-1-alex.bennee@linaro.org>
 <CAFEAcA9vb5_Mi_axWpu7269Zg0xMLbiiV80ofLeyDpfws3G4nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9vb5_Mi_axWpu7269Zg0xMLbiiV80ofLeyDpfws3G4nQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 26 Sep 2019 12:58:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 qemu-discuss <qemu-discuss@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 08:50:36AM +0100, Peter Maydell wrote:
> On Thu, 26 Sep 2019 at 00:31, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >
> > The 32 bit hosts are already a second class citizen especially with
> > support for running 64 bit guests under TCG. We are also limited by
> > testing as actual working 32 bit machines are getting quite rare in
> > developers personal menageries. For TCG supporting newer types like
> > Int128 is a lot harder with 32 bit calling conventions compared to
> > their larger bit sized cousins. Fundamentally address space is the
> > most useful thing for the translator to have even for a 32 bit guest =
a
> > 32 bit host is quite constrained.
> >
> > As far as I'm aware 32 bit KVM users are even less numerous. Even
> > ILP32 doesn't make much sense given the address space QEMU needs to
> > manage.
>=20
> For KVM we should wait until the kernel chooses to drop support,
> I think.

What if the kernel is waiting for QEMU to drop support too ;-P

> > @@ -745,19 +744,22 @@ case "$cpu" in
> >    ;;
> >    armv*b|armv*l|arm)
> >      cpu=3D"arm"
> > -    supported_cpu=3D"yes"
> >    ;;
>=20
> I'll leave others to voice opinions about their architectures,
> but I still have 32-bit arm in my test set for builds, and
> I'm pretty sure we have users (raspi users, for a start).

RHEL dropped all 32-bit host support a long time ago, so Red Hat
don't care for our products.

Fedora has recently stopped building i686 kernels and thus also no
long composes i686 installs. Some users complained, but ultimately
no one cares enough to step forward as maintainers.

That leaves armv7 as the only 32-bit arch in Fedora that is somewhat
active & maintained. I don't have any real insight on whether any
armv7 (Fedora) users are making much use of QEMU/KVM though, either
system or user emulation.=20

Our preference in Fedora is to have things built on every architecture
that the distro targets, but if upstream developers explicitly drop an
architecture we're not going to try to add it back.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

