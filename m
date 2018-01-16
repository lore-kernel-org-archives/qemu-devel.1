Received: from eggs.gnu.org ([2001:4830:134:3::10]:46211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJ45-0004pa-Dt
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:41:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJ42-0002DW-BY
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:41:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebJ42-0002DN-53
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:41:34 -0500
Date: Tue, 16 Jan 2018 06:41:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180116064025-mutt-send-email-mst@kernel.org>
References: <cover.1515724314.git.jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1515724314.git.jianjay.zhou@huawei.com>
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
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, liuzhe13@huawei.com

On Fri, Jan 12, 2018 at 10:47:56AM +0800, Jay Zhou wrote:
> Jay Zhou (3):
>   vhost: remove assertion to prevent crash
>   vhost: fix memslot limit check
>   vhost: used_memslots refactoring

This looks good to me, but needs to be rebased on top
of vhost mem slot management refactoring by dgilbert is
merged. Pls post the rebase, and I'll merge.

Thanks!



>  hw/virtio/vhost-backend.c         | 15 +++++++-
>  hw/virtio/vhost-user.c            | 74 +++++++++++++++++++++++++++------------
>  hw/virtio/vhost.c                 | 30 +++++++++-------
>  include/hw/virtio/vhost-backend.h |  6 ++--
>  4 files changed, 86 insertions(+), 39 deletions(-)
> 
> --
> 1.8.3.1
> 
