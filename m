Received: from eggs.gnu.org ([2001:4830:134:3::10]:46819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebWlx-0003CK-6a
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebWls-0007qf-R1
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:19:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebWls-0007qJ-DA
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:19:44 -0500
Date: Tue, 16 Jan 2018 21:19:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180116211858-mutt-send-email-mst@kernel.org>
References: <cover.1515724314.git.jianjay.zhou@huawei.com>
	<20180116064025-mutt-send-email-mst@kernel.org>
	<B2D15215269B544CADD246097EACE7473AB45B31@DGGEMM505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B2D15215269B544CADD246097EACE7473AB45B31@DGGEMM505-MBS.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/3] vhost: two fixes and used_memslots
 refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "imammedo@redhat.com" <imammedo@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Liuzhe (Ahriy, Euler)" <liuzhe13@huawei.com>

On Tue, Jan 16, 2018 at 08:17:54AM +0000, Zhoujian (jay) wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Tuesday, January 16, 2018 12:42 PM
> > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > Cc: qemu-devel@nongnu.org; imammedo@redhat.com; Huangweidong (C)
> > <weidong.huang@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>; Gonglei
> > (Arei) <arei.gonglei@huawei.com>; Liuzhe (Ahriy, Euler) <liuzhe13@huawei.com>
> > Subject: Re: [PATCH v6 0/3] vhost: two fixes and used_memslots refactoring
> > 
> > On Fri, Jan 12, 2018 at 10:47:56AM +0800, Jay Zhou wrote:
> > > Jay Zhou (3):
> > >   vhost: remove assertion to prevent crash
> > >   vhost: fix memslot limit check
> > >   vhost: used_memslots refactoring
> > 
> > This looks good to me, but needs to be rebased on top of vhost mem slot
> > management refactoring by dgilbert is merged. Pls post the rebase, and I'll
> > merge.
> 
> Hi Michael,
> I have tested but there're no conflicts, it is strange.
> 
> The patches I applied locally in sequence:
> 
> [PULL 21/33] vhost: Build temporary section list and deref after commit
> [PULL 22/33] vhost: Move log_dirty check
> [PULL 23/33] vhost: Simplify ring verification checks
> [PULL 24/33] vhost: Merge sections added to temporary list
> 
> And then,
> 
> [PATCH v6 1/3] vhost: remove assertion to prevent crash
> [PATCH v6 2/3] vhost: fix memslot limit check
> [PATCH v6 3/3] vhost: used_memslots refactoring
> 
> Could you point out which patches from Dave(or others) are conflict with mine?
> 
> Regards,
> Jay

To see the conflicts, please check out the for_upstream tag in my tree.



> > 
> > Thanks!
> > 
> > 
> > 
> > >  hw/virtio/vhost-backend.c         | 15 +++++++-
> > >  hw/virtio/vhost-user.c            | 74 +++++++++++++++++++++++++++--------
> > ----
> > >  hw/virtio/vhost.c                 | 30 +++++++++-------
> > >  include/hw/virtio/vhost-backend.h |  6 ++--
> > >  4 files changed, 86 insertions(+), 39 deletions(-)
> > >
> > > --
> > > 1.8.3.1
> > >
