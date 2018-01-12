Received: from eggs.gnu.org ([2001:4830:134:3::10]:50436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eZoLg-0006eD-4C
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 20:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eZoLc-0000ND-7l
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 20:41:36 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2307 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eZoLb-0000EA-SC
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 20:41:32 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Fri, 12 Jan 2018 01:41:19 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB3A5E1@DGGEMM505-MBS.china.huawei.com>
References: <1515515942-33692-1-git-send-email-jianjay.zhou@huawei.com>
	<20180111140057.61f36a8f@redhat.com>
	<B2D15215269B544CADD246097EACE7473AB386CE@DGGEMM505-MBS.china.huawei.com>
	<20180111215411-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180111215411-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 0/4] vhost: two fixes and used_memslots
 refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Liuzhe (Ahriy, Euler)" <liuzhe13@huawei.com>, Jason Wang <jasowang@redhat.com>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Friday, January 12, 2018 3:56 AM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> Cc: Igor Mammedov <imammedo@redhat.com>; qemu-devel@nongnu.org; Huangweid=
ong
> (C) <weidong.huang@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>;
> Gonglei (Arei) <arei.gonglei@huawei.com>; Liuzhe (Ahriy, Euler)
> <liuzhe13@huawei.com>
> Subject: Re: [PATCH v5 0/4] vhost: two fixes and used_memslots refactorin=
g
>=20
> On Thu, Jan 11, 2018 at 01:55:38PM +0000, Zhoujian (jay) wrote:
> > Hi Igor,
> >
> > > -----Original Message-----
> > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > Sent: Thursday, January 11, 2018 9:05 PM
> > > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > > Cc: qemu-devel@nongnu.org; mst@redhat.com; Huangweidong (C)
> > > <weidong.huang@huawei.com>; wangxin (U)
> > > <wangxinxin.wang@huawei.com>; Gonglei
> > > (Arei) <arei.gonglei@huawei.com>; Liuzhe (Ahriy, Euler)
> > > <liuzhe13@huawei.com>
> > > Subject: Re: [PATCH v5 0/4] vhost: two fixes and used_memslots
> > > refactoring
> > >
> > > On Wed, 10 Jan 2018 00:39:02 +0800
> > > Jay Zhou <jianjay.zhou@huawei.com> wrote:
> > >
> > > Jay,
> > > considering how non trivial touched code is, would you mind first
> > > adding 'make check' testcases for success/failure paths that you are
> touching?
> > > It would help with merging and ensure that future changes to vhost
> > > won't break memslots handling.
> >
> > Will look into the testcases. Maybe it would take some time since I'm
> > not very familiar with them.
> >
> > Regards,
> > Jay
>=20
>=20
> ok can you repost whatever's ready please? And please use proper threadin=
g
> (e.g. generated with git format-patch --thread=3Dshallow).
>=20

Will send a v6 version soon.

PS: Considering vhost memslots series and the patch "tap: do not close fd
if only vhost failed to initialize" are two separate issues, will send
them separately.

Regards,
Jay

> > >
> > > > v4 -> v5:
> > > >   Making the followed up device_add to fall back to userspace
> > > >   virtio when netdev_add fails if vhost force flag does not set.
> > > >
> > > > Jay Zhou (4):
> > > >   vhost: remove assertion to prevent crash
> > > >   tap: do not close fd if only vhost failed to initialize
> > > >   vhost: fix memslot limit check
> > > >   vhost: used_memslots refactoring
> > > >
> > > >  hw/virtio/vhost-backend.c         | 15 +++++++-
> > > >  hw/virtio/vhost-user.c            | 74 +++++++++++++++++++++++++++=
----
> ----
> > > ----
> > > >  hw/virtio/vhost.c                 | 30 +++++++++-------
> > > >  include/hw/virtio/vhost-backend.h |  6 ++--
> > > >  net/tap.c                         | 25 +++++++++----
> > > >  5 files changed, 104 insertions(+), 46 deletions(-)
> > > >
> > > > --
> > > > 1.8.3.1
> > > >
> > > >
