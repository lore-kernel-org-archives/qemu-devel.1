Received: from eggs.gnu.org ([2001:4830:134:3::10]:36797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePZVb-0002cn-Dw
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePZVX-00057U-FJ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:49:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePZVX-00056H-9E
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:49:27 -0500
Date: Thu, 14 Dec 2017 19:49:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171214194920.GH4380@work-vm>
References: <1513269392-23224-1-git-send-email-jianjay.zhou@huawei.com>
	<20171214202619-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171214202619-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 0/2] vhost: two fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jay Zhou <jianjay.zhou@huawei.com>, qemu-devel@nongnu.org, weidong.huang@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, gary.liuzhe@huawei.com, Igor Mammedov <imammedo@redhat.com>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Fri, Dec 15, 2017 at 12:36:30AM +0800, Jay Zhou wrote:
> > Jay Zhou (2):
> >   vhost: add used memslot number for vhost-user
> >   vhost: double check memslot number
> > 
> >  hw/virtio/vhost-user.c            | 31 +++++++++++++++++++++++++
> >  hw/virtio/vhost.c                 | 49 ++++++++++++++++++++++++++++++++++-----
> >  include/hw/virtio/vhost-backend.h |  4 ++++
> >  3 files changed, 78 insertions(+), 6 deletions(-)
> 
> Cc two developers working on these files right now.

I have to admit to not understanding the 'used_memslots' variable.

* It's a global in vhost.c
* but set by vhost_set_memory that's called from the listener associated
  with each individual vhost
* While they're probably always the same, the merging code calls
  the vhost_backend_can_merge method for each device, so the number
  of regions can be different.

Dave

> > -- 
> > 1.8.3.1
> > 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
