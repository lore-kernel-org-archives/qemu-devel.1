Received: from eggs.gnu.org ([2001:4830:134:3::10]:41645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVRoS-0005M4-EM
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVRoO-0001ju-Gk
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:17:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dVRoO-0001jJ-Ap
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:16:56 -0400
Date: Thu, 13 Jul 2017 03:16:49 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170713031526-mutt-send-email-mst@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Wed, Jul 12, 2017 at 08:40:20PM +0800, Wei Wang wrote:
> This patch enables for_each_zone()/for_each_populated_zone() to be
> invoked by a kernel module.

... for use by virtio balloon.

> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

balloon seems to only use
+       for_each_populated_zone(zone)
+               for_each_migratetype_order(order, type)


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
