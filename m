Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5CEC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 20:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE69D20656
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 20:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dIJGP/iZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE69D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0AhK-0005Ex-0G
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 16:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1i0AgX-0004Q3-Ad
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1i0AgU-0007SD-N7
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:24:51 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13371)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1i0AgU-0007PM-Cl
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:24:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d5c570f0000>; Tue, 20 Aug 2019 13:24:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 20 Aug 2019 13:24:47 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 20 Aug 2019 13:24:47 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 20:24:47 +0000
Received: from [10.24.71.106] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 20:24:37 +0000
To: Yan Zhao <yan.y.zhao@intel.com>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-8-git-send-email-kwankhede@nvidia.com>
 <20190717022513.GD8912@joy-OptiPlex-7040>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <4dfe05df-288c-9840-ddfa-347cb9fa1ac0@nvidia.com>
Date: Wed, 21 Aug 2019 01:54:27 +0530
MIME-Version: 1.0
In-Reply-To: <20190717022513.GD8912@joy-OptiPlex-7040>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1566332687; bh=XywdVEgKom6AjuMEGOzlbFJi8M/k/20LZk3JfpR2UOg=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=dIJGP/iZDwsGN+MmM5SVlk4I2kzKvq8OeVZDSBZC9tPDH+e1dJnl1g96Xg8SmRTjP
 vtsxAzx+dOxq+M/Wnd+ofud42C5FNB4M0MkXxJaG0lRnfPFK1UzH+kM0ytLS++jIqh
 Ww1gQy9aAv0jptXs1Ga/Pbf3vjb9Ncq0TmvfDPV8/JVCVmN+hqdmEFWV7xqpKc8eKS
 q2qqS71ZagGgY9i1yonPoKrSDO7xKf25r0+yKL4Uc9BD6RKJWcNvZyooq1jsgCyUvw
 ijtKil2yWoMjqLkSRGaZnJ/3N1xwD6/Z5KGXbJyR+U1jBMHGYoNCU9JvTvtcTZkzXJ
 EOY2ErtTV3+rQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.65
Subject: Re: [Qemu-devel] [PATCH v7 07/13] vfio: Add migration state change
 notifier
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



On 7/17/2019 7:55 AM, Yan Zhao wrote:
> On Tue, Jul 09, 2019 at 05:49:14PM +0800, Kirti Wankhede wrote:
>> Added migration state change notifier to get notification on migration state
>> change. These states are translated to VFIO device state and conveyed to vendor
>> driver.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>  hw/vfio/migration.c           | 54 +++++++++++++++++++++++++++++++++++++++++++
>>  hw/vfio/trace-events          |  1 +
>>  include/hw/vfio/vfio-common.h |  1 +
>>  3 files changed, 56 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index c01f08b659d0..e4a89a6f9bc7 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -132,6 +132,53 @@ static void vfio_vmstate_change(void *opaque, int running, RunState state)
>>      }
>>  }
>>  
>> +static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>> +{
>> +    MigrationState *s = data;
>> +    VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);
>> +    int ret;
>> +
>> +    trace_vfio_migration_state_notifier(vbasedev->name, s->state);
>> +
>> +    switch (s->state) {
>> +    case MIGRATION_STATUS_ACTIVE:
>> +        if (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING) {
>> +            if (vbasedev->vm_running) {
>> +                ret = vfio_migration_set_state(vbasedev,
>> +                          VFIO_DEVICE_STATE_RUNNING | VFIO_DEVICE_STATE_SAVING);
>> +                if (ret) {
>> +                    error_report("%s: Failed to set state RUNNING and SAVING",
>> +                                  vbasedev->name);
>> +                }
>> +            } else {
>> +                ret = vfio_migration_set_state(vbasedev,
>> +                                               VFIO_DEVICE_STATE_SAVING);
>> +                if (ret) {
>> +                    error_report("%s: Failed to set state STOP and SAVING",
>> +                                 vbasedev->name);
>> +                }
>> +            }
>> +        } else {
>> +            ret = vfio_migration_set_state(vbasedev,
>> +                                           VFIO_DEVICE_STATE_RESUMING);
>> +            if (ret) {
>> +                error_report("%s: Failed to set state RESUMING",
>> +                             vbasedev->name);
>> +            }
>> +        }
>> +        return;
>> +
> hi Kirti
> currently, migration state notifiers are only notified in below 3 interfaces:
> migrate_fd_connect, migrate_fd_cleanup, postcopy_start, where
> MIGRATION_STATUS_ACTIVE is not an valid state.
> Have you tested the above code? what's the purpose of the code?
> 

Sorry for delayed response.

migration_iteration_finish() -> qemu_bh_schedule(s->cleanup_bh) which is
migrate_fd_cleanup().

migration_iteration_finish() can be called with MIGRATION_STATUS_ACTIVE
state. So migration state notifiers can be called with
MIGRATION_STATUS_ACTIVE. So handled that case here.


Thanks,
Kirti


> Thanks
> Yan
> 
>> +    case MIGRATION_STATUS_CANCELLING:
>> +    case MIGRATION_STATUS_CANCELLED:
>> +    case MIGRATION_STATUS_FAILED:
>> +        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
>> +        if (ret) {
>> +            error_report("%s: Failed to set state RUNNING", vbasedev->name);
>> +        }
>> +        return;
>> +    }
>> +}
>> +
>>  static int vfio_migration_init(VFIODevice *vbasedev,
>>                                 struct vfio_region_info *info)
>>  {
>> @@ -152,6 +199,9 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>>      vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>>                                                            vbasedev);
>>  
>> +    vbasedev->migration_state.notify = vfio_migration_state_notifier;
>> +    add_migration_state_change_notifier(&vbasedev->migration_state);
>> +
>>      return 0;
>>  }
>>  
>> @@ -194,6 +244,10 @@ void vfio_migration_finalize(VFIODevice *vbasedev)
>>          return;
>>      }
>>  
>> +    if (vbasedev->migration_state.notify) {
>> +        remove_migration_state_change_notifier(&vbasedev->migration_state);
>> +    }
>> +
>>      if (vbasedev->vm_state) {
>>          qemu_del_vm_change_state_handler(vbasedev->vm_state);
>>      }
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 3d15bacd031a..69503228f20e 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -148,3 +148,4 @@ vfio_display_edid_write_error(void) ""
>>  vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
>>  vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
>>  vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
>> +vfio_migration_state_notifier(char *name, int state) " (%s) state %d"
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index f6c70db3a9c1..a022484d2636 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -128,6 +128,7 @@ typedef struct VFIODevice {
>>      uint32_t device_state;
>>      VMChangeStateEntry *vm_state;
>>      int vm_running;
>> +    Notifier migration_state;
>>  } VFIODevice;
>>  
>>  struct VFIODeviceOps {
>> -- 
>> 2.7.0
>>

