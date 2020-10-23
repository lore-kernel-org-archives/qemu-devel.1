Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851E2C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9F720EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="sEwOhzzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9F720EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVuHR-0007HA-6z
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 06:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVuEF-0006IJ-PV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:23:23 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVuEB-0005NG-KI
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:23:23 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f92aee5000c>; Fri, 23 Oct 2020 03:22:29 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Oct
 2020 10:21:16 +0000
Subject: Re: [PATCH v27 17/17] qapi: Add VFIO devices migration stats in
 Migration stats
To: Alex Williamson <alex.williamson@redhat.com>
References: <1603365127-14202-1-git-send-email-kwankhede@nvidia.com>
 <1603365127-14202-18-git-send-email-kwankhede@nvidia.com>
 <20201022161842.30585c2e@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <4caf6f0b-b291-8e73-fa5f-5357c6f194ff@nvidia.com>
Date: Fri, 23 Oct 2020 15:51:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201022161842.30585c2e@w520.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603448549; bh=UhsSn1ZW6BXznN01Ya2ARroLSWrt9aejEMEpApjd9Ug=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=sEwOhzzO8W1ocbFbyccF5yGLfF9xMbLL0jTHJgDJSSwd/coLnEZ+9cqKa5yDa5A4Z
 Zu2d2E5Ax70a84peZgy+f4sG/O2jpN8NQ9987stgaDKz7L3UmMRLUx16N8F5ju5OEx
 o/o9orRXumAQio18TgEKzN5WuikQ9d1vOh6Jx6ao+T3WomDCaGqvSQ86ZvDZIwIjI+
 kNlVs//exlsNEiSfxVFIq8sr5REyGXDGHqy7IQ/p3mRr1zvoCfBXT7uGQcQA+A0vPS
 zKyJk09v6zrrnwfts6AWXAaZLTokGXNaUYYx63emJJH+QPtvvcdBtfH5uesjNiZDr+
 2zq/JVHKez2cg==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 06:23:18
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: cohuck@redhat.com, cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/23/2020 3:48 AM, Alex Williamson wrote:
> On Thu, 22 Oct 2020 16:42:07 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Added amount of bytes transferred to the VM at destination by all VFIO
>> devices
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   hw/vfio/common.c            | 20 ++++++++++++++++++++
>>   hw/vfio/migration.c         | 10 ++++++++++
>>   include/qemu/vfio-helpers.h |  3 +++
>>   migration/migration.c       | 14 ++++++++++++++
>>   monitor/hmp-cmds.c          |  6 ++++++
>>   qapi/migration.json         | 17 +++++++++++++++++
>>   6 files changed, 70 insertions(+)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 9c879e5c0f62..8d0758eda9fa 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -39,6 +39,7 @@
>>   #include "trace.h"
>>   #include "qapi/error.h"
>>   #include "migration/migration.h"
>> +#include "qemu/vfio-helpers.h"
>>   
>>   VFIOGroupList vfio_group_list =
>>       QLIST_HEAD_INITIALIZER(vfio_group_list);
>> @@ -292,6 +293,25 @@ const MemoryRegionOps vfio_region_ops = {
>>    * Device state interfaces
>>    */
>>   
>> +bool vfio_mig_active(void)
>> +{
>> +    VFIOGroup *group;
>> +    VFIODevice *vbasedev;
>> +
>> +    if (QLIST_EMPTY(&vfio_group_list)) {
>> +        return false;
>> +    }
>> +
>> +    QLIST_FOREACH(group, &vfio_group_list, next) {
>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> +            if (vbasedev->migration_blocker) {
>> +                return false;
>> +            }
>> +        }
>> +    }
>> +    return true;
>> +}
>> +
>>   static bool vfio_devices_all_stopped_and_saving(VFIOContainer *container)
>>   {
>>       VFIOGroup *group;
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 77ee60a43ea5..b23e21c6de2b 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -28,6 +28,7 @@
>>   #include "pci.h"
>>   #include "trace.h"
>>   #include "hw/hw.h"
>> +#include "qemu/vfio-helpers.h"
>>   
>>   /*
>>    * Flags to be used as unique delimiters for VFIO devices in the migration
>> @@ -45,6 +46,8 @@
>>   #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>>   #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
>>   
>> +static int64_t bytes_transferred;
>> +
>>   static inline int vfio_mig_access(VFIODevice *vbasedev, void *val, int count,
>>                                     off_t off, bool iswrite)
>>   {
>> @@ -255,6 +258,7 @@ static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev, uint64_t *size)
>>           *size = data_size;
>>       }
>>   
>> +    bytes_transferred += data_size;
>>       return ret;
>>   }
>>   
>> @@ -776,6 +780,7 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>>       case MIGRATION_STATUS_CANCELLING:
>>       case MIGRATION_STATUS_CANCELLED:
>>       case MIGRATION_STATUS_FAILED:
>> +        bytes_transferred = 0;
>>           ret = vfio_migration_set_state(vbasedev,
>>                         ~(VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RESUMING),
>>                         VFIO_DEVICE_STATE_RUNNING);
>> @@ -862,6 +867,11 @@ err:
>>   
>>   /* ---------------------------------------------------------------------- */
>>   
>> +int64_t vfio_mig_bytes_transferred(void)
>> +{
>> +    return bytes_transferred;
>> +}
>> +
>>   int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
>>   {
>>       VFIOContainer *container = vbasedev->group->container;
>> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
>> index 4491c8e1a6e9..7f7a46e6ef2d 100644
>> --- a/include/qemu/vfio-helpers.h
>> +++ b/include/qemu/vfio-helpers.h
>> @@ -29,4 +29,7 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
>>   int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
>>                              int irq_type, Error **errp);
>>   
>> +bool vfio_mig_active(void);
>> +int64_t vfio_mig_bytes_transferred(void);
>> +
>>   #endif
> 
> 
> I don't think vfio-helpers is the right place for this, this header is
> specifically for using util/vfio-helpers.c.  Would
> include/hw/vfio/vfio-common.h work?
> 
> 

Yes, works with CONFIG_VFIO check. Changing it.

>> diff --git a/migration/migration.c b/migration/migration.c
>> index 0575ecb37953..8b2865d25ef4 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -56,6 +56,7 @@
>>   #include "net/announce.h"
>>   #include "qemu/queue.h"
>>   #include "multifd.h"
>> +#include "qemu/vfio-helpers.h"
>>   
>>   #define MAX_THROTTLE  (128 << 20)      /* Migration transfer speed throttling */
>>   
>> @@ -1002,6 +1003,17 @@ static void populate_disk_info(MigrationInfo *info)
>>       }
>>   }
>>   
>> +static void populate_vfio_info(MigrationInfo *info)
>> +{
>> +#ifdef CONFIG_LINUX
> 
> Use CONFIG_VFIO?  I get a build failure on qemu-system-avr
> 
> /usr/bin/ld: /tmp/tmp.3QbqxgbENl/build/../migration/migration.c:1012:
> undefined reference to `vfio_mig_bytes_transferred'.  Thanks,
> 

Ok Changing it.

> Alex
> 
>> +    if (vfio_mig_active()) {
>> +        info->has_vfio = true;
>> +        info->vfio = g_malloc0(sizeof(*info->vfio));
>> +        info->vfio->transferred = vfio_mig_bytes_transferred();
>> +    }
>> +#endif
>> +}
>> +
>>   static void fill_source_migration_info(MigrationInfo *info)
>>   {
>>       MigrationState *s = migrate_get_current();
>> @@ -1026,6 +1038,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>>           populate_time_info(info, s);
>>           populate_ram_info(info, s);
>>           populate_disk_info(info);
>> +        populate_vfio_info(info);
>>           break;
>>       case MIGRATION_STATUS_COLO:
>>           info->has_status = true;
>> @@ -1034,6 +1047,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>>       case MIGRATION_STATUS_COMPLETED:
>>           populate_time_info(info, s);
>>           populate_ram_info(info, s);
>> +        populate_vfio_info(info);
>>           break;
>>       case MIGRATION_STATUS_FAILED:
>>           info->has_status = true;
>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> index 9789f4277f50..56e9bad33d94 100644
>> --- a/monitor/hmp-cmds.c
>> +++ b/monitor/hmp-cmds.c
>> @@ -357,6 +357,12 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>>           }
>>           monitor_printf(mon, "]\n");
>>       }
>> +
>> +    if (info->has_vfio) {
>> +        monitor_printf(mon, "vfio device transferred: %" PRIu64 " kbytes\n",
>> +                       info->vfio->transferred >> 10);
>> +    }
>> +
>>       qapi_free_MigrationInfo(info);
>>   }
>>   
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index a5da513c9e05..3c7582052725 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -147,6 +147,18 @@
>>               'active', 'postcopy-active', 'postcopy-paused',
>>               'postcopy-recover', 'completed', 'failed', 'colo',
>>               'pre-switchover', 'device', 'wait-unplug' ] }
>> +##
>> +# @VfioStats:
>> +#
>> +# Detailed VFIO devices migration statistics
>> +#
>> +# @transferred: amount of bytes transferred to the target VM by VFIO devices
>> +#
>> +# Since: 5.2
>> +#
>> +##
>> +{ 'struct': 'VfioStats',
>> +  'data': {'transferred': 'int' } }
>>   
>>   ##
>>   # @MigrationInfo:
>> @@ -208,11 +220,16 @@
>>   #
>>   # @socket-address: Only used for tcp, to know what the real port is (Since 4.0)
>>   #
>> +# @vfio: @VfioStats containing detailed VFIO devices migration statistics,
>> +#        only returned if VFIO device is present, migration is supported by all
>> +#        VFIO devices and status is 'active' or 'completed' (since 5.2)
>> +#
>>   # Since: 0.14.0
>>   ##
>>   { 'struct': 'MigrationInfo',
>>     'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
>>              '*disk': 'MigrationStats',
>> +           '*vfio': 'VfioStats',
>>              '*xbzrle-cache': 'XBZRLECacheStats',
>>              '*total-time': 'int',
>>              '*expected-downtime': 'int',
> 

