Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD8CC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0DCA208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DCA208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSPZQ-0001yO-Jf
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 15:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kSPYP-0001EJ-4P
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 15:01:45 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:46691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kSPYM-0005B1-EP
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 15:01:44 -0400
Received: from [192.168.100.1] ([82.252.141.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Md6ZB-1jtLqj2mzD-00aCvs; Tue, 13 Oct 2020 21:01:38 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201013155124.451774-1-laurent@vivier.eu>
 <20201013155124.451774-5-laurent@vivier.eu>
 <2bfc12f5-0fd8-afb9-7b16-1a3d5ac51a06@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 4/4] m68k: add Virtual M68k Machine
Message-ID: <468df353-11ce-d29d-4d65-abd328010bb5@vivier.eu>
Date: Tue, 13 Oct 2020 21:01:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2bfc12f5-0fd8-afb9-7b16-1a3d5ac51a06@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gbVd0pb05DMUr6vTGke0MGbl1+II6dLQi5D7SaeQBq1+Yw785zv
 M9MvVmt2HBHiT5EET3BgE5HYcdhv+NFHRJ5iMU6kRDed0tkyeZgmGexWwN+CHMTox0O7ztP
 /FmS0c45tN0KzwfgzyI6CumHs7YrwDlTsQhcdKc4p0Rul/TcmkLnDWk7XtOYpb279TsG3kz
 DrFdWcdCjJIPE07hKaEoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H4fk/gXBpKU=:wcjvuvihPcf1a627NAa/bs
 TGAADr2qNrL6hKin5xc8aJtikcCOxoGvJY8rEpN6Bn668U2QEDLV2rYR7g5EAoJp4LHr+JDkW
 uBpmXUuFnstZwzTL5KBCS5YGLtBY5lIJoymOJDCg0I8FENM0/HrKOctwJYOh5rasj+JW1XKxS
 QcEV+cFScVCo9ExV5PjQnBat41UvciSSGGqb2j6VCfWH8/34yvt9W9lzfKJGbf9NefSHqMvLs
 HYUcFwg1Hrbdm0b2YQNFoT+Kbz2hDAMswVuvXnxX9J+61WiRsQmoWiiFOqh/Hj8HLAzwdkaZk
 mjCu5NyXjGjxrV0wmxOZLzVK2xVPuKL+UZgSJFzSHmw+u/JxbYedUh26UPwyF+5rRbLrM/11p
 3mbOxjgiez1m5dmv26ltOXUZWAjfixW7goHGQOY+0SSNzCChsTTuGQ/V3uM6BDucKj2Sf26C0
 L2SwjBrplA==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 15:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/10/2020 à 19:56, Philippe Mathieu-Daudé a écrit :
> On 10/13/20 5:51 PM, Laurent Vivier wrote:
>> The machine is based on Goldfish interfaces defined by Google
>> for Android simulator. It uses Goldfish-rtc (timer and RTC),
>> Goldfish-pic (PIC) and Goldfish-tty (for serial port and early tty).
>>
>> The machine is created with 128 virtio-mmio bus, and they can
>> be used to use serial console, GPU, disk, NIC, HID, ...
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   default-configs/devices/m68k-softmmu.mak      |   1 +
>>   .../standard-headers/asm-m68k/bootinfo-virt.h |  17 +
>>   hw/m68k/virt.c                                | 296 ++++++++++++++++++
>>   MAINTAINERS                                   |   9 +
>>   hw/m68k/Kconfig                               |   8 +
>>   hw/m68k/meson.build                           |   1 +
>>   6 files changed, 332 insertions(+)
>>   create mode 100644 include/standard-headers/asm-m68k/bootinfo-virt.h
>>   create mode 100644 hw/m68k/virt.c
...
>> +/*
>> + * The GLUE (General Logic Unit) is an Apple custom integrated
>> circuit chip
>> + * that performs a variety of functions (RAM management, clock
>> generation, ...).
>> + * The GLUE chip receives interrupt requests from various devices,
>> + * assign priority to each, and asserts one or more interrupt line to
>> the
>> + * CPU.
> 
> Does your virt machine really requires a GLUE? Or only another
> cascaded PIC?

I agree code needs cleanup here.

We need something to set the ÌRQ level (priority) and vector (see
m68k_set_irq_level()).

>> + */
>> +
>> +typedef struct {
>> +    M68kCPU *cpu;
>> +    uint8_t ipr;
>> +} GLUEState;
>> +
>> +static void GLUE_set_irq(void *opaque, int irq, int level)
>> +{
>> +    GLUEState *s = opaque;
>> +    int i;
>> +
>> +    if (level) {
>> +        s->ipr |= 1 << irq;
>> +    } else {
>> +        s->ipr &= ~(1 << irq);
>> +    }
>> +
>> +    for (i = 7; i >= 0; i--) {
>> +        if ((s->ipr >> i) & 1) {
>> +            m68k_set_irq_level(s->cpu, i + 1, i + 25);
>> +            return;
>> +        }
>> +    }
>> +    m68k_set_irq_level(s->cpu, 0, 0);
>> +}
>> +
>> +static void main_cpu_reset(void *opaque)
>> +{
>> +    M68kCPU *cpu = opaque;
>> +    CPUState *cs = CPU(cpu);
>> +
>> +    cpu_reset(cs);
>> +    cpu->env.aregs[7] = ldl_phys(cs->as, 0);
>> +    cpu->env.pc = ldl_phys(cs->as, 4);
>> +}
>> +
>> +static void virt_init(MachineState *machine)
>> +{
>> +    M68kCPU *cpu = NULL;
>> +    int32_t kernel_size;
>> +    uint64_t elf_entry;
>> +    ram_addr_t initrd_base;
>> +    int32_t initrd_size;
>> +    ram_addr_t ram_size = machine->ram_size;
>> +    const char *kernel_filename = machine->kernel_filename;
>> +    const char *initrd_filename = machine->initrd_filename;
>> +    const char *kernel_cmdline = machine->kernel_cmdline;
>> +    hwaddr parameters_base;
>> +    DeviceState *dev;
>> +    DeviceState *pic_dev[7];
>> +    GLUEState *irq;
>> +    qemu_irq *cpu_pic;
>> +    SysBusDevice *sysbus;
>> +    hwaddr io_base;
>> +    int i;
>> +
>> +
>> +    if (ram_size > 3399672 * KiB) {
>> +        /*
>> +         * The physical memory can be up to 4 GiB - 16 MiB, but linux
>> +         * kernel crashes after this limit (~ 3.2 GiB)
>> +         */
>> +        error_report("Too much memory for this machine: %" PRId64 "
>> KiB, "
>> +                     "maximum 3399672 KiB", ram_size / KiB);
>> +        exit(1);
>> +    }
>> +
>> +    /* init CPUs */
>> +    cpu = M68K_CPU(cpu_create(machine->cpu_type));
> 
> Due to BOOTINFO1(..., BI_CPUTYPE, CPU_68040) below, don't you
> need to check machine->cpu_type == M68K_CPU_TYPE_NAME("m68040")?

Yes, you're right.

68030MMU is not implemented. So we can't use other CPU than 68040.

> 
>> +    qemu_register_reset(main_cpu_reset, cpu);
>> +
>> +    /* RAM */
>> +    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>> +
>> +    /* IRQ Glue */
>> +
>> +    irq = g_new0(GLUEState, 1);
>> +    irq->cpu = cpu;
>> +    cpu_pic = qemu_allocate_irqs(GLUE_set_irq, irq, 8);
>> +
>> +    /*
>> +     * 6 goldfish-pic
>> +     *
>> +     * map: 0xff000000 - 0xff006fff = 28 KiB
>> +     * IRQ: #1 (lower priority) -> #6 (higher priority)
>> +     *
>> +     */
>> +    io_base = VIRT_GF_PIC_MMIO_BASE;
>> +    for (i = 0; i < 6; i++) {
>> +        pic_dev[i] = qdev_new(TYPE_GOLDFISH_PIC);
>> +        sysbus = SYS_BUS_DEVICE(pic_dev[i]);
>> +        sysbus_realize_and_unref(sysbus, &error_fatal);
>> +
>> +        sysbus_mmio_map(sysbus, 0, io_base);
>> +        sysbus_connect_irq(sysbus, 0, cpu_pic[i]);
>> +
>> +        io_base += 0x1000;
>> +    }
>> +
>> +    /* goldfish-rtc */
>> +    dev = qdev_new(TYPE_GOLDFISH_RTC);
>> +    sysbus = SYS_BUS_DEVICE(dev);
>> +    sysbus_realize_and_unref(sysbus, &error_fatal);
>> +    sysbus_mmio_map(sysbus, 0, VIRT_GF_RTC_MMIO_BASE);
>> +    sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_GF_RTC_IRQ_BASE));
>> +
>> +    /* goldfish-tty */
>> +    dev = qdev_new(TYPE_GOLDFISH_TTY);
>> +    sysbus = SYS_BUS_DEVICE(dev);
>> +    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
>> +    sysbus_realize_and_unref(sysbus, &error_fatal);
>> +    sysbus_mmio_map(sysbus, 0, VIRT_GF_TTY_MMIO_BASE);
>> +    sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_GF_TTY_IRQ_BASE));
>> +
>> +    /* virtio-mmio */
>> +    io_base = VIRT_VIRTIO_MMIO_BASE;
>> +    for (i = 0; i < 128; i++) {
>> +        dev = qdev_new(TYPE_VIRTIO_MMIO);
>> +        qdev_prop_set_bit(dev, "force-legacy", false);
>> +        sysbus = SYS_BUS_DEVICE(dev);
>> +        sysbus_realize_and_unref(sysbus, &error_fatal);
>> +        sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_VIRTIO_IRQ_BASE +
>> i));
>> +        sysbus_mmio_map(sysbus, 0, io_base);
>> +        io_base += 0x200;
>> +    }
>> +
>> +    if (kernel_filename) {
>> +        CPUState *cs = CPU(cpu);
>> +        uint64_t high;
>> +
>> +        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
>> +                               &elf_entry, NULL, &high, NULL, 1,
>> +                               EM_68K, 0, 0);
>> +        if (kernel_size < 0) {
>> +            error_report("could not load kernel '%s'", kernel_filename);
>> +            exit(1);
>> +        }
>> +        stl_phys(cs->as, 4, elf_entry); /* reset initial PC */
>> +        parameters_base = (high + 1) & ~1;
>> +
>> +        BOOTINFO1(cs->as, parameters_base, BI_MACHTYPE, MACH_VIRT);
>> +        BOOTINFO1(cs->as, parameters_base, BI_FPUTYPE, FPU_68040);
>> +        BOOTINFO1(cs->as, parameters_base, BI_MMUTYPE, MMU_68040);
>> +        BOOTINFO1(cs->as, parameters_base, BI_CPUTYPE, CPU_68040);
> 
> (see machine->cpu_type question earlier).

see answer above.

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d0962a22e1b4..b08cf4251246 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1101,6 +1101,15 @@ F: include/hw/nubus/*
>>   F: include/hw/display/macfb.h
>>   F: include/hw/block/swim.h
>>   +virt
> 
> Maybe "m68k virt".

We have "virt" only for ARM, RISCV, Xtensa, ...
the m68k is implied by the qemu-system-m68k

> 
>> +M: Laurent Vivier <laurent@vivier.eu>
>> +S: Maintained
>> +F: hw/m68k/virt.c
>> +F: hw/char/goldfish_tty.c
>> +F: hw/intc/goldfish_pic.c
>> +F: include/hw/char/goldfish_tty.h
>> +F: include/hw/intc/goldfish_pic.h
>> +

Thanks,
Laurent


