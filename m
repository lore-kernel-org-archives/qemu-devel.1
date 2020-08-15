Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53944C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 18:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3B223B6F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 18:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3B223B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k70fC-0005eL-Fb
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 14:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k70dY-0003qF-W5; Sat, 15 Aug 2020 14:10:37 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2101 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k70dX-0008Fl-8v; Sat, 15 Aug 2020 14:10:36 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id DCACFF626E9E62984702;
 Sat, 15 Aug 2020 10:19:28 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 15 Aug 2020 10:19:28 +0800
Received: from [10.174.185.187] (10.174.185.187) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 15 Aug 2020 10:19:28 +0800
Subject: Re: [RFC 5/9] target/arm: introduce CPU feature dependency mechanism
To: Andrew Jones <drjones@redhat.com>
References: <20200813102657.2588720-1-liangpeng10@huawei.com>
 <20200813102657.2588720-6-liangpeng10@huawei.com>
 <20200813124821.psavdkhddg4duar6@kamzik.brq.redhat.com>
From: Peng Liang <liangpeng10@huawei.com>
Message-ID: <1e7160d1-96e7-7581-cdc9-cb4ad44aca72@huawei.com>
Date: Sat, 15 Aug 2020 10:19:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200813124821.psavdkhddg4duar6@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.187]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=liangpeng10@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 14:10:31
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
Cc: peter.maydell@linaro.org, Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 mst@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou 00584000 <xiexiangyou@huawei.com>, qemu-arm@nongnu.org,
 pbonzini@redhat.com, zhukeqian 00502301 <zhukeqian1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/2020 8:48 PM, Andrew Jones wrote:
> On Thu, Aug 13, 2020 at 06:26:53PM +0800, Peng Liang wrote:
>> Some CPU features are dependent on other CPU features.  For example,
>> ID_AA64PFR0_EL1.FP field and ID_AA64PFR0_EL1.AdvSIMD must have the same
>> value, which means FP and ADVSIMD are dependent on each other, FPHP and
>> ADVSIMDHP are dependent on each other.
>>
>> This commit introduces a mechanism for CPU feature dependency in
>> AArch64.  We build a directed graph from the CPU feature dependency
>> relationship, each edge from->to means the `to` CPU feature is dependent
>> on the `from` CPU feature.  And we will automatically enable/disable CPU
>> feature according to the directed graph.
>>
>> For example, a, b, and c CPU features are in relationship a->b->c, which
>> means c is dependent on b and b is dependent on a.  If c is enabled by
>> user, then a and b is enabled automatically.  And if a is disabled by
>> user, then b and c is disabled automatically.
> 
> And what if a is mutually exclusive with b? I.e. a and b can both be
> disabled, but only a or b may be enabled.
> 
> Thanks,
> drew
> 
> .
> 

Currently, a and b will be both enabled or disabled.  For example, a and b are
in relationship a->b, which means b is dependent on a.  If -cpu host,a=off,b=on,
then both a and b are enabled.  If -cpu host,b=on,a=off, then both a and b are
disabled.  Maybe we should report an error to user in this scenario?

Thanks,
Peng

