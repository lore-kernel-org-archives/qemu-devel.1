Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0131CC4646D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0907208E3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0907208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgn3W-0000ui-WC
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 05:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44725)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hgn2Q-0008JP-J7
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hgn2O-00006Q-1X
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:19:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42546)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hgn2K-0008Sf-JA
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:19:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2C5C356DA;
 Fri, 28 Jun 2019 09:19:06 +0000 (UTC)
Received: from work-vm (ovpn-116-169.ams2.redhat.com [10.36.116.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4F0510018F9;
 Fri, 28 Jun 2019 09:18:57 +0000 (UTC)
Date: Fri, 28 Jun 2019 10:18:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20190628091855.GC2922@work-vm>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-10-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561041461-22326-10-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 28 Jun 2019 09:19:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 09/13] vfio: Add load state functions to
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
Cc: Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com,
 yulei.zhang@intel.com, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, alex.williamson@redhat.com,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 yan.y.zhao@intel.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> During _RESUMING device state:
> - If Vendor driver defines mappable region, mmap migration region.
> - Load config state.
> - For data packet, till VFIO_MIG_FLAG_END_OF_STATE is not reached
>     - read data_size from packet, read buffer of data_size
>     - read data_offset from where QEMU should write data.
>         if region is mmaped, write data of data_size to mmaped region.
>     - write data_size.
>         In case of mmapped region, write to data_size indicates kernel
>         driver that data is written in staging buffer.
>     - if region is trapped, pwrite() data of data_size from data_offset.
> - Repeat above until VFIO_MIG_FLAG_END_OF_STATE.
> - Unmap migration region.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 0a2f30872316..e4895f91761d 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -212,6 +212,22 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
>      return qemu_file_get_error(f);
>  }
>  
> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        vfio_pci_load_config(vbasedev, f);
> +    }
> +
> +    if (qemu_get_be64(f) != VFIO_MIG_FLAG_END_OF_STATE) {
> +        error_report("Wrong end of block while loading device config space");

You might find it useful to print the value in the error.

> +        return -EINVAL;
> +    }
> +
> +    return qemu_file_get_error(f);
> +}
> +
>  /* ---------------------------------------------------------------------- */
>  
>  static int vfio_save_setup(QEMUFile *f, void *opaque)
> @@ -372,12 +388,149 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>      return ret;
>  }
>  
> +static int vfio_load_setup(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret = 0;
> +
> +    if (migration->region.buffer.mmaps) {
> +        ret = vfio_region_mmap(&migration->region.buffer);
> +        if (ret) {
> +            error_report("Failed to mmap VFIO migration region %d: %s",
> +                         migration->region.index, strerror(-ret));
> +            return ret;
> +        }
> +    }
> +
> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING);
> +    if (ret) {
> +        error_report("Failed to set state RESUMING");
> +    }
> +    return ret;
> +}
> +
> +static int vfio_load_cleanup(void *opaque)
> +{
> +    vfio_save_cleanup(opaque);
> +    return 0;
> +}
> +
> +static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret = 0;
> +    uint64_t data, data_size;
> +
> +    data = qemu_get_be64(f);
> +    while (data != VFIO_MIG_FLAG_END_OF_STATE) {
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
> +                error_report("SETUP STATE: EOS not found 0x%lx", data);

Please use PRIx64 for uint64_t (I know it's painful, but it's portable).

> +                return -EINVAL;
> +            }
> +            break;
> +        }
> +        case VFIO_MIG_FLAG_DEV_DATA_STATE:
> +        {
> +            VFIORegion *region = &migration->region.buffer;
> +            void *buf = NULL;
> +            bool buffer_mmaped = false;
> +            uint64_t data_offset = 0;
> +
> +            data_size = qemu_get_be64(f);
> +            if (data_size == 0) {
> +                break;
> +            }
> +
> +            ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
> +                        region->fd_offset +
> +                        offsetof(struct vfio_device_migration_info,
> +                        data_offset));
> +            if (ret != sizeof(data_offset)) {
> +                error_report("Failed to get migration buffer data offset %d",
> +                              ret);
> +                return -EINVAL;
> +            }
> +
> +            if (region->mmaps) {
> +                int i;
> +
> +                for (i = 0; i < region->nr_mmaps; i++) {
> +                    if (region->mmaps[i].mmap &&
> +                        (data_offset >= region->mmaps[i].offset) &&
> +                        (data_offset < region->mmaps[i].offset +
> +                                       region->mmaps[i].size)) {
> +                        buf = region->mmaps[i].mmap + (data_offset -
> +                                                      region->mmaps[i].offset);

What checks that the read data_size fits in the region?
[Treat the incoming stream as broken/malicious until proven otherwise]

> +                        buffer_mmaped = true;
> +                        break;
> +                    }
> +                }

I think you had some code like this on the save side?  Perhaps a
'find_region' helper would be good?

> +            }
> +
> +            if (!buffer_mmaped) {
> +                buf = g_malloc0(data_size);
> +            }

Given that data_size could be quite large, you might want to use
g_try_malloc0 and check the return value;  especially since 'data_size'
is read from the stream.

> +            qemu_get_buffer(f, buf, data_size);
> +
> +            ret = pwrite(vbasedev->fd, &data_size, sizeof(data_size),
> +                         region->fd_offset +
> +                       offsetof(struct vfio_device_migration_info, data_size));
> +            if (ret != sizeof(data_size)) {
> +                error_report("Failed to set migration buffer data size %d",
> +                             ret);
> +                return -EINVAL;
> +            }
> +
> +            if (!buffer_mmaped) {
> +                ret = pwrite(vbasedev->fd, buf, data_size,
> +                             region->fd_offset + data_offset);
> +                g_free(buf);
> +
> +                if (ret != data_size) {
> +                    error_report("Failed to set migration buffer %d", ret);
> +                    return -EINVAL;
> +                }
> +            }
> +            break;
> +        }
> +        }
> +
> +        ret = qemu_file_get_error(f);
> +        if (ret) {
> +            return ret;
> +        }
> +        data = qemu_get_be64(f);
> +    }
> +
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
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

