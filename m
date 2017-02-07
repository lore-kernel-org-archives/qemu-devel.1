Received: from eggs.gnu.org ([2001:4830:134:3::10]:58482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cb67y-0004SJ-UN
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cb67y-0005EY-28
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:48:14 -0500
References: <20170207132723.13934-1-famz@redhat.com>
	<20170207132723.13934-2-famz@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <292513df-2560-a5bc-87e3-97d6d797ef8d@redhat.com>
Date: Tue, 7 Feb 2017 14:48:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170207132723.13934-2-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-blk: Remove useless condition
 around g_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On 02/07/17 14:27, Fam Zheng wrote:
> Laszlo spotted and studied this wasteful "if". He pointed out:
> 
> The original virtio_blk_free_request needed an "if" as it accesses one
> field, since 671ec3f05655 ("virtio-blk: Convert VirtIOBlockReq.elem to
> pointer", 2014-06-11); later on in f897bf751fbd ("virtio-blk: embed
> VirtQueueElement in VirtIOBlockReq", 2014-07-09) the field became
> embedded, so the "if" became unnecessary (at which point we were using
> g_slice_free(), but it is the same.
> 
> Now drop it.
> 
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/block/virtio-blk.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 702eda8..2858c31 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -42,9 +42,7 @@ static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
>  
>  static void virtio_blk_free_request(VirtIOBlockReq *req)
>  {
> -    if (req) {
> -        g_free(req);
> -    }
> +    g_free(req);
>  }
>  
>  static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
