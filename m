Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3543EC48BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 00:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0893F20883
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 00:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0893F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfw6a-0005sb-4A
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 20:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49797)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yan.y.zhao@intel.com>) id 1hfw5K-0005QJ-II
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 20:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1hfw5C-0006k4-Fu
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 20:46:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:23999)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1hfw5B-0006cD-Sc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 20:46:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Jun 2019 17:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,417,1557212400"; d="scan'208";a="360134456"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by fmsmga005.fm.intel.com with ESMTP; 25 Jun 2019 17:46:33 -0700
Date: Tue, 25 Jun 2019 20:40:39 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20190626004039.GE6971@joy-OptiPlex-7040>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-11-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561041461-22326-11-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [PATCH v4 10/13] vfio: Add function to get dirty
 page list
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
 Ziye" <ziye.yang@intel.com>, "yulei.zhang@intel.com" <yulei.zhang@intel.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 10:37:38PM +0800, Kirti Wankhede wrote:
> Dirty page tracking (.log_sync) is part of RAM copying state, where
> vendor driver provides the bitmap of pages which are dirtied by vendor
> driver through migration region and as part of RAM copy, those pages
> gets copied to file stream.
> 
> To get dirty page bitmap:
> - write start address, page_size and pfn count.
> - read count of pfns copied.
>     - Vendor driver should return 0 if driver doesn't have any page to
>       report dirty in given range.
>     - Vendor driver should return -1 to mark all pages dirty for given range.
> - read data_offset, where vendor driver has written bitmap.
> - read bitmap from the region or mmaped part of the region. This copy is
>   iterated till page bitmap for all requested pfns are copied.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c           | 119 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h |   2 +
>  2 files changed, 121 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index e4895f91761d..68775b5dec11 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -228,6 +228,125 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>      return qemu_file_get_error(f);
>  }
>  
> +void vfio_get_dirty_page_list(VFIODevice *vbasedev,
> +                              uint64_t start_pfn,
> +                              uint64_t pfn_count,
> +                              uint64_t page_size)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region.buffer;
> +    uint64_t count = 0;
> +    int64_t copied_pfns = 0;
> +    int ret;
> +
> +    qemu_mutex_lock(&migration->lock);
> +    ret = pwrite(vbasedev->fd, &start_pfn, sizeof(start_pfn),
> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                              start_pfn));
> +    if (ret < 0) {
> +        error_report("Failed to set dirty pages start address %d %s",
> +                ret, strerror(errno));
> +        goto dpl_unlock;
> +    }
> +
> +    ret = pwrite(vbasedev->fd, &page_size, sizeof(page_size),
> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                              page_size));
> +    if (ret < 0) {
> +        error_report("Failed to set dirty page size %d %s",
> +                ret, strerror(errno));
> +        goto dpl_unlock;
> +    }
> +
> +    ret = pwrite(vbasedev->fd, &pfn_count, sizeof(pfn_count),
> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                              total_pfns));
> +    if (ret < 0) {
> +        error_report("Failed to set dirty page total pfns %d %s",
> +                ret, strerror(errno));
> +        goto dpl_unlock;
> +    }
> +
> +    do {
> +        uint64_t bitmap_size, data_offset = 0;
> +        void *buf = NULL;
> +        bool buffer_mmaped = false;
> +
> +        /* Read copied dirty pfns */
> +        ret = pread(vbasedev->fd, &copied_pfns, sizeof(copied_pfns),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             copied_pfns));
> +        if (ret < 0) {
> +            error_report("Failed to get dirty pages bitmap count %d %s",
> +                    ret, strerror(errno));
> +            goto dpl_unlock;
> +        }
> +
> +        if (copied_pfns == 0) {
> +            /*
> +             * copied_pfns could be 0 if driver doesn't have any page to
> +             * report dirty in given range
> +             */
> +            break;
this copied_pfn is the dirty page count in which range?
if it is got each iteration, why break here rather than continue ?
consider there's a big region with pfn_count, and it is now breaked into
several smaller subregions, and copied_pfns is 0 in the first subregion,
it doesn't mean copied_pfns are all 0 in the remaining subregions.

> +        } else if (copied_pfns == -1) {
> +            /* Mark all pages dirty for this range */
> +            cpu_physical_memory_set_dirty_range(start_pfn * page_size,
> +                                                pfn_count * page_size,
> +                                                DIRTY_MEMORY_MIGRATION);
> +            break;
> +        }
> +
> +        bitmap_size = (BITS_TO_LONGS(copied_pfns) + 1) * sizeof(unsigned long);
> +
> +        ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             data_offset));
> +        if (ret != sizeof(data_offset)) {
> +            error_report("Failed to get migration buffer data offset %d",
> +                         ret);
> +            goto dpl_unlock;
> +        }
> +
> +        if (region->mmaps) {
> +            int i;
> +            for (i = 0; i < region->nr_mmaps; i++) {
> +                if ((region->mmaps[i].offset >= data_offset) &&
> +                    (data_offset < region->mmaps[i].offset +
> +                                   region->mmaps[i].size)) {
> +                    buf = region->mmaps[i].mmap + (data_offset -
> +                                                   region->mmaps[i].offset);
> +                    buffer_mmaped = true;
> +                    break;
> +                }
> +            }
> +        }
> +
> +        if (!buffer_mmaped) {
> +            buf = g_malloc0(bitmap_size);
> +
> +            ret = pread(vbasedev->fd, buf, bitmap_size,
> +                        region->fd_offset + data_offset);
> +            if (ret != bitmap_size) {
> +                error_report("Failed to get dirty pages bitmap %d", ret);
> +                g_free(buf);
> +                goto dpl_unlock;
> +            }
> +        }
> +
> +        cpu_physical_memory_set_dirty_lebitmap((unsigned long *)buf,
> +                                               (start_pfn + count) * page_size,
> +                                                copied_pfns);
> +        count +=  copied_pfns;
> +
here also. why it is count += copied_pfns.

> +        if (!buffer_mmaped) {
> +            g_free(buf);
> +        }
> +    } while (count < pfn_count);
> +
> +dpl_unlock:
> +    qemu_mutex_unlock(&migration->lock);
> +}
> +
>  /* ---------------------------------------------------------------------- */
>  
>  static int vfio_save_setup(QEMUFile *f, void *opaque)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 1d26e6be8d48..423d6dbccace 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -224,5 +224,7 @@ int vfio_spapr_remove_window(VFIOContainer *container,
>  
>  int vfio_migration_probe(VFIODevice *vbasedev, Error **errp);
>  void vfio_migration_finalize(VFIODevice *vbasedev);
> +void vfio_get_dirty_page_list(VFIODevice *vbasedev, uint64_t start_pfn,
> +                               uint64_t pfn_count, uint64_t page_size);
>  
>  #endif /* HW_VFIO_VFIO_COMMON_H */
> -- 
> 2.7.0
> 

