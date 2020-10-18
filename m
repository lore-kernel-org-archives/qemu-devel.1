Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC60C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 17:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E1522080D
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 17:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RVUJ0i/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1522080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUCi5-0003Kx-8K
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 13:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kUCg7-0002RI-Iq
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 13:41:08 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kUCg1-0007N4-8w
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 13:41:07 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8c7e1e0000>; Sun, 18 Oct 2020 10:40:46 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 18 Oct
 2020 17:40:44 +0000
Subject: Re: [PATCH v26 07/17] vfio: Register SaveVMHandlers for VFIO device
To: Alex Williamson <alex.williamson@redhat.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-8-git-send-email-kwankhede@nvidia.com>
 <20200925142046.7c9eca89@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <9e965cfb-f5f9-aa88-32c8-8623ee917529@nvidia.com>
Date: Sun, 18 Oct 2020 23:10:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925142046.7c9eca89@x1.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603042846; bh=EDJ/D6M5/4FSlcAnB1s3zU9GibIQUX4lGrRTwwnjp2E=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=RVUJ0i/jhkRXpFWv91ymSM2Ab2PLyNBRJTHuPluGvxKNs7vdYH2gFGX4UihGHFa9Y
 U+RU5ktuVCYPIuNbP+m2m2b7qCqD+vKPTYwRTVGGMGx0LFkj2zPWAFL0goGKgY4kyr
 WaZ3i4rbmSfjUieIQa/dQswWYghP3jZraImsNi4vkRBsZ8lPvBf98gZiXZvYjawzYx
 ajNDP7oRWLQ5xe2bNmN8JNoZffgsLxUZFYPkvo4M75SIzZDhvhE1jEcF9ywOqcZwoz
 eUH/APwwKEkOVtUbyMLOqDQ7hc/ZyJAFPjtDoH0mWA0uukdD9TaFzAbDp9Q7u108Nt
 cQxXYF6g9t1fg==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 13:40:59
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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



On 9/26/2020 1:50 AM, Alex Williamson wrote:
> On Wed, 23 Sep 2020 04:54:09 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
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
>>   hw/vfio/migration.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events |  2 ++
>>   2 files changed, 93 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index f650fe9fc3c8..8e8adaa25779 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -8,12 +8,15 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> +#include "qemu/main-loop.h"
>> +#include "qemu/cutils.h"
>>   #include <linux/vfio.h>
>>   
>>   #include "sysemu/runstate.h"
>>   #include "hw/vfio/vfio-common.h"
>>   #include "cpu.h"
>>   #include "migration/migration.h"
>> +#include "migration/vmstate.h"
>>   #include "migration/qemu-file.h"
>>   #include "migration/register.h"
>>   #include "migration/blocker.h"
>> @@ -25,6 +28,17 @@
>>   #include "trace.h"
>>   #include "hw/hw.h"
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
>>   static inline int vfio_mig_access(VFIODevice *vbasedev, void *val, int count,
>>                                     off_t off, bool iswrite)
>>   {
>> @@ -166,6 +180,65 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
>>       return 0;
>>   }
>>   
>> +/* ---------------------------------------------------------------------- */
>> +
>> +static int vfio_save_setup(QEMUFile *f, void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret;
>> +
>> +    trace_vfio_save_setup(vbasedev->name);
>> +
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>> +
>> +    if (migration->region.mmaps) {
>> +        qemu_mutex_lock_iothread();
>> +        ret = vfio_region_mmap(&migration->region);
>> +        qemu_mutex_unlock_iothread();
> 
> Please add a comment identifying why the iothread mutex lock is
> necessary here.
> 
>> +        if (ret) {
>> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
>> +                         vbasedev->name, migration->region.nr,
> 
> We don't support multiple migration regions, is it useful to include
> the region index here?
> 

Ok. Removing region.nr


>> +                         strerror(-ret));
>> +            error_report("%s: Falling back to slow path", vbasedev->name);
>> +        }
>> +    }
>> +
>> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_MASK,
>> +                                   VFIO_DEVICE_STATE_SAVING);
>> +    if (ret) {
>> +        error_report("%s: Failed to set state SAVING", vbasedev->name);
>> +        return ret;
>> +    }
> 
> Again, doesn't match the function semantics that success only means the
> device is in a non-error state, maybe the one that was asked for.
> 

Fixed in patch 05.

>> +
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> 
> What's the overall purpose of writing these markers into the migration
> stream?  vfio_load_state() doesn't do anything with this other than
> validate that the end-of-state immediately follows.  Is this a
> placeholder for something in the future?
> 

Its not placeholder, it is used in vfio_load_state() to determine upto 
what point to loop to fetch data for each state, otherwise how would we 
know when to stop reading data from stream for that VFIO device.

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
>> +    if (migration->region.mmaps) {
>> +        vfio_region_unmap(&migration->region);
>> +    }
>> +    trace_vfio_save_cleanup(vbasedev->name);
>> +}
>> +
>> +static SaveVMHandlers savevm_vfio_handlers = {
>> +    .save_setup = vfio_save_setup,
>> +    .save_cleanup = vfio_save_cleanup,
>> +};
>> +
>> +/* ---------------------------------------------------------------------- */
>> +
>>   static void vfio_vmstate_change(void *opaque, int running, RunState state)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> @@ -225,6 +298,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>>                                  struct vfio_region_info *info)
>>   {
>>       int ret = -EINVAL;
>> +    char id[256] = "";
>> +    Object *obj;
>>   
>>       if (!vbasedev->ops->vfio_get_object) {
>>           return ret;
>> @@ -241,6 +316,22 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>>           return ret;
>>       }
>>   
>> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
>> +
>> +    if (obj) {
>> +        DeviceState *dev = DEVICE(obj);
>> +        char *oid = vmstate_if_get_id(VMSTATE_IF(dev));
>> +
>> +        if (oid) {
>> +            pstrcpy(id, sizeof(id), oid);
>> +            pstrcat(id, sizeof(id), "/");
>> +            g_free(oid);
>> +        }
>> +    }
> 
> Here's where vfio_migration_init() starts using vfio_get_object() as I
> referenced back on patch 04.  We might as well get the object before
> calling vfio_migration_region_init() and then pass the object.  The
> conditional branch to handle obj is strange here too, it's fatal if
> vfio_migration_region_init() doesn't find an object, why do we handle
> it as optional here?  Also, what is this doing?  Comments would be
> nice...  Thanks,
> 

Changing it as I mentioned in other patch reply.

Thanks.

> Alex
> 
>> +    pstrcat(id, sizeof(id), "vfio");
>> +
>> +    register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
>> +                         vbasedev);
>>       vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>>                                                             vbasedev);
>>       vbasedev->migration_state.notify = vfio_migration_state_notifier;
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index bcb3fa7314d7..982d8dccb219 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -152,3 +152,5 @@ vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
>>   vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
>>   vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
>>   vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
>> +vfio_save_setup(const char *name) " (%s)"
>> +vfio_save_cleanup(const char *name) " (%s)"
> 

