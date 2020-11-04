Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEEDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 03:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74CA2074F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 03:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z698shl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74CA2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka9ZM-0003pU-TH
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 22:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1ka9YK-00030Z-M8
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 22:33:41 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1ka9YH-0002Cy-CE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 22:33:40 -0500
Received: by mail-il1-x144.google.com with SMTP id g15so3378478ilc.9
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 19:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VDTmG77zFkT6YGoSFsbprqEAkGboiZdBNYR9MK26rwQ=;
 b=Z698shl5oeX8H9Dkpt0BtUIxLIhUBCDiRjnVJQIsMzT379Gg860E3u3zbte6shYZa5
 eyUnJnKP4u8ugGYNl0Q9GkjaO0CqBqRbYUohEdkxXn0/TMkd5GJ76bhN72hpdEt6vQ31
 G3uSk4Y+UQgGPRIVur/SoCBxVSXnIlsDdG2nRaS2GNSFzm872bsSJ3IUw1sCVqWO1dd6
 RH3RJUmwZufycR8hzIYMBJjhUgWDo839X2LnvFQjpUOsLZDj/t2TdlQUXUiqn1KhWB/t
 w2wwJCN3V2/Jy9GurnMoWFDHTMxSBFbFjpiCXb6llBy+c6lkD0I0gZqaDBlobpwTmGax
 kiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VDTmG77zFkT6YGoSFsbprqEAkGboiZdBNYR9MK26rwQ=;
 b=ukGb2F2HohbzYzBjTfI9niNn1ztVF/YHNMVfYuHNFvHCokvQJdgmCTnfplyS59H+rc
 rIHWE7Dtt6p03LXiAhCaS7dy6VJxnQ9mHEc5dYgyHIOiZWY2lXl2nnQQtuyBikmiFFPH
 BJUY+TwT3EGfyGzcX7oFqOkpdKAEPyUDcx5luWTu1ATLYgWM3AZLwAHFXQ2ZXCAEZjzO
 Jl2v9FEdQdStWOYP9uFWpkt/52QnWVsh7qbxP/SYUJFj/UebrAZxaVMUtvvrGbrET3MC
 N45UZvCB1P7qQdHy0LHvL3eB9TtsnjR4aZ58CCe9/RD8vc5XVEoe58mFwPZ9FFtLmz5M
 u/hQ==
X-Gm-Message-State: AOAM5313qB96Kc6KxziWrwWXPLOQUe7zn9my4aB3bZ3X2ZG7xzj99+Mg
 /gJk2RqOInXP5dHb2ZFXVStzEUclRZq0d9u94Vw=
X-Google-Smtp-Source: ABdhPJzGC15vOZus+NsGliRvtGceMGupX95Y8KIS0os/l3l9rL63t5DAgTDED5kbQcwtLyVVubXdJN81UhxpXzkuCdA=
X-Received: by 2002:a92:a808:: with SMTP id o8mr15497749ilh.35.1604460815846; 
 Tue, 03 Nov 2020 19:33:35 -0800 (PST)
MIME-Version: 1.0
References: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
 <1604053541-27822-6-git-send-email-chenhc@lemote.com>
 <1f8bba94-555a-8391-5045-a288dbfc7906@amsat.org>
In-Reply-To: <1f8bba94-555a-8391-5045-a288dbfc7906@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Wed, 4 Nov 2020 11:33:24 +0800
Message-ID: <CAAhV-H7bofE1V9oRFbqfGTnSm7R4ogPzuegid_Ekv0Eyn3SpdQ@mail.gmail.com>
Subject: Re: [PATCH V16 5/6] hw/mips: Add Loongson-3 machine support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=chenhuacai@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Wed, Nov 4, 2020 at 4:23 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Hi Huacai,
>
> On 10/30/20 11:25 AM, Huacai Chen wrote:
> > Add Loongson-3 based machine support, it use liointc as the interrupt
> > controler and use GPEX as the pci controller. Currently it can work wit=
h
> > both TCG and KVM.
> >
> > As the machine model is not based on any exiting physical hardware, the
> > name of the machine is "loongson3-virt". It may be superseded in future
> > by a real machine model. If this happens, then a regular deprecation
> > procedure shall occur for "loongson3-virt" machine.
> >
> > We now already have a full functional Linux kernel (based on Linux-5.4.=
x
> > LTS, the kvm host side and guest side have both been upstream for Linux=
-
> > 5.9, but Linux-5.9 has not been released yet) here:
> >
> > https://github.com/chenhuacai/linux
> >
> > Of course the upstream kernel is also usable (though it is "unstable"
> > now):
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >
> > How to use QEMU/Loongson-3?
> > 1, Download kernel source from the above URL;
> > 2, Build a kernel with arch/mips/configs/loongson3_defconfig;
> > 3, Boot a Loongson-3A4000 host with this kernel (for KVM mode);
> > 4, Build QEMU-master with this patchset;
> > 5, modprobe kvm (only necessary for KVM mode);
> > 6, Use QEMU with TCG:
> >        qemu-system-mips64el -M loongson3-virt,accel=3Dtcg -cpu Loongson=
-3A1000 -kernel <path_to_kernel> -append ...
> >    Use QEMU with KVM:
> >        qemu-system-mips64el -M loongson3-virt,accel=3Dkvm -cpu Loongson=
-3A4000 -kernel <path_to_kernel> -append ...
> >
> >    The "-cpu" parameter is optional here and QEMU will use the correct =
type for TCG/KVM automatically.
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> >  default-configs/devices/mips64el-softmmu.mak |   1 +
> >  hw/mips/Kconfig                              |  12 +
> >  hw/mips/loongson3_virt.c                     | 620 +++++++++++++++++++=
++++++++
> >  hw/mips/meson.build                          |   2 +-
> >  4 files changed, 634 insertions(+), 1 deletion(-)
> >  create mode 100644 hw/mips/loongson3_virt.c
> ...
> > +static inline void loongson3_virt_devices_init(MachineState *machine, =
DeviceState *pic)
> > +{
> > +    int i;
> > +    qemu_irq irq;
> > +    PCIBus *pci_bus;
> > +    DeviceState *dev;
> > +    MemoryRegion *pio_alias;
> > +    MemoryRegion *mmio_alias, *mmio_reg;
> > +    MemoryRegion *ecam_alias, *ecam_reg;
> > +
> > +    dev =3D qdev_new(TYPE_GPEX_HOST);
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > +    pci_bus =3D PCI_HOST_BRIDGE(dev)->bus;
> > +
> > +    ecam_alias =3D g_new0(MemoryRegion, 1);
> > +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> > +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> > +                             ecam_reg, 0, virt_memmap[VIRT_PCIE_ECAM].=
size);
> > +    memory_region_add_subregion(get_system_memory(),
> > +                                virt_memmap[VIRT_PCIE_ECAM].base, ecam=
_alias);
> > +
> > +    mmio_alias =3D g_new0(MemoryRegion, 1);
> > +    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> > +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> > +                             mmio_reg, virt_memmap[VIRT_PCIE_MMIO].bas=
e,
> > +                             virt_memmap[VIRT_PCIE_MMIO].size);
> > +    memory_region_add_subregion(get_system_memory(),
> > +                                virt_memmap[VIRT_PCIE_MMIO].base, mmio=
_alias);
> > +
> > +    pio_alias =3D g_new0(MemoryRegion, 1);
> > +    memory_region_init_alias(pio_alias, OBJECT(dev), "pcie-pio",
> > +                             get_system_io(), 0, virt_memmap[VIRT_PCIE=
_PIO].size);
> > +    memory_region_add_subregion(get_system_memory(),
> > +                                virt_memmap[VIRT_PCIE_PIO].base, pio_a=
lias);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, virt_memmap[VIRT_PCIE_PIO]=
.base);
> > +
> > +    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > +        irq =3D qdev_get_gpio_in(pic, PCIE_IRQ_BASE + i);
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> > +        gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ_BASE + i);
> > +    }
> > +
> > +    pci_vga_init(pci_bus);
> > +
> > +    if (defaults_enabled()) {
> > +        pci_create_simple(pci_bus, -1, "pci-ohci");
> > +        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> > +        usb_create_simple(usb_bus_find(-1), "usb-tablet");
> > +    }
> > +
> > +    for (i =3D 0; i < nb_nics; i++) {
> > +        NICInfo *nd =3D &nd_table[i];
> > +
> > +        if (!nd->model) {
> > +            nd->model =3D g_strdup("virtio");
> > +        }
> > +
> > +        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
> > +    }
> > +}
> > +
> > +static void mips_loongson3_virt_init(MachineState *machine)
> > +{
> > +    int i;
> > +    long bios_size;
> > +    MIPSCPU *cpu;
> > +    Clock *cpuclk;
> > +    CPUMIPSState *env;
> > +    DeviceState *liointc;
> > +    char *filename;
> > +    const char *kernel_cmdline =3D machine->kernel_cmdline;
> > +    const char *kernel_filename =3D machine->kernel_filename;
> > +    const char *initrd_filename =3D machine->initrd_filename;
> > +    ram_addr_t ram_size =3D machine->ram_size;
> > +    MemoryRegion *address_space_mem =3D get_system_memory();
> > +    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> > +    MemoryRegion *bios =3D g_new(MemoryRegion, 1);
> > +    MemoryRegion *iomem =3D g_new(MemoryRegion, 1);
> > +
> > +    /* TODO: TCG will support all CPU types */
> > +    if (!kvm_enabled()) {
> > +        if (!machine->cpu_type) {
> > +            machine->cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-3A1000"=
);
> > +        }
> > +        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
> > +            error_report("Loongson-3/TCG needs cpu type Loongson-3A100=
0");
> > +            exit(1);
> > +        }
> > +    } else {
> > +        if (!machine->cpu_type) {
> > +            machine->cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-3A4000"=
);
> > +        }
> > +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
> > +            error_report("Loongson-3/KVM needs cpu type Loongson-3A400=
0");
> > +            exit(1);
> > +        }
> > +    }
> > +
> > +    if (ram_size < 512 * MiB) {
> > +        error_report("Loongson-3 machine needs at least 512MB memory")=
;
> > +        exit(1);
> > +    }
> > +
> > +    /*
> > +     * The whole MMIO range among configure registers doesn't generate
> > +     * exception when accessing invalid memory. Create some unimplemem=
ted
> > +     * devices to emulate this feature.
> > +     */
> > +    create_unimplemented_device("mmio fallback 0", 0x10000000, 256 * M=
iB);
> > +    create_unimplemented_device("mmio fallback 1", 0x30000000, 256 * M=
iB);
> > +
> > +    liointc =3D qdev_new("loongson.liointc");
>
> Please use TYPE_name when creating QOM (here TYPE_LOONGSON_LIOINTC).
> Similarly loongson3_virt_devices_init(). (no need to respin yet).
OK, thanks.

Huacai
>
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
> > +
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(liointc), 0, virt_memmap[VIRT_LIOIN=
TC].base);
> > +
> > +    serial_mm_init(address_space_mem, virt_memmap[VIRT_UART].base, 0,
> > +                   qdev_get_gpio_in(liointc, UART_IRQ), 115200, serial=
_hd(0),
> > +                   DEVICE_NATIVE_ENDIAN);
> > +
> > +    sysbus_create_simple("goldfish_rtc", virt_memmap[VIRT_RTC].base,
> > +                         qdev_get_gpio_in(liointc, RTC_IRQ));
> > +
> > +    cpuclk =3D clock_new(OBJECT(machine), "cpu-refclk");
> > +    clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
> > +
> > +    for (i =3D 0; i < machine->smp.cpus; i++) {
> > +        int ip;
> > +
> > +        /* init CPUs */
> > +        cpu =3D mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
> > +
> > +        /* Init internal devices */
> > +        cpu_mips_irq_init_cpu(cpu);
> > +        cpu_mips_clock_init(cpu);
> > +        qemu_register_reset(main_cpu_reset, cpu);
> > +
> > +        if (i >=3D 4) {
> > +            continue; /* Only node-0 can be connected to LIOINTC */
> > +        }
> > +
> > +        for (ip =3D 0; ip < 4 ; ip++) {
> > +            int pin =3D i * 4 + ip;
> > +            sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
> > +                               pin, cpu->env.irq[ip + 2]);
> > +        }
> > +    }
> > +    env =3D &MIPS_CPU(first_cpu)->env;
> ...

