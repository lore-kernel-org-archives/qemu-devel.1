Received: from eggs.gnu.org ([209.51.188.92]:50194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomjz-0007jC-F8
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomjy-00076W-Ly
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:05:07 -0500
References: <20190130095231.42081-1-sgarzare@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <367f74db-6341-df75-fc99-1b5326bfba78@redhat.com>
Date: Wed, 30 Jan 2019 11:04:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190130095231.42081-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: remove duplicate definition of
 VirtIOBlock *s pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 2019-01-30 10:52, Stefano Garzarella wrote:
> VirtIOBlock *s is already defined and initialized with req->dev
> on top of virtio_blk_handle_request(), so we can remove it from
> the code block of VIRTIO_BLK_T_GET_ID case.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  hw/block/virtio-blk.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index f208c6ddb9..9a87b3bfac 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -569,8 +569,6 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
>          break;
>      case VIRTIO_BLK_T_GET_ID:
>      {
> -        VirtIOBlock *s = req->dev;
> -
>          /*
>           * NB: per existing s/n string convention the string is
>           * terminated by '\0' only when shorter than buffer.
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
