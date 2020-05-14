Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409DDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BC22065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KDnc5vLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BC22065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZCTC-0007Ci-5A
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 07:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jZCSV-0006Sa-6b
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:55:27 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jZCST-0004HP-6o
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:55:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ebd31210000>; Thu, 14 May 2020 04:53:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 14 May 2020 04:55:23 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 14 May 2020 04:55:23 -0700
Received: from [10.40.103.94] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 May
 2020 11:55:14 +0000
Subject: Re: [PATCH Kernel v19 7/8] vfio iommu: Add migration capability to
 report supported features
To: Alex Williamson <alex.williamson@redhat.com>
References: <1589400279-28522-1-git-send-email-kwankhede@nvidia.com>
 <1589400279-28522-8-git-send-email-kwankhede@nvidia.com>
 <20200513230153.0b5f3729@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <23cb6aae-5212-2bce-6bec-fd893ea84d09@nvidia.com>
Date: Thu, 14 May 2020 17:25:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200513230153.0b5f3729@x1.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1589457185; bh=TC4Hs3akve1qrbifB6Q8+iRwZPlpROjU3NnwvRvVTTE=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=KDnc5vLBGvp5lwZsMjSoL2LmpJ0WmlnHwcH2wZTpAKTcNJXofSqQrZAzmuCJ0r8po
 5fFD7/lSMpHXY5rtTjhP+q3anjq1GpZbihwYii2diE30Xp0Q87eEde4PFcl/wENeax
 RBWJxI2nFwoj+ueShCNBddnYrK+el/Co0wv5u2Mb3uobwYmzlSd//jvGnNF6oW4hIf
 md5l2T9bo8y+45Gq/Oz0q5MnVJIDV5ksUmGtcBo+IAvFzHd2nphrGYxtFk6br+Fj3b
 36lTmsGb4ELeOl9OaSPukBLjatuA+J36uYpBKhSAYOuDCbx5r/wLR0jjsurMBI6H2v
 5AV2awy52JNRg==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 07:55:23
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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



On 5/14/2020 10:31 AM, Alex Williamson wrote:
> On Thu, 14 May 2020 01:34:38 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Added migration capability in IOMMU info chain.
>> User application should check IOMMU info chain for migration capability
>> to use dirty page tracking feature provided by kernel module.
>> User application must check page sizes supported and maximum dirty
>> bitmap size returned by this capability structure for ioctls used to get
>> dirty bitmap.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 24 +++++++++++++++++++++++-
>>   include/uapi/linux/vfio.h       | 21 +++++++++++++++++++++
>>   2 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 4358be26ff80..77351497a9c2 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -2389,6 +2389,22 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
>>   	return ret;
>>   }
>>   
>> +static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
>> +					   struct vfio_info_cap *caps)
>> +{
>> +	struct vfio_iommu_type1_info_cap_migration cap_mig;
>> +
>> +	cap_mig.header.id = VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION;
>> +	cap_mig.header.version = 1;
>> +	cap_mig.flags = VFIO_IOMMU_INFO_CAPS_MIGRATION_DIRTY_PAGE_TRACK;
>> +
>> +	/* support minimum pgsize */
>> +	cap_mig.pgsize_bitmap = (size_t)1 << __ffs(iommu->pgsize_bitmap);
>> +	cap_mig.max_dirty_bitmap_size = DIRTY_BITMAP_SIZE_MAX;
>> +
>> +	return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
>> +}
>> +
>>   static long vfio_iommu_type1_ioctl(void *iommu_data,
>>   				   unsigned int cmd, unsigned long arg)
>>   {
>> @@ -2433,10 +2449,16 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>>   		mutex_lock(&iommu->lock);
>>   		info.flags = VFIO_IOMMU_INFO_PGSIZES;
>>   
>> +		vfio_pgsize_bitmap(iommu);
> 
> 
> Why is it necessary to rebuild the bitmap here?  The user can't get to
> this ioctl until they've added a group to the container and set the
> IOMMU model.
> 
> 
For mdev device, domain is not added to domain_list so 
vfio_pgsize_bitmap() doesn't get called when there is only mdev device 
attached.
Your concern is right though, vfio_pgsize_bitmap() should get populated 
with attach_group,so fixing it by calling vfio_pgsize_bitmap() for mdev 
device when iommu->external_domain is set.

>>   		info.iova_pgsizes = iommu->pgsize_bitmap;
>>   
>> -		ret = vfio_iommu_iova_build_caps(iommu, &caps);
>> +		ret = vfio_iommu_migration_build_caps(iommu, &caps);
>> +
>> +		if (!ret)
>> +			ret = vfio_iommu_iova_build_caps(iommu, &caps);
>> +
>>   		mutex_unlock(&iommu->lock);
>> +
>>   		if (ret)
>>   			return ret;
>>   
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index e3cbf8b78623..c90604322798 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1013,6 +1013,27 @@ struct vfio_iommu_type1_info_cap_iova_range {
>>   	struct	vfio_iova_range iova_ranges[];
>>   };
>>   
>> +/*
>> + * The migration capability allows to report supported features for migration.
>> + *
>> + * The structures below define version 1 of this capability.
>> + *
>> + * pgsize_bitmap: Kernel driver returns supported page sizes bitmap for dirty
>> + * page tracking.
>> + * max_dirty_bitmap_size: Kernel driver returns maximum supported dirty bitmap
>> + * size in bytes to be used by user application for ioctls to get dirty bitmap.
>> + */
>> +#define VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION  1
>> +
>> +struct vfio_iommu_type1_info_cap_migration {
>> +	struct	vfio_info_cap_header header;
>> +	__u32	flags;
>> +	/* supports dirty page tracking */
>> +#define VFIO_IOMMU_INFO_CAPS_MIGRATION_DIRTY_PAGE_TRACK	(1 << 0)
> 
> This flag is a bit redundant to the purpose of this capability, isn't
> it?  I think exposing the capability itself is indicating support for
> dirty page tracking.  We should probably be explicit in the comment
> about exactly what interface this capability implies.  Thanks,
>

Capability is added to provide provision for feature flags that kernel 
driver support, that's where we started right?
Later added pgsize_bitmap and max supported bitmap size as you suggested.
I'm confused now, should I keep this flag here?
Even if the flag is removed, 'flags' field is still required so that 
whenever new feature is added, new flag will be added. That's the whole 
purpose we added this capability. Can we add a field which is not used? 
and we don't know when it will be used in future?

Thanks,
Kirti

> Alex
> 
>> +	__u64	pgsize_bitmap;
>> +	__u64	max_dirty_bitmap_size;		/* in bytes */
>> +};
>> +
>>   #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
>>   
>>   /**
> 

