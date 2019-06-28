Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C7EC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 20:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8789E208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 20:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8789E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgxxl-000379-HS
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 16:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51597)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hgxvc-0002Zj-5P
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hgxvZ-0005aR-6j
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:57:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hgxvY-0005Wl-Q2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:57:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so7559051wrl.9
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 13:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=08pZTFPwPmuKlefCVKMalKqY1cT+F6ORbu44J12hwjs=;
 b=aPonPCV0dggNX0b4QkLDHTAGOEETqlucyhk2tMAPOWY6Qu1fR8mUcoiJ8+2xUdVfYo
 h4pCtUHp+f0crwKMVhagdZL8vvup+fhmy4SHaB0YtS7Qre57B0f6WrXSM8jcbt26Etvw
 9e66uUdG8r7c2y77QxT1k+DmfTCcq6wWIiD0vJ24HDNVpnMlnmhOuL+WSmSAIw9XEWJY
 wwlW1xFnE1QY+EL5cVop+6Ou4QrRs4/vF1qxcv2b/M1aqfGk4KFslY7kaCyPLeIKqiNu
 XUBxaNIq98/r1CKXVEImU80c9Qpvd+as+GafcQnVOa5MjXUr96DkPm7+KxtF945ClqNF
 XMaA==
X-Gm-Message-State: APjAAAVovtq21BDXD5dDaifX/S7TLd1Wtzhaqrf/1IYLn0+Mx2x7XB9E
 0iVWkRGWnJciLT9re/w/px0cwUrT2wc=
X-Google-Smtp-Source: APXvYqyoLVXR6fkiEOfwRg++GbFlDMlmuI0/n7OgcNSF34cpkAnh8EDmjSyTaC6QgNr+gYGnKF2JJA==
X-Received: by 2002:adf:b605:: with SMTP id f5mr9707986wre.305.1561755418401; 
 Fri, 28 Jun 2019 13:56:58 -0700 (PDT)
Received: from dritchie.redhat.com (73.red-88-25-212.staticip.rima-tde.net.
 [88.25.212.73])
 by smtp.gmail.com with ESMTPSA id c1sm6031522wrh.1.2019.06.28.13.56.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 13:56:57 -0700 (PDT)
References: <20190628115349.60293-1-slp@redhat.com>
 <20190628115349.60293-5-slp@redhat.com>
 <20190628100458-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
In-reply-to: <20190628100458-mutt-send-email-mst@kernel.org>
Date: Fri, 28 Jun 2019 22:56:55 +0200
Message-ID: <87pnmxwhrc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
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

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Michael S. Tsirkin <mst@redhat.com> writes:

> On Fri, Jun 28, 2019 at 01:53:49PM +0200, Sergio Lopez wrote:
>> Microvm is a machine type inspired by both NEMU and Firecracker, and
>> constructed after the machine model implemented by the latter.
>>=20
>> It's main purpose is providing users a KVM-only machine type with fast
>> boot times, minimal attack surface (measured as the number of IO ports
>> and MMIO regions exposed to the Guest) and small footprint (specially
>> when combined with the ongoing QEMU modularization effort).
>>=20
>> Normally, other than the device support provided by KVM itself,
>> microvm only supports virtio-mmio devices. Microvm also includes a
>> legacy mode, which adds an ISA bus with a 16550A serial port, useful
>> for being able to see the early boot kernel messages.
>>=20
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  default-configs/i386-softmmu.mak |   1 +
>>  hw/i386/Kconfig                  |   4 +
>>  hw/i386/Makefile.objs            |   1 +
>>  hw/i386/microvm.c                | 518 +++++++++++++++++++++++++++++++
>>  include/hw/i386/microvm.h        |  85 +++++
>>  5 files changed, 609 insertions(+)
>>  create mode 100644 hw/i386/microvm.c
>>  create mode 100644 include/hw/i386/microvm.h
>>=20
>> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-sof=
tmmu.mak
>> index cd5ea391e8..338f07420f 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -26,3 +26,4 @@ CONFIG_ISAPC=3Dy
>>  CONFIG_I440FX=3Dy
>>  CONFIG_Q35=3Dy
>>  CONFIG_ACPI_PCI=3Dy
>> +CONFIG_MICROVM=3Dy
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index 9817888216..94c565d8db 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -87,6 +87,10 @@ config Q35
>>      select VMMOUSE
>>      select FW_CFG_DMA
>>=20=20
>> +config MICROVM
>> +    bool
>> +    select VIRTIO_MMIO
>> +
>>  config VTD
>>      bool
>>=20=20
>> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
>> index 102f2b35fc..149bdd0784 100644
>> --- a/hw/i386/Makefile.objs
>> +++ b/hw/i386/Makefile.objs
>> @@ -4,6 +4,7 @@ obj-y +=3D cpu.o
>>  obj-y +=3D pc.o
>>  obj-$(CONFIG_I440FX) +=3D pc_piix.o
>>  obj-$(CONFIG_Q35) +=3D pc_q35.o
>> +obj-$(CONFIG_MICROVM) +=3D mptable.o microvm.o
>>  obj-y +=3D fw_cfg.o pc_sysfw.o
>>  obj-y +=3D x86-iommu.o
>>  obj-$(CONFIG_VTD) +=3D intel_iommu.o
>> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
>> new file mode 100644
>> index 0000000000..fff88c3697
>> --- /dev/null
>> +++ b/hw/i386/microvm.c
>> @@ -0,0 +1,518 @@
>> +/*
>> + *
>> + * Copyright (c) 2018 Intel Corporation
>> + * Copyright (c) 2019 Red Hat, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify=
 it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2 or later, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHO=
UT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licens=
e for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License al=
ong with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "qapi/error.h"
>> +#include "qapi/visitor.h"
>> +#include "sysemu/sysemu.h"
>> +#include "sysemu/cpus.h"
>> +#include "sysemu/numa.h"
>> +
>> +#include "hw/loader.h"
>> +#include "hw/nmi.h"
>> +#include "hw/kvm/clock.h"
>> +#include "hw/i386/microvm.h"
>> +#include "hw/i386/pc.h"
>> +#include "hw/i386/cpu-internal.h"
>> +#include "target/i386/cpu.h"
>> +#include "hw/timer/i8254.h"
>> +#include "hw/char/serial.h"
>> +#include "hw/i386/topology.h"
>> +#include "hw/virtio/virtio-mmio.h"
>> +#include "hw/i386/mptable.h"
>> +
>> +#include "cpu.h"
>> +#include "elf.h"
>> +#include "kvm_i386.h"
>> +#include <asm/bootparam.h>
>> +
>> +#define DEFINE_MICROVM_MACHINE_LATEST(major, minor, latest) \
>> +    static void microvm_##major##_##minor##_object_class_init(ObjectCla=
ss *oc, \
>> +                                                              void *dat=
a) \
>> +    { \
>> +        MachineClass *mc =3D MACHINE_CLASS(oc); \
>> +        microvm_##major##_##minor##_machine_class_init(mc); \
>> +        mc->desc =3D "Microvm (i386)"; \
>> +        if (latest) { \
>> +            mc->alias =3D "microvm"; \
>> +        } \
>> +    } \
>> +    static const TypeInfo microvm_##major##_##minor##_info =3D { \
>> +        .name =3D MACHINE_TYPE_NAME("microvm-" # major "." # minor), \
>> +        .parent =3D TYPE_MICROVM_MACHINE, \
>> +        .instance_init =3D microvm_##major##_##minor##_instance_init, \
>> +        .class_init =3D microvm_##major##_##minor##_object_class_init, \
>> +    }; \
>> +    static void microvm_##major##_##minor##_init(void) \
>> +    { \
>> +        type_register_static(&microvm_##major##_##minor##_info); \
>> +    } \
>> +    type_init(microvm_##major##_##minor##_init);
>> +
>> +#define DEFINE_MICROVM_MACHINE_AS_LATEST(major, minor) \
>> +    DEFINE_MICROVM_MACHINE_LATEST(major, minor, true)
>> +#define DEFINE_MICROVM_MACHINE(major, minor) \
>> +    DEFINE_MICROVM_MACHINE_LATEST(major, minor, false)
>> +
>> +static void microvm_gsi_handler(void *opaque, int n, int level)
>> +{
>> +    qemu_irq *ioapic_irq =3D opaque;
>> +
>> +    qemu_set_irq(ioapic_irq[n], level);
>> +}
>> +
>> +static void microvm_legacy_init(MicrovmMachineState *mms)
>> +{
>> +    ISABus *isa_bus;
>> +    GSIState *gsi_state;
>> +    qemu_irq *i8259;
>> +    int i;
>> +
>> +    assert(kvm_irqchip_in_kernel());
>> +    gsi_state =3D g_malloc0(sizeof(*gsi_state));
>> +    mms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM_PIN=
S);
>> +
>> +    isa_bus =3D isa_bus_new(NULL, get_system_memory(), get_system_io(),
>> +                          &error_abort);
>> +    isa_bus_irqs(isa_bus, mms->gsi);
>> +
>> +    assert(kvm_pic_in_kernel());
>> +    i8259 =3D kvm_i8259_init(isa_bus);
>> +
>> +    for (i =3D 0; i < ISA_NUM_IRQS; i++) {
>> +        gsi_state->i8259_irq[i] =3D i8259[i];
>> +    }
>> +
>> +    kvm_pit_init(isa_bus, 0x40);
>> +
>> +    for (i =3D 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
>> +        int nirq =3D VIRTIO_IRQ_BASE + i;
>> +        ISADevice *isadev =3D isa_create(isa_bus, TYPE_ISA_SERIAL);
>> +        qemu_irq mmio_irq;
>> +
>> +        isa_init_irq(isadev, &mmio_irq, nirq);
>> +        sysbus_create_simple("virtio-mmio",
>> +                             VIRTIO_MMIO_BASE + i * 512,
>> +                             mms->gsi[VIRTIO_IRQ_BASE + i]);
>> +    }
>> +
>> +    g_free(i8259);
>> +
>> +    serial_hds_isa_init(isa_bus, 0, 1);
>> +}
>> +
>> +static void microvm_ioapic_init(MicrovmMachineState *mms)
>> +{
>> +    qemu_irq *ioapic_irq;
>> +    DeviceState *ioapic_dev;
>> +    SysBusDevice *d;
>> +    int i;
>> +
>> +    assert(kvm_irqchip_in_kernel());
>
> Hmm - irqchip in kernel actually increases the attack surface,
> does it not? Or at least, the severity of the attacks.

I'd say the attack surface exposed to the Guest is roughly the same. As
for the severity of a hypothetical vulnerability, it depends a lot on
the context and the nature of the vulnerability itself, specially given
that QEMU is run as root and barely containerized in many scenarios.

Balancing the risks and costs, I'm more inclined to keep the irqchip in
kernel.

>> +    ioapic_irq =3D g_new0(qemu_irq, IOAPIC_NUM_PINS);
>> +    kvm_pc_setup_irq_routing(true);
>> +
>> +    assert(kvm_ioapic_in_kernel());
>> +    ioapic_dev =3D qdev_create(NULL, "kvm-ioapic");
>> +
>> +    object_property_add_child(qdev_get_machine(), "ioapic", OBJECT(ioap=
ic_dev), NULL);
>> +
>> +    qdev_init_nofail(ioapic_dev);
>> +    d =3D SYS_BUS_DEVICE(ioapic_dev);
>> +    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
>> +
>> +    for (i =3D 0; i < IOAPIC_NUM_PINS; i++) {
>> +        ioapic_irq[i] =3D qdev_get_gpio_in(ioapic_dev, i);
>> +    }
>> +
>> +    mms->gsi =3D qemu_allocate_irqs(microvm_gsi_handler, ioapic_irq, IO=
APIC_NUM_PINS);
>> +
>> +    for (i =3D 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
>> +        sysbus_create_simple("virtio-mmio",
>> +                             VIRTIO_MMIO_BASE + i * 512,
>> +                             mms->gsi[VIRTIO_IRQ_BASE + i]);
>> +    }
>> +}
>> +
>> +static void microvm_memory_init(MicrovmMachineState *mms)
>> +{
>> +    MachineState *machine =3D MACHINE(mms);
>> +    MemoryRegion *ram, *ram_below_4g, *ram_above_4g;
>> +    MemoryRegion *system_memory =3D get_system_memory();
>> +
>> +    if (machine->ram_size > MICROVM_MAX_BELOW_4G) {
>> +        mms->above_4g_mem_size =3D machine->ram_size - MICROVM_MAX_BELO=
W_4G;
>> +        mms->below_4g_mem_size =3D MICROVM_MAX_BELOW_4G;
>> +    } else {
>> +        mms->above_4g_mem_size =3D 0;
>> +        mms->below_4g_mem_size =3D machine->ram_size;
>> +    }
>> +
>> +    ram =3D g_malloc(sizeof(*ram));
>> +    memory_region_allocate_system_memory(ram, NULL, "microvm.ram",
>> +                                         machine->ram_size);
>> +
>> +    ram_below_4g =3D g_malloc(sizeof(*ram_below_4g));
>> +    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
>> +                             0, mms->below_4g_mem_size);
>> +    memory_region_add_subregion(system_memory, 0, ram_below_4g);
>> +
>> +    e820_add_entry(0, mms->below_4g_mem_size, E820_RAM);
>> +
>> +    if (mms->above_4g_mem_size > 0) {
>> +        ram_above_4g =3D g_malloc(sizeof(*ram_above_4g));
>> +        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ra=
m,
>> +                                 mms->below_4g_mem_size,
>> +                                 mms->above_4g_mem_size);
>> +        memory_region_add_subregion(system_memory, 0x100000000ULL,
>> +                                    ram_above_4g);
>> +        e820_add_entry(0x100000000ULL, mms->above_4g_mem_size, E820_RAM=
);
>> +    }
>> +}
>> +
>> +static void microvm_machine_state_init(MachineState *machine)
>> +{
>> +    MicrovmMachineState *mms =3D MICROVM_MACHINE(machine);
>> +    uint64_t elf_entry;
>> +    int kernel_size;
>> +
>> +    if (machine->kernel_filename =3D=3D NULL) {
>> +        error_report("missing kernel image file name, required by micro=
vm");
>> +        exit(1);
>> +    }
>> +
>> +    microvm_memory_init(mms);
>> +    if (mms->legacy) {
>> +        microvm_legacy_init(mms);
>> +    } else {
>> +        microvm_ioapic_init(mms);
>> +    }
>> +
>> +    mms->apic_id_limit =3D cpus_init(machine, false);
>> +
>> +    kvmclock_create();
>> +
>> +    kernel_size =3D load_elf(machine->kernel_filename, NULL,
>> +                           NULL, NULL, &elf_entry,
>> +                           NULL, NULL, 0, I386_ELF_MACHINE,
>> +                           0, 0);
>> +
>> +    if (kernel_size < 0) {
>> +        error_report("Error while loading elf kernel");
>> +        exit(1);
>> +    }
>> +
>> +    mms->elf_entry =3D elf_entry;
>> +}
>> +
>> +static gchar *microvm_get_virtio_mmio_cmdline(gchar *name)
>> +{
>> +    gchar *cmdline;
>> +    gchar *separator;
>> +    unsigned long index;
>> +    int ret;
>> +
>> +    separator =3D g_strrstr(name, ".");
>> +    if (!separator) {
>> +        return NULL;
>> +    }
>> +
>> +    index =3D strtol(separator + 1, NULL, 10);
>> +    if (index =3D=3D LONG_MIN || index =3D=3D LONG_MAX) {
>> +        return NULL;
>> +    }
>> +
>> +    cmdline =3D g_malloc0(VIRTIO_CMDLINE_MAXLEN);
>> +    ret =3D g_snprintf(cmdline, VIRTIO_CMDLINE_MAXLEN,
>> +                     " virtio_mmio.device=3D512@0x%lx:%ld",
>> +                     VIRTIO_MMIO_BASE + index * 512,
>> +                     VIRTIO_IRQ_BASE + index);
>> +    if (ret < 0 || ret >=3D VIRTIO_CMDLINE_MAXLEN) {
>> +        g_free(cmdline);
>> +        return NULL;
>> +    }
>> +
>> +    return cmdline;
>> +}
>> +
>> +static void microvm_setup_bootparams(MicrovmMachineState *mms, const gc=
har *kernel_cmdline)
>> +{
>> +    struct boot_params params;
>> +    BusState *bus;
>> +    BusChild *kid;
>> +    gchar *cmdline;
>> +    int cmdline_len;
>> +    int i;
>> +
>> +    cmdline =3D g_strdup(kernel_cmdline);
>> +
>> +    /*
>> +     * Find MMIO transports with attached devices, and add them to the =
kernel
>> +     * command line.
>> +     */
>> +    bus =3D sysbus_get_default();
>> +    QTAILQ_FOREACH(kid, &bus->children, sibling) {
>> +        DeviceState *dev =3D kid->child;
>> +        ObjectClass *class =3D object_get_class(OBJECT(dev));
>> +
>> +        if (class =3D=3D object_class_by_name(TYPE_VIRTIO_MMIO)) {
>> +            VirtIOMMIOProxy *mmio =3D VIRTIO_MMIO(OBJECT(dev));
>> +            VirtioBusState *mmio_virtio_bus =3D &mmio->bus;
>> +            BusState *mmio_bus =3D &mmio_virtio_bus->parent_obj;
>> +
>> +            if (!QTAILQ_EMPTY(&mmio_bus->children)) {
>> +                gchar *mmio_cmdline =3D microvm_get_virtio_mmio_cmdline=
(mmio_bus->name);
>> +                if (mmio_cmdline) {
>> +                    char *newcmd =3D g_strjoin(NULL, cmdline, mmio_cmdl=
ine, NULL);
>> +                    g_free(mmio_cmdline);
>> +                    g_free(cmdline);
>> +                    cmdline =3D newcmd;
>> +                }
>> +            }
>> +        }
>> +    }
>> +
>> +    cmdline_len =3D strlen(cmdline);
>> +
>> +    address_space_write(&address_space_memory,
>> +                        KERNEL_CMDLINE_START, MEMTXATTRS_UNSPECIFIED,
>> +                        (uint8_t *) cmdline, cmdline_len);
>> +
>> +    g_free(cmdline);
>> +
>> +    memset(&params, 0, sizeof(struct boot_params));
>> +
>> +    params.hdr.type_of_loader =3D KERNEL_LOADER_OTHER;
>> +    params.hdr.boot_flag =3D KERNEL_BOOT_FLAG_MAGIC;
>> +    params.hdr.header =3D KERNEL_HDR_MAGIC;
>> +    params.hdr.cmd_line_ptr =3D KERNEL_CMDLINE_START;
>> +    params.hdr.cmdline_size =3D cmdline_len;
>> +    params.hdr.kernel_alignment =3D KERNEL_MIN_ALIGNMENT_BYTES;
>> +
>> +    params.e820_entries =3D e820_get_num_entries();
>> +    for (i =3D 0; i < params.e820_entries; i++) {
>> +        uint64_t address, length;
>> +        if (e820_get_entry(i, E820_RAM, &address, &length)) {
>> +            params.e820_table[i].addr =3D address;
>> +            params.e820_table[i].size =3D length;
>> +            params.e820_table[i].type =3D E820_RAM;
>> +        }
>> +    }
>> +
>> +    address_space_write(&address_space_memory,
>> +                        ZERO_PAGE_START, MEMTXATTRS_UNSPECIFIED,
>> +                        (uint8_t *) &params, sizeof(struct boot_params)=
);
>> +}
>> +
>> +static void microvm_init_page_tables(void)
>> +{
>> +    uint64_t val =3D 0;
>> +    int i;
>> +
>> +    val =3D PDPTE_START | 0x03;
>> +    address_space_write(&address_space_memory,
>> +                        PML4_START, MEMTXATTRS_UNSPECIFIED,
>> +                        (uint8_t *) &val, 8);
>> +    val =3D PDE_START | 0x03;
>> +    address_space_write(&address_space_memory,
>> +                        PDPTE_START, MEMTXATTRS_UNSPECIFIED,
>> +                        (uint8_t *) &val, 8);
>> +
>> +    for (i =3D 0; i < 512; i++) {
>> +        val =3D (i << 21) + 0x83;
>> +        address_space_write(&address_space_memory,
>> +                            PDE_START + (i * 8), MEMTXATTRS_UNSPECIFIED,
>> +                            (uint8_t *) &val, 8);
>> +    }
>> +}
>> +
>> +static void microvm_cpu_reset(CPUState *cs, uint64_t elf_entry)
>> +{
>> +    X86CPU *cpu =3D X86_CPU(cs);
>> +    CPUX86State *env =3D &cpu->env;
>> +    struct SegmentCache seg_code =3D
>> +        { .selector =3D 0x8, .base =3D 0x0, .limit =3D 0xfffff, .flags =
=3D 0xa09b00 };
>> +    struct SegmentCache seg_data =3D
>> +        { .selector =3D 0x10, .base =3D 0x0, .limit =3D 0xfffff, .flags=
 =3D 0xc09300 };
>> +    struct SegmentCache seg_tr =3D
>> +        { .selector =3D 0x18, .base =3D 0x0, .limit =3D 0xfffff, .flags=
 =3D 0x808b00 };
>> +
>> +    kvm_arch_get_registers(cs);
>> +
>> +    memcpy(&env->segs[R_CS], &seg_code, sizeof(struct SegmentCache));
>> +    memcpy(&env->segs[R_DS], &seg_data, sizeof(struct SegmentCache));
>> +    memcpy(&env->segs[R_ES], &seg_data, sizeof(struct SegmentCache));
>> +    memcpy(&env->segs[R_FS], &seg_data, sizeof(struct SegmentCache));
>> +    memcpy(&env->segs[R_GS], &seg_data, sizeof(struct SegmentCache));
>> +    memcpy(&env->segs[R_SS], &seg_data, sizeof(struct SegmentCache));
>> +    memcpy(&env->tr, &seg_tr, sizeof(struct SegmentCache));
>> +
>> +    env->efer |=3D MSR_EFER_LME | MSR_EFER_LMA;
>> +    env->regs[R_ESP] =3D BOOT_STACK_POINTER;
>> +    env->regs[R_EBP] =3D BOOT_STACK_POINTER;
>> +    env->regs[R_ESI] =3D ZERO_PAGE_START;
>> +
>> +    cpu_set_pc(cs, elf_entry);
>> +    cpu_x86_update_cr3(env, PML4_START);
>> +    cpu_x86_update_cr4(env, env->cr[4] | CR4_PAE_MASK);
>> +    cpu_x86_update_cr0(env, env->cr[0] | CR0_PE_MASK | CR0_PG_MASK);
>> +    x86_update_hflags(env);
>> +
>> +    kvm_arch_put_registers(cs, KVM_PUT_RESET_STATE);
>> +}
>> +
>> +static void microvm_mptable_setup(MicrovmMachineState *mms)
>> +{
>> +    char *mptable;
>> +    int size;
>> +
>> +    mptable =3D mptable_generate(smp_cpus, mms->apic_id_limit,
>> +                               EBDA_START, &size);
>> +    address_space_write(&address_space_memory,
>> +                        EBDA_START, MEMTXATTRS_UNSPECIFIED,
>> +                        (uint8_t *) mptable, size);
>> +    g_free(mptable);
>> +}
>> +
>> +static bool microvm_machine_get_legacy(Object *obj, Error **errp)
>> +{
>> +    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
>> +
>> +    return mms->legacy;
>> +}
>> +
>> +static void microvm_machine_set_legacy(Object *obj, bool value, Error *=
*errp)
>> +{
>> +    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
>> +
>> +    mms->legacy =3D value;
>> +}
>> +
>> +static void microvm_machine_reset(void)
>> +{
>> +    MachineState *machine =3D MACHINE(qdev_get_machine());
>> +    MicrovmMachineState *mms =3D MICROVM_MACHINE(machine);
>> +    CPUState *cs;
>> +    X86CPU *cpu;
>> +
>> +    qemu_devices_reset();
>> +
>> +    microvm_mptable_setup(mms);
>> +    microvm_setup_bootparams(mms, machine->kernel_cmdline);
>> +    microvm_init_page_tables();
>> +
>> +    CPU_FOREACH(cs) {
>> +        cpu =3D X86_CPU(cs);
>> +
>> +        /* Reset APIC after devices have been reset to cancel
>> +         * any changes that qemu_devices_reset() might have done.
>> +         */
>> +        if (cpu->apic_state) {
>> +            device_reset(cpu->apic_state);
>> +        }
>> +
>> +        microvm_cpu_reset(cs, mms->elf_entry);
>> +    }
>> +}
>> +
>> +static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
>> +{
>> +    CPUState *cs;
>> +
>> +    CPU_FOREACH(cs) {
>> +        X86CPU *cpu =3D X86_CPU(cs);
>> +
>> +        if (!cpu->apic_state) {
>> +            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
>> +        } else {
>> +            apic_deliver_nmi(cpu->apic_state);
>> +        }
>> +    }
>> +}
>> +
>> +static void microvm_machine_instance_init(Object *obj)
>> +{
>> +}
>> +
>> +static void microvm_class_init(ObjectClass *oc, void *data)
>> +{
>> +    NMIClass *nc =3D NMI_CLASS(oc);
>> +
>> +    /* NMI handler */
>> +    nc->nmi_monitor_handler =3D x86_nmi;
>> +
>> +    object_class_property_add_bool(oc, MICROVM_MACHINE_LEGACY,
>> +                                   microvm_machine_get_legacy,
>> +                                   microvm_machine_set_legacy,
>> +                                   &error_abort);
>> +}
>> +
>> +static const TypeInfo microvm_machine_info =3D {
>> +    .name          =3D TYPE_MICROVM_MACHINE,
>> +    .parent        =3D TYPE_MACHINE,
>> +    .abstract      =3D true,
>> +    .instance_size =3D sizeof(MicrovmMachineState),
>> +    .instance_init =3D microvm_machine_instance_init,
>> +    .class_size    =3D sizeof(MicrovmMachineClass),
>> +    .class_init    =3D microvm_class_init,
>> +    .interfaces =3D (InterfaceInfo[]) {
>> +         { TYPE_NMI },
>> +         { }
>> +    },
>> +};
>> +
>> +static void microvm_machine_init(void)
>> +{
>> +    type_register_static(&microvm_machine_info);
>> +}
>> +type_init(microvm_machine_init);
>> +
>> +static void microvm_1_0_instance_init(Object *obj)
>> +{
>> +}
>> +
>> +static void microvm_machine_class_init(MachineClass *mc)
>> +{
>> +    mc->init =3D microvm_machine_state_init;
>> +
>> +    mc->family =3D "microvm_i386";
>> +    mc->desc =3D "Microvm (i386)";
>> +    mc->units_per_default_bus =3D 1;
>> +    mc->no_floppy =3D 1;
>> +    machine_class_allow_dynamic_sysbus_dev(mc, "sysbus-debugcon");
>> +    machine_class_allow_dynamic_sysbus_dev(mc, "sysbus-debugexit");
>> +    mc->max_cpus =3D 288;
>> +    mc->has_hotpluggable_cpus =3D false;
>> +    mc->auto_enable_numa_with_memhp =3D false;
>> +    mc->default_cpu_type =3D X86_CPU_TYPE_NAME ("host");
>> +    mc->nvdimm_supported =3D false;
>> +    mc->default_machine_opts =3D "accel=3Dkvm";
>> +
>> +    /* Machine class handlers */
>> +    mc->cpu_index_to_instance_props =3D cpu_index_to_props;
>> +    mc->get_default_cpu_node_id =3D cpu_get_default_cpu_node_id;
>> +    mc->possible_cpu_arch_ids =3D cpu_possible_cpu_arch_ids;;
>> +    mc->reset =3D microvm_machine_reset;
>> +}
>> +
>> +static void microvm_1_0_machine_class_init(MachineClass *mc)
>> +{
>> +    microvm_machine_class_init(mc);
>> +}
>> +DEFINE_MICROVM_MACHINE_AS_LATEST(1, 0)
>> diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
>> new file mode 100644
>> index 0000000000..544ef60563
>> --- /dev/null
>> +++ b/include/hw/i386/microvm.h
>> @@ -0,0 +1,85 @@
>> +/*
>> + *
>> + * Copyright (c) 2018 Intel Corporation
>> + * Copyright (c) 2019 Red Hat, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify=
 it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2 or later, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHO=
UT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licens=
e for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License al=
ong with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef HW_I386_MICROVM_H
>> +#define HW_I386_MICROVM_H
>> +
>> +#include "qemu-common.h"
>> +#include "exec/hwaddr.h"
>> +#include "qemu/notify.h"
>> +
>> +#include "hw/boards.h"
>> +
>> +/* Microvm memory layout */
>> +#define ZERO_PAGE_START      0x7000
>> +#define BOOT_STACK_POINTER   0x8ff0
>> +#define PML4_START           0x9000
>> +#define PDPTE_START          0xa000
>> +#define PDE_START            0xb000
>> +#define EBDA_START           0x9fc00
>> +#define HIMEM_START          0x100000
>> +#define MICROVM_MAX_BELOW_4G 0xe0000000
>> +
>> +/* Bootparams related definitions */
>> +#define KERNEL_BOOT_FLAG_MAGIC     0xaa55
>> +#define KERNEL_HDR_MAGIC           0x53726448
>> +#define KERNEL_LOADER_OTHER        0xff
>> +#define KERNEL_MIN_ALIGNMENT_BYTES 0x01000000
>> +#define KERNEL_CMDLINE_START       0x20000
>> +#define KERNEL_CMDLINE_MAX_SIZE    0x10000
>> +
>> +/* Platform virtio definitions */
>> +#define VIRTIO_MMIO_BASE      0xd0000000
>> +#define VIRTIO_IRQ_BASE       5
>> +#define VIRTIO_NUM_TRANSPORTS 8
>> +#define VIRTIO_CMDLINE_MAXLEN 64
>> +
>> +/* Machine type options */
>> +#define MICROVM_MACHINE_LEGACY "legacy"
>> +
>> +typedef struct {
>> +    MachineClass parent;
>> +    HotplugHandler *(*orig_hotplug_handler)(MachineState *machine,
>> +                                           DeviceState *dev);
>> +} MicrovmMachineClass;
>> +
>> +typedef struct {
>> +    MachineState parent;
>> +    unsigned apic_id_limit;
>> +    qemu_irq *gsi;
>> +
>> +    /* RAM size */
>> +    ram_addr_t below_4g_mem_size;
>> +    ram_addr_t above_4g_mem_size;
>> +
>> +    /* Kernel ELF entry. On reset, vCPUs RIP will be set to this */
>> +    uint64_t elf_entry;
>> +
>> +    /* Legacy mode based on an ISA bus. Useful for debugging */
>> +    bool legacy;
>> +} MicrovmMachineState;
>> +
>> +#define TYPE_MICROVM_MACHINE   MACHINE_TYPE_NAME("microvm")
>> +#define MICROVM_MACHINE(obj) \
>> +    OBJECT_CHECK(MicrovmMachineState, (obj), TYPE_MICROVM_MACHINE)
>> +#define MICROVM_MACHINE_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(MicrovmMachineClass, obj, TYPE_MICROVM_MACHINE)
>> +#define MICROVM_MACHINE_CLASS(class) \
>> +    OBJECT_CLASS_CHECK(MicrovmMachineClass, class, TYPE_MICROVM_MACHINE)
>> +
>> +#endif
>> --=20
>> 2.21.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0WfxcACgkQ9GknjS8M
AjXMOA//f+UswiZ0Y6HYzdUYI6Row9X/YNMdH3LXW2L70ZWoJim9XOOXcEpfCMbX
+EXA5YGwrrEofpOrRRg3H4285ab0rVq+SJGPBBXiLzBhvgS7iZNK/dUUvLDdS+ad
XVpNF7+gVke0Nf/j5zS/4jUbqIEz6BX7WZCsCnQ+a1Mv+N09ScEahx29P/GR1t/8
2kQNmdfNWEo4EKCGEX93otSK46GWclsAGRKF6kQlzEyHSrlP29E5TcxP4i1Dcjh5
sAjYAGifrI4R+ke8aL+mqSSyvxNWL3FE4Bv1rZ77Tb7BHAPooJwXfbTXcjsUcCT4
3GaseKso1xdNVFs0lYabnbKvxky5uzS8DUYlNfu7+Vg5Kw0o1vxXWQLeELDQBqTS
y/OJrlPJNKRKztqDBVrlfryfbh2/5cBd5t/tl9/iIs+EYPOtk8Mek2rYkIcjlEoW
XgmKNTE9op5gQh8udLuzEuGOuAyW/YtEDQhfY6MGlehstvuZA7CsOMq2RZUtNHnQ
LFnpqdK4zJ0DEnTn5/Afu7zs2Mx/zCXkX2l3Qn8YNjGzZN/N+Soq+3QPnypqwqwl
Nak/JPn28qFMcuUaj9az5/fJoRkQQqUwv/mxSBrDj2KGb82mvqnjjS6KBo11Msqw
HoTT8J86NvXIKtGYcITbY7VV8ALKOZRaqWakH/AIdlecfxgGaTo=
=dc8V
-----END PGP SIGNATURE-----
--=-=-=--

