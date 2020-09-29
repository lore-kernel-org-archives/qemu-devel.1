Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45465C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE2820848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE2820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCG8-0004Uo-LL
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kNCFF-0003fO-UB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:48:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4771 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kNCFC-0007fr-2D
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:48:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A6667E6156EF2CA0B138;
 Tue, 29 Sep 2020 17:48:11 +0800 (CST)
Received: from [10.174.186.107] (10.174.186.107) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 17:48:02 +0800
Subject: Re: [RFC PATCH 0/7] block-backend: Introduce I/O hang
To: Kevin Wolf <kwolf@redhat.com>
References: <20200927130420.1095-1-fangying1@huawei.com>
 <20200928105711.GF5451@linux.fritz.box>
From: cenjiahui <cenjiahui@huawei.com>
Message-ID: <74c436e6-4796-fc03-1706-5cee9bb2e8bd@huawei.com>
Date: Tue, 29 Sep 2020 17:48:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200928105711.GF5451@linux.fritz.box>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.107]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=cenjiahui@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 05:48:12
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
Cc: Ying Fang <fangying1@huawei.com>, mreitz@redhat.com,
 zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/28 18:57, Kevin Wolf wrote:
> Am 27.09.2020 um 15:04 hat Ying Fang geschrieben:
>> A VM in the cloud environment may use a virutal disk as the backend storage,
>> and there are usually filesystems on the virtual block device. When backend
>> storage is temporarily down, any I/O issued to the virtual block device will
>> cause an error. For example, an error occurred in ext4 filesystem would make
>> the filesystem readonly. However a cloud backend storage can be soon recovered.
>> For example, an IP-SAN may be down due to network failure and will be online
>> soon after network is recovered. The error in the filesystem may not be
>> recovered unless a device reattach or system restart. So an I/O rehandle is
>> in need to implement a self-healing mechanism.
>>
>> This patch series propose a feature called I/O hang. It can rehandle AIOs
>> with EIO error without sending error back to guest. From guest's perspective
>> of view it is just like an IO is hanging and not returned. Guest can get
>> back running smoothly when I/O is recovred with this feature enabled.
> 
> What is the problem with setting werror=stop and rerror=stop for the
When an I/O error occurs, if simply setting werror=stop and rerror=stop, the
whole VM will be paused and unavailable. Moreover, the VM won't be recovered
until the management tool manually resumes it after the backend storage recovers.
> device? Is it that QEMU won't automatically retry, but management tool
> interaction is required to resume the guest?
By using I/O Hang mechanism, we can temporarily hang the IOs, and any other
services unrelated with the hung virtual block device like network can go on
working. Besides, once the backend storage is recovered, our I/O rehandle
mechanism will automatically complete the hung IOs and continue the VM's work.
> 
> I haven't checked your patches in detail yet, but implementing this
> functionality in the backend means that blk_drain() will hang (or if it
> doesn't hang, it doesn't do what it's supposed to do), making the whole
What if we disable rehandle before blk_drain().
> QEMU process unresponsive until the I/O succeeds again. Amongst others,
> this would make it impossible to migrate away from a host with storage
> problems.
Exactly if the storage is recovered during migration iteration phase, the
migration can succeed, but if the storage is still not recovered on migration
completion phase, the migration should fail and be cancelled.

Thanks,
Jiahui Cen
> 
> Kevin
> 
> 
> .
>

