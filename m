Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFE2C35240
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 02:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077E22071E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 02:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KglwsID0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077E22071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivuJy-0002rd-63
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 21:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivuJO-0002QD-9i
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 21:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivuJM-0004rX-TD
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 21:39:38 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ivuJM-0004qX-Lp
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 21:39:36 -0500
Received: by mail-oi1-x244.google.com with SMTP id d62so5295990oia.11
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2020 18:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O6vd8VesyZ9MxGaX7dCjOSk7sk5X5pEY89JnMxMy1MM=;
 b=KglwsID02UHwpUWhmRKjYYQCVAPggsioOF+2TPBcESHuvCO8OoIRfqmuS0LlFCt6IE
 bg55ICsFWhn9Pm60nsEsCr0m05AJtr7KqW8YuqMOsEovi49FrDikImxA8oKuEr3uMAlk
 CZDtZ6Wcdg65KXu72OxXL8E0zKaErnimM/t/DW6hEKXvwFzh8e579T4YXYbtNLdW7uvs
 RfVwRveALcrILnX1Z8EN88HgGMWak6kHDYxY0Tx2yNZeuDSl4bL7+Vw+00DRbpxGhXu7
 S9uzblQsfbf0Hrur6etePxkPq1+RTk+jFEWRmjZGF4gywKo/u760PKwIsdi517ptB73W
 +tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O6vd8VesyZ9MxGaX7dCjOSk7sk5X5pEY89JnMxMy1MM=;
 b=Zn2L9G7dHuw/QTrtOX9bGT1eWUn7RamEAVYvh/t6bn/XCTfNXRKX4LmO6v8v9KMGO2
 rINlKYlSfvN18d2VBpH/IXOWMPiQArXohjjHP5Ey0Req4R9DGvqckIYUjvB/aYUaZBoL
 4TfiLx3Zgwiet7XcqtECxuGFShKq0NDtnuGNblgatnjP4CAgTon0oB+6NM8xXYrEYty1
 jFg2epK+qKvNzGqg3Pu2U7cWMRJ1Jr489cLNNheNy2R8XRRGWnS59ACl3t9MyFk/SoUH
 IteEV7n4ZMPKuDIsj1KbMeETeEFYidDm/jaS3jsnMoR6o7bG9GncseqmEGlylZY2ajnj
 Rbyg==
X-Gm-Message-State: APjAAAUy8gNoSBPAmI0ywwC7dRO+fiBLfOe9m2JWCqlu4GnRhfMRRqoA
 OGrzp7VeXJokD+0baCFyS+WRmeguHtxJfnMYWIQ=
X-Google-Smtp-Source: APXvYqzEW1L0iV7TS0a3+PHDNlkK8g0lKPqBxN5AX11SQAkUEbvfHr/WbmIVpT1Uyq2IhsWnjE82QOAyX0zYFCvf/NE=
X-Received: by 2002:a05:6808:3ba:: with SMTP id
 n26mr4608944oie.62.1580092775176; 
 Sun, 26 Jan 2020 18:39:35 -0800 (PST)
MIME-Version: 1.0
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1580079311-20447-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 27 Jan 2020 03:39:24 +0100
Message-ID: <CAL1e-=h5v5nXBkoxhSx6inU6G59AHca_8_XrkOsX13C7uRU1jA@mail.gmail.com>
Subject: Re: [PATCH rc3 02/30] target/avr: Introduce AVR CPU class object
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> +static void avr_cpu_initfn(Object *obj)
> +{
> +    AVRCPU *cpu = AVR_CPU(obj);
> +
> +    cpu_set_cpustate_pointers(cpu);
> +
> +#ifndef CONFIG_USER_ONLY
> +    /* Set the number of interrupts supported by the CPU. */
> +    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int,
> +            sizeof(cpu->env.intsrc) * 8);
> +#endif
> +}

A question for Michael:

What is CONFIG_USER_ONLY doing here, if we know AVR cores from this
series doesn't have and will never have user mode, since they do not
work with the kernel?

Do you plan to support some AVR 32-bit CPUs in the same file, which
would be able to have linux-user mode? But, in this case, many files
must be completely redone. My advice is to separate them completely,
and that this file supports only 8-bit AVR cores, and in that case
checks for CONFIG_USER_ONLY do not make sense.

Regards,
Aleksandar

> +
> +static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
> +{
> +    ObjectClass *oc;
> +
> +    oc = object_class_by_name(cpu_model);
> +    if (object_class_dynamic_cast(oc, TYPE_AVR_CPU) == NULL ||
> +        object_class_is_abstract(oc)) {
> +        oc = NULL;
> +    }
> +    return oc;
> +}
> +
> +static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> +{
> +    AVRCPU *cpu = AVR_CPU(cs);
> +    CPUAVRState *env = &cpu->env;
> +    int i;
> +
> +    qemu_fprintf(f, "\n");
> +    qemu_fprintf(f, "PC:    %06x\n", env->pc_w);
> +    qemu_fprintf(f, "SP:      %04x\n", env->sp);
> +    qemu_fprintf(f, "rampD:     %02x\n", env->rampD >> 16);
> +    qemu_fprintf(f, "rampX:     %02x\n", env->rampX >> 16);
> +    qemu_fprintf(f, "rampY:     %02x\n", env->rampY >> 16);
> +    qemu_fprintf(f, "rampZ:     %02x\n", env->rampZ >> 16);
> +    qemu_fprintf(f, "EIND:      %02x\n", env->eind >> 16);
> +    qemu_fprintf(f, "X:       %02x%02x\n", env->r[27], env->r[26]);
> +    qemu_fprintf(f, "Y:       %02x%02x\n", env->r[29], env->r[28]);
> +    qemu_fprintf(f, "Z:       %02x%02x\n", env->r[31], env->r[30]);
> +    qemu_fprintf(f, "SREG:    [ %c %c %c %c %c %c %c %c ]\n",
> +                        env->sregI ? 'I' : '-',
> +                        env->sregT ? 'T' : '-',
> +                        env->sregH ? 'H' : '-',
> +                        env->sregS ? 'S' : '-',
> +                        env->sregV ? 'V' : '-',
> +                        env->sregN ? '-' : 'N', /* Zf has negative logic */
> +                        env->sregZ ? 'Z' : '-',
> +                        env->sregC ? 'I' : '-');
> +    qemu_fprintf(f, "SKIP:    %02x\n", env->skip);
> +
> +    qemu_fprintf(f, "\n");
> +    for (i = 0; i < ARRAY_SIZE(env->r); i++) {
> +        qemu_fprintf(f, "R[%02d]:  %02x   ", i, env->r[i]);
> +
> +        if ((i % 8) == 7) {
> +            qemu_fprintf(f, "\n");
> +        }
> +    }
> +    qemu_fprintf(f, "\n");
> +}
> +
> +static void avr_cpu_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    CPUClass *cc = CPU_CLASS(oc);
> +    AVRCPUClass *mcc = AVR_CPU_CLASS(oc);
> +
> +    mcc->parent_realize = dc->realize;
> +    dc->realize = avr_cpu_realizefn;
> +
> +    mcc->parent_reset = cc->reset;
> +    cc->reset = avr_cpu_reset;
> +
> +    cc->class_by_name = avr_cpu_class_by_name;
> +
> +    cc->has_work = avr_cpu_has_work;
> +    cc->do_interrupt = avr_cpu_do_interrupt;
> +    cc->cpu_exec_interrupt = avr_cpu_exec_interrupt;
> +    cc->dump_state = avr_cpu_dump_state;
> +    cc->set_pc = avr_cpu_set_pc;
> +#if !defined(CONFIG_USER_ONLY)
> +    cc->memory_rw_debug = avr_cpu_memory_rw_debug;
> +#endif
> +#ifdef CONFIG_USER_ONLY
> +    cc->handle_mmu_fault = avr_cpu_handle_mmu_fault;
> +#else
> +    cc->get_phys_page_debug = avr_cpu_get_phys_page_debug;
> +#endif

The same question here.

> +    cc->disas_set_info = avr_cpu_disas_set_info;
> +    cc->tlb_fill = avr_cpu_tlb_fill;
> +    cc->tcg_initialize = avr_cpu_tcg_init;
> +    cc->synchronize_from_tb = avr_cpu_synchronize_from_tb;
> +}
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> index d122611..f7a403a 100644
> --- a/target/avr/cpu.h
> +++ b/target/avr/cpu.h
> @@ -69,4 +69,138 @@
>
>  #define EF_AVR_MACH 0x7F
>
> +typedef struct CPUAVRState CPUAVRState;
> +
> +struct CPUAVRState {
> +    uint32_t pc_w; /* 0x003fffff up to 22 bits */
> +
> +    uint32_t sregC; /* 0x00000001 1 bit */
> +    uint32_t sregZ; /* 0x00000001 1 bit */
> +    uint32_t sregN; /* 0x00000001 1 bit */
> +    uint32_t sregV; /* 0x00000001 1 bit */
> +    uint32_t sregS; /* 0x00000001 1 bit */
> +    uint32_t sregH; /* 0x00000001 1 bit */
> +    uint32_t sregT; /* 0x00000001 1 bit */
> +    uint32_t sregI; /* 0x00000001 1 bit */
> +
> +    uint32_t rampD; /* 0x00ff0000 8 bits */
> +    uint32_t rampX; /* 0x00ff0000 8 bits */
> +    uint32_t rampY; /* 0x00ff0000 8 bits */
> +    uint32_t rampZ; /* 0x00ff0000 8 bits */
> +    uint32_t eind; /* 0x00ff0000 8 bits */
> +
> +    uint32_t r[NUMBER_OF_CPU_REGISTERS]; /* 8 bits each */
> +    uint32_t sp; /* 16 bits */
> +
> +    uint32_t skip; /* if set skip instruction */
> +
> +    uint64_t intsrc; /* interrupt sources */
> +    bool fullacc; /* CPU/MEM if true MEM only otherwise */
> +
> +    uint32_t features;
> +};
> +
> +/**
> + *  AVRCPU:
> + *  @env: #CPUAVRState
> + *
> + *  A AVR CPU.
> + */
> +typedef struct AVRCPU {
> +    /*< private >*/
> +    CPUState parent_obj;
> +    /*< public >*/
> +
> +    CPUNegativeOffsetState neg;
> +    CPUAVRState env;
> +} AVRCPU;
> +
> +void avr_cpu_do_interrupt(CPUState *cpu);
> +bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
> +hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +
> +#define cpu_list avr_cpu_list
> +#define cpu_signal_handler cpu_avr_signal_handler
> +#define cpu_mmu_index avr_cpu_mmu_index
> +
> +static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)
> +{
> +    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
> +}
> +
> +void avr_cpu_tcg_init(void);
> +
> +void avr_cpu_list(void);
> +int cpu_avr_exec(CPUState *cpu);
> +int cpu_avr_signal_handler(int host_signum, void *pinfo, void *puc);
> +int avr_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
> +                                int rw, int mmu_idx);
> +int avr_cpu_memory_rw_debug(CPUState *cs, vaddr address, uint8_t *buf,
> +                                int len, bool is_write);
> +
> +enum {
> +    TB_FLAGS_FULL_ACCESS = 1,
> +    TB_FLAGS_SKIP = 2,
> +};
> +
> +static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulong *pc,
> +                                target_ulong *cs_base, uint32_t *pflags)
> +{
> +    uint32_t flags = 0;
> +
> +    *pc = env->pc_w * 2;
> +    *cs_base = 0;
> +
> +    if (env->fullacc) {
> +        flags |= TB_FLAGS_FULL_ACCESS;
> +    }
> +    if (env->skip) {
> +        flags |= TB_FLAGS_SKIP;
> +    }
> +
> +    *pflags = flags;
> +}
> +
> +static inline int cpu_interrupts_enabled(CPUAVRState *env)
> +{
> +    return env->sregI != 0;
> +}
> +
> +static inline uint8_t cpu_get_sreg(CPUAVRState *env)
> +{
> +    uint8_t sreg;
> +    sreg = (env->sregC) << 0
> +         | (env->sregZ) << 1
> +         | (env->sregN) << 2
> +         | (env->sregV) << 3
> +         | (env->sregS) << 4
> +         | (env->sregH) << 5
> +         | (env->sregT) << 6
> +         | (env->sregI) << 7;
> +    return sreg;
> +}
> +
> +static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
> +{
> +    env->sregC = (sreg >> 0) & 0x01;
> +    env->sregZ = (sreg >> 1) & 0x01;
> +    env->sregN = (sreg >> 2) & 0x01;
> +    env->sregV = (sreg >> 3) & 0x01;
> +    env->sregS = (sreg >> 4) & 0x01;
> +    env->sregH = (sreg >> 5) & 0x01;
> +    env->sregT = (sreg >> 6) & 0x01;
> +    env->sregI = (sreg >> 7) & 0x01;
> +}
> +
> +bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                        MMUAccessType access_type, int mmu_idx,
> +                        bool probe, uintptr_t retaddr);
> +
> +typedef CPUAVRState CPUArchState;
> +typedef AVRCPU ArchCPU;
> +
> +#include "exec/cpu-all.h"
> +
> +const char *avr_flags_to_cpu_type(uint32_t flags, const char *def_cpu_type);
> +
>  #endif /* !defined (QEMU_AVR_CPU_H) */
> --
> 2.7.4
>

