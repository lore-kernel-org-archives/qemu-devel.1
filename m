Received: from eggs.gnu.org ([2001:4830:134:3::10]:52376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eNCm2-00071U-2h
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eNCly-0000Bb-TD
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:08:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:21786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eNCly-0000AB-L6
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:08:38 -0500
Date: Fri, 8 Dec 2017 14:52:06 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20171208065206.GB2392@sky-dev>
References: <20171208042654.10910-1-peterx@redhat.com>
	<20171208042654.10910-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171208042654.10910-3-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] intel_iommu: fix error param in string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Looks good.

Reviewed-by: Liu, Yi L <yi.l.liu@intel.com>

On Fri, Dec 08, 2017 at 12:26:54PM +0800, Peter Xu wrote:
> It should be caching-mode.  It may confuse people when it pops up.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c1fa08d205..fe15d3ba84 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2327,7 +2327,7 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>      IntelIOMMUNotifierNode *next_node = NULL;
>  
>      if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
> -        error_report("We need to set cache_mode=1 for intel-iommu to enable "
> +        error_report("We need to set caching-mode=1 for intel-iommu to enable "
>                       "device assignment with IOMMU protection.");
>          exit(1);
>      }
> -- 
> 2.14.3
> 
> 
