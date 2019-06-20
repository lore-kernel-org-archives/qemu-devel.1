Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD51C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9B32084E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9B32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he3Kg-00050E-FG
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 16:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58126)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1he2gW-0000CY-GD
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 15:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1he2gU-0002dZ-Hv
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 15:25:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1he2gU-0002dR-9h
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 15:25:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 74360307B965;
 Thu, 20 Jun 2019 19:25:10 +0000 (UTC)
Received: from x1.home (ovpn-117-35.phx2.redhat.com [10.3.117.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDE8060477;
 Thu, 20 Jun 2019 19:25:05 +0000 (UTC)
Date: Thu, 20 Jun 2019 13:25:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20190620132505.1cf64ac5@x1.home>
In-Reply-To: <1561041461-22326-9-git-send-email-kwankhede@nvidia.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-9-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 20 Jun 2019 19:25:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 08/13] vfio: Add save state functions to
 SaveVMHandlers
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, yulei.zhang@intel.com, eauger@redhat.com,
 felipe@nutanix.com, jonathan.davies@nutanix.com, yan.y.zhao@intel.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Jun 2019 20:07:36 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Added .save_live_pending, .save_live_iterate and .save_live_complete_precopy
> functions. These functions handles pre-copy and stop-and-copy phase.
> 
> In _SAVING|_RUNNING device state or pre-copy phase:
> - read pending_bytes
> - read data_offset - indicates kernel driver to write data to staging
>   buffer which is mmapped.

Why is data_offset the trigger rather than data_size?  It seems that
data_offset can't really change dynamically since it might be mmap'd,
so it seems unnatural to bother re-reading it.

> - read data_size - amount of data in bytes written by vendor driver in migration
>   region.
> - if data section is trapped, pread() number of bytes in data_size, from
>   data_offset.
> - if data section is mmaped, read mmaped buffer of size data_size.
> - Write data packet to file stream as below:
> {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
> VFIO_MIG_FLAG_END_OF_STATE }
> 
> In _SAVING device state or stop-and-copy phase
> a. read config space of device and save to migration file stream. This
>    doesn't need to be from vendor driver. Any other special config state
>    from driver can be saved as data in following iteration.
> b. read pending_bytes - indicates kernel driver to write data to staging
>    buffer which is mmapped.

Is it pending_bytes or data_offset that triggers the write out of
data?  Why pending_bytes vs data_size?  I was interpreting
pending_bytes as the total data size while data_size is the size
available to read now, so assumed data_size would be more closely
aligned to making the data available.

> c. read data_size - amount of data in bytes written by vendor driver in
>    migration region.
> d. if data section is trapped, pread() from data_offset of size data_size.
> e. if data section is mmaped, read mmaped buffer of size data_size.

Should this read as "pread() from data_offset of data_size, or
optionally if mmap is supported on the data area, read data_size from
start of mapped buffer"?  IOW, pread should always work.  Same in
previous section.

> f. Write data packet as below:
>    {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data}
> g. iterate through steps b to f until (pending_bytes > 0)

s/until/while/

> h. Write {VFIO_MIG_FLAG_END_OF_STATE}
> 
> .save_live_iterate runs outside the iothread lock in the migration case, which
> could race with asynchronous call to get dirty page list causing data corruption
> in mapped migration region. Mutex added here to serial migration buffer read
> operation.

Would we be ahead to use different offsets within the region for device
data vs dirty bitmap to avoid this?
 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 212 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index fe0887c27664..0a2f30872316 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -107,6 +107,111 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
>      return 0;
>  }
>  
> +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region.buffer;
> +    uint64_t data_offset = 0, data_size = 0;
> +    int ret;
> +
> +    ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             data_offset));
> +    if (ret != sizeof(data_offset)) {
> +        error_report("Failed to get migration buffer data offset %d",
> +                     ret);
> +        return -EINVAL;
> +    }
> +
> +    ret = pread(vbasedev->fd, &data_size, sizeof(data_size),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             data_size));
> +    if (ret != sizeof(data_size)) {
> +        error_report("Failed to get migration buffer data size %d",
> +                     ret);
> +        return -EINVAL;
> +    }
> +
> +    if (data_size > 0) {
> +        void *buf = NULL;
> +        bool buffer_mmaped = false;
> +
> +        if (region->mmaps) {
> +            int i;
> +
> +            for (i = 0; i < region->nr_mmaps; i++) {
> +                if ((data_offset >= region->mmaps[i].offset) &&
> +                    (data_offset < region->mmaps[i].offset +
> +                                   region->mmaps[i].size)) {
> +                    buf = region->mmaps[i].mmap + (data_offset -
> +                                                   region->mmaps[i].offset);

So you're expecting that data_offset is somewhere within the data
area.  Why doesn't the data always simply start at the beginning of the
data area?  ie. data_offset would coincide with the beginning of the
mmap'able area (if supported) and be static.  Does this enable some
functionality in the vendor driver?  Does resume data need to be
written from the same offset where it's read?

> +                    buffer_mmaped = true;
> +                    break;
> +                }
> +            }
> +        }
> +
> +        if (!buffer_mmaped) {
> +            buf = g_malloc0(data_size);
> +            ret = pread(vbasedev->fd, buf, data_size,
> +                        region->fd_offset + data_offset);
> +            if (ret != data_size) {
> +                error_report("Failed to get migration data %d", ret);
> +                g_free(buf);
> +                return -EINVAL;
> +            }
> +        }
> +
> +        qemu_put_be64(f, data_size);
> +        qemu_put_buffer(f, buf, data_size);
> +
> +        if (!buffer_mmaped) {
> +            g_free(buf);
> +        }
> +        migration->pending_bytes -= data_size;
> +    } else {
> +        qemu_put_be64(f, data_size);
> +    }
> +
> +    ret = qemu_file_get_error(f);
> +
> +    return data_size;
> +}
> +
> +static int vfio_update_pending(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region.buffer;
> +    uint64_t pending_bytes = 0;
> +    int ret;
> +
> +    ret = pread(vbasedev->fd, &pending_bytes, sizeof(pending_bytes),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             pending_bytes));

Did this trigger the vendor driver to write out to the data area when
we don't need it to?

> +    if ((ret < 0) || (ret != sizeof(pending_bytes))) {
> +        error_report("Failed to get pending bytes %d", ret);
> +        migration->pending_bytes = 0;
> +        return (ret < 0) ? ret : -EINVAL;
> +    }
> +
> +    migration->pending_bytes = pending_bytes;
> +    return 0;
> +}
> +
> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
> +
> +    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        vfio_pci_save_config(vbasedev, f);
> +    }
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    return qemu_file_get_error(f);
> +}
> +
>  /* ---------------------------------------------------------------------- */
>  
>  static int vfio_save_setup(QEMUFile *f, void *opaque)
> @@ -163,9 +268,116 @@ static void vfio_save_cleanup(void *opaque)
>      }
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
> +    if (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING) {
> +        *res_precopy_only += migration->pending_bytes;
> +    } else {
> +        *res_postcopy_only += migration->pending_bytes;
> +    }
> +    *res_compatible += 0;
> +}
> +
> +static int vfio_save_iterate(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
> +
> +    qemu_mutex_lock(&migration->lock);
> +    ret = vfio_save_buffer(f, vbasedev);
> +    qemu_mutex_unlock(&migration->lock);
> +
> +    if (ret < 0) {
> +        error_report("vfio_save_buffer failed %s",
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
> +    return ret;
> +}
> +
> +static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
> +
> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_SAVING);
> +    if (ret) {
> +        error_report("Failed to set state STOP and SAVING");
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
> +        ret = vfio_save_buffer(f, vbasedev);
> +        if (ret < 0) {
> +            error_report("Failed to save buffer");
> +            return ret;
> +        } else if (ret == 0) {
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
> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOPPED);
> +    if (ret) {
> +        error_report("Failed to set state STOPPED");
> +        return ret;
> +    }
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


