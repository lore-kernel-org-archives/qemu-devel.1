Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B472FC7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 18:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 832492084C
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 18:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gQ50M2X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832492084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoBXz-0006zA-Ft
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 14:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53736)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hoBXp-0006SS-HS
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 14:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hoBXo-0007bW-KH
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 14:54:21 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6597)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hoBXo-0007ab-CD
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 14:54:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d30c0600000>; Thu, 18 Jul 2019 11:54:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 18 Jul 2019 11:54:17 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 18 Jul 2019 11:54:17 -0700
Received: from [10.24.71.22] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jul
 2019 18:54:07 +0000
To: Cornelia Huck <cohuck@redhat.com>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-3-git-send-email-kwankhede@nvidia.com>
 <20190716182958.7428b1f9.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <6f09de0a-b959-aefd-ce53-5fcc9bce1049@nvidia.com>
Date: Fri, 19 Jul 2019 00:24:02 +0530
MIME-Version: 1.0
In-Reply-To: <20190716182958.7428b1f9.cohuck@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1563476064; bh=xOwwFZ6e+R1qsRlxVXTY8wmC8TBBVgp5fNISGncUiBQ=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=gQ50M2X/SMm+b+E/RFU6NZIr0vC+13ytQjddlK3P1lgBHygBCUK8d775ALfz+Uf88
 uelBt54C5aP0f3phR79hhkcMKnEs5ZZszg6QC/+QtkMkODYxx/4e9NOrXN4sfRC0xd
 /M8nRdKRcl7+RShIdev2sFT9qUHI1vVLUWQOKkLroWDc6Z3pd/DjeS4RbmAUxNVS52
 NhREtUxzSIgLrAaCYJXzEyIx3N10wvpVNPVcBtIq+5rsEaJrDRCHQjy/n9heMRGD2e
 gmrwtBY5oTc3U+7agqCwiVzaGc5KFadR4g1yK4cy3zoWAegwu46g/f9KxRU1YcS+9X
 Kc/5STAx9pPOQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.64
Subject: Re: [Qemu-devel] [PATCH v7 02/13] vfio: Add function to unmap VFIO
 region
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
 alex.williamson@redhat.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, mlevitsk@redhat.com,
 changpeng.liu@intel.com, zhi.a.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/16/2019 9:59 PM, Cornelia Huck wrote:
> On Tue, 9 Jul 2019 15:19:09 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> This function is used in follwing patch in this series.
> 
> "This function will be used for the migration region." ?
> 
> ("This series" will be a bit confusing when this has been merged :)
> 

Sure. Changing it in next version.

Thanks,
Kirti

>> Migration region is mmaped when migration starts and will be unmapped when
>> migration is complete.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>  hw/vfio/common.c              | 20 ++++++++++++++++++++
>>  hw/vfio/trace-events          |  1 +
>>  include/hw/vfio/vfio-common.h |  1 +
>>  3 files changed, 22 insertions(+)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

