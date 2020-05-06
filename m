Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313F4C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07304206F9
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07304206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWDrs-0005P5-38
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 02:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jWDrH-0004zx-A9
 for qemu-devel@nongnu.org; Wed, 06 May 2020 02:48:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:29749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jWDrE-0001SJ-Se
 for qemu-devel@nongnu.org; Wed, 06 May 2020 02:48:42 -0400
IronPort-SDR: X5I5hY7z41UF3BShctbSHj2y2+1z7HpL6RdNILbV9tLY5NdXOBzeY+TuGwmhJ2lLgSxGOxbMLJ
 QHv5pEA2vcTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2020 23:48:37 -0700
IronPort-SDR: LU8Ib861IlGylrHNnFnzVKcXhonmXETVG/JMsJY+moFQ1+WNGk7EUzoZ5SxohsU/9VqF6iUJpT
 x2rk00xZcyGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,358,1583222400"; d="scan'208";a="263448737"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga006.jf.intel.com with ESMTP; 05 May 2020 23:48:32 -0700
Date: Wed, 6 May 2020 02:38:46 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v16 QEMU 08/16] vfio: Register SaveVMHandlers for VFIO
 device
Message-ID: <20200506063846.GB19334@joy-OptiPlex-7040>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-9-git-send-email-kwankhede@nvidia.com>
 <20200325150248.6661e1bd@w520.home>
 <a3a082a4-cc2f-b84b-60c6-a20f86528a6d@nvidia.com>
 <20200504223726.5d4bb9ce@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504223726.5d4bb9ce@x1.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.31; envelope-from=yan.y.zhao@intel.com;
 helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:48:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 05, 2020 at 12:37:26PM +0800, Alex Williamson wrote:
> On Tue, 5 May 2020 04:49:10 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > On 3/26/2020 2:32 AM, Alex Williamson wrote:
> > > On Wed, 25 Mar 2020 02:39:06 +0530
> > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > >   
> > >> Define flags to be used as delimeter in migration file stream.
> > >> Added .save_setup and .save_cleanup functions. Mapped & unmapped migration
> > >> region from these functions at source during saving or pre-copy phase.
> > >> Set VFIO device state depending on VM's state. During live migration, VM is
> > >> running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
> > >> device. During save-restore, VM is paused, _SAVING state is set for VFIO device.
> > >>
> > >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> > >> ---
> > >>   hw/vfio/migration.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >>   hw/vfio/trace-events |  2 ++
> > >>   2 files changed, 78 insertions(+)
> > >>
> > >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > >> index 22ded9d28cf3..033f76526e49 100644
> > >> --- a/hw/vfio/migration.c
> > >> +++ b/hw/vfio/migration.c
> > >> @@ -8,6 +8,7 @@
> > >>    */
> > >>   
> > >>   #include "qemu/osdep.h"
> > >> +#include "qemu/main-loop.h"
> > >>   #include <linux/vfio.h>
> > >>   
> > >>   #include "sysemu/runstate.h"
> > >> @@ -24,6 +25,17 @@
> > >>   #include "pci.h"
> > >>   #include "trace.h"
> > >>   
> > >> +/*
> > >> + * Flags used as delimiter:
> > >> + * 0xffffffff => MSB 32-bit all 1s
> > >> + * 0xef10     => emulated (virtual) function IO
> > >> + * 0x0000     => 16-bits reserved for flags
> > >> + */
> > >> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> > >> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> > >> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> > >> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> > >> +
> > >>   static void vfio_migration_region_exit(VFIODevice *vbasedev)
> > >>   {
> > >>       VFIOMigration *migration = vbasedev->migration;
> > >> @@ -126,6 +138,69 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
> > >>       return 0;
> > >>   }
> > >>   
> > >> +/* ---------------------------------------------------------------------- */
> > >> +
> > >> +static int vfio_save_setup(QEMUFile *f, void *opaque)
> > >> +{
> > >> +    VFIODevice *vbasedev = opaque;
> > >> +    VFIOMigration *migration = vbasedev->migration;
> > >> +    int ret;
> > >> +
> > >> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
> > >> +
> > >> +    if (migration->region.mmaps) {
> > >> +        qemu_mutex_lock_iothread();
> > >> +        ret = vfio_region_mmap(&migration->region);
> > >> +        qemu_mutex_unlock_iothread();
> > >> +        if (ret) {
> > >> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
> > >> +                         vbasedev->name, migration->region.index,
> > >> +                         strerror(-ret));
> > >> +            return ret;
> > >> +        }
> > >> +    }
> > >> +
> > >> +    ret = vfio_migration_set_state(vbasedev, ~0, VFIO_DEVICE_STATE_SAVING);
> > >> +    if (ret) {
> > >> +        error_report("%s: Failed to set state SAVING", vbasedev->name);
> > >> +        return ret;
> > >> +    }
> > >> +
> > >> +    /*
> > >> +     * Save migration region size. This is used to verify migration region size
> > >> +     * is greater than or equal to migration region size at destination
> > >> +     */
> > >> +    qemu_put_be64(f, migration->region.size);  
> > > 
> > > Is this requirement supported by the uapi?    
> > 
> > Yes, on UAPI thread we discussed this:
> > 
> >   * For the user application, data is opaque. The user application 
> > should write
> >   * data in the same order as the data is received and the data should be of
> >   * same transaction size at the source.
> > 
> > data should be same transaction size, so migration region size should be 
> > greater than or equal to the size at source when verifying at destination.
> 
> We are that user application for which the data is opaque, therefore we
> should make no assumptions about how the vendor driver makes use of
> their region.  If we get a transaction that exceeds the end of the
> region, I agree, that would be an error.  But we have no business
> predicting that such a transaction might occur if the vendor driver
> indicates it can support the migration.
> 
> > > The vendor driver operates
> > > within the migration region, but it has no requirement to use the full
> > > extent of the region.  Shouldn't we instead insert the version string
> > > from versioning API Yan proposed?  Is this were we might choose to use
> > > an interface via the vfio API rather than sysfs if we had one?
> > >  
> > 
> > VFIO API cannot be used by libvirt or management tool stack. We need 
> > sysfs as Yan proposed to be used by libvirt or management tool stack.
> 
> It's been a long time, but that doesn't seem like what I was asking.
> The sysfs version checking is used to select a target that is likely to
> succeed, but the migration stream is still generated by a user and the
> vendor driver is still ultimately responsible for validating that
> stream.  I would hope that a vendor migration stream therefore starts
> with information similar to that found in the sysfs interface, allowing
> the receiving vendor driver to validate the source device and vendor
> software version, such that we can fail an incoming migration that the
> vendor driver deems incompatible.  Ideally the vendor driver might also
> include consistency and sequence checking throughout the stream to
> prevent a malicious user from exploiting the internal operation of the
> vendor driver.  Thanks,
> 
maybe we can add a rw field migration_version in
struct vfio_device_migration_info besides sysfs interface ?

when reading it in src, it gets the same string as that from sysfs;
when writing it in target, it returns success or not to check
compatibility and fails the migration early in setup phase.

Thanks
Yan.

