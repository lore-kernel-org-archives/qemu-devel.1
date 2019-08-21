Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125D3C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 20:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E672339E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 20:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BPXrMYup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E672339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0XIN-00087l-N2
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 16:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1i0XGx-0006vO-3w
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1i0XGt-0007PI-PO
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:31:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1i0XGt-0007MV-9v
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:31:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d5daa380000>; Wed, 21 Aug 2019 13:31:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 21 Aug 2019 13:31:52 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 21 Aug 2019 13:31:52 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 20:31:52 +0000
Received: from [10.24.71.106] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 20:31:45 +0000
To: Alex Williamson <alex.williamson@redhat.com>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-2-git-send-email-kwankhede@nvidia.com>
 <20190716145632.3b73b73d@x1.home>
From: Kirti Wankhede <kwankhede@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <7c1444e8-4c5b-d776-d7c5-2775d53aa4cb@nvidia.com>
Date: Thu, 22 Aug 2019 02:01:41 +0530
MIME-Version: 1.0
In-Reply-To: <20190716145632.3b73b73d@x1.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL109.nvidia.com (172.20.187.15) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1566419512; bh=bmZhyUZZ6bElPdsXusoJ5OEMZrbdhkGr8FNEMY1EDNc=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=BPXrMYupQd0z9xNMqCuCpprrZfWI7rPsQkzk+dWr/zIydhxsvfBYCxK/i396CDjRu
 SjoisH1IVGOovl3EfvVmbGAS8eCDxJ4VBnYoB3TyBMUmCtMKIdSkH65GuPhpG3MTaP
 1ROLDEyp7pIQWmFDE0AVIW2QsiPI+DimKJB2e0bPC9Zty8jhKxKI1mqQcFKdghr1ov
 Tr3wK+B4nfqzQg5uzRnENExTHVUZoHkUkAH/PRMhZM+yWVeVwXnxCnIOfT8FVINxBc
 O03d2OxHm9WKHZjBo0NsWjJNbn0c8sCQu/F2bJ5AGExGjuudE0seeRRc2grf+R9ACF
 b9UFAYOC+hAfg==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.143
Subject: Re: [Qemu-devel] [PATCH v7 01/13] vfio: KABI for migration interface
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


Sorry for the delay.

On 7/17/2019 2:26 AM, Alex Williamson wrote:
> On Tue, 9 Jul 2019 15:19:08 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> - Defined MIGRATION region type and sub-type.
>> - Used 3 bits to define VFIO device states.
>>     Bit 0 => _RUNNING
>>     Bit 1 => _SAVING
>>     Bit 2 => _RESUMING
>>     Combination of these bits defines VFIO device's state during migration
>>     _STOPPED => All bits 0 indicates VFIO device stopped.
>>     _RUNNING => Normal VFIO device running state.
>>     _SAVING | _RUNNING => vCPUs are running, VFIO device is running but start
>>                           saving state of device i.e. pre-copy state
>>     _SAVING  => vCPUs are stoppped, VFIO device should be stopped, and
>>                           save device state,i.e. stop-n-copy state
>>     _RESUMING => VFIO device resuming state.
>>     _SAVING | _RESUMING => Invalid state if _SAVING and _RESUMING bits are set
>> - Defined vfio_device_migration_info structure which will be placed at 0th
>>   offset of migration region to get/set VFIO device related information.
>>   Defined members of structure and usage on read/write access:
>>     * device_state: (read/write)
>>         To convey VFIO device state to be transitioned to. Only 3 bits are used
>>         as of now.
>>     * pending bytes: (read only)
>>         To get pending bytes yet to be migrated for VFIO device.
>>     * data_offset: (read only)
>>         To get data offset in migration from where data exist during _SAVING
>>         and from where data should be written by user space application during
>>          _RESUMING state
>>     * data_size: (read/write)
>>         To get and set size of data copied in migration region during _SAVING
>>         and _RESUMING state.
>>     * start_pfn, page_size, total_pfns: (write only)
>>         To get bitmap of dirty pages from vendor driver from given
>>         start address for total_pfns.
>>     * copied_pfns: (read only)
>>         To get number of pfns bitmap copied in migration region.
>>         Vendor driver should copy the bitmap with bits set only for
>>         pages to be marked dirty in migration region. Vendor driver
>>         should return 0 if there are 0 pages dirty in requested
>>         range. Vendor driver should return -1 to mark all pages in the section
>>         as dirty
>>
>> Migration region looks like:
>>  ------------------------------------------------------------------
>> |vfio_device_migration_info|    data section                      |
>> |                          |     ///////////////////////////////  |
>>  ------------------------------------------------------------------
>>  ^                              ^                              ^
>>  offset 0-trapped part        data_offset                 data_size
>>
>> Data section is always followed by vfio_device_migration_info
>> structure in the region, so data_offset will always be none-0.
>> Offset from where data is copied is decided by kernel driver, data
>> section can be trapped or mapped depending on how kernel driver
>> defines data section. If mmapped, then data_offset should be page
>> aligned, where as initial section which contain
>> vfio_device_migration_info structure might not end at offset which
>> is page aligned.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>  linux-headers/linux/vfio.h | 166 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 166 insertions(+)
>>
>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
>> index 24f505199f83..6696a4600545 100644
>> --- a/linux-headers/linux/vfio.h
>> +++ b/linux-headers/linux/vfio.h
>> @@ -372,6 +372,172 @@ struct vfio_region_gfx_edid {
>>   */
>>  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
>>  
>> +/* Migration region type and sub-type */
>> +#define VFIO_REGION_TYPE_MIGRATION	        (2)
> 
> Region type #2 is already claimed by VFIO_REGION_TYPE_CCW, so this would
> need to be #3 or greater (we should have a reference table somewhere in
> this header as it gets easier to miss claimed entries as the sprawl
> grows).
> 
>> +#define VFIO_REGION_SUBTYPE_MIGRATION	        (1)
>> +
>> +/**
>> + * Structure vfio_device_migration_info is placed at 0th offset of
>> + * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
>> + * information. Field accesses from this structure are only supported at their
>> + * native width and alignment, otherwise should return error.
> 
> This seems like a good unit test, a userspace driver that performs
> unaligned accesses to this space.  I'm afraid the wording above might
> suggest that if there's no error it must work though, which might put
> us in sticky support situations.  Should we say:
> 
> s/should return error/the result is undefined and vendor drivers should
> return an error/
> 
>> + *
>> + * device_state: (read/write)
>> + *      To indicate vendor driver the state VFIO device should be transitioned
>> + *      to. If device state transition fails, write on this field return error.
>> + *      It consists of 3 bits:
>> + *      - If bit 0 set, indicates _RUNNING state. When its reset, that indicates
>> + *        _STOPPED state. When device is changed to _STOPPED, driver should stop
>> + *        device before write() returns.
>> + *      - If bit 1 set, indicates _SAVING state.
>> + *      - If bit 2 set, indicates _RESUMING state.
>> + *      _SAVING and _RESUMING set at the same time is invalid state.
> 
> I think in the previous version there was a question of how we handle
> yet-to-be-defined bits.  For instance, if we defined a
> SUBTYPE_MIGRATIONv2 with the intention of making it backwards
> compatible with this version, do we declare the undefined bits as
> preserved so that the user should do a read-modify-write operation?
> 

Yes, Updating comment accordingly.

>> + * pending bytes: (read only)
>> + *      Number of pending bytes yet to be migrated from vendor driver
> 
> Is this for _SAVING, _RESUMING, or both?
> 

It is for _SAVING only.

>> + *
>> + * data_offset: (read only)
>> + *      User application should read data_offset in migration region from where
>> + *      user application should read device data during _SAVING state or write
>> + *      device data during _RESUMING state or read dirty pages bitmap. See below
>> + *      for detail of sequence to be followed.
>> + *
>> + * data_size: (read/write)
>> + *      User application should read data_size to get size of data copied in
>> + *      migration region during _SAVING state and write size of data copied in
>> + *      migration region during _RESUMING state.
>> + *
>> + * start_pfn: (write only)
>> + *      Start address pfn to get bitmap of dirty pages from vendor driver duing
>> + *      _SAVING state.
> 
> There are some subtleties in PFN that I'm not sure we're accounting for
> here.  Devices operate in an IOVA space, which is defined by DMA_MAP
> calls.  The user says this IOVA maps to this process virtual address.
> When there is no vIOMMU, we can \assume\ that IOVA ~= GPA and therefore
> this interface provides dirty gfns.  However when we have a vIOMMU, we
> don't know the IOVA to GPA mapping, right?  So is it expected that the
> user is calling this with GFNs relative to the device address space
> (IOVA) or relative to the VM address space (GPA)?  For the kernel
> internal mdev interface, the pin pages API is always operating in the
> device view and I think never cares if those are IOVA or GPA.
> 

Its IOVA.

>> + *
>> + * page_size: (write only)
>> + *      User application should write the page_size of pfn.
>> + *
>> + * total_pfns: (write only)
>> + *      Total pfn count from start_pfn for which dirty bitmap is requested.
>> + *
>> + * copied_pfns: (read only)
>> + *      pfn count for which dirty bitmap is copied to migration region.
>> + *      Vendor driver should copy the bitmap with bits set only for pages to be
>> + *      marked dirty in migration region.
>> + *      - Vendor driver should return VFIO_DEVICE_DIRTY_PFNS_NONE if none of the
>> + *        pages are dirty in requested range or rest of the range.
>> + *      - Vendor driver should return VFIO_DEVICE_DIRTY_PFNS_ALL to mark all
>> + *        pages dirty in the given section.
> 
> Does this have the same semantics as _NONE in being able to use it to
> report "all the remaining unreported pfns are dirty"?

Yes. Correcting logic accordingly in next version.

> 
>> + *      - Vendor driver should return pfn count for which bitmap is written in
>> + *        the region.
>> + *
>> + * Migration region looks like:
>> + *  ------------------------------------------------------------------
>> + * |vfio_device_migration_info|    data section                      |
>> + * |                          |     ///////////////////////////////  |
>> + * ------------------------------------------------------------------
>> + *   ^                              ^                              ^
>> + *  offset 0-trapped part        data_offset                 data_size
>> + *
>> + * Data section is always followed by vfio_device_migration_info structure
>> + * in the region, so data_offset will always be none-0. Offset from where data
> 
> s/none-0/non-0/  Or better, non-zero
> 
>> + * is copied is decided by kernel driver, data section can be trapped or
>> + * mapped depending on how kernel driver defines data section. If mmapped,
>> + * then data_offset should be page aligned, where as initial section which
>> + * contain vfio_device_migration_info structure might not end at offset which
>> + * is page aligned.
>> + * Data_offset can be same or different for device data and dirty page bitmap.
>> + * Vendor driver should decide whether to partition data section and how to
>> + * partition the data section. Vendor driver should return data_offset
>> + * accordingly.
> 
> I think we also want to talk about how the mmap support within this
> region is defined by a sparse mmap capability (this is required if
> any of it is mmap capable to support the non-mmap'd header) and the
> vendor driver can make portions of the data section mmap'able and
> others not.  I believe (unless we want to require otherwise) that the
> data_offset to data_offset+data_size range can arbitrarily span mmap
> supported sections to meet the vendor driver's needs.
> 
>> + *
>> + * Sequence to be followed:
>> + * In _SAVING|_RUNNING device state or pre-copy phase:
>> + * a. read pending_bytes. If pending_bytes > 0, go through below steps.
>> + * b. read data_offset, indicates kernel driver to write data to staging buffer
>> + *    which is mmapped.
> 
> There's no requirement that it be mmap'd, right?  The vendor driver has
> the choice whether to support mmap, the user has the choice whether to
> access via mmap or read/write.
> 
>> + * c. read data_size, amount of data in bytes written by vendor driver in
>> + *    migration region.
>> + * d. if data section is trapped, read from data_offset of data_size.
>> + * e. if data section is mmaped, read data_size bytes from mmaped buffer from
>> + *    data_offset in the migration region.
> 
> Is it really necessary to specify these separately?  The user should
> read from data_offset to data_offset+data_size, optionally via direct
> mapped buffer as supported by the sparse mmap support within the region.
> 
>> + * f. Write data_size and data to file stream.
> 
> This is not really part of our specification, the user does whatever
> they want with the data.
> 
>> + * g. iterate through steps a to f while (pending_bytes > 0)
> 
> Is the read of pending_bytes an implicit indication to the vendor
> driver that the data area has been consumed?  If so, should this
> sequence always end with a read of pending_bytes to indicate to the
> vendor driver to flush that data?  I'm assuming there will be gap where
> the user reads save data from the device, does other things, and comes
> back to read more data.
> 
> What assumptions, if any, can the user make about pending_bytes?  For
> instance, if the device is _RUNNING, I assume no assumptions can be
> made, maybe with the exception that it represents the minimum pending
> state at that instant of time.

That's right.

>  The rate at which we're approaching
> convergence might be inferred, but any method to determine that would
> be beyond the scope here.
> 
>> + * In _SAVING device state or stop-and-copy phase:
>> + * a. read config space of device and save to migration file stream. This
>> + *    doesn't need to be from vendor driver. Any other special config state
>> + *    from driver can be saved as data in following iteration.
> 
> This is beyond the scope of the migration interface here (and config
> space is PCI specific).
> 
>> + * b. read pending_bytes.
>> + * c. read data_offset, indicates kernel driver to write data to staging
>> + *    buffer which is mmapped.
> 
> Or not.
> 
>> + * d. read data_size, amount of data in bytes written by vendor driver in
>> + *    migration region.
>> + * e. if data section is trapped, read from data_offset of data_size.
>> + * f. if data section is mmaped, read data_size bytes from mmaped buffer from
>> + *    data_offset in the migration region.
> 
> Same comment as above.
> 
>> + * g. Write data_size and data to file stream
> 
> Outside of the scope.
> 
>> + * h. iterate through steps b to g while (pending_bytes > 0)
> 
> Same question regarding indicating to vendor driver that the buffer has
> been consumed.
> 
>> + *
>> + * When data region is mapped, its user's responsibility to read data from
>> + * data_offset of data_size before moving to next steps.
> 
> Do we really want to condition this on being mmap'd?  This implies that
> when it is not mmap'd the vendor driver tracks the accesses to make
> sure that it was consumed?
> 
>> + * Dirty page tracking is part of RAM copy state, where vendor driver
>> + * provides the bitmap of pages which are dirtied by vendor driver through
>> + * migration region and as part of RAM copy those pages gets copied to file
>> + * stream.
> 
> We're mixing QEMU/VM use cases here, this is only the kernel interface
> spec, which can be used for such things, but is not tied to them.  RAM
> ties to the previous question of the address space and implies we're
> operating in the GFN space while the device really only knows about the
> IOVA space.
> 
>> + *
>> + * To get dirty page bitmap:
>> + * a. write start_pfn, page_size and total_pfns.
> 
> Is it required to write every field every time?  For instance page_size
> seems like it should only ever need to be written once.  Is there any
> ordering required?  It seems like step b) initiates the vendor driver
> to consume these fields, but that's not specified below.
> 
>> + * b. read copied_pfns.
>> + *     - Vendor driver should return VFIO_DEVICE_DIRTY_PFNS_NONE if driver
>> + *       doesn't have any page to report dirty in given range or rest of the
>> + *       range. Exit loop.
>> + *     - Vendor driver should return VFIO_DEVICE_DIRTY_PFNS_ALL to mark all
>> + *       pages dirty for given range. Mark all pages in the range as dirty and
>> + *       exit the loop.
>> + *     - Vendor driver should return copied_pfns and provide bitmap for
>> + *       copied_pfn, which means that bitmap copied for given range contains
>> + *       information for all pages where some bits are 0s and some are 1s.
>> + * c. read data_offset, where vendor driver has written bitmap.
>> + * d. read bitmap from the region or mmaped part of the region.
>> + * e. Iterate through steps a to d while (total copied_pfns < total_pfns)
> 
> I thought there was some automatic iteration built into this interface,
> is that dropped? 

Yes, that was discussed in previous version review.

> The user is now expected to do start_pf +=
> copied_pfns and total_pfns -= copied_pfns themsevles?

Yes.

>  Does anything
> indicate to the vendor driver when the data area has been consumed such
> that resources can be released?
> 

If data section is trapped, then read callback on that region gives
confirmation that data has been consumed.
If data section is mmaped, then there has to be a staging buffer. On
read(data_offset), data should be copied to staging buffer, but vendor
driver doesn't get any indication when the read is done. In this case,
vendor driver should copy data to staging buffer and release resources.

>> + *
>> + * In _RESUMING device state:
>> + * - Load device config state.
> 
> Out of scope.
> 
>> + * - While end of data for this device is not reached, repeat below steps:
>> + *      - read data_size from file stream, read data from file stream of
>> + *        data_size.
> 
> Out of scope, how the user gets the data is a userspace implementation
> detail.  I think the important detail here is simply that each data
> transaction from the _SAVING process is indivisible and must translate
> to a _RESUMING transaction here.
> 
>> + *      - read data_offset from where User application should write data.
>> + *          if region is mmaped, write data of data_size to mmaped region.
>> + *      - write data_size.
>> + *          In case of mmapped region, write on data_size indicates kernel
>> + *          driver that data is written in staging buffer.
>> + *      - if region is trapped, write data of data_size from data_offset.
> 
> Gack!  We need something better here, the sequence should be the same
> regardless of the mechanism used to write the data.
> 

ok.

> It still confuses me how the resuming side can know where (data_offset)
> the incoming data should be written. 

User space application read on data_offset, vendor driver provides this
data_offset

> If we're migrating a !_RUNNING
> device, then I can see how some portion of the device might be directly
> mmap'd and the sequence would be very deterministic.  But if we're
> migrating a _RUNNING device, wouldn't the current data block depend on
> what portions of the device are active, which would be difficult to
> predict?
> 

Vendor driver should be able to predict from the data, for user space
application, data is opaque. See comment below.

>> + *
>> + * For user application, data is opaque. User should write data in the same
>> + * order as received.
>> + */
>> +
>> +struct vfio_device_migration_info {
>> +        __u32 device_state;         /* VFIO device state */
>> +#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
>> +#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
>> +#define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
>> +#define VFIO_DEVICE_STATE_MASK      (VFIO_DEVICE_STATE_RUNNING | \
>> +                                     VFIO_DEVICE_STATE_SAVING | \
>> +                                     VFIO_DEVICE_STATE_RESUMING)
> 
> Yes, we have the mask in here now, but no mention above how the user
> should handle undefined bits.

Updating the comment.

Thanks,
Kirti


>  Thanks,
> 
> Alex
> 
>> +#define VFIO_DEVICE_STATE_INVALID   (VFIO_DEVICE_STATE_SAVING | \
>> +                                     VFIO_DEVICE_STATE_RESUMING)
>> +        __u32 reserved;
>> +        __u64 pending_bytes;
>> +        __u64 data_offset;
>> +        __u64 data_size;
>> +        __u64 start_pfn;
>> +        __u64 page_size;
>> +        __u64 total_pfns;
>> +        __u64 copied_pfns;
>> +#define VFIO_DEVICE_DIRTY_PFNS_NONE     (0)
>> +#define VFIO_DEVICE_DIRTY_PFNS_ALL      (~0ULL)
>> +} __attribute__((packed));
>> +
>>  /*
>>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>>   * which allows direct access to non-MSIX registers which happened to be within
> 

