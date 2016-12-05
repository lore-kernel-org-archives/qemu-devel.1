Received: from eggs.gnu.org ([2001:4830:134:3::10]:56116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cE2eK-00013O-AG
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:26:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cE2eF-0003ig-Pm
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:26:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cE2eF-0003iE-KB
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:26:15 -0500
Date: Mon, 5 Dec 2016 16:26:13 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20161205162613.693a7c52@t450s.home>
In-Reply-To: <1480972100-846-1-git-send-email-kwankhede@nvidia.com>
References: <1480972100-846-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] vfio iommu type1: WARN_ON if notifier
 block is not unregistered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: pbonzini@redhat.com, kraxel@redhat.com, cjia@nvidia.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 6 Dec 2016 02:38:20 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> mdev vendor driver should unregister the iommu notifier since the vfio
> iommu can persist beyond the attachment of the mdev group. WARN_ON will
> show warning if vendor driver doesn't unregister the notifier and is
> forced to follow the implementations steps.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Signed-off-by: Neo Jia <cjia@nvidia.com>
> Change-Id: I75fd0a40e582a144fe7a037c7140d3513e8ff030
> ---
>  drivers/vfio/vfio_iommu_type1.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 023fba7b8d5a..37871ee0c0c5 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1361,6 +1361,8 @@ static void vfio_sanity_check_pfn_list(struct vfio_iommu *iommu)
>  		if (WARN_ON(!RB_EMPTY_ROOT(&dma->pfn_list)))
>  			break;
>  	}
> +	/* mdev venfor driver must unregister notifier */

s/venfor/vendor/

> +	WARN_ON(iommu->notifier.head);
>  }
>  
>  static void vfio_iommu_type1_detach_group(void *iommu_data,

Applied for v4.10 with the above typo fix.  Thanks,

Alex
