Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4845C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB08420652
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB08420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52312 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQsB-0000bR-HH
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42682)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hfQr0-00008p-GV
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hfQqy-00057r-GO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:25:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hfQqw-0004f2-NA
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:25:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 507E1308FED5;
 Mon, 24 Jun 2019 15:25:41 +0000 (UTC)
Received: from x1.home (ovpn-117-35.phx2.redhat.com [10.3.117.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B668E1001B13;
 Mon, 24 Jun 2019 15:25:36 +0000 (UTC)
Date: Mon, 24 Jun 2019 09:25:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20190624092535.4b66bac5@x1.home>
In-Reply-To: <72da05c6-eae9-c34c-20e1-da8d4846839d@nvidia.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-2-git-send-email-kwankhede@nvidia.com>
 <20190620111848.1bf70e99@x1.home>
 <ff9f4aeb-1dd2-c44d-e513-b2f4a06ae780@nvidia.com>
 <20190621090343.3be524f5@x1.home>
 <1648d75d-bda3-f5da-2684-312033ae9477@nvidia.com>
 <20190621140039.3820dd5d@x1.home>
 <24404cfe-bb2d-551b-af8f-609a4bdfce38@nvidia.com>
 <20190621160104.6893958f@x1.home>
 <72da05c6-eae9-c34c-20e1-da8d4846839d@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 24 Jun 2019 15:25:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 01/13] vfio: KABI for migration interface
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Jun 2019 20:30:08 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 6/22/2019 3:31 AM, Alex Williamson wrote:
> > On Sat, 22 Jun 2019 02:00:08 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:  
> >> On 6/22/2019 1:30 AM, Alex Williamson wrote:  
> >>> On Sat, 22 Jun 2019 01:05:48 +0530
> >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>     
> >>>> On 6/21/2019 8:33 PM, Alex Williamson wrote:    
> >>>>> On Fri, 21 Jun 2019 11:22:15 +0530
> >>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>>>       
> >>>>>> On 6/20/2019 10:48 PM, Alex Williamson wrote:      
> >>>>>>> On Thu, 20 Jun 2019 20:07:29 +0530
> >>>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>>>>>         
> >>>>>>>> - Defined MIGRATION region type and sub-type.
> >>>>>>>> - Used 3 bits to define VFIO device states.
> >>>>>>>>     Bit 0 => _RUNNING
> >>>>>>>>     Bit 1 => _SAVING
> >>>>>>>>     Bit 2 => _RESUMING
> >>>>>>>>     Combination of these bits defines VFIO device's state during migration
> >>>>>>>>     _STOPPED => All bits 0 indicates VFIO device stopped.
> >>>>>>>>     _RUNNING => Normal VFIO device running state.
> >>>>>>>>     _SAVING | _RUNNING => vCPUs are running, VFIO device is running but start
> >>>>>>>>                           saving state of device i.e. pre-copy state
> >>>>>>>>     _SAVING  => vCPUs are stoppped, VFIO device should be stopped, and
> >>>>>>>>                           save device state,i.e. stop-n-copy state
> >>>>>>>>     _RESUMING => VFIO device resuming state.
> >>>>>>>>     _SAVING | _RESUMING => Invalid state if _SAVING and _RESUMING bits are set
> >>>>>>>> - Defined vfio_device_migration_info structure which will be placed at 0th
> >>>>>>>>   offset of migration region to get/set VFIO device related information.
> >>>>>>>>   Defined members of structure and usage on read/write access:
> >>>>>>>>     * device_state: (read/write)
> >>>>>>>>         To convey VFIO device state to be transitioned to. Only 3 bits are used
> >>>>>>>>         as of now.
> >>>>>>>>     * pending bytes: (read only)
> >>>>>>>>         To get pending bytes yet to be migrated for VFIO device.
> >>>>>>>>     * data_offset: (read only)
> >>>>>>>>         To get data offset in migration from where data exist during _SAVING
> >>>>>>>>         and from where data should be written by user space application during
> >>>>>>>>          _RESUMING state
> >>>>>>>>     * data_size: (read/write)
> >>>>>>>>         To get and set size of data copied in migration region during _SAVING
> >>>>>>>>         and _RESUMING state.
> >>>>>>>>     * start_pfn, page_size, total_pfns: (write only)
> >>>>>>>>         To get bitmap of dirty pages from vendor driver from given
> >>>>>>>>         start address for total_pfns.
> >>>>>>>>     * copied_pfns: (read only)
> >>>>>>>>         To get number of pfns bitmap copied in migration region.
> >>>>>>>>         Vendor driver should copy the bitmap with bits set only for
> >>>>>>>>         pages to be marked dirty in migration region. Vendor driver
> >>>>>>>>         should return 0 if there are 0 pages dirty in requested
> >>>>>>>>         range. Vendor driver should return -1 to mark all pages in the section
> >>>>>>>>         as dirty
> >>>>>>>>
> >>>>>>>> Migration region looks like:
> >>>>>>>>  ------------------------------------------------------------------
> >>>>>>>> |vfio_device_migration_info|    data section                      |
> >>>>>>>> |                          |     ///////////////////////////////  |
> >>>>>>>>  ------------------------------------------------------------------
> >>>>>>>>  ^                              ^                              ^
> >>>>>>>>  offset 0-trapped part        data_offset                 data_size
> >>>>>>>>
> >>>>>>>> Data section is always followed by vfio_device_migration_info
> >>>>>>>> structure in the region, so data_offset will always be none-0.
> >>>>>>>> Offset from where data is copied is decided by kernel driver, data
> >>>>>>>> section can be trapped or mapped depending on how kernel driver
> >>>>>>>> defines data section. If mmapped, then data_offset should be page
> >>>>>>>> aligned, where as initial section which contain
> >>>>>>>> vfio_device_migration_info structure might not end at offset which
> >>>>>>>> is page aligned.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >>>>>>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >>>>>>>> ---
> >>>>>>>>  linux-headers/linux/vfio.h | 71 ++++++++++++++++++++++++++++++++++++++++++++++
> >>>>>>>>  1 file changed, 71 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> >>>>>>>> index 24f505199f83..274ec477eb82 100644
> >>>>>>>> --- a/linux-headers/linux/vfio.h
> >>>>>>>> +++ b/linux-headers/linux/vfio.h
> >>>>>>>> @@ -372,6 +372,77 @@ struct vfio_region_gfx_edid {
> >>>>>>>>   */
> >>>>>>>>  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
> >>>>>>>>  
> >>>>>>>> +/* Migration region type and sub-type */
> >>>>>>>> +#define VFIO_REGION_TYPE_MIGRATION	        (2)
> >>>>>>>> +#define VFIO_REGION_SUBTYPE_MIGRATION	        (1)
> >>>>>>>> +
> >>>>>>>> +/**
> >>>>>>>> + * Structure vfio_device_migration_info is placed at 0th offset of
> >>>>>>>> + * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
> >>>>>>>> + * information. Field accesses from this structure are only supported at their
> >>>>>>>> + * native width and alignment, otherwise should return error.
> >>>>>>>> + *
> >>>>>>>> + * device_state: (read/write)
> >>>>>>>> + *      To indicate vendor driver the state VFIO device should be transitioned
> >>>>>>>> + *      to. If device state transition fails, write to this field return error.
> >>>>>>>> + *      It consists of 3 bits:
> >>>>>>>> + *      - If bit 0 set, indicates _RUNNING state. When its reset, that indicates
> >>>>>>>> + *        _STOPPED state. When device is changed to _STOPPED, driver should stop
> >>>>>>>> + *        device before write returns.
> >>>>>>>> + *      - If bit 1 set, indicates _SAVING state.
> >>>>>>>> + *      - If bit 2 set, indicates _RESUMING state.
> >>>>>>>> + *
> >>>>>>>> + * pending bytes: (read only)
> >>>>>>>> + *      Read pending bytes yet to be migrated from vendor driver
> >>>>>>>> + *
> >>>>>>>> + * data_offset: (read only)
> >>>>>>>> + *      User application should read data_offset in migration region from where
> >>>>>>>> + *      user application should read data during _SAVING state or write data
> >>>>>>>> + *      during _RESUMING state.
> >>>>>>>> + *
> >>>>>>>> + * data_size: (read/write)
> >>>>>>>> + *      User application should read data_size to know data copied in migration
> >>>>>>>> + *      region during _SAVING state and write size of data copied in migration
> >>>>>>>> + *      region during _RESUMING state.
> >>>>>>>> + *
> >>>>>>>> + * start_pfn: (write only)
> >>>>>>>> + *      Start address pfn to get bitmap of dirty pages from vendor driver duing
> >>>>>>>> + *      _SAVING state.
> >>>>>>>> + *
> >>>>>>>> + * page_size: (write only)
> >>>>>>>> + *      User application should write the page_size of pfn.
> >>>>>>>> + *
> >>>>>>>> + * total_pfns: (write only)
> >>>>>>>> + *      Total pfn count from start_pfn for which dirty bitmap is requested.
> >>>>>>>> + *
> >>>>>>>> + * copied_pfns: (read only)
> >>>>>>>> + *      pfn count for which dirty bitmap is copied to migration region.
> >>>>>>>> + *      Vendor driver should copy the bitmap with bits set only for pages to be
> >>>>>>>> + *      marked dirty in migration region.
> >>>>>>>> + *      Vendor driver should return 0 if there are 0 pages dirty in requested
> >>>>>>>> + *      range.
> >>>>>>>> + *      Vendor driver should return -1 to mark all pages in the section as
> >>>>>>>> + *      dirty.        
> >>>>>>>
> >>>>>>> Is the protocol that the user writes start_pfn/page_size/total_pfns in
> >>>>>>> any order and then the read of copied_pfns is what triggers the
> >>>>>>> snapshot?        
> >>>>>>
> >>>>>> Yes.
> >>>>>>      
> >>>>>>>  Are start_pfn/page_size/total_pfns sticky such that a user
> >>>>>>> can write them once and get repeated refreshes of the dirty bitmap by
> >>>>>>> re-reading copied_pfns?        
> >>>>>>
> >>>>>> Yes and that bitmap should be for given range (from start_pfn till
> >>>>>> start_pfn + tolal_pfns).
> >>>>>> Re-reading of copied_pfns is to handle the case where it might be
> >>>>>> possible that vendor driver reserved area for bitmap < total bitmap size
> >>>>>> for range (start_pfn to start_pfn + tolal_pfns), then user will have to
> >>>>>> iterate till copied_pfns == total_pfns or till copied_pfns == 0 (that
> >>>>>> is, there are no pages dirty in rest of the range)      
> >>>>>
> >>>>> So reading copied_pfns triggers the data range to be updated, but the
> >>>>> caller cannot assume it to be synchronous and uses total_pfns to poll
> >>>>> that the update is complete?  How does the vendor driver differentiate
> >>>>> the user polling for the previous update to finish versus requesting a
> >>>>> new update?
> >>>>>       
> >>>>
> >>>> Write on start_pfn/page_size/total_pfns, then read on copied_pfns
> >>>> indicates new update, where as sequential read on copied_pfns indicates
> >>>> polling for previous update.    
> >>>
> >>> Hmm, this seems to contradict the answer to my question above where I
> >>> ask if the write fields are sticky so a user can trigger a refresh via
> >>> copied_pfns.    
> >>
> >> Sorry, how its contradict? pasting it again below:  
> >>>>>>>  Are start_pfn/page_size/total_pfns sticky such that a user
> >>>>>>> can write them once and get repeated refreshes of the dirty bitmap by
> >>>>>>> re-reading copied_pfns?    
> >>>>>>
> >>>>>> Yes and that bitmap should be for given range (from start_pfn till
> >>>>>> start_pfn + tolal_pfns).
> >>>>>> Re-reading of copied_pfns is to handle the case where it might be
> >>>>>> possible that vendor driver reserved area for bitmap < total bitmap    
> >> size  
> >>>>>> for range (start_pfn to start_pfn + tolal_pfns), then user will have to
> >>>>>> iterate till copied_pfns == total_pfns or till copied_pfns == 0 (that
> >>>>>> is, there are no pages dirty in rest of the range)    
> > 
> > Sorry, I guess I misinterpreted again.  So the vendor driver can return
> > copied_pfns < total_pfns if it has a buffer limitation, not as an
> > indication of its background progress in writing out the bitmap.  Just
> > as a proof of concept, let's say the vendor driver has a 1 bit buffer
> > and I write 0 to start_pfn and 3 to total_pfns.  I read copied_pfns,
> > which returns 1, so I read data_offset to find where this 1 bit is
> > located and then read my bit from that location.  This is the dirty
> > state of the first pfn.  I read copied_pfns again and it reports 2,  
> 
> It should report 1 to indicate its data for one pfn.
> 
> > I again read data_offset to find where the data is located, and it's my
> > job to remember that I've already read 1 bit, so 2 means there's only 1
> > bit available and it's the second pfn.  
> 
> No.
> Here 'I' means User application, right?

Yes

> User application knows for how many pfns bitmap he had already received,
> i.e. see 'count' in function vfio_get_dirty_page_list().
> 
> Here copied_pfns is the number of pfns for which bitmap is available in
> buffer. Start address for that bitmap is then calculated by user
> application as :
> ((start_pfn + count) * page_size)
> 
> Then QEMU calls:
> 
> cpu_physical_memory_set_dirty_lebitmap((unsigned long *)buf,
>                                        (start_pfn + count) * page_size,
>                                         copied_pfns);
> 
> >  I read the bit.  I again read
> > copied_pfns, which now reports 3, I read data_offset to find the
> > location of the data, I remember that I've already read 2 bits, so I
> > read my bit into the 3rd pfn.  This seems rather clumsy.
> >  
> 
> Hope above explanation helps.

Still seems rather clumsy, the knowledge of which bit(s) are available
in the buffer can only be known by foreknowledge of which bits have
already been read.  That seems error prone for both the user and the
vendor driver to stay in sync.

> > Now that copied_pfns == total_pfns, what happens if I read copied_pfns
> > again?  This is actually what I thought I was asking previously.
> >   
> 
> It should return 0.

Are we assuming no new pages have been dirtied?  What if pages have
been dirtied?

> > Should we expose the pfn buffer size and fault on writes of larger than that
> > size, requiring the user to iterate start_pfn themselves?  
> 
> Who should fault, vendor driver or user application?
> 
> Here Vendor driver is writing data to data section.
> In the steps in this patch-set, user application is incrementing
> start_pfn by adding copied_pfn count.

The user app is writing total_pfns to get a range, correct?  The vendor
driver could return errno on that write if total_pfns exceeds the
available buffer size.

> >  Are there
> > any operations where the user can assume data_offset is constant?  Thanks,
> >   
> 
> We introduced data_offset not to have such assumption, better not to
> keep such assumption at some place.

I agree if gives you flexibility, it'll be interesting to see how GVT-g
would make use of it, but it also seems very cumbersome for the app,
especially if we choose to implement this iterative read approach
above.  Thanks,

Alex

