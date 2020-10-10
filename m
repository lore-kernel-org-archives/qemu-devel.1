Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C91C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 02:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B48221FD
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 02:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B48221FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR4cv-0003qm-1W
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 22:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kR4cH-0003QG-Lt
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 22:28:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56276 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kR4cD-0006Fe-LB
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 22:28:13 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B95E7C8FF0C2127B3177;
 Sat, 10 Oct 2020 10:27:52 +0800 (CST)
Received: from [10.174.184.155] (10.174.184.155) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 10 Oct 2020 10:27:45 +0800
Subject: Re: [RFC PATCH v2 0/8] block-backend: Introduce I/O hang
To: <qemu-devel@nongnu.org>, <kwolf@redhat.com>
References: <20200930094606.5323-1-cenjiahui@huawei.com>
From: cenjiahui <cenjiahui@huawei.com>
Message-ID: <9bbda2fb-ce27-d8f1-11dd-d7f7889bbbab@huawei.com>
Date: Sat, 10 Oct 2020 10:27:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200930094606.5323-1-cenjiahui@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.155]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=cenjiahui@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 22:27:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.208,
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
Cc: fangying1@huawei.com, zhang.zhanghailiang@huawei.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kevin,

Could you please spend some time reviewing and commenting on this patch series.

Thanks,
Jiahui Cen

On 2020/9/30 17:45, Jiahui Cen wrote:
> A VM in the cloud environment may use a virutal disk as the backend storage,
> and there are usually filesystems on the virtual block device. When backend
> storage is temporarily down, any I/O issued to the virtual block device will
> cause an error. For example, an error occurred in ext4 filesystem would make
> the filesystem readonly. However a cloud backend storage can be soon recovered.
> For example, an IP-SAN may be down due to network failure and will be online
> soon after network is recovered. The error in the filesystem may not be
> recovered unless a device reattach or system restart. So an I/O rehandle is
> in need to implement a self-healing mechanism.
> 
> This patch series propose a feature called I/O hang. It can rehandle AIOs
> with EIO error without sending error back to guest. From guest's perspective
> of view it is just like an IO is hanging and not returned. Guest can get
> back running smoothly when I/O is recovred with this feature enabled.
> 
> v1->v2:
> * Rebase to fix compile problems.
> * Fix incorrect remove of rehandle list.
> * Provide rehandle pause interface.
> 
> Jiahui Cen (8):
>   block-backend: introduce I/O rehandle info
>   block-backend: rehandle block aios when EIO
>   block-backend: add I/O hang timeout
>   block-backend: add I/O rehandle pause/unpause
>   block-backend: enable I/O hang when timeout is set
>   virtio-blk: pause I/O hang when resetting
>   qemu-option: add I/O hang timeout option
>   qapi: add I/O hang and I/O hang timeout qapi event
> 
>  block/block-backend.c          | 300 +++++++++++++++++++++++++++++++++
>  blockdev.c                     |  11 ++
>  hw/block/virtio-blk.c          |   8 +
>  include/sysemu/block-backend.h |   5 +
>  qapi/block-core.json           |  26 +++
>  5 files changed, 350 insertions(+)
> 

