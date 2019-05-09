Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F519C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63911208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63911208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55631 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOk2r-0007om-LB
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 10:29:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hOk1Z-000722-Qs
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hOk1Y-0001a2-Ht
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:27:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hOk1V-0001Yn-Gh; Thu, 09 May 2019 10:27:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FDEC3078DC9;
	Thu,  9 May 2019 14:27:48 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-204-72.brq.redhat.com [10.40.204.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B13F643F2;
	Thu,  9 May 2019 14:27:42 +0000 (UTC)
Date: Thu, 9 May 2019 16:27:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Message-ID: <20190509162736.133418f9@Igors-MacBook-Pro>
In-Reply-To: <CAHmQWvAM3Jj_49Kq45jUgHnLmN-p3Yn-+GPQChpfTo1BS5hUJg@mail.gmail.com>
References: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
	<1555560291-3415-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9rTL_4co1JvHrpJcqJqdrBsOiHo8sZS6wKWJOWphCCSA@mail.gmail.com>
	<CAHmQWvAM3Jj_49Kq45jUgHnLmN-p3Yn-+GPQChpfTo1BS5hUJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 09 May 2019 14:27:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Leif Lindholm <leif.lindholm@linaro.org>,
	Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 May 2019 19:22:53 +0800
Hongbo Zhang <hongbo.zhang@linaro.org> wrote:

> On Tue, 30 Apr 2019 at 22:04, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Thu, 18 Apr 2019 at 05:05, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> > >
> > > For the Aarch64, there is one machine 'virt', it is primarily meant to
> > > run on KVM and execute virtualization workloads, but we need an
> > > environment as faithful as possible to physical hardware, for supporting
> > > firmware and OS development for pysical Aarch64 machines.
> > >
> > > This patch introduces new machine type 'sbsa-ref' with main features:
> > >  - Based on 'virt' machine type.
> > >  - A new memory map.
> > >  - CPU type cortex-a57.
> > >  - EL2 and EL3 are enabled.
> > >  - GIC version 3.
> > >  - System bus AHCI controller.
> > >  - System bus EHCI controller.
> > >  - CDROM and hard disc on AHCI bus.
> > >  - E1000E ethernet card on PCIE bus.
> > >  - VGA display adaptor on PCIE bus.
> > >  - No virtio deivces.
> > >  - No fw_cfg device.
> > >  - No ACPI table supplied.
> > >  - Only minimal device tree nodes.
> > >
> > > Arm Trusted Firmware and UEFI porting to this are done accordingly, and
> > > it should supply ACPI tables to load OS, the minimal device tree nodes
> > > supplied from this platform are only to pass the dynamic info reflecting
> > > command line input to firmware, not for loading OS.
> > >
> > > To make the review easier, this task is split into two patches, the
> > > fundamental sceleton part and the peripheral devices part, this patch is
> > > the first part.
> > >
> > > Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> >
> > Hi. This patch looks good to me. I have a couple of very minor
> > comments below.
> >
> > The only other thing I'm not sure about is whether the recent work
> > (both in master and in pending patchset) to add support for memory
> > hotplug and nvdimms to the 'virt' board is applicable here. I've
> > cc'd Igor and Eric to ask their opinion on that question.
> >
> My opinnion is, if we don't have conclusion before I send out next
> iteration, we can just abandon it at this time, currently from my side
> I don't see any reqirement for such features, what's more even if in
> the future we need it, we can still add it by seperate patch, maybe we
> probably have other features to be added in future too.

It should be possible to add nvdimm and memory hotplug later.
(I don't see big issues here, as long as it would be possible
to carve out continuous range in address space for it.

Considering ABI to guest, one could reuse QEMU's notification/enumeration
code for that or implement their own.

PS:
However there will be the same issues that we've had with Seabios when
ACPI tables were generated there (i.e. cease-less invention of interfaces
to to pass information from QEMU to firmware). But if I recall correctly,
it seems that it's intentional design decision for this board,
where user supplies/builds in firmware a board description (acpi/dt/...)
manually.

 
> > > +static const MemMapEntry sbsa_ref_memmap[] = {
> > > +    /* 512M boot ROM */
> > > +    [SBSA_FLASH] =              {          0, 0x20000000 },
> > > +    /* 512M secure memory */
> > > +    [SBSA_SECURE_MEM] =         { 0x20000000, 0x20000000 },
> > > +    /* Space reserved for CPU peripheral devices */
> > > +    [SBSA_CPUPERIPHS] =         { 0x40000000, 0x00040000 },
> > > +    [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
> > > +    [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
> > > +    [SBSA_UART] =               { 0x60000000, 0x00001000 },
> > > +    [SBSA_RTC] =                { 0x60010000, 0x00001000 },
> > > +    [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
> > > +    [SBSA_SECURE_UART] =        { 0x60030000, 0x00001000 },
> > > +    [SBSA_SECURE_UART_MM] =     { 0x60040000, 0x00001000 },
> > > +    [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
> > > +    /* Space here reserved for more SMMUs */
> > > +    [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
> > > +    [SBSA_EHCI] =               { 0x60110000, 0x00010000 },
> > > +    /* Space here reserved for other devices */
> > > +    [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
> > > +    /* 32-bit address PCIE MMIO space */
> > > +    [SBSA_PCIE_MMIO] =          { 0x80000000, 0x70000000 },
> > > +    /* 256M PCIE ECAM space */
> > > +    [SBSA_PCIE_ECAM] =          { 0xf0000000, 0x10000000 },
> > > +    /* ~1TB PCIE MMIO space (4GB to 1024GB boundary) */
> > > +    [SBSA_PCIE_MMIO_HIGH] =     { 0x100000000ULL, 0xFF00000000ULL },
> > > +    [SBSA_MEM] =                { 0x10000000000ULL, RAMLIMIT_BYTES },
> > > +};
> > > +
> > > +static const int sbsa_ref_irqmap[] = {
> > > +    [SBSA_UART] = 1,
> > > +    [SBSA_RTC] = 2,
> > > +    [SBSA_PCIE] = 3, /* ... to 6 */
> > > +    [SBSA_GPIO] = 7,
> > > +    [SBSA_SECURE_UART] = 8,
> > > +    [SBSA_SECURE_UART_MM] = 9,
> > > +    [SBSA_AHCI] = 10,
> > > +    [SBSA_EHCI] = 11,
> > > +};
> >
> > Since we only have one memory map and one irqmap, I think that
> > rather than setting up vms->memmap[x] and vms->irqmap[x] and then
> > always using those, we should just refer directly to the globals.
> > The indirection in virt is originally because I was thinking we
> > might want to have more than one layout (and because the code
> > derives from the vexpress boards, which really do have two
> > different layouts depending on the version), and then it turned
> > out to be useful that we could pass the VirtMachineState* to
> > the ACPI table generation code and let it get at the addresses
> > and IRQ numbers that way. But neither of those applies here, I think.
> >
> Yes, good.
> 
> > > +
> > > +static void sbsa_ref_init(MachineState *machine)
> > > +{
> > > +    SBSAMachineState *vms = SBSA_MACHINE(machine);
> >
> > This is a very trivial nitpick, but I think we should call
> > this variable 'sms', not 'vms', since we changed the name of
> > the struct type. (Same applies in some other functions later.)
> >
> Good catch, this is not 'trivial' I think, they should be changed obviously.
> 
> > > +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> > > +    MemoryRegion *sysmem = get_system_memory();
> > > +    MemoryRegion *secure_sysmem = NULL;
> > > +    MemoryRegion *ram = g_new(MemoryRegion, 1);
> > > +    bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
> > > +    const CPUArchIdList *possible_cpus;
> > > +    int n, sbsa_max_cpus;
> > > +
> > > +    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a57"))) {
> > > +        error_report("sbsa-ref: CPU type other than the built-in "
> > > +                     "cortex-a57 not supported");
> > > +        exit(1);
> > > +    }
> > > +
> > > +    if (kvm_enabled()) {
> > > +        error_report("sbsa-ref: KVM is not supported at this machine");
> >
> > "for this machine".
> >
> > > +        exit(1);
> > > +    }
> >
> > thanks
> > -- PMM


