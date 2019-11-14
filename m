Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DA2C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8F12071B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jninWE+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8F12071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVKJe-0005P6-Gr
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 13:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1iVKI7-0003tV-64
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1iVKI4-0001x6-MO
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:56:27 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12203)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1iVKI2-0001so-N6
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:56:24 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcda31d0000>; Thu, 14 Nov 2019 10:55:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 14 Nov 2019 10:56:20 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 14 Nov 2019 10:56:20 -0800
Received: from [10.25.73.195] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Nov
 2019 18:56:12 +0000
Subject: Re: [PATCH v9 Kernel 2/5] vfio iommu: Add ioctl defination to get
 dirty pages bitmap.
To: Alex Williamson <alex.williamson@redhat.com>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-3-git-send-email-kwankhede@nvidia.com>
 <20191112153020.71406c44@x1.home>
 <324ce4f8-d655-ee37-036c-fc9ef9045bef@nvidia.com>
 <20191113130705.32c6b663@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <7f74a2a1-ba1c-9d4c-dc5e-343ecdd7d6d6@nvidia.com>
Date: Fri, 15 Nov 2019 00:26:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191113130705.32c6b663@x1.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573757725; bh=qP9lJ06acDDo4MrsTFkC4NP5ruzpD9pSYcjb+jGuWcI=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=jninWE+a9+1IkyB3PK4dML4j9SeWfnyRYBnW/fAcLfDDDOIAIAOFoda6wX1QA8vt2
 X/F11Zb5oO/JCgzOxkXntAMRZS2GEhJWjIXfHoqPfLkFwUC7/zvCDrl/iFUVj60/FF
 OI5nrwfHCpjNLjWPq/BzrVqrc2x/xsBlNAA6NigeZFn4N0vARfllrpGG+y+cF1aPib
 +WVpNpf/XnAnr2hxdekKkDUXLX/FOjJGM2cLdHXomEzAR1FoEzf4iaD6qh4VM+4+E+
 B5EFmCL9vbdLuT8JQY3+l9r8XdLqtPQdsAc+oh0orrSiS9oCZjiZrCZi0PQnoTmqcj
 +O/2NU20cuNFw==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.65
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



On 11/14/2019 1:37 AM, Alex Williamson wrote:
> On Thu, 14 Nov 2019 01:07:21 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> On 11/13/2019 4:00 AM, Alex Williamson wrote:
>>> On Tue, 12 Nov 2019 22:33:37 +0530
>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>    
>>>> All pages pinned by vendor driver through vfio_pin_pages API should be
>>>> considered as dirty during migration. IOMMU container maintains a list of
>>>> all such pinned pages. Added an ioctl defination to get bitmap of such
>>>
>>> definition
>>>    
>>>> pinned pages for requested IO virtual address range.
>>>
>>> Additionally, all mapped pages are considered dirty when physically
>>> mapped through to an IOMMU, modulo we discussed devices opting in to
>>> per page pinning to indicate finer granularity with a TBD mechanism to
>>> figure out if any non-opt-in devices remain.
>>>    
>>
>> You mean, in case of device direct assignment (device pass through)?
> 
> Yes, or IOMMU backed mdevs.  If vfio_dmas in the container are fully
> pinned and mapped, then the correct dirty page set is all mapped pages.
> We discussed using the vpfn list as a mechanism for vendor drivers to
> reduce their migration footprint, but we also discussed that we would
> need a way to determine that all participants in the container have
> explicitly pinned their working pages or else we must consider the
> entire potential working set as dirty.
> 

How can vendor driver tell this capability to iommu module? Any suggestions?

>>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>>>> ---
>>>>    include/uapi/linux/vfio.h | 23 +++++++++++++++++++++++
>>>>    1 file changed, 23 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>> index 35b09427ad9f..6fd3822aa610 100644
>>>> --- a/include/uapi/linux/vfio.h
>>>> +++ b/include/uapi/linux/vfio.h
>>>> @@ -902,6 +902,29 @@ struct vfio_iommu_type1_dma_unmap {
>>>>    #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
>>>>    #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
>>>>    
>>>> +/**
>>>> + * VFIO_IOMMU_GET_DIRTY_BITMAP - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
>>>> + *                                     struct vfio_iommu_type1_dirty_bitmap)
>>>> + *
>>>> + * IOCTL to get dirty pages bitmap for IOMMU container during migration.
>>>> + * Get dirty pages bitmap of given IO virtual addresses range using
>>>> + * struct vfio_iommu_type1_dirty_bitmap. Caller sets argsz, which is size of
>>>> + * struct vfio_iommu_type1_dirty_bitmap. User should allocate memory to get
>>>> + * bitmap and should set size of allocated memory in bitmap_size field.
>>>> + * One bit is used to represent per page consecutively starting from iova
>>>> + * offset. Bit set indicates page at that offset from iova is dirty.
>>>> + */
>>>> +struct vfio_iommu_type1_dirty_bitmap {
>>>> +	__u32        argsz;
>>>> +	__u32        flags;
>>>> +	__u64        iova;                      /* IO virtual address */
>>>> +	__u64        size;                      /* Size of iova range */
>>>> +	__u64        bitmap_size;               /* in bytes */
>>>
>>> This seems redundant.  We can calculate the size of the bitmap based on
>>> the iova size.
>>>   
>>
>> But in kernel space, we need to validate the size of memory allocated by
>> user instead of assuming user is always correct, right?
> 
> What does it buy us for the user to tell us the size?  They could be
> wrong, they could be malicious.  The argsz field on the ioctl is mostly
> for the handshake that the user is competent, we should get faults from
> the copy-user operation if it's incorrect.
>

It is to mainly fail safe.

>>>> +	void __user *bitmap;                    /* one bit per page */
>>>
>>> Should we define that as a __u64* to (a) help with the size
>>> calculation, and (b) assure that we can use 8-byte ops on it?
>>>
>>> However, who defines page size?  Is it necessarily the processor page
>>> size?  A physical IOMMU may support page sizes other than the CPU page
>>> size.  It might be more important to indicate the expected page size
>>> than the bitmap size.  Thanks,
>>>   
>>
>> I see in QEMU and in vfio_iommu_type1 module, page sizes considered for
>> mapping are CPU page size, 4K. Do we still need to have such argument?
> 
> That assumption exists for backwards compatibility prior to supporting
> the iova_pgsizes field in vfio_iommu_type1_info.  AFAIK the current
> interface has no page size assumptions and we should not add any.

So userspace has iova_pgsizes information, which can be input to this 
ioctl. Bitmap should be considering smallest page size. Does that makes 
sense?


Thanks,
Kirti

> Thanks,
> 
> Alex
> 

