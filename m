Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27845C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21E0207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qK7k1n/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21E0207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWZEe-0004c6-26
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jWZE6-0004DD-8p
 for qemu-devel@nongnu.org; Thu, 07 May 2020 01:37:42 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jWZE4-00024D-T8
 for qemu-devel@nongnu.org; Thu, 07 May 2020 01:37:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eb39e200000>; Wed, 06 May 2020 22:35:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 06 May 2020 22:37:38 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 06 May 2020 22:37:38 -0700
Received: from [10.40.101.152] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 May
 2020 05:37:30 +0000
Subject: Re: [PATCH Kernel v18 6/7] vfio iommu: Add migration capability to
 report supported features
To: Alex Williamson <alex.williamson@redhat.com>
References: <1588607939-26441-1-git-send-email-kwankhede@nvidia.com>
 <1588607939-26441-7-git-send-email-kwankhede@nvidia.com>
 <20200506162738.6e08dbf2@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <79f1a586-52be-ab72-493a-3a3c5ae6e252@nvidia.com>
Date: Thu, 7 May 2020 11:07:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506162738.6e08dbf2@w520.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1588829728; bh=PCZ/GyErkVmvQQTaVhthVdSrM4rEkn03vvTTvcYS51g=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=qK7k1n/XuYPWG8QTVm2YIdD3m5X0DsURRUDzMkwkyUwf3rZgPeW/aLnmXT83cemTu
 znGGEtzKX555pRrzGnA0ij+E9MirxbC66VafQC35tWanKlJq1IusH9oKkCYjCahRan
 nn2x99EWk+TEps7Z2j6YDBd283eAy4YRf3xk5entnyPh+N2HPEKEB6zxFnFQH7eyYY
 lFIMtKx3nvlJUFo25X/aSS2H59IF6h+SQ4nKATyasxCXqbgsgQX7r2LnG3Mn1vz+sy
 ejRXV8NXh/qlye+Uv6KtdKxzAa1G+stOANrmYAr4pSh9cu2iDTMKJkDSED9uZaKDVS
 EpRHE/s9D2Miw==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 01:37:39
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



On 5/7/2020 3:57 AM, Alex Williamson wrote:
> On Mon, 4 May 2020 21:28:58 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Added migration capability in IOMMU info chain.
>> User application should check IOMMU info chain for migration capability
>> to use dirty page tracking feature provided by kernel module.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 15 +++++++++++++++
>>   include/uapi/linux/vfio.h       | 14 ++++++++++++++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 8b27faf1ec38..b38d278d7bff 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -2378,6 +2378,17 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
>>   	return ret;
>>   }
>>   
>> +static int vfio_iommu_migration_build_caps(struct vfio_info_cap *caps)
>> +{
>> +	struct vfio_iommu_type1_info_cap_migration cap_mig;
>> +
>> +	cap_mig.header.id = VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION;
>> +	cap_mig.header.version = 1;
>> +	cap_mig.flags = VFIO_IOMMU_INFO_CAPS_MIGRATION_DIRTY_PAGE_TRACK;
>> +
>> +	return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
>> +}
>> +
>>   static long vfio_iommu_type1_ioctl(void *iommu_data,
>>   				   unsigned int cmd, unsigned long arg)
>>   {
>> @@ -2427,6 +2438,10 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>>   		if (ret)
>>   			return ret;
>>   
>> +		ret = vfio_iommu_migration_build_caps(&caps);
>> +		if (ret)
>> +			return ret;
>> +
>>   		if (caps.size) {
>>   			info.flags |= VFIO_IOMMU_INFO_CAPS;
>>   
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index e3cbf8b78623..df9ce8aaafab 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1013,6 +1013,20 @@ struct vfio_iommu_type1_info_cap_iova_range {
>>   	struct	vfio_iova_range iova_ranges[];
>>   };
>>   
>> +/*
>> + * The migration capability allows to report supported features for migration.
>> + *
>> + * The structures below define version 1 of this capability.
>> + */
>> +#define VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION  1
>> +
>> +struct vfio_iommu_type1_info_cap_migration {
>> +	struct	vfio_info_cap_header header;
>> +	__u32	flags;
>> +	/* supports dirty page tracking */
>> +#define VFIO_IOMMU_INFO_CAPS_MIGRATION_DIRTY_PAGE_TRACK	(1 << 0)
>> +};
>> +
> 
> What about exposing the maximum supported dirty bitmap size and the
> supported page sizes?  Thanks,
> 

How should user application use that?

Thanks,
Kirti

> Alex
> 
>>   #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
>>   
>>   /**
> 

