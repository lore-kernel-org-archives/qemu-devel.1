Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2982C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 14:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C8E2086D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 14:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="T1c857IW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C8E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgVS3-0003p6-VL
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 10:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49335)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hgVR4-0003N3-TW
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hgVR3-0004wg-Hp
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:31:38 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hgVR3-0004uM-7a
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:31:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d14d3450000>; Thu, 27 Jun 2019 07:31:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 27 Jun 2019 07:31:34 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 27 Jun 2019 07:31:34 -0700
Received: from [10.24.71.89] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Jun
 2019 14:31:25 +0000
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-8-git-send-email-kwankhede@nvidia.com>
 <20190627100157.GC2751@work-vm>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <f7fb8dc2-84de-afd1-b2ea-223b2b6b8311@nvidia.com>
Date: Thu, 27 Jun 2019 20:01:20 +0530
MIME-Version: 1.0
In-Reply-To: <20190627100157.GC2751@work-vm>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561645893; bh=mbg79OTnUdTvXnKbC2TZTrEbBn3OTC9Dh3mIkdJu4V4=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=T1c857IWiz4ZOQ5g79ce2qyeFkv6go9uclzUVmsorBKNAB01432RDEscZznyj1/Vy
 +/w7ylrUOk+i4AyBqdpFBRlPNXGbCeWQDZ0nHmvOFmO2ym8oDkrpQFAVmOUFB3pRIj
 r+kXhPn/RqGkrrtaUW/BGPkLAJZ/wPj5XFL0rmBv80tsNdFDxcFSCtPKclkn8bCR4l
 BulZrPkhQQ/vSkXHhrc8YPehSkZ3dJchbBOgWsYfijYLoEcYhehHJXGI8vPq8y3Z9o
 m6jWhZA9XrF7Q+wknBTEsDgQUvDmO/M/BzDa6hekwwRaapywPBcNzkAdmRW6kx5378
 vZ1Ts8vjdUCvA==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.65
Subject: Re: [Qemu-devel] [PATCH v4 07/13] vfio: Register SaveVMHandlers for
 VFIO device
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



On 6/27/2019 3:31 PM, Dr. David Alan Gilbert wrote:
> * Kirti Wankhede (kwankhede@nvidia.com) wrote:
>> Define flags to be used as delimeter in migration file stream.
>> Added .save_setup and .save_cleanup functions. Mapped & unmapped migration
>> region from these functions at source during saving or pre-copy phase.
>> Set VFIO device state depending on VM's state. During live migration, VM is
>> running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
>> device. During save-restore, VM is paused, _SAVING state is set for VFIO device.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>  hw/vfio/migration.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 75 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 7f9858e6c995..fe0887c27664 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -22,6 +22,17 @@
>>  #include "exec/ram_addr.h"
>>  #include "pci.h"
>>  
>> +/*
>> + * Flags used as delimiter:
>> + * 0xffffffff => MSB 32-bit all 1s
>> + * 0xef10     => emulated (virtual) function IO
>> + * 0x0000     => 16-bits reserved for flags
>> + */
>> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
>> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
>> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
>> +
>>  static void vfio_migration_region_exit(VFIODevice *vbasedev)
>>  {
>>      VFIOMigration *migration = vbasedev->migration;
>> @@ -96,6 +107,69 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
>>      return 0;
>>  }
>>  
>> +/* ---------------------------------------------------------------------- */
>> +
>> +static int vfio_save_setup(QEMUFile *f, void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret;
>> +
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>> +
>> +    if (migration->region.buffer.mmaps) {
>> +        qemu_mutex_lock_iothread();
>> +        ret = vfio_region_mmap(&migration->region.buffer);
>> +        qemu_mutex_unlock_iothread();
>> +        if (ret) {
>> +            error_report("Failed to mmap VFIO migration region %d: %s",
>> +                         migration->region.index, strerror(-ret));
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    if (vbasedev->vm_running) {
>> +        ret = vfio_migration_set_state(vbasedev,
>> +                         VFIO_DEVICE_STATE_RUNNING | VFIO_DEVICE_STATE_SAVING);
>> +        if (ret) {
>> +            error_report("Failed to set state RUNNING and SAVING");
>> +            return ret;
>> +        }
>> +    } else {
>> +        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_SAVING);
>> +        if (ret) {
>> +            error_report("Failed to set state STOP and SAVING");
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
>> +    return 0;
>> +}
>> +
>> +static void vfio_save_cleanup(void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    if (migration->region.buffer.mmaps) {
>> +        vfio_region_unmap(&migration->region.buffer);
>> +    }
>> +}
>> +
>> +static SaveVMHandlers savevm_vfio_handlers = {
>> +    .save_setup = vfio_save_setup,
>> +    .save_cleanup = vfio_save_cleanup,
>> +};
>> +
>> +/* ---------------------------------------------------------------------- */
>> +
>>  static void vfio_vmstate_change(void *opaque, int running, RunState state)
>>  {
>>      VFIODevice *vbasedev = opaque;
>> @@ -169,7 +243,7 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>>      }
>>  
>>      qemu_mutex_init(&vbasedev->migration->lock);
>> -
>> +    register_savevm_live(NULL, "vfio", -1, 1, &savevm_vfio_handlers, vbasedev);
> 
> Does this work OK with multiple devices?

Yes. Tested with multiple vGPU devices.

> I think I'd expected you to pass a DeviceState as the first parameter
> for a real device like vfio.
> 'ram' and 'block' don't need to because they iterate over all RAM
> devices inside their save_setup's and similar handlers;  for vfio I'd
> expect it to be per-device.

I do see handlers called per-device. I'll check passing DeviceState as
first parameter.

Thanks,
Kirti

> 
> Dave
> 
>>      vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>>                                                            vbasedev);
>>  
>> -- 
>> 2.7.0
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

