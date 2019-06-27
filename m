Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A724C48BD9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA5D2133F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVG/DeSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA5D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXfZ-0007GJ-99
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42570)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hgWrg-0005Qi-TE
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hgWrQ-0003FV-RK
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:03:08 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hgWrQ-00039k-9A
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:02:56 -0400
Received: by mail-qt1-x844.google.com with SMTP id h21so2958689qtn.13
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=93TnJqbnRMSvbbFGdXsgMhNpnPoD+1nKwWehw3LzfA8=;
 b=WVG/DeSfvMT/AaoieGo9nOE9K3B+SR1kOIssVTIY8M8wR6CrHSRlkTL2ONuPsaVPR6
 afoJe4VOn1ypvfhPHbmj0eAPir6EjhzEdtizB7T5HtXdir3Tcu1a1vukQ9b322yW/5c9
 NLYYHA7KGyMFKkZEzCcGEEQ2qINqcyXTO0mOACewjvFzpm5a/t5JmeNv8MUYmhp6GKLA
 rqs2aN4oXPFfIiC0jecYsOVmn1YQkSEGi2cgvjZrFBW4MTsm5ii3IjBNHWqdAuJGzZ8k
 EVWWREJiZw7vI8Ch2+1hyL/AJwaGea6H3Ra1ins32TQzkKm27we6P6TtAHDgVM5UC0ub
 PteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=93TnJqbnRMSvbbFGdXsgMhNpnPoD+1nKwWehw3LzfA8=;
 b=uHxhPzYFUxHXpkEWciSIzEqurHtvuiKonz7k+kDNNfVKO7n/u3hK3ETn6Lii6msrcI
 sI0dhclzGw5TtYtckEmbjQwobTcz6B9ujSM87oo8u16GN7rzraaUGWMBJt5KDJnqAY1o
 W382OQkliGyE5zIMAmSbydcoUfTfIg0JbMv5cczgVbkswjZWex828QWksMm/19o+6ALs
 w0aoPxewuo1LCvAWOGL71g6BmxbJtU7slRv8rDBa7xUkJK3tolGM/kKGAXst7n1h8duT
 ndxP8YAZXosPdKbs/q33T3sPsYz1h58zYd4qh61eYZ2/0LbE2EDKk8zbcNa2XRslF04s
 vVVg==
X-Gm-Message-State: APjAAAUti4lN0jPKkh4oRqs23e7ax261s6CE3ZS1oj0D2Zwol71GayI0
 VSqyiA9qnNKiFR8V547r9hcO8mnAaGtD5Ya+dxU=
X-Google-Smtp-Source: APXvYqyfnL3Gf3BGfKP/ElXm1Tph+Z9sqx+4RWK5mzZ0F29AZzEuyu+pbRAr1XIuZRrXOLAWiEaNGWku+G6QiuX/oeA=
X-Received: by 2002:a0c:e6a2:: with SMTP id j2mr3735617qvn.190.1561651371455; 
 Thu, 27 Jun 2019 09:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190627052750.31856-1-mrolnik@gmail.com>
 <20190627052750.31856-2-mrolnik@gmail.com>
 <20190627132800.462655c5@redhat.com>
In-Reply-To: <20190627132800.462655c5@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 27 Jun 2019 19:02:14 +0300
Message-ID: <CAK4993j0BP62dEM_X7dP_9zT5JjJ1F4_OwEuHTnVY+59RHgm0g@mail.gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v23 1/7] target/avr: Add outward facing
 interfaces and core CPU logic
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

if I run `make check` it fails with
qemu-system-rx: unable to find CPU model 'rx62n'
or
qemu-system-avr: unable to find CPU model 'avr6'

On Thu, Jun 27, 2019 at 2:28 PM Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 27 Jun 2019 08:27:44 +0300
> Michael Rolnik <mrolnik@gmail.com> wrote:
>
> > From: Sarah Harris <S.E.Harris@kent.ac.uk>
> >
> > This includes:
> > - CPU data structures
> > - object model classes and functions
> > - migration functions
> > - GDB hooks
> >
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > ---
> >  gdb-xml/avr-cpu.xml    |  49 ++++
> >  target/avr/cpu-param.h |  37 +++
> >  target/avr/cpu.c       | 599 +++++++++++++++++++++++++++++++++++++++++
> >  target/avr/cpu.h       | 283 +++++++++++++++++++
> >  target/avr/gdbstub.c   |  85 ++++++
> >  target/avr/machine.c   | 123 +++++++++
> >  6 files changed, 1176 insertions(+)
> >  create mode 100644 gdb-xml/avr-cpu.xml
> >  create mode 100644 target/avr/cpu-param.h
> >  create mode 100644 target/avr/cpu.c
> >  create mode 100644 target/avr/cpu.h
> >  create mode 100644 target/avr/gdbstub.c
> >  create mode 100644 target/avr/machine.c
> >
> > diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml
> > new file mode 100644
> > index 0000000000..c4747f5b40
> > --- /dev/null
> > +++ b/gdb-xml/avr-cpu.xml
> > @@ -0,0 +1,49 @@
> > +<?xml version="1.0"?>
> > +<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
> > +
> > +     Copying and distribution of this file, with or without
> modification,
> > +     are permitted in any medium without royalty provided the copyright
> > +     notice and this notice are preserved.  -->
> > +
> > +<!-- Register numbers are hard-coded in order to maintain backward
> > +     compatibility with older versions of tools that didn't use xml
> > +     register descriptions.  -->
> > +
> > +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > +<feature name="org.gnu.gdb.riscv.cpu">
> > +  <reg name="r0" bitsize="8" type="int" regnum="0"/>
> > +  <reg name="r1" bitsize="8" type="int"/>
> > +  <reg name="r2" bitsize="8" type="int"/>
> > +  <reg name="r3" bitsize="8" type="int"/>
> > +  <reg name="r4" bitsize="8" type="int"/>
> > +  <reg name="r5" bitsize="8" type="int"/>
> > +  <reg name="r6" bitsize="8" type="int"/>
> > +  <reg name="r7" bitsize="8" type="int"/>
> > +  <reg name="r8" bitsize="8" type="int"/>
> > +  <reg name="r9" bitsize="8" type="int"/>
> > +  <reg name="r10" bitsize="8" type="int"/>
> > +  <reg name="r11" bitsize="8" type="int"/>
> > +  <reg name="r12" bitsize="8" type="int"/>
> > +  <reg name="r13" bitsize="8" type="int"/>
> > +  <reg name="r14" bitsize="8" type="int"/>
> > +  <reg name="r15" bitsize="8" type="int"/>
> > +  <reg name="r16" bitsize="8" type="int"/>
> > +  <reg name="r17" bitsize="8" type="int"/>
> > +  <reg name="r18" bitsize="8" type="int"/>
> > +  <reg name="r19" bitsize="8" type="int"/>
> > +  <reg name="r20" bitsize="8" type="int"/>
> > +  <reg name="r21" bitsize="8" type="int"/>
> > +  <reg name="r22" bitsize="8" type="int"/>
> > +  <reg name="r23" bitsize="8" type="int"/>
> > +  <reg name="r24" bitsize="8" type="int"/>
> > +  <reg name="r25" bitsize="8" type="int"/>
> > +  <reg name="r26" bitsize="8" type="int"/>
> > +  <reg name="r27" bitsize="8" type="int"/>
> > +  <reg name="r28" bitsize="8" type="int"/>
> > +  <reg name="r29" bitsize="8" type="int"/>
> > +  <reg name="r30" bitsize="8" type="int"/>
> > +  <reg name="r31" bitsize="8" type="int"/>
> > +  <reg name="sreg" bitsize="8" type="int"/>
> > +  <reg name="sp" bitsize="8" type="int"/>
> > +  <reg name="pc" bitsize="8" type="int"/>
> > +</feature>
> > diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
> > new file mode 100644
> > index 0000000000..5bbf985726
> > --- /dev/null
> > +++ b/target/avr/cpu-param.h
> > @@ -0,0 +1,37 @@
> > +/*
> > + * QEMU AVR CPU
> > + *
> > + * Copyright (c) 2016 Michael Rolnik
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > + */
> > +
> > +#ifndef AVR_CPU_PARAM_H
> > +#define AVR_CPU_PARAM_H 1
> > +
> > +#define TARGET_LONG_BITS 32
> > +/*
> > + * TARGET_PAGE_BITS cannot be more than 8 bits because
> > + * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and
> they
> > + *     should be implemented as a device and not memory
> > + * 2.  SRAM starts at the address 0x0100
> > + */
> > +#define TARGET_PAGE_BITS 8
> > +#define TARGET_PHYS_ADDR_SPACE_BITS 24
> > +#define TARGET_VIRT_ADDR_SPACE_BITS 24
> > +#define NB_MMU_MODES 2
> > +
> > +
> > +#endif
> > diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> > new file mode 100644
> > index 0000000000..142fe54524
> > --- /dev/null
> > +++ b/target/avr/cpu.c
> > @@ -0,0 +1,599 @@
> > +/*
> > + * QEMU AVR CPU
> > + *
> > + * Copyright (c) 2016 Michael Rolnik
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/qemu-print.h"
> > +#include "qemu/log.h"
> > +#include "cpu.h"
> > +#include "exec/exec-all.h"
> > +#include "qapi/error.h"
> > +#include "hw/qdev-properties.h"
> > +#include "migration/vmstate.h"
> > +
> > +static void avr_cpu_set_pc(CPUState *cs, vaddr value)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(cs);
> > +
> > +    cpu->env.pc_w = value / 2; /* internally PC points to words */
> > +}
> > +
> > +static bool avr_cpu_has_work(CPUState *cs)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(cs);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    return (cs->interrupt_request & (CPU_INTERRUPT_HARD |
> CPU_INTERRUPT_RESET))
> > +            && cpu_interrupts_enabled(env);
> > +}
> > +
> > +static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock
> *tb)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(cs);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    env->pc_w = tb->pc / 2; /* internally PC points to words */
> > +}
> > +
> > +static void avr_cpu_reset(CPUState *cs)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(cs);
> > +    AVRCPUClass *mcc = AVR_CPU_GET_CLASS(cpu);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    mcc->parent_reset(cs);
> > +
> > +    env->pc_w = 0;
> > +    env->sregI = 1;
> > +    env->sregC = 0;
> > +    env->sregZ = 0;
> > +    env->sregN = 0;
> > +    env->sregV = 0;
> > +    env->sregS = 0;
> > +    env->sregH = 0;
> > +    env->sregT = 0;
> > +
> > +    env->rampD = 0;
> > +    env->rampX = 0;
> > +    env->rampY = 0;
> > +    env->rampZ = 0;
> > +    env->eind = 0;
> > +    env->sp = 0;
> > +
> > +    env->skip = 0;
> > +
> > +    memset(env->r, 0, sizeof(env->r));
> > +
> > +    tlb_flush(cs);
> > +}
> > +
> > +static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info
> *info)
> > +{
> > +    info->mach = bfd_arch_avr;
> > +    info->print_insn = NULL;
> > +}
> > +
> > +static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
> > +{
> > +    CPUState *cs = CPU(dev);
> > +    AVRCPUClass *mcc = AVR_CPU_GET_CLASS(dev);
> > +    Error *local_err = NULL;
> > +
> > +    cpu_exec_realizefn(cs, &local_err);
> > +    if (local_err != NULL) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +    qemu_init_vcpu(cs);
> > +    cpu_reset(cs);
> > +
> > +    mcc->parent_realize(dev, errp);
> > +}
> > +
> > +static void avr_cpu_set_int(void *opaque, int irq, int level)
> > +{
> > +    AVRCPU *cpu = opaque;
> > +    CPUAVRState *env = &cpu->env;
> > +    CPUState *cs = CPU(cpu);
> > +
> > +    uint64_t mask = (1ull << irq);
> > +    if (level) {
> > +        env->intsrc |= mask;
> > +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> > +    } else {
> > +        env->intsrc &= ~mask;
> > +        if (env->intsrc == 0) {
> > +            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> > +        }
> > +    }
> > +}
> > +
> > +static void avr_cpu_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +
> > +    cpu_set_cpustate_pointers(cpu);
> > +
> > +#ifndef CONFIG_USER_ONLY
> > +    /* Set the number of interrupts supported by the CPU. */
> > +    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int, 57);
> > +#endif
> > +}
> > +
> > +static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
> > +{
> > +    ObjectClass *oc;
> > +    char *typename;
> > +    char **cpuname;
> > +
> > +    cpuname = g_strsplit(cpu_model, ",", 1);
> you do not need this, parse_cpu_option() does it for you.
>
> > +    typename = g_strdup_printf(AVR_CPU_TYPE_NAME("%s"), cpuname[0]);
> > +    oc = object_class_by_name(typename);
> Also just use cpu_model directly for lookup
> for example see '[Qemu-devel] [PATCH RESEND v21 06/21] target/rx: CPU
> definition'
> and simplify avr_cpu_list_entry() correspondingly.
>
>
> > +    g_strfreev(cpuname);
> > +    g_free(typename);
> > +    if (!oc || !object_class_dynamic_cast(oc, TYPE_AVR_CPU) ||
> > +        object_class_is_abstract(oc)) {
> > +        return NULL;
> > +    }
> > +    return oc;
> > +}
> > +
> > +static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(cs);
> > +    CPUAVRState *env = &cpu->env;
> > +    int i;
> > +
> > +    qemu_fprintf(f, "\n");
> > +    qemu_fprintf(f, "PC:    %06x\n", env->pc_w);
> > +    qemu_fprintf(f, "SP:      %04x\n", env->sp);
> > +    qemu_fprintf(f, "rampD:     %02x\n", env->rampD >> 16);
> > +    qemu_fprintf(f, "rampX:     %02x\n", env->rampX >> 16);
> > +    qemu_fprintf(f, "rampY:     %02x\n", env->rampY >> 16);
> > +    qemu_fprintf(f, "rampZ:     %02x\n", env->rampZ >> 16);
> > +    qemu_fprintf(f, "EIND:      %02x\n", env->eind >> 16);
> > +    qemu_fprintf(f, "X:       %02x%02x\n", env->r[27], env->r[26]);
> > +    qemu_fprintf(f, "Y:       %02x%02x\n", env->r[29], env->r[28]);
> > +    qemu_fprintf(f, "Z:       %02x%02x\n", env->r[31], env->r[30]);
> > +    qemu_fprintf(f, "SREG:    [ %c %c %c %c %c %c %c %c ]\n",
> > +                        env->sregI ? 'I' : '-',
> > +                        env->sregT ? 'T' : '-',
> > +                        env->sregH ? 'H' : '-',
> > +                        env->sregS ? 'S' : '-',
> > +                        env->sregV ? 'V' : '-',
> > +                        env->sregN ? '-' : 'N', /* Zf has negative
> logic */
> > +                        env->sregZ ? 'Z' : '-',
> > +                        env->sregC ? 'I' : '-');
> > +    qemu_fprintf(f, "SKIP:    %02x\n", env->skip);
> > +
> > +    qemu_fprintf(f, "\n");
> > +    for (i = 0; i < ARRAY_SIZE(env->r); i++) {
> > +        qemu_fprintf(f, "R[%02d]:  %02x   ", i, env->r[i]);
> > +
> > +        if ((i % 8) == 7) {
> > +            qemu_fprintf(f, "\n");
> > +        }
> > +    }
> > +    qemu_fprintf(f, "\n");
> > +}
> > +
> > +static void avr_cpu_class_init(ObjectClass *oc, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(oc);
> > +    CPUClass *cc = CPU_CLASS(oc);
> > +    AVRCPUClass *mcc = AVR_CPU_CLASS(oc);
> > +
> > +    mcc->parent_realize = dc->realize;
> > +    dc->realize = avr_cpu_realizefn;
> > +
> > +    mcc->parent_reset = cc->reset;
> > +    cc->reset = avr_cpu_reset;
> > +
> > +    cc->class_by_name = avr_cpu_class_by_name;
> > +
> > +    cc->has_work = avr_cpu_has_work;
> > +    cc->do_interrupt = avr_cpu_do_interrupt;
> > +    cc->cpu_exec_interrupt = avr_cpu_exec_interrupt;
> > +    cc->dump_state = avr_cpu_dump_state;
> > +    cc->set_pc = avr_cpu_set_pc;
> > +#if !defined(CONFIG_USER_ONLY)
> > +    cc->memory_rw_debug = avr_cpu_memory_rw_debug;
> > +#endif
> > +#ifdef CONFIG_USER_ONLY
> > +    cc->handle_mmu_fault = avr_cpu_handle_mmu_fault;
> > +#else
> > +    cc->get_phys_page_debug = avr_cpu_get_phys_page_debug;
> > +    cc->vmsd = &vms_avr_cpu;
> > +#endif
> > +    cc->disas_set_info = avr_cpu_disas_set_info;
> > +    cc->tlb_fill = avr_cpu_tlb_fill;
> > +    cc->tcg_initialize = avr_cpu_tcg_init;
> > +    cc->synchronize_from_tb = avr_cpu_synchronize_from_tb;
> > +    cc->gdb_read_register = avr_cpu_gdb_read_register;
> > +    cc->gdb_write_register = avr_cpu_gdb_write_register;
> > +    cc->gdb_num_core_regs = 35;
> > +    cc->gdb_core_xml_file = "avr-cpu.xml";
> > +}
> > +
> > +static void avr_avr1_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +}
> > +
> > +static void avr_avr2_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +}
> > +
> > +static void avr_avr25_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +}
> > +
> > +static void avr_avr3_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +}
> > +
> > +static void avr_avr31_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +}
> > +
> > +static void avr_avr35_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +}
> > +
> > +static void avr_avr4_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +}
> > +
> > +static void avr_avr5_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +}
> > +
> > +static void avr_avr51_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +}
> > +
> > +static void avr_avr6_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +}
> > +
> > +static void avr_xmega2_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +static void avr_xmega4_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +static void avr_xmega5_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +static void avr_xmega6_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +static void avr_xmega7_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +typedef struct AVRCPUInfo {
> > +    const char *name;
> > +    void (*initfn)(Object *obj);
> > +} AVRCPUInfo;
> > +
> > +static gint avr_cpu_list_compare(gconstpointer a, gconstpointer b)
> > +{
> > +    ObjectClass *class_a = (ObjectClass *)a;
> > +    ObjectClass *class_b = (ObjectClass *)b;
> > +    const char *name_a;
> > +    const char *name_b;
> > +
> > +    name_a = object_class_get_name(class_a);
> > +    name_b = object_class_get_name(class_b);
> > +
> > +    return strcmp(name_a, name_b);
> > +}
> > +
> > +static void avr_cpu_list_entry(gpointer data, gpointer user_data)
> > +{
> > +    const char *typename = object_class_get_name(OBJECT_CLASS(data));
> > +    int len = strlen(typename) - strlen(AVR_CPU_TYPE_SUFFIX);
> > +    qemu_printf("%.*s\n", len, typename);
> > +}
> > +
> > +void avr_cpu_list(void)
> > +{
> > +    GSList *list;
> > +    list = object_class_get_list(TYPE_AVR_CPU, false);
> > +    list = g_slist_sort(list, avr_cpu_list_compare);
> > +    qemu_printf("Available CPUs:\n");
> > +    g_slist_foreach(list, avr_cpu_list_entry, NULL);
> > +    g_slist_free(list);
> > +}
> > +
> > +#define DEFINE_AVR_CPU_TYPE(model, initfn) \
> > +    {                                      \
> > +        .parent = TYPE_AVR_CPU,            \
> > +        .instance_init = initfn,           \
> > +        .name = AVR_CPU_TYPE_NAME(model),  \
> > +    }
> > +
> > +static const TypeInfo avr_cpu_type_info[] = {
> > +    {
> > +        .name = TYPE_AVR_CPU,
> > +        .parent = TYPE_CPU,
> > +        .instance_size = sizeof(AVRCPU),
> > +        .instance_init = avr_cpu_initfn,
> > +        .class_size = sizeof(AVRCPUClass),
> > +        .class_init = avr_cpu_class_init,
> > +        .abstract = true,
> > +    },
> > +    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
> > +};
> > +
> > +DEFINE_TYPES(avr_cpu_type_info)
> > diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> > new file mode 100644
> > index 0000000000..3f9a803193
> > --- /dev/null
> > +++ b/target/avr/cpu.h
> > @@ -0,0 +1,283 @@
> > +/*
> > + * QEMU AVR CPU
> > + *
> > + * Copyright (c) 2016 Michael Rolnik
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > + */
> > +
> > +#ifndef CPU_AVR_H
> > +#define CPU_AVR_H
> > +
> > +#include "qemu-common.h"
> > +#include "qom/cpu.h"
> > +#include "exec/cpu-defs.h"
> > +#include "fpu/softfloat.h"
> > +
> > +#define TCG_GUEST_DEFAULT_MO 0
> > +
> > +#define TYPE_AVR_CPU "avr-cpu"
> > +
> > +#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
> > +#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)
> > +#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
> > +
> > +/*
> > + * AVR has two memory spaces, data & code.
> > + * e.g. both have 0 address
> > + * ST/LD instructions access data space
> > + * LPM/SPM and instruction fetching access code memory space
> > + */
> > +#define MMU_CODE_IDX 0
> > +#define MMU_DATA_IDX 1
> > +
> > +#define EXCP_RESET 1
> > +#define EXCP_INT(n) (EXCP_RESET + (n) + 1)
> > +
> > +/* Number of CPU registers */
> > +#define NO_CPU_REGISTERS 32
> > +/* Number of IO registers accessible by ld/st/in/out */
> > +#define NO_IO_REGISTERS 64
> > +
> > +/*
> > + * Offsets of AVR memory regions in host memory space.
> > + *
> > + * This is needed because the AVR has separate code and data address
> > + * spaces that both have start from zero but have to go somewhere in
> > + * host memory.
> > + *
> > + * It's also useful to know where some things are, like the IO
> registers.
> > + */
> > +/* Flash program memory */
> > +#define OFFSET_CODE 0x00000000
> > +/* CPU registers, IO registers, and SRAM */
> > +#define OFFSET_DATA 0x00800000
> > +/* CPU registers specifically, these are mapped at the start of data */
> > +#define OFFSET_CPU_REGISTERS OFFSET_DATA
> > +/*
> > + * IO registers, including status register, stack pointer, and memory
> > + * mapped peripherals, mapped just after CPU registers
> > + */
> > +#define OFFSET_IO_REGISTERS (OFFSET_DATA + NO_CPU_REGISTERS)
> > +
> > +enum avr_features {
> > +    AVR_FEATURE_SRAM,
> > +
> > +    AVR_FEATURE_1_BYTE_PC,
> > +    AVR_FEATURE_2_BYTE_PC,
> > +    AVR_FEATURE_3_BYTE_PC,
> > +
> > +    AVR_FEATURE_1_BYTE_SP,
> > +    AVR_FEATURE_2_BYTE_SP,
> > +
> > +    AVR_FEATURE_BREAK,
> > +    AVR_FEATURE_DES,
> > +    AVR_FEATURE_RMW, /* Read Modify Write - XCH LAC LAS LAT */
> > +
> > +    AVR_FEATURE_EIJMP_EICALL,
> > +    AVR_FEATURE_IJMP_ICALL,
> > +    AVR_FEATURE_JMP_CALL,
> > +
> > +    AVR_FEATURE_ADIW_SBIW,
> > +
> > +    AVR_FEATURE_SPM,
> > +    AVR_FEATURE_SPMX,
> > +
> > +    AVR_FEATURE_ELPMX,
> > +    AVR_FEATURE_ELPM,
> > +    AVR_FEATURE_LPMX,
> > +    AVR_FEATURE_LPM,
> > +
> > +    AVR_FEATURE_MOVW,
> > +    AVR_FEATURE_MUL,
> > +    AVR_FEATURE_RAMPD,
> > +    AVR_FEATURE_RAMPX,
> > +    AVR_FEATURE_RAMPY,
> > +    AVR_FEATURE_RAMPZ,
> > +};
> > +
> > +typedef struct CPUAVRState CPUAVRState;
> > +
> > +struct CPUAVRState {
> > +    uint32_t pc_w; /* 0x003fffff up to 22 bits */
> > +
> > +    uint32_t sregC; /* 0x00000001 1 bits */
> > +    uint32_t sregZ; /* 0x0000ffff 16 bits, negative logic; */
> > +                    /* 0=flag set, >0=flag cleared */
> > +    uint32_t sregN; /* 0x00000001 1 bits */
> > +    uint32_t sregV; /* 0x00000001 1 bits */
> > +    uint32_t sregS; /* 0x00000001 1 bits */
> > +    uint32_t sregH; /* 0x00000001 1 bits */
> > +    uint32_t sregT; /* 0x00000001 1 bits */
> > +    uint32_t sregI; /* 0x00000001 1 bits */
> > +
> > +    uint32_t rampD; /* 0x00ff0000 8 bits */
> > +    uint32_t rampX; /* 0x00ff0000 8 bits */
> > +    uint32_t rampY; /* 0x00ff0000 8 bits */
> > +    uint32_t rampZ; /* 0x00ff0000 8 bits */
> > +    uint32_t eind; /* 0x00ff0000 8 bits */
> > +
> > +    uint32_t r[NO_CPU_REGISTERS]; /* 8 bits each */
> > +    uint32_t sp; /* 16 bits */
> > +
> > +    uint32_t skip; /* if set skip instruction */
> > +
> > +    uint64_t intsrc; /* interrupt sources */
> > +    bool fullacc; /* CPU/MEM if true MEM only otherwise */
> > +
> > +    uint32_t features;
> > +};
> > +
> > +#define AVR_CPU_CLASS(klass) \
> > +    OBJECT_CLASS_CHECK(AVRCPUClass, (klass), TYPE_AVR_CPU)
> > +#define AVR_CPU(obj) \
> > +    OBJECT_CHECK(AVRCPU, (obj), TYPE_AVR_CPU)
> > +#define AVR_CPU_GET_CLASS(obj) \
> > +    OBJECT_GET_CLASS(AVRCPUClass, (obj), TYPE_AVR_CPU)
> > +
> > +/**
> > + *  AVRCPUClass:
> > + *  @parent_realize: The parent class' realize handler.
> > + *  @parent_reset: The parent class' reset handler.
> > + *  @vr: Version Register value.
> > + *
> > + *  A AVR CPU model.
> > + */
> > +typedef struct AVRCPUClass {
> > +    /*< private >*/
> > +    CPUClass parent_class;
> > +    /*< public >*/
> > +    DeviceRealize parent_realize;
> > +    void (*parent_reset)(CPUState *cpu);
> > +} AVRCPUClass;
> > +
> > +/**
> > + *  AVRCPU:
> > + *  @env: #CPUAVRState
> > + *
> > + *  A AVR CPU.
> > + */
> > +typedef struct AVRCPU {
> > +    /*< private >*/
> > +    CPUState parent_obj;
> > +    /*< public >*/
> > +
> > +    CPUNegativeOffsetState neg;
> > +    CPUAVRState env;
> > +} AVRCPU;
> > +
> > +#ifndef CONFIG_USER_ONLY
> > +extern const struct VMStateDescription vms_avr_cpu;
> > +#endif
> > +
> > +void avr_cpu_do_interrupt(CPUState *cpu);
> > +bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
> > +hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> > +int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
> > +int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> > +
> > +static inline int avr_feature(CPUAVRState *env, int feature)
> > +{
> > +    return (env->features & (1U << feature)) != 0;
> > +}
> > +
> > +static inline void avr_set_feature(CPUAVRState *env, int feature)
> > +{
> > +    env->features |= (1U << feature);
> > +}
> > +
> > +#define cpu_list avr_cpu_list
> > +#define cpu_signal_handler cpu_avr_signal_handler
> > +#define cpu_mmu_index avr_cpu_mmu_index
> > +
> > +static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)
> > +{
> > +    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
> > +}
> > +
> > +void avr_cpu_tcg_init(void);
> > +
> > +void avr_cpu_list(void);
> > +int cpu_avr_exec(CPUState *cpu);
> > +int cpu_avr_signal_handler(int host_signum, void *pinfo, void *puc);
> > +int avr_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
> > +                                int rw, int mmu_idx);
> > +int avr_cpu_memory_rw_debug(CPUState *cs, vaddr address, uint8_t *buf,
> > +                                int len, bool is_write);
> > +
> > +enum {
> > +    TB_FLAGS_FULL_ACCESS = 1,
> > +    TB_FLAGS_SKIP = 2,
> > +};
> > +
> > +static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulong
> *pc,
> > +                                target_ulong *cs_base, uint32_t *pflags)
> > +{
> > +    uint32_t flags = 0;
> > +
> > +    *pc = env->pc_w * 2;
> > +    *cs_base = 0;
> > +
> > +    if (env->fullacc) {
> > +        flags |= TB_FLAGS_FULL_ACCESS;
> > +    }
> > +    if (env->skip) {
> > +        flags |= TB_FLAGS_SKIP;
> > +    }
> > +
> > +    *pflags = flags;
> > +}
> > +
> > +static inline int cpu_interrupts_enabled(CPUAVRState *env)
> > +{
> > +    return env->sregI != 0;
> > +}
> > +
> > +static inline uint8_t cpu_get_sreg(CPUAVRState *env)
> > +{
> > +    uint8_t sreg;
> > +    sreg = (env->sregC & 0x01) << 0
> > +         | (env->sregZ == 0 ? 1 : 0) << 1
> > +         | (env->sregN) << 2
> > +         | (env->sregV) << 3
> > +         | (env->sregS) << 4
> > +         | (env->sregH) << 5
> > +         | (env->sregT) << 6
> > +         | (env->sregI) << 7;
> > +    return sreg;
> > +}
> > +
> > +static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
> > +{
> > +    env->sregC = (sreg >> 0) & 0x01;
> > +    env->sregZ = (sreg >> 1) & 0x01 ? 0 : 1;
> > +    env->sregN = (sreg >> 2) & 0x01;
> > +    env->sregV = (sreg >> 3) & 0x01;
> > +    env->sregS = (sreg >> 4) & 0x01;
> > +    env->sregH = (sreg >> 5) & 0x01;
> > +    env->sregT = (sreg >> 6) & 0x01;
> > +    env->sregI = (sreg >> 7) & 0x01;
> > +}
> > +
> > +bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> > +                        MMUAccessType access_type, int mmu_idx,
> > +                        bool probe, uintptr_t retaddr);
> > +
> > +typedef CPUAVRState CPUArchState;
> > +typedef AVRCPU ArchCPU;
> > +
> > +#include "exec/cpu-all.h"
> > +
> > +#endif /* !defined (CPU_AVR_H) */
> > diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
> > new file mode 100644
> > index 0000000000..537dc7226e
> > --- /dev/null
> > +++ b/target/avr/gdbstub.c
> > @@ -0,0 +1,85 @@
> > +/*
> > + * QEMU AVR CPU
> > + *
> > + * Copyright (c) 2016 Michael Rolnik
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu-common.h"
> > +#include "exec/gdbstub.h"
> > +
> > +int avr_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(cs);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    /*  R */
> > +    if (n < 32) {
> > +        return gdb_get_reg8(mem_buf, env->r[n]);
> > +    }
> > +
> > +    /*  SREG */
> > +    if (n == 32) {
> > +        uint8_t sreg = cpu_get_sreg(env);
> > +
> > +        return gdb_get_reg8(mem_buf, sreg);
> > +    }
> > +
> > +    /*  SP */
> > +    if (n == 33) {
> > +        return gdb_get_reg16(mem_buf, env->sp & 0x0000ffff);
> > +    }
> > +
> > +    /*  PC */
> > +    if (n == 34) {
> > +        return gdb_get_reg32(mem_buf, env->pc_w * 2);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(cs);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    /*  R */
> > +    if (n < 32) {
> > +        env->r[n] = *mem_buf;
> > +        return 1;
> > +    }
> > +
> > +    /*  SREG */
> > +    if (n == 32) {
> > +        cpu_set_sreg(env, *mem_buf);
> > +        return 1;
> > +    }
> > +
> > +    /*  SP */
> > +    if (n == 33) {
> > +        env->sp = lduw_p(mem_buf);
> > +        return 2;
> > +    }
> > +
> > +    /*  PC */
> > +    if (n == 34) {
> > +        env->pc_w = ldl_p(mem_buf) / 2;
> > +        return 4;
> > +    }
> > +
> > +    return 0;
> > +}
> > diff --git a/target/avr/machine.c b/target/avr/machine.c
> > new file mode 100644
> > index 0000000000..389b5eb95d
> > --- /dev/null
> > +++ b/target/avr/machine.c
> > @@ -0,0 +1,123 @@
> > +/*
> > + * QEMU AVR CPU
> > + *
> > + * Copyright (c) 2016 Michael Rolnik
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/hw.h"
> > +#include "cpu.h"
> > +#include "hw/boards.h"
> > +#include "migration/qemu-file.h"
> > +
> > +static int get_sreg(QEMUFile *f, void *opaque, size_t size,
> > +    const VMStateField *field)
> > +{
> > +    CPUAVRState *env = opaque;
> > +    uint8_t sreg;
> > +
> > +    sreg = qemu_get_byte(f);
> > +    cpu_set_sreg(env, sreg);
> > +    return 0;
> > +}
> > +
> > +static int put_sreg(
> > +    QEMUFile *f, void *opaque, size_t size,
> > +    const VMStateField *field, QJSON *vmdesc)
> > +{
> > +    CPUAVRState *env = opaque;
> > +    uint8_t sreg = cpu_get_sreg(env);
> > +
> > +    qemu_put_byte(f, sreg);
> > +    return 0;
> > +}
> > +
> > +static const VMStateInfo vms_sreg = {
> > +    .name = "sreg",
> > +    .get = get_sreg,
> > +    .put = put_sreg,
> > +};
> > +
> > +static int get_segment(
> > +    QEMUFile *f, void *opaque, size_t size, const VMStateField *field)
> > +{
> > +    uint32_t *ramp = opaque;
> > +    uint8_t temp;
> > +
> > +    temp = qemu_get_byte(f);
> > +    *ramp = ((uint32_t)temp) << 16;
> > +    return 0;
> > +}
> > +
> > +static int put_segment(
> > +    QEMUFile *f, void *opaque, size_t size,
> > +    const VMStateField *field, QJSON *vmdesc)
> > +{
> > +    uint32_t *ramp = opaque;
> > +    uint8_t temp = *ramp >> 16;
> > +
> > +    qemu_put_byte(f, temp);
> > +    return 0;
> > +}
> > +
> > +static const VMStateInfo vms_rampD = {
> > +    .name = "rampD",
> > +    .get = get_segment,
> > +    .put = put_segment,
> > +};
> > +static const VMStateInfo vms_rampX = {
> > +    .name = "rampX",
> > +    .get = get_segment,
> > +    .put = put_segment,
> > +};
> > +static const VMStateInfo vms_rampY = {
> > +    .name = "rampY",
> > +    .get = get_segment,
> > +    .put = put_segment,
> > +};
> > +static const VMStateInfo vms_rampZ = {
> > +    .name = "rampZ",
> > +    .get = get_segment,
> > +    .put = put_segment,
> > +};
> > +static const VMStateInfo vms_eind = {
> > +    .name = "eind",
> > +    .get = get_segment,
> > +    .put = put_segment,
> > +};
> > +
> > +const VMStateDescription vms_avr_cpu = {
> > +    .name = "cpu",
> > +    .version_id = 0,
> > +    .minimum_version_id = 0,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_UINT32(env.pc_w, AVRCPU),
> > +        VMSTATE_UINT32(env.sp, AVRCPU),
> > +        VMSTATE_UINT32(env.skip, AVRCPU),
> > +
> > +        VMSTATE_UINT32_ARRAY(env.r, AVRCPU, NO_CPU_REGISTERS),
> > +
> > +        VMSTATE_SINGLE(env, AVRCPU, 0, vms_sreg, CPUAVRState),
> > +        VMSTATE_SINGLE(env.rampD, AVRCPU, 0, vms_rampD, uint32_t),
> > +        VMSTATE_SINGLE(env.rampX, AVRCPU, 0, vms_rampX, uint32_t),
> > +        VMSTATE_SINGLE(env.rampY, AVRCPU, 0, vms_rampY, uint32_t),
> > +        VMSTATE_SINGLE(env.rampZ, AVRCPU, 0, vms_rampZ, uint32_t),
> > +        VMSTATE_SINGLE(env.eind, AVRCPU, 0, vms_eind, uint32_t),
> > +
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
>
>

-- 
Best Regards,
Michael Rolnik
