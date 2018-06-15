Received: from eggs.gnu.org ([2001:4830:134:3::10]:47215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTmwZ-0004gf-EO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTmwV-0002kL-Sx
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:31:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTmwV-0002jz-OO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:30:59 -0400
Date: Fri, 15 Jun 2018 12:30:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180615113054.GD13796@work-vm>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-4-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604095520.8563-4-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 03/12] migration: fix counting xbzrle
 cache_miss_rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

* guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Sync up xbzrle_cache_miss_prev only after migration iteration goes
> forward
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

This patch (not the whole set) queued

> ---
>  migration/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index dbf24d8c87..dd1283dd45 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1189,9 +1189,9 @@ static void migration_bitmap_sync(RAMState *rs)
>                     (double)(xbzrle_counters.cache_miss -
>                              rs->xbzrle_cache_miss_prev) /
>                     (rs->iterations - rs->iterations_prev);
> +                rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
>              }
>              rs->iterations_prev = rs->iterations;
> -            rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
>          }
>  
>          /* reset period counters */
> -- 
> 2.14.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
