Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB778C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB80B205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB80B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgnSd-0007ym-VS
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 05:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49437)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hgnRD-00072o-78
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hgnRB-0002YI-Np
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:44:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34326)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hgnRB-0002XW-Ey
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:44:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 029AE86658;
 Fri, 28 Jun 2019 09:44:56 +0000 (UTC)
Received: from work-vm (ovpn-116-169.ams2.redhat.com [10.36.116.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C067860922;
 Fri, 28 Jun 2019 09:44:49 +0000 (UTC)
Date: Fri, 28 Jun 2019 10:44:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190628094447.GD2922@work-vm>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <20190621002518.GF9303@joy-OptiPlex-7040>
 <20190621012404.GA4173@joy-OptiPlex-7040>
 <67726e08-f159-7054-57a7-36b08f691756@nvidia.com>
 <20190621084627.GC4304@joy-OptiPlex-7040>
 <583faf0d-55e7-0611-3e1c-b4925ca7e533@nvidia.com>
 <20190624190024.GX2726@work-vm>
 <20190626004303.GF6971@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626004303.GF6971@joy-OptiPlex-7040>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 28 Jun 2019 09:44:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

* Yan Zhao (yan.y.zhao@intel.com) wrote:
> On Tue, Jun 25, 2019 at 03:00:24AM +0800, Dr. David Alan Gilbert wrote:
> > * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> > > 
> > > 
> > > On 6/21/2019 2:16 PM, Yan Zhao wrote:
> > > > On Fri, Jun 21, 2019 at 04:02:50PM +0800, Kirti Wankhede wrote:
> > > >>
> > > >>
> > > >> On 6/21/2019 6:54 AM, Yan Zhao wrote:
> > > >>> On Fri, Jun 21, 2019 at 08:25:18AM +0800, Yan Zhao wrote:
> > > >>>> On Thu, Jun 20, 2019 at 10:37:28PM +0800, Kirti Wankhede wrote:
> > > >>>>> Add migration support for VFIO device
> > > >>>>>
> > > >>>>> This Patch set include patches as below:
> > > >>>>> - Define KABI for VFIO device for migration support.
> > > >>>>> - Added save and restore functions for PCI configuration space
> > > >>>>> - Generic migration functionality for VFIO device.
> > > >>>>>   * This patch set adds functionality only for PCI devices, but can be
> > > >>>>>     extended to other VFIO devices.
> > > >>>>>   * Added all the basic functions required for pre-copy, stop-and-copy and
> > > >>>>>     resume phases of migration.
> > > >>>>>   * Added state change notifier and from that notifier function, VFIO
> > > >>>>>     device's state changed is conveyed to VFIO device driver.
> > > >>>>>   * During save setup phase and resume/load setup phase, migration region
> > > >>>>>     is queried and is used to read/write VFIO device data.
> > > >>>>>   * .save_live_pending and .save_live_iterate are implemented to use QEMU's
> > > >>>>>     functionality of iteration during pre-copy phase.
> > > >>>>>   * In .save_live_complete_precopy, that is in stop-and-copy phase,
> > > >>>>>     iteration to read data from VFIO device driver is implemented till pending
> > > >>>>>     bytes returned by driver are not zero.
> > > >>>>>   * Added function to get dirty pages bitmap for the pages which are used by
> > > >>>>>     driver.
> > > >>>>> - Add vfio_listerner_log_sync to mark dirty pages.
> > > >>>>> - Make VFIO PCI device migration capable. If migration region is not provided by
> > > >>>>>   driver, migration is blocked.
> > > >>>>>
> > > >>>>> Below is the flow of state change for live migration where states in brackets
> > > >>>>> represent VM state, migration state and VFIO device state as:
> > > >>>>>     (VM state, MIGRATION_STATUS, VFIO_DEVICE_STATE)
> > > >>>>>
> > > >>>>> Live migration save path:
> > > >>>>>         QEMU normal running state
> > > >>>>>         (RUNNING, _NONE, _RUNNING)
> > > >>>>>                         |
> > > >>>>>     migrate_init spawns migration_thread.
> > > >>>>>     (RUNNING, _SETUP, _RUNNING|_SAVING)
> > > >>>>>     Migration thread then calls each device's .save_setup()
> > > >>>>>                         |
> > > >>>>>     (RUNNING, _ACTIVE, _RUNNING|_SAVING)
> > > >>>>>     If device is active, get pending bytes by .save_live_pending()
> > > >>>>>     if pending bytes >= threshold_size,  call save_live_iterate()
> > > >>>>>     Data of VFIO device for pre-copy phase is copied.
> > > >>>>>     Iterate till pending bytes converge and are less than threshold
> > > >>>>>                         |
> > > >>>>>     On migration completion, vCPUs stops and calls .save_live_complete_precopy
> > > >>>>>     for each active device. VFIO device is then transitioned in
> > > >>>>>      _SAVING state.
> > > >>>>>     (FINISH_MIGRATE, _DEVICE, _SAVING)
> > > >>>>>     For VFIO device, iterate in  .save_live_complete_precopy  until
> > > >>>>>     pending data is 0.
> > > >>>>>     (FINISH_MIGRATE, _DEVICE, _STOPPED)
> > > >>>>
> > > >>>> I suggest we also register to VMStateDescription, whose .pre_save
> > > >>>> handler would get called after .save_live_complete_precopy in pre-copy
> > > >>>> only case, and will called before .save_live_iterate in post-copy
> > > >>>> enabled case.
> > > >>>> In the .pre_save handler, we can save all device state which must be
> > > >>>> copied after device stop in source vm and before device start in target vm.
> > > >>>>
> > > >>> hi
> > > >>> to better describe this idea:
> > > >>>
> > > >>> in pre-copy only case, the flow is
> > > >>>
> > > >>> start migration --> .save_live_iterate (several round) -> stop source vm
> > > >>> --> .save_live_complete_precopy --> .pre_save  -->start target vm
> > > >>> -->migration complete
> > > >>>
> > > >>>
> > > >>> in post-copy enabled case, the flow is
> > > >>>
> > > >>> start migration --> .save_live_iterate (several round) --> start post copy --> 
> > > >>> stop source vm --> .pre_save --> start target vm --> .save_live_iterate (several round) 
> > > >>> -->migration complete
> > > >>>
> > > >>> Therefore, we should put saving of device state in .pre_save interface
> > > >>> rather than in .save_live_complete_precopy. 
> > > >>> The device state includes pci config data, page tables, register state, etc.
> > > >>>
> > > >>> The .save_live_iterate and .save_live_complete_precopy should only deal
> > > >>> with saving dirty memory.
> > > >>>
> > > >>
> > > >> Vendor driver can decide when to save device state depending on the VFIO
> > > >> device state set by user. Vendor driver doesn't have to depend on which
> > > >> callback function QEMU or user application calls. In pre-copy case,
> > > >> save_live_complete_precopy sets VFIO device state to
> > > >> VFIO_DEVICE_STATE_SAVING which means vCPUs are stopped and vendor driver
> > > >> should save all device state.
> > > >>
> > > > when post copy stops vCPUs and vfio device, vendor driver only needs to
> > > > provide device state. but how vendor driver knows that, if no extra
> > > > interface or no extra device state is provides?
> > > > 
> > > 
> > > .save_live_complete_postcopy interface for post-copy will get called,
> > > right?
> > 
> > That happens at the very end; I think the question here is for something
> > that gets called at the point we stop iteratively sending RAM, send the
> > device states and then start sending RAM on demand to the destination
> > as it's running. Typically we send a small set of device state
> > (registers etc) at this point.
> > 
> > I guess there's two different postcopy cases that we need to think
> > about:
> >   a) Where the VFIO device doesn't support postcopy - it just gets
> >   migrated like any other device, so all it's RAM must get sent
> >   before we flip into postcopy mode.
> > 
> >   b) Where the VFIO device does support postcopy - where the pages
> >   get sent on demand.
> > 
> > (b) maybe tricky depending on whether your hardware can fault
> > on pages of your RAM that are needed but not yet transferred;  but
> > if you can that would make life a lot more practical on really
> > big VFO devices.
> > 
> > Dave
> >
> hi Dave,
> so do you think it is good to abstract device state data and save it in
> .pre_save callback?

I'm not sure we have a vmsd/pre_save in this setup?  If we did then it's
a bit confusing because I don't think we have any other iterative device
that also has a vmsd.

I'd have to test it, but I think you might get the devices
->save_live_complete_precopy called at the right point just before
postcopy switchover.  It's worth looking.

Dave

> Thanks
> Yan
> 
> > > Thanks,
> > > Kirti
> > > 
> > > >>>
> > > >>> I know current implementation does not support post-copy. but at least
> > > >>> it should not require huge change when we decide to enable it in future.
> > > >>>
> > > >>
> > > >> .has_postcopy and .save_live_complete_postcopy need to be implemented to
> > > >> support post-copy. I think .save_live_complete_postcopy should be
> > > >> similar to vfio_save_complete_precopy.
> > > >>
> > > >> Thanks,
> > > >> Kirti
> > > >>
> > > >>> Thanks
> > > >>> Yan
> > > >>>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

