Received: from eggs.gnu.org ([2001:4830:134:3::10]:50867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dVzlF-000422-NN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dVzlC-0002nx-KS
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:31:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:33443 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhocko@kernel.org>) id 1dVzlC-0002nX-DQ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:31:54 -0400
Date: Fri, 14 Jul 2017 14:31:50 +0200
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20170714123150.GB2624@dhcp22.suse.cz>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-8-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499863221-16206-8-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v12 7/8] mm: export symbol of next_zone and
 first_online_pgdat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Wed 12-07-17 20:40:20, Wei Wang wrote:
> This patch enables for_each_zone()/for_each_populated_zone() to be
> invoked by a kernel module.

This needs much better justification with an example of who is going to
use these symbols and what for.
 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  mm/mmzone.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/mmzone.c b/mm/mmzone.c
> index a51c0a6..08a2a3a 100644
> --- a/mm/mmzone.c
> +++ b/mm/mmzone.c
> @@ -13,6 +13,7 @@ struct pglist_data *first_online_pgdat(void)
>  {
>  	return NODE_DATA(first_online_node);
>  }
> +EXPORT_SYMBOL_GPL(first_online_pgdat);
>  
>  struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
>  {
> @@ -41,6 +42,7 @@ struct zone *next_zone(struct zone *zone)
>  	}
>  	return zone;
>  }
> +EXPORT_SYMBOL_GPL(next_zone);
>  
>  static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
>  {
> -- 
> 2.7.4
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

-- 
Michal Hocko
SUSE Labs
