Received: from eggs.gnu.org ([2001:4830:134:3::10]:37489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dX4hV-0004SO-Rh
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dX4hS-0002WJ-RO
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:00:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dX4hS-0002V9-Lc
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:00:30 -0400
Date: Mon, 17 Jul 2017 13:59:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170717135954.3afd6409@gondolin>
In-Reply-To: <20170717081152.17153-9-lprosek@redhat.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
	<20170717081152.17153-9-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 8/9] virtio-crypto: use virtqueue_error
 for errors with queue context
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

On Mon, 17 Jul 2017 10:11:51 +0200
Ladi Prosek <lprosek@redhat.com> wrote:

> virtqueue_error includes the queue index in the error output and is preferred
> for errors that pertain to a virtqueue rather than to the device as a whole.
> 
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/virtio/virtio-crypto.c | 49 ++++++++++++++++++++++++-----------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
