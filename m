Received: from eggs.gnu.org ([2001:4830:134:3::10]:41581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRPim-0005w1-PJ
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 16:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRPiH-0007UZ-AR
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 16:46:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRPiF-0007S4-SE
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 16:46:12 -0500
Date: Tue, 19 Dec 2017 23:46:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171219234550-mutt-send-email-mst@kernel.org>
References: <1513327555-17520-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513327555-17520-1-git-send-email-jianjay.zhou@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] vhost: two fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, gary.liuzhe@huawei.com, dgilbert@redhat.com, imammedo@redhat.com

On Fri, Dec 15, 2017 at 04:45:53PM +0800, Jay Zhou wrote:
> v1 -> v2:
>   * delete the "used_memslots" global variable, and add it
>     for vhost-user and vhost-kernel separately

imammedo, any feedback on this?

> Jay Zhou (2):
>   vhost: add used memslot number for vhost-user and vhost-kernel    
>     separately
>   vhost: double check used memslots number
> 
>  hw/virtio/vhost-backend.c         | 14 ++++++++++++++
>  hw/virtio/vhost-user.c            | 31 +++++++++++++++++++++++++++++++
>  hw/virtio/vhost.c                 | 39 ++++++++++++++++++++++++++++++---------
>  include/hw/virtio/vhost-backend.h |  4 ++++
>  4 files changed, 79 insertions(+), 9 deletions(-)
> 
> -- 
> 1.8.3.1
> 
