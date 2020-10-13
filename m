Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931BDC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887502538B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRQNaIa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887502538B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSOYP-0004Q3-6a
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 13:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSOXM-0003pr-OW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:56:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSOXK-0005TA-C4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:56:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id i1so398507wro.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+R89IXXO2Yx47Qg//vzsKX26x0ALHaiyQPT0H4H1ho8=;
 b=lRQNaIa6+TyksNm56gqW1wQrMZ6vhT45/sEaNQJoOjU8YiGIp8M0gxhzO5JCCEXjQ0
 Nfj6SckrIjYCjFwxIO3LQa8SwUY125CnCo+hkVmegujvqifMcDuGMRo0YzTC0umGRvOz
 yuQ7FzAbmb1jy/dySob+IzcBG8n6BGlsxPIolnFQidckc+P+/cakuZXMrSxMhgICoSeT
 5/onKrqKanzDlsnZ/Oxyx7QPPDLmZm8hEkB8scM/kbKtko7QkfwasTBvqG5wqaQGwl6a
 lWFY77cxzxo4XuDxumaiSy/z5XUIN5njTNZv6HrCxQF8YieEcpcakJyl6lldTTVCP7td
 SutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+R89IXXO2Yx47Qg//vzsKX26x0ALHaiyQPT0H4H1ho8=;
 b=f/J4fscC8USWhV0lgG723mdCrCET54K5CMgX/T95Tfr2VKdsITQIZuo96iz/8+lpI4
 E9rXOgmZMRxfcMh238+QSCVruauS8cvCnPVfjfOnMwDffWxhrGqiXc0ImGFgWfNO2a8y
 W3tU3Js1ABGKyesbD/Hek+t/I18TXH3KJXBbh5aHCmWfcypxmVyIo8V8byv3qzo4jyLy
 McAe6GHyaswpMBI7Oppfr66xiXMjk0nQTs5sVaz0ca+fk6aa6pAjfW8rRP58ScJsqlef
 de0hVvQLBJYtHuD/3J/t5MBvx1Q98k3j3j8gVTSV61Z0/fRk4/0hV3t6619Zi3lA1YMS
 PrAw==
X-Gm-Message-State: AOAM530lWtOkx59GsO3dRe4hvNYo11SRKNks4lB49Y38vhVNJHLsfk2u
 XNeNxWbX6l6vPxMZlilK2DnihhEQU6c=
X-Google-Smtp-Source: ABdhPJz/JdPzNJG7xV6agKLwiQ/5R3Bqe0RocfX0tb+9lT8HH62en87KuuabLOnmB6IHYIfzTU0qDA==
X-Received: by 2002:a5d:6cae:: with SMTP id a14mr954807wra.187.1602611791977; 
 Tue, 13 Oct 2020 10:56:31 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l5sm431731wrq.14.2020.10.13.10.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 10:56:31 -0700 (PDT)
Subject: Re: [PATCH 4/4] m68k: add Virtual M68k Machine
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20201013155124.451774-1-laurent@vivier.eu>
 <20201013155124.451774-5-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2bfc12f5-0fd8-afb9-7b16-1a3d5ac51a06@amsat.org>
Date: Tue, 13 Oct 2020 19:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013155124.451774-5-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 5:51 PM, Laurent Vivier wrote:
> The machine is based on Goldfish interfaces defined by Google
> for Android simulator. It uses Goldfish-rtc (timer and RTC),
> Goldfish-pic (PIC) and Goldfish-tty (for serial port and early tty).
> 
> The machine is created with 128 virtio-mmio bus, and they can
> be used to use serial console, GPU, disk, NIC, HID, ...
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   default-configs/devices/m68k-softmmu.mak      |   1 +
>   .../standard-headers/asm-m68k/bootinfo-virt.h |  17 +
>   hw/m68k/virt.c                                | 296 ++++++++++++++++++
>   MAINTAINERS                                   |   9 +
>   hw/m68k/Kconfig                               |   8 +
>   hw/m68k/meson.build                           |   1 +
>   6 files changed, 332 insertions(+)
>   create mode 100644 include/standard-headers/asm-m68k/bootinfo-virt.h
>   create mode 100644 hw/m68k/virt.c
> 
> diff --git a/default-configs/devices/m68k-softmmu.mak b/default-configs/devices/m68k-softmmu.mak
> index 6629fd2aa330..7f8619e42786 100644
> --- a/default-configs/devices/m68k-softmmu.mak
> +++ b/default-configs/devices/m68k-softmmu.mak
> @@ -8,3 +8,4 @@ CONFIG_AN5206=y
>   CONFIG_MCF5208=y
>   CONFIG_NEXTCUBE=y
>   CONFIG_Q800=y
> +CONFIG_M68K_VIRT=y
> diff --git a/include/standard-headers/asm-m68k/bootinfo-virt.h b/include/standard-headers/asm-m68k/bootinfo-virt.h
> new file mode 100644
> index 000000000000..b3d90a601513
> --- /dev/null
> +++ b/include/standard-headers/asm-m68k/bootinfo-virt.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> +** asm/bootinfo-virt.h -- Virtual-m68k-specific boot information definitions
> +*/
> +
> +#ifndef _UAPI_ASM_M68K_BOOTINFO_VIRT_H
> +#define _UAPI_ASM_M68K_BOOTINFO_VIRT_H
> +
> +#define BI_VIRT_QEMU_VERSION	0x8000
> +#define BI_VIRT_GF_PIC_BASE	0x8001
> +#define BI_VIRT_GF_RTC_BASE	0x8002
> +#define BI_VIRT_GF_TTY_BASE	0x8003
> +#define BI_VIRT_VIRTIO_BASE	0x8004
> +
> +#define VIRT_BOOTI_VERSION	MK_BI_VERSION(2, 0)
> +
> +#endif /* _UAPI_ASM_M68K_BOOTINFO_MAC_H */
> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
> new file mode 100644
> index 000000000000..8b89373dafdb
> --- /dev/null
> +++ b/hw/m68k/virt.c
> @@ -0,0 +1,296 @@
> +/*
> + * SPDX-License-Identifer: GPL-2.0-or-later
> + *
> + * QEMU Vitual M68K Machine
> + *
> + * (c) 2020 Laurent Vivier <laurent@vivier.eu>
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu-common.h"
> +#include "sysemu/sysemu.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "hw/boards.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "elf.h"
> +#include "hw/loader.h"
> +#include "ui/console.h"
> +#include "exec/address-spaces.h"
> +#include "hw/sysbus.h"
> +#include "standard-headers/asm-m68k/bootinfo.h"
> +#include "standard-headers/asm-m68k/bootinfo-virt.h"
> +#include "bootinfo.h"
> +#include "net/net.h"
> +#include "qapi/error.h"
> +#include "sysemu/qtest.h"
> +#include "sysemu/runstate.h"
> +#include "sysemu/reset.h"
> +
> +#include "hw/char/goldfish_tty.h"
> +#include "hw/rtc/goldfish_rtc.h"
> +#include "hw/intc/goldfish_pic.h"
> +#include "hw/virtio/virtio-mmio.h"
> +#include "hw/virtio/virtio-blk.h"
> +
> +/*
> + * 6 goldfish-pic for CPU IRQ #1 to IRQ #6
> + * CPU IRQ #1 -> PIC #1
> + *               IRQ #1 to IRQ #31 -> unused
> + *               IRQ #32 -> goldfish-tty
> + * CPU IRQ #2 -> PIC #2
> + *               IRQ #1 to IRQ #32 -> virtio-mmio from 1 to 32
> + * CPU IRQ #3 -> PIC #3
> + *               IRQ #1 to IRQ #32 -> virtio-mmio from 33 to 64
> + * CPU IRQ #4 -> PIC #4
> + *               IRQ #1 to IRQ #32 -> virtio-mmio from 65 to 96
> + * CPU IRQ #5 -> PIC #5
> + *               IRQ #1 to IRQ #32 -> virtio-mmio from 97 to 128
> + * CPU IRQ #6 -> PIC #5
> + *               IRQ #1 -> goldfish-rtc
> + *               IRQ #2 to IRQ #32 -> unused
> + * CPU IRQ #7 -> NMI
> + */
> +
> +#define PIC_IRQ_BASE(num)     (8 + (num - 1) * 32)
> +#define PIC_IRQ(num, irq)     (PIC_IRQ_BASE(num) + irq - 1)
> +#define PIC_GPIO(pic_irq)     (qdev_get_gpio_in(pic_dev[(pic_irq - 8) / 32], \
> +                                                (pic_irq - 8) % 32))
> +
> +#define VIRT_GF_PIC_MMIO_BASE 0xff000000     /* MMIO: 0xff000000 - 0xff005fff */
> +#define VIRT_GF_PIC_IRQ_BASE  1              /* IRQ: #1 -> #6 */
> +
> +/* 1 goldfish-rtc (and timer) */
> +#define VIRT_GF_RTC_MMIO_BASE 0xff006000     /* MMIO: 0xff006000 - 0xff006fff */
> +#define VIRT_GF_RTC_IRQ_BASE  PIC_IRQ(6, 1)  /* PIC: #6, IRQ: #1 */
> +
> +/* 1 goldfish-tty */
> +#define VIRT_GF_TTY_MMIO_BASE 0xff007000     /* MMIO: 0xff007000 - 0xff007000 */
> +#define VIRT_GF_TTY_IRQ_BASE  PIC_IRQ(1, 32) /* PIC: #1, IRQ: #32 */
> +/*
> + * virtio-mmio size is 0x200 bytes
> + * we use 4 goldfish-pic to attach them,
> + * we can attach 32 virtio devices / goldfish-pic
> + * -> we can manage 32 * 4 = 128 virtio devices
> + */
> +#define VIRT_VIRTIO_MMIO_BASE 0xff010000     /* MMIO: 0xff010000 - 0xff01ffff */
> +#define VIRT_VIRTIO_IRQ_BASE  PIC_IRQ(2, 1)  /* PIC: 2, 3, 4, 5, IRQ: ALL */
> +
> +/*
> + * The GLUE (General Logic Unit) is an Apple custom integrated circuit chip
> + * that performs a variety of functions (RAM management, clock generation, ...).
> + * The GLUE chip receives interrupt requests from various devices,
> + * assign priority to each, and asserts one or more interrupt line to the
> + * CPU.

Does your virt machine really requires a GLUE? Or only another
cascaded PIC?

> + */
> +
> +typedef struct {
> +    M68kCPU *cpu;
> +    uint8_t ipr;
> +} GLUEState;
> +
> +static void GLUE_set_irq(void *opaque, int irq, int level)
> +{
> +    GLUEState *s = opaque;
> +    int i;
> +
> +    if (level) {
> +        s->ipr |= 1 << irq;
> +    } else {
> +        s->ipr &= ~(1 << irq);
> +    }
> +
> +    for (i = 7; i >= 0; i--) {
> +        if ((s->ipr >> i) & 1) {
> +            m68k_set_irq_level(s->cpu, i + 1, i + 25);
> +            return;
> +        }
> +    }
> +    m68k_set_irq_level(s->cpu, 0, 0);
> +}
> +
> +static void main_cpu_reset(void *opaque)
> +{
> +    M68kCPU *cpu = opaque;
> +    CPUState *cs = CPU(cpu);
> +
> +    cpu_reset(cs);
> +    cpu->env.aregs[7] = ldl_phys(cs->as, 0);
> +    cpu->env.pc = ldl_phys(cs->as, 4);
> +}
> +
> +static void virt_init(MachineState *machine)
> +{
> +    M68kCPU *cpu = NULL;
> +    int32_t kernel_size;
> +    uint64_t elf_entry;
> +    ram_addr_t initrd_base;
> +    int32_t initrd_size;
> +    ram_addr_t ram_size = machine->ram_size;
> +    const char *kernel_filename = machine->kernel_filename;
> +    const char *initrd_filename = machine->initrd_filename;
> +    const char *kernel_cmdline = machine->kernel_cmdline;
> +    hwaddr parameters_base;
> +    DeviceState *dev;
> +    DeviceState *pic_dev[7];
> +    GLUEState *irq;
> +    qemu_irq *cpu_pic;
> +    SysBusDevice *sysbus;
> +    hwaddr io_base;
> +    int i;
> +
> +
> +    if (ram_size > 3399672 * KiB) {
> +        /*
> +         * The physical memory can be up to 4 GiB - 16 MiB, but linux
> +         * kernel crashes after this limit (~ 3.2 GiB)
> +         */
> +        error_report("Too much memory for this machine: %" PRId64 " KiB, "
> +                     "maximum 3399672 KiB", ram_size / KiB);
> +        exit(1);
> +    }
> +
> +    /* init CPUs */
> +    cpu = M68K_CPU(cpu_create(machine->cpu_type));

Due to BOOTINFO1(..., BI_CPUTYPE, CPU_68040) below, don't you
need to check machine->cpu_type == M68K_CPU_TYPE_NAME("m68040")?

> +    qemu_register_reset(main_cpu_reset, cpu);
> +
> +    /* RAM */
> +    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> +
> +    /* IRQ Glue */
> +
> +    irq = g_new0(GLUEState, 1);
> +    irq->cpu = cpu;
> +    cpu_pic = qemu_allocate_irqs(GLUE_set_irq, irq, 8);
> +
> +    /*
> +     * 6 goldfish-pic
> +     *
> +     * map: 0xff000000 - 0xff006fff = 28 KiB
> +     * IRQ: #1 (lower priority) -> #6 (higher priority)
> +     *
> +     */
> +    io_base = VIRT_GF_PIC_MMIO_BASE;
> +    for (i = 0; i < 6; i++) {
> +        pic_dev[i] = qdev_new(TYPE_GOLDFISH_PIC);
> +        sysbus = SYS_BUS_DEVICE(pic_dev[i]);
> +        sysbus_realize_and_unref(sysbus, &error_fatal);
> +
> +        sysbus_mmio_map(sysbus, 0, io_base);
> +        sysbus_connect_irq(sysbus, 0, cpu_pic[i]);
> +
> +        io_base += 0x1000;
> +    }
> +
> +    /* goldfish-rtc */
> +    dev = qdev_new(TYPE_GOLDFISH_RTC);
> +    sysbus = SYS_BUS_DEVICE(dev);
> +    sysbus_realize_and_unref(sysbus, &error_fatal);
> +    sysbus_mmio_map(sysbus, 0, VIRT_GF_RTC_MMIO_BASE);
> +    sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_GF_RTC_IRQ_BASE));
> +
> +    /* goldfish-tty */
> +    dev = qdev_new(TYPE_GOLDFISH_TTY);
> +    sysbus = SYS_BUS_DEVICE(dev);
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +    sysbus_realize_and_unref(sysbus, &error_fatal);
> +    sysbus_mmio_map(sysbus, 0, VIRT_GF_TTY_MMIO_BASE);
> +    sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_GF_TTY_IRQ_BASE));
> +
> +    /* virtio-mmio */
> +    io_base = VIRT_VIRTIO_MMIO_BASE;
> +    for (i = 0; i < 128; i++) {
> +        dev = qdev_new(TYPE_VIRTIO_MMIO);
> +        qdev_prop_set_bit(dev, "force-legacy", false);
> +        sysbus = SYS_BUS_DEVICE(dev);
> +        sysbus_realize_and_unref(sysbus, &error_fatal);
> +        sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_VIRTIO_IRQ_BASE + i));
> +        sysbus_mmio_map(sysbus, 0, io_base);
> +        io_base += 0x200;
> +    }
> +
> +    if (kernel_filename) {
> +        CPUState *cs = CPU(cpu);
> +        uint64_t high;
> +
> +        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
> +                               &elf_entry, NULL, &high, NULL, 1,
> +                               EM_68K, 0, 0);
> +        if (kernel_size < 0) {
> +            error_report("could not load kernel '%s'", kernel_filename);
> +            exit(1);
> +        }
> +        stl_phys(cs->as, 4, elf_entry); /* reset initial PC */
> +        parameters_base = (high + 1) & ~1;
> +
> +        BOOTINFO1(cs->as, parameters_base, BI_MACHTYPE, MACH_VIRT);
> +        BOOTINFO1(cs->as, parameters_base, BI_FPUTYPE, FPU_68040);
> +        BOOTINFO1(cs->as, parameters_base, BI_MMUTYPE, MMU_68040);
> +        BOOTINFO1(cs->as, parameters_base, BI_CPUTYPE, CPU_68040);

(see machine->cpu_type question earlier).

> +        BOOTINFO2(cs->as, parameters_base, BI_MEMCHUNK, 0, ram_size);
> +
> +        BOOTINFO1(cs->as, parameters_base, BI_VIRT_QEMU_VERSION,
> +                  ((QEMU_VERSION_MAJOR << 24) | (QEMU_VERSION_MICRO << 16) |
> +                   (QEMU_VERSION_MINOR << 8)));
> +        BOOTINFO2(cs->as, parameters_base, BI_VIRT_GF_PIC_BASE,
> +                  VIRT_GF_PIC_MMIO_BASE, VIRT_GF_PIC_IRQ_BASE);
> +        BOOTINFO2(cs->as, parameters_base, BI_VIRT_GF_RTC_BASE,
> +                  VIRT_GF_RTC_MMIO_BASE, VIRT_GF_RTC_IRQ_BASE);
> +        BOOTINFO2(cs->as, parameters_base, BI_VIRT_GF_TTY_BASE,
> +                  VIRT_GF_TTY_MMIO_BASE, VIRT_GF_TTY_IRQ_BASE);
> +        BOOTINFO2(cs->as, parameters_base, BI_VIRT_VIRTIO_BASE,
> +                  VIRT_VIRTIO_MMIO_BASE, VIRT_VIRTIO_IRQ_BASE);
> +
> +        if (kernel_cmdline) {
> +            BOOTINFOSTR(cs->as, parameters_base, BI_COMMAND_LINE,
> +                        kernel_cmdline);
> +        }
> +
> +        /* load initrd */
> +        if (initrd_filename) {
> +            initrd_size = get_image_size(initrd_filename);
> +            if (initrd_size < 0) {
> +                error_report("could not load initial ram disk '%s'",
> +                             initrd_filename);
> +                exit(1);
> +            }
> +
> +            initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
> +            load_image_targphys(initrd_filename, initrd_base,
> +                                ram_size - initrd_base);
> +            BOOTINFO2(cs->as, parameters_base, BI_RAMDISK, initrd_base,
> +                      initrd_size);
> +        } else {
> +            initrd_base = 0;
> +            initrd_size = 0;
> +        }
> +        BOOTINFO0(cs->as, parameters_base, BI_LAST);
> +    }
> +}
> +
> +static void virt_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    mc->desc = "M68k Virtual Machine";
> +    mc->init = virt_init;
> +    mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
> +    mc->max_cpus = 1;
> +    mc->block_default_type = IF_SCSI;
> +    mc->default_ram_id = "m68k_virt.ram";
> +}
> +
> +static const TypeInfo virt_machine_typeinfo = {
> +    .name       = MACHINE_TYPE_NAME("virt"),
> +    .parent     = TYPE_MACHINE,
> +    .class_init = virt_machine_class_init,
> +};
> +
> +static void virt_machine_register_types(void)
> +{
> +    type_register_static(&virt_machine_typeinfo);
> +}
> +
> +type_init(virt_machine_register_types)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d0962a22e1b4..b08cf4251246 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1101,6 +1101,15 @@ F: include/hw/nubus/*
>   F: include/hw/display/macfb.h
>   F: include/hw/block/swim.h
>   
> +virt

Maybe "m68k virt".

> +M: Laurent Vivier <laurent@vivier.eu>
> +S: Maintained
> +F: hw/m68k/virt.c
> +F: hw/char/goldfish_tty.c
> +F: hw/intc/goldfish_pic.c
> +F: include/hw/char/goldfish_tty.h
> +F: include/hw/intc/goldfish_pic.h
> +
>   MicroBlaze Machines
>   -------------------
>   petalogix_s3adsp1800
> diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
> index c757e7dfa48b..f4b3b115270e 100644
> --- a/hw/m68k/Kconfig
> +++ b/hw/m68k/Kconfig
> @@ -22,3 +22,11 @@ config Q800
>       select ESCC
>       select ESP
>       select DP8393X
> +
> +config M68K_VIRT
> +    bool
> +    select GOLDFISH_PIC
> +    select GOLDFISH_TTY
> +    select GOLDFISH_RTC
> +    select VIRTIO
> +    select VIRTIO_MMIO
> diff --git a/hw/m68k/meson.build b/hw/m68k/meson.build
> index ca0044c652d3..31248641d301 100644
> --- a/hw/m68k/meson.build
> +++ b/hw/m68k/meson.build
> @@ -3,5 +3,6 @@ m68k_ss.add(when: 'CONFIG_AN5206', if_true: files('an5206.c', 'mcf5206.c'))
>   m68k_ss.add(when: 'CONFIG_MCF5208', if_true: files('mcf5208.c', 'mcf_intc.c'))
>   m68k_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-kbd.c', 'next-cube.c'))
>   m68k_ss.add(when: 'CONFIG_Q800', if_true: files('q800.c'))
> +m68k_ss.add(when: 'CONFIG_M68K_VIRT', if_true: files('virt.c'))
>   
>   hw_arch += {'m68k': m68k_ss}
> 


