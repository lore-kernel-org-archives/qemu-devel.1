Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E5DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39F32064C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UaaZ0EoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39F32064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVkUW-00059Y-Rs
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 19:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkN9-0002BM-PT
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:19:39 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkN7-0007kC-D3
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:19:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eb0a2ee0000>; Mon, 04 May 2020 16:19:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 04 May 2020 16:19:23 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 04 May 2020 16:19:23 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 23:19:23 +0000
Received: from [10.40.101.152] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May 2020
 23:19:14 +0000
Subject: Re: [PATCH v16 QEMU 08/16] vfio: Register SaveVMHandlers for VFIO
 device
To: Alex Williamson <alex.williamson@redhat.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-9-git-send-email-kwankhede@nvidia.com>
 <20200325150248.6661e1bd@w520.home>
From: Kirti Wankhede <kwankhede@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a3a082a4-cc2f-b84b-60c6-a20f86528a6d@nvidia.com>
Date: Tue, 5 May 2020 04:49:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325150248.6661e1bd@w520.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1588634351; bh=0+sMe2MG5LwyVI4NFvLUrNNK0BjHbF2v/an/kuE70TY=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=UaaZ0EoX6Uy2hsgepphQHZ/uUVWjJq1emBDPr1awnh9IQ+S+CdPsDVpqiDg3H7Mvc
 Qqz4Q6hEewcMfbDOECGpZjR8XghTVb22Q1xD2QgjSYt2B0Q5vN6duA1WqKLU1GSxxg
 sq0qn02+NrqBUFjvBHxSad8EJN1i3Bcfw0d9MvP2DBpLWiqW3RJBChecHmm3PLws2m
 cx+nTbQth7SuPdXxHgizxh1NU/P3pwGBgmMsvkLqKQ9ITN+ANbpvQvt7fYVdqE/mvU
 1KPOxbNOQUD/gWlWA/w4Ehwu1DrjS4mQ1+JWtVhzUS1W3nARa3p7HgEGF9/CRLIuf8
 dDmhG6SCfT+oQ==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 19:18:18
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/26/2020 2:32 AM, Alex Williamson wrote:
> On Wed, 25 Mar 2020 02:39:06 +0530
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
>>   hw/vfio/migration.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events |  2 ++
>>   2 files changed, 78 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 22ded9d28cf3..033f76526e49 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -8,6 +8,7 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> +#include "qemu/main-loop.h"
>>   #include <linux/vfio.h>
>>   
>>   #include "sysemu/runstate.h"
>> @@ -24,6 +25,17 @@
>>   #include "pci.h"
>>   #include "trace.h"
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
>>   static void vfio_migration_region_exit(VFIODevice *vbasedev)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>> @@ -126,6 +138,69 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
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
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>> +
>> +    if (migration->region.mmaps) {
>> +        qemu_mutex_lock_iothread();
>> +        ret = vfio_region_mmap(&migration->region);
>> +        qemu_mutex_unlock_iothread();
>> +        if (ret) {
>> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
>> +                         vbasedev->name, migration->region.index,
>> +                         strerror(-ret));
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    ret = vfio_migration_set_state(vbasedev, ~0, VFIO_DEVICE_STATE_SAVING);
>> +    if (ret) {
>> +        error_report("%s: Failed to set state SAVING", vbasedev->name);
>> +        return ret;
>> +    }
>> +
>> +    /*
>> +     * Save migration region size. This is used to verify migration region size
>> +     * is greater than or equal to migration region size at destination
>> +     */
>> +    qemu_put_be64(f, migration->region.size);
> 
> Is this requirement supported by the uapi?  

Yes, on UAPI thread we discussed this:

  * For the user application, data is opaque. The user application 
should write
  * data in the same order as the data is received and the data should be of
  * same transaction size at the source.

data should be same transaction size, so migration region size should be 
greater than or equal to the size at source when verifying at destination.

> The vendor driver operates
> within the migration region, but it has no requirement to use the full
> extent of the region.  Shouldn't we instead insert the version string
> from versioning API Yan proposed?  Is this were we might choose to use
> an interface via the vfio API rather than sysfs if we had one?
>

VFIO API cannot be used by libvirt or management tool stack. We need 
sysfs as Yan proposed to be used by libvirt or management tool stack.

Thanks,
Kirti

>> +
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> +
>> +    ret = qemu_file_get_error(f);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    trace_vfio_save_setup(vbasedev->name);
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
>> @@ -191,6 +266,7 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>>           return ret;
>>       }
>>   
>> +    register_savevm_live("vfio", -1, 1, &savevm_vfio_handlers, vbasedev);
>>       vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>>                                                             vbasedev);
>>   
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 69503228f20e..4bb43f18f315 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -149,3 +149,5 @@ vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
>>   vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
>>   vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
>>   vfio_migration_state_notifier(char *name, int state) " (%s) state %d"
>> +vfio_save_setup(char *name) " (%s)"
>> +vfio_save_cleanup(char *name) " (%s)"
> 

