Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7A8C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66AB235FC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66AB235FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKyt1-0005ra-KN
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 03:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuzenghui@huawei.com>)
 id 1kKyrv-0005GK-At
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 03:07:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50432 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuzenghui@huawei.com>)
 id 1kKyrs-0003Ge-UJ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 03:07:11 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0CD7FBF050B303D8607B;
 Wed, 23 Sep 2020 15:06:57 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 23 Sep 2020 15:06:49 +0800
Subject: Re: [PATCH QEMU v25 00/17] Add migration support for VFIO devices
To: Kirti Wankhede <kwankhede@nvidia.com>, <alex.williamson@redhat.com>,
 <cjia@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <f0a6ddc4-4d85-8757-441d-d6f3f9bf4783@huawei.com>
Date: Wed, 23 Sep 2020 15:06:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=yuzenghui@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 03:06:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cohuck@redhat.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, wanghaibin.wang@huawei.com,
 Ken.Xue@amd.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, quintela@redhat.com,
 zhi.a.wang@intel.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/9/23 7:24, Kirti Wankhede wrote:

> Patch 4-9:
> - Generic migration functionality for VFIO device.
>   * This patch set adds functionality for PCI devices, but can be
>     extended to other VFIO devices.
>   * Added all the basic functions required for pre-copy, stop-and-copy and
>     resume phases of migration.
>   * Added state change notifier and from that notifier function, VFIO
>     device's state changed is conveyed to VFIO device driver.
>   * During save setup phase and resume/load setup phase, migration region
>     is queried and is used to read/write VFIO device data.
>   * .save_live_pending and .save_live_iterate are implemented to use QEMU's
>     functionality of iteration during pre-copy phase.
>   * In .save_live_complete_precopy, that is in stop-and-copy phase,
>     iteration to read data from VFIO device driver is implemented till pending
>     bytes returned by driver are not zero.

s/are not zero/are zero/ ?

[...]

> Live migration resume path:
>     Incomming migration calls .load_setup for each device
>     (RESTORE_VM, _ACTIVE, STOPPED)

The _RESUMING device state is missed here?

>                         |
>     For each device, .load_state is called for that device section data
>                         |
>     At the end, called .load_cleanup for each device and vCPUs are started.
>                         |
>         (RUNNING, _NONE, _RUNNING)


Thanks,
Zenghui

