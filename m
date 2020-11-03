Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1B7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2D921556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj6Vx1cE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2D921556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2qv-0004qJ-7w
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka2q8-00046I-Sp
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:23:37 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka2q6-0005F2-2r
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:23:35 -0500
Received: by mail-wr1-x442.google.com with SMTP id w1so19866289wrm.4
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 12:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=38AEF8dmSpRXq6JOjEF02qG3spfaEL+FlA9qvinjnaw=;
 b=Oj6Vx1cEzU2e9srm3uwwFoZ/+jBFg3FkGY3FQCPVVc82CawWze/7sLf7grL9EtjB+S
 rhFliPG7uJhbu99iHP8ot8QLn3XKnnN4fn5zIME/rqZ7ahQPFCOAWKzWvrcdsJ/JjK8u
 pvI9mfNCaL+s1GhEboqnC3n46UhL0aO1drHoDY2sSJHUvQDf19mCo1PMeupAv8Zapi37
 6A+tZ8cV0zfM1DL3XAAvr/LVbio3aLH24d8+iA4W8wk3Fc0bFVDjBppggZ6ySxf+ZxmB
 BbH9jI7X38fFoc3EbcvEsuN8k1DHy2u9VlszYY+9YcUUKRg8gfTPJo+Brgy7FruVR1Fp
 uHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=38AEF8dmSpRXq6JOjEF02qG3spfaEL+FlA9qvinjnaw=;
 b=Fg5D+8Qokbm9+dukXmQ7g2kqAxmA9h2qXBn+KpP7TyF/F5hDemKA7q3BxbBsmAYAM8
 PuYdVKKtivcG2tk+25ygQA39QUynrdzo1IZAc7bcMMxO7PUTpZYooaW3oB/ek4c4/btw
 SrAa2UT492GIoWkVrcS2m7BbkWzG7db/Fm1Jk+5Ti6x7+afrzxKbWVkdi4wzMfhc22Is
 p55KsRYbN/Bm9Xias69EzjH8UyeNnRJu1tBXTkwHmubnwtXtaALrU7wYtqUnZ/m/S02v
 TYYv6fS0D5IYK4r7kkmL4bhK3BLrdi1ZvgoFTycR5b+6v1f9a0onnxsP4k6AKhJBGU4T
 6RCw==
X-Gm-Message-State: AOAM530DKQJ8OR1Pr/6NcglNbE+IIhQbKq02r9yDHPCLu/olE6zbuflB
 Y8vePCLqLeohiVOQSdT6/oY=
X-Google-Smtp-Source: ABdhPJwhSUAfAYYHL8T1i0tIluQk+rzg/4Vk6v1Gi/ApYKBtIJ4y4+3RZo8Z/qNIGmVbAG16KHKdfA==
X-Received: by 2002:adf:f987:: with SMTP id f7mr12902653wrr.17.1604435012514; 
 Tue, 03 Nov 2020 12:23:32 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v123sm4136164wme.7.2020.11.03.12.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 12:23:31 -0800 (PST)
Subject: Re: [PATCH V16 5/6] hw/mips: Add Loongson-3 machine support
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
 <1604053541-27822-6-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1f8bba94-555a-8391-5045-a288dbfc7906@amsat.org>
Date: Tue, 3 Nov 2020 21:23:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1604053541-27822-6-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Huacai,

On 10/30/20 11:25 AM, Huacai Chen wrote:
> Add Loongson-3 based machine support, it use liointc as the interrupt
> controler and use GPEX as the pci controller. Currently it can work with
> both TCG and KVM.
> 
> As the machine model is not based on any exiting physical hardware, the
> name of the machine is "loongson3-virt". It may be superseded in future
> by a real machine model. If this happens, then a regular deprecation
> procedure shall occur for "loongson3-virt" machine.
> 
> We now already have a full functional Linux kernel (based on Linux-5.4.x
> LTS, the kvm host side and guest side have both been upstream for Linux-
> 5.9, but Linux-5.9 has not been released yet) here:
> 
> https://github.com/chenhuacai/linux
> 
> Of course the upstream kernel is also usable (though it is "unstable"
> now):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> How to use QEMU/Loongson-3?
> 1, Download kernel source from the above URL;
> 2, Build a kernel with arch/mips/configs/loongson3_defconfig;
> 3, Boot a Loongson-3A4000 host with this kernel (for KVM mode);
> 4, Build QEMU-master with this patchset;
> 5, modprobe kvm (only necessary for KVM mode);
> 6, Use QEMU with TCG:
>        qemu-system-mips64el -M loongson3-virt,accel=tcg -cpu Loongson-3A1000 -kernel <path_to_kernel> -append ...
>    Use QEMU with KVM:
>        qemu-system-mips64el -M loongson3-virt,accel=kvm -cpu Loongson-3A4000 -kernel <path_to_kernel> -append ...
> 
>    The "-cpu" parameter is optional here and QEMU will use the correct type for TCG/KVM automatically.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  default-configs/devices/mips64el-softmmu.mak |   1 +
>  hw/mips/Kconfig                              |  12 +
>  hw/mips/loongson3_virt.c                     | 620 +++++++++++++++++++++++++++
>  hw/mips/meson.build                          |   2 +-
>  4 files changed, 634 insertions(+), 1 deletion(-)
>  create mode 100644 hw/mips/loongson3_virt.c
...
> +static inline void loongson3_virt_devices_init(MachineState *machine, DeviceState *pic)
> +{
> +    int i;
> +    qemu_irq irq;
> +    PCIBus *pci_bus;
> +    DeviceState *dev;
> +    MemoryRegion *pio_alias;
> +    MemoryRegion *mmio_alias, *mmio_reg;
> +    MemoryRegion *ecam_alias, *ecam_reg;
> +
> +    dev = qdev_new(TYPE_GPEX_HOST);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    pci_bus = PCI_HOST_BRIDGE(dev)->bus;
> +
> +    ecam_alias = g_new0(MemoryRegion, 1);
> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> +                             ecam_reg, 0, virt_memmap[VIRT_PCIE_ECAM].size);
> +    memory_region_add_subregion(get_system_memory(),
> +                                virt_memmap[VIRT_PCIE_ECAM].base, ecam_alias);
> +
> +    mmio_alias = g_new0(MemoryRegion, 1);
> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> +                             mmio_reg, virt_memmap[VIRT_PCIE_MMIO].base,
> +                             virt_memmap[VIRT_PCIE_MMIO].size);
> +    memory_region_add_subregion(get_system_memory(),
> +                                virt_memmap[VIRT_PCIE_MMIO].base, mmio_alias);
> +
> +    pio_alias = g_new0(MemoryRegion, 1);
> +    memory_region_init_alias(pio_alias, OBJECT(dev), "pcie-pio",
> +                             get_system_io(), 0, virt_memmap[VIRT_PCIE_PIO].size);
> +    memory_region_add_subregion(get_system_memory(),
> +                                virt_memmap[VIRT_PCIE_PIO].base, pio_alias);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, virt_memmap[VIRT_PCIE_PIO].base);
> +
> +    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +        irq = qdev_get_gpio_in(pic, PCIE_IRQ_BASE + i);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> +        gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ_BASE + i);
> +    }
> +
> +    pci_vga_init(pci_bus);
> +
> +    if (defaults_enabled()) {
> +        pci_create_simple(pci_bus, -1, "pci-ohci");
> +        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> +        usb_create_simple(usb_bus_find(-1), "usb-tablet");
> +    }
> +
> +    for (i = 0; i < nb_nics; i++) {
> +        NICInfo *nd = &nd_table[i];
> +
> +        if (!nd->model) {
> +            nd->model = g_strdup("virtio");
> +        }
> +
> +        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
> +    }
> +}
> +
> +static void mips_loongson3_virt_init(MachineState *machine)
> +{
> +    int i;
> +    long bios_size;
> +    MIPSCPU *cpu;
> +    Clock *cpuclk;
> +    CPUMIPSState *env;
> +    DeviceState *liointc;
> +    char *filename;
> +    const char *kernel_cmdline = machine->kernel_cmdline;
> +    const char *kernel_filename = machine->kernel_filename;
> +    const char *initrd_filename = machine->initrd_filename;
> +    ram_addr_t ram_size = machine->ram_size;
> +    MemoryRegion *address_space_mem = get_system_memory();
> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
> +    MemoryRegion *bios = g_new(MemoryRegion, 1);
> +    MemoryRegion *iomem = g_new(MemoryRegion, 1);
> +
> +    /* TODO: TCG will support all CPU types */
> +    if (!kvm_enabled()) {
> +        if (!machine->cpu_type) {
> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
> +        }
> +        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
> +            error_report("Loongson-3/TCG needs cpu type Loongson-3A1000");
> +            exit(1);
> +        }
> +    } else {
> +        if (!machine->cpu_type) {
> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A4000");
> +        }
> +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
> +            error_report("Loongson-3/KVM needs cpu type Loongson-3A4000");
> +            exit(1);
> +        }
> +    }
> +
> +    if (ram_size < 512 * MiB) {
> +        error_report("Loongson-3 machine needs at least 512MB memory");
> +        exit(1);
> +    }
> +
> +    /*
> +     * The whole MMIO range among configure registers doesn't generate
> +     * exception when accessing invalid memory. Create some unimplememted
> +     * devices to emulate this feature.
> +     */
> +    create_unimplemented_device("mmio fallback 0", 0x10000000, 256 * MiB);
> +    create_unimplemented_device("mmio fallback 1", 0x30000000, 256 * MiB);
> +
> +    liointc = qdev_new("loongson.liointc");

Please use TYPE_name when creating QOM (here TYPE_LOONGSON_LIOINTC).
Similarly loongson3_virt_devices_init(). (no need to respin yet).

> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(liointc), 0, virt_memmap[VIRT_LIOINTC].base);
> +
> +    serial_mm_init(address_space_mem, virt_memmap[VIRT_UART].base, 0,
> +                   qdev_get_gpio_in(liointc, UART_IRQ), 115200, serial_hd(0),
> +                   DEVICE_NATIVE_ENDIAN);
> +
> +    sysbus_create_simple("goldfish_rtc", virt_memmap[VIRT_RTC].base,
> +                         qdev_get_gpio_in(liointc, RTC_IRQ));
> +
> +    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
> +    clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
> +
> +    for (i = 0; i < machine->smp.cpus; i++) {
> +        int ip;
> +
> +        /* init CPUs */
> +        cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
> +
> +        /* Init internal devices */
> +        cpu_mips_irq_init_cpu(cpu);
> +        cpu_mips_clock_init(cpu);
> +        qemu_register_reset(main_cpu_reset, cpu);
> +
> +        if (i >= 4) {
> +            continue; /* Only node-0 can be connected to LIOINTC */
> +        }
> +
> +        for (ip = 0; ip < 4 ; ip++) {
> +            int pin = i * 4 + ip;
> +            sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
> +                               pin, cpu->env.irq[ip + 2]);
> +        }
> +    }
> +    env = &MIPS_CPU(first_cpu)->env;
...

