Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87923C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBEE22280
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QkW+knl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBEE22280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFjh-00076s-Vk
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 16:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kUFiZ-0005uN-3f
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 16:55:51 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kUFiX-0003oS-0I
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 16:55:50 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8caba50000>; Sun, 18 Oct 2020 13:55:01 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 18 Oct
 2020 20:55:31 +0000
Subject: Re: [PATCH v26 07/17] vfio: Register SaveVMHandlers for VFIO device
To: Cornelia Huck <cohuck@redhat.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-8-git-send-email-kwankhede@nvidia.com>
 <20200925135318.7afaf234.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <34146d7a-6b38-132d-ab2e-90f5d8b71f9e@nvidia.com>
Date: Mon, 19 Oct 2020 02:25:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925135318.7afaf234.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603054501; bh=erjOhhdEJiZ7vuQBtqUDFKLUCFj4iSgrkxFZjah9jjs=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=QkW+knl+E179piMiC8kmqO0OLL6WMStTdKvK99qP7oFycx3b5doDOAk0LhtRS0h/T
 Tl9+SEqygsQd195Mu3JAqmMGx/mMNPAlhbnXIXUg2czMuCr65Fg+RAUqfJ5rBjig9J
 WCL5rGXFMZuc5Xa4wF8Gf8vAv44+c7o1DOoJB0R5+p/PfyAQC0LolEjGmSd2egTDf+
 e2axsUZY6AKnDVObqcEKzICaf2r7IfxE5Fq2E3qt+4z6GDcz3RN26D+MDfl56GKFFv
 ggUe0m/hwSUlCsQJDSkNJaxmDHNSD/PjQN89YwOFkZJwt6whMO3DbLSXpRqrJCKYIY
 UvG7RE6IAzKiA==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 16:55:47
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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



On 9/25/2020 5:23 PM, Cornelia Huck wrote:
> On Wed, 23 Sep 2020 04:54:09 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Define flags to be used as delimeter in migration file stream.
>> Added .save_setup and .save_cleanup functions. Mapped & unmapped migration
>> region from these functions at source during saving or pre-copy phase.
>> Set VFIO device state depending on VM's state. During live migration, VM is
>> running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
>> device. During save-restore, VM is paused, _SAVING state is set for VFIO device.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   hw/vfio/migration.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events |  2 ++
>>   2 files changed, 93 insertions(+)
>>
> 
> (...)
> 
>> +/*
>> + * Flags used as delimiter:
>> + * 0xffffffff => MSB 32-bit all 1s
>> + * 0xef10     => emulated (virtual) function IO
> 
> Where is this value coming from?
> 

Delimiter flags should be unique and this is a magic number that 
represents (e)mulated (f)unction (10) representing IO.

>> + * 0x0000     => 16-bits reserved for flags
>> + */
>> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
>> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
>> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> 
> I think we need some more documentation what these values mean and how
> they are used. From reading ahead a bit, it seems there is always
> supposed to be a pair of DEV_*_STATE and END_OF_STATE framing some kind
> of data?
> 

Adding comment as below, hope it helps.

/*
  * Flags used as delimiter for VFIO devices should be unique in 
migration stream
  * These flags are composed as:
  * 0xffffffff => MSB 32-bit all 1s
  * 0xef10     => Magic ID, represents emulated (virtual) function IO
  * 0x0000     => 16-bits reserved for flags
  *
  * Flags _DEV_CONFIG_STATE, _DEV_SETUP_STATE and _DEV_DATA_STATE marks 
start of
  * respective states in migration stream.
  * FLAG _END_OF_STATE indicates end of current state, state could be any
  * of above states.
  */

Thanks,
Kirti


