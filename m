Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE72C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A741221789
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4TM/XAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A741221789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaIcX-0005e5-T8
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 07:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iaIYs-00043b-Qt
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iaIYg-0003Jc-GN
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:06:13 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e]:44592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iaIYg-00031a-8s
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:06:06 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id t11so1423678qvz.11
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 04:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Im0qF1+filgdGEwp4tzeAoPHhWCgA/+Qdm4HLlOesuU=;
 b=l4TM/XAE2/HSngxjUzCZjtiuGGgB3lPX/1UuYl9lARVs+rRVukuU1OSciIzCicdaKV
 PByG84mMnO2dnNdF2kNukgS4BXOk4DpUZaDfLzsAi7ii5IxCnBVcQIHkbxJVBXKVURkV
 oc/gFp+YRIYBMeIOjXnoc633WA9dtaSuANkwP1NdRET2TU8cDkwCuLXUV0KbJ+J9I5m2
 VbTVZc5tXuHvX+bkbpkHk6bfLU6Xh3ZcBsrPnCQRjNytA4+ujaG3u3YxZCbw+4woY2rW
 dWr5wrCOMp1ssNSgHN4/o5WgmE25P7vD4riAlypjBWBhBhBoUKPlYXIDLIsgW65I1wUE
 RtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Im0qF1+filgdGEwp4tzeAoPHhWCgA/+Qdm4HLlOesuU=;
 b=mXCHtWKF8YQLePZPe6aIBErf7cYHAP62R19M01caz3NVqVNS7ZOQW9CTE9OOi9ItEy
 3nSNgU5mOAnY9Q5ag9EVg/d+AZHCGgbx8YQGN5VyU5vaY7xtacQ/sPFzjoLfVGK7OVnp
 g0rfo/q5lFvx2oP0vS2hSOiMGnmmZ5Pj/eIf+Rvne/8s0RYpjkhnfedjKayCbvoc3vyL
 IlIsJnFNKpqjn1ianXnWxA/OTYOlXjyOMbocAZYCPH9VkLu9lKHlUNf1Q/S7oAbqqX/Z
 IMhbMGDtjj3YFW/xZ4ry8/jPbDfz7mHgFpN7fBPqe9nbjd7dX+OF5gctnjlzIpjkQL+f
 4QSQ==
X-Gm-Message-State: APjAAAWKXSX+JxtTFlwxvo6h/lm5JlLTJ3o7k2vhtWHa1pX3F7NpmCiN
 nTn94YyNrXADGawC9FdO5hj9qv5hSRjitFx28j8=
X-Google-Smtp-Source: APXvYqyArf2HKPbeLnVobhrVj6Dxfz1QV0NskN4Kas5zkx7tVm5FvYylLGahZ1v+UcCpwEyA9T28LqsElBOMzsw2Q9o=
X-Received: by 2002:a05:6214:8e5:: with SMTP id
 dr5mr10131967qvb.79.1574942759686; 
 Thu, 28 Nov 2019 04:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-2-mrolnik@gmail.com>
 <861986d1-11e4-8cb2-5fb6-e19cfef67f61@redhat.com>
In-Reply-To: <861986d1-11e4-8cb2-5fb6-e19cfef67f61@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 28 Nov 2019 14:04:50 +0200
Message-ID: <CAK4993iwCa+RPMbVtcDnaKTZ3bia1THN1GRfc+8P+coYkSA4aw@mail.gmail.com>
Subject: Re: [PATCH v37 01/17] target/avr: Add outward facing interfaces and
 core CPU logic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bb999a059866ef09"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f2e
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bb999a059866ef09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2019 at 12:26 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> Hi Michael,
>
> On 11/27/19 6:52 PM, Michael Rolnik wrote:
> > This includes:
> > - CPU data structures
> > - object model classes and functions
> > - migration functions
> > - GDB hooks
> >
> > Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
> > Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Acked-by: Igor Mammedov <imammedo@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >   target/avr/cpu-param.h |  37 +++
> >   target/avr/cpu-qom.h   |  54 ++++
> >   target/avr/cpu.h       | 253 ++++++++++++++++++
> >   target/avr/cpu.c       | 576 ++++++++++++++++++++++++++++++++++++++++=
+
> >   target/avr/gdbstub.c   |  85 ++++++
> >   target/avr/machine.c   | 121 +++++++++
> >   gdb-xml/avr-cpu.xml    |  49 ++++
> >   7 files changed, 1175 insertions(+)
> >   create mode 100644 target/avr/cpu-param.h
> >   create mode 100644 target/avr/cpu-qom.h
> >   create mode 100644 target/avr/cpu.h
> >   create mode 100644 target/avr/cpu.c
> >   create mode 100644 target/avr/gdbstub.c
> >   create mode 100644 target/avr/machine.c
> >   create mode 100644 gdb-xml/avr-cpu.xml
> >
> > diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
> > new file mode 100644
> > index 0000000000..ccd1ea3429
> > --- /dev/null
> > +++ b/target/avr/cpu-param.h
> > @@ -0,0 +1,37 @@
> > +/*
> > + * QEMU AVR CPU
> > + *
> > + * Copyright (c) 2019 Michael Rolnik
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
> > diff --git a/target/avr/cpu-qom.h b/target/avr/cpu-qom.h
> > new file mode 100644
> > index 0000000000..e28b58c897
> > --- /dev/null
> > +++ b/target/avr/cpu-qom.h
> > @@ -0,0 +1,54 @@
> > +/*
> > + * QEMU AVR CPU
> > + *
> > + * Copyright (c) 2019 Michael Rolnik
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
> > +#ifndef QEMU_AVR_QOM_H
> > +#define QEMU_AVR_QOM_H
> > +
> > +#include "hw/core/cpu.h"
> > +
> > +#define TYPE_AVR_CPU "avr-cpu"
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
> > +typedef struct AVRCPU AVRCPU;
> > +
> > +
> > +#endif /* !defined (QEMU_AVR_CPU_QOM_H) */
> > diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> > new file mode 100644
> > index 0000000000..9ea5260165
> > --- /dev/null
> > +++ b/target/avr/cpu.h
> > @@ -0,0 +1,253 @@
> > +/*
> > + * QEMU AVR CPU
> > + *
> > + * Copyright (c) 2019 Michael Rolnik
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
> > +#ifndef QEMU_AVR_CPU_H
> > +#define QEMU_AVR_CPU_H
> > +
> > +#include "cpu-qom.h"
> > +#include "exec/cpu-defs.h"
> > +
> > +#define TCG_GUEST_DEFAULT_MO 0
> > +
>
> Please add:
>
>   #define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
>   #define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)
>
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
> > +#define NUMBER_OF_CPU_REGISTERS 32
> > +/* Number of IO registers accessible by ld/st/in/out */
> > +#define NUMBER_OF_IO_REGISTERS 64
> > +
>
> Is the following block <...
>
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
> > +/* CPU registers specifically, these are mapped at the start of data *=
/
> > +#define OFFSET_CPU_REGISTERS OFFSET_DATA
> > +/*
> > + * IO registers, including status register, stack pointer, and memory
> > + * mapped peripherals, mapped just after CPU registers
> > + */
> > +#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)
>
> ...> really CPU specific? This doesn't seem used by the CPU (core) code,
> but by the MCU devices. Maybe we can extract them into
> "target/avr/addrspace.h".
>
These defines are used in the helper.c file

>
> Can be done later.
>
> [...]
> > +static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
> > +{
> > +    CPUState *cs =3D CPU(dev);
> > +    AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(dev);
> > +    Error *local_err =3D NULL;
> > +
> > +    cpu_exec_realizefn(cs, &local_err);
> > +    if (local_err !=3D NULL) {
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
> > +    AVRCPU *cpu =3D opaque;
> > +    CPUAVRState *env =3D &cpu->env;
> > +    CPUState *cs =3D CPU(cpu);
> > +
> > +    uint64_t mask =3D (1ull << irq);
> > +    if (level) {
> > +        env->intsrc |=3D mask;
> > +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> > +    } else {
> > +        env->intsrc &=3D ~mask;
> > +        if (env->intsrc =3D=3D 0) {
> > +            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> > +        }
> > +    }
> > +}
> > +
> > +static void avr_cpu_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +
> > +    cpu_set_cpustate_pointers(cpu);
> > +
> > +#ifndef CONFIG_USER_ONLY
> > +    /* Set the number of interrupts supported by the CPU. */
> > +    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int, 57);
>
> Deeply buried magic number...
>
> I'm trying to understand the following comment in sample.c:
>
>      /*
>       * These IRQ numbers don't match the datasheet because we're
> counting from
>       * zero and not including reset.
>       */
>
> RESET is IRQ#1. IIUC qdev_get_gpio_in(cpu, 0) will return IRQ#2?
> Then qdev_get_gpio_in(cpu, 55) will return IRQ#57?
>
> This is related to:
>
>   #define EXCP_RESET 1
>   #define EXCP_INT(n) (EXCP_RESET + (n) + 1)
>
> But then you use the hardware numbering:
>
> /* Interrupt numbers used by peripherals */
> #define USART_RXC_IRQ 24
> #define USART_DRE_IRQ 25
> #define USART_TXC_IRQ 26
>
> So for USART3_TX=3D57, have we qdev_get_gpio_in(cpu, 57) out of bound?
>
> Trying so trigger an abort:
>
> #1  0x00007f2ed58e1895 in abort () at /lib64/libc.so.6
> #2  0x00007f2ed58e1769 in _nl_load_domain.cold () at /lib64/libc.so.6
> #3  0x00007f2ed58ef566 in annobin_assert.c_end () at /lib64/libc.so.6
> #4  0x0000561fbbb37417 in qdev_get_gpio_in_named (dev=3D0x561fbd8b19d0,
> name=3D0x0, n=3D57) at hw/core/qdev.c:478
> #5  0x0000561fbbb37454 in qdev_get_gpio_in (dev=3D0x561fbd8b19d0, n=3D57)=
 at
> hw/core/qdev.c:484
>
> [This has to be fixed before merging]
>
> Also, what about other MCUs with more than 57 lines? Can we use some
> maximum value instead? Maybe 64?
>
> Else we need to add a property and move that into realize(), because we
> won't know the value at init() time.
>
> Please use a #define for this value.
>
> > +#endif
> > +}
> [...]
>
> Thanks,
>
> Phil.
>
>

--=20
Best Regards,
Michael Rolnik

--000000000000bb999a059866ef09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 28, 2019 at 12:26 AM Phil=
ippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Hi Michael,<br>
<br>
On 11/27/19 6:52 PM, Michael Rolnik wrote:<br>
&gt; This includes:<br>
&gt; - CPU data structures<br>
&gt; - object model classes and functions<br>
&gt; - migration functions<br>
&gt; - GDB hooks<br>
&gt; <br>
&gt; Co-developed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.co=
m" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Co-developed-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac=
.uk" target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
 target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.u=
k" target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
 target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Acked-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" tar=
get=3D"_blank">imammedo@redhat.com</a>&gt;<br>
&gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@re=
dhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/avr/cpu-param.h |=C2=A0 37 +++<br>
&gt;=C2=A0 =C2=A0target/avr/cpu-qom.h=C2=A0 =C2=A0|=C2=A0 54 ++++<br>
&gt;=C2=A0 =C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 253 +++++++++=
+++++++++<br>
&gt;=C2=A0 =C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 576 +++++++++=
++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0target/avr/gdbstub.c=C2=A0 =C2=A0|=C2=A0 85 ++++++<br>
&gt;=C2=A0 =C2=A0target/avr/machine.c=C2=A0 =C2=A0| 121 +++++++++<br>
&gt;=C2=A0 =C2=A0gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 |=C2=A0 49 ++++<br>
&gt;=C2=A0 =C2=A07 files changed, 1175 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/avr/cpu-param.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/avr/cpu-qom.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/avr/cpu.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/avr/cpu.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/avr/gdbstub.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/avr/machine.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 gdb-xml/avr-cpu.xml<br>
&gt; <br>
&gt; diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..ccd1ea3429<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/cpu-param.h<br>
&gt; @@ -0,0 +1,37 @@<br>
&gt; +/*<br>
&gt; + * QEMU AVR CPU<br>
&gt; + *<br>
&gt; + * Copyright (c) 2019 Michael Rolnik<br>
&gt; + *<br>
&gt; + * This library is free software; you can redistribute it and/or<br>
&gt; + * modify it under the terms of the GNU Lesser General Public<br>
&gt; + * License as published by the Free Software Foundation; either<br>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt; + *<br>
&gt; + * This library is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; + * Lesser General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; + * License along with this library; if not, see<br>
&gt; + * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" rel=3D"n=
oreferrer" target=3D"_blank">http://www.gnu.org/licenses/lgpl-2.1.html</a>&=
gt;<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef AVR_CPU_PARAM_H<br>
&gt; +#define AVR_CPU_PARAM_H 1<br>
&gt; +<br>
&gt; +#define TARGET_LONG_BITS 32<br>
&gt; +/*<br>
&gt; + * TARGET_PAGE_BITS cannot be more than 8 bits because<br>
&gt; + * 1.=C2=A0 all IO registers occupy [0x0000 .. 0x00ff] address range,=
 and they<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0should be implemented as a device and not memor=
y<br>
&gt; + * 2.=C2=A0 SRAM starts at the address 0x0100<br>
&gt; + */<br>
&gt; +#define TARGET_PAGE_BITS 8<br>
&gt; +#define TARGET_PHYS_ADDR_SPACE_BITS 24<br>
&gt; +#define TARGET_VIRT_ADDR_SPACE_BITS 24<br>
&gt; +#define NB_MMU_MODES 2<br>
&gt; +<br>
&gt; +<br>
&gt; +#endif<br>
&gt; diff --git a/target/avr/cpu-qom.h b/target/avr/cpu-qom.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..e28b58c897<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/cpu-qom.h<br>
&gt; @@ -0,0 +1,54 @@<br>
&gt; +/*<br>
&gt; + * QEMU AVR CPU<br>
&gt; + *<br>
&gt; + * Copyright (c) 2019 Michael Rolnik<br>
&gt; + *<br>
&gt; + * This library is free software; you can redistribute it and/or<br>
&gt; + * modify it under the terms of the GNU Lesser General Public<br>
&gt; + * License as published by the Free Software Foundation; either<br>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt; + *<br>
&gt; + * This library is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; + * Lesser General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; + * License along with this library; if not, see<br>
&gt; + * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" rel=3D"n=
oreferrer" target=3D"_blank">http://www.gnu.org/licenses/lgpl-2.1.html</a>&=
gt;<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef QEMU_AVR_QOM_H<br>
&gt; +#define QEMU_AVR_QOM_H<br>
&gt; +<br>
&gt; +#include &quot;hw/core/cpu.h&quot;<br>
&gt; +<br>
&gt; +#define TYPE_AVR_CPU &quot;avr-cpu&quot;<br>
&gt; +<br>
&gt; +#define AVR_CPU_CLASS(klass) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_CLASS_CHECK(AVRCPUClass, (klass), TYPE_AVR_CPU)<=
br>
&gt; +#define AVR_CPU(obj) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_CHECK(AVRCPU, (obj), TYPE_AVR_CPU)<br>
&gt; +#define AVR_CPU_GET_CLASS(obj) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_GET_CLASS(AVRCPUClass, (obj), TYPE_AVR_CPU)<br>
&gt; +<br>
&gt; +/**<br>
&gt; + *=C2=A0 AVRCPUClass:<br>
&gt; + *=C2=A0 @parent_realize: The parent class&#39; realize handler.<br>
&gt; + *=C2=A0 @parent_reset: The parent class&#39; reset handler.<br>
&gt; + *=C2=A0 @vr: Version Register value.<br>
&gt; + *<br>
&gt; + *=C2=A0 A AVR CPU model.<br>
&gt; + */<br>
&gt; +typedef struct AVRCPUClass {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 CPUClass parent_class;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +=C2=A0 =C2=A0 DeviceRealize parent_realize;<br>
&gt; +=C2=A0 =C2=A0 void (*parent_reset)(CPUState *cpu);<br>
&gt; +} AVRCPUClass;<br>
&gt; +<br>
&gt; +typedef struct AVRCPU AVRCPU;<br>
&gt; +<br>
&gt; +<br>
&gt; +#endif /* !defined (QEMU_AVR_CPU_QOM_H) */<br>
&gt; diff --git a/target/avr/cpu.h b/target/avr/cpu.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..9ea5260165<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/cpu.h<br>
&gt; @@ -0,0 +1,253 @@<br>
&gt; +/*<br>
&gt; + * QEMU AVR CPU<br>
&gt; + *<br>
&gt; + * Copyright (c) 2019 Michael Rolnik<br>
&gt; + *<br>
&gt; + * This library is free software; you can redistribute it and/or<br>
&gt; + * modify it under the terms of the GNU Lesser General Public<br>
&gt; + * License as published by the Free Software Foundation; either<br>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt; + *<br>
&gt; + * This library is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; + * Lesser General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; + * License along with this library; if not, see<br>
&gt; + * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" rel=3D"n=
oreferrer" target=3D"_blank">http://www.gnu.org/licenses/lgpl-2.1.html</a>&=
gt;<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef QEMU_AVR_CPU_H<br>
&gt; +#define QEMU_AVR_CPU_H<br>
&gt; +<br>
&gt; +#include &quot;cpu-qom.h&quot;<br>
&gt; +#include &quot;exec/cpu-defs.h&quot;<br>
&gt; +<br>
&gt; +#define TCG_GUEST_DEFAULT_MO 0<br>
&gt; +<br>
<br>
Please add:<br>
<br>
=C2=A0 #define AVR_CPU_TYPE_SUFFIX &quot;-&quot; TYPE_AVR_CPU<br>
=C2=A0 #define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)<br>
<br>
&gt; +#define CPU_RESOLVING_TYPE TYPE_AVR_CPU<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * AVR has two memory spaces, data &amp; code.<br>
&gt; + * e.g. both have 0 address<br>
&gt; + * ST/LD instructions access data space<br>
&gt; + * LPM/SPM and instruction fetching access code memory space<br>
&gt; + */<br>
&gt; +#define MMU_CODE_IDX 0<br>
&gt; +#define MMU_DATA_IDX 1<br>
&gt; +<br>
&gt; +#define EXCP_RESET 1<br>
&gt; +#define EXCP_INT(n) (EXCP_RESET + (n) + 1)<br>
&gt; +<br>
&gt; +/* Number of CPU registers */<br>
&gt; +#define NUMBER_OF_CPU_REGISTERS 32<br>
&gt; +/* Number of IO registers accessible by ld/st/in/out */<br>
&gt; +#define NUMBER_OF_IO_REGISTERS 64<br>
&gt; +<br>
<br>
Is the following block &lt;...<br>
<br>
&gt; +/*<br>
&gt; + * Offsets of AVR memory regions in host memory space.<br>
&gt; + *<br>
&gt; + * This is needed because the AVR has separate code and data address<=
br>
&gt; + * spaces that both have start from zero but have to go somewhere in<=
br>
&gt; + * host memory.<br>
&gt; + *<br>
&gt; + * It&#39;s also useful to know where some things are, like the IO re=
gisters.<br>
&gt; + */<br>
&gt; +/* Flash program memory */<br>
&gt; +#define OFFSET_CODE 0x00000000<br>
&gt; +/* CPU registers, IO registers, and SRAM */<br>
&gt; +#define OFFSET_DATA 0x00800000<br>
&gt; +/* CPU registers specifically, these are mapped at the start of data =
*/<br>
&gt; +#define OFFSET_CPU_REGISTERS OFFSET_DATA<br>
&gt; +/*<br>
&gt; + * IO registers, including status register, stack pointer, and memory=
<br>
&gt; + * mapped peripherals, mapped just after CPU registers<br>
&gt; + */<br>
&gt; +#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)<b=
r>
<br>
...&gt; really CPU specific? This doesn&#39;t seem used by the CPU (core) c=
ode, <br>
but by the MCU devices. Maybe we can extract them into <br>
&quot;target/avr/addrspace.h&quot;.<br></blockquote><div>These defines are =
used in the helper.c file=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
Can be done later.<br>
<br>
[...]<br>
&gt; +static void avr_cpu_realizefn(DeviceState *dev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CPUState *cs =3D CPU(dev);<br>
&gt; +=C2=A0 =C2=A0 AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(dev);<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu_exec_realizefn(cs, &amp;local_err);<br>
&gt; +=C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 qemu_init_vcpu(cs);<br>
&gt; +=C2=A0 =C2=A0 cpu_reset(cs);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mcc-&gt;parent_realize(dev, errp);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void avr_cpu_set_int(void *opaque, int irq, int level)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +=C2=A0 =C2=A0 CPUState *cs =3D CPU(cpu);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint64_t mask =3D (1ull &lt;&lt; irq);<br>
&gt; +=C2=A0 =C2=A0 if (level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;intsrc |=3D mask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_interrupt(cs, CPU_INTERRUPT_HARD);<br=
>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;intsrc &amp;=3D ~mask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;intsrc =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_reset_interrupt(cs, CPU=
_INTERRUPT_HARD);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void avr_cpu_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu_set_cpustate_pointers(cpu);<br>
&gt; +<br>
&gt; +#ifndef CONFIG_USER_ONLY<br>
&gt; +=C2=A0 =C2=A0 /* Set the number of interrupts supported by the CPU. *=
/<br>
&gt; +=C2=A0 =C2=A0 qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int, 57);<br=
>
<br>
Deeply buried magic number...<br>
<br>
I&#39;m trying to understand the following comment in sample.c:<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * These IRQ numbers don&#39;t match the datasheet beca=
use we&#39;re <br>
counting from<br>
=C2=A0 =C2=A0 =C2=A0 * zero and not including reset.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
<br>
RESET is IRQ#1. IIUC qdev_get_gpio_in(cpu, 0) will return IRQ#2?<br>
Then qdev_get_gpio_in(cpu, 55) will return IRQ#57?<br>
<br>
This is related to:<br>
<br>
=C2=A0 #define EXCP_RESET 1<br>
=C2=A0 #define EXCP_INT(n) (EXCP_RESET + (n) + 1)<br>
<br>
But then you use the hardware numbering:<br>
<br>
/* Interrupt numbers used by peripherals */<br>
#define USART_RXC_IRQ 24<br>
#define USART_DRE_IRQ 25<br>
#define USART_TXC_IRQ 26<br>
<br>
So for USART3_TX=3D57, have we qdev_get_gpio_in(cpu, 57) out of bound?<br>
<br>
Trying so trigger an abort:<br>
<br>
#1=C2=A0 0x00007f2ed58e1895 in abort () at /lib64/libc.so.6<br>
#2=C2=A0 0x00007f2ed58e1769 in _nl_load_domain.cold () at /lib64/libc.so.6<=
br>
#3=C2=A0 0x00007f2ed58ef566 in annobin_assert.c_end () at /lib64/libc.so.6<=
br>
#4=C2=A0 0x0000561fbbb37417 in qdev_get_gpio_in_named (dev=3D0x561fbd8b19d0=
, <br>
name=3D0x0, n=3D57) at hw/core/qdev.c:478<br>
#5=C2=A0 0x0000561fbbb37454 in qdev_get_gpio_in (dev=3D0x561fbd8b19d0, n=3D=
57) at <br>
hw/core/qdev.c:484<br>
<br>
[This has to be fixed before merging]<br>
<br>
Also, what about other MCUs with more than 57 lines? Can we use some <br>
maximum value instead? Maybe 64?<br>
<br>
Else we need to add a property and move that into realize(), because we <br=
>
won&#39;t know the value at init() time.<br>
<br>
Please use a #define for this value.<br>
<br>
&gt; +#endif<br>
&gt; +}<br>
[...]<br>
<br>
Thanks,<br>
<br>
Phil.<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div></div>

--000000000000bb999a059866ef09--

