Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1966AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95522070A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="obFiMWLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95522070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdD6A-0004Av-51
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 09:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jdD2a-00083E-II
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:21:16 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jdD2V-0004Yi-OV
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:21:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ecbc6370000>; Mon, 25 May 2020 06:20:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 25 May 2020 06:21:07 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 25 May 2020 06:21:07 -0700
Received: from [10.40.102.2] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 May
 2020 13:20:58 +0000
Subject: Re: [PATCH Kernel v22 0/8] Add UAPIs to support migration for VFIO
 devices
To: Yan Zhao <yan.y.zhao@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>
References: <1589781397-28368-1-git-send-email-kwankhede@nvidia.com>
 <20200519105804.02f3cae8@x1.home> <20200525065925.GA698@joy-OptiPlex-7040>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <426a5314-6d67-7cbe-bad0-e32f11d304ea@nvidia.com>
Date: Mon, 25 May 2020 18:50:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525065925.GA698@joy-OptiPlex-7040>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1590412855; bh=rfvzQ1dHfzD4GOc0GVDetG93nM12lVwp2xFrbbE4mrM=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=obFiMWLGm5rnR3RXAScvd/qKPQwMDIkOvlO/mrMnXbqKVmsRgT7mOw4OABMA8/fpa
 dxtZPIEmSYHo1rXH4y48NhxvMm2VOmvIIEp/ldTNClwSG6gFB0qo0G1+sleIvtne9S
 bIQhKlPwCKOlhfc8jLbCi+9CduGga+wUraCF7u8viKR1MCQ6NW8OkU975m3bKUC0Hx
 bNLivELzZ2daRgcDOHgRrcjs/l3DesT3hUNBpmnzaBmPtlSK+FdJGH0Fld6eve22cu
 Pl2XfwTbsh1StUr5ck+rpzWgkhORa4sFZoF6ZwOmud4Wl4m6MVw2XH/cBB5z96uEdK
 b3ffEN2fiUbZA==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 09:21:08
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
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/25/2020 12:29 PM, Yan Zhao wrote:
> On Tue, May 19, 2020 at 10:58:04AM -0600, Alex Williamson wrote:
>> Hi folks,
>>
>> My impression is that we're getting pretty close to a workable
>> implementation here with v22 plus respins of patches 5, 6, and 8.  We
>> also have a matching QEMU series and a proposal for a new i40e
>> consumer, as well as I assume GVT-g updates happening internally at
>> Intel.  I expect all of the latter needs further review and discussion,
>> but we should be at the point where we can validate these proposed
>> kernel interfaces.  Therefore I'd like to make a call for reviews so
>> that we can get this wrapped up for the v5.8 merge window.  I know
>> Connie has some outstanding documentation comments and I'd like to make
>> sure everyone has an opportunity to check that their comments have been
>> addressed and we don't discover any new blocking issues.  Please send
>> your Acked-by/Reviewed-by/Tested-by tags if you're satisfied with this
>> interface and implementation.  Thanks!
>>
> hi Alex
> after porting gvt/i40e vf migration code to kernel/qemu v23, we spoted
> two bugs.
> 1. "Failed to get dirty bitmap for iova: 0xfe011000 size: 0x3fb0 err: 22"
>     This is a qemu bug that the dirty bitmap query range is not the same
>     as the dma map range. It can be fixed in qemu. and I just have a little
>     concern for kernel to have this restriction.
> 

I never saw this unaligned size in my testing. In this case if you can 
provide vfio_* event traces, that will helpful.

> 2. migration abortion, reporting
> "qemu-system-x86_64-lm: vfio_load_state: Error allocating buffer
> qemu-system-x86_64-lm: error while loading state section id 49(vfio)
> qemu-system-x86_64-lm: load of migration failed: Cannot allocate memory"
> 
> It's still a qemu bug and we can fixed it by
> "
> if (migration->pending_bytes == 0) {
> +            qemu_put_be64(f, 0);
> +            qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> "

In which function in QEMU do you have to add this?

> and actually there are some extra concerns about this part, as reported in
> [1][2].
> 
> [1] data_size should be read ahead of data_offset
> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg02795.html.
> [2] should not repeatedly update pending_bytes in vfio_save_iterate()
> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg02796.html.
> 
> but as those errors are all in qemu, and we have finished basic tests in
> both gvt & i40e, we're fine with the kernel part interface in general now.
> (except for my concern [1], which needs to update kernel patch 1)
> 

 >> what if pending_bytes is not 0, but vendor driver just does not want  to
 >> send data in this iteration? isn't it right to get data_size first 
before
 >> getting data_offset?

If vendor driver doesn't want to send data but still has data in staging 
buffer, vendor driver still can control to send pending_bytes for this 
iteration as 0 as this is a trap field.

I would defer this to Alex.

> so I wonder which way in your mind is better, to give our reviewed-by to
> the kernel part now, or hold until next qemu fixes?
> and as performance data from gvt is requested from your previous mail, is
> that still required before the code is accepted?
> 
> BTW, we have also conducted some basic tests when viommu is on, and found out
> errors like
> "qemu-system-x86_64-dt: vtd_iova_to_slpte: detected slpte permission error (iova=0x0, level=0x3, slpte=0x0, write=1)
> qemu-system-x86_64-dt: vtd_iommu_translate: detected translation failure (dev=00:03:00, iova=0x0)
> qemu-system-x86_64-dt: New fault is not recorded due to compression of faults".
> 

I saw these errors, I'm looking into it.

Thanks,
Kirti

