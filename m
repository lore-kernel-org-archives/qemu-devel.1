Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E549C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F0D22CD5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F0D22CD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbHn-00032b-HC
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37982)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqbHa-0002e9-Kv
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqbHY-0007wu-6m
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:47:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqbHX-0007wT-HS
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:47:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so44282977wmg.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 03:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mXNMh4Xqv9+/iKQusWtx/Wa9gt6gj8/QzY3EI9eZ/84=;
 b=lZshzluUZTNq8D/564LQBG08eI9WkjjNG4kB75p5IhdxFsrG3+UP9XdPmkooVKy8yg
 wQ18m7V/4273SV/qRf5pmrvcBZI8AHUuZUso6snbzkEbULgutXy0OV0VdbLYCrK89yPb
 DE0pWxfm1SRWiOQBrl8FnQ2z7uyLcgsy8h5lAhUoJy0D7p7q2bXLelX3H0BWzrnn3R7m
 nChHnIOTmLkurp0RokI77QKsRDci3pums7ZktEcebRsXkcy7cdaILXoBEJEA1GZyIKLL
 BBeyVK7KUr+QvTKZJjRxeHyAw+hx1wXODc0ISItrfsA2hlxV1v4kh5w61Xu4Hd1tgLBN
 6Yng==
X-Gm-Message-State: APjAAAVmqPUQCQkVIbwtwbt9ROYQdMU9hwmX6XFPGTJ3j0aEZHl/0mql
 dRDyU/MKYHSOglYvTJLOWb6NHqzcHFY=
X-Google-Smtp-Source: APXvYqwNtwR6dgOx8XX4X8YjDhaeIFSVywq74ILdQUuSIis1mXH6mjeS0uHkM7eOcqUvRq9ZfKbYEQ==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr77193330wmc.89.1564051649945; 
 Thu, 25 Jul 2019 03:47:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id i6sm42645939wrv.47.2019.07.25.03.47.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 03:47:29 -0700 (PDT)
To: Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 marcel.apfelbaum@gmail.com, rth@twiddle.net, ehabkost@redhat.com,
 maran.wilson@oracle.com, sgarzare@redhat.com, kraxel@redhat.com
References: <20190702121106.28374-1-slp@redhat.com>
 <20190702121106.28374-5-slp@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34e729c5-5192-2cda-048a-55388d6f8e01@redhat.com>
Date: Thu, 25 Jul 2019 12:47:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190702121106.28374-5-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 4/4] hw/i386: Introduce the microvm
 machine type
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/19 14:11, Sergio Lopez wrote:
> +static void microvm_ioapic_init(MicrovmMachineState *mms)
> +{
> +    qemu_irq *ioapic_irq;
> +    DeviceState *ioapic_dev;
> +    SysBusDevice *d;
> +    int i;
> +
> +    assert(kvm_irqchip_in_kernel());
> +    ioapic_irq = g_new0(qemu_irq, IOAPIC_NUM_PINS);
> +    kvm_pc_setup_irq_routing(true);
> +
> +    assert(kvm_ioapic_in_kernel());
> +    ioapic_dev = qdev_create(NULL, "kvm-ioapic");
> +
> +    object_property_add_child(qdev_get_machine(),
> +                              "ioapic", OBJECT(ioapic_dev), NULL);

Please use the userspace IOAPIC instead, using the kernel one is just
sweeping the attack surface under the rug.

You are also missing the LAPIC device; things are working only because
KVM is helpfully creating one for you but it's better to be precise in
the description of the hardware.  I'd like to have support for non-KVM
accelerators (TCG, HAX, HVF) and they should all come for free if you
support "-machine kernel_irqchip=off".

Finally, I thing we can agree that legacy mode can go away.  At the same
time I think we should always have:

1) an ISA bus, even if it's mostly empty, since we have fw_cfg on it now

2) an optional RTC accessible via "-machine rtc=on|off", so that the
guest can know the current time even if it is running under an
accelerator other than KVM (or doesn't have access to kvmclock).

3) possibly, a fake "keyboard controller" device to support reset via
port 64h

Thanks!

Paolo

> +    qdev_init_nofail(ioapic_dev);
> +    d = SYS_BUS_DEVICE(ioapic_dev);
> +    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
> +
> +    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
> +        ioapic_irq[i] = qdev_get_gpio_in(ioapic_dev, i);
> +    }
> +
> +    mms->gsi = qemu_allocate_irqs(microvm_gsi_handler,
> +                                  ioapic_irq, IOAPIC_NUM_PINS);
> +
> +    for (i = 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
> +        sysbus_create_simple("virtio-mmio",
> +                             VIRTIO_MMIO_BASE + i * 512,
> +                             mms->gsi[VIRTIO_IRQ_BASE + i]);
> +    }
> +}
> +
> +static void microvm_memory_init(MicrovmMachineState *mms)
> +{
> +    MachineState *machine = MACHINE(mms);
> +    MemoryRegion *ram, *ram_below_4g, *ram_above_4g;
> +    MemoryRegion *system_memory = get_system_memory();
> +
> +    if (machine->ram_size > MICROVM_MAX_BELOW_4G) {
> +        mms->above_4g_mem_size = machine->ram_size - MICROVM_MAX_BELOW_4G;
> +        mms->below_4g_mem_size = MICROVM_MAX_BELOW_4G;
> +    } else {
> +        mms->above_4g_mem_size = 0;
> +        mms->below_4g_mem_size = machine->ram_size;
> +    }
> +
> +    ram = g_malloc(sizeof(*ram));
> +    memory_region_allocate_system_memory(ram, NULL, "microvm.ram",
> +                                         machine->ram_size);
> +
> +    ram_below_4g = g_malloc(sizeof(*ram_below_4g));
> +    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
> +                             0, mms->below_4g_mem_size);
> +    memory_region_add_subregion(system_memory, 0, ram_below_4g);
> +
> +    e820_add_entry(0, mms->below_4g_mem_size, E820_RAM);
> +
> +    if (mms->above_4g_mem_size > 0) {
> +        ram_above_4g = g_malloc(sizeof(*ram_above_4g));
> +        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram,
> +                                 mms->below_4g_mem_size,
> +                                 mms->above_4g_mem_size);
> +        memory_region_add_subregion(system_memory, 0x100000000ULL,
> +                                    ram_above_4g);
> +        e820_add_entry(0x100000000ULL, mms->above_4g_mem_size, E820_RAM);
> +    }
> +}
> +
> +static void microvm_cpus_init(const char *typename, Error **errp)
> +{
> +    int i;
> +
> +    for (i = 0; i < smp_cpus; i++) {
> +        Object *cpu = NULL;
> +        Error *local_err = NULL;
> +
> +        cpu = object_new(typename);
> +
> +        object_property_set_uint(cpu, i, "apic-id", &local_err);
> +        object_property_set_bool(cpu, true, "realized", &local_err);
> +
> +        object_unref(cpu);
> +        error_propagate(errp, local_err);
> +    }
> +}
> +
> +static void microvm_machine_state_init(MachineState *machine)
> +{
> +    MicrovmMachineState *mms = MICROVM_MACHINE(machine);
> +    Error *local_err = NULL;
> +
> +    if (machine->kernel_filename == NULL) {
> +        error_report("missing kernel image file name, required by microvm");
> +        exit(1);
> +    }
> +
> +    microvm_memory_init(mms);
> +
> +    microvm_cpus_init(machine->cpu_type, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        exit(1);
> +    }
> +
> +    if (mms->legacy) {
> +        microvm_legacy_init(mms);
> +    } else {
> +        microvm_ioapic_init(mms);
> +    }
> +
> +    kvmclock_create();
> +
> +    if (!pvh_load_elfboot(machine->kernel_filename, NULL, NULL)) {
> +        error_report("Error while loading elf kernel");
> +        exit(1);
> +    }
> +
> +    if (machine->initrd_filename) {
> +        uint32_t initrd_max;
> +        gsize initrd_size;
> +        gchar *initrd_data;
> +        GError *gerr = NULL;
> +
> +        if (!g_file_get_contents(machine->initrd_filename, &initrd_data,
> +                                 &initrd_size, &gerr)) {
> +            error_report("qemu: error reading initrd %s: %s\n",
> +                         machine->initrd_filename, gerr->message);
> +            exit(1);
> +        }
> +
> +        initrd_max = mms->below_4g_mem_size - HIMEM_START;
> +        if (initrd_size >= initrd_max) {
> +            error_report("qemu: initrd is too large, cannot support."
> +                         "(max: %"PRIu32", need %"PRId64")\n",
> +                         initrd_max, (uint64_t)initrd_size);
> +            exit(1);
> +        }
> +
> +        address_space_write(&address_space_memory,
> +                            HIMEM_START, MEMTXATTRS_UNSPECIFIED,
> +                            (uint8_t *) initrd_data, initrd_size);
> +
> +        g_free(initrd_data);
> +
> +        mms->initrd_addr = HIMEM_START;
> +        mms->initrd_size = initrd_size;
> +    }
> +
> +    mms->elf_entry = pvh_get_start_addr();
> +}
> +
> +static gchar *microvm_get_mmio_cmdline(gchar *name)
> +{
> +    gchar *cmdline;
> +    gchar *separator;
> +    long int index;
> +    int ret;
> +
> +    separator = g_strrstr(name, ".");
> +    if (!separator) {
> +        return NULL;
> +    }
> +
> +    if (qemu_strtol(separator + 1, NULL, 10, &index) != 0) {
> +        return NULL;
> +    }
> +
> +    cmdline = g_malloc0(VIRTIO_CMDLINE_MAXLEN);
> +    ret = g_snprintf(cmdline, VIRTIO_CMDLINE_MAXLEN,
> +                     " virtio_mmio.device=512@0x%lx:%ld",
> +                     VIRTIO_MMIO_BASE + index * 512,
> +                     VIRTIO_IRQ_BASE + index);
> +    if (ret < 0 || ret >= VIRTIO_CMDLINE_MAXLEN) {
> +        g_free(cmdline);
> +        return NULL;
> +    }
> +
> +    return cmdline;
> +}
> +
> +static void microvm_setup_pvh(MicrovmMachineState *mms,
> +                              const gchar *kernel_cmdline)
> +{
> +    struct hvm_memmap_table_entry *memmap_table;
> +    struct hvm_start_info *start_info;
> +    BusState *bus;
> +    BusChild *kid;
> +    gchar *cmdline;
> +    int cmdline_len;
> +    int memmap_entries;
> +    int i;
> +
> +    cmdline = g_strdup(kernel_cmdline);
> +
> +    /*
> +     * Find MMIO transports with attached devices, and add them to the kernel
> +     * command line.
> +     */
> +    bus = sysbus_get_default();
> +    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> +        DeviceState *dev = kid->child;
> +        ObjectClass *class = object_get_class(OBJECT(dev));
> +
> +        if (class == object_class_by_name(TYPE_VIRTIO_MMIO)) {
> +            VirtIOMMIOProxy *mmio = VIRTIO_MMIO(OBJECT(dev));
> +            VirtioBusState *mmio_virtio_bus = &mmio->bus;
> +            BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
> +
> +            if (!QTAILQ_EMPTY(&mmio_bus->children)) {
> +                gchar *mmio_cmdline = microvm_get_mmio_cmdline(mmio_bus->name);
> +                if (mmio_cmdline) {
> +                    char *newcmd = g_strjoin(NULL, cmdline, mmio_cmdline, NULL);
> +                    g_free(mmio_cmdline);
> +                    g_free(cmdline);
> +                    cmdline = newcmd;
> +                }
> +            }
> +        }
> +    }
> +
> +    cmdline_len = strlen(cmdline);
> +
> +    address_space_write(&address_space_memory,
> +                        KERNEL_CMDLINE_START, MEMTXATTRS_UNSPECIFIED,
> +                        (uint8_t *) cmdline, cmdline_len);
> +
> +    g_free(cmdline);
> +
> +    memmap_entries = e820_get_num_entries();
> +    memmap_table = g_new0(struct hvm_memmap_table_entry, memmap_entries);
> +    for (i = 0; i < memmap_entries; i++) {
> +        uint64_t address, length;
> +        struct hvm_memmap_table_entry *entry = &memmap_table[i];
> +
> +        if (e820_get_entry(i, E820_RAM, &address, &length)) {
> +            entry->addr = address;
> +            entry->size = length;
> +            entry->type = E820_RAM;
> +            entry->reserved = 0;
> +        }
> +    }
> +
> +    address_space_write(&address_space_memory,
> +                        MEMMAP_START, MEMTXATTRS_UNSPECIFIED,
> +                        (uint8_t *) memmap_table,
> +                        memmap_entries * sizeof(struct hvm_memmap_table_entry));
> +
> +    g_free(memmap_table);
> +
> +    start_info = g_malloc0(sizeof(struct hvm_start_info));
> +
> +    start_info->magic = XEN_HVM_START_MAGIC_VALUE;
> +    start_info->version = 1;
> +
> +    start_info->nr_modules = 0;
> +    start_info->cmdline_paddr = KERNEL_CMDLINE_START;
> +    start_info->memmap_entries = memmap_entries;
> +    start_info->memmap_paddr = MEMMAP_START;
> +
> +    if (mms->initrd_addr) {
> +        struct hvm_modlist_entry *entry = g_new0(struct hvm_modlist_entry, 1);
> +
> +        entry->paddr = mms->initrd_addr;
> +        entry->size = mms->initrd_size;
> +
> +        address_space_write(&address_space_memory,
> +                            MODLIST_START, MEMTXATTRS_UNSPECIFIED,
> +                            (uint8_t *) entry,
> +                            sizeof(struct hvm_modlist_entry));
> +        g_free(entry);
> +
> +        start_info->nr_modules = 1;
> +        start_info->modlist_paddr = MODLIST_START;
> +    } else {
> +        start_info->nr_modules = 0;
> +    }
> +
> +    address_space_write(&address_space_memory,
> +                        PVH_START_INFO, MEMTXATTRS_UNSPECIFIED,
> +                        (uint8_t *) start_info,
> +                        sizeof(struct hvm_start_info));
> +
> +    g_free(start_info);
> +}
> +
> +static void microvm_init_page_tables(void)
> +{
> +    uint64_t val = 0;
> +    int i;
> +
> +    val = PDPTE_START | 0x03;
> +    address_space_write(&address_space_memory,
> +                        PML4_START, MEMTXATTRS_UNSPECIFIED,
> +                        (uint8_t *) &val, 8);
> +    val = PDE_START | 0x03;
> +    address_space_write(&address_space_memory,
> +                        PDPTE_START, MEMTXATTRS_UNSPECIFIED,
> +                        (uint8_t *) &val, 8);
> +
> +    for (i = 0; i < 512; i++) {
> +        val = (i << 21) + 0x83;
> +        address_space_write(&address_space_memory,
> +                            PDE_START + (i * 8), MEMTXATTRS_UNSPECIFIED,
> +                            (uint8_t *) &val, 8);
> +    }
> +}
> +
> +static void microvm_cpu_reset(CPUState *cs, uint64_t elf_entry)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    struct SegmentCache seg_code = { .selector = 0x8,
> +                                     .base = 0x0,
> +                                     .limit = 0xffffffff,
> +                                     .flags = 0xc09b00 };
> +    struct SegmentCache seg_data = { .selector = 0x10,
> +                                     .base = 0x0,
> +                                     .limit = 0xffffffff,
> +                                     .flags = 0xc09300 };
> +    struct SegmentCache seg_tr = { .selector = 0x18,
> +                                   .base = 0x0,
> +                                   .limit = 0xffff,
> +                                   .flags = 0x8b00 };
> +
> +    memcpy(&env->segs[R_CS], &seg_code, sizeof(struct SegmentCache));
> +    memcpy(&env->segs[R_DS], &seg_data, sizeof(struct SegmentCache));
> +    memcpy(&env->segs[R_ES], &seg_data, sizeof(struct SegmentCache));
> +    memcpy(&env->segs[R_FS], &seg_data, sizeof(struct SegmentCache));
> +    memcpy(&env->segs[R_GS], &seg_data, sizeof(struct SegmentCache));
> +    memcpy(&env->segs[R_SS], &seg_data, sizeof(struct SegmentCache));
> +    memcpy(&env->tr, &seg_tr, sizeof(struct SegmentCache));
> +
> +    env->regs[R_EBX] = PVH_START_INFO;
> +
> +    cpu_set_pc(cs, elf_entry);
> +    cpu_x86_update_cr3(env, 0);
> +    cpu_x86_update_cr4(env, 0);
> +    cpu_x86_update_cr0(env, CR0_PE_MASK);
> +
> +    x86_update_hflags(env);
> +}
> +
> +static void microvm_mptable_setup(MicrovmMachineState *mms)
> +{
> +    char *mptable;
> +    int size;
> +
> +    mptable = mptable_generate(smp_cpus, EBDA_START, &size);
> +    address_space_write(&address_space_memory,
> +                        EBDA_START, MEMTXATTRS_UNSPECIFIED,
> +                        (uint8_t *) mptable, size);
> +    g_free(mptable);
> +}
> +
> +static bool microvm_machine_get_legacy(Object *obj, Error **errp)
> +{
> +    MicrovmMachineState *mms = MICROVM_MACHINE(obj);
> +
> +    return mms->legacy;
> +}
> +
> +static void microvm_machine_set_legacy(Object *obj, bool value, Error **errp)
> +{
> +    MicrovmMachineState *mms = MICROVM_MACHINE(obj);
> +
> +    mms->legacy = value;
> +}
> +
> +static void microvm_machine_reset(void)
> +{
> +    MachineState *machine = MACHINE(qdev_get_machine());
> +    MicrovmMachineState *mms = MICROVM_MACHINE(machine);
> +    CPUState *cs;
> +    X86CPU *cpu;
> +
> +    qemu_devices_reset();
> +
> +    microvm_mptable_setup(mms);
> +    microvm_setup_pvh(mms, machine->kernel_cmdline);
> +    microvm_init_page_tables();
> +
> +    CPU_FOREACH(cs) {
> +        cpu = X86_CPU(cs);
> +
> +        if (cpu->apic_state) {
> +            device_reset(cpu->apic_state);
> +        }
> +
> +        microvm_cpu_reset(cs, mms->elf_entry);
> +    }
> +}
> +
> +static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
> +{
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        X86CPU *cpu = X86_CPU(cs);
> +
> +        if (!cpu->apic_state) {
> +            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
> +        } else {
> +            apic_deliver_nmi(cpu->apic_state);
> +        }
> +    }
> +}
> +
> +static void microvm_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    NMIClass *nc = NMI_CLASS(oc);
> +
> +    mc->init = microvm_machine_state_init;
> +
> +    mc->family = "microvm_i386";
> +    mc->desc = "Microvm (i386)";
> +    mc->units_per_default_bus = 1;
> +    mc->no_floppy = 1;
> +    machine_class_allow_dynamic_sysbus_dev(mc, "sysbus-debugcon");
> +    machine_class_allow_dynamic_sysbus_dev(mc, "sysbus-debugexit");
> +    mc->max_cpus = 288;
> +    mc->has_hotpluggable_cpus = false;
> +    mc->auto_enable_numa_with_memhp = false;
> +    mc->default_cpu_type = X86_CPU_TYPE_NAME("host");
> +    mc->nvdimm_supported = false;
> +    mc->default_machine_opts = "accel=kvm";
> +
> +    /* Machine class handlers */
> +    mc->reset = microvm_machine_reset;
> +
> +    /* NMI handler */
> +    nc->nmi_monitor_handler = x86_nmi;
> +
> +    object_class_property_add_bool(oc, MICROVM_MACHINE_LEGACY,
> +                                   microvm_machine_get_legacy,
> +                                   microvm_machine_set_legacy,
> +                                   &error_abort);
> +}
> +
> +static const TypeInfo microvm_machine_info = {
> +    .name          = TYPE_MICROVM_MACHINE,
> +    .parent        = TYPE_MACHINE,
> +    .instance_size = sizeof(MicrovmMachineState),
> +    .class_size    = sizeof(MicrovmMachineClass),
> +    .class_init    = microvm_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +         { TYPE_NMI },
> +         { }
> +    },
> +};
> +
> +static void microvm_machine_init(void)
> +{
> +    type_register_static(&microvm_machine_info);
> +}
> +type_init(microvm_machine_init);
> diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
> new file mode 100644
> index 0000000000..fd6f370997
> --- /dev/null
> +++ b/include/hw/i386/microvm.h
> @@ -0,0 +1,82 @@
> +/*
> + * Copyright (c) 2018 Intel Corporation
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_I386_MICROVM_H
> +#define HW_I386_MICROVM_H
> +
> +#include "qemu-common.h"
> +#include "exec/hwaddr.h"
> +#include "qemu/notify.h"
> +
> +#include "hw/boards.h"
> +
> +/* Microvm memory layout */
> +#define PVH_START_INFO        0x6000
> +#define MEMMAP_START          0x7000
> +#define MODLIST_START         0x7800
> +#define BOOT_STACK_POINTER    0x8ff0
> +#define PML4_START            0x9000
> +#define PDPTE_START           0xa000
> +#define PDE_START             0xb000
> +#define KERNEL_CMDLINE_START  0x20000
> +#define EBDA_START            0x9fc00
> +#define HIMEM_START           0x100000
> +#define MICROVM_MAX_BELOW_4G  0xe0000000
> +
> +/* Platform virtio definitions */
> +#define VIRTIO_MMIO_BASE      0xd0000000
> +#define VIRTIO_IRQ_BASE       5
> +#define VIRTIO_NUM_TRANSPORTS 8
> +#define VIRTIO_CMDLINE_MAXLEN 64
> +
> +/* Machine type options */
> +#define MICROVM_MACHINE_LEGACY "legacy"
> +
> +typedef struct {
> +    MachineClass parent;
> +    HotplugHandler *(*orig_hotplug_handler)(MachineState *machine,
> +                                           DeviceState *dev);
> +} MicrovmMachineClass;
> +
> +typedef struct {
> +    MachineState parent;
> +    qemu_irq *gsi;
> +
> +    /* RAM size */
> +    ram_addr_t below_4g_mem_size;
> +    ram_addr_t above_4g_mem_size;
> +
> +    /* Kernel ELF entry. On reset, vCPUs RIP will be set to this */
> +    uint64_t elf_entry;
> +
> +    /* Optional initrd start address and size */
> +    uint64_t initrd_addr;
> +    uint32_t initrd_size;
> +
> +    /* Legacy mode based on an ISA bus. Useful for debugging */
> +    bool legacy;
> +} MicrovmMachineState;
> +
> +#define TYPE_MICROVM_MACHINE   MACHINE_TYPE_NAME("microvm")
> +#define MICROVM_MACHINE(obj) \
> +    OBJECT_CHECK(MicrovmMachineState, (obj), TYPE_MICROVM_MACHINE)
> +#define MICROVM_MACHINE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(MicrovmMachineClass, obj, TYPE_MICROVM_MACHINE)
> +#define MICROVM_MACHINE_CLASS(class) \
> +    OBJECT_CLASS_CHECK(MicrovmMachineClass, class, TYPE_MICROVM_MACHINE)
> +
> +#endif
> 


