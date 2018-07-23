Received: from eggs.gnu.org ([2001:4830:134:3::10]:46468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhRba-00071D-G8
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 23:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhRbP-0000Sv-Rq
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 23:33:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43632 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fhRbP-0000Rp-Hp
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 23:33:39 -0400
Date: Mon, 23 Jul 2018 11:33:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180723033329.GB2491@xz-mi>
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-3-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719121520.30026-3-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] migration: fix counting normal page
 for compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Thu, Jul 19, 2018 at 08:15:14PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> The compressed page is not normal page
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

I think it'll depend on how we are defining the "normal" page.  AFAIU
it's the count of raw pages, then I think it's correct.

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/ram.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 0ad234c692..1b016e048d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1903,7 +1903,6 @@ retry:
>              qemu_cond_signal(&comp_param[idx].cond);
>              qemu_mutex_unlock(&comp_param[idx].mutex);
>              pages = 1;
> -            ram_counters.normal++;
>              ram_counters.transferred += bytes_xmit;
>              break;
>          }
> -- 
> 2.14.4
> 

Regards,

-- 
Peter Xu
