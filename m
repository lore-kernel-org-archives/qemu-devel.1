Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E667C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DCE20658
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rEil14Lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DCE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaGj-0000iX-1W
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jHaEf-00061j-4c
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jHaEd-0004Mz-SB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:40:21 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15233)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jHaEd-0004Ln-L2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:40:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7d21140002>; Thu, 26 Mar 2020 14:39:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 26 Mar 2020 14:40:18 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 26 Mar 2020 14:40:18 -0700
Received: from [10.40.103.35] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Mar
 2020 21:39:59 +0000
Subject: Re: [PATCH v16 Kernel 1/7] vfio: KABI for migration interface for
 device state
To: Cornelia Huck <cohuck@redhat.com>
References: <1585078359-20124-1-git-send-email-kwankhede@nvidia.com>
 <1585078359-20124-2-git-send-email-kwankhede@nvidia.com>
 <20200326114150.2b5430b9.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <acfa7027-123f-6acf-769d-59c5991dd331@nvidia.com>
Date: Fri, 27 Mar 2020 03:09:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326114150.2b5430b9.cohuck@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585258772; bh=HTfsOH15X1fJ2ccj2OyOcpNOtjiQiB35/SR79O3J9Zg=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=rEil14Lwu3fQv0lbGxyyBCWfnLbWI5FfdKS9HtGkLntqhFy205GOwkFJSL1VZtzLN
 Lz/m6tK8SMOUfbH+EbUfwNFJlBq0tRstKEBMIoX4lLk9tvyqWXisxJncn2bNoQKIze
 isN9hYrWU6RRkKcaxtf83W0qTDQRAUC3aPhauOmbZ2MY/CGn0iAzWNtEDV9yPyxm82
 f6cpbG/67pa4J2zUKqBMVXXhQw7pg+TiF0TFgUQEPb7W4/zW+axPPGBxCbE31nefRu
 QDXBlfGaFQtE7Fg60PEchkbpA7r8ymkXoNGqdFEjkiA/kXyct1NWO37btEDeNpplyY
 K0s9bfjm0PUIQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.64
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
 kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 alex.williamson@redhat.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/26/2020 4:11 PM, Cornelia Huck wrote:
> On Wed, 25 Mar 2020 01:02:33 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> - Defined MIGRATION region type and sub-type.
>>
>> - Defined vfio_device_migration_info structure which will be placed at the
>>    0th offset of migration region to get/set VFIO device related
>>    information. Defined members of structure and usage on read/write access.
>>
>> - Defined device states and state transition details.
>>
>> - Defined sequence to be followed while saving and resuming VFIO device.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   include/uapi/linux/vfio.h | 228 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 228 insertions(+)
> 
> (...)
> 
>> +struct vfio_device_migration_info {
>> +	__u32 device_state;         /* VFIO device state */
>> +#define VFIO_DEVICE_STATE_STOP      (0)
>> +#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
>> +#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
>> +#define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
>> +#define VFIO_DEVICE_STATE_MASK      (VFIO_DEVICE_STATE_RUNNING | \
>> +				     VFIO_DEVICE_STATE_SAVING |  \
>> +				     VFIO_DEVICE_STATE_RESUMING)
>> +
>> +#define VFIO_DEVICE_STATE_VALID(state) \
>> +	(state & VFIO_DEVICE_STATE_RESUMING ? \
>> +	(state & VFIO_DEVICE_STATE_MASK) == VFIO_DEVICE_STATE_RESUMING : 1)
>> +
>> +#define VFIO_DEVICE_STATE_IS_ERROR(state) \
>> +	((state & VFIO_DEVICE_STATE_MASK) == (VFIO_DEVICE_STATE_SAVING | \
>> +					      VFIO_DEVICE_STATE_RESUMING))
>> +
>> +#define VFIO_DEVICE_STATE_SET_ERROR(state) \
>> +	((state & ~VFIO_DEVICE_STATE_MASK) | VFIO_DEVICE_SATE_SAVING | \
>> +					     VFIO_DEVICE_STATE_RESUMING)
>> +
>> +	__u32 reserved;
>> +	__u64 pending_bytes;
>> +	__u64 data_offset;
>> +	__u64 data_size;
>> +} __attribute__((packed));
> 
> The 'packed' should not even be needed, I think?
> 

Right, Above structure is padded properly. Removing it.

>> +
>>   /*
>>    * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>>    * which allows direct access to non-MSIX registers which happened to be within
> 
> Generally, this looks sane to me; however, we should really have
> something under Documentation/ in the long run that describes how this
> works, so that you can find out about the protocol without having to
> dig through headers.
> 

But the documentation will have almost the same text as in this comment. 
Should we replicate it?

Thanks,
Kirti


