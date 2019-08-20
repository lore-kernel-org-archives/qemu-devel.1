Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410D0C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 20:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81A522DD3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 20:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Bu2d8bKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81A522DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ApQ-0000rN-1M
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 16:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1i0AmS-0007th-Ok
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1i0AmP-0002ZM-Fk
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:31:00 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1i0AmN-0002Wm-HU
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:30:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d5c587c0001>; Tue, 20 Aug 2019 13:30:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 20 Aug 2019 13:30:52 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 20 Aug 2019 13:30:52 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 20:30:52 +0000
Received: from [10.24.71.106] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 20:30:42 +0000
To: Yan Zhao <yan.y.zhao@intel.com>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-10-git-send-email-kwankhede@nvidia.com>
 <20190717025031.GE8912@joy-OptiPlex-7040>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <f3913c25-f25b-f959-0af1-6e819ab6606a@nvidia.com>
Date: Wed, 21 Aug 2019 02:00:38 +0530
MIME-Version: 1.0
In-Reply-To: <20190717025031.GE8912@joy-OptiPlex-7040>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1566333052; bh=dR7tsz71j0jR9Y3obtKXSb4Kk0lNsxToyySteSSBbus=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Bu2d8bKBBb5Vs/3aZxiwCqlm3rh3Sk72w0h4t8/xK31ItgH6RGscGG0zI7D3bXmye
 N0IKWwFyQLE2UcIVQkCzfKB0WrwW+XYQZ/KxOTzFz24Pr5vKO4uSNPMDoOnEGVLzFl
 dmtMEiQ/EvdhOvhGcMf3cO+Tunz8DAfKPoGu0qeziBG3MIGvLbtaLg/+vjld9V5Y0k
 gCbSgQGuBwhIJYcVlGVZkROuIOO/36JfS+sxaDEyzLU+/4ZzkMXeH9su2UaR7iAx71
 0RG4U09SKXcmy6KJgXbHSGDDSYmUhGt6L5d3duF67Krz0SqFYf+/PXxQzZME/4ObXG
 I2lJPS7LuLIFg==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.65
Subject: Re: [Qemu-devel] [PATCH v7 09/13] vfio: Add save state functions to
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



On 7/17/2019 8:20 AM, Yan Zhao wrote:
> On Tue, Jul 09, 2019 at 05:49:16PM +0800, Kirti Wankhede wrote:
>> Added .save_live_pending, .save_live_iterate and .save_live_complete_precopy
>> functions. These functions handles pre-copy and stop-and-copy phase.
>>
>> In _SAVING|_RUNNING device state or pre-copy phase:
>> - read pending_bytes
>> - read data_offset - indicates kernel driver to write data to staging
>>   buffer which is mmapped.
>> - read data_size - amount of data in bytes written by vendor driver in migration
>>   region.
>> - if data section is trapped, pread() from data_offset of data_size.
>> - if data section is mmaped, read mmaped buffer of data_size.
>> - Write data packet to file stream as below:
>> {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
>> VFIO_MIG_FLAG_END_OF_STATE }
>>
>> In _SAVING device state or stop-and-copy phase
>> a. read config space of device and save to migration file stream. This
>>    doesn't need to be from vendor driver. Any other special config state
>>    from driver can be saved as data in following iteration.
>> b. read pending_bytes
>> c. read data_offset - indicates kernel driver to write data to staging
>>    buffer which is mmapped.
>> d. read data_size - amount of data in bytes written by vendor driver in
>>    migration region.
>> e. if data section is trapped, pread() from data_offset of data_size.
>> f. if data section is mmaped, read mmaped buffer of data_size.
>> g. Write data packet as below:
>>    {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data}
>> h. iterate through steps b to g while (pending_bytes > 0)
>> i. Write {VFIO_MIG_FLAG_END_OF_STATE}
>>
>> When data region is mapped, its user's responsibility to read data from
>> data_offset of data_size before moving to next steps.
>>
> each iteration, vendor driver has to set data_offset for device data once
> and for dirty page once. it's really cumbersome.

This should be done so that vendor driver has the flexibility to decide
whether to have data in trapped region or mmapped region. For example,
device data can be in mmapped region and dirty pages data in trapped region.

> could dirty page and device data use different data_offset? e.g.
> data_offset, dirty_page_offset? or just keep them constant after being
> read first time?
> 

Reading device data and dirty page bitmap are atomic operations since
same region can be used to share those. Then having different variable
for both seems redundant.

Later option was discussion in v4 version and we decided not to assume
data_offset for each iteration
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05223.html

Thanks,
Kirti

>> .save_live_iterate runs outside the iothread lock in the migration case, which
>> could race with asynchronous call to get dirty page list causing data corruption
>> in mapped migration region. Mutex added here to serial migration buffer read
>> operation.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>  hw/vfio/migration.c  | 246 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/vfio/trace-events |   6 ++
>>  2 files changed, 252 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 0597a45fda2d..4e9b4cce230b 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -117,6 +117,138 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
>>      return 0;
>>  }
>>  
>> +static void *find_data_region(VFIORegion *region,
>> +                              uint64_t data_offset,
>> +                              uint64_t data_size)
>> +{
>> +    void *ptr = NULL;
>> +    int i;
>> +
>> +    for (i = 0; i < region->nr_mmaps; i++) {
>> +        if ((data_offset >= region->mmaps[i].offset) &&
>> +            (data_offset < region->mmaps[i].offset + region->mmaps[i].size) &&
>> +            (data_size <= region->mmaps[i].size)) {
>> +            ptr = region->mmaps[i].mmap + (data_offset -
>> +                                           region->mmaps[i].offset);
>> +            break;
>> +        }
>> +    }
>> +    return ptr;
>> +}
>> +
>> +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIORegion *region = &migration->region.buffer;
>> +    uint64_t data_offset = 0, data_size = 0;
>> +    int ret;
>> +
>> +    ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                                             data_offset));
>> +    if (ret != sizeof(data_offset)) {
>> +        error_report("%s: Failed to get migration buffer data offset %d",
>> +                     vbasedev->name, ret);
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = pread(vbasedev->fd, &data_size, sizeof(data_size),
>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                                             data_size));
>> +    if (ret != sizeof(data_size)) {
>> +        error_report("%s: Failed to get migration buffer data size %d",
>> +                     vbasedev->name, ret);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (data_size > 0) {
>> +        void *buf = NULL;
>> +        bool buffer_mmaped;
>> +
>> +        if (region->mmaps) {
>> +            buf = find_data_region(region, data_offset, data_size);
>> +        }
>> +
>> +        buffer_mmaped = (buf != NULL) ? true : false;
>> +
>> +        if (!buffer_mmaped) {
>> +            buf = g_try_malloc0(data_size);
>> +            if (!buf) {
>> +                error_report("%s: Error allocating buffer ", __func__);
>> +                return -ENOMEM;
>> +            }
>> +
>> +            ret = pread(vbasedev->fd, buf, data_size,
>> +                        region->fd_offset + data_offset);
>> +            if (ret != data_size) {
>> +                error_report("%s: Failed to get migration data %d",
>> +                             vbasedev->name, ret);
>> +                g_free(buf);
>> +                return -EINVAL;
>> +            }
>> +        }
>> +
>> +        qemu_put_be64(f, data_size);
>> +        qemu_put_buffer(f, buf, data_size);
>> +
>> +        if (!buffer_mmaped) {
>> +            g_free(buf);
>> +        }
>> +        migration->pending_bytes -= data_size;
>> +    } else {
>> +        qemu_put_be64(f, data_size);
>> +    }
>> +
>> +    trace_vfio_save_buffer(vbasedev->name, data_offset, data_size,
>> +                           migration->pending_bytes);
>> +
>> +    ret = qemu_file_get_error(f);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    return data_size;
>> +}
>> +
>> +static int vfio_update_pending(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIORegion *region = &migration->region.buffer;
>> +    uint64_t pending_bytes = 0;
>> +    int ret;
>> +
>> +    ret = pread(vbasedev->fd, &pending_bytes, sizeof(pending_bytes),
>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                                             pending_bytes));
>> +    if ((ret < 0) || (ret != sizeof(pending_bytes))) {
>> +        error_report("%s: Failed to get pending bytes %d",
>> +                     vbasedev->name, ret);
>> +        migration->pending_bytes = 0;
>> +        return (ret < 0) ? ret : -EINVAL;
>> +    }
>> +
>> +    migration->pending_bytes = pending_bytes;
>> +    trace_vfio_update_pending(vbasedev->name, pending_bytes);
>> +    return 0;
>> +}
>> +
>> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
>> +
>> +    if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
>> +        vbasedev->ops->vfio_save_config(vbasedev, f);
>> +    }
>> +
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> +
>> +    trace_vfio_save_device_config_state(vbasedev->name);
>> +
>> +    return qemu_file_get_error(f);
>> +}
>> +
>>  /* ---------------------------------------------------------------------- */
>>  
>>  static int vfio_save_setup(QEMUFile *f, void *opaque)
>> @@ -178,9 +310,123 @@ static void vfio_save_cleanup(void *opaque)
>>      trace_vfio_save_cleanup(vbasedev->name);
>>  }
>>  
>> +static void vfio_save_pending(QEMUFile *f, void *opaque,
>> +                              uint64_t threshold_size,
>> +                              uint64_t *res_precopy_only,
>> +                              uint64_t *res_compatible,
>> +                              uint64_t *res_postcopy_only)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret;
>> +
>> +    ret = vfio_update_pending(vbasedev);
>> +    if (ret) {
>> +        return;
>> +    }
>> +
>> +    *res_precopy_only += migration->pending_bytes;
>> +
>> +    trace_vfio_save_pending(vbasedev->name, *res_precopy_only,
>> +                            *res_postcopy_only, *res_compatible);
>> +}
>> +
>> +static int vfio_save_iterate(QEMUFile *f, void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret, data_size;
>> +
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
>> +
>> +    qemu_mutex_lock(&migration->lock);
>> +    data_size = vfio_save_buffer(f, vbasedev);
>> +    qemu_mutex_unlock(&migration->lock);
>> +
>> +    if (data_size < 0) {
>> +        error_report("%s: vfio_save_buffer failed %s", vbasedev->name,
>> +                     strerror(errno));
>> +        return data_size;
>> +    }
>> +
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> +
>> +    ret = qemu_file_get_error(f);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    trace_vfio_save_iterate(vbasedev->name, data_size);
>> +    if (data_size == 0) {
>> +        /* indicates data finished, goto complete phase */
>> +        return 1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret;
>> +
>> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_SAVING);
> I think this state is already set in vm state change handler, where
> ~VFIO_DEVICE_STATE_RUNNING is applied to (VFIO_DEVICE_STATE_RUNNING | VFIO_DEVICE_STATE_SAVING).
> 
> Why VFIO_DEVICE_STATE_SAVING is redundantly set here?

Ok, I'll remove and verify it.

Thanks,
Kirti

> 
>> +    if (ret) {
>> +        error_report("%s: Failed to set state STOP and SAVING",
>> +                     vbasedev->name);
>> +        return ret;
>> +    }
>> +
>> +    ret = vfio_save_device_config_state(f, opaque);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    ret = vfio_update_pending(vbasedev);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    while (migration->pending_bytes > 0) {
>> +        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
>> +        ret = vfio_save_buffer(f, vbasedev);
>> +        if (ret < 0) {
>> +            error_report("%s: Failed to save buffer", vbasedev->name);
>> +            return ret;
>> +        } else if (ret == 0) {
>> +            break;
>> +        }
>> +
>> +        ret = vfio_update_pending(vbasedev);
>> +        if (ret) {
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> +
>> +    ret = qemu_file_get_error(f);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    ret = vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_MASK);
> This state is a little weird.
> 
> Thanks
> Yan
>> +    if (ret) {
>> +        error_report("%s: Failed to set state STOPPED", vbasedev->name);
>> +        return ret;
>> +    }
>> +
>> +    trace_vfio_save_complete_precopy(vbasedev->name);
>> +    return ret;
>> +}
>> +
>>  static SaveVMHandlers savevm_vfio_handlers = {
>>      .save_setup = vfio_save_setup,
>>      .save_cleanup = vfio_save_cleanup,
>> +    .save_live_pending = vfio_save_pending,
>> +    .save_live_iterate = vfio_save_iterate,
>> +    .save_live_complete_precopy = vfio_save_complete_precopy,
>>  };
>>  
>>  /* ---------------------------------------------------------------------- */
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 4bb43f18f315..bdf40ba368c7 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -151,3 +151,9 @@ vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_st
>>  vfio_migration_state_notifier(char *name, int state) " (%s) state %d"
>>  vfio_save_setup(char *name) " (%s)"
>>  vfio_save_cleanup(char *name) " (%s)"
>> +vfio_save_buffer(char *name, uint64_t data_offset, uint64_t data_size, uint64_t pending) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64" pending 0x%"PRIx64
>> +vfio_update_pending(char *name, uint64_t pending) " (%s) pending 0x%"PRIx64
>> +vfio_save_device_config_state(char *name) " (%s)"
>> +vfio_save_pending(char *name, uint64_t precopy, uint64_t postcopy, uint64_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible 0x%"PRIx64
>> +vfio_save_iterate(char *name, int data_size) " (%s) data_size %d"
>> +vfio_save_complete_precopy(char *name) " (%s)"
>> -- 
>> 2.7.0
>>

