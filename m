Received: from eggs.gnu.org ([2001:4830:134:3::10]:34313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eNFZp-0005L4-GN
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eNFZm-0002Gf-B7
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:08:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eNFZm-0002FE-49
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:08:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CB4481DE4
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 10:08:13 +0000 (UTC)
Date: Fri, 8 Dec 2017 11:08:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171208110807.7239fb36.cohuck@redhat.com>
In-Reply-To: <20171207191726-musend-email-mst@kernel.org>
References: <20171207191726-musend-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] question on virtio ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, 7 Dec 2017 19:18:44 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> I see this in ccw in qemu:
> 
>             if (virtio_set_status(vdev, status) == 0) {
>                 if (vdev->status == 0) {
>                     virtio_ccw_reset_virtio(dev, vdev);
>                 }
>                 if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
>                     virtio_ccw_start_ioeventfd(dev);
>                 }
>                 sch->curr_status.scsw.count = ccw.count - sizeof(status);
>                 ret = 0;
>             } else {
>                 /* Trigger a command reject. */
>                 ret = -ENOSYS;
>             }
> 
> virtio_set_status on success sets vdev->status to status.
> Why check vdev->status in one place and status in another?
> 

Probably for symmetry with the check whether to stop ioeventfd right
above. But it does not really matter one way or the other.
