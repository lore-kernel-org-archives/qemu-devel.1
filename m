Received: from eggs.gnu.org ([2001:4830:134:3::10]:38848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQUs3-0007Y6-3n
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQUs2-0004Lr-8V
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:32:15 -0400
Date: Thu, 29 Jun 2017 16:32:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170629083200.GA19976@lemon.lan>
References: <20170628184724.21378-1-stefanha@redhat.com>
	<20170628184724.21378-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170628184724.21378-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] libqos: fix typo in virtio.h
 QVirtQueue->used comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 06/28 19:47, Stefan Hajnoczi wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/libqos/virtio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
> index 3397a08..829de5e 100644
> --- a/tests/libqos/virtio.h
> +++ b/tests/libqos/virtio.h
> @@ -26,7 +26,7 @@ typedef struct QVirtioDevice {
>  typedef struct QVirtQueue {
>      uint64_t desc; /* This points to an array of struct vring_desc */
>      uint64_t avail; /* This points to a struct vring_avail */
> -    uint64_t used; /* This points to a struct vring_desc */
> +    uint64_t used; /* This points to a struct vring_used */
>      uint16_t index;
>      uint32_t size;
>      uint32_t free_head;
> -- 
> 2.9.4
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
