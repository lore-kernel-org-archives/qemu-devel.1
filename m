Received: from eggs.gnu.org ([2001:4830:134:3::10]:45108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gJs2y-0003Gq-4k
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 22:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gJrq3-0005gr-7S
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 22:15:40 -0500
References: <20181105181353.39804-1-mst@redhat.com>
	<20181105181353.39804-6-mst@redhat.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <be0ef180-67f2-4a5b-03fd-c9cc1e3058f0@oracle.com>
Date: Tue, 6 Nov 2018 11:17:03 +0800
MIME-Version: 1.0
In-Reply-To: <20181105181353.39804-6-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 05/33] virtio-blk: fix comment for
 virtio_blk_rw_complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 11/06/2018 02:15 AM, Michael S. Tsirkin wrote:
> From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> 
> Here should be submit_requests, there is no submit_merged_requests
> function.
> 
> Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/block/virtio-blk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 225fe44b7a..83cf5c01f9 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -97,8 +97,8 @@ static void virtio_blk_rw_complete(void *opaque, int ret)
>  
>          if (req->qiov.nalloc != -1) {
>              /* If nalloc is != 1 req->qiov is a local copy of the original

Should it be "If nalloc is != -1" in the comment? Seems the initial state is -1.

> -             * external iovec. It was allocated in submit_merged_requests
> -             * to be able to merge requests. */
> +             * external iovec. It was allocated in submit_requests to be
> +             * able to merge requests. */
>              qemu_iovec_destroy(&req->qiov);
>          }
>  
> 

Dongli Zhang
