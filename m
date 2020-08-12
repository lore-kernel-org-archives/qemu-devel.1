Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B6DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 23:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6879220774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 23:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDfLWS+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6879220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k609L-0002bH-L2
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 19:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k608k-00027C-Dt; Wed, 12 Aug 2020 19:26:38 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:34759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k608i-0002W4-8c; Wed, 12 Aug 2020 19:26:38 -0400
Received: by mail-il1-x141.google.com with SMTP id t4so3744660iln.1;
 Wed, 12 Aug 2020 16:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wytlQz6bzpk943b0Muie01TFuftSx/f1fjCONG06DLA=;
 b=mDfLWS+OkaHCH+0zUP//8FHz+etQ/CYINsqNfXE98ZamZCrAYAOrdQug5dosDSrqqk
 gMb59FkyPZWUkuGxE78yqN9aGvga+wQOf5dTpHoO1ydAeGSbfW8YlgR5ruQSWiHH3BfS
 TUjm9TN8aWBR0ZrbaYiDWow4bEVxEjDPO/y6yI5iLIwZRf8MFQInujKv/bMIXPRtfWgR
 k/fQiaIiWegt6C1F6LSvc7dAygRBU3mlBOSTlDl5OfppwkWgmcRmwX8xBHcWcLsKWXWI
 W7psVjep2tsTZJisxkQ6iVv1JVAqUXpARpiltRqfhjRokTW8j7NScVCSMBgz1iZGqMGM
 jYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wytlQz6bzpk943b0Muie01TFuftSx/f1fjCONG06DLA=;
 b=J91zHdTPbaah2rEybVYiyPrHNc+I1Vz4phgoWZ1XrZgz233C3n+SP68tS6YQyBuGsZ
 V/59d6i0gL/TaeZRtA2pj3En4sOeyFdy15oSCvwr7/sI4XbFZxP/pjDQFTyUyI7lEWr2
 Dk8/pghltDwhDpKuHB67bmZUkkqLz/6x9QVyqhxM45aACfo8rtk1MD5oxvRWjNnRzphL
 d+2uvDFn6FeqhcmJnIL0gpxe4dLwVbRzXlFOSst3DCpej3cTd0Ysnne0WLYVIOzecsEI
 SD2B7e7ntRXeibN17xxb9eDVSm3adcDqGk/xFQUaqoDga5NZdIPIMq2b9grf9jpgFDex
 G3eQ==
X-Gm-Message-State: AOAM531yC14lLufOUxbzAbyyfjOYSGkTWIXnxGQJ+/PheirmpDuQSdrV
 bS0kLtJDWIRKZR630E4AuSmZ7s8W7ddud4D0XaU=
X-Google-Smtp-Source: ABdhPJwkanTUa4w+iJNLO2+6Eb6cTVqbmaq1WeRbU2xRGRHpRXjfx8sKfzelKsy2QBW/kz8YYokqep12l8OPLA20sG8=
X-Received: by 2002:a05:6e02:13f1:: with SMTP id
 w17mr2029112ilj.131.1597274794749; 
 Wed, 12 Aug 2020 16:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200729112801.108985-1-anup.patel@wdc.com>
 <20200729112801.108985-4-anup.patel@wdc.com>
In-Reply-To: <20200729112801.108985-4-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Aug 2020 16:16:08 -0700
Message-ID: <CAKmqyKMCYutR5TNvbJ3nA0rAu4W0xFVsZRm66W7Fi_Nw3joiBw@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/riscv: Update MTINST/HTINST CSR in
 riscv_cpu_do_interrupt()
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 29, 2020 at 4:32 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> When RISCV_FEATURE_TINST feature is enabled, we should write
> transformed instruction encoding of the trapped instruction
> in MTINST/HTINST CSR at time of taking trap.
>
> We update riscv_cpu_do_interrupt() as-per above.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 166 +++++++++++++++++++++++++++++++++++++-
>  target/riscv/instmap.h    |  41 ++++++++++
>  2 files changed, 204 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e4bd45d66a..97ae23ad2b 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -22,6 +22,7 @@
>  #include "qemu/main-loop.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
> +#include "instmap.h"
>  #include "tcg/tcg-op.h"
>  #include "trace.h"
>
> @@ -820,6 +821,151 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>  #endif
>  }
>
> +static target_ulong riscv_transformed_insn(CPURISCVState *env,
> +                                           int xlen, target_ulong insn)
> +{
> +    target_ulong xinsn = 0;
> +
> +    if ((insn & 0x3) != 0x3) {
> +        /* Transform 16bit instruction into 32bit instruction */
> +        switch (GET_C_OP(insn)) {
> +        case OPC_RISC_C_OP_QUAD0: /* Quadrant 0 */
> +            switch (GET_C_FUNC(insn)) {
> +            case OPC_RISC_C_FUNC_FLD_LQ:
> +                if (xlen != 128) { /* C.FLD (RV32/64) */
> +                    xinsn = OPC_RISC_FLD;
> +                    xinsn = SET_RD(xinsn, GET_C_RS2S(insn));
> +                    xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
> +                    xinsn = SET_I_IMM(xinsn, GET_C_LD_IMM(insn));
> +                }
> +                break;
> +            case OPC_RISC_C_FUNC_LW: /* C.LW */
> +                xinsn = OPC_RISC_LW;
> +                xinsn = SET_RD(xinsn, GET_C_RS2S(insn));
> +                xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
> +                xinsn = SET_I_IMM(xinsn, GET_C_LW_IMM(insn));
> +                break;
> +            case OPC_RISC_C_FUNC_FLW_LD:
> +                if (xlen == 32) { /* C.FLW (RV32) */
> +                    xinsn = OPC_RISC_FLW;
> +                    xinsn = SET_RD(xinsn, GET_C_RS2S(insn));
> +                    xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
> +                    xinsn = SET_I_IMM(xinsn, GET_C_LW_IMM(insn));
> +                } else { /* C.LD (RV64/RV128) */
> +                    xinsn = OPC_RISC_LD;
> +                    xinsn = SET_RD(xinsn, GET_C_RS2S(insn));
> +                    xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
> +                    xinsn = SET_I_IMM(xinsn, GET_C_LD_IMM(insn));
> +                }
> +                break;
> +            case OPC_RISC_C_FUNC_FSD_SQ:
> +                if (xlen != 128) { /* C.FSD (RV32/64) */
> +                    xinsn = OPC_RISC_FSD;
> +                    xinsn = SET_RS2(xinsn, GET_C_RS2S(insn));
> +                    xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
> +                    xinsn = SET_S_IMM(xinsn, GET_C_SD_IMM(insn));
> +                }
> +                break;
> +            case OPC_RISC_C_FUNC_SW: /* C.SW */
> +                xinsn = OPC_RISC_SW;
> +                xinsn = SET_RS2(xinsn, GET_C_RS2S(insn));
> +                xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
> +                xinsn = SET_S_IMM(xinsn, GET_C_SW_IMM(insn));
> +                break;
> +            case OPC_RISC_C_FUNC_FSW_SD:
> +                if (xlen == 32) { /* C.FSW (RV32) */
> +                    xinsn = OPC_RISC_FSW;
> +                    xinsn = SET_RS2(xinsn, GET_C_RS2S(insn));
> +                    xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
> +                    xinsn = SET_S_IMM(xinsn, GET_C_SW_IMM(insn));
> +                } else { /* C.SD (RV64/RV128) */
> +                    xinsn = OPC_RISC_SD;
> +                    xinsn = SET_RS2(xinsn, GET_C_RS2S(insn));
> +                    xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
> +                    xinsn = SET_S_IMM(xinsn, GET_C_SD_IMM(insn));
> +                }
> +                break;
> +            default:
> +                break;
> +            }
> +            break;
> +        case OPC_RISC_C_OP_QUAD2: /* Quadrant 2 */
> +            switch (GET_C_FUNC(insn)) {
> +            case OPC_RISC_C_FUNC_FLDSP_LQSP:
> +                if (xlen != 128) { /* C.FLDSP (RV32/64) */
> +                    xinsn = OPC_RISC_FLD;
> +                    xinsn = SET_RD(xinsn, GET_C_RD(insn));
> +                    xinsn = SET_RS1(xinsn, 2);
> +                    xinsn = SET_I_IMM(xinsn, GET_C_LDSP_IMM(insn));
> +                }
> +                break;
> +            case OPC_RISC_C_FUNC_LWSP: /* C.LWSP */
> +                xinsn = OPC_RISC_LW;
> +                xinsn = SET_RD(xinsn, GET_C_RD(insn));
> +                xinsn = SET_RS1(xinsn, 2);
> +                xinsn = SET_I_IMM(xinsn, GET_C_LWSP_IMM(insn));
> +                break;
> +            case OPC_RISC_C_FUNC_FLWSP_LDSP:
> +                if (xlen == 32) { /* C.FLWSP (RV32) */
> +                    xinsn = OPC_RISC_FLW;
> +                    xinsn = SET_RD(xinsn, GET_C_RD(insn));
> +                    xinsn = SET_RS1(xinsn, 2);
> +                    xinsn = SET_I_IMM(xinsn, GET_C_LWSP_IMM(insn));
> +                } else { /* C.LDSP (RV64/RV128) */
> +                    xinsn = OPC_RISC_LD;
> +                    xinsn = SET_RD(xinsn, GET_C_RD(insn));
> +                    xinsn = SET_RS1(xinsn, 2);
> +                    xinsn = SET_I_IMM(xinsn, GET_C_LDSP_IMM(insn));
> +                }
> +                break;
> +            case OPC_RISC_C_FUNC_FSDSP_SQSP:
> +                if (xlen != 128) { /* C.FSDSP (RV32/64) */
> +                    xinsn = OPC_RISC_FSD;
> +                    xinsn = SET_RS2(xinsn, GET_C_RS2(insn));
> +                    xinsn = SET_RS1(xinsn, 2);
> +                    xinsn = SET_S_IMM(xinsn, GET_C_SDSP_IMM(insn));
> +                }
> +                break;
> +            case OPC_RISC_C_FUNC_SWSP: /* C.SWSP */
> +                xinsn = OPC_RISC_SW;
> +                xinsn = SET_RS2(xinsn, GET_C_RS2(insn));
> +                xinsn = SET_RS1(xinsn, 2);
> +                xinsn = SET_S_IMM(xinsn, GET_C_SWSP_IMM(insn));
> +                break;
> +            case 7:
> +                if (xlen == 32) { /* C.FSWSP (RV32) */
> +                    xinsn = OPC_RISC_FSW;
> +                    xinsn = SET_RS2(xinsn, GET_C_RS2(insn));
> +                    xinsn = SET_RS1(xinsn, 2);
> +                    xinsn = SET_S_IMM(xinsn, GET_C_SWSP_IMM(insn));
> +                } else { /* C.SDSP (RV64/RV128) */
> +                    xinsn = OPC_RISC_SD;
> +                    xinsn = SET_RS2(xinsn, GET_C_RS2(insn));
> +                    xinsn = SET_RS1(xinsn, 2);
> +                    xinsn = SET_S_IMM(xinsn, GET_C_SDSP_IMM(insn));
> +                }
> +                break;
> +            default:
> +                break;
> +            }
> +            break;
> +        default:
> +            break;
> +        }

I don't like that we have to manually decode the instructions. As it's
only a handful it's not the end of the world, but it seems like
duplication that could grow. Could we not use decode_insn16() instead?
That way we can share the well tested TCG decoder.

Alistair

> +
> +        /*
> +         * Clear Bit1 of transformed instruction to indicate that
> +         * original insruction was a 16bit instruction
> +         */
> +        xinsn &= ~((target_ulong)0x2);
> +    } else {
> +        /* No need to transform 32bit (or wider) instructions */
> +        xinsn = insn;
> +    }
> +
> +    return xinsn;
> +}
> +
>  /*
>   * Handle Traps
>   *
> @@ -842,6 +988,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
>      target_ulong deleg = async ? env->mideleg : env->medeleg;
>      target_ulong tval = 0;
> +    target_ulong tinst = 0;
>      target_ulong htval = 0;
>      target_ulong mtval2 = 0;
>
> @@ -849,20 +996,31 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          /* set tval to badaddr for traps with address information */
>          switch (cause) {
>          case RISCV_EXCP_INST_GUEST_PAGE_FAULT:
> -        case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
> -        case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
>              force_hs_execp = true;
>              /* fallthrough */
>          case RISCV_EXCP_INST_ADDR_MIS:
>          case RISCV_EXCP_INST_ACCESS_FAULT:
> +        case RISCV_EXCP_INST_PAGE_FAULT:
> +            tval = env->badaddr;
> +            break;
> +        case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
> +        case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
> +            force_hs_execp = true;
> +            /* fallthrough */
>          case RISCV_EXCP_LOAD_ADDR_MIS:
>          case RISCV_EXCP_STORE_AMO_ADDR_MIS:
>          case RISCV_EXCP_LOAD_ACCESS_FAULT:
>          case RISCV_EXCP_STORE_AMO_ACCESS_FAULT:
> -        case RISCV_EXCP_INST_PAGE_FAULT:
>          case RISCV_EXCP_LOAD_PAGE_FAULT:
>          case RISCV_EXCP_STORE_PAGE_FAULT:
>              tval = env->badaddr;
> +            if (riscv_feature(env, RISCV_FEATURE_TINST)) {
> +#if defined(TARGET_RISCV32)
> +                tinst = riscv_transformed_insn(env, 32, env->trap_insn);
> +#elif defined(TARGET_RISCV64)
> +                tinst = riscv_transformed_insn(env, 64, env->trap_insn);
> +#endif
> +            }
>              break;
>          case RISCV_EXCP_VIRT_INSTRUCTION_FAULT:
>          case RISCV_EXCP_ILLEGAL_INST:
> @@ -955,6 +1113,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->sepc = env->pc;
>          env->sbadaddr = tval;
>          env->htval = htval;
> +        env->htinst = tinst;
>          env->pc = (env->stvec >> 2 << 2) +
>              ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
>          riscv_cpu_set_mode(env, PRV_S);
> @@ -994,6 +1153,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->mepc = env->pc;
>          env->mbadaddr = tval;
>          env->mtval2 = mtval2;
> +        env->mtinst = tinst;
>          env->pc = (env->mtvec >> 2 << 2) +
>              ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
>          riscv_cpu_set_mode(env, PRV_M);
> diff --git a/target/riscv/instmap.h b/target/riscv/instmap.h
> index 40b6d2b64d..f4ee686c78 100644
> --- a/target/riscv/instmap.h
> +++ b/target/riscv/instmap.h
> @@ -316,6 +316,12 @@ enum {
>  #define GET_RS2(inst)  extract32(inst, 20, 5)
>  #define GET_RD(inst)   extract32(inst, 7, 5)
>  #define GET_IMM(inst)  sextract64(inst, 20, 12)
> +#define SET_RS1(inst, val)  deposit32(inst, 15, 5, val)
> +#define SET_RS2(inst, val)  deposit32(inst, 20, 5, val)
> +#define SET_RD(inst, val)   deposit32(inst, 7, 5, val)
> +#define SET_I_IMM(inst, val)  deposit32(inst, 20, 12, val)
> +#define SET_S_IMM(inst, val)  \
> +    deposit32(deposit32(inst, 7, 5, val), 25, 7, (val) >> 5)
>
>  /* RVC decoding macros */
>  #define GET_C_IMM(inst)             (extract32(inst, 2, 5) \
> @@ -346,6 +352,8 @@ enum {
>                                      | (extract32(inst, 5, 1) << 6))
>  #define GET_C_LD_IMM(inst)          ((extract16(inst, 10, 3) << 3) \
>                                      | (extract16(inst, 5, 2) << 6))
> +#define GET_C_SW_IMM(inst)          GET_C_LW_IMM(inst)
> +#define GET_C_SD_IMM(inst)          GET_C_LD_IMM(inst)
>  #define GET_C_J_IMM(inst)           ((extract32(inst, 3, 3) << 1) \
>                                      | (extract32(inst, 11, 1) << 4) \
>                                      | (extract32(inst, 2, 1) << 5) \
> @@ -366,4 +374,37 @@ enum {
>  #define GET_C_RS1S(inst)            (8 + extract16(inst, 7, 3))
>  #define GET_C_RS2S(inst)            (8 + extract16(inst, 2, 3))
>
> +#define GET_C_FUNC(inst)           extract32(inst, 13, 3)
> +#define GET_C_OP(inst)             extract32(inst, 0, 2)
> +
> +enum {
> +    /* RVC Quadrants */
> +    OPC_RISC_C_OP_QUAD0 = 0x0,
> +    OPC_RISC_C_OP_QUAD1 = 0x1,
> +    OPC_RISC_C_OP_QUAD2 = 0x2
> +};
> +
> +enum {
> +    /* RVC Quadrant 0 */
> +    OPC_RISC_C_FUNC_ADDI4SPN = 0x0,
> +    OPC_RISC_C_FUNC_FLD_LQ = 0x1,
> +    OPC_RISC_C_FUNC_LW = 0x2,
> +    OPC_RISC_C_FUNC_FLW_LD = 0x3,
> +    OPC_RISC_C_FUNC_FSD_SQ = 0x5,
> +    OPC_RISC_C_FUNC_SW = 0x6,
> +    OPC_RISC_C_FUNC_FSW_SD = 0x7
> +};
> +
> +enum {
> +    /* RVC Quadrant 2 */
> +    OPC_RISC_C_FUNC_SLLI_SLLI64 = 0x0,
> +    OPC_RISC_C_FUNC_FLDSP_LQSP = 0x1,
> +    OPC_RISC_C_FUNC_LWSP = 0x2,
> +    OPC_RISC_C_FUNC_FLWSP_LDSP = 0x3,
> +    OPC_RISC_C_FUNC_JR_MV_EBREAK_JALR_ADD = 0x4,
> +    OPC_RISC_C_FUNC_FSDSP_SQSP = 0x5,
> +    OPC_RISC_C_FUNC_SWSP = 0x6,
> +    OPC_RISC_C_FUNC_FSWSP_SDSP = 0x7
> +};
> +
>  #endif
> --
> 2.25.1
>
>

