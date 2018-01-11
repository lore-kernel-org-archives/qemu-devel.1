Received: from eggs.gnu.org ([2001:4830:134:3::10]:34765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eZcY9-0005ir-Bg
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eZcY8-0006aF-Cm
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:05:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eZcY8-0006Wp-5n
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:05:40 -0500
Date: Thu, 11 Jan 2018 14:05:20 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180111140057.61f36a8f@redhat.com>
In-Reply-To: <1515515942-33692-1-git-send-email-jianjay.zhou@huawei.com>
References: <1515515942-33692-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, liuzhe13@huawei.com

On Wed, 10 Jan 2018 00:39:02 +0800
Jay Zhou <jianjay.zhou@huawei.com> wrote:

Jay,
considering how non trivial touched code is, would you mind
first adding 'make check' testcases for success/failure paths
that you are touching?
It would help with merging and ensure that future changes to
vhost won't break memslots handling.

> v4 -> v5:
>   Making the followed up device_add to fall back to userspace
>   virtio when netdev_add fails if vhost force flag does not set.
> 
> Jay Zhou (4):
>   vhost: remove assertion to prevent crash
>   tap: do not close fd if only vhost failed to initialize
>   vhost: fix memslot limit check
>   vhost: used_memslots refactoring
> 
>  hw/virtio/vhost-backend.c         | 15 +++++++-
>  hw/virtio/vhost-user.c            | 74 +++++++++++++++++++++++++++------------
>  hw/virtio/vhost.c                 | 30 +++++++++-------
>  include/hw/virtio/vhost-backend.h |  6 ++--
>  net/tap.c                         | 25 +++++++++----
>  5 files changed, 104 insertions(+), 46 deletions(-)
> 
> --
> 1.8.3.1
> 
> 
