Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A78BC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 19:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF9220735
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 19:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pglPdtXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF9220735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWPl5-0005Ki-UL
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 15:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jWPkP-0004q8-CP
 for qemu-devel@nongnu.org; Wed, 06 May 2020 15:30:25 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jWPkL-0000Dc-I6
 for qemu-devel@nongnu.org; Wed, 06 May 2020 15:30:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eb310020000>; Wed, 06 May 2020 12:29:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 06 May 2020 12:30:17 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 06 May 2020 12:30:17 -0700
Received: from [10.40.101.152] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 May
 2020 19:30:09 +0000
Subject: Re: [PATCH v16 QEMU 08/16] vfio: Register SaveVMHandlers for VFIO
 device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-9-git-send-email-kwankhede@nvidia.com>
 <20200325150248.6661e1bd@w520.home>
 <a3a082a4-cc2f-b84b-60c6-a20f86528a6d@nvidia.com>
 <20200504223726.5d4bb9ce@x1.home> <20200506063846.GB19334@joy-OptiPlex-7040>
 <20200506115856.012c88d8.cohuck@redhat.com> <20200506165305.GP2743@work-vm>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <f351c0f0-685f-7d9b-46cc-1e1c7187f06d@nvidia.com>
Date: Thu, 7 May 2020 01:00:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506165305.GP2743@work-vm>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1588793346; bh=3ipIMNIIBHdeyB1p4x7CsEmSEo3RBGPpJzjjQ9AkcPg=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=pglPdtXFFz/39YOHWPxC6kYDwFqsP+DOV0QOxTNeKrRpFsi0p1XByCSUUhLeFLwAF
 IyXCml+DWEgx6EGC5ZKahHa5NHQ70PdlGt0Oe6iH+kpa9mMJjJGc/DvvHlVtUr+EfT
 mIBGjwgwSepHXvDU6Br86c5Vn5cn5fRwRnNf9o064BCougsUHXyk8ejOVZrm28QsfX
 487CcYq9UnLatU78Tqq9ET/LvcToH6Lqh16zqjJPR1C+DmTnj3pxGZUntiurK1URIJ
 vF3FO4Q0gqKCWhDTV1VuWxVkv1M7cw7AR9F1BOBddr8URy2Z7n5V8x/9hyqJXkHpAe
 YHyhVvKYFfTiA==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 15:30:17
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>,
 "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 Yan Zhao <yan.y.zhao@intel.com>, "Liu, 
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/6/2020 10:23 PM, Dr. David Alan Gilbert wrote:
> * Cornelia Huck (cohuck@redhat.com) wrote:
>> On Wed, 6 May 2020 02:38:46 -0400
>> Yan Zhao <yan.y.zhao@intel.com> wrote:
>>
>>> On Tue, May 05, 2020 at 12:37:26PM +0800, Alex Williamson wrote:
>>>> It's been a long time, but that doesn't seem like what I was asking.
>>>> The sysfs version checking is used to select a target that is likely to
>>>> succeed, but the migration stream is still generated by a user and the
>>>> vendor driver is still ultimately responsible for validating that
>>>> stream.  I would hope that a vendor migration stream therefore starts
>>>> with information similar to that found in the sysfs interface, allowing
>>>> the receiving vendor driver to validate the source device and vendor
>>>> software version, such that we can fail an incoming migration that the
>>>> vendor driver deems incompatible.  Ideally the vendor driver might also
>>>> include consistency and sequence checking throughout the stream to
>>>> prevent a malicious user from exploiting the internal operation of the
>>>> vendor driver.  Thanks,
>>
>> Some kind of somewhat standardized marker for driver/version seems like
>> a good idea. Further checking is also a good idea, but I think the
>> details of that need to be left to the individual drivers.
> 
> Standardised markers like that would be useful; although the rules of
> how to compare them might be a bit vendor specific; but still - it would
> be good for us to be able to dump something out when it all goes wrong.
> 

Such checking should already there in vendor driver. Vendor driver might 
also support across version migration. I think checking in QEMU again 
would be redundant. Let vendor driver handle version checks.

Thanks,
Kirti

>>>>    
>>> maybe we can add a rw field migration_version in
>>> struct vfio_device_migration_info besides sysfs interface ?
>>>
>>> when reading it in src, it gets the same string as that from sysfs;
>>> when writing it in target, it returns success or not to check
>>> compatibility and fails the migration early in setup phase.
>>
>> Getting both populated from the same source seems like a good idea.
>>
>> Not sure if a string is the best value to put into a migration stream;
>> maybe the sysfs interface can derive a human-readable string from a
>> more compact value to be put into the migration region (and ultimately
>> the stream)? Might be overengineering, just thinking out aloud here.
> 
> A string might be OK fi you specify a little about it.
> 
> Dave
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

