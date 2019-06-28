Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D076C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3072F205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3072F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60647 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrpo-00036w-Bm
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36251)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hgrWo-0003MP-O0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hgrWk-00055N-Ol
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:07:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hgrWj-0004s9-2G
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:06:57 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so6383950qtl.5
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 07:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fTvz5Nj2r3Ff8R0RMRobrHcuo5QSR83dwzxJKJdqd3s=;
 b=hGyQkH+uBELusn3BrmyKnEeLBP5nrReVIlpZ94JdRKlB0EaZz3Sa6aTcc2ViGwwVA0
 fZUx4TQrVgzf2EmESYD8Z0KBvUeUKrQMZJkyYEP0moIDIuuQ6F04M+Og6xBOPfaSGb4X
 yC32K3bi1cJZS2ma70pxwSTU+BRXzR5I4sxG4ZRyaaPNOHBT9bo7xDA2irs1aArukTl5
 l6eanUOhHkRTpwtRg1C9k754uEWdYzk6R3Rv2TNhjKy3zRpLCmqQwtI19scxGh6jVpY+
 dd0u9Hj1LDrb7ClLsbSqPNpJpsYBcxPl9rOgW/nBqgXIroKOGfszKntElxFDVu3x8qFb
 mjGA==
X-Gm-Message-State: APjAAAWNf1euAPgm2WqGK0pCrAixUBm6lW6QANN5G4T6SPMe4nmgazHJ
 e50C+Bkxcn1wH8M21hx7Qee0xg==
X-Google-Smtp-Source: APXvYqzNsHx1d6gBtvQDiKHfHeX9OZPLybgluto1RjymTArbfop9pHckVHNYLs0CyBQvkQCt5iIbrA==
X-Received: by 2002:ac8:16ac:: with SMTP id r41mr8391066qtj.346.1561730802855; 
 Fri, 28 Jun 2019 07:06:42 -0700 (PDT)
Received: from redhat.com ([37.26.146.159])
 by smtp.gmail.com with ESMTPSA id t197sm1026671qke.2.2019.06.28.07.06.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 07:06:42 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:06:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190628100458-mutt-send-email-mst@kernel.org>
References: <20190628115349.60293-1-slp@redhat.com>
 <20190628115349.60293-5-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628115349.60293-5-slp@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/i386: Introduce the microvm machine
 type
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 28, 2019 at 01:53:49PM +0200, Sergio Lopez wrote:
> Microvm is a machine type inspired by both NEMU and Firecracker, and
> constructed after the machine model implemented by the latter.
> 
> It's main purpose is providing users a KVM-only machine type with fast
> boot times, minimal attack surface (measured as the number of IO ports
> and MMIO regions exposed to the Guest) and small footprint (specially
> when combined with the ongoing QEMU modularization effort).
> 
> Normally, other than the device support provided by KVM itself,
> microvm only supports virtio-mmio devices. Microvm also includes a
> legacy mode, which adds an ISA bus with a 16550A serial port, useful
> for being able to see the early boot kernel messages.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  default-configs/i386-softmmu.mak |   1 +
>  hw/i386/Kconfig                  |   4 +
>  hw/i386/Makefile.objs            |   1 +
>  hw/i386/microvm.c                | 518 +++++++++++++++++++++++++++++++
>  include/hw/i386/microvm.h        |  85 +++++
>  5 files changed, 609 insertions(+)
>  create mode 100644 hw/i386/microvm.c
>  create mode 100644 include/hw/i386/microvm.h
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index cd5ea391e8..338f07420f 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -26,3 +26,4 @@ CONFIG_ISAPC=y
>  CONFIG_I440FX=y
>  CONFIG_Q35=y
>  CONFIG_ACPI_PCI=y
> +CONFIG_MICROVM=y
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 9817888216..94c565d8db 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -87,6 +87,10 @@ config Q35
>      select VMMOUSE
>      select FW_CFG_DMA
>  
> +config MICROVM
> +    bool
> +    select VIRTIO_MMIO
> +
>  config VTD
>      bool
>  
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 102f2b35fc..149bdd0784 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -4,6 +4,7 @@ obj-y += cpu.o
>  obj-y += pc.o
>  obj-$(CONFIG_I440FX) += pc_piix.o
>  obj-$(CONFIG_Q35) += pc_q35.o
> +obj-$(CONFIG_MICROVM) += mptable.o microvm.o
>  obj-y += fw_cfg.o pc_sysfw.o
>  obj-y += x86-iommu.o
>  obj-$(CONFIG_VTD) += intel_iommu.o
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> new file mode 100644
> index 0000000000..fff88c3697
> --- /dev/null
> +++ b/hw/i386/microvm.c
> @@ -0,0 +1,518 @@
> +/*
> + *
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
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/cpus.h"
> +#include "sysemu/numa.h"
> +
> +#include "hw/loader.h"
> +#include "hw/nmi.h"
> +#include "hw/kvm/clock.h"
> +#include "hw/i386/microvm.h"
> +#include "hw/i386/pc.h"
> +#include "hw/i386/cpu-internal.h"
> +#include "target/i386/cpu.h"
> +#include "hw/timer/i8254.h"
> +#include "hw/char/serial.h"
> +#include "hw/i386/topology.h"
> +#include "hw/virtio/virtio-mmio.h"
> +#include "hw/i386/mptable.h"
> +
> +#include "cpu.h"
> +#include "elf.h"
> +#include "kvm_i386.h"
> +#include <asm/bootparam.h>
> +
> +#define DEFINE_MICROVM_MACHINE_LATEST(major, minor, latest) \
> +    static void microvm_##major##_##minor##_object_class_init(ObjectClass *oc, \
> +                                                              void *data) \
> +    { \
> +        MachineClass *mc = MACHINE_CLASS(oc); \
> +        microvm_##major##_##minor##_machine_class_init(mc); \
> +        mc->desc = "Microvm (i386)"; \
> +        if (latest) { \
> +            mc->alias = "microvm"; \
> +        } \
> +    } \
> +    static const TypeInfo microvm_##major##_##minor##_info = { \
> +        .name = MACHINE_TYPE_NAME("microvm-" # major "." # minor), \
> +        .parent = TYPE_MICROVM_MACHINE, \
> +        .instance_init = microvm_##major##_##minor##_instance_init, \
> +        .class_init = microvm_##major##_##minor##_object_class_init, \
> +    }; \
> +    static void microvm_##major##_##minor##_init(void) \
> +    { \
> +        type_register_static(&microvm_##major##_##minor##_info); \
> +    } \
> +    type_init(microvm_##major##_##minor##_init);
> +
> +#define DEFINE_MICROVM_MACHINE_AS_LATEST(major, minor) \
> +    DEFINE_MICROVM_MACHINE_LATEST(major, minor, true)
> +#define DEFINE_MICROVM_MACHINE(major, minor) \
> +    DEFINE_MICROVM_MACHINE_LATEST(major, minor, false)
> +
> +static void microvm_gsi_handler(void *opaque, int n, int level)
> +{
> +    qemu_irq *ioapic_irq = opaque;
> +
> +    qemu_set_irq(ioapic_irq[n], level);
> +}
> +
> +static void microvm_legacy_init(MicrovmMachineState *mms)
> +{
> +    ISABus *isa_bus;
> +    GSIState *gsi_state;
> +    qemu_irq *i8259;
> +    int i;
> +
> +    assert(kvm_irqchip_in_kernel());
> +    gsi_state = g_malloc0(sizeof(*gsi_state));
> +    mms->gsi = qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM_PINS);
> +
> +    isa_bus = isa_bus_new(NULL, get_system_memory(), get_system_io(),
> +                          &error_abort);
> +    isa_bus_irqs(isa_bus, mms->gsi);
> +
> +    assert(kvm_pic_in_kernel());
> +    i8259 = kvm_i8259_init(isa_bus);
> +
> +    for (i = 0; i < ISA_NUM_IRQS; i++) {
> +        gsi_state->i8259_irq[i] = i8259[i];
> +    }
> +
> +    kvm_pit_init(isa_bus, 0x40);
> +
> +    for (i = 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
> +        int nirq = VIRTIO_IRQ_BASE + i;
> +        ISADevice *isadev = isa_create(isa_bus, TYPE_ISA_SERIAL);
> +        qemu_irq mmio_irq;
> +
> +        isa_init_irq(isadev, &mmio_irq, nirq);
> +        sysbus_create_simple("virtio-mmio",
> +                             VIRTIO_MMIO_BASE + i * 512,
> +                             mms->gsi[VIRTIO_IRQ_BASE + i]);
> +    }
> +
> +    g_free(i8259);
> +
> +    serial_hds_isa_init(isa_bus, 0, 1);
> +}
> +
> +static void microvm_ioapic_init(MicrovmMachineState *mms)
> +{
> +    qemu_irq *ioapic_irq;
> +    DeviceState *ioapic_dev;
> +    SysBusDevice *d;
> +    int i;
> +
> +    assert(kvm_irqchip_in_kernel());

Hmm - irqchip in kernel actually increases the attack surface,
does it not? Or at least, the severity of the attacks.

> +    ioapic_irq = g_new0(qemu_irq, IOAPIC_NUM_PINS);
> +    kvm_pc_setup_irq_routing(true);
> +
> +    assert(kvm_ioapic_in_kernel());
> +    ioapic_dev = qdev_create(NULL, "kvm-ioapic");
> +
> +    object_property_add_child(qdev_get_machine(), "ioapic", OBJECT(ioapic_dev), NULL);
> +
> +    qdev_init_nofail(ioapic_dev);
> +    d = SYS_BUS_DEVICE(ioapic_dev);
> +    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
> +
> +    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
> +        ioapic_irq[i] = qdev_get_gpio_in(ioapic_dev, i);
> +    }
> +
> +    mms->gsi = qemu_allocate_irqs(microvm_gsi_handler, ioapic_irq, IOAPIC_NUM_PINS);
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
> +static void microvm_machine_state_init(MachineState *machine)
> +{
> +    MicrovmMachineState *mms = MICROVM_MACHINE(machine);
> +    uint64_t elf_entry;
> +    int kernel_size;
> +
> +    if (machine->kernel_filename == NULL) {
> +        error_report("missing kernel image file name, required by microvm");
> +        exit(1);
> +    }
> +
> +    microvm_memory_init(mms);
> +    if (mms->legacy) {
> +        microvm_legacy_init(mms);
> +    } else {
> +        microvm_ioapic_init(mms);
> +    }
> +
> +    mms->apic_id_limit = cpus_init(machine, false);
> +
> +    kvmclock_create();
> +
> +    kernel_size = load_elf(machine->kernel_filename, NULL,
> +                           NULL, NULL, &elf_entry,
> +                           NULL, NULL, 0, I386_ELF_MACHINE,
> +                           0, 0);
> +
> +    if (kernel_size < 0) {
> +        error_report("Error while loading elf kernel");
> +        exit(1);
> +    }
> +
> +    mms->elf_entry = elf_entry;
> +}
> +
> +static gchar *microvm_get_virtio_mmio_cmdline(gchar *name)
> +{
> +    gchar *cmdline;
> +    gchar *separator;
> +    unsigned long index;
> +    int ret;
> +
> +    separator = g_strrstr(name, ".");
> +    if (!separator) {
> +        return NULL;
> +    }
> +
> +    index = strtol(separator + 1, NULL, 10);
> +    if (index == LONG_MIN || index == LONG_MAX) {
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
> +static void microvm_setup_bootparams(MicrovmMachineState *mms, const gchar *kernel_cmdline)
> +{
> +    struct boot_params params;
> +    BusState *bus;
> +    BusChild *kid;
> +    gchar *cmdline;
> +    int cmdline_len;
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
> +                gchar *mmio_cmdline = microvm_get_virtio_mmio_cmdline(mmio_bus->name);
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
> +    memset(&params, 0, sizeof(struct boot_params));
> +
> +    params.hdr.type_of_loader = KERNEL_LOADER_OTHER;
> +    params.hdr.boot_flag = KERNEL_BOOT_FLAG_MAGIC;
> +    params.hdr.header = KERNEL_HDR_MAGIC;
> +    params.hdr.cmd_line_ptr = KERNEL_CMDLINE_START;
> +    params.hdr.cmdline_size = cmdline_len;
> +    params.hdr.kernel_alignment = KERNEL_MIN_ALIGNMENT_BYTES;
> +
> +    params.e820_entries = e820_get_num_entries();
> +    for (i = 0; i < params.e820_entries; i++) {
> +        uint64_t address, length;
> +        if (e820_get_entry(i, E820_RAM, &address, &length)) {
> +            params.e820_table[i].addr = address;
> +            params.e820_table[i].size = length;
> +            params.e820_table[i].type = E820_RAM;
> +        }
> +    }
> +
> +    address_space_write(&address_space_memory,
> +                        ZERO_PAGE_START, MEMTXATTRS_UNSPECIFIED,
> +                        (uint8_t *) &params, sizeof(struct boot_params));
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
> +    struct SegmentCache seg_code =
> +        { .selector = 0x8, .base = 0x0, .limit = 0xfffff, .flags = 0xa09b00 };
> +    struct SegmentCache seg_data =
> +        { .selector = 0x10, .base = 0x0, .limit = 0xfffff, .flags = 0xc09300 };
> +    struct SegmentCache seg_tr =
> +        { .selector = 0x18, .base = 0x0, .limit = 0xfffff, .flags = 0x808b00 };
> +
> +    kvm_arch_get_registers(cs);
> +
> +    memcpy(&env->segs[R_CS], &seg_code, sizeof(struct SegmentCache));
> +    memcpy(&env->segs[R_DS], &seg_data, sizeof(struct SegmentCache));
> +    memcpy(&env->segs[R_ES], &seg_data, sizeof(struct SegmentCache));
> +    memcpy(&env->segs[R_FS], &seg_data, sizeof(struct SegmentCache));
> +    memcpy(&env->segs[R_GS], &seg_data, sizeof(struct SegmentCache));
> +    memcpy(&env->segs[R_SS], &seg_data, sizeof(struct SegmentCache));
> +    memcpy(&env->tr, &seg_tr, sizeof(struct SegmentCache));
> +
> +    env->efer |= MSR_EFER_LME | MSR_EFER_LMA;
> +    env->regs[R_ESP] = BOOT_STACK_POINTER;
> +    env->regs[R_EBP] = BOOT_STACK_POINTER;
> +    env->regs[R_ESI] = ZERO_PAGE_START;
> +
> +    cpu_set_pc(cs, elf_entry);
> +    cpu_x86_update_cr3(env, PML4_START);
> +    cpu_x86_update_cr4(env, env->cr[4] | CR4_PAE_MASK);
> +    cpu_x86_update_cr0(env, env->cr[0] | CR0_PE_MASK | CR0_PG_MASK);
> +    x86_update_hflags(env);
> +
> +    kvm_arch_put_registers(cs, KVM_PUT_RESET_STATE);
> +}
> +
> +static void microvm_mptable_setup(MicrovmMachineState *mms)
> +{
> +    char *mptable;
> +    int size;
> +
> +    mptable = mptable_generate(smp_cpus, mms->apic_id_limit,
> +                               EBDA_START, &size);
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
> +    microvm_setup_bootparams(mms, machine->kernel_cmdline);
> +    microvm_init_page_tables();
> +
> +    CPU_FOREACH(cs) {
> +        cpu = X86_CPU(cs);
> +
> +        /* Reset APIC after devices have been reset to cancel
> +         * any changes that qemu_devices_reset() might have done.
> +         */
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
> +static void microvm_machine_instance_init(Object *obj)
> +{
> +}
> +
> +static void microvm_class_init(ObjectClass *oc, void *data)
> +{
> +    NMIClass *nc = NMI_CLASS(oc);
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
> +    .abstract      = true,
> +    .instance_size = sizeof(MicrovmMachineState),
> +    .instance_init = microvm_machine_instance_init,
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
> +
> +static void microvm_1_0_instance_init(Object *obj)
> +{
> +}
> +
> +static void microvm_machine_class_init(MachineClass *mc)
> +{
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
> +    mc->default_cpu_type = X86_CPU_TYPE_NAME ("host");
> +    mc->nvdimm_supported = false;
> +    mc->default_machine_opts = "accel=kvm";
> +
> +    /* Machine class handlers */
> +    mc->cpu_index_to_instance_props = cpu_index_to_props;
> +    mc->get_default_cpu_node_id = cpu_get_default_cpu_node_id;
> +    mc->possible_cpu_arch_ids = cpu_possible_cpu_arch_ids;;
> +    mc->reset = microvm_machine_reset;
> +}
> +
> +static void microvm_1_0_machine_class_init(MachineClass *mc)
> +{
> +    microvm_machine_class_init(mc);
> +}
> +DEFINE_MICROVM_MACHINE_AS_LATEST(1, 0)
> diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
> new file mode 100644
> index 0000000000..544ef60563
> --- /dev/null
> +++ b/include/hw/i386/microvm.h
> @@ -0,0 +1,85 @@
> +/*
> + *
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
> +#define ZERO_PAGE_START      0x7000
> +#define BOOT_STACK_POINTER   0x8ff0
> +#define PML4_START           0x9000
> +#define PDPTE_START          0xa000
> +#define PDE_START            0xb000
> +#define EBDA_START           0x9fc00
> +#define HIMEM_START          0x100000
> +#define MICROVM_MAX_BELOW_4G 0xe0000000
> +
> +/* Bootparams related definitions */
> +#define KERNEL_BOOT_FLAG_MAGIC     0xaa55
> +#define KERNEL_HDR_MAGIC           0x53726448
> +#define KERNEL_LOADER_OTHER        0xff
> +#define KERNEL_MIN_ALIGNMENT_BYTES 0x01000000
> +#define KERNEL_CMDLINE_START       0x20000
> +#define KERNEL_CMDLINE_MAX_SIZE    0x10000
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
> +    unsigned apic_id_limit;
> +    qemu_irq *gsi;
> +
> +    /* RAM size */
> +    ram_addr_t below_4g_mem_size;
> +    ram_addr_t above_4g_mem_size;
> +
> +    /* Kernel ELF entry. On reset, vCPUs RIP will be set to this */
> +    uint64_t elf_entry;
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
> -- 
> 2.21.0

