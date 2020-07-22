Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF3CC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 02:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E749720792
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 02:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E749720792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy4w9-0001oH-7x
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 22:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengxiang9@huawei.com>)
 id 1jy4vZ-0001Ml-U6
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 22:56:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3719 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengxiang9@huawei.com>)
 id 1jy4vV-00043y-Id
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 22:56:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5A289FF4945750D32C85;
 Wed, 22 Jul 2020 10:56:00 +0800 (CST)
Received: from [127.0.0.1] (10.174.187.83) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Jul 2020
 10:55:54 +0800
Subject: Re: [PATCH Kernel v24 0/8] Add UAPIs to support migration for VFIO
 devices
To: Alex Williamson <alex.williamson@redhat.com>
References: <1590697854-21364-1-git-send-email-kwankhede@nvidia.com>
 <450612c3-2a92-9034-7958-ee7f3c1a8c52@huawei.com>
 <20200721164304.0ce76b2e@x1.home>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <3351a7d0-4fb1-a902-b902-a638a3d3047a@huawei.com>
Date: Wed, 22 Jul 2020 10:55:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200721164304.0ce76b2e@x1.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.83]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengxiang9@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 22:56:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com,
 ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, Wang Haibin <wanghaibin.wang@huawei.com>,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, cohuck@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

Thank you for your suggestion.

On 2020/7/22 6:43, Alex Williamson wrote:
> On Tue, 21 Jul 2020 10:43:21 +0800
> Xiang Zheng <zhengxiang9@huawei.com> wrote:
> 
>> Hi Kirti,
>>
>> Sorry to disturb you since this patch set has been merged, and I cannot
>> receive the qemu-side emails about this patch set.
>>
>> We are going to support migration for VFIO devices which support dirty
>> pages tracking.
>>
>> And we also plan to leverage SMMU HTTU feature to do the dirty pages
>> tracking for the devices which don't support dirty pages tracking.
>>
>> For the above two cases, which side determines to choose IOMMU driver or
>> vendor driver to do dirty bitmap tracking, Qemu or VFIO?
>>
>> In brief, if both IOMMU and VFIO devices support dirty pages tracking,
>> we can check the capability and prefer to track dirty pages on device
>> vendor driver which is more efficient.
>>
>> The qusetion is which side to do the check and selection? In my opinion,
>> Qemu/userspace seems more suitable.
> 
> Dirty page tracking is consolidated at the vfio container level.
> Userspace has no basis for determining or interface for selecting a
> dirty bitmap provider, so I would disagree that QEMU should play any
> role here.  The container dirty bitmap tries to provide the finest
> granularity available based on the support of all the devices/groups
> managed by the container.  If there are groups attached to the
> container that have not participated in page pinning, then we consider
> all DMA mappings within the container as persistently dirty.  Once all
> of the participants subscribe to page pinning, the dirty scope is
> reduced to the pinned pages.  IOMMU support for dirty page logging would
> introduce finer granularity yet, which we would probably prefer over
> page pinning, but interfaces for this have not been devised.

Kevin and his colleagues may add these APIs in the future.
We also plan to support these interfaces on SMMU driver and afterwards we
can have a further discussion.

> 
> Ideally userspace should be unaware of any of this, the benefit would
> be seen transparently by having a more sparsely filled dirty bitmap,
> which more accurately reflects how memory is actually being dirtied.

Yes, indeed.

-- 
Thanks,
Xiang


