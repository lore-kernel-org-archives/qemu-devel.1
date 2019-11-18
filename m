Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B636C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 06:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62ADD2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 06:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62ADD2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWaxV-0005au-I2
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 01:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iWawm-00051i-FP
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 01:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iWawk-0001SY-TF
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 01:55:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36528 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iWawh-0001Or-AU; Mon, 18 Nov 2019 01:55:35 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C2AAD672B27508F4C875;
 Mon, 18 Nov 2019 14:55:29 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 14:55:21 +0800
Subject: Re: [RFC v2 00/14] Add SDEI support for arm64
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>
References: <20191105091056.9541-1-guoheyi@huawei.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <9d7a2c5d-df78-ef67-87af-3860fcb7aee8@huawei.com>
Date: Mon, 18 Nov 2019 14:55:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191105091056.9541-1-guoheyi@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
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
Cc: Mark Rutland <mark.rutland@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

Could you spare some time to review the framework and provide comments 
and advice?

Thanks,

HG


On 2019/11/5 17:10, Heyi Guo wrote:
> SDEI is for ARM "Software Delegated Exception Interface". AS ARM64 doesn't have
> native non-maskable interrupt (NMI), we rely on higher privileged (larger
> exception level) software to change the execution flow of lower privileged
> (smaller exception level) software when certain events occur, to emulate NMI
> mechanism, and SDEI is the standard interfaces between the two levels of
> privileged software. It is based on SMC/HVC calls.
>
> The higher privileged software implements an SDEI dispatcher to handle SDEI
> related SMC/HVC calls and trigger SDEI events; the lower privileged software
> implements an SDEI client to request SDEI services and handle SDEI events.
>
> Core interfaces provided by SDEI include:
>
> 1. interrupt bind: client can request to bind an interrupt to an SDEI event, so
> the interrupt will be a non-maskable event and the event number will be returned
> to the caller. Only PPI and SPI can be bound to SDEI events.
>
> 2. register: client can request to register a handler to an SDEI event, so
> dispatcher will change PC of lower privileged software to this handler when
> certain event occurs.
>
> 3. complete: client notifies dispatcher that it has completed the event
> handling, so dispatcher will restore the context of guest when it is
> interrupted.
>
> In virtualization situation, guest OS is the lower privileged software and
> hypervisor is the higher one.
>
> KVM is supposed to pass SMC/HVC calls to qemu, and qemu will emulate an SDEI
> dispatcher to serve the SDEI requests and trigger the events. If an interrupt is
> requested to be bound to an event, qemu should not inject the interrupt to guest
> any more; instead, it should save the context of VCPU and change the PC to event
> handler which is registered by guest, and then return to guest.
>
> To make the conversion of interrupt to SDEI event transparent to other modules
> in qemu, we used qemu_irq and qemu_irq_intercept_in() to override the default
> irq handler with SDEI event trigger. I saw qemu_irq_intercept_in() should be
> only used in qemu MST, but it seemed fit to override interrupt injection with
> event trigger after guest requests to bind interrupt to SDEI event.
>
> This patchset is trying to implement the whole SDEI framework in qemu with KVM
> enabled, including all SDEI v1.0 interfaces, as well as event trigger conduit
> from other qemu devices after interrupt binding.
>
> Key points:
> - We propose to only support kvm enabled arm64 virtual machines, for
>    non-kvm VMs can emulate EL3 and have Trusted Firmware run on it,
>    which has a builtin SDEI dispatcher.
> - New kvm capability KVM_CAP_FORWARD_HYPERCALL is added to probe if
>    kvm supports forwarding hypercalls, and the capability should be
>    enabled explicitly.
> - We make the dispatcher as a logical device, to save the states
>    during migration or save/restore operation; only one instance is
>    allowed in one VM.
> - We use qemu_irq as the bridge for other qemu modules to switch from
>    irq injection to SDEI event trigger after VM binds the interrupt to
>    SDEI event. We use qemu_irq_intercept_in() to override qemu_irq
>    handler with SDEI event trigger, and a new interface
>    qemu_irq_remove_intercept() is added to restore the handler to
>    default one (i.e. ARM GIC).
>
> More details are in the commit message of each patch.
>
> Basic tests are done by emulating a watchdog timer and triggering SDEI
> event in every 10s.
>
> Please focus on the interfaces and framework first. We can refine the code for
> several rounds after the big things have been determined.
>
> Any comment or suggestion is welcome.
>
> Thanks,
>
> HG
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
>
> v2:
> - Import import linux/arm_sdei.h to standard-headers
> - Drop SDEI table definition and add comments
> - Some bugfix and code refinement
>
> Heyi Guo (14):
>    update-linux-headers.sh: import linux/arm_sdei.h to standard-headers
>    standard-headers: import arm_sdei.h
>    arm/sdei: add virtual device framework
>    arm: add CONFIG_SDEI build flag
>    arm/sdei: add support to handle SDEI requests from guest
>    arm/sdei: add system reset callback
>    arm/sdei: add support to trigger event by GIC interrupt ID
>    core/irq: add qemu_irq_remove_intercept interface
>    arm/sdei: override qemu_irq handler when binding interrupt
>    arm/sdei: add support to register interrupt bind notifier
>    linux-headers/kvm.h: add capability to forward hypercall
>    arm/sdei: add stub to fix build failure when SDEI is not enabled
>    arm/kvm: handle guest exit of hypercall
>    virt/acpi: add SDEI table if SDEI is enabled
>
>   default-configs/arm-softmmu.mak           |    1 +
>   hw/arm/Kconfig                            |    4 +
>   hw/arm/virt-acpi-build.c                  |   26 +
>   hw/core/irq.c                             |   11 +
>   include/hw/irq.h                          |    8 +-
>   include/standard-headers/linux/arm_sdei.h |   73 +
>   linux-headers/linux/kvm.h                 |    1 +
>   scripts/update-linux-headers.sh           |    1 +
>   target/arm/Makefile.objs                  |    4 +
>   target/arm/kvm.c                          |   17 +
>   target/arm/sdei-stub.c                    |   49 +
>   target/arm/sdei.c                         | 1576 +++++++++++++++++++++
>   target/arm/sdei.h                         |   60 +
>   target/arm/sdei_int.h                     |  121 ++
>   14 files changed, 1950 insertions(+), 2 deletions(-)
>   create mode 100644 include/standard-headers/linux/arm_sdei.h
>   create mode 100644 target/arm/sdei-stub.c
>   create mode 100644 target/arm/sdei.c
>   create mode 100644 target/arm/sdei.h
>   create mode 100644 target/arm/sdei_int.h
>



