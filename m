Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24A2C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0162068D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFsvgeca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0162068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLviF-0005bX-I7
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 17:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kLvh5-0004Ka-70
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kLvh2-00063y-Qf
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:55:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601070952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtZm9WLi6DUAixAeidgYZaL37hgV0J9YHfjH5EllhD8=;
 b=iFsvgeca3G8mbHZrxRrj5ySTNu2lwi2cW0u0k34vS77H5pqZgAAWljTxvxRWtL5jMQWmyb
 /h++Sm4PHJgEkA8cO8vHoHbAT5z99+VGbFFAMOmmZyHtfInZUlO1S8m8ZxJCH4YV0txgY3
 jKEyZvZe0JAoQ15ZhTfwGDYT6y/uvQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-EorSWocrNMq9mi95gVuZxQ-1; Fri, 25 Sep 2020 17:55:50 -0400
X-MC-Unique: EorSWocrNMq9mi95gVuZxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAB452FD04;
 Fri, 25 Sep 2020 21:55:47 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A97BA5C1BB;
 Fri, 25 Sep 2020 21:55:43 +0000 (UTC)
Date: Fri, 25 Sep 2020 15:02:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v26 08/17] vfio: Add save state functions to SaveVMHandlers
Message-ID: <20200925150213.38cc975e@x1.home>
In-Reply-To: <1600817059-26721-9-git-send-email-kwankhede@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-9-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Sep 2020 04:54:10 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

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
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c           | 273 ++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |   6 +
>  include/hw/vfio/vfio-common.h |   1 +
>  3 files changed, 280 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 8e8adaa25779..4611bb972228 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -180,6 +180,154 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
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
> +            *size = data_size;
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
> +        *size = limit ? limit - data_offset : data_size;

'limit - data_offset' doesn't take data_size into account, this should
be MIN(data_size, limit - data_offset).

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
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             data_offset));
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret = vfio_mig_read(vbasedev, &data_size, sizeof(data_size),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             data_size));
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
> +        void *buf = NULL;

Unnecessary initialization.

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
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             pending_bytes));
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
>  /* ---------------------------------------------------------------------- */
>  
>  static int vfio_save_setup(QEMUFile *f, void *opaque)
> @@ -232,9 +380,134 @@ static void vfio_save_cleanup(void *opaque)
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
> +            /* indicates data finished, goto complete phase */
> +            return 1;
> +        }
> +    }
> +
> +    ret = vfio_save_buffer(f, vbasedev, &data_size);
> +
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
> +    trace_vfio_save_iterate(vbasedev->name, data_size);
> +
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

This also assumes success implies desired state.

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

And another.  Thanks,

Alex

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
> index 982d8dccb219..118b5547c921 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -154,3 +154,9 @@ vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t
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
> index 49c7c7a0e29a..471e444a364c 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -60,6 +60,7 @@ typedef struct VFIORegion {
>  
>  typedef struct VFIOMigration {
>      VFIORegion region;
> +    uint64_t pending_bytes;
>  } VFIOMigration;
>  
>  typedef struct VFIOAddressSpace {


