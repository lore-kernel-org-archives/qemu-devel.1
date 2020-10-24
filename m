Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0B8C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 12:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA82F2225F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 12:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA82F2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWIH6-0005BY-TN
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 08:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kWICz-0001o1-VD
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 07:59:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:17846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kWICx-0004kt-HL
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 07:59:41 -0400
IronPort-SDR: BmTcd3CfNjR5lokARVa6x8gOKsr9X9FGKZphN5xTHhQJW6LZ7IqqvpY2Y+AEA7sZLHjNcbJM9O
 3X12CZKWVAVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9783"; a="167892047"
X-IronPort-AV: E=Sophos;i="5.77,412,1596524400"; d="scan'208";a="167892047"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2020 04:59:38 -0700
IronPort-SDR: geuU1WV8J38+QMbK5clPE2mauoTs5YjS1PrFP7vGoLkaCS6JtNKNes/rpXq5q3wvBM5ca1rUQt
 gpLkU1iLmH5w==
X-IronPort-AV: E=Sophos;i="5.77,412,1596524400"; d="scan'208";a="534740985"
Received: from joy-optiplex-7040.sh.intel.com (HELO yzhao56-desk)
 ([10.239.13.16])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2020 04:59:31 -0700
Date: Sat, 24 Oct 2020 19:58:13 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v28 09/17] vfio: Add load state functions to SaveVMHandlers
Message-ID: <20201024115813.GB11827@yzhao56-desk>
References: <1603449643-12851-1-git-send-email-kwankhede@nvidia.com>
 <1603449643-12851-10-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603449643-12851-10-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.24; envelope-from=yan.y.zhao@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 07:59:38
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: cohuck@redhat.com, cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com, artemp@nvidia.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>

On Fri, Oct 23, 2020 at 04:10:35PM +0530, Kirti Wankhede wrote:
> Sequence  during _RESUMING device state:
> While data for this device is available, repeat below steps:
> a. read data_offset from where user application should write data.
> b. write data of data_size to migration region from data_offset.
> c. write data_size which indicates vendor driver that data is written in
>    staging buffer.
> 
> For user, data is opaque. User should write data in the same order as
> received.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/vfio/migration.c  | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events |   4 ++
>  2 files changed, 199 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index be9e4aba541d..240646592b39 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -257,6 +257,77 @@ static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev, uint64_t *size)
>      return ret;
>  }
>  
> +static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
> +                            uint64_t data_size)
> +{
> +    VFIORegion *region = &vbasedev->migration->region;
> +    uint64_t data_offset = 0, size, report_size;
> +    int ret;
> +
> +    do {
> +        ret = vfio_mig_read(vbasedev, &data_offset, sizeof(data_offset),
> +                      region->fd_offset + VFIO_MIG_STRUCT_OFFSET(data_offset));
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        if (data_offset + data_size > region->size) {
> +            /*
> +             * If data_size is greater than the data section of migration region
> +             * then iterate the write buffer operation. This case can occur if
> +             * size of migration region at destination is smaller than size of
> +             * migration region at source.
> +             */
> +            report_size = size = region->size - data_offset;
> +            data_size -= size;
> +        } else {
> +            report_size = size = data_size;
> +            data_size = 0;
> +        }
> +
> +        trace_vfio_load_state_device_data(vbasedev->name, data_offset, size);
> +
> +        while (size) {
> +            void *buf;
> +            uint64_t sec_size;
> +            bool buf_alloc = false;
> +
> +            buf = get_data_section_size(region, data_offset, size, &sec_size);
> +
> +            if (!buf) {
> +                buf = g_try_malloc(sec_size);
> +                if (!buf) {
> +                    error_report("%s: Error allocating buffer ", __func__);
> +                    return -ENOMEM;
> +                }
> +                buf_alloc = true;
> +            }
> +
> +            qemu_get_buffer(f, buf, sec_size);
> +
> +            if (buf_alloc) {
> +                ret = vfio_mig_write(vbasedev, buf, sec_size,
> +                        region->fd_offset + data_offset);
> +                g_free(buf);
> +
> +                if (ret < 0) {
> +                    return ret;
> +                }
> +            }
> +            size -= sec_size;
> +            data_offset += sec_size;
> +        }
> +
> +        ret = vfio_mig_write(vbasedev, &report_size, sizeof(report_size),
> +                        region->fd_offset + VFIO_MIG_STRUCT_OFFSET(data_size));
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    } while (data_size);
> +
> +    return 0;
> +}
> +
>  static int vfio_update_pending(VFIODevice *vbasedev)
>  {
>      VFIOMigration *migration = vbasedev->migration;
> @@ -293,6 +364,33 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
>      return qemu_file_get_error(f);
>  }
>  
> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    uint64_t data;
> +
> +    if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
> +        int ret;
> +
> +        ret = vbasedev->ops->vfio_load_config(vbasedev, f);
> +        if (ret) {
> +            error_report("%s: Failed to load device config space",
> +                         vbasedev->name);
> +            return ret;
> +        }
> +    }
> +
> +    data = qemu_get_be64(f);
> +    if (data != VFIO_MIG_FLAG_END_OF_STATE) {
> +        error_report("%s: Failed loading device config space, "
> +                     "end flag incorrect 0x%"PRIx64, vbasedev->name, data);
> +        return -EINVAL;
> +    }
> +
> +    trace_vfio_load_device_config_state(vbasedev->name);
> +    return qemu_file_get_error(f);
> +}
> +
>  static void vfio_migration_cleanup(VFIODevice *vbasedev)
>  {
>      VFIOMigration *migration = vbasedev->migration;
> @@ -483,12 +581,109 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>      return ret;
>  }
>  
> +static int vfio_load_setup(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret = 0;
> +
> +    if (migration->region.mmaps) {
> +        ret = vfio_region_mmap(&migration->region);
> +        if (ret) {
> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
> +                         vbasedev->name, migration->region.nr,
> +                         strerror(-ret));
> +            error_report("%s: Falling back to slow path", vbasedev->name);
> +        }
> +    }
> +
> +    ret = vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_MASK,
> +                                   VFIO_DEVICE_STATE_RESUMING);
> +    if (ret) {
> +        error_report("%s: Failed to set state RESUMING", vbasedev->name);
> +        if (migration->region.mmaps) {
> +            vfio_region_unmap(&migration->region);
> +        }
> +    }
> +    return ret;
> +}
> +
> +static int vfio_load_cleanup(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    vfio_migration_cleanup(vbasedev);
> +    trace_vfio_load_cleanup(vbasedev->name);
> +    return 0;
> +}
> +
> +static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    int ret = 0;
> +    uint64_t data;
> +
> +    data = qemu_get_be64(f);
> +    while (data != VFIO_MIG_FLAG_END_OF_STATE) {
> +
> +        trace_vfio_load_state(vbasedev->name, data);
> +
> +        switch (data) {
> +        case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
> +        {
> +            ret = vfio_load_device_config_state(f, opaque);
> +            if (ret) {
> +                return ret;
> +            }
> +            break;
> +        }
> +        case VFIO_MIG_FLAG_DEV_SETUP_STATE:
> +        {
> +            data = qemu_get_be64(f);
> +            if (data == VFIO_MIG_FLAG_END_OF_STATE) {
> +                return ret;
> +            } else {
> +                error_report("%s: SETUP STATE: EOS not found 0x%"PRIx64,
> +                             vbasedev->name, data);
> +                return -EINVAL;
> +            }
> +            break;
> +        }
> +        case VFIO_MIG_FLAG_DEV_DATA_STATE:
> +        {
> +            uint64_t data_size = qemu_get_be64(f);
> +
> +            if (data_size) {
> +                ret = vfio_load_buffer(f, vbasedev, data_size);
> +                if (ret < 0) {
> +                    return ret;
> +                }
> +            }
> +            break;
> +        }
> +        default:
> +            error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
> +            return -EINVAL;
> +        }
> +
> +        data = qemu_get_be64(f);
> +        ret = qemu_file_get_error(f);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +    return ret;
> +}
> +
>  static SaveVMHandlers savevm_vfio_handlers = {
>      .save_setup = vfio_save_setup,
>      .save_cleanup = vfio_save_cleanup,
>      .save_live_pending = vfio_save_pending,
>      .save_live_iterate = vfio_save_iterate,
>      .save_live_complete_precopy = vfio_save_complete_precopy,
> +    .load_setup = vfio_load_setup,
> +    .load_cleanup = vfio_load_cleanup,
> +    .load_state = vfio_load_state,
>  };
>  
>  /* ---------------------------------------------------------------------- */
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 9f5712dab1ea..a75b5208818c 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -159,3 +159,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
>  vfio_save_pending(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible 0x%"PRIx64
>  vfio_save_iterate(const char *name, int data_size) " (%s) data_size %d"
>  vfio_save_complete_precopy(const char *name) " (%s)"
> +vfio_load_device_config_state(const char *name) " (%s)"
> +vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
> +vfio_load_state_device_data(const char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
> +vfio_load_cleanup(const char *name) " (%s)"
> -- 
> 2.7.0
> 

