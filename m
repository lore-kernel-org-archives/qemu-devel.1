Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0BEC18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5777620727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5777620727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbzz-0006BF-E0
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1jBbyn-0005GZ-CU
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1jBbym-0008AI-BL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:19:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54404 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1jBbyj-0007cb-Ug; Tue, 10 Mar 2020 06:19:14 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A427CD65A2219E0EC76E;
 Tue, 10 Mar 2020 18:19:05 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 10 Mar 2020
 18:18:51 +0800
Subject: Re: [kvm-unit-tests PATCH v4 00/13] arm/arm64: Add ITS tests
To: Andrew Jones <drjones@redhat.com>, Eric Auger <eric.auger@redhat.com>
References: <20200309102420.24498-1-eric.auger@redhat.com>
 <20200309115741.6stx5tpkb6s6ejzh@kamzik.brq.redhat.com>
 <20200309120012.xkgmlbvd5trm6ewk@kamzik.brq.redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <5cfe64d3-e609-cd1e-4f92-e24cf5f62c77@huawei.com>
Date: Tue, 10 Mar 2020 18:18:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200309120012.xkgmlbvd5trm6ewk@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/3/9 20:00, Andrew Jones wrote:
> On Mon, Mar 09, 2020 at 12:57:51PM +0100, Andrew Jones wrote:
>> This looks pretty good to me. It just needs some resquashing cleanups.
>> Does Andre plan to review? I've only been reviewing with respect to
>> the framework, not ITS. If no other reviews are expected, then I'll
>> queue the next version.
> 
> Oops, sorry Zenghui, I forgot to ask if you'll be reviewing again as
> well.

I'd like to have a look again this week if time permits :-).  Thanks
for reminding me.


Zenghui


