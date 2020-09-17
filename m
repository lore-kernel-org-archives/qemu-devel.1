Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD1BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5764D2220A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5764D2220A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIulf-0001Bi-6u
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIudE-0005iO-7V; Thu, 17 Sep 2020 10:11:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41306 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIudB-0001on-IA; Thu, 17 Sep 2020 10:11:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 4A5032FBC6CE97CD6C11;
 Thu, 17 Sep 2020 22:11:14 +0800 (CST)
Received: from [10.174.185.104] (10.174.185.104) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 22:11:07 +0800
Subject: Re: [RFC PATCH 09/12] target/arm/cpu: Add CPU cache description for
 arm
To: Andrew Jones <drjones@redhat.com>
References: <20200917032033.2020-1-fangying1@huawei.com>
 <20200917032033.2020-10-fangying1@huawei.com>
 <20200917083929.uv2oukokqmiykfs5@kamzik.brq.redhat.com>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <4e2f68a2-5726-9dc3-70b8-9ce02f5f642f@huawei.com>
Date: Thu, 17 Sep 2020 22:11:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200917083929.uv2oukokqmiykfs5@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:23:09
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, alistair.francis@wdc.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/17/2020 4:39 PM, Andrew Jones wrote:
> On Thu, Sep 17, 2020 at 11:20:30AM +0800, Ying Fang wrote:
>> Add the CPUCacheInfo structure to hold CPU cache information for ARM cpus.
>> A classic three level cache topology is used here. The default cache
>> capacity is given and userspace can overwrite these values.
> 
> Doesn't TCG already have some sort of fake cache hierarchy? If so, then

TCG may have some sort of fake cache hierarchy via CCSIDR.

> we shouldn't be adding another one, we should be simply describing the
> one we already have. For KVM, we shouldn't describe anything other than
> what is actually on the host.

Yes, I agreed. Cache capacity should be the with host otherwise it may
have bad impact on guest performance, we can do that by query from the
host and make cache capacity configurable from userspace.

Dario Faggioli is going to give a talk about it in KVM forum [1].

[1] 
https://kvmforum2020.sched.com/event/eE1y/virtual-topology-for-virtual-machines-friend-or-foe-dario-faggioli-suse?iframe=no&w=100%&sidebar=yes&bg=no

Thanks.

> 
> drew
> 
> .
> 

