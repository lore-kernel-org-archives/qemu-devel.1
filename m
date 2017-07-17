Received: from eggs.gnu.org ([2001:4830:134:3::10]:34291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dX4YZ-0001M5-AD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dX4YW-0002SH-8s
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:51:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dX4YW-0002PZ-2S
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:51:16 -0400
Date: Mon, 17 Jul 2017 13:51:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170717135107.62ab0bd8@gondolin>
In-Reply-To: <20170717081152.17153-2-lprosek@redhat.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
	<20170717081152.17153-2-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/9] virtio: enhance virtio_error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

On Mon, 17 Jul 2017 10:11:44 +0200
Ladi Prosek <lprosek@redhat.com> wrote:

> Output like "Virtqueue size exceeded" is not much useful in identifying the

s/much/very/

> culprit. This commit adds virtio device name (e.g. "virtio-input") and id
> if set (e.g. "mouse0") to all virtio error messages to improve debuggability.
> 
> Some virtio devices (virtio-scsi, virtio-serial) insert a bus between the
> proxy object and the virtio backends, so a helper function is added to walk
> the object hierarchy and find the right proxy object to extract the id from.
> 
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/virtio/virtio.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
