Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497B7C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 22:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3952070B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 22:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3952070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38182 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heRog-0001kc-IN
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 18:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1heRnA-0001JM-0O
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 18:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1heRn8-0007G8-4L
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 18:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1heRn7-00078t-RS
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 18:13:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D3D363086275;
 Fri, 21 Jun 2019 22:13:33 +0000 (UTC)
Received: from x1.home (ovpn-117-35.phx2.redhat.com [10.3.117.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F211F1001B0F;
 Fri, 21 Jun 2019 22:13:25 +0000 (UTC)
Date: Fri, 21 Jun 2019 16:13:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20190621161325.30992675@x1.home>
In-Reply-To: <0242d206-1e2d-c1b0-0131-7375f087a394@nvidia.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-9-git-send-email-kwankhede@nvidia.com>
 <20190620132505.1cf64ac5@x1.home>
 <9256515a-f815-58e1-c9ca-81d64bac6db1@nvidia.com>
 <20190621091638.18127e7a@x1.home>
 <b345a59c-b34d-c589-be78-b7a7690e80b2@nvidia.com>
 <20190621140243.621fd2d7@x1.home>
 <18c8fb0d-c1d7-3b19-4721-7e765237dd1d@nvidia.com>
 <20190621143226.4d23c9f7@x1.home>
 <0242d206-1e2d-c1b0-0131-7375f087a394@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 21 Jun 2019 22:13:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 08/13] vfio: Add save state functions to
 SaveVMHandlers
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

On Sat, 22 Jun 2019 02:35:02 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 6/22/2019 2:02 AM, Alex Williamson wrote:
> > On Sat, 22 Jun 2019 01:37:47 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 6/22/2019 1:32 AM, Alex Williamson wrote:  
> >>> On Sat, 22 Jun 2019 01:08:40 +0530
> >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>     
> >>>> On 6/21/2019 8:46 PM, Alex Williamson wrote:    
> >>>>> On Fri, 21 Jun 2019 12:08:26 +0530
> >>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>>>       
> >>>>>> On 6/21/2019 12:55 AM, Alex Williamson wrote:      
> >>>>>>> On Thu, 20 Jun 2019 20:07:36 +0530
> >>>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>>>>>         
> >>>>>>>> Added .save_live_pending, .save_live_iterate and .save_live_complete_precopy
> >>>>>>>> functions. These functions handles pre-copy and stop-and-copy phase.
> >>>>>>>>
> >>>>>>>> In _SAVING|_RUNNING device state or pre-copy phase:
> >>>>>>>> - read pending_bytes
> >>>>>>>> - read data_offset - indicates kernel driver to write data to staging
> >>>>>>>>   buffer which is mmapped.        
> >>>>>>>
> >>>>>>> Why is data_offset the trigger rather than data_size?  It seems that
> >>>>>>> data_offset can't really change dynamically since it might be mmap'd,
> >>>>>>> so it seems unnatural to bother re-reading it.
> >>>>>>>         
> >>>>>>
> >>>>>> Vendor driver can change data_offset, he can have different data_offset
> >>>>>> for device data and dirty pages bitmap.
> >>>>>>      
> >>>>>>>> - read data_size - amount of data in bytes written by vendor driver in migration
> >>>>>>>>   region.
> >>>>>>>> - if data section is trapped, pread() number of bytes in data_size, from
> >>>>>>>>   data_offset.
> >>>>>>>> - if data section is mmaped, read mmaped buffer of size data_size.
> >>>>>>>> - Write data packet to file stream as below:
> >>>>>>>> {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
> >>>>>>>> VFIO_MIG_FLAG_END_OF_STATE }
> >>>>>>>>
> >>>>>>>> In _SAVING device state or stop-and-copy phase
> >>>>>>>> a. read config space of device and save to migration file stream. This
> >>>>>>>>    doesn't need to be from vendor driver. Any other special config state
> >>>>>>>>    from driver can be saved as data in following iteration.
> >>>>>>>> b. read pending_bytes - indicates kernel driver to write data to staging
> >>>>>>>>    buffer which is mmapped.        
> >>>>>>>
> >>>>>>> Is it pending_bytes or data_offset that triggers the write out of
> >>>>>>> data?  Why pending_bytes vs data_size?  I was interpreting
> >>>>>>> pending_bytes as the total data size while data_size is the size
> >>>>>>> available to read now, so assumed data_size would be more closely
> >>>>>>> aligned to making the data available.
> >>>>>>>         
> >>>>>>
> >>>>>> Sorry, that's my mistake while editing, its read data_offset as in above
> >>>>>> case.
> >>>>>>      
> >>>>>>>> c. read data_size - amount of data in bytes written by vendor driver in
> >>>>>>>>    migration region.
> >>>>>>>> d. if data section is trapped, pread() from data_offset of size data_size.
> >>>>>>>> e. if data section is mmaped, read mmaped buffer of size data_size.        
> >>>>>>>
> >>>>>>> Should this read as "pread() from data_offset of data_size, or
> >>>>>>> optionally if mmap is supported on the data area, read data_size from
> >>>>>>> start of mapped buffer"?  IOW, pread should always work.  Same in
> >>>>>>> previous section.
> >>>>>>>         
> >>>>>>
> >>>>>> ok. I'll update.
> >>>>>>      
> >>>>>>>> f. Write data packet as below:
> >>>>>>>>    {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data}
> >>>>>>>> g. iterate through steps b to f until (pending_bytes > 0)        
> >>>>>>>
> >>>>>>> s/until/while/        
> >>>>>>
> >>>>>> Ok.
> >>>>>>      
> >>>>>>>         
> >>>>>>>> h. Write {VFIO_MIG_FLAG_END_OF_STATE}
> >>>>>>>>
> >>>>>>>> .save_live_iterate runs outside the iothread lock in the migration case, which
> >>>>>>>> could race with asynchronous call to get dirty page list causing data corruption
> >>>>>>>> in mapped migration region. Mutex added here to serial migration buffer read
> >>>>>>>> operation.        
> >>>>>>>
> >>>>>>> Would we be ahead to use different offsets within the region for device
> >>>>>>> data vs dirty bitmap to avoid this?
> >>>>>>>        
> >>>>>>
> >>>>>> Lock will still be required to serialize the read/write operations on
> >>>>>> vfio_device_migration_info structure in the region.
> >>>>>>
> >>>>>>      
> >>>>>>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >>>>>>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >>>>>>>> ---
> >>>>>>>>  hw/vfio/migration.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>>>>>  1 file changed, 212 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >>>>>>>> index fe0887c27664..0a2f30872316 100644
> >>>>>>>> --- a/hw/vfio/migration.c
> >>>>>>>> +++ b/hw/vfio/migration.c
> >>>>>>>> @@ -107,6 +107,111 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
> >>>>>>>>      return 0;
> >>>>>>>>  }
> >>>>>>>>  
> >>>>>>>> +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
> >>>>>>>> +{
> >>>>>>>> +    VFIOMigration *migration = vbasedev->migration;
> >>>>>>>> +    VFIORegion *region = &migration->region.buffer;
> >>>>>>>> +    uint64_t data_offset = 0, data_size = 0;
> >>>>>>>> +    int ret;
> >>>>>>>> +
> >>>>>>>> +    ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
> >>>>>>>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> >>>>>>>> +                                             data_offset));
> >>>>>>>> +    if (ret != sizeof(data_offset)) {
> >>>>>>>> +        error_report("Failed to get migration buffer data offset %d",
> >>>>>>>> +                     ret);
> >>>>>>>> +        return -EINVAL;
> >>>>>>>> +    }
> >>>>>>>> +
> >>>>>>>> +    ret = pread(vbasedev->fd, &data_size, sizeof(data_size),
> >>>>>>>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> >>>>>>>> +                                             data_size));
> >>>>>>>> +    if (ret != sizeof(data_size)) {
> >>>>>>>> +        error_report("Failed to get migration buffer data size %d",
> >>>>>>>> +                     ret);
> >>>>>>>> +        return -EINVAL;
> >>>>>>>> +    }
> >>>>>>>> +
> >>>>>>>> +    if (data_size > 0) {
> >>>>>>>> +        void *buf = NULL;
> >>>>>>>> +        bool buffer_mmaped = false;
> >>>>>>>> +
> >>>>>>>> +        if (region->mmaps) {
> >>>>>>>> +            int i;
> >>>>>>>> +
> >>>>>>>> +            for (i = 0; i < region->nr_mmaps; i++) {
> >>>>>>>> +                if ((data_offset >= region->mmaps[i].offset) &&
> >>>>>>>> +                    (data_offset < region->mmaps[i].offset +
> >>>>>>>> +                                   region->mmaps[i].size)) {
> >>>>>>>> +                    buf = region->mmaps[i].mmap + (data_offset -
> >>>>>>>> +                                                   region->mmaps[i].offset);        
> >>>>>>>
> >>>>>>> So you're expecting that data_offset is somewhere within the data
> >>>>>>> area.  Why doesn't the data always simply start at the beginning of the
> >>>>>>> data area?  ie. data_offset would coincide with the beginning of the
> >>>>>>> mmap'able area (if supported) and be static.  Does this enable some
> >>>>>>> functionality in the vendor driver?        
> >>>>>>
> >>>>>> Do you want to enforce that to vendor driver?
> >>>>>> From the feedback on previous version I thought vendor driver should
> >>>>>> define data_offset within the region
> >>>>>> "I'd suggest that the vendor driver expose a read-only
> >>>>>> data_offset that matches a sparse mmap capability entry should the
> >>>>>> driver support mmap.  The use should always read or write data from the
> >>>>>> vendor defined data_offset"
> >>>>>>
> >>>>>> This also adds flexibility to vendor driver such that vendor driver can
> >>>>>> define different data_offset for device data and dirty page bitmap
> >>>>>> within same mmaped region.      
> >>>>>
> >>>>> I agree, it adds flexibility, the protocol was not evident to me until
> >>>>> I got here though.
> >>>>>       
> >>>>>>>  Does resume data need to be
> >>>>>>> written from the same offset where it's read?        
> >>>>>>
> >>>>>> No, resume data should be written from the data_offset that vendor
> >>>>>> driver provided during resume.      
> >>>
> >>> A)
> >>>     
> >>>>> s/resume/save/?    
> >>>
> >>> B)
> >>>      
> >>>>> Or is this saying that on resume that the vendor driver is requesting a
> >>>>> specific block of data via data_offset?       
> >>>>
> >>>> Correct.    
> >>>
> >>> Which one is correct?  Thanks,
> >>>     
> >>
> >> B is correct.  
> > 
> > Shouldn't data_offset be stored in the migration stream then so we can
> > at least verify that source and target are in sync?   
> 
> Why? data_offset is offset within migration region, nothing to do with
> data stream. While resuming vendor driver can ask data at different
> offset in migration region.

So the data is opaque and the sequencing is opaque, the user should
have no expectation that there's any relationship between where the
data was read from while saving versus where the target device is
requesting the next block be written while resuming.  We have a data
blob and a size and we do what we're told.

> > I'm not getting a
> > sense that this protocol involves any sort of sanity or integrity
> > testing on the vendor driver end, the user can just feed garbage into
> > the device on resume and watch the results :-\  Thanks,
> >  
> 
> vendor driver should be able to do sanity and integrity check within its
> opaque data. If that sanity fails, return failure for access on field in
> migration region structure.

Would that be a synchronous failure on the write of data_size, which
should result in the device_state moving to invalid?  Thanks,

Alex

