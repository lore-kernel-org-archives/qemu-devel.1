Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45652C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7F321D6C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="He3rISsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7F321D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS4yP-0006jW-8c
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 14:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iS4xl-0006Kl-Vz
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iS4xj-00068m-DZ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:58:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57722
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iS4xj-00068C-6K
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572983878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UIfc32gUYU+9TMOjZVWdRq8cePCCLK8gKkTj6OtRDxM=;
 b=He3rISsHoWUs7m5Io4jQqTPG7eBMobakPemZhdMbySVjVGW9/kaUXWJxZ2FsN37ZuahaU/
 i5U/sq+ZWnrWqiJHrpkFC/iO+sNh6oBh7UxM8Fk1vW5lgtcxNHDVA06/1E8+ZP9l6LeGDo
 df4JSzUkTB1HQJkfUPnr9DI9KTNhFeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-xL8qi-0bPROuhNTgxqo7Jg-1; Tue, 05 Nov 2019 14:57:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2381E1800D78;
 Tue,  5 Nov 2019 19:57:53 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FBE91001902;
 Tue,  5 Nov 2019 19:57:49 +0000 (UTC)
Date: Tue, 5 Nov 2019 16:57:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/1] Require Python >= 3.5 to build QEMU
Message-ID: <20191105195748.GG3812@habkost.net>
References: <20191025203427.20181-1-ehabkost@redhat.com>
 <CAFEAcA-F0iB2vzi3Z0J9FPAt6JpuMh+V0wsfXWLuAGX5_d69xw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-F0iB2vzi3Z0J9FPAt6JpuMh+V0wsfXWLuAGX5_d69xw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xL8qi-0bPROuhNTgxqo7Jg-1
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 31, 2019 at 08:12:01AM +0000, Peter Maydell wrote:
> On Fri, 25 Oct 2019 at 21:34, Eduardo Habkost <ehabkost@redhat.com> wrote=
:
> >
> > The following changes since commit 03bf012e523ecdf047ac56b2057950247256=
064d:
> >
> >   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into s=
taging (2019-10-25 14:59:53 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
> >
> > for you to fetch changes up to d24e417866f85229de1b75bc5c0a1d942451a842=
:
> >
> >   configure: Require Python >=3D 3.5 (2019-10-25 16:34:57 -0300)
> >
> > ----------------------------------------------------------------
> > Require Python >=3D 3.5 to build QEMU
> >
> > ----------------------------------------------------------------
>=20
> I can't apply this until we've fixed the tests/vm netbsd setup to
> not use Python 2.

Fixing tests/vm/netbsd is being tricky.  It looks like the
configure patch will have to wait until after QEMU 4.2.0.  :(

>=20
> Have you tried a test run with Travis/etc/etc to check that none of
> those CI configs need updating to have python3 available ?

I have tested this pull request on Shippable, and I will take a
look at Travis.  I'd appreciate help from the CI system
maintainers (CCed) for the rest, as I don't have accounts in all
our CI systems.

Do we expect maintainers to test their pull requests in all CI
systems listed at the QEMU wiki[1]?  Do we have an official list
of CI systems that you consider to be pull request blockers?

[1] https://wiki.qemu.org/Testing#Continuous_Integration

--=20
Eduardo


