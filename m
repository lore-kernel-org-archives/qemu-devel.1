Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24CBFA372C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 01:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E852187F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 01:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E852187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSWri-0007jz-L1
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 20:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iSWqz-0007FC-R5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 20:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iSWqy-0004BN-OC
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 20:44:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2263 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iSWqw-0004AB-71; Wed, 06 Nov 2019 20:44:50 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3E779B65EF589C9340E0;
 Thu,  7 Nov 2019 09:44:44 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 7 Nov 2019
 09:44:37 +0800
Subject: Re: [RFC v2 11/14] linux-headers/kvm.h: add capability to forward
 hypercall
To: Cornelia Huck <cohuck@redhat.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <20191105091056.9541-12-guoheyi@huawei.com>
 <20191106185524.0fe51c50.cohuck@redhat.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <4dbcbd18-0e6c-f985-c36d-96df65331d11@huawei.com>
Date: Thu, 7 Nov 2019 09:44:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191106185524.0fe51c50.cohuck@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, James Morse <james.morse@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, wanghaibin.wang@huawei.com,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/11/7 1:55, Cornelia Huck wrote:
> On Tue, 5 Nov 2019 17:10:53 +0800
> Heyi Guo <guoheyi@huawei.com> wrote:
>
>> To keep backward compatibility, we add new KVM capability
>> "KVM_CAP_FORWARD_HYPERCALL" to probe whether KVM supports forwarding
>> hypercall to userspace.
>>
>> The capability should be enabled explicitly, for we don't want user
>> space application to deal with unexpected hypercall exits. After
>> enabling this cap, all HVC calls unhandled by kvm will be forwarded to
>> user space.
>>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Dave Martin <Dave.Martin@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> ---
>>   linux-headers/linux/kvm.h |  1 +
>>   target/arm/sdei.c         | 16 ++++++++++++++++
>>   target/arm/sdei.h         |  2 ++
>>   3 files changed, 19 insertions(+)
>>
>> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
>> index 3d9b18f7f8..36c9b3859f 100644
>> --- a/linux-headers/linux/kvm.h
>> +++ b/linux-headers/linux/kvm.h
>> @@ -1000,6 +1000,7 @@ struct kvm_ppc_resize_hpt {
>>   #define KVM_CAP_PMU_EVENT_FILTER 173
>>   #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
>>   #define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
>> +#define KVM_CAP_FORWARD_HYPERCALL 176
>>   
>>   #ifdef KVM_CAP_IRQ_ROUTING
> Is this cap upstream already? I would have thought your header sync
> would have brought it in, then. (Saying this, that header sync looks
> awfully small.)
>
> If it is not upstream yet, please split off this hunk into a separate
> patch -- it's a bit annoying, but makes life easier for merging.
No, it is not upstream yet. The whole framework and interfaces between 
KVM and qemu are still under discussion. I'll keep in mind of this when 
moving forward to next steps...

Thanks,
HG
>
>
> .
>



