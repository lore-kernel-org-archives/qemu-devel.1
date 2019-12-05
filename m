Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27717C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 02:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA6121744
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 02:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA6121744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ich1I-000053-29
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 21:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1icgzm-0007cu-S2
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 21:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1icgzl-0002pz-1M
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 21:35:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2211 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1icgzk-0002eD-Jg
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 21:35:56 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id F3550714885439EC8B01;
 Thu,  5 Dec 2019 10:35:51 +0800 (CST)
Received: from [127.0.0.1] (10.120.177.99) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Dec 2019
 10:35:42 +0800
Subject: Re: [PATCH v2 1/3] virtio: add ability to delete vq through a pointer
To: Eric Blake <eblake@redhat.com>, <mst@redhat.com>
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
 <40c11e5e-60a0-9407-4ebe-52d23d70ea85@redhat.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <fd6d2433-062b-3985-e40f-f4865e6c2616@huawei.com>
Date: Thu, 5 Dec 2019 10:35:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <40c11e5e-60a0-9407-4ebe-52d23d70ea85@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.120.177.99]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/12/4 22:40, Eric Blake wrote:
> On 12/4/19 1:31 AM, pannengyuan@huawei.com wrote:
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> Devices tend to maintain vq pointers, allow deleting them trough a vq
>> pointer.
> 
> through

Thanks. I'm sorry for my carelessness.

> 
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
> 
> Also, don't forget to send a 0/3 cover letter (any series longer than
> one patch should have a cover letter; it is possible to configure git to
> do this automatically: https://wiki.qemu.org/Contribute/SubmitAPatch has
> this tip and others)

ok, thanks.

> 


