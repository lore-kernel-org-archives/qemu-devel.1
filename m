Received: from eggs.gnu.org ([2001:4830:134:3::10]:53188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1fkAKp-0003M8-CJ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1fkAKo-0007uN-H3
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:43:47 -0400
Date: Mon, 30 Jul 2018 23:43:23 +0800
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Message-ID: <20180730154323.GA6933@byw>
Reply-To: baiyaowei@cmss.chinamobile.com
References: <1532755124-23795-1-git-send-email-baiyaowei@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532755124-23795-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: fix comment for
 virtio_blk_rw_complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, mst@redhat.com, kwolf@redhat.com, mreitz@redhat.com, mjt@tls.msk.ru, laurent@vivier.eu
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Oh, sorry, this patch should go into trivial mail list.

On Sat, Jul 28, 2018 at 01:18:44PM +0800, Yaowei Bai wrote:
> Here should be submit_requests, there is no submit_merged_requests
> function.
> 
> Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> ---
>  hw/block/virtio-blk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 50b5c86..91cbede 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -97,8 +97,8 @@ static void virtio_blk_rw_complete(void *opaque, int ret)
>  
>          if (req->qiov.nalloc != -1) {
>              /* If nalloc is != 1 req->qiov is a local copy of the original
> -             * external iovec. It was allocated in submit_merged_requests
> -             * to be able to merge requests. */
> +             * external iovec. It was allocated in submit_requests to be
> +             * able to merge requests. */
>              qemu_iovec_destroy(&req->qiov);
>          }
>  
> -- 
> 1.8.3.1
> 
