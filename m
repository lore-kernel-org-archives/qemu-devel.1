Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C7CC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 20:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7708122DD3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 20:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="g3p+TgcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7708122DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Arc-00036W-Gi
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 16:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1i0ApU-0001O2-5P
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1i0ApS-0003av-P7
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:34:08 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13863)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1i0ApS-0003aM-GK
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:34:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d5c593d0000>; Tue, 20 Aug 2019 13:34:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 20 Aug 2019 13:34:05 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 20 Aug 2019 13:34:05 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 20:34:05 +0000
Received: from [10.24.71.106] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 20:33:55 +0000
To: Yan Zhao <yan.y.zhao@intel.com>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-7-git-send-email-kwankhede@nvidia.com>
 <20190722083703.GN8912@joy-OptiPlex-7040>
X-Nvconfidentiality: pubic
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <0611522b-7ec2-194a-5ebc-7314b2158cff@nvidia.com>
Date: Wed, 21 Aug 2019 02:03:50 +0530
MIME-Version: 1.0
In-Reply-To: <20190722083703.GN8912@joy-OptiPlex-7040>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1566333245; bh=BdeZvLvZqmYhANfAdHkS+eiTz5NOzD6lm6Dm09hBhSA=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=g3p+TgcIo+4XZ+dlQSEwnce7IB4P809XfRbn4JkP0DM2Vve/CeEAgpPSufvuLwREY
 i4enYfwxZVxl+BIqYkUVQQLsfSzwUZC8fcPw9JSDS8ZlhExV6pdTlMgMmCQDuDuQob
 rK4IyuDpm9T4vdfrhe87SSt3MeVDWYTGgE9gwPun0cqHDmOPCtOyFkgPdvw6Ft1Ykl
 uUvT61NL6T7cZgrYv3FHgo/63DFPamT5kgeiwHXcg13FQrtwBpMVa20Jid3wHTP1pS
 LgwphPDOGy7LMLOcKMWsBMRQFKt/IxaLkhgF47El4j73badvYjEF5Dr6NOXyeg1mC7
 /bEwTU+1n7+7A==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.65
Subject: Re: [Qemu-devel] [PATCH v7 06/13] vfio: Add VM state change handler
 to know state of VM
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



On 7/22/2019 2:07 PM, Yan Zhao wrote:
> On Tue, Jul 09, 2019 at 05:49:13PM +0800, Kirti Wankhede wrote:
>> VM state change handler gets called on change in VM's state. This is used to set
>> VFIO device state to _RUNNING.
>> VM state change handler, migration state change handler and log_sync listener
>> are called asynchronously, which sometimes lead to data corruption in migration
>> region. Initialised mutex that is used to serialize operations on migration data
>> region during saving state.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>  hw/vfio/migration.c           | 64 +++++++++++++++++++++++++++++++++++++++++++
>>  hw/vfio/trace-events          |  2 ++
>>  include/hw/vfio/vfio-common.h |  4 +++
>>  3 files changed, 70 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index a2cfbd5af2e1..c01f08b659d0 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -78,6 +78,60 @@ err:
>>      return ret;
>>  }
>>  
>> +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIORegion *region = &migration->region.buffer;
>> +    uint32_t device_state;
>> +    int ret = 0;
>> +
>> +    device_state = (state & VFIO_DEVICE_STATE_MASK) |
>> +                   (vbasedev->device_state & ~VFIO_DEVICE_STATE_MASK);
>> +
>> +    if ((device_state & VFIO_DEVICE_STATE_MASK) == VFIO_DEVICE_STATE_INVALID) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = pwrite(vbasedev->fd, &device_state, sizeof(device_state),
>> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                                              device_state));
>> +    if (ret < 0) {
>> +        error_report("%s: Failed to set device state %d %s",
>> +                     vbasedev->name, ret, strerror(errno));
>> +        return ret;
>> +    }
>> +
>> +    vbasedev->device_state = device_state;
>> +    trace_vfio_migration_set_state(vbasedev->name, device_state);
>> +    return 0;
>> +}
>> +
>> +static void vfio_vmstate_change(void *opaque, int running, RunState state)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +
>> +    if ((vbasedev->vm_running != running)) {
>> +        int ret;
>> +        uint32_t dev_state;
>> +
>> +        if (running) {
>> +            dev_state = VFIO_DEVICE_STATE_RUNNING;
> should be
> dev_state |= VFIO_DEVICE_STATE_RUNNING; ?
> 

vfio_migration_set_state() takes case of ORing.

Thanks,
Kirti

>> +        } else {
>> +            dev_state = (vbasedev->device_state & VFIO_DEVICE_STATE_MASK) &
>> +                     ~VFIO_DEVICE_STATE_RUNNING;
>> +        }
>> +
>> +        ret = vfio_migration_set_state(vbasedev, dev_state);
>> +        if (ret) {
>> +            error_report("%s: Failed to set device state 0x%x",
>> +                         vbasedev->name, dev_state);
>> +        }
>> +        vbasedev->vm_running = running;
>> +        trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
>> +                                  dev_state);
>> +    }
>> +}
>> +
>>  static int vfio_migration_init(VFIODevice *vbasedev,
>>                                 struct vfio_region_info *info)
>>  {
>> @@ -93,6 +147,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>>          return ret;
>>      }
>>  
>> +    qemu_mutex_init(&vbasedev->migration->lock);
>> +
>> +    vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>> +                                                          vbasedev);
>> +
>>      return 0;
>>  }
>>  
>> @@ -135,11 +194,16 @@ void vfio_migration_finalize(VFIODevice *vbasedev)
>>          return;
>>      }
>>  
>> +    if (vbasedev->vm_state) {
>> +        qemu_del_vm_change_state_handler(vbasedev->vm_state);
>> +    }
>> +
>>      if (vbasedev->migration_blocker) {
>>          migrate_del_blocker(vbasedev->migration_blocker);
>>          error_free(vbasedev->migration_blocker);
>>      }
>>  
>> +    qemu_mutex_destroy(&vbasedev->migration->lock);
>>      vfio_migration_region_exit(vbasedev);
>>      g_free(vbasedev->migration);
>>  }
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 191a726a1312..3d15bacd031a 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -146,3 +146,5 @@ vfio_display_edid_write_error(void) ""
>>  
>>  # migration.c
>>  vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
>> +vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
>> +vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 152da3f8d6f3..f6c70db3a9c1 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -29,6 +29,7 @@
>>  #ifdef CONFIG_LINUX
>>  #include <linux/vfio.h>
>>  #endif
>> +#include "sysemu/sysemu.h"
>>  
>>  #define VFIO_MSG_PREFIX "vfio %s: "
>>  
>> @@ -124,6 +125,9 @@ typedef struct VFIODevice {
>>      unsigned int flags;
>>      VFIOMigration *migration;
>>      Error *migration_blocker;
>> +    uint32_t device_state;
>> +    VMChangeStateEntry *vm_state;
>> +    int vm_running;
>>  } VFIODevice;
>>  
>>  struct VFIODeviceOps {
>> -- 
>> 2.7.0
>>

