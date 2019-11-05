Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A14BC5DF61
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2297021A49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfdNdhAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2297021A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5a7-0000b2-BC
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iS5Z0-00008N-B9
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:36:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iS5Yy-0002DY-A1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:36:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54182
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iS5Yy-0002D8-4q
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572986187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gpMQq1MIbTR9qx9rUnlY1b3RwBdDaRcq02JfZfVDioU=;
 b=PfdNdhAhQ/sew679syqcWLI/38kJ/OefruAoSE403/AoQZ7NOXsD3aExF1JqPt2snu2lNL
 6iPPoC2zGGyjteoRQq9R5LgZpwBqv/5fEPi4zpzNX6NrlWmu0/eW/5kFSN5alvVwpwnmb6
 UTfHLPbQvFfoszzfEkBcke3CHefsC50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-QQeIOFwgPeipCZbb6u-4mA-1; Tue, 05 Nov 2019 15:36:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CCD38017DD;
 Tue,  5 Nov 2019 20:36:24 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 010735D9C9;
 Tue,  5 Nov 2019 20:36:20 +0000 (UTC)
Date: Tue, 5 Nov 2019 17:36:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 0/1] Require Python >= 3.5 to build QEMU
Message-ID: <20191105203619.GJ3812@habkost.net>
References: <20191025203427.20181-1-ehabkost@redhat.com>
 <CAFEAcA-F0iB2vzi3Z0J9FPAt6JpuMh+V0wsfXWLuAGX5_d69xw@mail.gmail.com>
 <20191105195748.GG3812@habkost.net> <87y2wuhy00.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87y2wuhy00.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: QQeIOFwgPeipCZbb6u-4mA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 05, 2019 at 08:25:03PM +0000, Alex Benn=E9e wrote:
>=20
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
> > On Thu, Oct 31, 2019 at 08:12:01AM +0000, Peter Maydell wrote:
> >> On Fri, 25 Oct 2019 at 21:34, Eduardo Habkost <ehabkost@redhat.com> wr=
ote:
> >> >
> >> > The following changes since commit 03bf012e523ecdf047ac56b2057950247=
256064d:
> >> >
> >> >   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' int=
o staging (2019-10-25 14:59:53 +0100)
> >> >
> >> > are available in the Git repository at:
> >> >
> >> >   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
> >> >
> >> > for you to fetch changes up to d24e417866f85229de1b75bc5c0a1d942451a=
842:
> >> >
> >> >   configure: Require Python >=3D 3.5 (2019-10-25 16:34:57 -0300)
> >> >
> >> > ----------------------------------------------------------------
> >> > Require Python >=3D 3.5 to build QEMU
> >> >
> >> > ----------------------------------------------------------------
> >>
> >> I can't apply this until we've fixed the tests/vm netbsd setup to
> >> not use Python 2.
> >
> > Fixing tests/vm/netbsd is being tricky.  It looks like the
> > configure patch will have to wait until after QEMU 4.2.0.  :(
>=20
> I've posted fixes for the netbsd serial install but there are still
> problems with the tests including what looks like a fairly serious
> failure in the async code.

This sounds like a known "feature": QEMU expects clients to be
constantly reading from chardev sockets until the socket is
closed.  Otherwise, VCPU threads may block waiting for the socket
to be writeable.


>=20
> >
> >>
> >> Have you tried a test run with Travis/etc/etc to check that none of
> >> those CI configs need updating to have python3 available ?
> >
> > I have tested this pull request on Shippable, and I will take a
> > look at Travis.  I'd appreciate help from the CI system
> > maintainers (CCed) for the rest, as I don't have accounts in all
> > our CI systems.
>=20
> Setting up accounts on the others doesn't take long. I use the
> CustomCIStatus template to instantiate all the buttons for my various
> maintainer branches on the wiki, e.g.:
>=20
>   {{CustomCIStatus|user=3Dstsquad|repo=3Dqemu|branch=3Dtesting/next|ship_=
proj=3D5885eac43b653a0f00fa97f5}}
>=20
> which means I just have to glance at the button state rather than going
> through each individual CI's status pages.

This is awesome.  Thanks for the tip!

>=20
> > Do we expect maintainers to test their pull requests in all CI
> > systems listed at the QEMU wiki[1]?  Do we have an official list
> > of CI systems that you consider to be pull request blockers?
>=20
> Well they all catch various things but none of them catch all the things
> Peter's PR processing does. Historically Travis has been allowed to
> slide because of test instability and timeouts. Having said that last I
> checked everything was green so breaking any of the main CIs
> (Travis/Shippable/Cirrus/Gitlab) indicates there is a problem that needs
> to be fixed.

Manually checking if 5 different CI systems are green wouldn't be
reasonable to me, but the CustomCIStatus template will be useful.

--=20
Eduardo


