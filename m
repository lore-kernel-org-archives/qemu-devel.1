Received: from eggs.gnu.org ([2001:4830:134:3::10]:37712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gMXQM-0003Kb-Dx
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gMXQG-0002ts-4J
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:04:06 -0500
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:47134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gMXQF-0002sL-Tw
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:04:00 -0500
Received: from player778.ha.ovh.net (unknown [10.109.159.224])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3C82D172A05
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 13:03:58 +0100 (CET)
Date: Tue, 13 Nov 2018 13:03:47 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181113130347.12013ef4@bahia.lan>
In-Reply-To: <A02D6AA901860840B46E751C5E9E38B43CC97027@DGGEML532-MBX.china.huawei.com>
References: <A02D6AA901860840B46E751C5E9E38B43CC96FA1@DGGEML532-MBX.china.huawei.com>
	<20181113112855.4f3984f8@bahia.lan>
	<A02D6AA901860840B46E751C5E9E38B43CC97027@DGGEML532-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/3] fsdev-throttle-qmp: refactor code
 for qmp interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiezhide <xiezhide@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>

On Tue, 13 Nov 2018 11:17:19 +0000
xiezhide <xiezhide@huawei.com> wrote:

> Following is the the patch header,  user name and mail are the same at Fr=
om and Signed-off-by :
>=20

=46rom and Signed-off-by are the same indeed but x00390961 doesn't look like a
valid name.

You should read the following page. It explains everything you need to know
in order to send useful contributions.

https://wiki.qemu.org/Contribute/SubmitAPatch

About Signed-off-by:

https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_S=
igned-off-by:_line

"Please use your real name to sign a patch (not an alias or acronym)."

Cheers,

--
Greg

> -------------------
> From 457f3168eca2d041bbfcad822ad9004e29a3840c Mon Sep 17 00:00:00 2001
> From: x00390961 <xiezhide@huawei.com>
> Date: Wed, 14 Nov 2018 01:03:49 +0800
> Subject: [PATCH 1/3] fsdev-throttle-qmp: refactor code for qmp interface =
for
>  io throttling
>=20
> This patch includes two parts:
> 1. factor out throttle code to reuse code
> 2. use ThrottleLimits structure
>=20
> Signed-off-by: x00390961 <xiezhide@huawei.com>
>=20
>=20
> Anyway, let me try git send-email
>=20
> Thanks
> Kidd
>=20
> -----Original Message-----
> From: Greg Kurz [mailto:groug@kaod.org]=20
> Sent: 2018=E5=B9=B411=E6=9C=8813=E6=97=A5 18:29
> To: xiezhide <xiezhide@huawei.com>
> Cc: qemu-devel@nongnu.org; Eric Blake <eblake@redhat.com>; armbru@redhat.=
com; dgilbert@redhat.com; berto@igalia.com; aneesh.kumar@linux.vnet.ibm.com
> Subject: Re: [Qemu-devel][PATCH v1 0/3] fsdev-throttle-qmp: refactor code=
 for qmp interface
>=20
> Hi Kidd,
>=20
> This posting is still broken: no threading and missing leading blanks on =
unchanged lines. Also is x00390961 really your name of choice ?
>=20
> In some other mail, you mentioned copy-paste to an outlook mail client...
> please don't do that to post series. Use git format-patch and git send-em=
ail instead and you'll get the formatting and threading right.
>=20
> Cheers,
>=20
> --
> Greg
>=20
> On Tue, 13 Nov 2018 09:59:54 +0000
> xiezhide <xiezhide@huawei.com> wrote:
>=20
> > This patches provide qmp interface to query/set io throttle parameters =
of a fsdev.
> > Some of patches also refactor the code and structure that was present i=
n block and fsdev files.
> >=20
> > x00390961 (3):
> >   fsdev-throttle-qmp: refactor code for qmp interface for io throttling
> >   fsdev-throttle-qmp: qmp interface for fsdev io throttling
> >   fsdev-throttle-qmp: hmp interface for fsdev io throttling
> >=20
> >  Makefile                        |  20 +++-
> >  Makefile.objs                   |   8 ++
> >  block/throttle.c                |   6 +-
> >  blockdev.c                      |  96 +----------------
> >  fsdev/qemu-fsdev-dummy.c        |  11 ++
> >  fsdev/qemu-fsdev-throttle.c     | 144 +++++++++++++++++---------
> >  fsdev/qemu-fsdev-throttle.h     |   6 +-
> >  fsdev/qemu-fsdev.c              |  29 ++++++
> >  hmp-commands-info.hx            |  15 +++
> >  hmp-commands.hx                 |  15 +++
> >  hmp.c                           |  83 +++++++++++++--
> >  hmp.h                           |   4 +
> >  include/qemu/throttle-options.h |   3 +-
> >  include/qemu/throttle.h         |   4 +-
> >  include/qemu/typedefs.h         |   1 +
> >  monitor.c                       |  41 ++++----
> >  qapi/block-core.json            | 122 +---------------------
> >  qapi/fsdev.json                 |  96 +++++++++++++++++
> >  qapi/qapi-schema.json           |   1 +
> >  qapi/tlimits.json               |  89 ++++++++++++++++
> >  qmp.c                           |  12 +++
> >  util/throttle.c                 | 224 ++++++++++++++++++++++++++------=
--------
> >  22 files changed, 654 insertions(+), 376 deletions(-)  create mode=20
> > 100644 qapi/fsdev.json  create mode 100644 qapi/tlimits.json
> >=20
> > v0 -> v1:
> >  Addressed comments from Eric Blake and Greg Kurz.
> >  Fix patch corrupt issue due to email client change the patch format=20
> > with copy-to-paster  Break patch to patches
> >=20
> > --
> > 1.8.3.1
> >  =20
>=20
