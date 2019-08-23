Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E00C3A5A1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 01:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67022173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 01:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67022173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0yZE-0004VO-UG
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 21:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1i0yYV-0003zV-Da
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 21:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1i0yYT-0000QZ-VS
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 21:39:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:15700)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1i0yYT-0000O4-Kb
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 21:39:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Aug 2019 18:39:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,419,1559545200"; d="scan'208";a="379540432"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by fmsmga006.fm.intel.com with ESMTP; 22 Aug 2019 18:39:48 -0700
Date: Thu, 22 Aug 2019 21:32:15 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20190823013215.GC16599@joy-OptiPlex-7040>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-7-git-send-email-kwankhede@nvidia.com>
 <20190722083703.GN8912@joy-OptiPlex-7040>
 <0611522b-7ec2-194a-5ebc-7314b2158cff@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0611522b-7ec2-194a-5ebc-7314b2158cff@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
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

On Wed, Aug 21, 2019 at 04:33:50AM +0800, Kirti Wankhede wrote:
> 
> 
> On 7/22/2019 2:07 PM, Yan Zhao wrote:
> > On Tue, Jul 09, 2019 at 05:49:13PM +0800, Kirti Wankhede wrote:
> >> VM state change handler gets called on change in VM's state. This is used to set
> >> VFIO device state to _RUNNING.
> >> VM state change handler, migration state change handler and log_sync listener
> >> are called asynchronously, which sometimes lead to data corruption in migration
> >> region. Initialised mutex that is used to serialize operations on migration data
> >> region during saving state.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> ---
> >>  hw/vfio/migration.c           | 64 +++++++++++++++++++++++++++++++++++++++++++
> >>  hw/vfio/trace-events          |  2 ++
> >>  include/hw/vfio/vfio-common.h |  4 +++
> >>  3 files changed, 70 insertions(+)
> >>
> >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >> index a2cfbd5af2e1..c01f08b659d0 100644
> >> --- a/hw/vfio/migration.c
> >> +++ b/hw/vfio/migration.c
> >> @@ -78,6 +78,60 @@ err:
> >>      return ret;
> >>  }
> >>  
> >> +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
> >> +{
> >> +    VFIOMigration *migration = vbasedev->migration;
> >> +    VFIORegion *region = &migration->region.buffer;
> >> +    uint32_t device_state;
> >> +    int ret = 0;
> >> +
> >> +    device_state = (state & VFIO_DEVICE_STATE_MASK) |
> >> +                   (vbasedev->device_state & ~VFIO_DEVICE_STATE_MASK);
> >> +
> >> +    if ((device_state & VFIO_DEVICE_STATE_MASK) == VFIO_DEVICE_STATE_INVALID) {
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    ret = pwrite(vbasedev->fd, &device_state, sizeof(device_state),
> >> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
> >> +                                              device_state));
> >> +    if (ret < 0) {
> >> +        error_report("%s: Failed to set device state %d %s",
> >> +                     vbasedev->name, ret, strerror(errno));
> >> +        return ret;
> >> +    }
> >> +
> >> +    vbasedev->device_state = device_state;
> >> +    trace_vfio_migration_set_state(vbasedev->name, device_state);
> >> +    return 0;
> >> +}
> >> +
> >> +static void vfio_vmstate_change(void *opaque, int running, RunState state)
> >> +{
> >> +    VFIODevice *vbasedev = opaque;
> >> +
> >> +    if ((vbasedev->vm_running != running)) {
> >> +        int ret;
> >> +        uint32_t dev_state;
> >> +
> >> +        if (running) {
> >> +            dev_state = VFIO_DEVICE_STATE_RUNNING;
> > should be
> > dev_state |= VFIO_DEVICE_STATE_RUNNING; ?
> > 
> 
> vfio_migration_set_state() takes case of ORing.
>
if previous dev_state is VFIO_DEVICE_STATE_SAVING (without RUNNING), and
vfio_migration_set_state(VFIO_DEVICE_STATE_RUNNING) is called here, do
you mean vfio_migration_set_state() will change the device state to
VFIO_DEVICE_STATE_RUNNING | VFIO_DEVICE_STATE_SAVING ?

Thanks
Yan


> Thanks,
> Kirti
> 
> >> +        } else {
> >> +            dev_state = (vbasedev->device_state & VFIO_DEVICE_STATE_MASK) &
> >> +                     ~VFIO_DEVICE_STATE_RUNNING;
> >> +        }
> >> +
> >> +        ret = vfio_migration_set_state(vbasedev, dev_state);
> >> +        if (ret) {
> >> +            error_report("%s: Failed to set device state 0x%x",
> >> +                         vbasedev->name, dev_state);
> >> +        }
> >> +        vbasedev->vm_running = running;
> >> +        trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
> >> +                                  dev_state);
> >> +    }
> >> +}
> >> +
> >>  static int vfio_migration_init(VFIODevice *vbasedev,
> >>                                 struct vfio_region_info *info)
> >>  {
> >> @@ -93,6 +147,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
> >>          return ret;
> >>      }
> >>  
> >> +    qemu_mutex_init(&vbasedev->migration->lock);
> >> +
> >> +    vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
> >> +                                                          vbasedev);
> >> +
> >>      return 0;
> >>  }
> >>  
> >> @@ -135,11 +194,16 @@ void vfio_migration_finalize(VFIODevice *vbasedev)
> >>          return;
> >>      }
> >>  
> >> +    if (vbasedev->vm_state) {
> >> +        qemu_del_vm_change_state_handler(vbasedev->vm_state);
> >> +    }
> >> +
> >>      if (vbasedev->migration_blocker) {
> >>          migrate_del_blocker(vbasedev->migration_blocker);
> >>          error_free(vbasedev->migration_blocker);
> >>      }
> >>  
> >> +    qemu_mutex_destroy(&vbasedev->migration->lock);
> >>      vfio_migration_region_exit(vbasedev);
> >>      g_free(vbasedev->migration);
> >>  }
> >> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> >> index 191a726a1312..3d15bacd031a 100644
> >> --- a/hw/vfio/trace-events
> >> +++ b/hw/vfio/trace-events
> >> @@ -146,3 +146,5 @@ vfio_display_edid_write_error(void) ""
> >>  
> >>  # migration.c
> >>  vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
> >> +vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
> >> +vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
> >> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> >> index 152da3f8d6f3..f6c70db3a9c1 100644
> >> --- a/include/hw/vfio/vfio-common.h
> >> +++ b/include/hw/vfio/vfio-common.h
> >> @@ -29,6 +29,7 @@
> >>  #ifdef CONFIG_LINUX
> >>  #include <linux/vfio.h>
> >>  #endif
> >> +#include "sysemu/sysemu.h"
> >>  
> >>  #define VFIO_MSG_PREFIX "vfio %s: "
> >>  
> >> @@ -124,6 +125,9 @@ typedef struct VFIODevice {
> >>      unsigned int flags;
> >>      VFIOMigration *migration;
> >>      Error *migration_blocker;
> >> +    uint32_t device_state;
> >> +    VMChangeStateEntry *vm_state;
> >> +    int vm_running;
> >>  } VFIODevice;
> >>  
> >>  struct VFIODeviceOps {
> >> -- 
> >> 2.7.0
> >>
> 
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------

