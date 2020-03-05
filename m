Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A01C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17FD22073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FD22073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mRM-0000zt-6g
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j9mPr-0000Kz-VV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:03:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j9mPq-00073Y-Sn
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:03:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:33104 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j9mPq-00070t-G8; Thu, 05 Mar 2020 04:03:38 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 36EB956AC1CF26D48166;
 Thu,  5 Mar 2020 17:03:33 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 5 Mar 2020
 17:03:23 +0800
Subject: Re: [PATCH v4 1/3] s390x: fix memleaks in cpu_finalize
To: David Hildenbrand <david@redhat.com>, <qemu-devel@nongnu.org>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-2-pannengyuan@huawei.com>
 <c61888fa-35d1-8619-79f1-2e36a5aca563@redhat.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <320c1d62-b7d9-65b0-6dc8-a29140a4f5ac@huawei.com>
Date: Thu, 5 Mar 2020 17:03:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c61888fa-35d1-8619-79f1-2e36a5aca563@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 euler.robot@huawei.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/5/2020 4:34 PM, David Hildenbrand wrote:
> 
>>  #if !defined(CONFIG_USER_ONLY)
>>      MachineState *ms = MACHINE(qdev_get_machine());
>>      unsigned int max_cpus = ms->smp.max_cpus;
>> +
>> +    cpu->env.tod_timer =
>> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
>> +    cpu->env.cpu_timer =
>> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
>> +
>>      if (cpu->env.core_id >= max_cpus) {
>>          error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
>>                     ", maximum core-id: %d", cpu->env.core_id,
>> @@ -224,9 +230,38 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>>  
>>      scc->parent_realize(dev, &err);
>>  out:
>> +    if (cpu->env.tod_timer) {
>> +        timer_del(cpu->env.tod_timer);
>> +    }
>> +    if (cpu->env.cpu_timer) {
>> +        timer_del(cpu->env.cpu_timer);
>> +    }
>> +    timer_free(cpu->env.tod_timer);
>> +    timer_free(cpu->env.cpu_timer);
> 
> timer_free() should be sufficient, as it cannot be running, no?

Yes, it's redundant.

> 
>>      error_propagate(errp, err);
>>  }
>>  
>> +static void s390_cpu_unrealizefn(DeviceState *dev, Error **errp)
>> +{
>> +    S390CPUClass *scc = S390_CPU_GET_CLASS(dev);
>> +    Error *err = NULL;
>> +
>> +#if !defined(CONFIG_USER_ONLY)
>> +    S390CPU *cpu = S390_CPU(dev);
>> +
>> +    timer_del(cpu->env.tod_timer);
>> +    timer_del(cpu->env.cpu_timer);
>> +    timer_free(cpu->env.tod_timer);
>> +    timer_free(cpu->env.cpu_timer);
>> +#endif
>> +
>> +    scc->parent_unrealize(dev, &err);
>> +    if (err != NULL) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +}
> 
> Simply a
> 
> scc->parent_unrealize(dev, errp) and you can drop the temporary variable.

Fine, it looks more clear and I will change it.
And I think it's the same on x86_cpu_unrealize/ppc_cpu_unrealize, I refer to the implement of them.

Thanks.

> 
> 

