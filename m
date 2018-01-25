Received: from eggs.gnu.org ([2001:4830:134:3::10]:38154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eehyO-00037t-Pv
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eehyL-0002Ul-OU
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:53:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1eehyL-0002Qm-JI
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:53:45 -0500
References: <20180125041411.6647-1-aik@ozlabs.ru>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9e5bf372-8321-0333-4c09-b93d98639992@redhat.com>
Date: Thu, 25 Jan 2018 14:53:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180125041411.6647-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] vfio/common: Remove redundand copy of
 local variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>

Hi,On 25/01/18 05:14, Alexey Kardashevskiy wrote:
> There is already @hostwin in vfio_listener_region_add() so there is no
> point in having the other one.
> 
> Fixes: 2e4109de "vfio/spapr: Create DMA window dynamically (SPAPR IOMMU v2)"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/common.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index b77be3a..3d652c8 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -435,7 +435,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
>      end = int128_get64(int128_sub(llend, int128_one()));
>  
>      if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
> -        VFIOHostDMAWindow *hostwin;
>          hwaddr pgsize = 0;
>  
>          /* For now intersections are not allowed, we may relax this later */
> 
