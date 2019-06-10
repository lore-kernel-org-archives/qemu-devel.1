Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E281FC282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EE020679
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EE020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haK5i-000660-R8
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41693)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1haK51-0005bW-Td
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1haK4y-0001wL-9e
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:11:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1haK4y-0001pQ-33
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:11:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9250522388A;
 Mon, 10 Jun 2019 13:11:07 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2788560BF3;
 Mon, 10 Jun 2019 13:11:06 +0000 (UTC)
Date: Mon, 10 Jun 2019 10:11:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190610131105.GJ22416@habkost.net>
References: <20190607211544.7964-1-ehabkost@redhat.com>
 <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 10 Jun 2019 13:11:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/8] Python queue, 2019-06-07
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 10, 2019 at 01:58:50PM +0100, Peter Maydell wrote:
> On Fri, 7 Jun 2019 at 22:16, Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
> >
> > The following changes since commit 185b7ccc11354cbd69b6d53bf8d831dd96=
4f6c88:
> >
> >   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190607-2'=
 into staging (2019-06-07 15:24:13 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
> >
> > for you to fetch changes up to 8297719709f1339506d6da93ec69e6118ace86=
76:
> >
> >   travis: Make check-acceptance job more verbose (2019-06-07 18:11:02=
 -0300)
> >
> > ----------------------------------------------------------------
> > Python queue, 2019-06-07
> >
> > * New boot_linux_console test cases (Philippe Mathieu-Daud=E9)
> > * Deprecate Python 2 support (Eduardo Habkost)
> > * Require python3 >=3D 3.5 (Eduardo Habkost)
> > * Make check-acceptance Travis job more verbose (Eduardo Habkost)
> >
> > ----------------------------------------------------------------
>=20
> Hi. This fails to build on one of my buildtest machines:
>=20
> ERROR: Cannot use 'python3', Python 2 >=3D 2.7 or Python 3 >=3D 3.5 is =
required.
>        Use --python=3D/path/to/python to specify a supported Python.
>=20
> The machine has python 2.7.6 and 3.4.3. (It's an Ubuntu trusty
> box; it's one of the gcc compile farm machines so upgrades to its
> OS are not really under my control.)

Ubuntu 16.04 LTS (Xenial) was released in April 2016.  Doesn't
that mean Trusty is not a supported build platform since April
2018?

>=20
> The configure check also spits out deprecation warnings for
> the NetBSD/FreeBSD/OpenBSD tests/vm configurations. It would be nice
> to get those updated.

I'll take a look.

--=20
Eduardo

