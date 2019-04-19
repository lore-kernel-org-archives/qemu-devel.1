Received: from eggs.gnu.org ([209.51.188.92]:46723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hHco4-0002VR-0a
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hHco3-0004hU-3g
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:20:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hHco2-0004gH-UV
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:20:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id v20so6818710qtv.12
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 16:20:26 -0700 (PDT)
Date: Fri, 19 Apr 2019 19:20:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190419191910-mutt-send-email-mst@kernel.org>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411110157.14252-3-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411110157.14252-3-yuval.shaia@oracle.com>
Subject: Re: [Qemu-devel] [RFC 2/3] hw/virtio-rdma: VirtIO rdma device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, cohuck@redhat.com, marcel.apfelbaum@gmail.com, linux-rdma@vger.kernel.org, jgg@mellanox.com

On Thu, Apr 11, 2019 at 02:01:56PM +0300, Yuval Shaia wrote:
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> index 6d5c3b2d4f..bd2c699450 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -43,5 +43,6 @@
>  #define VIRTIO_ID_INPUT        18 /* virtio input */
>  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> +#define VIRTIO_ID_RDMA         26 /* virtio crypto */
>  
>  #endif /* _LINUX_VIRTIO_IDS_H */


Please reserve an ID with the virtio TC.
Process:
- create a github issue
- post patch with Fixes: tag
- wait a bit
- if no comments on either ask for a vote

> -- 
> 2.20.1
