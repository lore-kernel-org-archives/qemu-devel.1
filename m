Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAE6C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 12:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE94C2225F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 12:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE94C2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWIGo-0004bJ-ID
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 08:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kWIE9-0002v5-MA
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 08:00:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:1547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kWIE6-0004zc-Gc
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 08:00:53 -0400
IronPort-SDR: dvIyV4S9b/8+d1hoqwfCdXEO2XQQVNDHFamlXQQb7JSXA9QjsZ5sef/YYWRbMeh/j67327dP5+
 rwG4jiu2/zag==
X-IronPort-AV: E=McAfee;i="6000,8403,9783"; a="166985746"
X-IronPort-AV: E=Sophos;i="5.77,412,1596524400"; d="scan'208";a="166985746"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2020 05:00:47 -0700
IronPort-SDR: IcMWRvYCB7axOh2f2VtoO5qnl5IsvTBAo8a9kb81YRfuyBaBJzR2ki9uMTt1gt+ATrjv4P23Y+
 1LkwJJFtA85Q==
X-IronPort-AV: E=Sophos;i="5.77,412,1596524400"; d="scan'208";a="534741452"
Received: from joy-optiplex-7040.sh.intel.com (HELO yzhao56-desk)
 ([10.239.13.16])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2020 05:00:40 -0700
Date: Sat, 24 Oct 2020 19:59:22 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v28 08/17] vfio: Add save state functions to SaveVMHandlers
Message-ID: <20201024115922.GC11827@yzhao56-desk>
References: <1603449643-12851-1-git-send-email-kwankhede@nvidia.com>
 <1603449643-12851-9-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603449643-12851-9-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.115; envelope-from=yan.y.zhao@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 08:00:47
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 23, 2020 at 04:10:34PM +0530, Kirti Wankhede wrote:
> Added .save_live_pending, .save_live_iterate and .save_live_complete_precopy
> functions. These functions handles pre-copy and stop-and-copy phase.
> 
> In _SAVING|_RUNNING device state or pre-copy phase:
> - read pending_bytes. If pending_bytes > 0, go through below steps.
> - read data_offset - indicates kernel driver to write data to staging
>   buffer.
> - read data_size - amount of data in bytes written by vendor driver in
>   migration region.
> - read data_size bytes of data from data_offset in the migration region.
> - Write data packet to file stream as below:
> {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
> VFIO_MIG_FLAG_END_OF_STATE }
> 
> In _SAVING device state or stop-and-copy phase
> a. read config space of device and save to migration file stream. This
>    doesn't need to be from vendor driver. Any other special config state
>    from driver can be saved as data in following iteration.
> b. read pending_bytes. If pending_bytes > 0, go through below steps.
> c. read data_offset - indicates kernel driver to write data to staging
>    buffer.
> d. read data_size - amount of data in bytes written by vendor driver in
>    migration region.
> e. read data_size bytes of data from data_offset in the migration region.
> f. Write data packet as below:
>    {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data}
> g. iterate through steps b to f while (pending_bytes > 0)
> h. Write {VFIO_MIG_FLAG_END_OF_STATE}
> 
> When data region is mapped, its user's responsibility to read data from
> data_offset of data_size before moving to next steps.
> 
> Added fix suggested by Artem Polyakov to reset pending_bytes in
> vfio_save_iterate().
> Added fix suggested by Zhi Wang to add 0 as data size in migration stream and
> add END_OF_STATE delimiter to indicate phase complete.
> 
> Suggested-by: Artem Polyakov <artemp@nvidia.com>
> Suggested-by: Zhi Wang <zhi.wang.linux@gmail.com>
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c           | 276 ++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |   6 +
>  include/hw/vfio/vfio-common.h |   1 +
>  3 files changed, 283 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 94d2bdae5c54..be9e4aba541d 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -148,6 +148,151 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
>      return 0;
>  }
>  
> +static void *get_data_section_size(VFIORegion *region, uint64_t data_offset,
> +                                   uint64_t data_size, uint64_t *size)
> +{
> +    void *ptr = NULL;
> +    uint64_t limit = 0;
> +    int i;
> +
> +    if (!region->mmaps) {
> +        if (size) {
> +            *size = MIN(data_size, region->size - data_offset);
> +        }
> +        return ptr;
> +    }
> +
> +    for (i = 0; i < region->nr_mmaps; i++) {
> +        VFIOMmap *map = region->mmaps + i;
> +
> +        if ((data_offset >= map->offset) &&
> +            (data_offset < map->offset + map->size)) {
> +
> +            /* check if data_offset is within sparse mmap areas */
> +            ptr = map->mmap + data_offset - map->offset;
> +            if (size) {
> +                *size = MIN(data_size, map->offset + map->size - data_offset);
> +            }
> +            break;
> +        } else if ((data_offset < map->offset) &&
> +                   (!limit || limit > map->offset)) {
> +            /*
> +             * data_offset is not within sparse mmap areas, find size of
> +             * non-mapped area. Check through all list since region->mmaps list
> +             * is not sorted.
> +             */
> +            limit = map->offset;
> +        }
> +    }
> +
> +    if (!ptr && size) {
> +        *size = limit ? MIN(data_size, limit - data_offset) : data_size;
> +    }
> +    return ptr;
> +}
> +
> +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev, uint64_t *size)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region;
> +    uint64_t data_offset = 0, data_size = 0, sz;
> +    int ret;
> +
> +    ret = vfio_mig_read(vbasedev, &data_offset, sizeof(data_offset),
> +                      region->fd_offset + VFIO_MIG_STRUCT_OFFSET(data_offset));
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret = vfio_mig_read(vbasedev, &data_size, sizeof(data_size),
> +                        region->fd_offset + VFIO_MIG_STRUCT_OFFSET(data_size));
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    trace_vfio_save_buffer(vbasedev->name, data_offset, data_size,
> +                           migration->pending_bytes);
> +
> +    qemu_put_be64(f, data_size);
> +    sz = data_size;
> +
> +    while (sz) {
> +        void *buf;
> +        uint64_t sec_size;
> +        bool buf_allocated = false;
> +
> +        buf = get_data_section_size(region, data_offset, sz, &sec_size);
> +
> +        if (!buf) {
> +            buf = g_try_malloc(sec_size);
> +            if (!buf) {
> +                error_report("%s: Error allocating buffer ", __func__);
> +                return -ENOMEM;
> +            }
> +            buf_allocated = true;
> +
> +            ret = vfio_mig_read(vbasedev, buf, sec_size,
> +                                region->fd_offset + data_offset);
> +            if (ret < 0) {
> +                g_free(buf);
> +                return ret;
> +            }
> +        }
> +
> +        qemu_put_buffer(f, buf, sec_size);
> +
> +        if (buf_allocated) {
> +            g_free(buf);
> +        }
> +        sz -= sec_size;
> +        data_offset += sec_size;
> +    }
> +
> +    ret = qemu_file_get_error(f);
> +
> +    if (!ret && size) {
> +        *size = data_size;
> +    }
> +
> +    return ret;
> +}
> +
> +static int vfio_update_pending(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region;
> +    uint64_t pending_bytes = 0;
> +    int ret;
> +
> +    ret = vfio_mig_read(vbasedev, &pending_bytes, sizeof(pending_bytes),
> +                    region->fd_offset + VFIO_MIG_STRUCT_OFFSET(pending_bytes));
> +    if (ret < 0) {
> +        migration->pending_bytes = 0;
> +        return ret;
> +    }
> +
> +    migration->pending_bytes = pending_bytes;
> +    trace_vfio_update_pending(vbasedev->name, pending_bytes);
> +    return 0;
> +}
> +
> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
> +
> +    if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
> +        vbasedev->ops->vfio_save_config(vbasedev, f);
> +    }
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    trace_vfio_save_device_config_state(vbasedev->name);
> +
> +    return qemu_file_get_error(f);
> +}
> +
>  static void vfio_migration_cleanup(VFIODevice *vbasedev)
>  {
>      VFIOMigration *migration = vbasedev->migration;
> @@ -210,9 +355,140 @@ static void vfio_save_cleanup(void *opaque)
>      trace_vfio_save_cleanup(vbasedev->name);
>  }
>  
> +static void vfio_save_pending(QEMUFile *f, void *opaque,
> +                              uint64_t threshold_size,
> +                              uint64_t *res_precopy_only,
> +                              uint64_t *res_compatible,
> +                              uint64_t *res_postcopy_only)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
> +
> +    ret = vfio_update_pending(vbasedev);
> +    if (ret) {
> +        return;
> +    }
> +
> +    *res_precopy_only += migration->pending_bytes;
> +
> +    trace_vfio_save_pending(vbasedev->name, *res_precopy_only,
> +                            *res_postcopy_only, *res_compatible);
> +}
> +
> +static int vfio_save_iterate(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    uint64_t data_size;
> +    int ret;
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
> +
> +    if (migration->pending_bytes == 0) {
> +        ret = vfio_update_pending(vbasedev);
> +        if (ret) {
> +            return ret;
> +        }
> +
> +        if (migration->pending_bytes == 0) {
> +            qemu_put_be64(f, 0);
> +            qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +            /* indicates data finished, goto complete phase */
> +            return 1;
> +        }
> +    }
> +
> +    ret = vfio_save_buffer(f, vbasedev, &data_size);
> +    if (ret) {
> +        error_report("%s: vfio_save_buffer failed %s", vbasedev->name,
> +                     strerror(errno));
> +        return ret;
> +    }
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    ret = qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    /*
> +     * Reset pending_bytes as .save_live_pending is not called during savevm or
> +     * snapshot case, in such case vfio_update_pending() at the start of this
> +     * function updates pending_bytes.
> +     */
> +    migration->pending_bytes = 0;
> +    trace_vfio_save_iterate(vbasedev->name, data_size);
> +    return 0;
> +}
> +
> +static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    uint64_t data_size;
> +    int ret;
> +
> +    ret = vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_RUNNING,
> +                                   VFIO_DEVICE_STATE_SAVING);
> +    if (ret) {
> +        error_report("%s: Failed to set state STOP and SAVING",
> +                     vbasedev->name);
> +        return ret;
> +    }
> +
> +    ret = vfio_save_device_config_state(f, opaque);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret = vfio_update_pending(vbasedev);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    while (migration->pending_bytes > 0) {
> +        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
> +        ret = vfio_save_buffer(f, vbasedev, &data_size);
> +        if (ret < 0) {
> +            error_report("%s: Failed to save buffer", vbasedev->name);
> +            return ret;
> +        }
> +
> +        if (data_size == 0) {
> +            break;
> +        }
> +
> +        ret = vfio_update_pending(vbasedev);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    ret = qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret = vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_SAVING, 0);
> +    if (ret) {
> +        error_report("%s: Failed to set state STOPPED", vbasedev->name);
> +        return ret;
> +    }
> +
> +    trace_vfio_save_complete_precopy(vbasedev->name);
> +    return ret;
> +}
> +
>  static SaveVMHandlers savevm_vfio_handlers = {
>      .save_setup = vfio_save_setup,
>      .save_cleanup = vfio_save_cleanup,
> +    .save_live_pending = vfio_save_pending,
> +    .save_live_iterate = vfio_save_iterate,
> +    .save_live_complete_precopy = vfio_save_complete_precopy,
>  };
>  
>  /* ---------------------------------------------------------------------- */
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index f148b5e828c1..9f5712dab1ea 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -153,3 +153,9 @@ vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t
>  vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
>  vfio_save_setup(const char *name) " (%s)"
>  vfio_save_cleanup(const char *name) " (%s)"
> +vfio_save_buffer(const char *name, uint64_t data_offset, uint64_t data_size, uint64_t pending) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64" pending 0x%"PRIx64
> +vfio_update_pending(const char *name, uint64_t pending) " (%s) pending 0x%"PRIx64
> +vfio_save_device_config_state(const char *name) " (%s)"
> +vfio_save_pending(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible 0x%"PRIx64
> +vfio_save_iterate(const char *name, int data_size) " (%s) data_size %d"
> +vfio_save_complete_precopy(const char *name) " (%s)"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 2bd593ba38bb..f4ebdae013ad 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -65,6 +65,7 @@ typedef struct VFIOMigration {
>      uint32_t device_state;
>      int vm_running;
>      Notifier migration_state;
> +    uint64_t pending_bytes;
>  } VFIOMigration;
>  
>  typedef struct VFIOAddressSpace {
> -- 
> 2.7.0
> 

