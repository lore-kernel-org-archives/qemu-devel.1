Received: from eggs.gnu.org ([2001:4830:134:3::10]:58947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVfKB-0000kM-9L
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVfK8-0004p1-32
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:42:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVfK7-0004op-Sm
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:42:36 -0400
Date: Thu, 13 Jul 2017 16:42:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170713164210.45b2f3fc@gondolin>
In-Reply-To: <20170713110237.6712-4-lprosek@redhat.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-4-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/8] virtio: introduce virtqueue_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, stefanha@redhat.com

On Thu, 13 Jul 2017 13:02:32 +0200
Ladi Prosek <lprosek@redhat.com> wrote:

> Most virtio error output pertains to a specific virtqueue so it makes
> sense to include the queue index in error messages. This commit makes
> all error output in virtio.c use the newly introduced virtqueue_error.

Split out the change introducing virtqueue_error(), as this patch is
quite large?

> 
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/virtio/virtio.c         | 98 ++++++++++++++++++++++++++++------------------
>  include/hw/virtio/virtio.h |  1 +
>  2 files changed, 60 insertions(+), 39 deletions(-)

I like the change. Feel free to add

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
