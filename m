Received: from eggs.gnu.org ([2001:4830:134:3::10]:43969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1euBIn-0004OO-Gg
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 01:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1euBIk-0000b4-Bj
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 01:14:49 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1euBIk-0000ae-5R
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 01:14:46 -0500
References: <20180306113442.15295-1-kraxel@redhat.com>
	<20180306113442.15295-7-kraxel@redhat.com>
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <6f91e389-33af-0a56-b39b-1e41ed69959f@nvidia.com>
Date: Fri, 9 Mar 2018 11:44:25 +0530
MIME-Version: 1.0
In-Reply-To: <20180306113442.15295-7-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 6/9] vfio/common: cleanup in
 vfio_region_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: intel-gvt-dev@lists.freedesktop.org, Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>


Looks good.

Reviewed by: Kirti Wankhede <kwankhede@nvidia.com>

Thanks,
Kirti

On 3/6/2018 5:04 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/vfio/common.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f895e3c335..6a8203a532 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -858,6 +858,13 @@ void vfio_region_finalize(VFIORegion *region)
>      g_free(region->mmaps);
>  
>      trace_vfio_region_finalize(region->vbasedev->name, region->nr);
> +
> +    region->mem = NULL;
> +    region->mmaps = NULL;
> +    region->nr_mmaps = 0;
> +    region->size = 0;
> +    region->flags = 0;
> +    region->nr = 0;
>  }
>  
>  void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
> 
