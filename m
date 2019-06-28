Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7B7C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509392086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509392086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgyOy-0004bR-AS
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 17:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56873)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yan.y.zhao@intel.com>) id 1hgyKD-0002oR-Co
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1hgyKB-0003FI-EU
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:22:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:52433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1hgyKA-00038C-Ta
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:22:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jun 2019 14:22:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,429,1557212400"; d="scan'208";a="361200347"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2019 14:22:16 -0700
Date: Fri, 28 Jun 2019 17:16:21 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190628211621.GG6971@joy-OptiPlex-7040>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-9-git-send-email-kwankhede@nvidia.com>
 <20190621003153.GG9303@joy-OptiPlex-7040>
 <20190625033029.GC6971@joy-OptiPlex-7040>
 <20190628085030.GA2922@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628085030.GA2922@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "yulei.zhang@intel.com" <yulei.zhang@intel.com>,
 "aik@ozlabs.ru" <aik@ozlabs.ru>, Kirti Wankhede <kwankhede@nvidia.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 28, 2019 at 04:50:30PM +0800, Dr. David Alan Gilbert wrote:
> * Yan Zhao (yan.y.zhao@intel.com) wrote:
> > On Fri, Jun 21, 2019 at 08:31:53AM +0800, Yan Zhao wrote:
> > > On Thu, Jun 20, 2019 at 10:37:36PM +0800, Kirti Wankhede wrote:
> > > > Added .save_live_pending, .save_live_iterate and .save_live_complete_precopy
> > > > functions. These functions handles pre-copy and stop-and-copy phase.
> > > > 
> > > > In _SAVING|_RUNNING device state or pre-copy phase:
> > > > - read pending_bytes
> > > > - read data_offset - indicates kernel driver to write data to staging
> > > >   buffer which is mmapped.
> > > > - read data_size - amount of data in bytes written by vendor driver in migration
> > > >   region.
> > > > - if data section is trapped, pread() number of bytes in data_size, from
> > > >   data_offset.
> > > > - if data section is mmaped, read mmaped buffer of size data_size.
> > > > - Write data packet to file stream as below:
> > > > {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
> > > > VFIO_MIG_FLAG_END_OF_STATE }
> > > > 
> > > > In _SAVING device state or stop-and-copy phase
> > > > a. read config space of device and save to migration file stream. This
> > > >    doesn't need to be from vendor driver. Any other special config state
> > > >    from driver can be saved as data in following iteration.
> > > > b. read pending_bytes - indicates kernel driver to write data to staging
> > > >    buffer which is mmapped.
> > > > c. read data_size - amount of data in bytes written by vendor driver in
> > > >    migration region.
> > > > d. if data section is trapped, pread() from data_offset of size data_size.
> > > > e. if data section is mmaped, read mmaped buffer of size data_size.
> > > > f. Write data packet as below:
> > > >    {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data}
> > > > g. iterate through steps b to f until (pending_bytes > 0)
> > > > h. Write {VFIO_MIG_FLAG_END_OF_STATE}
> > > > 
> > > > .save_live_iterate runs outside the iothread lock in the migration case, which
> > > > could race with asynchronous call to get dirty page list causing data corruption
> > > > in mapped migration region. Mutex added here to serial migration buffer read
> > > > operation.
> > > > 
> > > > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > > > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > > > ---
> > > >  hw/vfio/migration.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 212 insertions(+)
> > > > 
> > > > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > > > index fe0887c27664..0a2f30872316 100644
> > > > --- a/hw/vfio/migration.c
> > > > +++ b/hw/vfio/migration.c
> > > > @@ -107,6 +107,111 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
> > > >      return 0;
> > > >  }
> > > >  
> > > > +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
> > > > +{
> > > > +    VFIOMigration *migration = vbasedev->migration;
> > > > +    VFIORegion *region = &migration->region.buffer;
> > > > +    uint64_t data_offset = 0, data_size = 0;
> > > > +    int ret;
> > > > +
> > > > +    ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
> > > > +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> > > > +                                             data_offset));
> > > > +    if (ret != sizeof(data_offset)) {
> > > > +        error_report("Failed to get migration buffer data offset %d",
> > > > +                     ret);
> > > > +        return -EINVAL;
> > > > +    }
> > > > +
> > > > +    ret = pread(vbasedev->fd, &data_size, sizeof(data_size),
> > > > +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> > > > +                                             data_size));
> > > > +    if (ret != sizeof(data_size)) {
> > > > +        error_report("Failed to get migration buffer data size %d",
> > > > +                     ret);
> > > > +        return -EINVAL;
> > > > +    }
> > > > +
> > > how big is the data_size ? 
> > > if this size is too big, it may take too much time and block others.
> > > 
> > > > +    if (data_size > 0) {
> > > > +        void *buf = NULL;
> > > > +        bool buffer_mmaped = false;
> > > > +
> > > > +        if (region->mmaps) {
> > > > +            int i;
> > > > +
> > > > +            for (i = 0; i < region->nr_mmaps; i++) {
> > > > +                if ((data_offset >= region->mmaps[i].offset) &&
> > > > +                    (data_offset < region->mmaps[i].offset +
> > > > +                                   region->mmaps[i].size)) {
> > > > +                    buf = region->mmaps[i].mmap + (data_offset -
> > > > +                                                   region->mmaps[i].offset);
> > > > +                    buffer_mmaped = true;
> > > > +                    break;
> > > > +                }
> > > > +            }
> > > > +        }
> > > > +
> > > > +        if (!buffer_mmaped) {
> > > > +            buf = g_malloc0(data_size);
> > > > +            ret = pread(vbasedev->fd, buf, data_size,
> > > > +                        region->fd_offset + data_offset);
> > > > +            if (ret != data_size) {
> > > > +                error_report("Failed to get migration data %d", ret);
> > > > +                g_free(buf);
> > > > +                return -EINVAL;
> > > > +            }
> > > > +        }
> > > > +
> > > > +        qemu_put_be64(f, data_size);
> > > > +        qemu_put_buffer(f, buf, data_size);
> > > > +
> > > > +        if (!buffer_mmaped) {
> > > > +            g_free(buf);
> > > > +        }
> > > > +        migration->pending_bytes -= data_size;
> > > > +    } else {
> > > > +        qemu_put_be64(f, data_size);
> > > > +    }
> > > > +
> > > > +    ret = qemu_file_get_error(f);
> > > > +
> > > > +    return data_size;
> > > > +}
> > > > +
> > > > +static int vfio_update_pending(VFIODevice *vbasedev)
> > > > +{
> > > > +    VFIOMigration *migration = vbasedev->migration;
> > > > +    VFIORegion *region = &migration->region.buffer;
> > > > +    uint64_t pending_bytes = 0;
> > > > +    int ret;
> > > > +
> > > > +    ret = pread(vbasedev->fd, &pending_bytes, sizeof(pending_bytes),
> > > > +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> > > > +                                             pending_bytes));
> > > > +    if ((ret < 0) || (ret != sizeof(pending_bytes))) {
> > > > +        error_report("Failed to get pending bytes %d", ret);
> > > > +        migration->pending_bytes = 0;
> > > > +        return (ret < 0) ? ret : -EINVAL;
> > > > +    }
> > > > +
> > > > +    migration->pending_bytes = pending_bytes;
> > > > +    return 0;
> > > > +}
> > > > +
> > > > +static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> > > > +{
> > > > +    VFIODevice *vbasedev = opaque;
> > > > +
> > > > +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
> > > > +
> > > > +    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> > > > +        vfio_pci_save_config(vbasedev, f);
> > > > +    }
> > > > +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> > > > +
> > > > +    return qemu_file_get_error(f);
> > > > +}
> > > > +
> > > >  /* ---------------------------------------------------------------------- */
> > > >  
> > > >  static int vfio_save_setup(QEMUFile *f, void *opaque)
> > > > @@ -163,9 +268,116 @@ static void vfio_save_cleanup(void *opaque)
> > > >      }
> > > >  }
> > > >  
> > > > +static void vfio_save_pending(QEMUFile *f, void *opaque,
> > > > +                              uint64_t threshold_size,
> > > > +                              uint64_t *res_precopy_only,
> > > > +                              uint64_t *res_compatible,
> > > > +                              uint64_t *res_postcopy_only)
> > > > +{
> > > > +    VFIODevice *vbasedev = opaque;
> > > > +    VFIOMigration *migration = vbasedev->migration;
> > > > +    int ret;
> > > > +
> > > > +    ret = vfio_update_pending(vbasedev);
> > > > +    if (ret) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    if (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING) {
> > > > +        *res_precopy_only += migration->pending_bytes;
> > > > +    } else {
> > > > +        *res_postcopy_only += migration->pending_bytes;
> > > > +    }
> > by definition,
> > - res_precopy_only is for data which must be migrated in precopy phase
> >    or in stopped state, in other words - before target vm start
> > - res_postcopy_only is for data which must be migrated in postcopy phase
> >   or in stopped state, in other words - after source vm stop
> > So, we can only determining data type by the nature of the data. i.e.
> > if it is device state data which must be copied after source vm stop and
> > before target vm start, it belongs to res_precopy_only.
> > 
> > It is not right to determining data type by current device state.
> 
> Right; you can determine it by whether postcopy is *enabled* or not.
> However, since this isn't ready for postcopy yet anyway, just add it to
> res_postcopy_only all the time;  then you can come back to postcopy
hi Dave,
do you mean "add it to res_precopy_only all the time" here?

Thanks
Yan


> later.
> 
> Dave
> 
> > Thanks
> > Yan
> > 
> > > > +    *res_compatible += 0;
> > > > +}
> > > > +
> > > > +static int vfio_save_iterate(QEMUFile *f, void *opaque)
> > > > +{
> > > > +    VFIODevice *vbasedev = opaque;
> > > > +    VFIOMigration *migration = vbasedev->migration;
> > > > +    int ret;
> > > > +
> > > > +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
> > > > +
> > > > +    qemu_mutex_lock(&migration->lock);
> > > > +    ret = vfio_save_buffer(f, vbasedev);
> > > > +    qemu_mutex_unlock(&migration->lock);
> > > > +
> > > > +    if (ret < 0) {
> > > > +        error_report("vfio_save_buffer failed %s",
> > > > +                     strerror(errno));
> > > > +        return ret;
> > > > +    }
> > > > +
> > > > +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> > > > +
> > > > +    ret = qemu_file_get_error(f);
> > > > +    if (ret) {
> > > > +        return ret;
> > > > +    }
> > > > +
> > > > +    return ret;
> > > > +}
> > > > +
> > > > +static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
> > > > +{
> > > > +    VFIODevice *vbasedev = opaque;
> > > > +    VFIOMigration *migration = vbasedev->migration;
> > > > +    int ret;
> > > > +
> > > > +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_SAVING);
> > > > +    if (ret) {
> > > > +        error_report("Failed to set state STOP and SAVING");
> > > > +        return ret;
> > > > +    }
> > > > +
> > > > +    ret = vfio_save_device_config_state(f, opaque);
> > > > +    if (ret) {
> > > > +        return ret;
> > > > +    }
> > > > +
> > > > +    ret = vfio_update_pending(vbasedev);
> > > > +    if (ret) {
> > > > +        return ret;
> > > > +    }
> > > > +
> > > > +    while (migration->pending_bytes > 0) {
> > > > +        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
> > > > +        ret = vfio_save_buffer(f, vbasedev);
> > > > +        if (ret < 0) {
> > > > +            error_report("Failed to save buffer");
> > > > +            return ret;
> > > > +        } else if (ret == 0) {
> > > > +            break;
> > > > +        }
> > > > +
> > > > +        ret = vfio_update_pending(vbasedev);
> > > > +        if (ret) {
> > > > +            return ret;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> > > > +
> > > > +    ret = qemu_file_get_error(f);
> > > > +    if (ret) {
> > > > +        return ret;
> > > > +    }
> > > > +
> > > > +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOPPED);
> > > > +    if (ret) {
> > > > +        error_report("Failed to set state STOPPED");
> > > > +        return ret;
> > > > +    }
> > > > +    return ret;
> > > > +}
> > > > +
> > > >  static SaveVMHandlers savevm_vfio_handlers = {
> > > >      .save_setup = vfio_save_setup,
> > > >      .save_cleanup = vfio_save_cleanup,
> > > > +    .save_live_pending = vfio_save_pending,
> > > > +    .save_live_iterate = vfio_save_iterate,
> > > > +    .save_live_complete_precopy = vfio_save_complete_precopy,
> > > >  };
> > > >  
> > > >  /* ---------------------------------------------------------------------- */
> > > > -- 
> > > > 2.7.0
> > > > 
> > > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

