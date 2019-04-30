Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7DAC04AA6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5099220652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSbOV1zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5099220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47711 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLTSw-0007ky-FL
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 10:10:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLTRO-0006hs-1l
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLTMZ-0007bj-3r
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:04:04 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLTMY-0007bS-V1
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:04:03 -0400
Received: by mail-ot1-x343.google.com with SMTP id n15so5927188ota.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=rp3NMk74hJQNcvS8jQez3Zj+7AMBiwuUII7+5IrcSyg=;
	b=oSbOV1zuopQ7kmigOksn0fC9u42RtOD+izV0oe+5ZvqK2VcKAPHWZOfMON6wAO1Ucp
	CZEkqyPoVolCh2LI05EoL4Djzd9OFRFrPgrvD9HUqIkcRoPked0XxLAdy6Jw3LC3Et7V
	zz7IRIEZssHcpwED6Vy8Wym0VK278ZQKJv1WKZ9mZtoJFzNN/72V67LxaThBLUiZ6y2V
	udtCN8soBBiUkTEeW05y7McG8B57JiY89t/leSweZyf8wc0ZiX9iCLFvaYj5y0J69BcP
	H6XV7Sl2JpGZdUL3QndbOT8+IchAwCZ1Vtj59qipo8VEeAUEYZtQTbsNWLhhLbdijSKR
	zoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=rp3NMk74hJQNcvS8jQez3Zj+7AMBiwuUII7+5IrcSyg=;
	b=Z+jeUo9xv59PFJUgv/dvqiL0fARagBhEEkKBZEV/FFUiq+KsB/++F9eC9910zDminw
	mUu1y0JtrgNroZceQeztiCVzaoy/ceyBFd9jcFWp6zamYyT+lXnbgMHn7nD5+6OmBj2X
	+hcpEgtLDjHGPviHV6JPZv7Izb2mOjE1ZPBfwuOT54lWXHsbYIkGTBqAT+Dn9H8CStrw
	YETrVqaXiRPJZJtrRiDyZLtFtxR1KBJfNDT3S/xDA5SbaYprcCBBB26f1QsbjgYL5wcs
	jMSQYfI/5QeFUNGNOAI1rHGGfkIW8LS4tuM1YqQyXKu3Tmc+r7g6nPuH1rU9q3bWsVwY
	hNXg==
X-Gm-Message-State: APjAAAUWRGKbhpCdy/affUKoW9f3t4PxelrVitp3knFopwJmanqIlMgM
	TlNqnM/SgzopO/hF1Ig2f85xdzVJ1m+c3VqBYZfSow==
X-Google-Smtp-Source: APXvYqx1Cl9664+LY5uU6rwQ3gJGN6BFzvG3I6FMW3A1Bo0YuvM9tiaJfAMn6F4Gl0LoMpt9QQkJAPS6/21BK0oxpPE=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr5057163otk.316.1556633041989; 
	Tue, 30 Apr 2019 07:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
	<1555560291-3415-2-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1555560291-3415-2-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 15:03:50 +0100
Message-ID:
 <CAFEAcA9rTL_4co1JvHrpJcqJqdrBsOiHo8sZS6wKWJOWphCCSA@mail.gmail.com>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v7 1/2] hw/arm: Add arm SBSA reference
 machine, skeleton part
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
Cc: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Leif Lindholm <leif.lindholm@linaro.org>,
	Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430140350.oN5tgi507e8DDcsXjO7vCFdIkKPXkKIsbApkiv65iCk@z>

On Thu, 18 Apr 2019 at 05:05, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> For the Aarch64, there is one machine 'virt', it is primarily meant to
> run on KVM and execute virtualization workloads, but we need an
> environment as faithful as possible to physical hardware, for supporting
> firmware and OS development for pysical Aarch64 machines.
>
> This patch introduces new machine type 'sbsa-ref' with main features:
>  - Based on 'virt' machine type.
>  - A new memory map.
>  - CPU type cortex-a57.
>  - EL2 and EL3 are enabled.
>  - GIC version 3.
>  - System bus AHCI controller.
>  - System bus EHCI controller.
>  - CDROM and hard disc on AHCI bus.
>  - E1000E ethernet card on PCIE bus.
>  - VGA display adaptor on PCIE bus.
>  - No virtio deivces.
>  - No fw_cfg device.
>  - No ACPI table supplied.
>  - Only minimal device tree nodes.
>
> Arm Trusted Firmware and UEFI porting to this are done accordingly, and
> it should supply ACPI tables to load OS, the minimal device tree nodes
> supplied from this platform are only to pass the dynamic info reflecting
> command line input to firmware, not for loading OS.
>
> To make the review easier, this task is split into two patches, the
> fundamental sceleton part and the peripheral devices part, this patch is
> the first part.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>

Hi. This patch looks good to me. I have a couple of very minor
comments below.

The only other thing I'm not sure about is whether the recent work
(both in master and in pending patchset) to add support for memory
hotplug and nvdimms to the 'virt' board is applicable here. I've
cc'd Igor and Eric to ask their opinion on that question.

> +static const MemMapEntry sbsa_ref_memmap[] = {
> +    /* 512M boot ROM */
> +    [SBSA_FLASH] =              {          0, 0x20000000 },
> +    /* 512M secure memory */
> +    [SBSA_SECURE_MEM] =         { 0x20000000, 0x20000000 },
> +    /* Space reserved for CPU peripheral devices */
> +    [SBSA_CPUPERIPHS] =         { 0x40000000, 0x00040000 },
> +    [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
> +    [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
> +    [SBSA_UART] =               { 0x60000000, 0x00001000 },
> +    [SBSA_RTC] =                { 0x60010000, 0x00001000 },
> +    [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
> +    [SBSA_SECURE_UART] =        { 0x60030000, 0x00001000 },
> +    [SBSA_SECURE_UART_MM] =     { 0x60040000, 0x00001000 },
> +    [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
> +    /* Space here reserved for more SMMUs */
> +    [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
> +    [SBSA_EHCI] =               { 0x60110000, 0x00010000 },
> +    /* Space here reserved for other devices */
> +    [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
> +    /* 32-bit address PCIE MMIO space */
> +    [SBSA_PCIE_MMIO] =          { 0x80000000, 0x70000000 },
> +    /* 256M PCIE ECAM space */
> +    [SBSA_PCIE_ECAM] =          { 0xf0000000, 0x10000000 },
> +    /* ~1TB PCIE MMIO space (4GB to 1024GB boundary) */
> +    [SBSA_PCIE_MMIO_HIGH] =     { 0x100000000ULL, 0xFF00000000ULL },
> +    [SBSA_MEM] =                { 0x10000000000ULL, RAMLIMIT_BYTES },
> +};
> +
> +static const int sbsa_ref_irqmap[] = {
> +    [SBSA_UART] = 1,
> +    [SBSA_RTC] = 2,
> +    [SBSA_PCIE] = 3, /* ... to 6 */
> +    [SBSA_GPIO] = 7,
> +    [SBSA_SECURE_UART] = 8,
> +    [SBSA_SECURE_UART_MM] = 9,
> +    [SBSA_AHCI] = 10,
> +    [SBSA_EHCI] = 11,
> +};

Since we only have one memory map and one irqmap, I think that
rather than setting up vms->memmap[x] and vms->irqmap[x] and then
always using those, we should just refer directly to the globals.
The indirection in virt is originally because I was thinking we
might want to have more than one layout (and because the code
derives from the vexpress boards, which really do have two
different layouts depending on the version), and then it turned
out to be useful that we could pass the VirtMachineState* to
the ACPI table generation code and let it get at the addresses
and IRQ numbers that way. But neither of those applies here, I think.

> +
> +static void sbsa_ref_init(MachineState *machine)
> +{
> +    SBSAMachineState *vms = SBSA_MACHINE(machine);

This is a very trivial nitpick, but I think we should call
this variable 'sms', not 'vms', since we changed the name of
the struct type. (Same applies in some other functions later.)

> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *secure_sysmem = NULL;
> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
> +    bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
> +    const CPUArchIdList *possible_cpus;
> +    int n, sbsa_max_cpus;
> +
> +    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a57"))) {
> +        error_report("sbsa-ref: CPU type other than the built-in "
> +                     "cortex-a57 not supported");
> +        exit(1);
> +    }
> +
> +    if (kvm_enabled()) {
> +        error_report("sbsa-ref: KVM is not supported at this machine");

"for this machine".

> +        exit(1);
> +    }

thanks
-- PMM

