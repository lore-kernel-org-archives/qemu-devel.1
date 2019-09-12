Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36217C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF1C2084F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF1C2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Kvk-0008SU-7J
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 04:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i8Kuj-0007Xn-Cn
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i8Kui-0003jJ-F6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:57:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i8Kuf-0003iL-BR; Thu, 12 Sep 2019 04:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 577AF308212D;
 Thu, 12 Sep 2019 08:57:12 +0000 (UTC)
Received: from [10.36.116.238] (ovpn-116-238.ams2.redhat.com [10.36.116.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E0985DA5B;
 Thu, 12 Sep 2019 08:57:10 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190911155125.11932-1-eric.auger@redhat.com>
 <20190911155125.11932-4-eric.auger@redhat.com>
 <CAFEAcA-tZJ2C8=ZH5e7tXzigPu3SGjSJbnLybZTG+hZO-7ZV0A@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1b849672-31a6-3d8d-b8ea-254e737e3b80@redhat.com>
Date: Thu, 12 Sep 2019 10:57:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-tZJ2C8=ZH5e7tXzigPu3SGjSJbnLybZTG+hZO-7ZV0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 12 Sep 2019 08:57:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v2 3/3] virt: Check
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
Cc: Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,
On 9/12/19 10:42 AM, Peter Maydell wrote:
> On Wed, 11 Sep 2019 at 16:51, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Host kernel within [4.18, 5.3] report an erroneous KVM_MAX_VCPUS=512
>> for ARM. The actual capability to instantiate more than 256 vcpus
>> was fixed in 5.4 with the upgrade of the KVM_IRQ_LINE ABI to support
>> vcpu id encoded on 12 bits instead of 8 and a redistributor consuming
>> a single KVM IO device instead of 2.
>>
>> So let's check this capability when attempting to use more than 256
>> vcpus.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/virt.c        |  4 ++++
>>  target/arm/kvm.c     | 21 +++++++++++++++++++++
>>  target/arm/kvm_arm.h | 15 +++++++++++++++
>>  3 files changed, 40 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 0d1629ccb3..465e3140f7 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1575,6 +1575,10 @@ static void machvirt_init(MachineState *machine)
>>          virt_max_cpus = GIC_NCPU;
>>      }
>>
>> +    if (kvm_arm_irq_line_layout_mismatch(MACHINE(vms), max_cpus)) {
>> +        exit(1);
>> +    }
>> +
> 
> Is there really no place to put this check in common code?
Not sure what you mean by common code here? Do you mean in a common code
for ARM machines (I don't think we have any atm) or directly in
kvm_init(). I did not want to pollute this latter with this ARM specific
fix.

Thanks

Eric

> 
> thanks
> -- PMM
> 

