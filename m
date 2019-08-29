Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01585C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 04:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9C12173E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 04:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9C12173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3CV7-0001Kx-V8
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 00:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1i39u8-0000ZL-I0
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 22:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1i39u7-000796-Ca
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 22:11:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2257 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1i39u4-00074q-R6; Wed, 28 Aug 2019 22:11:13 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 9E8565E696147CB115BC;
 Thu, 29 Aug 2019 10:11:05 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 29 Aug 2019
 10:10:59 +0800
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>
References: <20190827160554.30995-1-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <2b9f6028-117b-f3da-e40b-3e5e217ad826@huawei.com>
Date: Thu, 29 Aug 2019 10:06:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20190827160554.30995-1-eric.auger@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
X-Mailman-Approved-At: Thu, 29 Aug 2019 00:56:37 -0400
Subject: Re: [Qemu-devel] [RFC 0/3] KVM/ARM: Fix >256 vcpus
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
Cc: maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On 2019/8/28 0:05, Eric Auger wrote:
> Since 4.18, KVM/ARM exposes a KVM_MAX_VCPUS equal to 512. However it was
> reported [1] that a VM with more than 256 vcpus cannot be launched. 5.4
> is about to fix the situation with 2 patches:
> - one upgrade of the KVM_IRQ_LINE API [2] supporting a vcpu id encoded
>    on 12 bits,
> - the reduction of KVM IO devices consumed by each GICv3 redistributor [3]
> 
> This series uses the new KVM_IRQ_LINE API and also checks the associated
> capability (KVM_CAP_ARM_IRQ_LINE_LAYOUT_2) in machvirt.
> 
> Without the series, as soon as the -smp arguments exceeds 256, QEMU exits
> with "kvm_set_irq: Invalid argument".

For the series:

Tested-by: Zenghui Yu <yuzenghui@huawei.com>

together with [2], [3].

> 
> Best Regards
> 
> Eric
> 
> References:
> [1] Can we boot a 512U kvm guest?
>      https://patchwork.kernel.org/patch/11091501/
> [2] [PATCH] KVM: arm/arm64: vgic: Allow more than 256 vcpus for KVM_IRQ_LINE
>      https://patchwork.kernel.org/patch/11099609/
> [3] [PATCH] KVM: arm/arm64: vgic: Use a single IO device per redistributor
>      https://patchwork.kernel.org/patch/11112141/
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/v4.1.0-256fix-rfc-v1
> 
> Eric Auger (3):
>    linux headers: update for KVM_CAP_ARM_IRQ_LINE_LAYOUT_2
>    intc/arm_gic: Support PPI injection for more than 256 vpus
>    virt: Check KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 for smp_cpus > 256

Thanks,
zenghui


