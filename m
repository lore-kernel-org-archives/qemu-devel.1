Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D261C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF762086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF762086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgyXv-0007KM-8o
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 17:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59659)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yan.y.zhao@intel.com>) id 1hgyWZ-0006n9-51
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1hgyWO-0004fH-Hv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:35:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:31331)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1hgyWJ-0004QY-Sw
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:35:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jun 2019 14:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,429,1557212400"; d="scan'208";a="361644832"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2019 14:34:48 -0700
Date: Fri, 28 Jun 2019 17:28:53 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190628212853.GH6971@joy-OptiPlex-7040>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <20190621002518.GF9303@joy-OptiPlex-7040>
 <20190621012404.GA4173@joy-OptiPlex-7040>
 <67726e08-f159-7054-57a7-36b08f691756@nvidia.com>
 <20190621084627.GC4304@joy-OptiPlex-7040>
 <583faf0d-55e7-0611-3e1c-b4925ca7e533@nvidia.com>
 <20190624190024.GX2726@work-vm>
 <20190626004303.GF6971@joy-OptiPlex-7040>
 <20190628094447.GD2922@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628094447.GD2922@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH v4 00/13] Add migration support for VFIO
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

On Fri, Jun 28, 2019 at 05:44:47PM +0800, Dr. David Alan Gilbert wrote:
> * Yan Zhao (yan.y.zhao@intel.com) wrote:
> > On Tue, Jun 25, 2019 at 03:00:24AM +0800, Dr. David Alan Gilbert wrote:
> > > * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> > > > 
> > > > 
> > > > On 6/21/2019 2:16 PM, Yan Zhao wrote:
> > > > > On Fri, Jun 21, 2019 at 04:02:50PM +0800, Kirti Wankhede wrote:
> > > > >>
> > > > >>
> > > > >> On 6/21/2019 6:54 AM, Yan Zhao wrote:
> > > > >>> On Fri, Jun 21, 2019 at 08:25:18AM +0800, Yan Zhao wrote:
> > > > >>>> On Thu, Jun 20, 2019 at 10:37:28PM +0800, Kirti Wankhede wrote:
> > > > >>>>> Add migration support for VFIO device
> > > > >>>>>
> > > > >>>>> This Patch set include patches as below:
> > > > >>>>> - Define KABI for VFIO device for migration support.
> > > > >>>>> - Added save and restore functions for PCI configuration space
> > > > >>>>> - Generic migration functionality for VFIO device.
> > > > >>>>>   * This patch set adds functionality only for PCI devices, but can be
> > > > >>>>>     extended to other VFIO devices.
> > > > >>>>>   * Added all the basic functions required for pre-copy, stop-and-copy and
> > > > >>>>>     resume phases of migration.
> > > > >>>>>   * Added state change notifier and from that notifier function, VFIO
> > > > >>>>>     device's state changed is conveyed to VFIO device driver.
> > > > >>>>>   * During save setup phase and resume/load setup phase, migration region
> > > > >>>>>     is queried and is used to read/write VFIO device data.
> > > > >>>>>   * .save_live_pending and .save_live_iterate are implemented to use QEMU's
> > > > >>>>>     functionality of iteration during pre-copy phase.
> > > > >>>>>   * In .save_live_complete_precopy, that is in stop-and-copy phase,
> > > > >>>>>     iteration to read data from VFIO device driver is implemented till pending
> > > > >>>>>     bytes returned by driver are not zero.
> > > > >>>>>   * Added function to get dirty pages bitmap for the pages which are used by
> > > > >>>>>     driver.
> > > > >>>>> - Add vfio_listerner_log_sync to mark dirty pages.
> > > > >>>>> - Make VFIO PCI device migration capable. If migration region is not provided by
> > > > >>>>>   driver, migration is blocked.
> > > > >>>>>
> > > > >>>>> Below is the flow of state change for live migration where states in brackets
> > > > >>>>> represent VM state, migration state and VFIO device state as:
> > > > >>>>>     (VM state, MIGRATION_STATUS, VFIO_DEVICE_STATE)
> > > > >>>>>
> > > > >>>>> Live migration save path:
> > > > >>>>>         QEMU normal running state
> > > > >>>>>         (RUNNING, _NONE, _RUNNING)
> > > > >>>>>                         |
> > > > >>>>>     migrate_init spawns migration_thread.
> > > > >>>>>     (RUNNING, _SETUP, _RUNNING|_SAVING)
> > > > >>>>>     Migration thread then calls each device's .save_setup()
> > > > >>>>>                         |
> > > > >>>>>     (RUNNING, _ACTIVE, _RUNNING|_SAVING)
> > > > >>>>>     If device is active, get pending bytes by .save_live_pending()
> > > > >>>>>     if pending bytes >= threshold_size,  call save_live_iterate()
> > > > >>>>>     Data of VFIO device for pre-copy phase is copied.
> > > > >>>>>     Iterate till pending bytes converge and are less than threshold
> > > > >>>>>                         |
> > > > >>>>>     On migration completion, vCPUs stops and calls .save_live_complete_precopy
> > > > >>>>>     for each active device. VFIO device is then transitioned in
> > > > >>>>>      _SAVING state.
> > > > >>>>>     (FINISH_MIGRATE, _DEVICE, _SAVING)
> > > > >>>>>     For VFIO device, iterate in  .save_live_complete_precopy  until
> > > > >>>>>     pending data is 0.
> > > > >>>>>     (FINISH_MIGRATE, _DEVICE, _STOPPED)
> > > > >>>>
> > > > >>>> I suggest we also register to VMStateDescription, whose .pre_save
> > > > >>>> handler would get called after .save_live_complete_precopy in pre-copy
> > > > >>>> only case, and will called before .save_live_iterate in post-copy
> > > > >>>> enabled case.
> > > > >>>> In the .pre_save handler, we can save all device state which must be
> > > > >>>> copied after device stop in source vm and before device start in target vm.
> > > > >>>>
> > > > >>> hi
> > > > >>> to better describe this idea:
> > > > >>>
> > > > >>> in pre-copy only case, the flow is
> > > > >>>
> > > > >>> start migration --> .save_live_iterate (several round) -> stop source vm
> > > > >>> --> .save_live_complete_precopy --> .pre_save  -->start target vm
> > > > >>> -->migration complete
> > > > >>>
> > > > >>>
> > > > >>> in post-copy enabled case, the flow is
> > > > >>>
> > > > >>> start migration --> .save_live_iterate (several round) --> start post copy --> 
> > > > >>> stop source vm --> .pre_save --> start target vm --> .save_live_iterate (several round) 
> > > > >>> -->migration complete
> > > > >>>
> > > > >>> Therefore, we should put saving of device state in .pre_save interface
> > > > >>> rather than in .save_live_complete_precopy. 
> > > > >>> The device state includes pci config data, page tables, register state, etc.
> > > > >>>
> > > > >>> The .save_live_iterate and .save_live_complete_precopy should only deal
> > > > >>> with saving dirty memory.
> > > > >>>
> > > > >>
> > > > >> Vendor driver can decide when to save device state depending on the VFIO
> > > > >> device state set by user. Vendor driver doesn't have to depend on which
> > > > >> callback function QEMU or user application calls. In pre-copy case,
> > > > >> save_live_complete_precopy sets VFIO device state to
> > > > >> VFIO_DEVICE_STATE_SAVING which means vCPUs are stopped and vendor driver
> > > > >> should save all device state.
> > > > >>
> > > > > when post copy stops vCPUs and vfio device, vendor driver only needs to
> > > > > provide device state. but how vendor driver knows that, if no extra
> > > > > interface or no extra device state is provides?
> > > > > 
> > > > 
> > > > .save_live_complete_postcopy interface for post-copy will get called,
> > > > right?
> > > 
> > > That happens at the very end; I think the question here is for something
> > > that gets called at the point we stop iteratively sending RAM, send the
> > > device states and then start sending RAM on demand to the destination
> > > as it's running. Typically we send a small set of device state
> > > (registers etc) at this point.
> > > 
> > > I guess there's two different postcopy cases that we need to think
> > > about:
> > >   a) Where the VFIO device doesn't support postcopy - it just gets
> > >   migrated like any other device, so all it's RAM must get sent
> > >   before we flip into postcopy mode.
> > > 
> > >   b) Where the VFIO device does support postcopy - where the pages
> > >   get sent on demand.
> > > 
> > > (b) maybe tricky depending on whether your hardware can fault
> > > on pages of your RAM that are needed but not yet transferred;  but
> > > if you can that would make life a lot more practical on really
> > > big VFO devices.
> > > 
> > > Dave
> > >
> > hi Dave,
> > so do you think it is good to abstract device state data and save it in
> > .pre_save callback?
> 
> I'm not sure we have a vmsd/pre_save in this setup?  If we did then it's
> a bit confusing because I don't think we have any other iterative device
> that also has a vmsd.
Yes, I tried it. it's ok to register SaveVMHandlers and VMStateDescription at the
same time.

> 
> I'd have to test it, but I think you might get the devices
> ->save_live_complete_precopy called at the right point just before
> postcopy switchover.  It's worth looking.
> 
if a iterative device supports postcopy, then its save_live_complete_precopy
would not get called before postcopy switchover.
However, postcopy may need to save pure device state only data (not memory) at that
time. That's the reason I think we should also register to
VMStateDescription also, as its .pre_save handler would get called at
at that time.

Thanks
Yan

> Dave
> 
> > Thanks
> > Yan
> > 
> > > > Thanks,
> > > > Kirti
> > > > 
> > > > >>>
> > > > >>> I know current implementation does not support post-copy. but at least
> > > > >>> it should not require huge change when we decide to enable it in future.
> > > > >>>
> > > > >>
> > > > >> .has_postcopy and .save_live_complete_postcopy need to be implemented to
> > > > >> support post-copy. I think .save_live_complete_postcopy should be
> > > > >> similar to vfio_save_complete_precopy.
> > > > >>
> > > > >> Thanks,
> > > > >> Kirti
> > > > >>
> > > > >>> Thanks
> > > > >>> Yan
> > > > >>>
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

