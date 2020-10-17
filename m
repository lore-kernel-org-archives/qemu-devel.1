Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C26FC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6342C20714
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pExC/0Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6342C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTsd3-0002tq-Gj
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 16:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kTsbt-00024q-OQ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 16:15:26 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kTsbh-0002Nc-0e
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 16:15:23 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8b50bc0002>; Sat, 17 Oct 2020 13:14:53 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 17 Oct
 2020 20:14:50 +0000
Subject: Re: [PATCH v26 04/17] vfio: Add migration region initialization and
 finalize function
To: Cornelia Huck <cohuck@redhat.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-5-git-send-email-kwankhede@nvidia.com>
 <20200924160856.1308e6f5.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <1f059554-50f1-6540-45a7-0851dcf11bf9@nvidia.com>
Date: Sun, 18 Oct 2020 01:44:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924160856.1308e6f5.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602965693; bh=+yXQ8i0DoboBAKpHHvtX016uslb4dWNtTvxP0+8QXl4=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=pExC/0Q+v6OH8F6ebeWeeUDMpDBl5oLvOiON2Ax/Yb2meN0YH+BRK0ae+g8EWiLt8
 Frg0Dd+54PtUWoI5la1saNLohZ2j9WKU7kE3iFF6RAZ7vIo1GW/aixD4YuRx4eFtDY
 lAqt/zZ8qwRbiLDZrv3hsgyN6KKmJOQatSJ2t9SOMPMflfQRvXDDpH1Moy/611U2L/
 jPV2CjTjl5zowzneJpp1/TZrdUT6XdH9CiV37UfiE+zfykWKJZPBBYp9h7cjag5mgI
 AZZRXcyAazw1JTAADJ+Oa4TZIqy3kl9w9GS/L3yYvuPdn83Wa/KC/epo8ZKcCIWrWm
 q2q2gcCbPTDjg==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 16:15:05
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.247, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/24/2020 7:38 PM, Cornelia Huck wrote:
> On Wed, 23 Sep 2020 04:54:06 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Whether the VFIO device supports migration or not is decided based of
>> migration region query. If migration region query is successful and migration
>> region initialization is successful then migration is supported else
>> migration is blocked.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   hw/vfio/meson.build           |   1 +
>>   hw/vfio/migration.c           | 142 ++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events          |   5 ++
>>   include/hw/vfio/vfio-common.h |   9 +++
>>   4 files changed, 157 insertions(+)
>>   create mode 100644 hw/vfio/migration.c
> 
> (...)
> 
>> +static int vfio_migration_region_init(VFIODevice *vbasedev, int index)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    Object *obj = NULL;
>> +    int ret = -EINVAL;
>> +
>> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
>> +    if (!obj) {
>> +        return ret;
>> +    }
>> +
>> +    ret = vfio_region_setup(obj, vbasedev, &migration->region, index,
>> +                            "migration");
>> +    if (ret) {
>> +        error_report("%s: Failed to setup VFIO migration region %d: %s",
>> +                     vbasedev->name, index, strerror(-ret));
>> +        goto err;
>> +    }
>> +
>> +    if (!migration->region.size) {
>> +        ret = -EINVAL;
>> +        error_report("%s: Invalid region size of VFIO migration region %d: %s",
>> +                     vbasedev->name, index, strerror(-ret));
> 
> Using strerror on a hardcoded error value is probably not terribly
> helpful. I think printing either region.size (if you plan to extend
> this check later) or something like "Invalid zero-sized VFIO migration
> region" would make more sense.
> 

Updating the error string as you suggested.


>> +        goto err;
>> +    }
>> +
>> +    return 0;
>> +
>> +err:
>> +    vfio_migration_region_exit(vbasedev);
>> +    return ret;
>> +}
> 
> (...)
> 
> Apart from that, looks good to me.
> 

Thanks.

Kirti

