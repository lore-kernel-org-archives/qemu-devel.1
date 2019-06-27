Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C867FC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 14:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B1F2086D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 14:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hTiecIrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B1F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgVqQ-0000bb-NK
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 10:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54849)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hgVpa-00087k-Pt
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hgVpW-0004i7-S2
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:56:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7955)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hgVpT-0004cT-7e
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:56:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d14d92d0000>; Thu, 27 Jun 2019 07:56:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 27 Jun 2019 07:56:47 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 27 Jun 2019 07:56:47 -0700
Received: from [10.24.71.89] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Jun
 2019 14:56:38 +0000
To: Cornelia Huck <cohuck@redhat.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-5-git-send-email-kwankhede@nvidia.com>
 <20190624160038.5a116930.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <7700cf5b-b478-4068-cf87-52f9f6e9bffd@nvidia.com>
Date: Thu, 27 Jun 2019 20:26:34 +0530
MIME-Version: 1.0
In-Reply-To: <20190624160038.5a116930.cohuck@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561647405; bh=YsajgQ0SXimquHzHWrf8BGXkjPSQXj8fc3Mx9KH1DcI=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=hTiecIrEGBNIAnFzHQa5MkQ4SHoG8SG/DoIi+1lBnLkVzBsjumirvckVMUXgm5wsb
 mQWyR2SO5vovN95A6oaUU9X8f+KUTwp0duzdrhRhBYoNt1S8VIC61ml9rmWKNiMi7y
 XDndLifzqazHsN8NOSSgU+wVGhiTARO+Wd/cffj9g87aTRloQwZv80jxBxepOUebt6
 TOR0GQVNGp5VZnPxuAd8p1zk+UQC2YPmQhZp/hO2uoqN5ZB70wZczlUItAghX//10O
 1qdidvcH9P+2T6OS1oMuxuf5qupqcFuvViHio54nco60OL8hYUJYPA67TaD3QqncEa
 +bKtULHxFFxpw==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.143
Subject: Re: [Qemu-devel] [PATCH v4 04/13] vfio: Add migration region
 initialization and finalize function
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
 eskultet@redhat.com, ziye.yang@intel.com, qemu-devel@nongnu.org,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, alex.williamson@redhat.com,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 yan.y.zhao@intel.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/24/2019 7:30 PM, Cornelia Huck wrote:
> On Thu, 20 Jun 2019 20:07:32 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> - Migration functions are implemented for VFIO_DEVICE_TYPE_PCI device in this
>>   patch series.
>> - VFIO device supports migration or not is decided based of migration region
>>   query. If migration region query is successful then migration is supported
>>   else migration is blocked.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>  hw/vfio/Makefile.objs         |   2 +-
>>  hw/vfio/migration.c           | 137 ++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/vfio/vfio-common.h |  14 +++++
>>  3 files changed, 152 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/vfio/migration.c
> 
> (...)
> 
>> +static int vfio_migration_region_init(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    Object *obj = NULL;
>> +    int ret = -EINVAL;
>> +
>> +    if (!migration) {
>> +        return ret;
>> +    }
>> +
>> +    /* Migration support added for PCI device only */
>> +    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
>> +        obj = vfio_pci_get_object(vbasedev);
>> +    }
> 
> Hm... what about instead including an (optional) callback in
> VFIODeviceOps that returns the object embedding the VFIODevice? No need
> to adapt this code if we introduce support for a non-pci device, and the
> callback function also allows to support migration in a more
> finegrained way than by device type.
> 

That's good suggestion. I'm incorporating this change in next version.

Thanks,
Kirti


>> +
>> +    if (!obj) {
>> +        return ret;
>> +    }
>> +
>> +    ret = vfio_region_setup(obj, vbasedev, &migration->region.buffer,
>> +                            migration->region.index, "migration");
>> +    if (ret) {
>> +        error_report("Failed to setup VFIO migration region %d: %s",
>> +                      migration->region.index, strerror(-ret));
>> +        goto err;
>> +    }
>> +
>> +    if (!migration->region.buffer.size) {
>> +        ret = -EINVAL;
>> +        error_report("Invalid region size of VFIO migration region %d: %s",
>> +                     migration->region.index, strerror(-ret));
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

