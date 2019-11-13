Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8755FC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 04:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB022245A
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 04:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB022245A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUkLL-0003Vw-Gk
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 23:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1iUkKW-00034Y-IG
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 23:32:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1iUkKU-0005xf-D7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 23:32:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:58308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1iUkKU-0005vF-4x
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 23:32:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Nov 2019 20:32:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,299,1569308400"; d="scan'208";a="207336862"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by orsmga003.jf.intel.com with ESMTP; 12 Nov 2019 20:32:21 -0800
Date: Tue, 12 Nov 2019 23:24:19 -0500
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 QEMU 14/15] vfio: Add ioctl to get dirty pages bitmap
 during dma unmap.
Message-ID: <20191113042419.GC18001@joy-OptiPlex-7040>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
 <1573578324-8389-15-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573578324-8389-15-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 13, 2019 at 01:05:23AM +0800, Kirti Wankhede wrote:
> With vIOMMU, IO virtual address range can get unmapped while in pre-copy phase
> of migration. In that case, unmap ioctl should return pages pinned in that range
> and QEMU should find its correcponding guest physical addresses and report
> those dirty.
> 
> Note: This patch is not yet tested. I'm trying to see how I can test this code
> path.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/common.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 66f1c64bf074..dc5768219d44 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -311,11 +311,30 @@ static bool vfio_devices_are_stopped_and_saving(void)
>      return true;
>  }
>  
> +static bool vfio_devices_are_running_and_saving(void)
> +{
> +    VFIOGroup *group;
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if ((vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) &&
> +                (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING)) {
> +                continue;
> +            } else {
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
>  /*
>   * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
>   */
>  static int vfio_dma_unmap(VFIOContainer *container,
> -                          hwaddr iova, ram_addr_t size)
> +                          hwaddr iova, ram_addr_t size,
> +                          VFIOGuestIOMMU *giommu)
>  {
>      struct vfio_iommu_type1_dma_unmap unmap = {
>          .argsz = sizeof(unmap),
> @@ -324,6 +343,44 @@ static int vfio_dma_unmap(VFIOContainer *container,
>          .size = size,
>      };
>  
> +    if (giommu && vfio_devices_are_running_and_saving()) {
> +        int ret;
> +        uint64_t bitmap_size;
> +        struct vfio_iommu_type1_dma_unmap_bitmap unmap_bitmap = {
> +            .argsz = sizeof(unmap_bitmap),
> +            .flags = VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP,
> +            .iova = iova,
> +            .size = size,
> +        };
> +
> +        bitmap_size = BITS_TO_LONGS(size >> TARGET_PAGE_BITS) *
> +                      sizeof(uint64_t);
> +
> +        unmap_bitmap.bitmap = g_try_malloc0(bitmap_size);
> +        if (!unmap_bitmap.bitmap) {
> +            error_report("%s: Error allocating bitmap buffer of size 0x%lx",
> +                         __func__, bitmap_size);
> +            return -ENOMEM;
> +        }
> +
> +        unmap_bitmap.bitmap_size = bitmap_size;
> +
> +        ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA_GET_BITMAP,
> +                    &unmap_bitmap);

Once reaching vfio_dma_unmap, the IOVAs being unmapped will be failed to
get translated in viommu for shadow page tables are updated already. so
except for iotlbs have been generated and iotlb inalidation is delayed until
after unmap notification, IOVA to GPA translation would fail.
> +
> +        if (!ret) {
> +            cpu_physical_memory_set_dirty_lebitmap(
> +                                        (uint64_t *)unmap_bitmap.bitmap,
> +                                        giommu->iommu_offset + giommu->n.start,
> +                                        bitmap_size >> TARGET_PAGE_BITS);
also, why here IOVAs can be used directly?

Thanks
Yan
> +        } else {
> +            error_report("VFIO_IOMMU_GET_DIRTY_BITMAP: %d %d", ret, errno);
> +        }
> +
> +        g_free(unmap_bitmap.bitmap);
> +        return ret;
> +    }
> +
>      while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>          /*
>           * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
> @@ -371,7 +428,7 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>       * the VGA ROM space.
>       */
>      if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
> -        (errno == EBUSY && vfio_dma_unmap(container, iova, size) == 0 &&
> +        (errno == EBUSY && vfio_dma_unmap(container, iova, size, NULL) == 0 &&
>           ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
>          return 0;
>      }
> @@ -511,7 +568,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>                           iotlb->addr_mask + 1, vaddr, ret);
>          }
>      } else {
> -        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1);
> +        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1, giommu);
>          if (ret) {
>              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                           "0x%"HWADDR_PRIx") = %d (%m)",
> @@ -814,7 +871,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      }
>  
>      if (try_unmap) {
> -        ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
> +        ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
>          if (ret) {
>              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                           "0x%"HWADDR_PRIx") = %d (%m)",
> -- 
> 2.7.0
> 

