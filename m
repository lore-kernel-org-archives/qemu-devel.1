Received: from eggs.gnu.org ([2001:4830:134:3::10]:46703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ePYE0-00012n-0Q
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ePYDx-00040Y-Aq
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:27:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ePYDx-00040G-51
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:27:13 -0500
Date: Thu, 14 Dec 2017 20:27:07 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171214202619-mutt-send-email-mst@kernel.org>
References: <1513269392-23224-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513269392-23224-1-git-send-email-jianjay.zhou@huawei.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] vhost: two fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, gary.liuzhe@huawei.com, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>

On Fri, Dec 15, 2017 at 12:36:30AM +0800, Jay Zhou wrote:
> Jay Zhou (2):
>   vhost: add used memslot number for vhost-user
>   vhost: double check memslot number
> 
>  hw/virtio/vhost-user.c            | 31 +++++++++++++++++++++++++
>  hw/virtio/vhost.c                 | 49 ++++++++++++++++++++++++++++++++++-----
>  include/hw/virtio/vhost-backend.h |  4 ++++
>  3 files changed, 78 insertions(+), 6 deletions(-)

Cc two developers working on these files right now.

> -- 
> 1.8.3.1
> 
