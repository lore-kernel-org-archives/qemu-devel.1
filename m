Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11595C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0F582186D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWucwQ5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F582186D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX9I3-00029r-W4
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 14:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iX9GJ-0001Nm-1Y
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iX9GG-0004Re-Kj
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:34:06 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iX9GG-0004R9-CH
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:34:04 -0500
Received: by mail-wm1-x343.google.com with SMTP id 8so5201938wmo.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 11:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L75CF277HvGjZnFmrwyjY4nLMNgCToCl0sL4q8Q7Hio=;
 b=UWucwQ5krkL2CHXilah23/ZqDqzYG0yNH0V5QiSSuTt8kmfErsmd4kyby1BKvDgqZk
 3Gu/+xPV7la7+jNGy44rlxUPuWTUZW/UxtLAhTffyhC14lJFm9smTgGefPL7sbvofCc+
 cv1xml3mDtJbYetZEIftr51MEqXFBO4YP7tmLD8tFXfho/6KXl/aU+8IQEujPzjYxxaL
 wOPPP8YT6XQNbdeR+ly9iTlPZGK6te6ulqZjiTy+dtiXE4+DUNDQ9HyF6F0hw7cBummy
 wMFpKDy1XzV04YTsF62h4Oxr2XK9/kmz3VPavHM4RyBopF3cDRmvKPyLH2Kg83Dmi886
 ywRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L75CF277HvGjZnFmrwyjY4nLMNgCToCl0sL4q8Q7Hio=;
 b=cnR9S07iyGixLYGmnZMVd8WuLmmrwK4G42TQBF2+YPJGcuAoGGpSzZL9wk/xUVRiSI
 wT9CPCaYKQwSA8XW6btoYRdOmlvja97ySA7za2Nd68f/A5zdQEZYtCiYWDFuj4WqYRpd
 59TKRjZ9gPDlggDXhpEF1x2XRJLDmaB5DNbQQnjXxxV72/Budqk7IHyIj/HJlJfOUpD7
 4lRZeAaG5xRqBzXSbVXDbJJPXUbf7lGUuo4INZaWtMvi3v15lZgaQGE05veq4K4KKNQ1
 s0UqWPx7HHu99w3aIfTTLChFYqgBN7nM9uxvBzwU6Z7thKTfu02FWsShIa3VHAXbb+yo
 ctpQ==
X-Gm-Message-State: APjAAAUtUr2lXtV4bnDX9QwHrfXJkv32wnD78BxiYHbDr3QPTx5Uo3dz
 tnSfZZfxxElyhbv23vv0Q/Cvq/yTG+Oyvg==
X-Google-Smtp-Source: APXvYqy8MzR5DjpUjEfbJNQcPq+QUQ+YPSkeIpqdf1dRdRg30fdmaGrGpbbJB++v43Mj94wQ82otJA==
X-Received: by 2002:a1c:9804:: with SMTP id a4mr7676760wme.57.1574192042375;
 Tue, 19 Nov 2019 11:34:02 -0800 (PST)
Received: from [192.168.8.102] (64.red-79-149-204.dynamicip.rima-tde.net.
 [79.149.204.64])
 by smtp.gmail.com with ESMTPSA id b1sm26588023wrs.74.2019.11.19.11.34.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 11:34:01 -0800 (PST)
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Taylor Simpson <tsimpson@quicinc.com>, laurent@vivier.eu,
 riku.voipio@iki.fi, qemu-devel@nongnu.org
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <41e0e646-f595-be14-fc31-12a5ec090dcb@linaro.org>
Date: Tue, 19 Nov 2019 20:33:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

On 11/19/19 12:58 AM, Taylor Simpson wrote:
> +static abi_ulong get_sigframe(struct target_sigaction *ka,
> +                              CPUHexagonState *regs, size_t framesize)
> +{
> +    abi_ulong sp = get_sp_from_cpustate(regs);
> +
> +    /* This is the X/Open sanctioned signal stack switching.  */
> +    sp = target_sigsp(sp, ka) - framesize;
> +
> +    sp &= ~7UL; /* align sp on 8-byte boundary */

QEMU_ALIGN_DOWN.

> diff --git a/linux-user/hexagon/sockbits.h b/linux-user/hexagon/sockbits.h
> new file mode 100644
> index 0000000..85bd64a
> --- /dev/null
> +++ b/linux-user/hexagon/sockbits.h
> @@ -0,0 +1,3 @@
> +/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
> +
> +#include "../generic/sockbits.h"

All new files should have denote their license.

> +static inline const char *cpu_get_model(uint32_t eflags)
> +{
> +    /* For now, treat anything newer than v60 as a v67 */
> +    /* FIXME - Disable instructions that are newer than the specified arch */
> +    if (eflags == 0x04 ||    /* v5  */
> +        eflags == 0x05 ||    /* v55 */
> +        eflags == 0x60 ||    /* v60 */
> +        eflags == 0x61 ||    /* v61 */
> +        eflags == 0x62 ||    /* v62 */
> +        eflags == 0x65 ||    /* v65 */
> +        eflags == 0x66 ||    /* v66 */
> +        eflags == 0x67) {    /* v67 */
> +        return "v67";
> +    }
> +    printf("eflags = 0x%x\n", eflags);

Left over debug.

> diff --git a/target/hexagon/Makefile.objs b/target/hexagon/Makefile.objs
> new file mode 100644
> index 0000000..dfab6ee
> --- /dev/null
> +++ b/target/hexagon/Makefile.objs
> @@ -0,0 +1,6 @@
> +obj-y += \
> +    cpu.o \
> +    translate.o \
> +    op_helper.o
> +
> +CFLAGS += -I$(SRC_PATH)/target/hexagon/imported

Is this really better than

#include "imported/global_types.h"

etc?

> +++ b/target/hexagon/cpu-param.h
> @@ -0,0 +1,11 @@
> +/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
> +
> +
> +#ifndef HEXAGON_CPU_PARAM_H
> +#define HEXAGON_CPU_PARAM_H
> +
> +# define TARGET_PHYS_ADDR_SPACE_BITS 36

Watch your spacing.

Does this really compile without TARGET_VIRT_ADDR_SPACE_BITS?

It's used in linux-user/main.c, but I suppose in a way that
the preprocessor interprets it as 0.

> +const char * const hexagon_prednames[] = {
> +  "p0 ", "p1 ", "p2 ", "p3 "
> +};

Inter-string spacing probably belongs to the format not the name.

> +static inline target_ulong hack_stack_ptrs(CPUHexagonState *env,
> +                                           target_ulong addr)
> +{
> +    target_ulong stack_start = env->stack_start;
> +    target_ulong stack_size = 0x10000;
> +    target_ulong stack_adjust = env->stack_adjust;
> +
> +    if (stack_start + 0x1000 >= addr && addr >= (stack_start - stack_size)) {
> +        return addr - stack_adjust;
> +    }
> +    return addr;
> +}

An explanation would be welcome here.

> +static void hexagon_dump(CPUHexagonState *env, FILE *f)
> +{
> +    static target_ulong last_pc;
> +    int i;
> +
> +    /*
> +     * When comparing with LLDB, it doesn't step through single-cycle
> +     * hardware loops the same way.  So, we just skip them here
> +     */
> +    if (env->gpr[HEX_REG_PC] == last_pc) {
> +        return;
> +    }

This seems mis-placed.

> +#ifdef FIXME
> +    /*
> +     * LLDB bug swaps gp and ugp
> +     * FIXME when the LLDB bug is fixed
> +     */
> +    print_reg(f, env, HEX_REG_GP);
> +    print_reg(f, env, HEX_REG_UGP);
> +#else
> +    fprintf(f, "  %s = 0x" TARGET_FMT_lx "\n",
> +        hexagon_regnames[HEX_REG_GP],
> +        hack_stack_ptrs(env, env->gpr[HEX_REG_UGP]));
> +    fprintf(f, "  %s = 0x" TARGET_FMT_lx "\n",
> +        hexagon_regnames[HEX_REG_UGP],
> +        hack_stack_ptrs(env, env->gpr[HEX_REG_GP]));
> +#endif
> +    print_reg(f, env, HEX_REG_PC);
> +#ifdef FIXME
> +    /*
> +     * Not modelled in qemu, print junk to minimize the diff's
> +     * with LLDB output
> +     */
> +    print_reg(f, env, HEX_REG_CAUSE);
> +    print_reg(f, env, HEX_REG_BADVA);
> +    print_reg(f, env, HEX_REG_CS0);
> +    print_reg(f, env, HEX_REG_CS1);
> +#else
> +    fprintf(f, "  cause = 0x000000db\n");
> +    fprintf(f, "  badva = 0x00000000\n");
> +    fprintf(f, "  cs0 = 0x00000000\n");
> +    fprintf(f, "  cs1 = 0x00000000\n");
> +#endif

Need we retain the fixme?

> +void hexagon_debug(CPUHexagonState *env)
> +{
> +    hexagon_dump(env, stdout);
> +}

Is this to be called from the debugger?  From what location did you find it
useful?  There are only certain locations in tcg that are self-consistent...

> +    DEFINE_CPU(TYPE_HEXAGON_CPU_V67,              hexagon_v67_cpu_init),

Spacing?

> +#ifndef HEXAGON_CPU_H
> +#define HEXAGON_CPU_H
> +
> +/* FIXME - Change this to a command-line option */
> +#ifdef FIXME
> +#define DEBUG_HEX
> +#endif
> +#ifdef FIXME
> +#define COUNT_HEX_HELPERS
> +#endif

Eh?

> +
> +/* Forward declaration needed by some of the header files */
> +typedef struct CPUHexagonState CPUHexagonState;
> +
> +#include <fenv.h>
> +#include "qemu/osdep.h"

osdep.h should already have been included.
Indeed, it must be first for *.c files.

Why do you need fenv.h?

> +#include "global_types.h"
> +#include "max.h"
> +#include "iss_ver_registers.h"
> +
> +#define TARGET_PAGE_BITS 16     /* 64K pages */
> +/*
> + * For experimenting with oslib (4K pages)
> + * #define TARGET_PAGE_BITS 12
> + */
> +#define TARGET_LONG_BITS 32
> +#define TARGET_VIRT_ADDR_SPACE_BITS 32

Ah, to answer my earlier question, these belong to cpu-param.h.
Drop the "experimenting" comment.

> +
> +#include <time.h>

time.h is included by osdep.h.


> +#include "qemu/compiler.h"
> +#include "qemu-common.h"
> +#include "exec/cpu-defs.h"
> +#include "regs.h"
> +
> +#define TYPE_HEXAGON_CPU "hexagon-cpu"
> +
> +#define HEXAGON_CPU_TYPE_SUFFIX "-" TYPE_HEXAGON_CPU
> +#define HEXAGON_CPU_TYPE_NAME(name) (name HEXAGON_CPU_TYPE_SUFFIX)
> +#define CPU_RESOLVING_TYPE TYPE_HEXAGON_CPU
> +
> +#define TYPE_HEXAGON_CPU_V67             HEXAGON_CPU_TYPE_NAME("v67")
> +
> +#define MMU_USER_IDX 0
> +
> +#define TRANSLATE_FAIL 1
> +#define TRANSLATE_SUCCESS 0

What's this for?  This looks like it's cribbed from riscv,
which oddly doesn't match the actual tlb_fill interface,
which uses bool true for success.

> +
> +struct MemLog {
> +    vaddr_t va;
> +    size1u_t width;
> +    size4u_t data32;
> +    size8u_t data64;
> +};

Is this part of translation?  Maybe save this til you
actually use it, and probably place in translate.h.

> +    /* For comparing with LLDB on target - see hack_stack_ptrs function */
> +    target_ulong stack_start;
> +    target_ulong stack_adjust;

Which, as you recall, doesn't actually have any commentary.

> +extern const char * const hexagon_regnames[];
> +extern const char * const hexagon_prednames[];

Do these actually need declaring here?
Let's keep them private to cpu.c otherwise.

> +#define ENV_GET_CPU(e)  CPU(hexagon_env_get_cpu(e))
> +#define ENV_OFFSET      offsetof(HexagonCPU, env)

Obsolete. Remove.

> +int hexagon_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
> +int hexagon_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);

Move these decls to e.g. internal.h?
They're not relevant to generic users of cpu.h

> +void QEMU_NORETURN do_raise_exception_err(CPUHexagonState *env,
> +                                          uint32_t exception, uintptr_t pc);

Likewise.

> +void hexagon_translate_init(void);
> +void hexagon_debug(CPUHexagonState *env);
> +void hexagon_debug_vreg(CPUHexagonState *env, int regnum);
> +void hexagon_debug_qreg(CPUHexagonState *env, int regnum);

Likewise.

> +#ifdef COUNT_HEX_HELPERS
> +extern void print_helper_counts(void);
> +#endif

Likewise.

> +static void decode_packet(CPUHexagonState *env, DisasContext *ctx)
> +{
> +    size4u_t words[4];
> +    int i;
> +    /* Brute force way to make sure current PC is set */
> +    tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->base.pc_next);

What's this for?

> +
> +    for (i = 0; i < 4; i++) {
> +        words[i] = cpu_ldl_code(env, ctx->base.pc_next + i * sizeof(size4u_t));
> +    }

And this?

> +    /*
> +     * Brute force just enough to get the first program to execute.
> +     */
> +    switch (words[0]) {
> +    case 0x7800c806:                                /* r6 = #64 */
> +        tcg_gen_movi_tl(hex_gpr[6], 64);
> +        ctx->base.pc_next += 4;
> +        break;
> +    case 0x7800c020:                                /* r0 = #1 */
> +        tcg_gen_movi_tl(hex_gpr[0], 1);
> +        ctx->base.pc_next += 4;
> +        break;
> +    case 0x00044002:
> +        if (words[1] == 0x7800c001) {               /* r1 = ##0x400080 */
> +            tcg_gen_movi_tl(hex_gpr[1], 0x400080);
> +            ctx->base.pc_next += 8;
> +        } else {
> +            printf("ERROR: Unknown instruction 0x%x\n", words[1]);
> +            g_assert_not_reached();
> +        }
> +        break;
> +    case 0x7800c0e2:                                /* r2 = #7 */
> +        tcg_gen_movi_tl(hex_gpr[2], 7);
> +        ctx->base.pc_next += 4;
> +        break;
> +    case 0x5400c004:                               /* trap0(#1) */
> +    {
> +        TCGv excp_trap0 = tcg_const_tl(HEX_EXCP_TRAP0);
> +        gen_helper_raise_exception(cpu_env, excp_trap0);
> +        tcg_temp_free(excp_trap0);
> +        ctx->base.pc_next += 4;
> +        break;
> +    }
> +    case 0x7800cbc6:                               /* r6 = #94 */
> +        tcg_gen_movi_tl(hex_gpr[6], 94);
> +        ctx->base.pc_next += 4;
> +        break;
> +    case 0x7800cba6:                               /* r6 = #93 */
> +        tcg_gen_movi_tl(hex_gpr[6], 93);
> +        ctx->base.pc_next += 4;
> +        break;
> +    case 0x7800c000:                               /* r0 = #0 */
> +        tcg_gen_movi_tl(hex_gpr[0], 0);
> +        ctx->base.pc_next += 4;
> +        break;
> +    default:
> +        ctx->base.is_jmp = DISAS_TOO_MANY;
> +        ctx->base.pc_next += 4;
> +    }

I'm not especially keen on this, since it will just be removed in subsequent
patches.  The initial patch must compile, but it need not do *anything*
interesting.

C.f. 61766fe9e2d3 which is the initial commit for target/hppa, wherein the
decoder is

> +static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
> +{
> +    uint32_t opc = extract32(insn, 26, 6);
> +
> +    switch (opc) {
> +    default:
> +        break;
> +    }
> +    return gen_illegal(ctx);
> +}



> +}
> +
> +static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
> +                                          CPUState *cs)
> +{
> +    DisasContext *ctx = container_of(dcbase, DisasContext, base);
> +
> +    ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;

Since you're not initializing this in cpu_get_tb_cpu_state, you might as well
just use

    ctx->mem_idx = MMU_USER_IDX;

> +static void hexagon_tr_translate_packet(DisasContextBase *dcbase, CPUState *cpu)
> +{
> +    DisasContext *ctx = container_of(dcbase, DisasContext, base);
> +    CPUHexagonState *env = cpu->env_ptr;
> +
> +    decode_packet(env, ctx);
> +
> +    if (ctx->base.is_jmp == DISAS_NEXT) {
> +        target_ulong page_start;
> +
> +        page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
> +        if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE) {
> +            ctx->base.is_jmp = DISAS_TOO_MANY;
> +        }
> +
> +#ifdef DEBUG_HEX
> +        /* When debugging, force the end of the TB after each packet */
> +        if (ctx->base.pc_next - ctx->base.pc_first >= 0x04) {
> +            ctx->base.is_jmp = DISAS_TOO_MANY;
> +        }
> +#endif
> +    }

As mentioned elsewhere, this latter should be handled by -singlestep.  The
generic translator loop will have set max_insns to 1.


r~

