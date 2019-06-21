Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84592C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 21:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470692075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 21:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GqpkYqGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470692075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heQkS-0001lm-AT
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 17:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41119)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1heQio-0000uY-Gw
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 17:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1heQim-0001w7-ON
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 17:05:22 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7551)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1heQim-0001tJ-BH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 17:05:20 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d0d468e0000>; Fri, 21 Jun 2019 14:05:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Fri, 21 Jun 2019 14:05:16 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Fri, 21 Jun 2019 14:05:16 -0700
Received: from [10.24.71.210] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Jun
 2019 21:05:07 +0000
To: Alex Williamson <alex.williamson@redhat.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-9-git-send-email-kwankhede@nvidia.com>
 <20190620132505.1cf64ac5@x1.home>
 <9256515a-f815-58e1-c9ca-81d64bac6db1@nvidia.com>
 <20190621091638.18127e7a@x1.home>
 <b345a59c-b34d-c589-be78-b7a7690e80b2@nvidia.com>
 <20190621140243.621fd2d7@x1.home>
 <18c8fb0d-c1d7-3b19-4721-7e765237dd1d@nvidia.com>
 <20190621143226.4d23c9f7@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <0242d206-1e2d-c1b0-0131-7375f087a394@nvidia.com>
Date: Sat, 22 Jun 2019 02:35:02 +0530
MIME-Version: 1.0
In-Reply-To: <20190621143226.4d23c9f7@x1.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561151118; bh=RKXCzr4uZPgOakLy5yrIn8A0OSHp7QEyo17AY/HTS4E=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=GqpkYqGcuI/luKWjR5n7t0GA4qGqZrzqcA0/fhFOvGz5JOoEPPHdG8s9Y7zTpWStu
 UdGXIr6vnFYmuTmYbuj+qeTNPj6Nwq8cHd6eM4MZFPqcug6xjbbf918RN2jg5Dm7Mf
 1Ct+chaCAZZvmbWABGKOW6VEuGELLkWfOH9kRJQ2BDxGpZR04yP+bReKnWfqFYlUQu
 tU1NNwrfkVyldpOmgamtv0yqx6fRosC+LZhoKG53Y5tBLvDqvBWnK/2ficsyOzYDkF
 /sZCg/vyEiDdz71gGDOhO+HnxzrG+uijY/dV6fPBv0mnFMAVc34rhVq/w4+NBDcgp6
 5Xeci3VO/g/Fw==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.64
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



On 6/22/2019 2:02 AM, Alex Williamson wrote:
> On Sat, 22 Jun 2019 01:37:47 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> On 6/22/2019 1:32 AM, Alex Williamson wrote:
>>> On Sat, 22 Jun 2019 01:08:40 +0530
>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>   
>>>> On 6/21/2019 8:46 PM, Alex Williamson wrote:  
>>>>> On Fri, 21 Jun 2019 12:08:26 +0530
>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>>>     
>>>>>> On 6/21/2019 12:55 AM, Alex Williamson wrote:    
>>>>>>> On Thu, 20 Jun 2019 20:07:36 +0530
>>>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>>>>>       
>>>>>>>> Added .save_live_pending, .save_live_iterate and .save_live_complete_precopy
>>>>>>>> functions. These functions handles pre-copy and stop-and-copy phase.
>>>>>>>>
>>>>>>>> In _SAVING|_RUNNING device state or pre-copy phase:
>>>>>>>> - read pending_bytes
>>>>>>>> - read data_offset - indicates kernel driver to write data to staging
>>>>>>>>   buffer which is mmapped.      
>>>>>>>
>>>>>>> Why is data_offset the trigger rather than data_size?  It seems that
>>>>>>> data_offset can't really change dynamically since it might be mmap'd,
>>>>>>> so it seems unnatural to bother re-reading it.
>>>>>>>       
>>>>>>
>>>>>> Vendor driver can change data_offset, he can have different data_offset
>>>>>> for device data and dirty pages bitmap.
>>>>>>    
>>>>>>>> - read data_size - amount of data in bytes written by vendor driver in migration
>>>>>>>>   region.
>>>>>>>> - if data section is trapped, pread() number of bytes in data_size, from
>>>>>>>>   data_offset.
>>>>>>>> - if data section is mmaped, read mmaped buffer of size data_size.
>>>>>>>> - Write data packet to file stream as below:
>>>>>>>> {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
>>>>>>>> VFIO_MIG_FLAG_END_OF_STATE }
>>>>>>>>
>>>>>>>> In _SAVING device state or stop-and-copy phase
>>>>>>>> a. read config space of device and save to migration file stream. This
>>>>>>>>    doesn't need to be from vendor driver. Any other special config state
>>>>>>>>    from driver can be saved as data in following iteration.
>>>>>>>> b. read pending_bytes - indicates kernel driver to write data to staging
>>>>>>>>    buffer which is mmapped.      
>>>>>>>
>>>>>>> Is it pending_bytes or data_offset that triggers the write out of
>>>>>>> data?  Why pending_bytes vs data_size?  I was interpreting
>>>>>>> pending_bytes as the total data size while data_size is the size
>>>>>>> available to read now, so assumed data_size would be more closely
>>>>>>> aligned to making the data available.
>>>>>>>       
>>>>>>
>>>>>> Sorry, that's my mistake while editing, its read data_offset as in above
>>>>>> case.
>>>>>>    
>>>>>>>> c. read data_size - amount of data in bytes written by vendor driver in
>>>>>>>>    migration region.
>>>>>>>> d. if data section is trapped, pread() from data_offset of size data_size.
>>>>>>>> e. if data section is mmaped, read mmaped buffer of size data_size.      
>>>>>>>
>>>>>>> Should this read as "pread() from data_offset of data_size, or
>>>>>>> optionally if mmap is supported on the data area, read data_size from
>>>>>>> start of mapped buffer"?  IOW, pread should always work.  Same in
>>>>>>> previous section.
>>>>>>>       
>>>>>>
>>>>>> ok. I'll update.
>>>>>>    
>>>>>>>> f. Write data packet as below:
>>>>>>>>    {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data}
>>>>>>>> g. iterate through steps b to f until (pending_bytes > 0)      
>>>>>>>
>>>>>>> s/until/while/      
>>>>>>
>>>>>> Ok.
>>>>>>    
>>>>>>>       
>>>>>>>> h. Write {VFIO_MIG_FLAG_END_OF_STATE}
>>>>>>>>
>>>>>>>> .save_live_iterate runs outside the iothread lock in the migration case, which
>>>>>>>> could race with asynchronous call to get dirty page list causing data corruption
>>>>>>>> in mapped migration region. Mutex added here to serial migration buffer read
>>>>>>>> operation.      
>>>>>>>
>>>>>>> Would we be ahead to use different offsets within the region for device
>>>>>>> data vs dirty bitmap to avoid this?
>>>>>>>      
>>>>>>
>>>>>> Lock will still be required to serialize the read/write operations on
>>>>>> vfio_device_migration_info structure in the region.
>>>>>>
>>>>>>    
>>>>>>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>>>>>>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>>>>>>>> ---
>>>>>>>>  hw/vfio/migration.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>  1 file changed, 212 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>>>>> index fe0887c27664..0a2f30872316 100644
>>>>>>>> --- a/hw/vfio/migration.c
>>>>>>>> +++ b/hw/vfio/migration.c
>>>>>>>> @@ -107,6 +107,111 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
>>>>>>>>      return 0;
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
>>>>>>>> +{
>>>>>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>>>>>> +    VFIORegion *region = &migration->region.buffer;
>>>>>>>> +    uint64_t data_offset = 0, data_size = 0;
>>>>>>>> +    int ret;
>>>>>>>> +
>>>>>>>> +    ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
>>>>>>>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
>>>>>>>> +                                             data_offset));
>>>>>>>> +    if (ret != sizeof(data_offset)) {
>>>>>>>> +        error_report("Failed to get migration buffer data offset %d",
>>>>>>>> +                     ret);
>>>>>>>> +        return -EINVAL;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    ret = pread(vbasedev->fd, &data_size, sizeof(data_size),
>>>>>>>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
>>>>>>>> +                                             data_size));
>>>>>>>> +    if (ret != sizeof(data_size)) {
>>>>>>>> +        error_report("Failed to get migration buffer data size %d",
>>>>>>>> +                     ret);
>>>>>>>> +        return -EINVAL;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    if (data_size > 0) {
>>>>>>>> +        void *buf = NULL;
>>>>>>>> +        bool buffer_mmaped = false;
>>>>>>>> +
>>>>>>>> +        if (region->mmaps) {
>>>>>>>> +            int i;
>>>>>>>> +
>>>>>>>> +            for (i = 0; i < region->nr_mmaps; i++) {
>>>>>>>> +                if ((data_offset >= region->mmaps[i].offset) &&
>>>>>>>> +                    (data_offset < region->mmaps[i].offset +
>>>>>>>> +                                   region->mmaps[i].size)) {
>>>>>>>> +                    buf = region->mmaps[i].mmap + (data_offset -
>>>>>>>> +                                                   region->mmaps[i].offset);      
>>>>>>>
>>>>>>> So you're expecting that data_offset is somewhere within the data
>>>>>>> area.  Why doesn't the data always simply start at the beginning of the
>>>>>>> data area?  ie. data_offset would coincide with the beginning of the
>>>>>>> mmap'able area (if supported) and be static.  Does this enable some
>>>>>>> functionality in the vendor driver?      
>>>>>>
>>>>>> Do you want to enforce that to vendor driver?
>>>>>> From the feedback on previous version I thought vendor driver should
>>>>>> define data_offset within the region
>>>>>> "I'd suggest that the vendor driver expose a read-only
>>>>>> data_offset that matches a sparse mmap capability entry should the
>>>>>> driver support mmap.  The use should always read or write data from the
>>>>>> vendor defined data_offset"
>>>>>>
>>>>>> This also adds flexibility to vendor driver such that vendor driver can
>>>>>> define different data_offset for device data and dirty page bitmap
>>>>>> within same mmaped region.    
>>>>>
>>>>> I agree, it adds flexibility, the protocol was not evident to me until
>>>>> I got here though.
>>>>>     
>>>>>>>  Does resume data need to be
>>>>>>> written from the same offset where it's read?      
>>>>>>
>>>>>> No, resume data should be written from the data_offset that vendor
>>>>>> driver provided during resume.    
>>>
>>> A)
>>>   
>>>>> s/resume/save/?  
>>>
>>> B)
>>>    
>>>>> Or is this saying that on resume that the vendor driver is requesting a
>>>>> specific block of data via data_offset?     
>>>>
>>>> Correct.  
>>>
>>> Which one is correct?  Thanks,
>>>   
>>
>> B is correct.
> 
> Shouldn't data_offset be stored in the migration stream then so we can
> at least verify that source and target are in sync? 

Why? data_offset is offset within migration region, nothing to do with
data stream. While resuming vendor driver can ask data at different
offset in migration region.

> I'm not getting a
> sense that this protocol involves any sort of sanity or integrity
> testing on the vendor driver end, the user can just feed garbage into
> the device on resume and watch the results :-\  Thanks,
>

vendor driver should be able to do sanity and integrity check within its
opaque data. If that sanity fails, return failure for access on field in
migration region structure.

Thanks,
Kirti

> Alex
> 

