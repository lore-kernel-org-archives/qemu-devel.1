Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FBFC7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 18:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFEA3208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 18:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="B/jZ9/43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEA3208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoBPV-00032g-SZ
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 14:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50977)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hoBPJ-0002cs-Sx
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 14:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hoBPI-0001Vw-Io
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 14:45:33 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6223)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hoBPI-0001VA-9n
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 14:45:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d30be510000>; Thu, 18 Jul 2019 11:45:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 18 Jul 2019 11:45:30 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 18 Jul 2019 11:45:30 -0700
Received: from [10.24.71.22] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jul
 2019 18:45:19 +0000
To: Yan Zhao <yan.y.zhao@intel.com>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-10-git-send-email-kwankhede@nvidia.com>
 <20190712024423.GG9176@joy-OptiPlex-7040>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <21d44d43-4d17-937c-6224-32455ab710ee@nvidia.com>
Date: Fri, 19 Jul 2019 00:15:15 +0530
MIME-Version: 1.0
In-Reply-To: <20190712024423.GG9176@joy-OptiPlex-7040>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1563475537; bh=NQARAXoB41Kwj6+Sq5zE0xu0zGTqVSscgR8C0D0MgeI=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=B/jZ9/43sqRi7snWUGsF7kcKT6Fs1ZMRBiVu02h64MCrFXwLJjGmgUlSOWBdl4yHM
 LH9KUJRIIQKBUklB+jwOk7cOBvGSLguC3oBjhWSxatOH04+jn0vHoQFXssaIhOxZol
 Tg30v2OHGsgnBdy5vVac0K1AwrFl1sXiJFiZQMX8NrQHcNDwt7PAWA5MI7ADixqSmT
 6GuTT2Gh9PFC6DsbyIgmxaIMMF9oQTLI4tsPiHglXbagwwzp9jKoudBekASXDsemwF
 GQ+7db2WvaXZJLwolhAIihGQyw9dd1orDg4mfhHULyYJp8Nh/lSUM5PwJAONrPrLDf
 z0RGHq2/RvFpA==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.64
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



On 7/12/2019 8:14 AM, Yan Zhao wrote:
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
> This line "migration->pending_bytes -= data_size;" is not necessary, as
> it will be updated anyway in vfio_update_pending()
> 

Right, removing it.

Thanks,
Kirti


