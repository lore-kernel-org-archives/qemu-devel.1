Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C3C73C66
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 00:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3D420868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 00:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3D420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmp3z-0001mg-DH
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 20:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42925)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yan.y.zhao@intel.com>) id 1hmp3m-0001OP-Iz
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 20:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1hmp3k-0003iu-9g
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 20:41:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:46812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1hmp3j-0003fs-Tv
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 20:41:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jul 2019 17:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,492,1557212400"; d="scan'208";a="160940531"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by orsmga008.jf.intel.com with ESMTP; 14 Jul 2019 17:41:26 -0700
Date: Sun, 14 Jul 2019 20:35:25 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190715003525.GI9176@joy-OptiPlex-7040>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <20190711025524.GB9176@joy-OptiPlex-7040>
 <20190711105012.GI3971@work-vm>
 <20190711114715.GC9176@joy-OptiPlex-7040>
 <20190711162315.GP3971@work-vm>
 <2dd65778-8661-929d-392f-4db25cf7162b@nvidia.com>
 <20190712174239.GN2730@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712174239.GN2730@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
Subject: Re: [Qemu-devel] [PATCH v7 00/13] Add migration support for VFIO
 device
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 13, 2019 at 01:42:39AM +0800, Dr. David Alan Gilbert wrote:
> * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> > 
> > 
> > On 7/11/2019 9:53 PM, Dr. David Alan Gilbert wrote:
> > > * Yan Zhao (yan.y.zhao@intel.com) wrote:
> > >> On Thu, Jul 11, 2019 at 06:50:12PM +0800, Dr. David Alan Gilbert wrote:
> > >>> * Yan Zhao (yan.y.zhao@intel.com) wrote:
> > >>>> Hi Kirti,
> > >>>> There are still unaddressed comments to your patches v4.
> > >>>> Would you mind addressing them?
> > >>>>
> > >>>> 1. should we register two migration interfaces simultaneously
> > >>>> (https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04750.html)
> > >>>
> > >>> Please don't do this.
> > >>> As far as I'm aware we currently only have one device that does that
> > >>> (vmxnet3) and a patch has just been posted that fixes/removes that.
> > >>>
> > >>> Dave
> > >>>
> > >> hi Dave,
> > >> Thanks for notifying this. but if we want to support postcopy in future,
> > >> after device stops, what interface could we use to transfer data of
> > >> device state only?
> > >> for postcopy, when source device stops, we need to transfer only
> > >> necessary device state to target vm before target vm starts, and we
> > >> don't want to transfer device memory as we'll do that after target vm
> > >> resuming.
> > > 
> > > Hmm ok, lets see; that's got to happen in the call to:
> > >     qemu_savevm_state_complete_precopy(fb, false, false);
> > > that's made from postcopy_start.
> > >  (the false's are iterable_only and inactivate_disks)
> > > 
> > > and at that time I believe the state is POSTCOPY_ACTIVE, so in_postcopy
> > > is true.
> > > 
> > > If you're doing postcopy, then you'll probably define a has_postcopy()
> > > function, so qemu_savevm_state_complete_precopy will skip the
> > > save_live_complete_precopy call from it's loop for at least two of the
> > > reasons in it's big if.
> > > 
> > > So you're right; you need the VMSD for this to happen in the second
> > > loop in qemu_savevm_state_complete_precopy.  Hmm.
> > > 
> > > Now, what worries me, and I don't know the answer, is how the section
> > > header for the vmstate and the section header for an iteration look
> > > on the stream; how are they different?
> > > 
> > 
> > I don't have way to test postcopy migration - is one of the major reason
> > I had not included postcopy support in this patchset and clearly called
> > out in cover letter.
> > This patchset is thoroughly tested for precopy migration.
> > If anyone have hardware that supports fault, then I would prefer to add
> > postcopy support as incremental change later which can be tested before
> > submitting.
> 
> Agreed; although I think Yan's right to think about how it's going to
> work.
> 
> > Just a suggestion, instead of using VMSD, is it possible to have some
> > additional check to call save_live_complete_precopy from
> > qemu_savevm_state_complete_precopy?
> 
> Probably yes; although as you can tell the logic in their is already
> pretty hairy.
> 
This might be a solution. but in that case, lots of modules' 
.save_live_complete_precopy needs to be rewritten, including that of
ram. and we need to redefine the interface of .save_live_complete_precopy.
maybe we can add a new interface like .save_live_pre_postcopy in SaveVMHandlers?

Thanks
Yan

> Dave
> 
> > 
> > >>
> > >>>> 2. in each save iteration, how much data is to be saved
> > >>>> (https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04683.html)
> > 
> > > how big is the data_size ?
> > > if this size is too big, it may take too much time and block others.
> > 
> > I do had mentioned this in the comment about the structure in vfio.h
> > header. data_size will be provided by vendor driver and obviously will
> > not be greater that migration region size. Vendor driver should be
> > responsible to keep its solution optimized.
> > 
> > 
> > >>>> 3. do we need extra interface to get data for device state only
> > >>>> (https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04812.html)
> > 
> > I don't think so. Opaque Device data from vendor driver can include
> > device state and device memory. Vendor driver who is managing his device
> > can decide how to place data over the stream.
> > 
> > >>>> 4. definition of dirty page copied_pfn
> > >>>> (https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05592.html)
> > >>>>
> > 
> > This was inline to discussion going with Alex. I addressed the concern
> > there. Please check current patchset, which addresses the concerns raised.
> > 
> > >>>> Also, I'm glad to see that you updated code by following my comments below,
> > >>>> but please don't forget to reply my comments next time:)
> > 
> > I tried to reply top of threads and addressed common concerns raised in
> > that. Sorry If I missed any, I'll make sure to point you to my replies
> > going ahead.
> > 
> > Thanks,
> > Kirti
> > 
> > >>>> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05357.html
> > >>>> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06454.html
> > >>>>
> > >>>> Thanks
> > >>>> Yan
> > >>>>
> > >>>> On Tue, Jul 09, 2019 at 05:49:07PM +0800, Kirti Wankhede wrote:
> > >>>>> Add migration support for VFIO device
> > >>>>>
> > >>>>> This Patch set include patches as below:
> > >>>>> - Define KABI for VFIO device for migration support.
> > >>>>> - Added save and restore functions for PCI configuration space
> > >>>>> - Generic migration functionality for VFIO device.
> > >>>>>   * This patch set adds functionality only for PCI devices, but can be
> > >>>>>     extended to other VFIO devices.
> > >>>>>   * Added all the basic functions required for pre-copy, stop-and-copy and
> > >>>>>     resume phases of migration.
> > >>>>>   * Added state change notifier and from that notifier function, VFIO
> > >>>>>     device's state changed is conveyed to VFIO device driver.
> > >>>>>   * During save setup phase and resume/load setup phase, migration region
> > >>>>>     is queried and is used to read/write VFIO device data.
> > >>>>>   * .save_live_pending and .save_live_iterate are implemented to use QEMU's
> > >>>>>     functionality of iteration during pre-copy phase.
> > >>>>>   * In .save_live_complete_precopy, that is in stop-and-copy phase,
> > >>>>>     iteration to read data from VFIO device driver is implemented till pending
> > >>>>>     bytes returned by driver are not zero.
> > >>>>>   * Added function to get dirty pages bitmap for the pages which are used by
> > >>>>>     driver.
> > >>>>> - Add vfio_listerner_log_sync to mark dirty pages.
> > >>>>> - Make VFIO PCI device migration capable. If migration region is not provided by
> > >>>>>   driver, migration is blocked.
> > >>>>>
> > >>>>> Below is the flow of state change for live migration where states in brackets
> > >>>>> represent VM state, migration state and VFIO device state as:
> > >>>>>     (VM state, MIGRATION_STATUS, VFIO_DEVICE_STATE)
> > >>>>>
> > >>>>> Live migration save path:
> > >>>>>         QEMU normal running state
> > >>>>>         (RUNNING, _NONE, _RUNNING)
> > >>>>>                         |
> > >>>>>     migrate_init spawns migration_thread.
> > >>>>>     (RUNNING, _SETUP, _RUNNING|_SAVING)
> > >>>>>     Migration thread then calls each device's .save_setup()
> > >>>>>                         |
> > >>>>>     (RUNNING, _ACTIVE, _RUNNING|_SAVING)
> > >>>>>     If device is active, get pending bytes by .save_live_pending()
> > >>>>>     if pending bytes >= threshold_size,  call save_live_iterate()
> > >>>>>     Data of VFIO device for pre-copy phase is copied.
> > >>>>>     Iterate till pending bytes converge and are less than threshold
> > >>>>>                         |
> > >>>>>     On migration completion, vCPUs stops and calls .save_live_complete_precopy
> > >>>>>     for each active device. VFIO device is then transitioned in
> > >>>>>      _SAVING state.
> > >>>>>     (FINISH_MIGRATE, _DEVICE, _SAVING)
> > >>>>>     For VFIO device, iterate in  .save_live_complete_precopy  until
> > >>>>>     pending data is 0.
> > >>>>>     (FINISH_MIGRATE, _DEVICE, _STOPPED)
> > >>>>>                         |
> > >>>>>     (FINISH_MIGRATE, _COMPLETED, STOPPED)
> > >>>>>     Migraton thread schedule cleanup bottom half and exit
> > >>>>>
> > >>>>> Live migration resume path:
> > >>>>>     Incomming migration calls .load_setup for each device
> > >>>>>     (RESTORE_VM, _ACTIVE, STOPPED)
> > >>>>>                         |
> > >>>>>     For each device, .load_state is called for that device section data
> > >>>>>                         |
> > >>>>>     At the end, called .load_cleanup for each device and vCPUs are started.
> > >>>>>                         |
> > >>>>>         (RUNNING, _NONE, _RUNNING)
> > >>>>>
> > >>>>> Note that:
> > >>>>> - Migration post copy is not supported.
> > >>>>>
> > >>>>> v6 -> v7:
> > >>>>> - Fix build failures.
> > >>>>>
> > >>>>> v5 -> v6:
> > >>>>> - Fix build failure.
> > >>>>>
> > >>>>> v4 -> v5:
> > >>>>> - Added decriptive comment about the sequence of access of members of structure
> > >>>>>   vfio_device_migration_info to be followed based on Alex's suggestion
> > >>>>> - Updated get dirty pages sequence.
> > >>>>> - As per Cornelia Huck's suggestion, added callbacks to VFIODeviceOps to
> > >>>>>   get_object, save_config and load_config.
> > >>>>> - Fixed multiple nit picks.
> > >>>>> - Tested live migration with multiple vfio device assigned to a VM.
> > >>>>>
> > >>>>> v3 -> v4:
> > >>>>> - Added one more bit for _RESUMING flag to be set explicitly.
> > >>>>> - data_offset field is read-only for user space application.
> > >>>>> - data_size is read for every iteration before reading data from migration, that
> > >>>>>   is removed assumption that data will be till end of migration region.
> > >>>>> - If vendor driver supports mappable sparsed region, map those region during
> > >>>>>   setup state of save/load, similarly unmap those from cleanup routines.
> > >>>>> - Handles race condition that causes data corruption in migration region during
> > >>>>>   save device state by adding mutex and serialiaing save_buffer and
> > >>>>>   get_dirty_pages routines.
> > >>>>> - Skip called get_dirty_pages routine for mapped MMIO region of device.
> > >>>>> - Added trace events.
> > >>>>> - Splitted into multiple functional patches.
> > >>>>>
> > >>>>> v2 -> v3:
> > >>>>> - Removed enum of VFIO device states. Defined VFIO device state with 2 bits.
> > >>>>> - Re-structured vfio_device_migration_info to keep it minimal and defined action
> > >>>>>   on read and write access on its members.
> > >>>>>
> > >>>>> v1 -> v2:
> > >>>>> - Defined MIGRATION region type and sub-type which should be used with region
> > >>>>>   type capability.
> > >>>>> - Re-structured vfio_device_migration_info. This structure will be placed at 0th
> > >>>>>   offset of migration region.
> > >>>>> - Replaced ioctl with read/write for trapped part of migration region.
> > >>>>> - Added both type of access support, trapped or mmapped, for data section of the
> > >>>>>   region.
> > >>>>> - Moved PCI device functions to pci file.
> > >>>>> - Added iteration to get dirty page bitmap until bitmap for all requested pages
> > >>>>>   are copied.
> > >>>>>
> > >>>>> Thanks,
> > >>>>> Kirti
> > >>>>>
> > >>>>> Kirti Wankhede (13):
> > >>>>>   vfio: KABI for migration interface
> > >>>>>   vfio: Add function to unmap VFIO region
> > >>>>>   vfio: Add vfio_get_object callback to VFIODeviceOps
> > >>>>>   vfio: Add save and load functions for VFIO PCI devices
> > >>>>>   vfio: Add migration region initialization and finalize function
> > >>>>>   vfio: Add VM state change handler to know state of VM
> > >>>>>   vfio: Add migration state change notifier
> > >>>>>   vfio: Register SaveVMHandlers for VFIO device
> > >>>>>   vfio: Add save state functions to SaveVMHandlers
> > >>>>>   vfio: Add load state functions to SaveVMHandlers
> > >>>>>   vfio: Add function to get dirty page list
> > >>>>>   vfio: Add vfio_listerner_log_sync to mark dirty pages
> > >>>>>   vfio: Make vfio-pci device migration capable.
> > >>>>>
> > >>>>>  hw/vfio/Makefile.objs         |   2 +-
> > >>>>>  hw/vfio/common.c              |  55 +++
> > >>>>>  hw/vfio/migration.c           | 874 ++++++++++++++++++++++++++++++++++++++++++
> > >>>>>  hw/vfio/pci.c                 | 137 ++++++-
> > >>>>>  hw/vfio/trace-events          |  19 +
> > >>>>>  include/hw/vfio/vfio-common.h |  25 ++
> > >>>>>  linux-headers/linux/vfio.h    | 166 ++++++++
> > >>>>>  7 files changed, 1271 insertions(+), 7 deletions(-)
> > >>>>>  create mode 100644 hw/vfio/migration.c
> > >>>>>
> > >>>>> -- 
> > >>>>> 2.7.0
> > >>>>>
> > >>> --
> > >>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

