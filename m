Received: from eggs.gnu.org ([2001:4830:134:3::10]:40331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePftp-000078-Id
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 21:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePftm-00006Y-E3
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 21:38:57 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:4438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePftl-0008VW-RF
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 21:38:54 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Fri, 15 Dec 2017 02:38:35 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB03F26@DGGEMM505-MBS.china.huawei.com>
References: <1513269392-23224-1-git-send-email-jianjay.zhou@huawei.com>
	<20171214202619-mutt-send-email-mst@kernel.org>
	<20171214194920.GH4380@work-vm>
In-Reply-To: <20171214194920.GH4380@work-vm>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/2] vhost: two fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Liuzhe (Cloud Open Labs, NFV)" <gary.liuzhe@huawei.com>, Igor Mammedov <imammedo@redhat.com>

Hi Dave,

> -----Original Message-----
> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> Sent: Friday, December 15, 2017 3:49 AM
> To: Michael S. Tsirkin <mst@redhat.com>
> Cc: Zhoujian (jay) <jianjay.zhou@huawei.com>; qemu-devel@nongnu.org;
> Huangweidong (C) <weidong.huang@huawei.com>; Gonglei (Arei)
> <arei.gonglei@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>;
> Liuzhe (Cloud Open Labs, NFV) <gary.liuzhe@huawei.com>; Igor Mammedov
> <imammedo@redhat.com>
> Subject: Re: [PATCH 0/2] vhost: two fixes
>=20
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Fri, Dec 15, 2017 at 12:36:30AM +0800, Jay Zhou wrote:
> > > Jay Zhou (2):
> > >   vhost: add used memslot number for vhost-user
> > >   vhost: double check memslot number
> > >
> > >  hw/virtio/vhost-user.c            | 31 +++++++++++++++++++++++++
> > >  hw/virtio/vhost.c                 | 49
> ++++++++++++++++++++++++++++++++++-----
> > >  include/hw/virtio/vhost-backend.h |  4 ++++
> > >  3 files changed, 78 insertions(+), 6 deletions(-)
> >
> > Cc two developers working on these files right now.
>=20
> I have to admit to not understanding the 'used_memslots' variable.
>=20
> * It's a global in vhost.c
> * but set by vhost_set_memory that's called from the listener associated
>   with each individual vhost
> * While they're probably always the same, the merging code calls
>   the vhost_backend_can_merge method for each device, so the number
>   of regions can be different.
>=20

Your mean for some devices the new added MemoryRegionSection can be merged,
but for others it can not be merged? IIUC the vhost_mem for each vhost_dev
is the same.

Meanwhile, I think it is more reasonable to add globals in vhost-backend.c
and vhost-user.c respectively instead of 'used_memslots'. The reason
is explained in patch 1. What do you think?

Regards,
Jay
