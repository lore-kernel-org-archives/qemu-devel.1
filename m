Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE41C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 04:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72F022CF5
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 04:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72F022CF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3CWD-0002GJ-Sn
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 00:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1i3Aad-0000HP-W3
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 22:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1i3Aab-0002y8-Hc
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 22:55:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41688 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1i3AaT-0002hs-VI; Wed, 28 Aug 2019 22:55:02 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B5D5EFFF1EAD691909A8;
 Thu, 29 Aug 2019 10:54:55 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 29 Aug 2019
 10:54:47 +0800
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>
References: <20190827160554.30995-1-eric.auger@redhat.com>
 <20190827160554.30995-3-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <29520007-f3fd-ed8d-f52b-2839f991556a@huawei.com>
Date: Thu, 29 Aug 2019 10:53:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20190827160554.30995-3-eric.auger@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
X-Mailman-Approved-At: Thu, 29 Aug 2019 00:56:37 -0400
Subject: Re: [Qemu-devel] [RFC 2/3] intc/arm_gic: Support PPI injection for
 more than 256 vpus
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
> Host kernels that expose the KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 capability
> allow injection of PPIs along with vcpu ids larger than 255. Let's
> encode the vpcu id on 12 bits according to the upgraded KVM_IRQ_LINE
> ABI when needed.
> 
> Without that patch qemu exits with "kvm_set_irq: Invalid argument"
> message.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   hw/intc/arm_gic_kvm.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
> index b56fda144f..889293e97f 100644
> --- a/hw/intc/arm_gic_kvm.c
> +++ b/hw/intc/arm_gic_kvm.c
> @@ -56,6 +56,7 @@ void kvm_arm_gic_set_irq(uint32_t num_irq, int irq, int level)
>        * CPU number and interrupt number.
>        */
>       int kvm_irq, irqtype, cpu;
> +    int cpu_idx1 = 0, cpu_idx2 = 0;
>   
>       if (irq < (num_irq - GIC_INTERNAL)) {
>           /* External interrupt. The kernel numbers these like the GIC
> @@ -63,17 +64,20 @@ void kvm_arm_gic_set_irq(uint32_t num_irq, int irq, int level)
>            * internal ones.
>            */
>           irqtype = KVM_ARM_IRQ_TYPE_SPI;
> -        cpu = 0;
>           irq += GIC_INTERNAL;
>       } else {
>           /* Internal interrupt: decode into (cpu, interrupt id) */
>           irqtype = KVM_ARM_IRQ_TYPE_PPI;
>           irq -= (num_irq - GIC_INTERNAL);
>           cpu = irq / GIC_INTERNAL;
> +        cpu_idx2 = cpu / 256;
> +        cpu_idx1 = cpu % 256;
>           irq %= GIC_INTERNAL;
>       }
> -    kvm_irq = (irqtype << KVM_ARM_IRQ_TYPE_SHIFT)
> -        | (cpu << KVM_ARM_IRQ_VCPU_SHIFT) | irq;
> +    kvm_irq = (irqtype << KVM_ARM_IRQ_TYPE_SHIFT) |
> +              (cpu_idx1 << KVM_ARM_IRQ_VCPU_SHIFT) |
> +              ((cpu_idx2 & KVM_ARM_IRQ_VCPU2_MASK) << KVM_ARM_IRQ_VCPU2_SHIFT) |
> +              irq;
>   
>       kvm_set_irq(kvm_state, kvm_irq, !!level);
>   }
> 

For confirmation, should we also adjust the vcpu_index in
arm_cpu_kvm_set_irq(), just like above?


Thanks,
zenghui


