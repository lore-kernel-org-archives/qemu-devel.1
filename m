Received: from eggs.gnu.org ([2001:4830:134:3::10]:34335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6gin-0007zV-Vd
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6gin-0000dr-4u
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:41:06 -0400
Date: Mon, 23 Oct 2017 19:40:56 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171023174056.GE15029@stefanha-x1.localdomain>
References: <1508564040-120700-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508564040-120700-1-git-send-email-lizhengui@huawei.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: all I/O should be
 completed before removing throttle timers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhengui Li <lizhengui@huawei.com>
Cc: kwolf@redhat.com, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, lina.lulina@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, qemu-devel@nongnu.org, wangjie88@huawei.com, sochin.jiang@huawei.com

On Sat, Oct 21, 2017 at 01:34:00PM +0800, Zhengui Li wrote:
> From: Zhengui <lizhengui@huawei.com>
> 
> In blk_remove_bs, all I/O should be completed before removing throttle
> timers. If there has inflight I/O, removing throttle timers here will
> cause the inflight I/O never return.
> This patch add bdrv_drained_begin before throttle_timers_detach_aio_context
> to let all I/O completed before removing throttle timers.
> 
> Signed-off-by: Zhengui <lizhengui@huawei.com>
> ---
>  block/block-backend.c | 4 ++++
>  1 file changed, 4 insertions(+)

Related (but not equivalent) patch here:
https://patchwork.kernel.org/patch/9970023/

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
