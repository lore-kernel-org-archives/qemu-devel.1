Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5437C17440
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5AC222D4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5AC222D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUhtG-0008E7-Ki
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 20:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1iUhsH-0007do-U7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 20:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1iUhsF-0007pv-I0
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 20:55:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:26878)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1iUhsF-0007mD-8U
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 20:55:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Nov 2019 17:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,298,1569308400"; d="scan'208";a="355336868"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by orsmga004.jf.intel.com with ESMTP; 12 Nov 2019 17:54:58 -0800
Date: Tue, 12 Nov 2019 20:46:56 -0500
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 QEMU 13/15] vfio: Add vfio_listener_log_sync to mark
 dirty pages
Message-ID: <20191113014656.GA18001@joy-OptiPlex-7040>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
 <1573578324-8389-14-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573578324-8389-14-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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

On Wed, Nov 13, 2019 at 01:05:22AM +0800, Kirti Wankhede wrote:
> vfio_listener_log_sync gets list of dirty pages from container using
> VFIO_IOMMU_GET_DIRTY_BITMAP ioctl and mark those pages dirty when all
> devices are stopped and saving state.
> Return early for the RAM block section of mapped MMIO region.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/common.c     | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events |   1 +
>  2 files changed, 104 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index ade9839c28a3..66f1c64bf074 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -29,6 +29,7 @@
>  #include "hw/vfio/vfio.h"
>  #include "exec/address-spaces.h"
>  #include "exec/memory.h"
> +#include "exec/ram_addr.h"
>  #include "hw/hw.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> @@ -38,6 +39,7 @@
>  #include "sysemu/reset.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> +#include "migration/migration.h"
>  
>  VFIOGroupList vfio_group_list =
>      QLIST_HEAD_INITIALIZER(vfio_group_list);
> @@ -288,6 +290,28 @@ const MemoryRegionOps vfio_region_ops = {
>  };
>  
>  /*
> + * Device state interfaces
> + */
> +
> +static bool vfio_devices_are_stopped_and_saving(void)
> +{
> +    VFIOGroup *group;
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if ((vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) &&
> +                !(vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING)) {
> +                continue;
> +            } else {
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
> +/*
>   * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
>   */
>  static int vfio_dma_unmap(VFIOContainer *container,
> @@ -813,9 +837,88 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      }
>  }
>  
> +static int vfio_get_dirty_bitmap(VFIOContainer *container,
> +                                 MemoryRegionSection *section)
> +{
> +    struct vfio_iommu_type1_dirty_bitmap range;
> +    uint64_t bitmap_size;
> +    int ret;
> +
> +    range.argsz = sizeof(range);
> +
> +    if (memory_region_is_iommu(section->mr)) {
> +        VFIOGuestIOMMU *giommu;
> +        IOMMUTLBEntry iotlb;
> +
> +        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> +            if (MEMORY_REGION(giommu->iommu) == section->mr &&
> +                giommu->n.start == section->offset_within_region) {
> +                break;
> +            }
> +        }
> +
> +        if (!giommu) {
> +            return -EINVAL;
> +        }
> +
> +        iotlb = address_space_get_iotlb_entry(container->space->as,
> +                       TARGET_PAGE_ALIGN(section->offset_within_address_space),
> +                       true, MEMTXATTRS_UNSPECIFIED);
> +        range.iova = iotlb.iova + giommu->iommu_offset;
> +        range.size = iotlb.addr_mask + 1;
> +    } else {
> +        range.iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
> +        range.size = int128_get64(section->size);
> +    }
> +
> +    bitmap_size = BITS_TO_LONGS(range.size >> TARGET_PAGE_BITS) *
> +                                                             sizeof(uint64_t);
> +
> +    range.bitmap = g_try_malloc0(bitmap_size);
> +    if (!range.bitmap) {
> +        error_report("%s: Error allocating bitmap buffer of size 0x%lx",
> +                     __func__, bitmap_size);
> +        return -ENOMEM;
> +    }
> +
> +    range.bitmap_size = bitmap_size;
> +
> +    ret = ioctl(container->fd, VFIO_IOMMU_GET_DIRTY_BITMAP, &range);
> +
From the implementation of ioctl VFIO_IOMMU_GET_DIRTY_BITMAP,
this range.bitmap is indexed by iova, right?
so if viommu is on, why cpu_physical_memory_set_dirty_lebitmap can be 
called directly here without any viommu translation?

> +    if (!ret) {
> +        cpu_physical_memory_set_dirty_lebitmap((uint64_t *)range.bitmap,
> +                       TARGET_PAGE_ALIGN(section->offset_within_address_space),
> +                       bitmap_size >> TARGET_PAGE_BITS);
> +    } else {
> +        error_report("VFIO_IOMMU_GET_DIRTY_BITMAP: %d %d", ret, errno);
> +    }
> +
> +    trace_vfio_get_dirty_bitmap(container->fd, range.iova, range.size,
> +                                bitmap_size);
> +
> +    g_free(range.bitmap);
> +    return ret;
> +}
> +
> +static void vfio_listerner_log_sync(MemoryListener *listener,
> +        MemoryRegionSection *section)
> +{
> +    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
> +
> +    if (memory_region_is_ram_device(section->mr)) {
> +        return;
> +    }
> +
how about for those devices who need to sync dirty bitmap in RUNNING and
SAVING state?
> +    if (vfio_devices_are_stopped_and_saving()) {
> +
> +        vfio_get_dirty_bitmap(container, section);
> +    }
> +}
> +
when viommu is on, the address space registered for this MemoryListener
is from VTDAddressSpace,
in this address space, listener->log_sync(listener, &mrs) would not be
called for lacking of dirty_log_mask.

If listener->log_sync still needs to be called, some special handlings
are required.

>  static const MemoryListener vfio_memory_listener = {
>      .region_add = vfio_listener_region_add,
>      .region_del = vfio_listener_region_del,
> +    .log_sync = vfio_listerner_log_sync,
>  };
>  
Thanks
Yan

>  static void vfio_listener_release(VFIOContainer *container)
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ac065b559f4e..0dd1f2ffe648 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -160,3 +160,4 @@ vfio_save_complete_precopy(char *name) " (%s)"
>  vfio_load_device_config_state(char *name) " (%s)"
>  vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
>  vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
> +vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64
> -- 
> 2.7.0
> 

