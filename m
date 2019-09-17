Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623B7C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3FF206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3FF206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAMzW-0001Dq-Ed
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 19:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iAMwo-00086b-2k
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iAMwl-0006Pp-Ud
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:31:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iAMwl-0006PX-PA
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:31:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8EA4218C8900;
 Tue, 17 Sep 2019 23:31:46 +0000 (UTC)
Received: from localhost (ovpn-116-86.gru2.redhat.com [10.97.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E155A5C219;
 Tue, 17 Sep 2019 23:31:41 +0000 (UTC)
Date: Tue, 17 Sep 2019 20:31:40 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190917233140.GK4082@habkost.net>
References: <20190607211544.7964-1-ehabkost@redhat.com>
 <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
 <20190701222527.GJ5198@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190701222527.GJ5198@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 17 Sep 2019 23:31:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Python 2 in tests/vm (was Re: [PULL 0/8] Python
 queue, 2019-06-07)
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 01, 2019 at 07:25:27PM -0300, Eduardo Habkost wrote:
> On Mon, Jun 10, 2019 at 01:58:50PM +0100, Peter Maydell wrote:
> > On Fri, 7 Jun 2019 at 22:16, Eduardo Habkost <ehabkost@redhat.com> wr=
ote:
> > >
> > > The following changes since commit 185b7ccc11354cbd69b6d53bf8d831dd=
964f6c88:
> > >
> > >   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190607-=
2' into staging (2019-06-07 15:24:13 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
> > >
> > > for you to fetch changes up to 8297719709f1339506d6da93ec69e6118ace=
8676:
> > >
> > >   travis: Make check-acceptance job more verbose (2019-06-07 18:11:=
02 -0300)
> > >
> > > ----------------------------------------------------------------
> > > Python queue, 2019-06-07
> > >
> > > * New boot_linux_console test cases (Philippe Mathieu-Daud=E9)
> > > * Deprecate Python 2 support (Eduardo Habkost)
> > > * Require python3 >=3D 3.5 (Eduardo Habkost)
> > > * Make check-acceptance Travis job more verbose (Eduardo Habkost)
> > >
> > > ----------------------------------------------------------------
> >=20
> > Hi. This fails to build on one of my buildtest machines:
> >=20
> > ERROR: Cannot use 'python3', Python 2 >=3D 2.7 or Python 3 >=3D 3.5 i=
s required.
> >        Use --python=3D/path/to/python to specify a supported Python.
> >=20
> > The machine has python 2.7.6 and 3.4.3. (It's an Ubuntu trusty
> > box; it's one of the gcc compile farm machines so upgrades to its
> > OS are not really under my control.)
> >=20
> > The configure check also spits out deprecation warnings for
> > the NetBSD/FreeBSD/OpenBSD tests/vm configurations. It would be nice
> > to get those updated.
>=20
> CCing the test/vm maintainers.
>=20
> Fam, Alex, are you able to fix this and create new BSD VM images
> with Python 3 available?  I thought the VM image configurations
> were stored in the source tree, but they are downloaded from
> download.patchew.org.

Fam, Alex, can you help us on this?  Python 2 won't be supported
anymore, so we need the VM images to be updated.

--=20
Eduardo

