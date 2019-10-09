Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476D6C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD0720679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD0720679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGy8-0008Ed-RA
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iICER-0005JC-6n
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iICEQ-0002JX-1g
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:42:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35426 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iICEN-0002DL-72; Wed, 09 Oct 2019 09:42:19 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id E295C36A5D818A856480;
 Wed,  9 Oct 2019 21:42:13 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 21:42:03 +0800
Subject: Re: [RFC PATCH 00/12] Add SDEI support for arm64
To: Peter Maydell <peter.maydell@linaro.org>
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
 <CAFEAcA_ztr0_Bu9d__dSr9oH75s2DSd5=6NZvVMrxuDTxf31mw@mail.gmail.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <84e1a629-bdd3-faaf-e12f-17930945adf4@huawei.com>
Date: Wed, 9 Oct 2019 21:42:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ztr0_Bu9d__dSr9oH75s2DSd5=6NZvVMrxuDTxf31mw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc
 Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Dave Martin <Dave.Martin@arm.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>, wanghaibin.wang@huawei.com,
 kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/9/30 21:15, Peter Maydell wrote:
> On Tue, 24 Sep 2019 at 16:23, Heyi Guo <guoheyi@huawei.com> wrote:
>> As promised, this is the first RFC patch set for arm64 SDEI support.
> Hi; for the benefit of possible reviewers who aren't familiar
> with every corner of the arm ecosystem, could you provide a
> summary of:
>   * what is SDEI ?
SDEI is for ARM "Software Delegated Exception Interface". AS ARM64 
doesn't have native non-maskable interrupt (NMI), we can rely on higher 
privileged software to change the pc of lower privileged software on 
certain events occur, to emulate NMI mechanism, and SDEI is the standard 
interfaces between the two levels of privileged software. It is based on 
SMC/HVC calls.

In virtualization situation, guest OS is the lower privileged software 
and hypervisor is the higher one. Major interfaces provided by SDEI include:
1. interrupt bind: guest OS can request to bind an interrupt to an SDEI 
event.
2. register: guest OS can request to register a handler to an SDEI 
event, so hypervisor will change pc of guest to this handler when 
certain event occurs.
3. complete: guest OS notifies hypervisor that it has completed the 
event handling, so hypervisor will restore the context of guest when it 
is interrupted.
>   * what do KVM and QEMU want/need to do with it ?
KVM is supposed to pass SMC/HVC calls to qemu, and qemu will serve the 
SDEI requests after parsing SMC/HVC calls. qemu also takes the 
responsibility to trigger the events. If an interrupt is requested to be 
bound to an event, qemu should not inject the interrupt to guest any 
more; instead, it should save the context of VCPU and change the PC to 
event handler which is registered by guest, and then return to guest.

To make the conversion of interrupt to SDEI event transparent to other 
modules in qemu, we used qemu_irq and qemu_irq_intercept_in() to 
override the default irq handler with SDEI event trigger. I saw 
qemu_irq_intercept_in() should be only used in qemu MST, but it seemed 
fit to override interrupt injection with event trigger after guest 
requests to bind interrupt to SDEI event.
>   * what is this patchset trying to solve ?
This patchset is trying to implement the whole SDEI framework in qemu 
with KVM enabled, including all SDEI v1.0 interfaces, as well as event 
trigger conduit from other qemu devices after interrupt binding.

I will also provide the above context in the cover letter of v2 RFC.

Thanks,

Heyi

>
> That would provide some useful context for trying to
> review the patchset.
>
> thanks
> -- PMM
>
> .
>



