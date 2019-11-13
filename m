Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B2CC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 19:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB4D206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 19:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lINcAqrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB4D206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUyTb-0006u7-Ew
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 14:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1iUySQ-0006Rz-An
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 14:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1iUySO-00037E-Bh
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 14:37:37 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2577)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1iUySN-00034O-U8
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 14:37:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcc5b810000>; Wed, 13 Nov 2019 11:37:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 13 Nov 2019 11:37:34 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 13 Nov 2019 11:37:34 -0800
Received: from [10.25.73.195] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 19:37:25 +0000
Subject: Re: [PATCH v9 Kernel 2/5] vfio iommu: Add ioctl defination to get
 dirty pages bitmap.
To: Alex Williamson <alex.williamson@redhat.com>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-3-git-send-email-kwankhede@nvidia.com>
 <20191112153020.71406c44@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <324ce4f8-d655-ee37-036c-fc9ef9045bef@nvidia.com>
Date: Thu, 14 Nov 2019 01:07:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191112153020.71406c44@x1.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573673857; bh=6fNZc2mHwEswrolJj1VDa99wf4sYflIbMrzvc45iAFs=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=lINcAqrguOlRieumuvDf33LJlToXpndTmzQVE7Umbdg2fukbs/FsQuO8LG09mLMbT
 dF/mhOYz0CbIHm+Z7Fldewq+TzeeQ4uaSRSgJ2wZ+3HEteE0hYnhBcXgZwlDo384yv
 Tw723jIeUDyHfCS19eTJtlCVaBedNHi3LPT+0PUCMruh4YkMQhNSimTKBdtFuuB4nw
 JSq6cWas/z26CqW2c31HLs9fS2vWKZGW78PEp4ssVBETLzLHpG1VuY7fs0XTc8aKyY
 PpaWTWRGSanA4VBu1VUlvGmtomCLNqtMmGucf3+E0BI8TQ09EikX3n2JPWbmL/NBY8
 uN1SsDxMiLAUQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.143
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
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/13/2019 4:00 AM, Alex Williamson wrote:
> On Tue, 12 Nov 2019 22:33:37 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> All pages pinned by vendor driver through vfio_pin_pages API should be
>> considered as dirty during migration. IOMMU container maintains a list of
>> all such pinned pages. Added an ioctl defination to get bitmap of such
> 
> definition
> 
>> pinned pages for requested IO virtual address range.
> 
> Additionally, all mapped pages are considered dirty when physically
> mapped through to an IOMMU, modulo we discussed devices opting in to
> per page pinning to indicate finer granularity with a TBD mechanism to
> figure out if any non-opt-in devices remain.
> 

You mean, in case of device direct assignment (device pass through)?

>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   include/uapi/linux/vfio.h | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 35b09427ad9f..6fd3822aa610 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -902,6 +902,29 @@ struct vfio_iommu_type1_dma_unmap {
>>   #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
>>   #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
>>   
>> +/**
>> + * VFIO_IOMMU_GET_DIRTY_BITMAP - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
>> + *                                     struct vfio_iommu_type1_dirty_bitmap)
>> + *
>> + * IOCTL to get dirty pages bitmap for IOMMU container during migration.
>> + * Get dirty pages bitmap of given IO virtual addresses range using
>> + * struct vfio_iommu_type1_dirty_bitmap. Caller sets argsz, which is size of
>> + * struct vfio_iommu_type1_dirty_bitmap. User should allocate memory to get
>> + * bitmap and should set size of allocated memory in bitmap_size field.
>> + * One bit is used to represent per page consecutively starting from iova
>> + * offset. Bit set indicates page at that offset from iova is dirty.
>> + */
>> +struct vfio_iommu_type1_dirty_bitmap {
>> +	__u32        argsz;
>> +	__u32        flags;
>> +	__u64        iova;                      /* IO virtual address */
>> +	__u64        size;                      /* Size of iova range */
>> +	__u64        bitmap_size;               /* in bytes */
> 
> This seems redundant.  We can calculate the size of the bitmap based on
> the iova size.
>

But in kernel space, we need to validate the size of memory allocated by 
user instead of assuming user is always correct, right?

>> +	void __user *bitmap;                    /* one bit per page */
> 
> Should we define that as a __u64* to (a) help with the size
> calculation, and (b) assure that we can use 8-byte ops on it?
> 
> However, who defines page size?  Is it necessarily the processor page
> size?  A physical IOMMU may support page sizes other than the CPU page
> size.  It might be more important to indicate the expected page size
> than the bitmap size.  Thanks,
>

I see in QEMU and in vfio_iommu_type1 module, page sizes considered for 
mapping are CPU page size, 4K. Do we still need to have such argument?

Thanks,
Kirti

> Alex
> 
>> +};
>> +
>> +#define VFIO_IOMMU_GET_DIRTY_BITMAP             _IO(VFIO_TYPE, VFIO_BASE + 17)
>> +
>>   /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>>   
>>   /*
> 

