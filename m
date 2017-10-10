Received: from eggs.gnu.org ([2001:4830:134:3::10]:54138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1rY9-00079Q-NC
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1rY4-0001c3-IN
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:14:09 -0400
Date: Tue, 10 Oct 2017 18:13:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171010101354.GE20686@pxdev.xzpeter.org>
References: <20171010094247.10173-1-maxime.coquelin@redhat.com>
	<20171010094247.10173-4-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171010094247.10173-4-maxime.coquelin@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] memory: fix off-by-one error in
 memory_region_notify_one()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Tue, Oct 10, 2017 at 11:42:47AM +0200, Maxime Coquelin wrote:
> This patch fixes an off-by-one error that could lead to the
> notifyee to receive notifications for ranges it is not
> registered to.
> 
> The bug has been spotted by code review.
> 
> Fixes: bd2bfa4c52e5 ("memory: introduce memory_region_notify_one()")
> Cc: qemu-stable@nongnu.org
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks for fixing it!

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/memory.c b/memory.c
> index 5e6351a6c1..b637c12bad 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1892,7 +1892,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>       * Skip the notification if the notification does not overlap
>       * with registered range.
>       */
> -    if (notifier->start > entry->iova + entry->addr_mask + 1 ||
> +    if (notifier->start > entry->iova + entry->addr_mask ||
>          notifier->end < entry->iova) {
>          return;
>      }
> -- 
> 2.13.6
> 

-- 
Peter Xu
