Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EADBC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01DE205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LSeCTpWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01DE205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQXG-0000zq-FO
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35882)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hfQSN-0006i0-Cc
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hfQSL-0000lS-5D
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:00:31 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hfQSI-0000Pi-J3
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:00:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d10e5830000>; Mon, 24 Jun 2019 08:00:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 24 Jun 2019 08:00:21 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 24 Jun 2019 08:00:21 -0700
Received: from [10.24.70.40] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 15:00:12 +0000
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
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <72da05c6-eae9-c34c-20e1-da8d4846839d@nvidia.com>
Date: Mon, 24 Jun 2019 20:30:08 +0530
MIME-Version: 1.0
In-Reply-To: <20190621160104.6893958f@x1.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561388419; bh=gIZX+PWP9EDJZFBI9VoOCvNur66adCoPSI/X4p25pWA=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=LSeCTpWTBuIdW234wx6gCcvLltzxf+0WtMFNgDh0dCae32VC2pvfURtQVoI/9E+Wh
 eH4AVjrzPj+oUL9XZFpe3hOQF+zDXBtuC3gCKjmpIxahrG9BoueYF0g1eKKtDBPy1S
 q21uFqmW6FpQyncJlMdj3FT0U8YRW3l/pt+rb/WDgbzqOuMhp7P9hLV7lUfEcQjBoW
 6gcE3S+IXFgW9YvQfi+tfzWuRBlB9HCwhgw8o36NzQFzW4bcKQu+sJem3awayTa4dR
 /BNwc/zNzRW5rKsDlFFAebFa5+Wcdf7YP2dFoN1K+9zVSRCQQ3D8i9AfFPDckaCr1L
 MVO4hHlTudNeQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.143
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



On 6/22/2019 3:31 AM, Alex Williamson wrote:
> On Sat, 22 Jun 2019 02:00:08 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>> On 6/22/2019 1:30 AM, Alex Williamson wrote:
>>> On Sat, 22 Jun 2019 01:05:48 +0530
>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>   
>>>> On 6/21/2019 8:33 PM, Alex Williamson wrote:  
>>>>> On Fri, 21 Jun 2019 11:22:15 +0530
>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>>>     
>>>>>> On 6/20/2019 10:48 PM, Alex Williamson wrote:    
>>>>>>> On Thu, 20 Jun 2019 20:07:29 +0530
>>>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>>>>>       
>>>>>>>> - Defined MIGRATION region type and sub-type.
>>>>>>>> - Used 3 bits to define VFIO device states.
>>>>>>>>     Bit 0 => _RUNNING
>>>>>>>>     Bit 1 => _SAVING
>>>>>>>>     Bit 2 => _RESUMING
>>>>>>>>     Combination of these bits defines VFIO device's state during migration
>>>>>>>>     _STOPPED => All bits 0 indicates VFIO device stopped.
>>>>>>>>     _RUNNING => Normal VFIO device running state.
>>>>>>>>     _SAVING | _RUNNING => vCPUs are running, VFIO device is running but start
>>>>>>>>                           saving state of device i.e. pre-copy state
>>>>>>>>     _SAVING  => vCPUs are stoppped, VFIO device should be stopped, and
>>>>>>>>                           save device state,i.e. stop-n-copy state
>>>>>>>>     _RESUMING => VFIO device resuming state.
>>>>>>>>     _SAVING | _RESUMING => Invalid state if _SAVING and _RESUMING bits are set
>>>>>>>> - Defined vfio_device_migration_info structure which will be placed at 0th
>>>>>>>>   offset of migration region to get/set VFIO device related information.
>>>>>>>>   Defined members of structure and usage on read/write access:
>>>>>>>>     * device_state: (read/write)
>>>>>>>>         To convey VFIO device state to be transitioned to. Only 3 bits are used
>>>>>>>>         as of now.
>>>>>>>>     * pending bytes: (read only)
>>>>>>>>         To get pending bytes yet to be migrated for VFIO device.
>>>>>>>>     * data_offset: (read only)
>>>>>>>>         To get data offset in migration from where data exist during _SAVING
>>>>>>>>         and from where data should be written by user space application during
>>>>>>>>          _RESUMING state
>>>>>>>>     * data_size: (read/write)
>>>>>>>>         To get and set size of data copied in migration region during _SAVING
>>>>>>>>         and _RESUMING state.
>>>>>>>>     * start_pfn, page_size, total_pfns: (write only)
>>>>>>>>         To get bitmap of dirty pages from vendor driver from given
>>>>>>>>         start address for total_pfns.
>>>>>>>>     * copied_pfns: (read only)
>>>>>>>>         To get number of pfns bitmap copied in migration region.
>>>>>>>>         Vendor driver should copy the bitmap with bits set only for
>>>>>>>>         pages to be marked dirty in migration region. Vendor driver
>>>>>>>>         should return 0 if there are 0 pages dirty in requested
>>>>>>>>         range. Vendor driver should return -1 to mark all pages in the section
>>>>>>>>         as dirty
>>>>>>>>
>>>>>>>> Migration region looks like:
>>>>>>>>  ------------------------------------------------------------------
>>>>>>>> |vfio_device_migration_info|    data section                      |
>>>>>>>> |                          |     ///////////////////////////////  |
>>>>>>>>  ------------------------------------------------------------------
>>>>>>>>  ^                              ^                              ^
>>>>>>>>  offset 0-trapped part        data_offset                 data_size
>>>>>>>>
>>>>>>>> Data section is always followed by vfio_device_migration_info
>>>>>>>> structure in the region, so data_offset will always be none-0.
>>>>>>>> Offset from where data is copied is decided by kernel driver, data
>>>>>>>> section can be trapped or mapped depending on how kernel driver
>>>>>>>> defines data section. If mmapped, then data_offset should be page
>>>>>>>> aligned, where as initial section which contain
>>>>>>>> vfio_device_migration_info structure might not end at offset which
>>>>>>>> is page aligned.
>>>>>>>>
>>>>>>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>>>>>>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>>>>>>>> ---
>>>>>>>>  linux-headers/linux/vfio.h | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>  1 file changed, 71 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
>>>>>>>> index 24f505199f83..274ec477eb82 100644
>>>>>>>> --- a/linux-headers/linux/vfio.h
>>>>>>>> +++ b/linux-headers/linux/vfio.h
>>>>>>>> @@ -372,6 +372,77 @@ struct vfio_region_gfx_edid {
>>>>>>>>   */
>>>>>>>>  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
>>>>>>>>  
>>>>>>>> +/* Migration region type and sub-type */
>>>>>>>> +#define VFIO_REGION_TYPE_MIGRATION	        (2)
>>>>>>>> +#define VFIO_REGION_SUBTYPE_MIGRATION	        (1)
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * Structure vfio_device_migration_info is placed at 0th offset of
>>>>>>>> + * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
>>>>>>>> + * information. Field accesses from this structure are only supported at their
>>>>>>>> + * native width and alignment, otherwise should return error.
>>>>>>>> + *
>>>>>>>> + * device_state: (read/write)
>>>>>>>> + *      To indicate vendor driver the state VFIO device should be transitioned
>>>>>>>> + *      to. If device state transition fails, write to this field return error.
>>>>>>>> + *      It consists of 3 bits:
>>>>>>>> + *      - If bit 0 set, indicates _RUNNING state. When its reset, that indicates
>>>>>>>> + *        _STOPPED state. When device is changed to _STOPPED, driver should stop
>>>>>>>> + *        device before write returns.
>>>>>>>> + *      - If bit 1 set, indicates _SAVING state.
>>>>>>>> + *      - If bit 2 set, indicates _RESUMING state.
>>>>>>>> + *
>>>>>>>> + * pending bytes: (read only)
>>>>>>>> + *      Read pending bytes yet to be migrated from vendor driver
>>>>>>>> + *
>>>>>>>> + * data_offset: (read only)
>>>>>>>> + *      User application should read data_offset in migration region from where
>>>>>>>> + *      user application should read data during _SAVING state or write data
>>>>>>>> + *      during _RESUMING state.
>>>>>>>> + *
>>>>>>>> + * data_size: (read/write)
>>>>>>>> + *      User application should read data_size to know data copied in migration
>>>>>>>> + *      region during _SAVING state and write size of data copied in migration
>>>>>>>> + *      region during _RESUMING state.
>>>>>>>> + *
>>>>>>>> + * start_pfn: (write only)
>>>>>>>> + *      Start address pfn to get bitmap of dirty pages from vendor driver duing
>>>>>>>> + *      _SAVING state.
>>>>>>>> + *
>>>>>>>> + * page_size: (write only)
>>>>>>>> + *      User application should write the page_size of pfn.
>>>>>>>> + *
>>>>>>>> + * total_pfns: (write only)
>>>>>>>> + *      Total pfn count from start_pfn for which dirty bitmap is requested.
>>>>>>>> + *
>>>>>>>> + * copied_pfns: (read only)
>>>>>>>> + *      pfn count for which dirty bitmap is copied to migration region.
>>>>>>>> + *      Vendor driver should copy the bitmap with bits set only for pages to be
>>>>>>>> + *      marked dirty in migration region.
>>>>>>>> + *      Vendor driver should return 0 if there are 0 pages dirty in requested
>>>>>>>> + *      range.
>>>>>>>> + *      Vendor driver should return -1 to mark all pages in the section as
>>>>>>>> + *      dirty.      
>>>>>>>
>>>>>>> Is the protocol that the user writes start_pfn/page_size/total_pfns in
>>>>>>> any order and then the read of copied_pfns is what triggers the
>>>>>>> snapshot?      
>>>>>>
>>>>>> Yes.
>>>>>>    
>>>>>>>  Are start_pfn/page_size/total_pfns sticky such that a user
>>>>>>> can write them once and get repeated refreshes of the dirty bitmap by
>>>>>>> re-reading copied_pfns?      
>>>>>>
>>>>>> Yes and that bitmap should be for given range (from start_pfn till
>>>>>> start_pfn + tolal_pfns).
>>>>>> Re-reading of copied_pfns is to handle the case where it might be
>>>>>> possible that vendor driver reserved area for bitmap < total bitmap size
>>>>>> for range (start_pfn to start_pfn + tolal_pfns), then user will have to
>>>>>> iterate till copied_pfns == total_pfns or till copied_pfns == 0 (that
>>>>>> is, there are no pages dirty in rest of the range)    
>>>>>
>>>>> So reading copied_pfns triggers the data range to be updated, but the
>>>>> caller cannot assume it to be synchronous and uses total_pfns to poll
>>>>> that the update is complete?  How does the vendor driver differentiate
>>>>> the user polling for the previous update to finish versus requesting a
>>>>> new update?
>>>>>     
>>>>
>>>> Write on start_pfn/page_size/total_pfns, then read on copied_pfns
>>>> indicates new update, where as sequential read on copied_pfns indicates
>>>> polling for previous update.  
>>>
>>> Hmm, this seems to contradict the answer to my question above where I
>>> ask if the write fields are sticky so a user can trigger a refresh via
>>> copied_pfns.  
>>
>> Sorry, how its contradict? pasting it again below:
>>>>>>>  Are start_pfn/page_size/total_pfns sticky such that a user
>>>>>>> can write them once and get repeated refreshes of the dirty bitmap by
>>>>>>> re-reading copied_pfns?  
>>>>>>
>>>>>> Yes and that bitmap should be for given range (from start_pfn till
>>>>>> start_pfn + tolal_pfns).
>>>>>> Re-reading of copied_pfns is to handle the case where it might be
>>>>>> possible that vendor driver reserved area for bitmap < total bitmap  
>> size
>>>>>> for range (start_pfn to start_pfn + tolal_pfns), then user will have to
>>>>>> iterate till copied_pfns == total_pfns or till copied_pfns == 0 (that
>>>>>> is, there are no pages dirty in rest of the range)  
> 
> Sorry, I guess I misinterpreted again.  So the vendor driver can return
> copied_pfns < total_pfns if it has a buffer limitation, not as an
> indication of its background progress in writing out the bitmap.  Just
> as a proof of concept, let's say the vendor driver has a 1 bit buffer
> and I write 0 to start_pfn and 3 to total_pfns.  I read copied_pfns,
> which returns 1, so I read data_offset to find where this 1 bit is
> located and then read my bit from that location.  This is the dirty
> state of the first pfn.  I read copied_pfns again and it reports 2,

It should report 1 to indicate its data for one pfn.

> I again read data_offset to find where the data is located, and it's my
> job to remember that I've already read 1 bit, so 2 means there's only 1
> bit available and it's the second pfn.

No.
Here 'I' means User application, right?
User application knows for how many pfns bitmap he had already received,
i.e. see 'count' in function vfio_get_dirty_page_list().

Here copied_pfns is the number of pfns for which bitmap is available in
buffer. Start address for that bitmap is then calculated by user
application as :
((start_pfn + count) * page_size)

Then QEMU calls:

cpu_physical_memory_set_dirty_lebitmap((unsigned long *)buf,
                                       (start_pfn + count) * page_size,
                                        copied_pfns);

>  I read the bit.  I again read
> copied_pfns, which now reports 3, I read data_offset to find the
> location of the data, I remember that I've already read 2 bits, so I
> read my bit into the 3rd pfn.  This seems rather clumsy.
>

Hope above explanation helps.

> Now that copied_pfns == total_pfns, what happens if I read copied_pfns
> again?  This is actually what I thought I was asking previously.
> 

It should return 0.

> Should we expose the pfn buffer size and fault on writes of larger than that
> size, requiring the user to iterate start_pfn themselves?

Who should fault, vendor driver or user application?

Here Vendor driver is writing data to data section.
In the steps in this patch-set, user application is incrementing
start_pfn by adding copied_pfn count.

>  Are there
> any operations where the user can assume data_offset is constant?  Thanks,
> 

We introduced data_offset not to have such assumption, better not to
keep such assumption at some place.

Thanks,
Kirti

