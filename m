Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B96C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2BB229FA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2BB229FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqFWF-0005Ke-2s
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57481)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqFW1-0004tg-C9
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqFVz-0007Ev-0E
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:33:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hqFVy-0007Dv-Mj
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:32:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1B74C88306;
 Wed, 24 Jul 2019 11:32:56 +0000 (UTC)
Received: from work-vm (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E85155D9DE;
 Wed, 24 Jul 2019 11:32:48 +0000 (UTC)
Date: Wed, 24 Jul 2019 12:32:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190724113246.GF2717@work-vm>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <20190711025524.GB9176@joy-OptiPlex-7040>
 <20190711105012.GI3971@work-vm>
 <20190711114715.GC9176@joy-OptiPlex-7040>
 <20190711162315.GP3971@work-vm>
 <2dd65778-8661-929d-392f-4db25cf7162b@nvidia.com>
 <20190712003201.GE9176@joy-OptiPlex-7040>
 <f368b367-e355-cf04-2824-3384f4ea6e33@nvidia.com>
 <20190719012328.GF8912@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719012328.GF8912@joy-OptiPlex-7040>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 24 Jul 2019 11:32:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yan Zhao (yan.y.zhao@intel.com) wrote:
> On Fri, Jul 19, 2019 at 02:32:33AM +0800, Kirti Wankhede wrote:
> > 
> > On 7/12/2019 6:02 AM, Yan Zhao wrote:
> > > On Fri, Jul 12, 2019 at 03:08:31AM +0800, Kirti Wankhede wrote:
> > >>
> > >>
> > >> On 7/11/2019 9:53 PM, Dr. David Alan Gilbert wrote:
> > >>> * Yan Zhao (yan.y.zhao@intel.com) wrote:
> > >>>> On Thu, Jul 11, 2019 at 06:50:12PM +0800, Dr. David Alan Gilbert wrote:
> > >>>>> * Yan Zhao (yan.y.zhao@intel.com) wrote:
> > >>>>>> Hi Kirti,
> > >>>>>> There are still unaddressed comments to your patches v4.
> > >>>>>> Would you mind addressing them?
> > >>>>>>
> > >>>>>> 1. should we register two migration interfaces simultaneously
> > >>>>>> (https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04750.html)
> > >>>>>
> > >>>>> Please don't do this.
> > >>>>> As far as I'm aware we currently only have one device that does that
> > >>>>> (vmxnet3) and a patch has just been posted that fixes/removes that.
> > >>>>>
> > >>>>> Dave
> > >>>>>
> > >>>> hi Dave,
> > >>>> Thanks for notifying this. but if we want to support postcopy in future,
> > >>>> after device stops, what interface could we use to transfer data of
> > >>>> device state only?
> > >>>> for postcopy, when source device stops, we need to transfer only
> > >>>> necessary device state to target vm before target vm starts, and we
> > >>>> don't want to transfer device memory as we'll do that after target vm
> > >>>> resuming.
> > >>>
> > >>> Hmm ok, lets see; that's got to happen in the call to:
> > >>>     qemu_savevm_state_complete_precopy(fb, false, false);
> > >>> that's made from postcopy_start.
> > >>>  (the false's are iterable_only and inactivate_disks)
> > >>>
> > >>> and at that time I believe the state is POSTCOPY_ACTIVE, so in_postcopy
> > >>> is true.
> > >>>
> > >>> If you're doing postcopy, then you'll probably define a has_postcopy()
> > >>> function, so qemu_savevm_state_complete_precopy will skip the
> > >>> save_live_complete_precopy call from it's loop for at least two of the
> > >>> reasons in it's big if.
> > >>>
> > >>> So you're right; you need the VMSD for this to happen in the second
> > >>> loop in qemu_savevm_state_complete_precopy.  Hmm.
> > >>>
> > >>> Now, what worries me, and I don't know the answer, is how the section
> > >>> header for the vmstate and the section header for an iteration look
> > >>> on the stream; how are they different?
> > >>>
> > >>
> > >> I don't have way to test postcopy migration - is one of the major reason
> > >> I had not included postcopy support in this patchset and clearly called
> > >> out in cover letter.
> > >> This patchset is thoroughly tested for precopy migration.
> > >> If anyone have hardware that supports fault, then I would prefer to add
> > >> postcopy support as incremental change later which can be tested before
> > >> submitting.
> > >>
> > >> Just a suggestion, instead of using VMSD, is it possible to have some
> > >> additional check to call save_live_complete_precopy from
> > >> qemu_savevm_state_complete_precopy?
> > >>
> > >>
> > >>>>
> > >>>>>> 2. in each save iteration, how much data is to be saved
> > >>>>>> (https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04683.html)
> > >>
> > >>> how big is the data_size ?
> > >>> if this size is too big, it may take too much time and block others.
> > >>
> > >> I do had mentioned this in the comment about the structure in vfio.h
> > >> header. data_size will be provided by vendor driver and obviously will
> > >> not be greater that migration region size. Vendor driver should be
> > >> responsible to keep its solution optimized.
> > >>
> > > if the data_size is no big than migration region size, and each
> > > iteration only saves data of data_size, i'm afraid it will cause
> > > prolonged down time. after all, the migration region size cannot be very
> > > big.
> > 
> > As I mentioned above, its vendor driver responsibility to keep its
> > solution optimized.
> > A good behaving vendor driver should not cause unnecessary prolonged
> > down time.
> >
> I think vendor data can determine the data_size, but qemu has to decide
> how much data to transmit according to the actual transmitting time (or
> transmitting speed). when transmitting speed is high, transmit more data
> a iteration, and low speed small data a iteration. This transmitting
> time knowledge is not available to vendor driver, and even it has this
> knowledge, can it dynamically change data region size?
> maybe you can say vendor driver can register a big enough region and
> dynamically use part of it, but what is big enough and it really costs
> memory.
> 
> > > Also, if vendor driver determines how much data to save in each
> > > iteration alone, and no checks in qemu, it may cause other devices'
> > > migration time be squeezed.
> > > 
> > 
> > Sorry, how will that squeeze other device's migration time?
> > 
> if a vendor driver has extremely big data to transmit, other devices
> have to wait until it finishes to transmit their own data. In a given
> time period, it can be considered as their time slot being squeezed.
> not sure whether it's a good practice.

I don't think we have anything for fairly allocating bandwidth/time
among devices; that would be pretty hard.

I think the only thing we currently have is the final downtime
heuristics; i.e. the threshold you should be below at the point
we decide to stop iterating.

Dave

> > >>
> > >>>>>> 3. do we need extra interface to get data for device state only
> > >>>>>> (https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04812.html)
> > >>
> > >> I don't think so. Opaque Device data from vendor driver can include
> > >> device state and device memory. Vendor driver who is managing his device
> > >> can decide how to place data over the stream.
> > >>
> > > I know current design is opaque device data. then to support postcopy,
> > > we may have to add extra device state like in-postcopy. but postcopy is
> > > more like a qemu state and is not a device state.
> > 
> > One bit from device_state can be used to inform vendor driver about
> > postcopy, when postcopy support will be added.
> >
> ok. if you insist on that, one bit in devie_state is also good, as long
> as everyone agrees on it:)
> 
> > > to address it elegantly, may we add an extra interface besides
> > > vfio_save_buffer() to get data for device state only?
> > > 
> > 
> > When in postcopy state, based on device_state flag, vendor driver can
> > copy device state first in migration region, I still think there is no
> > need to separate device state and device memory.
> >
> it's the difference between more device_state flags and more interfaces.
> 
> > >>>>>> 4. definition of dirty page copied_pfn
> > >>>>>> (https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05592.html)
> > >>>>>>
> > >>
> > >> This was inline to discussion going with Alex. I addressed the concern
> > >> there. Please check current patchset, which addresses the concerns raised.
> > >>
> > > ok. I saw you also updated the flow in the part. please check my comment
> > > in that patch for detail. but as a suggestion, I think processed_pfns is
> > > a better name compared to copied_pfns :)
> > > 
> > 
> > Vendor driver can process total_pfns, but can copy only some pfns bitmap
> > to migration region. One of the reason could be the size of migration
> > region is not able to accommodate bitmap of total_pfns size. So it could
> > be like: 0 < copied_pfns < total_pfns. That's why the name
> > 'copied_pfns'. I'll continue with 'copied_pfns'.
> >
> so it's bitmap's pfn count, right? 
> besides VFIO_DEVICE_DIRTY_PFNS_NONE, and VFIO_DEVICE_DIRTY_PFNS_ALL to
> indicate no dirty and all dirty in total_pfns, why not add two more
> flags, e.g.
> VFIO_DEVICE_DIRTY_PFNS_ONE_ITERATION,
> VFIO_DEVICE_DIRTY_PFNS_ALL_ONE_ITERATION, to skip copying bitmap from
> kernel if the copied bitmap in one iteration is all 0 or all 1?
> 
> Thanks
> Yan
> > 
> > >>>>>> Also, I'm glad to see that you updated code by following my comments below,
> > >>>>>> but please don't forget to reply my comments next time:)
> > >>
> > >> I tried to reply top of threads and addressed common concerns raised in
> > >> that. Sorry If I missed any, I'll make sure to point you to my replies
> > >> going ahead.
> > >>
> > > ok. let's cooperate:)
> > > 
> > > Thanks
> > > Yan
> > > 
> > >> Thanks,
> > >> Kirti
> > >>
> > >>>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05357.html
> > >>>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06454.html
> > >>>>>>
> > >>>>>> Thanks
> > >>>>>> Yan
> > >>>>>>
> > >>>>>> On Tue, Jul 09, 2019 at 05:49:07PM +0800, Kirti Wankhede wrote:
> > >>>>>>> Add migration support for VFIO device
> > >>>>>>>
> > >>>>>>> This Patch set include patches as below:
> > >>>>>>> - Define KABI for VFIO device for migration support.
> > >>>>>>> - Added save and restore functions for PCI configuration space
> > >>>>>>> - Generic migration functionality for VFIO device.
> > >>>>>>>   * This patch set adds functionality only for PCI devices, but can be
> > >>>>>>>     extended to other VFIO devices.
> > >>>>>>>   * Added all the basic functions required for pre-copy, stop-and-copy and
> > >>>>>>>     resume phases of migration.
> > >>>>>>>   * Added state change notifier and from that notifier function, VFIO
> > >>>>>>>     device's state changed is conveyed to VFIO device driver.
> > >>>>>>>   * During save setup phase and resume/load setup phase, migration region
> > >>>>>>>     is queried and is used to read/write VFIO device data.
> > >>>>>>>   * .save_live_pending and .save_live_iterate are implemented to use QEMU's
> > >>>>>>>     functionality of iteration during pre-copy phase.
> > >>>>>>>   * In .save_live_complete_precopy, that is in stop-and-copy phase,
> > >>>>>>>     iteration to read data from VFIO device driver is implemented till pending
> > >>>>>>>     bytes returned by driver are not zero.
> > >>>>>>>   * Added function to get dirty pages bitmap for the pages which are used by
> > >>>>>>>     driver.
> > >>>>>>> - Add vfio_listerner_log_sync to mark dirty pages.
> > >>>>>>> - Make VFIO PCI device migration capable. If migration region is not provided by
> > >>>>>>>   driver, migration is blocked.
> > >>>>>>>
> > >>>>>>> Below is the flow of state change for live migration where states in brackets
> > >>>>>>> represent VM state, migration state and VFIO device state as:
> > >>>>>>>     (VM state, MIGRATION_STATUS, VFIO_DEVICE_STATE)
> > >>>>>>>
> > >>>>>>> Live migration save path:
> > >>>>>>>         QEMU normal running state
> > >>>>>>>         (RUNNING, _NONE, _RUNNING)
> > >>>>>>>                         |
> > >>>>>>>     migrate_init spawns migration_thread.
> > >>>>>>>     (RUNNING, _SETUP, _RUNNING|_SAVING)
> > >>>>>>>     Migration thread then calls each device's .save_setup()
> > >>>>>>>                         |
> > >>>>>>>     (RUNNING, _ACTIVE, _RUNNING|_SAVING)
> > >>>>>>>     If device is active, get pending bytes by .save_live_pending()
> > >>>>>>>     if pending bytes >= threshold_size,  call save_live_iterate()
> > >>>>>>>     Data of VFIO device for pre-copy phase is copied.
> > >>>>>>>     Iterate till pending bytes converge and are less than threshold
> > >>>>>>>                         |
> > >>>>>>>     On migration completion, vCPUs stops and calls .save_live_complete_precopy
> > >>>>>>>     for each active device. VFIO device is then transitioned in
> > >>>>>>>      _SAVING state.
> > >>>>>>>     (FINISH_MIGRATE, _DEVICE, _SAVING)
> > >>>>>>>     For VFIO device, iterate in  .save_live_complete_precopy  until
> > >>>>>>>     pending data is 0.
> > >>>>>>>     (FINISH_MIGRATE, _DEVICE, _STOPPED)
> > >>>>>>>                         |
> > >>>>>>>     (FINISH_MIGRATE, _COMPLETED, STOPPED)
> > >>>>>>>     Migraton thread schedule cleanup bottom half and exit
> > >>>>>>>
> > >>>>>>> Live migration resume path:
> > >>>>>>>     Incomming migration calls .load_setup for each device
> > >>>>>>>     (RESTORE_VM, _ACTIVE, STOPPED)
> > >>>>>>>                         |
> > >>>>>>>     For each device, .load_state is called for that device section data
> > >>>>>>>                         |
> > >>>>>>>     At the end, called .load_cleanup for each device and vCPUs are started.
> > >>>>>>>                         |
> > >>>>>>>         (RUNNING, _NONE, _RUNNING)
> > >>>>>>>
> > >>>>>>> Note that:
> > >>>>>>> - Migration post copy is not supported.
> > >>>>>>>
> > >>>>>>> v6 -> v7:
> > >>>>>>> - Fix build failures.
> > >>>>>>>
> > >>>>>>> v5 -> v6:
> > >>>>>>> - Fix build failure.
> > >>>>>>>
> > >>>>>>> v4 -> v5:
> > >>>>>>> - Added decriptive comment about the sequence of access of members of structure
> > >>>>>>>   vfio_device_migration_info to be followed based on Alex's suggestion
> > >>>>>>> - Updated get dirty pages sequence.
> > >>>>>>> - As per Cornelia Huck's suggestion, added callbacks to VFIODeviceOps to
> > >>>>>>>   get_object, save_config and load_config.
> > >>>>>>> - Fixed multiple nit picks.
> > >>>>>>> - Tested live migration with multiple vfio device assigned to a VM.
> > >>>>>>>
> > >>>>>>> v3 -> v4:
> > >>>>>>> - Added one more bit for _RESUMING flag to be set explicitly.
> > >>>>>>> - data_offset field is read-only for user space application.
> > >>>>>>> - data_size is read for every iteration before reading data from migration, that
> > >>>>>>>   is removed assumption that data will be till end of migration region.
> > >>>>>>> - If vendor driver supports mappable sparsed region, map those region during
> > >>>>>>>   setup state of save/load, similarly unmap those from cleanup routines.
> > >>>>>>> - Handles race condition that causes data corruption in migration region during
> > >>>>>>>   save device state by adding mutex and serialiaing save_buffer and
> > >>>>>>>   get_dirty_pages routines.
> > >>>>>>> - Skip called get_dirty_pages routine for mapped MMIO region of device.
> > >>>>>>> - Added trace events.
> > >>>>>>> - Splitted into multiple functional patches.
> > >>>>>>>
> > >>>>>>> v2 -> v3:
> > >>>>>>> - Removed enum of VFIO device states. Defined VFIO device state with 2 bits.
> > >>>>>>> - Re-structured vfio_device_migration_info to keep it minimal and defined action
> > >>>>>>>   on read and write access on its members.
> > >>>>>>>
> > >>>>>>> v1 -> v2:
> > >>>>>>> - Defined MIGRATION region type and sub-type which should be used with region
> > >>>>>>>   type capability.
> > >>>>>>> - Re-structured vfio_device_migration_info. This structure will be placed at 0th
> > >>>>>>>   offset of migration region.
> > >>>>>>> - Replaced ioctl with read/write for trapped part of migration region.
> > >>>>>>> - Added both type of access support, trapped or mmapped, for data section of the
> > >>>>>>>   region.
> > >>>>>>> - Moved PCI device functions to pci file.
> > >>>>>>> - Added iteration to get dirty page bitmap until bitmap for all requested pages
> > >>>>>>>   are copied.
> > >>>>>>>
> > >>>>>>> Thanks,
> > >>>>>>> Kirti
> > >>>>>>>
> > >>>>>>> Kirti Wankhede (13):
> > >>>>>>>   vfio: KABI for migration interface
> > >>>>>>>   vfio: Add function to unmap VFIO region
> > >>>>>>>   vfio: Add vfio_get_object callback to VFIODeviceOps
> > >>>>>>>   vfio: Add save and load functions for VFIO PCI devices
> > >>>>>>>   vfio: Add migration region initialization and finalize function
> > >>>>>>>   vfio: Add VM state change handler to know state of VM
> > >>>>>>>   vfio: Add migration state change notifier
> > >>>>>>>   vfio: Register SaveVMHandlers for VFIO device
> > >>>>>>>   vfio: Add save state functions to SaveVMHandlers
> > >>>>>>>   vfio: Add load state functions to SaveVMHandlers
> > >>>>>>>   vfio: Add function to get dirty page list
> > >>>>>>>   vfio: Add vfio_listerner_log_sync to mark dirty pages
> > >>>>>>>   vfio: Make vfio-pci device migration capable.
> > >>>>>>>
> > >>>>>>>  hw/vfio/Makefile.objs         |   2 +-
> > >>>>>>>  hw/vfio/common.c              |  55 +++
> > >>>>>>>  hw/vfio/migration.c           | 874 ++++++++++++++++++++++++++++++++++++++++++
> > >>>>>>>  hw/vfio/pci.c                 | 137 ++++++-
> > >>>>>>>  hw/vfio/trace-events          |  19 +
> > >>>>>>>  include/hw/vfio/vfio-common.h |  25 ++
> > >>>>>>>  linux-headers/linux/vfio.h    | 166 ++++++++
> > >>>>>>>  7 files changed, 1271 insertions(+), 7 deletions(-)
> > >>>>>>>  create mode 100644 hw/vfio/migration.c
> > >>>>>>>
> > >>>>>>> -- 
> > >>>>>>> 2.7.0
> > >>>>>>>
> > >>>>> --
> > >>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >>> --
> > >>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >>>
> > > 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

