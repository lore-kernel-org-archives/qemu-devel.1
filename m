Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B849C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6E22085A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VM3nmLAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6E22085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33142 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfnRi-0007Hc-Cl
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58346)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hfnFb-0006H7-RX
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hfnFZ-0002GV-EU
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:20:51 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9548)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hfnFU-0001PE-BR
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:20:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d123bb60001>; Tue, 25 Jun 2019 08:20:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 25 Jun 2019 08:20:22 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 25 Jun 2019 08:20:22 -0700
Received: from [10.24.206.166] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Jun
 2019 15:20:16 +0000
To: Alex Williamson <alex.williamson@redhat.com>
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
 <20190624092535.4b66bac5@x1.home>
 <c26273f7-0f05-860c-fb4d-5e8f641140a4@nvidia.com>
 <20190624130103.68deb4cd@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <4c72cdbf-27b3-e98b-6ebf-6a86a67cb9ec@nvidia.com>
Date: Tue, 25 Jun 2019 20:50:13 +0530
MIME-Version: 1.0
In-Reply-To: <20190624130103.68deb4cd@x1.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561476022; bh=keP3TU/xeYBqXlkODCalkajWy5B8RFJBPRLrbuSk0Jg=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=VM3nmLAjC4UdQGJt9Qd6B5J12863dRKT4+QtxlzO6j9Z+uxdTQyOuLIp1ZePTdUsn
 7Br9WbIJkHzU2uWKt5nFEzJxXQ9QZ1nWUmSvj/SLYyS+wDM8ob/EZmBenrR2bmGs7z
 4Gb8ZKKkTfWeDfPPguttDbuMBidM5prQNtHkP9uVF8B4XMWhnStona4cMPbIBU8Xw9
 5mYNxlNqNy6ZIEHmK0GXE5TzjBj2UN+pPl79g/cWMJUWK6KOzM1OZ1yjQGBzimMRd9
 tW28+EsP7B58AVv1yGOtJrkgqE+4GRCbKl0XxWDxLb6j26ER9Sl4xiC//clUrYUfP+
 qbeGe912iNkYQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.65
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, cjia@nvidia.com,
 eskultet@redhat.com, ziye.yang@intel.com, Ken.Xue@amd.com,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 eauger@redhat.com, cohuck@redhat.com, jonathan.davies@nutanix.com,
 felipe@nutanix.com, mlevitsk@redhat.com, changpeng.liu@intel.com,
 zhi.a.wang@intel.com, yan.y.zhao@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/25/2019 12:31 AM, Alex Williamson wrote:
> On Tue, 25 Jun 2019 00:22:16 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> On 6/24/2019 8:55 PM, Alex Williamson wrote:
>>> On Mon, 24 Jun 2019 20:30:08 +0530
>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>   
>>>> On 6/22/2019 3:31 AM, Alex Williamson wrote:  
>>>>> On Sat, 22 Jun 2019 02:00:08 +0530
>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:    
>>>>>> On 6/22/2019 1:30 AM, Alex Williamson wrote:    
>>>>>>> On Sat, 22 Jun 2019 01:05:48 +0530
>>>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>>>>>       
>>>>>>>> On 6/21/2019 8:33 PM, Alex Williamson wrote:      
>>>>>>>>> On Fri, 21 Jun 2019 11:22:15 +0530
>>>>>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>>>>>>>         
>>>>>>>>>> On 6/20/2019 10:48 PM, Alex Williamson wrote:        
>>>>>>>>>>> On Thu, 20 Jun 2019 20:07:29 +0530
>>>>>>>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>>>>>>>>>           
>>>>>>>>>>>> - Defined MIGRATION region type and sub-type.
>>>>>>>>>>>> - Used 3 bits to define VFIO device states.
>>>>>>>>>>>>     Bit 0 => _RUNNING
>>>>>>>>>>>>     Bit 1 => _SAVING
>>>>>>>>>>>>     Bit 2 => _RESUMING
>>>>>>>>>>>>     Combination of these bits defines VFIO device's state during migration
>>>>>>>>>>>>     _STOPPED => All bits 0 indicates VFIO device stopped.
>>>>>>>>>>>>     _RUNNING => Normal VFIO device running state.
>>>>>>>>>>>>     _SAVING | _RUNNING => vCPUs are running, VFIO device is running but start
>>>>>>>>>>>>                           saving state of device i.e. pre-copy state
>>>>>>>>>>>>     _SAVING  => vCPUs are stoppped, VFIO device should be stopped, and
>>>>>>>>>>>>                           save device state,i.e. stop-n-copy state
>>>>>>>>>>>>     _RESUMING => VFIO device resuming state.
>>>>>>>>>>>>     _SAVING | _RESUMING => Invalid state if _SAVING and _RESUMING bits are set
>>>>>>>>>>>> - Defined vfio_device_migration_info structure which will be placed at 0th
>>>>>>>>>>>>   offset of migration region to get/set VFIO device related information.
>>>>>>>>>>>>   Defined members of structure and usage on read/write access:
>>>>>>>>>>>>     * device_state: (read/write)
>>>>>>>>>>>>         To convey VFIO device state to be transitioned to. Only 3 bits are used
>>>>>>>>>>>>         as of now.
>>>>>>>>>>>>     * pending bytes: (read only)
>>>>>>>>>>>>         To get pending bytes yet to be migrated for VFIO device.
>>>>>>>>>>>>     * data_offset: (read only)
>>>>>>>>>>>>         To get data offset in migration from where data exist during _SAVING
>>>>>>>>>>>>         and from where data should be written by user space application during
>>>>>>>>>>>>          _RESUMING state
>>>>>>>>>>>>     * data_size: (read/write)
>>>>>>>>>>>>         To get and set size of data copied in migration region during _SAVING
>>>>>>>>>>>>         and _RESUMING state.
>>>>>>>>>>>>     * start_pfn, page_size, total_pfns: (write only)
>>>>>>>>>>>>         To get bitmap of dirty pages from vendor driver from given
>>>>>>>>>>>>         start address for total_pfns.
>>>>>>>>>>>>     * copied_pfns: (read only)
>>>>>>>>>>>>         To get number of pfns bitmap copied in migration region.
>>>>>>>>>>>>         Vendor driver should copy the bitmap with bits set only for
>>>>>>>>>>>>         pages to be marked dirty in migration region. Vendor driver
>>>>>>>>>>>>         should return 0 if there are 0 pages dirty in requested
>>>>>>>>>>>>         range. Vendor driver should return -1 to mark all pages in the section
>>>>>>>>>>>>         as dirty
>>>>>>>>>>>>
>>>>>>>>>>>> Migration region looks like:
>>>>>>>>>>>>  ------------------------------------------------------------------
>>>>>>>>>>>> |vfio_device_migration_info|    data section                      |
>>>>>>>>>>>> |                          |     ///////////////////////////////  |
>>>>>>>>>>>>  ------------------------------------------------------------------
>>>>>>>>>>>>  ^                              ^                              ^
>>>>>>>>>>>>  offset 0-trapped part        data_offset                 data_size
>>>>>>>>>>>>
>>>>>>>>>>>> Data section is always followed by vfio_device_migration_info
>>>>>>>>>>>> structure in the region, so data_offset will always be none-0.
>>>>>>>>>>>> Offset from where data is copied is decided by kernel driver, data
>>>>>>>>>>>> section can be trapped or mapped depending on how kernel driver
>>>>>>>>>>>> defines data section. If mmapped, then data_offset should be page
>>>>>>>>>>>> aligned, where as initial section which contain
>>>>>>>>>>>> vfio_device_migration_info structure might not end at offset which
>>>>>>>>>>>> is page aligned.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>>>>>>>>>>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>  linux-headers/linux/vfio.h | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>>>  1 file changed, 71 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
>>>>>>>>>>>> index 24f505199f83..274ec477eb82 100644
>>>>>>>>>>>> --- a/linux-headers/linux/vfio.h
>>>>>>>>>>>> +++ b/linux-headers/linux/vfio.h
>>>>>>>>>>>> @@ -372,6 +372,77 @@ struct vfio_region_gfx_edid {
>>>>>>>>>>>>   */
>>>>>>>>>>>>  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
>>>>>>>>>>>>  
>>>>>>>>>>>> +/* Migration region type and sub-type */
>>>>>>>>>>>> +#define VFIO_REGION_TYPE_MIGRATION	        (2)
>>>>>>>>>>>> +#define VFIO_REGION_SUBTYPE_MIGRATION	        (1)
>>>>>>>>>>>> +
>>>>>>>>>>>> +/**
>>>>>>>>>>>> + * Structure vfio_device_migration_info is placed at 0th offset of
>>>>>>>>>>>> + * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
>>>>>>>>>>>> + * information. Field accesses from this structure are only supported at their
>>>>>>>>>>>> + * native width and alignment, otherwise should return error.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * device_state: (read/write)
>>>>>>>>>>>> + *      To indicate vendor driver the state VFIO device should be transitioned
>>>>>>>>>>>> + *      to. If device state transition fails, write to this field return error.
>>>>>>>>>>>> + *      It consists of 3 bits:
>>>>>>>>>>>> + *      - If bit 0 set, indicates _RUNNING state. When its reset, that indicates
>>>>>>>>>>>> + *        _STOPPED state. When device is changed to _STOPPED, driver should stop
>>>>>>>>>>>> + *        device before write returns.
>>>>>>>>>>>> + *      - If bit 1 set, indicates _SAVING state.
>>>>>>>>>>>> + *      - If bit 2 set, indicates _RESUMING state.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * pending bytes: (read only)
>>>>>>>>>>>> + *      Read pending bytes yet to be migrated from vendor driver
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * data_offset: (read only)
>>>>>>>>>>>> + *      User application should read data_offset in migration region from where
>>>>>>>>>>>> + *      user application should read data during _SAVING state or write data
>>>>>>>>>>>> + *      during _RESUMING state.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * data_size: (read/write)
>>>>>>>>>>>> + *      User application should read data_size to know data copied in migration
>>>>>>>>>>>> + *      region during _SAVING state and write size of data copied in migration
>>>>>>>>>>>> + *      region during _RESUMING state.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * start_pfn: (write only)
>>>>>>>>>>>> + *      Start address pfn to get bitmap of dirty pages from vendor driver duing
>>>>>>>>>>>> + *      _SAVING state.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * page_size: (write only)
>>>>>>>>>>>> + *      User application should write the page_size of pfn.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * total_pfns: (write only)
>>>>>>>>>>>> + *      Total pfn count from start_pfn for which dirty bitmap is requested.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * copied_pfns: (read only)
>>>>>>>>>>>> + *      pfn count for which dirty bitmap is copied to migration region.
>>>>>>>>>>>> + *      Vendor driver should copy the bitmap with bits set only for pages to be
>>>>>>>>>>>> + *      marked dirty in migration region.
>>>>>>>>>>>> + *      Vendor driver should return 0 if there are 0 pages dirty in requested
>>>>>>>>>>>> + *      range.
>>>>>>>>>>>> + *      Vendor driver should return -1 to mark all pages in the section as
>>>>>>>>>>>> + *      dirty.          
>>>>>>>>>>>
>>>>>>>>>>> Is the protocol that the user writes start_pfn/page_size/total_pfns in
>>>>>>>>>>> any order and then the read of copied_pfns is what triggers the
>>>>>>>>>>> snapshot?          
>>>>>>>>>>
>>>>>>>>>> Yes.
>>>>>>>>>>        
>>>>>>>>>>>  Are start_pfn/page_size/total_pfns sticky such that a user
>>>>>>>>>>> can write them once and get repeated refreshes of the dirty bitmap by
>>>>>>>>>>> re-reading copied_pfns?          
>>>>>>>>>>
>>>>>>>>>> Yes and that bitmap should be for given range (from start_pfn till
>>>>>>>>>> start_pfn + tolal_pfns).
>>>>>>>>>> Re-reading of copied_pfns is to handle the case where it might be
>>>>>>>>>> possible that vendor driver reserved area for bitmap < total bitmap size
>>>>>>>>>> for range (start_pfn to start_pfn + tolal_pfns), then user will have to
>>>>>>>>>> iterate till copied_pfns == total_pfns or till copied_pfns == 0 (that
>>>>>>>>>> is, there are no pages dirty in rest of the range)        
>>>>>>>>>
>>>>>>>>> So reading copied_pfns triggers the data range to be updated, but the
>>>>>>>>> caller cannot assume it to be synchronous and uses total_pfns to poll
>>>>>>>>> that the update is complete?  How does the vendor driver differentiate
>>>>>>>>> the user polling for the previous update to finish versus requesting a
>>>>>>>>> new update?
>>>>>>>>>         
>>>>>>>>
>>>>>>>> Write on start_pfn/page_size/total_pfns, then read on copied_pfns
>>>>>>>> indicates new update, where as sequential read on copied_pfns indicates
>>>>>>>> polling for previous update.      
>>>>>>>
>>>>>>> Hmm, this seems to contradict the answer to my question above where I
>>>>>>> ask if the write fields are sticky so a user can trigger a refresh via
>>>>>>> copied_pfns.      
>>>>>>
>>>>>> Sorry, how its contradict? pasting it again below:    
>>>>>>>>>>>  Are start_pfn/page_size/total_pfns sticky such that a user
>>>>>>>>>>> can write them once and get repeated refreshes of the dirty bitmap by
>>>>>>>>>>> re-reading copied_pfns?      
>>>>>>>>>>
>>>>>>>>>> Yes and that bitmap should be for given range (from start_pfn till
>>>>>>>>>> start_pfn + tolal_pfns).
>>>>>>>>>> Re-reading of copied_pfns is to handle the case where it might be
>>>>>>>>>> possible that vendor driver reserved area for bitmap < total bitmap      
>>>>>> size    
>>>>>>>>>> for range (start_pfn to start_pfn + tolal_pfns), then user will have to
>>>>>>>>>> iterate till copied_pfns == total_pfns or till copied_pfns == 0 (that
>>>>>>>>>> is, there are no pages dirty in rest of the range)      
>>>>>
>>>>> Sorry, I guess I misinterpreted again.  So the vendor driver can return
>>>>> copied_pfns < total_pfns if it has a buffer limitation, not as an
>>>>> indication of its background progress in writing out the bitmap.  Just
>>>>> as a proof of concept, let's say the vendor driver has a 1 bit buffer
>>>>> and I write 0 to start_pfn and 3 to total_pfns.  I read copied_pfns,
>>>>> which returns 1, so I read data_offset to find where this 1 bit is
>>>>> located and then read my bit from that location.  This is the dirty
>>>>> state of the first pfn.  I read copied_pfns again and it reports 2,    
>>>>
>>>> It should report 1 to indicate its data for one pfn.
>>>>  
>>>>> I again read data_offset to find where the data is located, and it's my
>>>>> job to remember that I've already read 1 bit, so 2 means there's only 1
>>>>> bit available and it's the second pfn.    
>>>>
>>>> No.
>>>> Here 'I' means User application, right?  
>>>
>>> Yes
>>>   
>>>> User application knows for how many pfns bitmap he had already received,
>>>> i.e. see 'count' in function vfio_get_dirty_page_list().
>>>>
>>>> Here copied_pfns is the number of pfns for which bitmap is available in
>>>> buffer. Start address for that bitmap is then calculated by user
>>>> application as :
>>>> ((start_pfn + count) * page_size)
>>>>
>>>> Then QEMU calls:
>>>>
>>>> cpu_physical_memory_set_dirty_lebitmap((unsigned long *)buf,
>>>>                                        (start_pfn + count) * page_size,
>>>>                                         copied_pfns);
>>>>  
>>>>>  I read the bit.  I again read
>>>>> copied_pfns, which now reports 3, I read data_offset to find the
>>>>> location of the data, I remember that I've already read 2 bits, so I
>>>>> read my bit into the 3rd pfn.  This seems rather clumsy.
>>>>>    
>>>>
>>>> Hope above explanation helps.  
>>>
>>> Still seems rather clumsy, the knowledge of which bit(s) are available
>>> in the buffer can only be known by foreknowledge of which bits have
>>> already been read.  That seems error prone for both the user and the
>>> vendor driver to stay in sync.
>>>   
>>>>> Now that copied_pfns == total_pfns, what happens if I read copied_pfns
>>>>> again?  This is actually what I thought I was asking previously.
>>>>>     
>>>>
>>>> It should return 0.  
>>>
>>> Are we assuming no new pages have been dirtied?  What if pages have
>>> been dirtied?
>>>   
>>>>> Should we expose the pfn buffer size and fault on writes of larger than that
>>>>> size, requiring the user to iterate start_pfn themselves?    
>>>>
>>>> Who should fault, vendor driver or user application?
>>>>
>>>> Here Vendor driver is writing data to data section.
>>>> In the steps in this patch-set, user application is incrementing
>>>> start_pfn by adding copied_pfn count.  
>>>
>>> The user app is writing total_pfns to get a range, correct?  The vendor
>>> driver could return errno on that write if total_pfns exceeds the
>>> available buffer size.
>>>   
>>
>> ok. If vendor driver returns error, then will user application retry
>> with smaller size?
> 
> I think we'd need to improve the header to indicate the available size,
> it would seem unreasonable to me to require the user to guess how much
> is available.  Thanks,
> 

Instead of returning error on write to total_pfns, how about writing
updated start_pfn and total_pfns again as below:

count = 0
while (total_pfns > 0) {
    write(start_pfn + count)
    write(page_size)
    write(total_pfns)
    read(copied_pfns)
    read(data_offset)
    read bitmap from data_offset for copied_pfns and mark pages dirty
    if (copied_pfns < total_pfns)
        count += copied_pfns,
        total_pfns -= copied_pfns
}

Thanks,
Kirti

