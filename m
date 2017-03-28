Received: from eggs.gnu.org ([2001:4830:134:3::10]:59608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1csxRA-0002oY-Vw
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1csxR6-0002vE-UW
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:09:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1csxR6-0002v2-PZ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:09:48 -0400
Date: Tue, 28 Mar 2017 23:09:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170328230934-mutt-send-email-mst@kernel.org>
References: <20170324231943.18768-1-Andrew.Baumann@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324231943.18768-1-Andrew.Baumann@microsoft.com>
Subject: Re: [Qemu-devel] [PATCH v3] virtio: fix vring_align() on 64-bit
 windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>

On Fri, Mar 24, 2017 at 04:19:43PM -0700, Andrew Baumann wrote:
> long is 32-bits on 64-bit windows, which caused the top half of the
> address to be truncated; this patch changes it to use the
> QEMU_ALIGN_UP macro which does not suffer the same problem
> 
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/hw/virtio/virtio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 15efcf2..7b6edba 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -34,7 +34,7 @@ struct VirtQueue;
>  static inline hwaddr vring_align(hwaddr addr,
>                                               unsigned long align)
>  {
> -    return (addr + align - 1) & ~(align - 1);
> +    return QEMU_ALIGN_UP(addr, align);
>  }
>  
>  typedef struct VirtQueue VirtQueue;
> -- 
> 2.8.3
