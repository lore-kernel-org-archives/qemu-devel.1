Received: from eggs.gnu.org ([2001:4830:134:3::10]:56115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUUUr-0000Fd-Iv
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUUUq-0005jb-Pq
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:56:49 -0400
Date: Mon, 10 Jul 2017 16:56:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170710085636.GB8951@lemon.lan>
References: <20170710083553.6167-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170710083553.6167-1-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/1] block: fix possible return code
 clobbering in bdrv_co_pdiscard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On Mon, 07/10 11:35, Denis V. Lunev wrote:
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com> (supporter:Block I/O path)
> CC: Fam Zheng <famz@redhat.com> (supporter:Block I/O path)

Maybe use "--noroles"?  The parenthesis part is not really useful.

> ---
>  block/io.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/io.c b/block/io.c
> index ed31810c0a..e5c6dc77d3 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2464,7 +2464,6 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
>      assert(max_pdiscard >= bs->bl.request_alignment);
>  
>      while (count > 0) {
> -        int ret;
>          int num = count;
>  
>          if (head) {
> -- 
> 2.11.0
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
