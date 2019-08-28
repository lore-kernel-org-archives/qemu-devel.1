Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028D9C3A5A6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 06:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20F922CF4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 06:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20F922CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2rJZ-0008Nv-W8
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 02:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i2rIi-0007jY-K9
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 02:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i2rIh-0008I7-E4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 02:19:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i2rIf-0008G7-2E; Wed, 28 Aug 2019 02:19:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F288D3DE04;
 Wed, 28 Aug 2019 06:19:19 +0000 (UTC)
Received: from [10.36.116.105] (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5C056060D;
 Wed, 28 Aug 2019 06:19:17 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org
References: <20190827160554.30995-1-eric.auger@redhat.com>
 <20190827160554.30995-4-eric.auger@redhat.com>
 <7d012631-1fe3-c040-eaf7-87ba274657c5@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8779e6f0-b8d8-7ec8-a77a-860d8be97e5f@redhat.com>
Date: Wed, 28 Aug 2019 08:19:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7d012631-1fe3-c040-eaf7-87ba274657c5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 28 Aug 2019 06:19:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 3/3] virt: Check
 KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 for smp_cpus > 256
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
Cc: yuzenghui@huawei.com, maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

On 8/28/19 5:28 AM, Richard Henderson wrote:
> On 8/27/19 9:05 AM, Eric Auger wrote:
>> +++ b/target/arm/kvm_arm.h
>> @@ -233,6 +233,14 @@ bool kvm_arm_pmu_supported(CPUState *cs);
>>   */
>>  int kvm_arm_get_max_vm_ipa_size(MachineState *ms);
>>  
>> +/**
>> + * kvm_arm_irq_line_layout_2 - Returns whether more than 256
>> + * vcpus are supported by KVM_IRQ_LINE
>> + *
>> + * @ms: Machine state handle
>> + */
>> +bool kvm_arm_irq_line_layout_2(MachineState *ms);
>> +
>>  /**
>>   * kvm_arm_sync_mpstate_to_kvm
>>   * @cpu: ARMCPU
>> @@ -280,6 +288,11 @@ static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
>>      return -ENOENT;
>>  }
>>  
>> +static inline int kvm_arm_irq_line_layout_2(MachineState *ms)
>> +{
>> +    return -ENOENT;
>> +}
>> +
> 
> These signatures don't match.
thanks for spotting this. I will fix it.

Best Regards

Eric
> 
> 
> r~
> 

