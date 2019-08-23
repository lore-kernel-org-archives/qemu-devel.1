Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52565C3A5A1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 01:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254B6233A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 01:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254B6233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0yRD-0000ya-4v
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 21:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1i0yQ3-0000Pq-Ey
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 21:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1i0yQ1-0003sm-7I
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 21:31:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:34195)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1i0yQ0-0003pI-V8
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 21:31:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Aug 2019 18:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,419,1559545200"; d="scan'208";a="378715550"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by fmsmga005.fm.intel.com with ESMTP; 22 Aug 2019 18:31:00 -0700
Date: Thu, 22 Aug 2019 21:23:27 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20190823012326.GB16599@joy-OptiPlex-7040>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-9-git-send-email-kwankhede@nvidia.com>
 <20190722083449.GM8912@joy-OptiPlex-7040>
 <91bc4137-4306-928c-56ff-9a388d82f026@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91bc4137-4306-928c-56ff-9a388d82f026@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] [PATCH v7 08/13] vfio: Register SaveVMHandlers for
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

On Wed, Aug 21, 2019 at 04:33:06AM +0800, Kirti Wankhede wrote:
> 
> 
> On 7/22/2019 2:04 PM, Yan Zhao wrote:
> > On Tue, Jul 09, 2019 at 05:49:15PM +0800, Kirti Wankhede wrote:
> >> Define flags to be used as delimeter in migration file stream.
> >> Added .save_setup and .save_cleanup functions. Mapped & unmapped migration
> >> region from these functions at source during saving or pre-copy phase.
> >> Set VFIO device state depending on VM's state. During live migration, VM is
> >> running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
> >> device. During save-restore, VM is paused, _SAVING state is set for VFIO device.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> ---
> >>  hw/vfio/migration.c  | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  hw/vfio/trace-events |  2 ++
> >>  2 files changed, 83 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >> index e4a89a6f9bc7..0597a45fda2d 100644
> >> --- a/hw/vfio/migration.c
> >> +++ b/hw/vfio/migration.c
> >> @@ -23,6 +23,17 @@
> >>  #include "pci.h"
> >>  #include "trace.h"
> >>  
> >> +/*
> >> + * Flags used as delimiter:
> >> + * 0xffffffff => MSB 32-bit all 1s
> >> + * 0xef10     => emulated (virtual) function IO
> >> + * 0x0000     => 16-bits reserved for flags
> >> + */
> >> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> >> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> >> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> >> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> >> +
> >>  static void vfio_migration_region_exit(VFIODevice *vbasedev)
> >>  {
> >>      VFIOMigration *migration = vbasedev->migration;
> >> @@ -106,6 +117,74 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
> >>      return 0;
> >>  }
> >>  
> >> +/* ---------------------------------------------------------------------- */
> >> +
> >> +static int vfio_save_setup(QEMUFile *f, void *opaque)
> >> +{
> >> +    VFIODevice *vbasedev = opaque;
> >> +    VFIOMigration *migration = vbasedev->migration;
> >> +    int ret;
> >> +
> >> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
> >> +
> >> +    if (migration->region.buffer.mmaps) {
> >> +        qemu_mutex_lock_iothread();
> >> +        ret = vfio_region_mmap(&migration->region.buffer);
> >> +        qemu_mutex_unlock_iothread();
> >> +        if (ret) {
> >> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
> >> +                         vbasedev->name, migration->region.index,
> >> +                         strerror(-ret));
> >> +            return ret;
> >> +        }
> >> +    }
> >> +
> >> +    if (vbasedev->vm_running) {
> >> +        ret = vfio_migration_set_state(vbasedev,
> >> +                         VFIO_DEVICE_STATE_RUNNING | VFIO_DEVICE_STATE_SAVING);
> >> +        if (ret) {
> >> +            error_report("%s: Failed to set state RUNNING and SAVING",
> >> +                         vbasedev->name);
> >> +            return ret;
> >> +        }
> >> +    } else {
> > hi Kirti
> > May I know in which condition will this "else" case happen?
> > 
> 
> This can happen in savevm case.

ok. I see it. thanks.
Could we simplify the logic and only or VFIO_DEVICE_STATE_SAVING to
current device state here?
Because device state was already set to RUNNING or STOP in
vfio_vmstate_change().

Thanks
Yan
> 
> Thanks,
> Kirti
> 
> > Thanks
> > Yan
> > 
> >> +        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_SAVING);
> >> +        if (ret) {
> >> +            error_report("%s: Failed to set state STOP and SAVING",
> >> +                         vbasedev->name);
> >> +            return ret;
> >> +        }
> >> +    }
> >> +
> >> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> >> +
> >> +    ret = qemu_file_get_error(f);
> >> +    if (ret) {
> >> +        return ret;
> >> +    }
> >> +
> >> +    trace_vfio_save_setup(vbasedev->name);
> >> +    return 0;
> >> +}
> >> +
> >> +static void vfio_save_cleanup(void *opaque)
> >> +{
> >> +    VFIODevice *vbasedev = opaque;
> >> +    VFIOMigration *migration = vbasedev->migration;
> >> +
> >> +    if (migration->region.buffer.mmaps) {
> >> +        vfio_region_unmap(&migration->region.buffer);
> >> +    }
> >> +    trace_vfio_save_cleanup(vbasedev->name);
> >> +}
> >> +
> >> +static SaveVMHandlers savevm_vfio_handlers = {
> >> +    .save_setup = vfio_save_setup,
> >> +    .save_cleanup = vfio_save_cleanup,
> >> +};
> >> +
> >> +/* ---------------------------------------------------------------------- */
> >> +
> >>  static void vfio_vmstate_change(void *opaque, int running, RunState state)
> >>  {
> >>      VFIODevice *vbasedev = opaque;
> >> @@ -195,7 +274,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
> >>      }
> >>  
> >>      qemu_mutex_init(&vbasedev->migration->lock);
> >> -
> >> +    register_savevm_live(vbasedev->dev, "vfio", -1, 1, &savevm_vfio_handlers,
> >> +                         vbasedev);
> >>      vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
> >>                                                            vbasedev);
> >>  
> >> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> >> index 69503228f20e..4bb43f18f315 100644
> >> --- a/hw/vfio/trace-events
> >> +++ b/hw/vfio/trace-events
> >> @@ -149,3 +149,5 @@ vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
> >>  vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
> >>  vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
> >>  vfio_migration_state_notifier(char *name, int state) " (%s) state %d"
> >> +vfio_save_setup(char *name) " (%s)"
> >> +vfio_save_cleanup(char *name) " (%s)"
> >> -- 
> >> 2.7.0
> >>

