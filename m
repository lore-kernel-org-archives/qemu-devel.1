Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74A7C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D8E208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EvKSTv9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D8E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQ3b-0005KD-CL
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55623)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hfQ0r-0003kO-UD
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hfQ0q-0000jQ-GU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:32:05 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hfQ0n-0000QW-1h
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:32:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d10dece0000>; Mon, 24 Jun 2019 07:31:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 24 Jun 2019 07:31:42 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 24 Jun 2019 07:31:42 -0700
Received: from [10.24.70.40] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 14:31:34 +0000
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
 <0242d206-1e2d-c1b0-0131-7375f087a394@nvidia.com>
 <20190621161325.30992675@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <9c334b12-5715-fd02-8060-83058a9e89b7@nvidia.com>
Date: Mon, 24 Jun 2019 20:01:26 +0530
MIME-Version: 1.0
In-Reply-To: <20190621161325.30992675@x1.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561386702; bh=Q13Ipl3p2WJ/6fjYPb0+fhy+5HLNGCFpr8TYfZteCRc=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=EvKSTv9HiahOc8pAxtOBwbN4ErYJInbrXT+2icuDq92vm3AHiHqS2B3CzZKQyNBCz
 bJRiv4BSuB1QRo/WyGkLQGEheDqGD9KOlHezy7KZr6cmmlMZdRrNkZ+ZlWypX47Cj8
 tQolTDgK5miLsouFfeRMH9XAfAIEpLJGgaN2MXglcTwXLk7m5jRBiB8F4jOU/AGrB/
 wkJNg65pbJ2IRXBpcFDiLP7EZgOePe75mexYcuIkf20cp/JRCmkYEqn51g++cUJgr7
 3hg2DTmABq9048q6woe717roFnCGZk24HW4ZGf84C7RawMve5YPtfmCZvJF6a8jlul
 wIn6RsyV3PuEA==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.65
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

<snip>
>>>>>>>>>> +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
>>>>>>>>>> +{
>>>>>>>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>>>>>>>> +    VFIORegion *region = &migration->region.buffer;
>>>>>>>>>> +    uint64_t data_offset = 0, data_size = 0;
>>>>>>>>>> +    int ret;
>>>>>>>>>> +
>>>>>>>>>> +    ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
>>>>>>>>>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
>>>>>>>>>> +                                             data_offset));
>>>>>>>>>> +    if (ret != sizeof(data_offset)) {
>>>>>>>>>> +        error_report("Failed to get migration buffer data offset %d",
>>>>>>>>>> +                     ret);
>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>> +    }
>>>>>>>>>> +
>>>>>>>>>> +    ret = pread(vbasedev->fd, &data_size, sizeof(data_size),
>>>>>>>>>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
>>>>>>>>>> +                                             data_size));
>>>>>>>>>> +    if (ret != sizeof(data_size)) {
>>>>>>>>>> +        error_report("Failed to get migration buffer data size %d",
>>>>>>>>>> +                     ret);
>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>> +    }
>>>>>>>>>> +
>>>>>>>>>> +    if (data_size > 0) {
>>>>>>>>>> +        void *buf = NULL;
>>>>>>>>>> +        bool buffer_mmaped = false;
>>>>>>>>>> +
>>>>>>>>>> +        if (region->mmaps) {
>>>>>>>>>> +            int i;
>>>>>>>>>> +
>>>>>>>>>> +            for (i = 0; i < region->nr_mmaps; i++) {
>>>>>>>>>> +                if ((data_offset >= region->mmaps[i].offset) &&
>>>>>>>>>> +                    (data_offset < region->mmaps[i].offset +
>>>>>>>>>> +                                   region->mmaps[i].size)) {
>>>>>>>>>> +                    buf = region->mmaps[i].mmap + (data_offset -
>>>>>>>>>> +                                                   region->mmaps[i].offset);        
>>>>>>>>>
>>>>>>>>> So you're expecting that data_offset is somewhere within the data
>>>>>>>>> area.  Why doesn't the data always simply start at the beginning of the
>>>>>>>>> data area?  ie. data_offset would coincide with the beginning of the
>>>>>>>>> mmap'able area (if supported) and be static.  Does this enable some
>>>>>>>>> functionality in the vendor driver?        
>>>>>>>>
>>>>>>>> Do you want to enforce that to vendor driver?
>>>>>>>> From the feedback on previous version I thought vendor driver should
>>>>>>>> define data_offset within the region
>>>>>>>> "I'd suggest that the vendor driver expose a read-only
>>>>>>>> data_offset that matches a sparse mmap capability entry should the
>>>>>>>> driver support mmap.  The use should always read or write data from the
>>>>>>>> vendor defined data_offset"
>>>>>>>>
>>>>>>>> This also adds flexibility to vendor driver such that vendor driver can
>>>>>>>> define different data_offset for device data and dirty page bitmap
>>>>>>>> within same mmaped region.      
>>>>>>>
>>>>>>> I agree, it adds flexibility, the protocol was not evident to me until
>>>>>>> I got here though.
>>>>>>>       
>>>>>>>>>  Does resume data need to be
>>>>>>>>> written from the same offset where it's read?        
>>>>>>>>
>>>>>>>> No, resume data should be written from the data_offset that vendor
>>>>>>>> driver provided during resume.      
>>>>>
>>>>> A)
>>>>>     
>>>>>>> s/resume/save/?    
>>>>>
>>>>> B)
>>>>>      
>>>>>>> Or is this saying that on resume that the vendor driver is requesting a
>>>>>>> specific block of data via data_offset?       
>>>>>>
>>>>>> Correct.    
>>>>>
>>>>> Which one is correct?  Thanks,
>>>>>     
>>>>
>>>> B is correct.  
>>>
>>> Shouldn't data_offset be stored in the migration stream then so we can
>>> at least verify that source and target are in sync?   
>>
>> Why? data_offset is offset within migration region, nothing to do with
>> data stream. While resuming vendor driver can ask data at different
>> offset in migration region.
> 
> So the data is opaque and the sequencing is opaque, the user should
> have no expectation that there's any relationship between where the
> data was read from while saving versus where the target device is
> requesting the next block be written while resuming.  We have a data
> blob and a size and we do what we're told.
> 

That's correct.

>>> I'm not getting a
>>> sense that this protocol involves any sort of sanity or integrity
>>> testing on the vendor driver end, the user can just feed garbage into
>>> the device on resume and watch the results :-\  Thanks,
>>>  
>>
>> vendor driver should be able to do sanity and integrity check within its
>> opaque data. If that sanity fails, return failure for access on field in
>> migration region structure.
> 
> Would that be a synchronous failure on the write of data_size, which
> should result in the device_state moving to invalid?  Thanks,
> 

If data section of migration region is mapped, then on write to
data_size, vendor driver should read staging buffer, validate data and
return sizeof(data_size) if success or return error (< 0). If data
section is trapped, then write on data section should return accordingly
on receiving data. On error, migration/restore would fail.

Thanks,
Kirti

