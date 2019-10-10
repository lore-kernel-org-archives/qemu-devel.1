Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBADC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A2D2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A2D2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIbJx-0001wS-5l
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIaut-0007wf-HG
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIauq-0002Mw-Fs
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:03:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIauq-0002Jc-5q
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:03:48 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0823C01092E
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 16:03:46 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id s25so1970779wmh.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8yxk1vuNcOlfbFxw2gA+RQh0zRUxp/VA1GlW4UT9EfY=;
 b=CqgDP7AF5DiO88TtLmqBzJO9qhmXcCNIVUYmIZRamoH1aHsDR61Y0j/OSRbrNkmM/g
 2nV+5dWEZDDzbw7acBwEl5B84AJzZ7zI+hS0x2zqrzD+QkSGKnlf8i6hjEOQ4Vww+JBn
 3yLYGnpBBIXFkscH8lY1UZ4LGtF/L8wpmCa1N6cImrgaQnEt5xPpQzXzzwQ5Ms/V7T5A
 9EgCzFvqtVHhM2+LVc/8T0CVgPSZb2LbpryYpYTR3JZMAyv60/S4uExccC99FDWT9YEo
 17y28hDCRgxsoOVM4b3mC7RBj2xWtZ303EbNGMlRabX4Fz4bXoZ+lvL7w3amob5EWwJN
 Uivg==
X-Gm-Message-State: APjAAAVdjwFGupHKU7QTVe3jYm3dGlGDQU+NJbmIiYxw9jaqgw2E49Up
 pHGmqKyx8nwgfAbF7IZ4sznuPAZVLvw/4qmanqboZlPkoUA4GvHA3soOhH013QE94du/Y4v1pxU
 YZaK4R0aqjzXrmXE=
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr8831279wmc.150.1570723425483; 
 Thu, 10 Oct 2019 09:03:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5cf0oOQhxJfR33bsQpHAOGw6MlfxTchax0+zQ0pKjRhg7u5MiwWYutzCtoB9DX9VYah25aA==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr8831229wmc.150.1570723425042; 
 Thu, 10 Oct 2019 09:03:45 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id 90sm8270306wrr.1.2019.10.10.09.03.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 09:03:44 -0700 (PDT)
Subject: Re: [PATCH v25 06/22] target/rx: CPU definition
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190927062302.110144-1-ysato@users.sourceforge.jp>
 <20190927062302.110144-7-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2f11bbd6-9b3a-7749-ab0b-8d36dc15e27b@redhat.com>
Date: Thu, 10 Oct 2019 18:03:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927062302.110144-7-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 8:22 AM, Yoshinori Sato wrote:
> v21 changes
> Add cpu-param.h
> Remove CPU_COMMON
> rx_load_image move to rx-virt.
> remove rx_load_image

^ We can strip these lines, which are specific to a patchset version.

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>=20
> Message-Id: <20190616142836.10614-4-ysato@users.sourceforge.jp>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20190607091116.49044-4-ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [PMD: Use newer QOM style, split cpu-qom.h, restrict access to
>   extable array, use rx_cpu_tlb_fill() extracted from patch of
>   Yoshinori Sato 'Convert to CPUClass::tlb_fill']
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   target/rx/cpu-param.h   |  31 ++++++
>   target/rx/cpu-qom.h     |  42 ++++++++
>   target/rx/cpu.h         | 181 +++++++++++++++++++++++++++++++++
>   target/rx/cpu.c         | 217 +++++++++++++++++++++++++++++++++++++++=
+
>   target/rx/gdbstub.c     | 112 +++++++++++++++++++++
>   target/rx/Makefile.objs |   1 -
>   6 files changed, 583 insertions(+), 1 deletion(-)
>   create mode 100644 target/rx/cpu-param.h
>   create mode 100644 target/rx/cpu-qom.h
>   create mode 100644 target/rx/cpu.h
>   create mode 100644 target/rx/cpu.c
>   create mode 100644 target/rx/gdbstub.c
>=20
> diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
> new file mode 100644
> index 0000000000..5da87fbebe
> --- /dev/null
> +++ b/target/rx/cpu-param.h
> @@ -0,0 +1,31 @@
> +/*
> + *  RX cpu parameters
> + *
> + *  Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITH=
OUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License a=
long with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef RX_CPU_PARAM_H
> +#define RX_CPU_PARAM_H
> +
> +#define TARGET_LONG_BITS 32
> +#define TARGET_PAGE_BITS 12
> +
> +#define TARGET_PHYS_ADDR_SPACE_BITS 32
> +#define TARGET_VIRT_ADDR_SPACE_BITS 32
> +
> +#define NB_MMU_MODES 1
> +#define MMU_MODE0_SUFFIX _all
> +
> +#endif
> diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h
> new file mode 100644
> index 0000000000..8328900f3f
> --- /dev/null
> +++ b/target/rx/cpu-qom.h
> @@ -0,0 +1,42 @@
> +#ifndef QEMU_RX_CPU_QOM_H
> +#define QEMU_RX_CPU_QOM_H
> +
> +#include "hw/core/cpu.h"
> +/*
> + * RX CPU
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + * SPDX-License-Identifier: LGPL-2.0+
> + */
> +
> +#define TYPE_RX_CPU "rx-cpu"
> +
> +#define TYPE_RX62N_CPU RX_CPU_TYPE_NAME("rx62n")
> +
> +#define RXCPU_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RX_CPU)
> +#define RXCPU(obj) \
> +    OBJECT_CHECK(RXCPU, (obj), TYPE_RX_CPU)
> +#define RXCPU_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RX_CPU)
> +
> +/*
> + * RXCPUClass:
> + * @parent_realize: The parent class' realize handler.
> + * @parent_reset: The parent class' reset handler.
> + *
> + * A RX CPU model.
> + */
> +typedef struct RXCPUClass {
> +    /*< private >*/
> +    CPUClass parent_class;
> +    /*< public >*/
> +
> +    DeviceRealize parent_realize;
> +    void (*parent_reset)(CPUState *cpu);
> +
> +} RXCPUClass;
> +
> +#define CPUArchState struct CPURXState
> +
> +#endif
> diff --git a/target/rx/cpu.h b/target/rx/cpu.h
> new file mode 100644
> index 0000000000..2d1eb7665c
> --- /dev/null
> +++ b/target/rx/cpu.h
> @@ -0,0 +1,181 @@
> +/*
> + *  RX emulation definition
> + *
> + *  Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITH=
OUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License a=
long with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef RX_CPU_H
> +#define RX_CPU_H
> +
> +#include "qemu/bitops.h"
> +#include "qemu-common.h"
> +#include "hw/registerfields.h"
> +#include "cpu-qom.h"
> +
> +#include "exec/cpu-defs.h"
> +
> +/* PSW define */
> +REG32(PSW, 0)
> +FIELD(PSW, C, 0, 1)
> +FIELD(PSW, Z, 1, 1)
> +FIELD(PSW, S, 2, 1)
> +FIELD(PSW, O, 3, 1)
> +FIELD(PSW, I, 16, 1)
> +FIELD(PSW, U, 17, 1)
> +FIELD(PSW, PM, 20, 1)
> +FIELD(PSW, IPL, 24, 4)
> +
> +/* FPSW define */
> +REG32(FPSW, 0)
> +FIELD(FPSW, RM, 0, 2)
> +FIELD(FPSW, CV, 2, 1)
> +FIELD(FPSW, CO, 3, 1)
> +FIELD(FPSW, CZ, 4, 1)
> +FIELD(FPSW, CU, 5, 1)
> +FIELD(FPSW, CX, 6, 1)
> +FIELD(FPSW, CE, 7, 1)
> +FIELD(FPSW, CAUSE, 2, 6)
> +FIELD(FPSW, DN, 8, 1)
> +FIELD(FPSW, EV, 10, 1)
> +FIELD(FPSW, EO, 11, 1)
> +FIELD(FPSW, EZ, 12, 1)
> +FIELD(FPSW, EU, 13, 1)
> +FIELD(FPSW, EX, 14, 1)
> +FIELD(FPSW, ENABLE, 10, 5)
> +FIELD(FPSW, FV, 26, 1)
> +FIELD(FPSW, FO, 27, 1)
> +FIELD(FPSW, FZ, 28, 1)
> +FIELD(FPSW, FU, 29, 1)
> +FIELD(FPSW, FX, 30, 1)
> +FIELD(FPSW, FLAGS, 26, 4)
> +FIELD(FPSW, FS, 31, 1)
> +
> +enum {
> +    NUM_REGS =3D 16,
> +};
> +
> +typedef struct CPURXState {
> +    /* CPU registers */
> +    uint32_t regs[NUM_REGS];    /* general registers */
> +    uint32_t psw_o;             /* O bit of status register */
> +    uint32_t psw_s;             /* S bit of status register */
> +    uint32_t psw_z;             /* Z bit of status register */
> +    uint32_t psw_c;             /* C bit of status register */
> +    uint32_t psw_u;
> +    uint32_t psw_i;
> +    uint32_t psw_pm;
> +    uint32_t psw_ipl;
> +    uint32_t bpsw;              /* backup status */
> +    uint32_t bpc;               /* backup pc */
> +    uint32_t isp;               /* global base register */
> +    uint32_t usp;               /* vector base register */
> +    uint32_t pc;                /* program counter */
> +    uint32_t intb;              /* interrupt vector */
> +    uint32_t fintv;
> +    uint32_t fpsw;
> +    uint64_t acc;
> +
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
> +    /* Internal use */
> +    uint32_t in_sleep;
> +    uint32_t req_irq;           /* Requested interrupt no (hard) */
> +    uint32_t req_ipl;           /* Requested interrupt level */
> +    uint32_t ack_irq;           /* execute irq */
> +    uint32_t ack_ipl;           /* execute ipl */
> +    float_status fp_status;
> +    qemu_irq ack;               /* Interrupt acknowledge */
> +} CPURXState;
> +
> +/*
> + * RXCPU:
> + * @env: #CPURXState
> + *
> + * A RX CPU
> + */
> +struct RXCPU {
> +    /*< private >*/
> +    CPUState parent_obj;
> +    /*< public >*/
> +
> +    CPUNegativeOffsetState neg;
> +    CPURXState env;
> +};
> +
> +typedef struct RXCPU RXCPU;
> +typedef RXCPU ArchCPU;
> +
> +#define ENV_OFFSET offsetof(RXCPU, env)
> +
> +#define RX_CPU_TYPE_SUFFIX "-" TYPE_RX_CPU
> +#define RX_CPU_TYPE_NAME(model) model RX_CPU_TYPE_SUFFIX
> +#define CPU_RESOLVING_TYPE TYPE_RX_CPU
> +
> +extern const char rx_crname[][6];
> +
> +void rx_cpu_do_interrupt(CPUState *cpu);
> +bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
> +void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> +int rx_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
> +int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +hwaddr rx_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +
> +void rx_translate_init(void);
> +int cpu_rx_signal_handler(int host_signum, void *pinfo,
> +                           void *puc);
> +
> +void rx_cpu_list(void);
> +void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte);
> +
> +#define cpu_signal_handler cpu_rx_signal_handler
> +#define cpu_list rx_cpu_list
> +
> +#include "exec/cpu-all.h"
> +
> +#define CPU_INTERRUPT_SOFT CPU_INTERRUPT_TGT_INT_0
> +#define CPU_INTERRUPT_FIR  CPU_INTERRUPT_TGT_INT_1
> +
> +#define RX_CPU_IRQ 0
> +#define RX_CPU_FIR 1
> +
> +static inline void cpu_get_tb_cpu_state(CPURXState *env, target_ulong =
*pc,
> +                                        target_ulong *cs_base, uint32_=
t *flags)
> +{
> +    *pc =3D env->pc;
> +    *cs_base =3D 0;
> +    *flags =3D FIELD_DP32(0, PSW, PM, env->psw_pm);
> +}
> +
> +static inline int cpu_mmu_index(CPURXState *env, bool ifetch)
> +{
> +    return 0;
> +}
> +
> +static inline uint32_t rx_cpu_pack_psw(CPURXState *env)
> +{
> +    uint32_t psw =3D 0;
> +    psw =3D FIELD_DP32(psw, PSW, IPL, env->psw_ipl);
> +    psw =3D FIELD_DP32(psw, PSW, PM,  env->psw_pm);
> +    psw =3D FIELD_DP32(psw, PSW, U,   env->psw_u);
> +    psw =3D FIELD_DP32(psw, PSW, I,   env->psw_i);
> +    psw =3D FIELD_DP32(psw, PSW, O,   env->psw_o >> 31);
> +    psw =3D FIELD_DP32(psw, PSW, S,   env->psw_s >> 31);
> +    psw =3D FIELD_DP32(psw, PSW, Z,   env->psw_z =3D=3D 0);
> +    psw =3D FIELD_DP32(psw, PSW, C,   env->psw_c);
> +    return psw;
> +}
> +
> +#endif /* RX_CPU_H */
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> new file mode 100644
> index 0000000000..ea38639f47
> --- /dev/null
> +++ b/target/rx/cpu.c
> @@ -0,0 +1,217 @@
> +/*
> + * QEMU RX CPU
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITH=
OUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License a=
long with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/qemu-print.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "qemu-common.h"
> +#include "migration/vmstate.h"
> +#include "exec/exec-all.h"
> +#include "hw/loader.h"
> +#include "fpu/softfloat.h"
> +
> +static void rx_cpu_set_pc(CPUState *cs, vaddr value)
> +{
> +    RXCPU *cpu =3D RXCPU(cs);
> +
> +    cpu->env.pc =3D value;
> +}
> +
> +static void rx_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock =
*tb)
> +{
> +    RXCPU *cpu =3D RXCPU(cs);
> +
> +    cpu->env.pc =3D tb->pc;
> +}
> +
> +static bool rx_cpu_has_work(CPUState *cs)
> +{
> +    return cs->interrupt_request &
> +        (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
> +}
> +
> +static void rx_cpu_reset(CPUState *s)
> +{
> +    RXCPU *cpu =3D RXCPU(s);
> +    RXCPUClass *rcc =3D RXCPU_GET_CLASS(cpu);
> +    CPURXState *env =3D &cpu->env;
> +    uint32_t *resetvec;
> +
> +    rcc->parent_reset(s);
> +
> +    memset(env, 0, offsetof(CPURXState, end_reset_fields));
> +
> +    resetvec =3D rom_ptr(0xfffffffc, 4);
> +    if (resetvec) {
> +        /* In the case of kernel, it is ignored because it is not set.=
 */
> +        env->pc =3D ldl_p(resetvec);
> +    }
> +    rx_cpu_unpack_psw(env, 0, 1);
> +    env->regs[0] =3D env->isp =3D env->usp =3D 0;
> +    env->fpsw =3D 0;
> +    set_flush_to_zero(1, &env->fp_status);
> +    set_flush_inputs_to_zero(1, &env->fp_status);
> +}
> +
> +static void rx_cpu_list_entry(gpointer data, gpointer user_data)
> +{
> +    const char *typename =3D object_class_get_name(OBJECT_CLASS(data))=
;
> +
> +    qemu_printf("%s\n", typename);
> +}
> +
> +void rx_cpu_list(void)
> +{
> +    GSList *list;
> +    list =3D object_class_get_list_sorted(TYPE_RX_CPU, false);
> +    g_slist_foreach(list, rx_cpu_list_entry, NULL);
> +    g_slist_free(list);
> +}
> +
> +static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
> +{
> +    ObjectClass *oc;
> +
> +    oc =3D object_class_by_name(cpu_model);
> +    if (object_class_dynamic_cast(oc, TYPE_RX_CPU) =3D=3D NULL ||
> +        object_class_is_abstract(oc)) {
> +        oc =3D NULL;
> +    }
> +
> +    return oc;
> +}
> +
> +static void rx_cpu_realize(DeviceState *dev, Error **errp)
> +{
> +    CPUState *cs =3D CPU(dev);
> +    RXCPUClass *rcc =3D RXCPU_GET_CLASS(dev);
> +    Error *local_err =3D NULL;
> +
> +    cpu_exec_realizefn(cs, &local_err);
> +    if (local_err !=3D NULL) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    cpu_reset(cs);
> +    qemu_init_vcpu(cs);
> +
> +    rcc->parent_realize(dev, errp);
> +}
> +
> +static void rx_cpu_set_irq(void *opaque, int no, int request)
> +{
> +    RXCPU *cpu =3D opaque;
> +    CPUState *cs =3D CPU(cpu);
> +    int irq =3D request & 0xff;
> +
> +    static const int mask[] =3D {
> +        [RX_CPU_IRQ] =3D CPU_INTERRUPT_HARD,
> +        [RX_CPU_FIR] =3D CPU_INTERRUPT_FIR,
> +    };
> +    if (irq) {
> +        cpu->env.req_irq =3D irq;
> +        cpu->env.req_ipl =3D (request >> 8) & 0x0f;
> +        cpu_interrupt(cs, mask[no]);
> +    } else {
> +        cpu_reset_interrupt(cs, mask[no]);
> +    }
> +}
> +
> +static void rx_cpu_disas_set_info(CPUState *cpu, disassemble_info *inf=
o)
> +{
> +    info->mach =3D bfd_mach_rx;
> +    info->print_insn =3D print_insn_rx;
> +}
> +
> +static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
> +                            MMUAccessType access_type, int mmu_idx,
> +                            bool probe, uintptr_t retaddr)
> +{
> +    uint32_t address, physical, prot;
> +
> +    /* Linear mapping */
> +    address =3D physical =3D addr & TARGET_PAGE_MASK;
> +    prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZ=
E);
> +    return true;
> +}
> +
> +static void rx_cpu_init(Object *obj)
> +{
> +    CPUState *cs =3D CPU(obj);
> +    RXCPU *cpu =3D RXCPU(obj);
> +    CPURXState *env =3D &cpu->env;
> +
> +    cpu_set_cpustate_pointers(cpu);
> +    cs->env_ptr =3D env;
> +    qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);
> +}
> +
> +static void rx_cpu_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    CPUClass *cc =3D CPU_CLASS(klass);
> +    RXCPUClass *rcc =3D RXCPU_CLASS(klass);
> +
> +    device_class_set_parent_realize(dc, rx_cpu_realize,
> +                                    &rcc->parent_realize);
> +
> +    rcc->parent_reset =3D cc->reset;
> +    cc->reset =3D rx_cpu_reset;
> +
> +    cc->class_by_name =3D rx_cpu_class_by_name;
> +    cc->has_work =3D rx_cpu_has_work;
> +    cc->do_interrupt =3D rx_cpu_do_interrupt;
> +    cc->cpu_exec_interrupt =3D rx_cpu_exec_interrupt;
> +    cc->dump_state =3D rx_cpu_dump_state;
> +    cc->set_pc =3D rx_cpu_set_pc;
> +    cc->synchronize_from_tb =3D rx_cpu_synchronize_from_tb;
> +    cc->gdb_read_register =3D rx_cpu_gdb_read_register;
> +    cc->gdb_write_register =3D rx_cpu_gdb_write_register;
> +    cc->get_phys_page_debug =3D rx_cpu_get_phys_page_debug;
> +    cc->disas_set_info =3D rx_cpu_disas_set_info;
> +    cc->tcg_initialize =3D rx_translate_init;
> +    cc->tlb_fill =3D rx_cpu_tlb_fill;
> +
> +    cc->gdb_num_core_regs =3D 26;
> +}
> +
> +static const TypeInfo rx_cpu_info =3D {
> +    .name =3D TYPE_RX_CPU,
> +    .parent =3D TYPE_CPU,
> +    .instance_size =3D sizeof(RXCPU),
> +    .instance_init =3D rx_cpu_init,
> +    .abstract =3D true,
> +    .class_size =3D sizeof(RXCPUClass),
> +    .class_init =3D rx_cpu_class_init,
> +};
> +
> +static const TypeInfo rx62n_rx_cpu_info =3D {
> +    .name =3D TYPE_RX62N_CPU,
> +    .parent =3D TYPE_RX_CPU,
> +};
> +
> +static void rx_cpu_register_types(void)
> +{
> +    type_register_static(&rx_cpu_info);
> +    type_register_static(&rx62n_rx_cpu_info);
> +}
> +
> +type_init(rx_cpu_register_types)
> diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
> new file mode 100644
> index 0000000000..d76ca52e82
> --- /dev/null
> +++ b/target/rx/gdbstub.c
> @@ -0,0 +1,112 @@
> +/*
> + * RX gdb server stub
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITH=
OUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License a=
long with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "exec/gdbstub.h"
> +
> +int rx_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    RXCPU *cpu =3D RXCPU(cs);
> +    CPURXState *env =3D &cpu->env;
> +
> +    switch (n) {
> +    case 0 ... 15:
> +        return gdb_get_regl(mem_buf, env->regs[n]);
> +    case 16:
> +        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0] : env=
->usp);
> +    case 17:
> +        return gdb_get_regl(mem_buf, (!env->psw_u) ? env->regs[0] : en=
v->isp);
> +    case 18:
> +        return gdb_get_regl(mem_buf, rx_cpu_pack_psw(env));
> +    case 19:
> +        return gdb_get_regl(mem_buf, env->pc);
> +    case 20:
> +        return gdb_get_regl(mem_buf, env->intb);
> +    case 21:
> +        return gdb_get_regl(mem_buf, env->bpsw);
> +    case 22:
> +        return gdb_get_regl(mem_buf, env->bpc);
> +    case 23:
> +        return gdb_get_regl(mem_buf, env->fintv);
> +    case 24:
> +        return gdb_get_regl(mem_buf, env->fpsw);
> +    case 25:
> +        return 0;
> +    }
> +    return 0;
> +}
> +
> +int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    RXCPU *cpu =3D RXCPU(cs);
> +    CPURXState *env =3D &cpu->env;
> +    uint32_t psw;
> +    switch (n) {
> +    case 0 ... 15:
> +        env->regs[n] =3D ldl_p(mem_buf);
> +        if (n =3D=3D 0) {
> +            if (env->psw_u) {
> +                env->usp =3D env->regs[0];
> +            } else {
> +                env->isp =3D env->regs[0];
> +            }
> +        }
> +        break;
> +    case 16:
> +        env->usp =3D ldl_p(mem_buf);
> +        if (env->psw_u) {
> +            env->regs[0] =3D ldl_p(mem_buf);
> +        }
> +        break;
> +    case 17:
> +        env->isp =3D ldl_p(mem_buf);
> +        if (!env->psw_u) {
> +            env->regs[0] =3D ldl_p(mem_buf);
> +        }
> +        break;
> +    case 18:
> +        psw =3D ldl_p(mem_buf);
> +        rx_cpu_unpack_psw(env, psw, 1);
> +        break;
> +    case 19:
> +        env->pc =3D ldl_p(mem_buf);
> +        break;
> +    case 20:
> +        env->intb =3D ldl_p(mem_buf);
> +        break;
> +    case 21:
> +        env->bpsw =3D ldl_p(mem_buf);
> +        break;
> +    case 22:
> +        env->bpc =3D ldl_p(mem_buf);
> +        break;
> +    case 23:
> +        env->fintv =3D ldl_p(mem_buf);
> +        break;
> +    case 24:
> +        env->fpsw =3D ldl_p(mem_buf);
> +        break;
> +    case 25:
> +        return 8;
> +    default:
> +        return 0;
> +    }
> +
> +    return 4;
> +}
> diff --git a/target/rx/Makefile.objs b/target/rx/Makefile.objs
> index aa6f2d2d6c..a0018d5bc5 100644
> --- a/target/rx/Makefile.objs
> +++ b/target/rx/Makefile.objs
> @@ -1,5 +1,4 @@
>   obj-y +=3D translate.o op_helper.o helper.o cpu.o gdbstub.o disas.o
> -obj-$(CONFIG_SOFTMMU) +=3D monitor.o
>  =20
>   DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
>  =20
>=20

