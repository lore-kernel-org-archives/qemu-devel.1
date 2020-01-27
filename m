Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1182BC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B9920702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hscTm2Cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B9920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw08t-0003Ji-Uv
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 03:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iw08J-0002uv-C0
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iw08G-0001mI-Vz
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:52:35 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:43897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iw08G-0001l7-OM
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:52:32 -0500
Received: by mail-qk1-x742.google.com with SMTP id j20so8821892qka.10
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 00:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ojWNVMFWpZFIcXhdRHPLdeBxJIuk410qUxhw2hq9qoo=;
 b=hscTm2CcS10/9o5nIO/7K4wL379raqKdCk4g7CiIYz1UjHuYcnDSXsxGdOk4vi2xZh
 eQ4tc0pT12flxy4HPbn+LR2JX/9vifLQPwqSe5cLqsaIzu4mZdD9m5mZ4wXZwYIGkDLc
 ZTjfkX4Jqqp4X93z3C5tFsJOQIeHi1PDv4JlOZz657ve5YQScQdSvLuU8kEeIRiiPTYM
 mUdIfp6y19tta8diSsxE1J+SL4+292prIyJ1sAM1l9TfQkhhpstl5hqV6Fg2r8KhkDF/
 0lelVHoihmyRMBpH6jJhNz6oIsxfAIOryH8qp9Sylx2zf6Zsi/Odtb57vERZum2YLpMw
 M4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ojWNVMFWpZFIcXhdRHPLdeBxJIuk410qUxhw2hq9qoo=;
 b=RGrPozXrOV3t+ycUx+gfHISVSk447kR1PKKrlJr1u2zKDIRR+ny0x6jc1EBWi5lPDu
 M6snrhCwSlVwYsRQAhA356MWXdAH+IPYAMn2AchN1X4G3DiCnP0GEnNU40hVnWC7Mo3r
 5EknYO2BcFWwJXtjGKKPYvie4pQPFYyT8vHDx+9z0ayIlqG9VZBN65LLE9eoBZv/E9cR
 qZT3xcIo0OCZrnuYXqFwmgjkm1raFTfdEWbSjkCpwP112/PHW9/wR30WtRx6JYYPSVhG
 bBLPOL54ir1fbW4ZLNVfh/1xK9JGcunW69jOjl1pw6r7FCZxXIZ2aDWIya8l1YPpW7Cb
 B3pA==
X-Gm-Message-State: APjAAAWWypc4IDdkfILKb+BOifx3MBAV4UlWUiqGyzbeoEW/tES1eDIW
 FBJTeItSMYnTeoCLFZ2FwavoraobH1799msV5bQ=
X-Google-Smtp-Source: APXvYqyNgZ/WI0c6/ZMwjvoNMOqXuJBPHi8E2CZOf6TEvHJbJqe8+OxpHpRtWcXaRVKsjftlvvKjHQck5kAEQs5QAf4=
X-Received: by 2002:ae9:f40b:: with SMTP id y11mr7974186qkl.378.1580115151552; 
 Mon, 27 Jan 2020 00:52:31 -0800 (PST)
MIME-Version: 1.0
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=h5v5nXBkoxhSx6inU6G59AHca_8_XrkOsX13C7uRU1jA@mail.gmail.com>
In-Reply-To: <CAL1e-=h5v5nXBkoxhSx6inU6G59AHca_8_XrkOsX13C7uRU1jA@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 27 Jan 2020 10:51:47 +0200
Message-ID: <CAK4993jGVGwrvaekXqkr8_n6-PW18J7txdTKwZcwJcLS8+=6OQ@mail.gmail.com>
Subject: Re: [PATCH rc3 02/30] target/avr: Introduce AVR CPU class object
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000500858059d1b3aad"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000500858059d1b3aad
Content-Type: text/plain; charset="UTF-8"

Hi all.

As for now I have no plans to add support for AVR 32 bit CPU. If there are
requests I might consider it.
When I started to implement AVR 8 bit CPU I added that `#ifndef
CONFIG_USER_ONLY` as other CPUs did, so I guess they could be removed.

Regards,
Michael Rolnik

On Mon, Jan 27, 2020 at 4:39 AM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

> > +static void avr_cpu_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +
> > +    cpu_set_cpustate_pointers(cpu);
> > +
> > +#ifndef CONFIG_USER_ONLY
> > +    /* Set the number of interrupts supported by the CPU. */
> > +    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int,
> > +            sizeof(cpu->env.intsrc) * 8);
> > +#endif
> > +}
>
> A question for Michael:
>
> What is CONFIG_USER_ONLY doing here, if we know AVR cores from this
> series doesn't have and will never have user mode, since they do not
> work with the kernel?
>
> Do you plan to support some AVR 32-bit CPUs in the same file, which
> would be able to have linux-user mode? But, in this case, many files
> must be completely redone. My advice is to separate them completely,
> and that this file supports only 8-bit AVR cores, and in that case
> checks for CONFIG_USER_ONLY do not make sense.
>
> Regards,
> Aleksandar
>
> > +
> > +static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
> > +{
> > +    ObjectClass *oc;
> > +
> > +    oc = object_class_by_name(cpu_model);
> > +    if (object_class_dynamic_cast(oc, TYPE_AVR_CPU) == NULL ||
> > +        object_class_is_abstract(oc)) {
> > +        oc = NULL;
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
> > +#endif
>
> The same question here.
>
> > +    cc->disas_set_info = avr_cpu_disas_set_info;
> > +    cc->tlb_fill = avr_cpu_tlb_fill;
> > +    cc->tcg_initialize = avr_cpu_tcg_init;
> > +    cc->synchronize_from_tb = avr_cpu_synchronize_from_tb;
> > +}
> > diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> > index d122611..f7a403a 100644
> > --- a/target/avr/cpu.h
> > +++ b/target/avr/cpu.h
> > @@ -69,4 +69,138 @@
> >
> >  #define EF_AVR_MACH 0x7F
> >
> > +typedef struct CPUAVRState CPUAVRState;
> > +
> > +struct CPUAVRState {
> > +    uint32_t pc_w; /* 0x003fffff up to 22 bits */
> > +
> > +    uint32_t sregC; /* 0x00000001 1 bit */
> > +    uint32_t sregZ; /* 0x00000001 1 bit */
> > +    uint32_t sregN; /* 0x00000001 1 bit */
> > +    uint32_t sregV; /* 0x00000001 1 bit */
> > +    uint32_t sregS; /* 0x00000001 1 bit */
> > +    uint32_t sregH; /* 0x00000001 1 bit */
> > +    uint32_t sregT; /* 0x00000001 1 bit */
> > +    uint32_t sregI; /* 0x00000001 1 bit */
> > +
> > +    uint32_t rampD; /* 0x00ff0000 8 bits */
> > +    uint32_t rampX; /* 0x00ff0000 8 bits */
> > +    uint32_t rampY; /* 0x00ff0000 8 bits */
> > +    uint32_t rampZ; /* 0x00ff0000 8 bits */
> > +    uint32_t eind; /* 0x00ff0000 8 bits */
> > +
> > +    uint32_t r[NUMBER_OF_CPU_REGISTERS]; /* 8 bits each */
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
> > +void avr_cpu_do_interrupt(CPUState *cpu);
> > +bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
> > +hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
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
> > +    sreg = (env->sregC) << 0
> > +         | (env->sregZ) << 1
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
> > +    env->sregZ = (sreg >> 1) & 0x01;
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
> > +const char *avr_flags_to_cpu_type(uint32_t flags, const char
> *def_cpu_type);
> > +
> >  #endif /* !defined (QEMU_AVR_CPU_H) */
> > --
> > 2.7.4
> >
>


-- 
Best Regards,
Michael Rolnik

--000000000000500858059d1b3aad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all.<div><br></div><div>As for now I have no plans to a=
dd support for AVR 32 bit CPU. If there are requests I might consider it.</=
div><div>When I started to implement AVR 8 bit CPU I added that `#ifndef CO=
NFIG_USER_ONLY` as other CPUs did, so I guess they could be removed.</div><=
div><br></div><div>Regards,</div><div>Michael Rolnik</div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 27, 2=
020 at 4:39 AM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@=
gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">&gt; +static void avr_cpu_initfn(Obje=
ct *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu_set_cpustate_pointers(cpu);<br>
&gt; +<br>
&gt; +#ifndef CONFIG_USER_ONLY<br>
&gt; +=C2=A0 =C2=A0 /* Set the number of interrupts supported by the CPU. *=
/<br>
&gt; +=C2=A0 =C2=A0 qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(cpu-&gt;env.intsrc) =
* 8);<br>
&gt; +#endif<br>
&gt; +}<br>
<br>
A question for Michael:<br>
<br>
What is CONFIG_USER_ONLY doing here, if we know AVR cores from this<br>
series doesn&#39;t have and will never have user mode, since they do not<br=
>
work with the kernel?<br>
<br>
Do you plan to support some AVR 32-bit CPUs in the same file, which<br>
would be able to have linux-user mode? But, in this case, many files<br>
must be completely redone. My advice is to separate them completely,<br>
and that this file supports only 8-bit AVR cores, and in that case<br>
checks for CONFIG_USER_ONLY do not make sense.<br>
<br>
Regards,<br>
Aleksandar<br>
<br>
&gt; +<br>
&gt; +static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 ObjectClass *oc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 oc =3D object_class_by_name(cpu_model);<br>
&gt; +=C2=A0 =C2=A0 if (object_class_dynamic_cast(oc, TYPE_AVR_CPU) =3D=3D =
NULL ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_class_is_abstract(oc)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 oc =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return oc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;PC:=C2=A0 =C2=A0 %06x\n&quot;, en=
v-&gt;pc_w);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;SP:=C2=A0 =C2=A0 =C2=A0 %04x\n&qu=
ot;, env-&gt;sp);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;rampD:=C2=A0 =C2=A0 =C2=A0%02x\n&=
quot;, env-&gt;rampD &gt;&gt; 16);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;rampX:=C2=A0 =C2=A0 =C2=A0%02x\n&=
quot;, env-&gt;rampX &gt;&gt; 16);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;rampY:=C2=A0 =C2=A0 =C2=A0%02x\n&=
quot;, env-&gt;rampY &gt;&gt; 16);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;rampZ:=C2=A0 =C2=A0 =C2=A0%02x\n&=
quot;, env-&gt;rampZ &gt;&gt; 16);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;EIND:=C2=A0 =C2=A0 =C2=A0 %02x\n&=
quot;, env-&gt;eind &gt;&gt; 16);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;X:=C2=A0 =C2=A0 =C2=A0 =C2=A0%02x=
%02x\n&quot;, env-&gt;r[27], env-&gt;r[26]);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;Y:=C2=A0 =C2=A0 =C2=A0 =C2=A0%02x=
%02x\n&quot;, env-&gt;r[29], env-&gt;r[28]);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;Z:=C2=A0 =C2=A0 =C2=A0 =C2=A0%02x=
%02x\n&quot;, env-&gt;r[31], env-&gt;r[30]);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;SREG:=C2=A0 =C2=A0 [ %c %c %c %c =
%c %c %c %c ]\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregI ? &#39;I&#39; : &#39;-&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregT ? &#39;T&#39; : &#39;-&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregH ? &#39;H&#39; : &#39;-&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregS ? &#39;S&#39; : &#39;-&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregV ? &#39;V&#39; : &#39;-&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregN ? &#39;-&#39; : &#39;N&#39;, /* Zf has negativ=
e logic */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregZ ? &#39;Z&#39; : &#39;-&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;sregC ? &#39;I&#39; : &#39;-&#39;);<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;SKIP:=C2=A0 =C2=A0 %02x\n&quot;, =
env-&gt;skip);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(env-&gt;r); i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot;R[%02d]:=C2=A0 %02x=
=C2=A0 =C2=A0&quot;, i, env-&gt;r[i]);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i % 8) =3D=3D 7) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&qu=
ot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&quot;);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void avr_cpu_class_init(ObjectClass *oc, void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
&gt; +=C2=A0 =C2=A0 CPUClass *cc =3D CPU_CLASS(oc);<br>
&gt; +=C2=A0 =C2=A0 AVRCPUClass *mcc =3D AVR_CPU_CLASS(oc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mcc-&gt;parent_realize =3D dc-&gt;realize;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D avr_cpu_realizefn;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mcc-&gt;parent_reset =3D cc-&gt;reset;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;reset =3D avr_cpu_reset;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;class_by_name =3D avr_cpu_class_by_name;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;has_work =3D avr_cpu_has_work;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;do_interrupt =3D avr_cpu_do_interrupt;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;cpu_exec_interrupt =3D avr_cpu_exec_interrupt;<b=
r>
&gt; +=C2=A0 =C2=A0 cc-&gt;dump_state =3D avr_cpu_dump_state;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;set_pc =3D avr_cpu_set_pc;<br>
&gt; +#if !defined(CONFIG_USER_ONLY)<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;memory_rw_debug =3D avr_cpu_memory_rw_debug;<br>
&gt; +#endif<br>
&gt; +#ifdef CONFIG_USER_ONLY<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;handle_mmu_fault =3D avr_cpu_handle_mmu_fault;<b=
r>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;get_phys_page_debug =3D avr_cpu_get_phys_page_de=
bug;<br>
&gt; +#endif<br>
<br>
The same question here.<br>
<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;disas_set_info =3D avr_cpu_disas_set_info;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;tlb_fill =3D avr_cpu_tlb_fill;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;tcg_initialize =3D avr_cpu_tcg_init;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;synchronize_from_tb =3D avr_cpu_synchronize_from=
_tb;<br>
&gt; +}<br>
&gt; diff --git a/target/avr/cpu.h b/target/avr/cpu.h<br>
&gt; index d122611..f7a403a 100644<br>
&gt; --- a/target/avr/cpu.h<br>
&gt; +++ b/target/avr/cpu.h<br>
&gt; @@ -69,4 +69,138 @@<br>
&gt;<br>
&gt;=C2=A0 #define EF_AVR_MACH 0x7F<br>
&gt;<br>
&gt; +typedef struct CPUAVRState CPUAVRState;<br>
&gt; +<br>
&gt; +struct CPUAVRState {<br>
&gt; +=C2=A0 =C2=A0 uint32_t pc_w; /* 0x003fffff up to 22 bits */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregC; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregZ; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregN; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregV; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregS; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregH; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregT; /* 0x00000001 1 bit */<br>
&gt; +=C2=A0 =C2=A0 uint32_t sregI; /* 0x00000001 1 bit */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t rampD; /* 0x00ff0000 8 bits */<br>
&gt; +=C2=A0 =C2=A0 uint32_t rampX; /* 0x00ff0000 8 bits */<br>
&gt; +=C2=A0 =C2=A0 uint32_t rampY; /* 0x00ff0000 8 bits */<br>
&gt; +=C2=A0 =C2=A0 uint32_t rampZ; /* 0x00ff0000 8 bits */<br>
&gt; +=C2=A0 =C2=A0 uint32_t eind; /* 0x00ff0000 8 bits */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t r[NUMBER_OF_CPU_REGISTERS]; /* 8 bits each */<=
br>
&gt; +=C2=A0 =C2=A0 uint32_t sp; /* 16 bits */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t skip; /* if set skip instruction */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint64_t intsrc; /* interrupt sources */<br>
&gt; +=C2=A0 =C2=A0 bool fullacc; /* CPU/MEM if true MEM only otherwise */<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t features;<br>
&gt; +};<br>
&gt; +<br>
&gt; +/**<br>
&gt; + *=C2=A0 AVRCPU:<br>
&gt; + *=C2=A0 @env: #CPUAVRState<br>
&gt; + *<br>
&gt; + *=C2=A0 A AVR CPU.<br>
&gt; + */<br>
&gt; +typedef struct AVRCPU {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 CPUState parent_obj;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 CPUNegativeOffsetState neg;<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState env;<br>
&gt; +} AVRCPU;<br>
&gt; +<br>
&gt; +void avr_cpu_do_interrupt(CPUState *cpu);<br>
&gt; +bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);<br>
&gt; +hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);<br>
&gt; +<br>
&gt; +#define cpu_list avr_cpu_list<br>
&gt; +#define cpu_signal_handler cpu_avr_signal_handler<br>
&gt; +#define cpu_mmu_index avr_cpu_mmu_index<br>
&gt; +<br>
&gt; +static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void avr_cpu_tcg_init(void);<br>
&gt; +<br>
&gt; +void avr_cpu_list(void);<br>
&gt; +int cpu_avr_exec(CPUState *cpu);<br>
&gt; +int cpu_avr_signal_handler(int host_signum, void *pinfo, void *puc);<=
br>
&gt; +int avr_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int rw, int mmu_idx);<br>
&gt; +int avr_cpu_memory_rw_debug(CPUState *cs, vaddr address, uint8_t *buf=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int len, bool is_write);<br>
&gt; +<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 TB_FLAGS_FULL_ACCESS =3D 1,<br>
&gt; +=C2=A0 =C2=A0 TB_FLAGS_SKIP =3D 2,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulon=
g *pc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong *cs_base, uint32_t =
*pflags)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t flags =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 *pc =3D env-&gt;pc_w * 2;<br>
&gt; +=C2=A0 =C2=A0 *cs_base =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (env-&gt;fullacc) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D TB_FLAGS_FULL_ACCESS;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (env-&gt;skip) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D TB_FLAGS_SKIP;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 *pflags =3D flags;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline int cpu_interrupts_enabled(CPUAVRState *env)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return env-&gt;sregI !=3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline uint8_t cpu_get_sreg(CPUAVRState *env)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint8_t sreg;<br>
&gt; +=C2=A0 =C2=A0 sreg =3D (env-&gt;sregC) &lt;&lt; 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregZ) &lt;&lt; 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregN) &lt;&lt; 2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregV) &lt;&lt; 3<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregS) &lt;&lt; 4<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregH) &lt;&lt; 5<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregT) &lt;&lt; 6<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (env-&gt;sregI) &lt;&lt; 7;<br>
&gt; +=C2=A0 =C2=A0 return sreg;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregC =3D (sreg &gt;&gt; 0) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregZ =3D (sreg &gt;&gt; 1) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregN =3D (sreg &gt;&gt; 2) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregV =3D (sreg &gt;&gt; 3) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregS =3D (sreg &gt;&gt; 4) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregH =3D (sreg &gt;&gt; 5) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregT =3D (sreg &gt;&gt; 6) &amp; 0x01;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregI =3D (sreg &gt;&gt; 7) &amp; 0x01;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 MMUAccessType access_type, int mmu_idx,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 bool probe, uintptr_t retaddr);<br>
&gt; +<br>
&gt; +typedef CPUAVRState CPUArchState;<br>
&gt; +typedef AVRCPU ArchCPU;<br>
&gt; +<br>
&gt; +#include &quot;exec/cpu-all.h&quot;<br>
&gt; +<br>
&gt; +const char *avr_flags_to_cpu_type(uint32_t flags, const char *def_cpu=
_type);<br>
&gt; +<br>
&gt;=C2=A0 #endif /* !defined (QEMU_AVR_CPU_H) */<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000500858059d1b3aad--

