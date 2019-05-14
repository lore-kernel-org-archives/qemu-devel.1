Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E944CC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5E4208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5E4208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45985 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQVd3-0003mV-04
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 07:29:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1hQVZ5-0000XE-GI
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1hQVZ3-0004ha-Jh
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:25:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56260 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
	id 1hQVYw-0004ZH-0e; Tue, 14 May 2019 07:25:39 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 381A0BE33AB50F181077;
	Tue, 14 May 2019 19:25:33 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS412-HUB.china.huawei.com
	(10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 May 2019
	19:25:22 +0800
To: Peter Maydell <peter.maydell@linaro.org>
References: <1557751388-27063-1-git-send-email-gengdongjiu@huawei.com>
	<1557751388-27063-11-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA81nMkHdCvQTcv2ixNB7sg+3Qx+9mpNgF0XLaBPY7-PNQ@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <d23719b7-65e4-1136-ffb4-f58de774d8cd@huawei.com>
Date: Tue, 14 May 2019 19:25:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
	Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81nMkHdCvQTcv2ixNB7sg+3Qx+9mpNgF0XLaBPY7-PNQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: Re: [Qemu-devel] [PATCH v16 10/10] target-arm: kvm64: handle SIGBUS
 signal from kernel or KVM
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Zheng
	Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"xuwei \(O\)" <xuwei5@huawei.com>,
	Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> 
>> +void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(c);
>> +    CPUARMState *env = &cpu->env;
>> +    ram_addr_t ram_addr;
>> +    hwaddr paddr;
>> +
>> +    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>> +
>> +    if (addr) {
>> +        ram_addr = qemu_ram_addr_from_host(addr);
>> +        if (ram_addr != RAM_ADDR_INVALID &&
>> +            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
>> +            kvm_hwpoison_page_add(ram_addr);
>> +            /* Asynchronous signal will be masked by main thread, so
>> +             * only handle synchronous signal.
>> +             */
>> +            if (code == BUS_MCEERR_AR) {
>> +                kvm_cpu_synchronize_state(c);
>> +                if (GHES_CPER_FAIL != ghes_record_errors(ACPI_HEST_NOTIFY_SEA, paddr)) {
>> +                    kvm_inject_arm_sea(c);
>> +                } else {
>> +                    fprintf(stderr, "failed to record the error\n");
>> +                }
>> +            }
>> +            return;
>> +        }
>> +        fprintf(stderr, "Hardware memory error for memory used by "
>> +                "QEMU itself instead of guest system!\n");
>> +    }
>> +
>> +    if (code == BUS_MCEERR_AR) {
>> +        fprintf(stderr, "Hardware memory error!\n");
>> +        exit(1);
>> +    }
>> +}
> 
> This code appears to still be unconditionally trying to
> notify the guest of the error via the ACPI tables without
> checking whether those ACPI tables even exist. I told you
> about this in a previous round of review :-(

Thanks very much for the comments, and sorry for my forgetting
I added the ACPI checking in the new V17 version.

> 
> thanks
> -- PMM
> .
> 


