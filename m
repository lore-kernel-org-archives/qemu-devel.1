Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D72DC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 17:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E74120714
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 17:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EuGz+YFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E74120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJh8g-0007Ir-7y
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 13:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jJh84-0006sQ-16
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 13:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jJh82-00072T-A5
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 13:26:15 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13295)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jJh82-00072B-2s
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 13:26:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e84cea70000>; Wed, 01 Apr 2020 10:25:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 01 Apr 2020 10:26:12 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 01 Apr 2020 10:26:12 -0700
Received: from [10.40.163.116] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Apr
 2020 17:26:03 +0000
Subject: Re: [PATCH v17 Kernel 6/7] vfio iommu: Adds flag to indicate dirty
 pages tracking capability support
To: Alex Williamson <alex.williamson@redhat.com>
References: <1585587044-2408-1-git-send-email-kwankhede@nvidia.com>
 <1585587044-2408-7-git-send-email-kwankhede@nvidia.com>
 <20200330145814.32d9b652@w520.home>
 <6c6e6625-6dfd-d885-23fe-511744816d5b@nvidia.com>
 <20200331131539.390259e1@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <ba5227f9-bf22-3a7b-638d-c434f18495f4@nvidia.com>
Date: Wed, 1 Apr 2020 22:55:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331131539.390259e1@w520.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585761959; bh=taNHRDKeHbOBGgZ1OQi2gnI2bfN5+wmqdr+VNSRkuMs=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=EuGz+YFV+d+VNCTX/F1LP7DUrE6b0Pp5GQMCewb3Kc9LN8GhGyzSZ+nHb9xkxOtyh
 8DhCmLc4io8rIh26DDyBn6WPZREKGowGLZMhEa3Bd4PnnzfISj6mGK78P11fqncD3L
 Y5J42hiVb8lnV/sf+10Pd+ExErs6N7wJDGdIf11jw7ZrWNalFE26SfClmd+5wLigNN
 YlDpMeMGOFq21vN2QD6BJU57otGurA4T5WpKLWpaeuyMI0WQodyNFpACiN7qJx0qvn
 enwHO623/rierKIRMnzhuq84rOPvSUG7PGCLkePpno0TmohnD+qTueU29dIz76F78W
 mTGMdVhZDMMow==
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



On 4/1/2020 12:45 AM, Alex Williamson wrote:
> On Wed, 1 Apr 2020 00:38:49 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> On 3/31/2020 2:28 AM, Alex Williamson wrote:
>>> On Mon, 30 Mar 2020 22:20:43 +0530
>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>    
>>>> Flag VFIO_IOMMU_INFO_DIRTY_PGS in VFIO_IOMMU_GET_INFO indicates that driver
>>>> support dirty pages tracking.
>>>>
>>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>>>> ---
>>>>    drivers/vfio/vfio_iommu_type1.c | 3 ++-
>>>>    include/uapi/linux/vfio.h       | 5 +++--
>>>>    2 files changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>> index 266550bd7307..9fe12b425976 100644
>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>> @@ -2390,7 +2390,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>>>>    			info.cap_offset = 0; /* output, no-recopy necessary */
>>>>    		}
>>>>    
>>>> -		info.flags = VFIO_IOMMU_INFO_PGSIZES;
>>>> +		info.flags = VFIO_IOMMU_INFO_PGSIZES |
>>>> +			     VFIO_IOMMU_INFO_DIRTY_PGS;
>>>>    
>>>>    		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
>>>>    
>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>> index e3cbf8b78623..0fe7c9a6f211 100644
>>>> --- a/include/uapi/linux/vfio.h
>>>> +++ b/include/uapi/linux/vfio.h
>>>> @@ -985,8 +985,9 @@ struct vfio_device_feature {
>>>>    struct vfio_iommu_type1_info {
>>>>    	__u32	argsz;
>>>>    	__u32	flags;
>>>> -#define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
>>>> -#define VFIO_IOMMU_INFO_CAPS	(1 << 1)	/* Info supports caps */
>>>> +#define VFIO_IOMMU_INFO_PGSIZES   (1 << 0) /* supported page sizes info */
>>>> +#define VFIO_IOMMU_INFO_CAPS      (1 << 1) /* Info supports caps */
>>>> +#define VFIO_IOMMU_INFO_DIRTY_PGS (1 << 2) /* supports dirty page tracking */
>>>>    	__u64	iova_pgsizes;	/* Bitmap of supported page sizes */
>>>>    	__u32   cap_offset;	/* Offset within info struct of first cap */
>>>>    };
>>>
>>>
>>> As I just mentioned in my reply to Yan, I'm wondering if
>>> VFIO_CHECK_EXTENSION would be a better way to expose this.  The
>>> difference is relatively trivial, but currently the only flag
>>> set by VFIO_IOMMU_GET_INFO is to indicate the presence of a field in
>>> the returned structure.  I think this is largely true of other INFO
>>> ioctls within vfio as well and we're already using the
>>> VFIO_CHECK_EXTENSION ioctl to check supported IOMMU models, and IOMMU
>>> cache coherency.  We'd simply need to define a VFIO_DIRTY_PGS_IOMMU
>>> value (9) and return 1 for that case.  Then when we enable support for
>>> dirt pages that can span multiple mappings, we can add a v2 extensions,
>>> or "MULTI" variant of this extension, since it should be backwards
>>> compatible.
>>>
>>> The v2/multi version will again require that the user provide a zero'd
>>> bitmap, but I don't think that should be a problem as part of the
>>> definition of that version (we won't know if the user is using v1 or
>>> v2, but a v1 user should only retrieve bitmaps that exactly match
>>> existing mappings, where all bits will be written).  Thanks,
>>>
>>> Alex
>>>    
>>
>> I look at these two ioctls as : VFIO_CHECK_EXTENSION is used to get
>> IOMMU type, while VFIO_IOMMU_GET_INFO is used to get properties of a
>> particular IOMMU type, right?
> 
> Not exclusively, see for example VFIO_DMA_CC_IOMMU,
> 
>> Then I think VFIO_IOMMU_INFO_DIRTY_PGS should be part of
>> VFIO_IOMMU_GET_INFO and when we add code for v2/multi, a flag should be
>> added to VFIO_IOMMU_GET_INFO.
> 
> Which burns through flags, which is a far more limited resource than
> our 32bit extension address space, especially when we're already
> planning for one or more extensions to this support.  Thanks,
> 

To use flag from VFIO_IOMMU_GET_INFO was your original suggestion, only 
3 bits are used here as of now.

Thanks,
Kirti

