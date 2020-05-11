Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8BFC38A2A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29993206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lt1SVYIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29993206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXxZd-0000vh-Bj
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 21:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUx-00011R-5n; Sun, 10 May 2020 21:44:51 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56995 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUv-0000hv-92; Sun, 10 May 2020 21:44:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49L3dh2KgFz9sT5; Mon, 11 May 2020 11:44:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589161480;
 bh=9ljOHZlsUvOR4IFaWk5w3kI/2osTQHq6jsLMDg9lJmU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lt1SVYINhBtc5lrLpYmM4ZgaXztULcpuws4KW9K6dfmKQHUSBHS5Yls1OmhCZphPc
 wWng509QwtmwPxwCyAphdYj5mPUk4/DTgT+yFflB6TefgNdB7cNA3DgIMB9oq1vq1j
 85OseHREHkUNN7yqtGYNNTYQNhc8rl34EzkWmNv4=
Date: Mon, 11 May 2020 11:37:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] target/ppc: Add support for scv and rfscv instructions
Message-ID: <20200511013727.GM2183@umbus.fritz.box>
References: <20200507115328.789175-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1rguoi8KZGYj2k4L"
Content-Disposition: inline
In-Reply-To: <20200507115328.789175-1-npiggin@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1rguoi8KZGYj2k4L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 09:53:28PM +1000, Nicholas Piggin wrote:
> POWER9 adds scv and rfscv instructions and the system call vectored
> interrupt. Linux does not support this instruction yet but it has
> been tested with a modified kernel that runs on real hardware.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.1.

> ---
> This was tested with out-of-tree Linux patches and seems to work fine.
>=20
> This fixes the linux-user compile error that David reported last time,
> by disabling everything for CONFIG_USER_ONLY. I have the user
> implementation which is pretty simple, but we don't have an official
> user ABI yet so I'll wait until we get support merged in the kernel.
>=20
> Thanks,
> Nick
>=20
>  linux-user/ppc/cpu_loop.c       |  1 +
>  target/ppc/cpu.h                |  7 ++-
>  target/ppc/excp_helper.c        | 98 ++++++++++++++++++++++++---------
>  target/ppc/helper.h             |  1 +
>  target/ppc/translate.c          | 52 ++++++++++++++++-
>  target/ppc/translate_init.inc.c |  3 +-
>  6 files changed, 132 insertions(+), 30 deletions(-)
>=20
> diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
> index 5b27f8603e..df71e15a25 100644
> --- a/linux-user/ppc/cpu_loop.c
> +++ b/linux-user/ppc/cpu_loop.c
> @@ -267,6 +267,7 @@ void cpu_loop(CPUPPCState *env)
>              queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
>              break;
>          case POWERPC_EXCP_SYSCALL:  /* System call exception            =
     */
> +        case POWERPC_EXCP_SYSCALL_VECTORED:
>              cpu_abort(cs, "Syscall exception while in user mode. "
>                        "Aborting\n");
>              break;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 6b6dd7e483..df5c30160d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -127,8 +127,9 @@ enum {
>      POWERPC_EXCP_SDOOR_HV =3D 100,
>      /* ISA 3.00 additions */
>      POWERPC_EXCP_HVIRT    =3D 101,
> +    POWERPC_EXCP_SYSCALL_VECTORED =3D 102, /* scv exception             =
        */
>      /* EOL                                                              =
     */
> -    POWERPC_EXCP_NB       =3D 102,
> +    POWERPC_EXCP_NB       =3D 103,
>      /* QEMU exceptions: used internally during code translation         =
     */
>      POWERPC_EXCP_STOP         =3D 0x200, /* stop translation            =
       */
>      POWERPC_EXCP_BRANCH       =3D 0x201, /* branch instruction          =
       */
> @@ -478,6 +479,7 @@ typedef struct ppc_v3_pate_t {
>  /* Facility Status and Control (FSCR) bits */
>  #define FSCR_EBB        (63 - 56) /* Event-Based Branch Facility */
>  #define FSCR_TAR        (63 - 55) /* Target Address Register */
> +#define FSCR_SCV        (63 - 51) /* System call vectored */
>  /* Interrupt cause mask and position in FSCR. HFSCR has the same format =
*/
>  #define FSCR_IC_MASK    (0xFFULL)
>  #define FSCR_IC_POS     (63 - 7)
> @@ -487,6 +489,7 @@ typedef struct ppc_v3_pate_t {
>  #define FSCR_IC_TM          5
>  #define FSCR_IC_EBB         7
>  #define FSCR_IC_TAR         8
> +#define FSCR_IC_SCV        12
> =20
>  /* Exception state register bits definition                             =
     */
>  #define ESR_PIL   PPC_BIT(36) /* Illegal Instruction                    =
*/
> @@ -554,6 +557,8 @@ enum {
>      POWERPC_FLAG_VSX      =3D 0x00080000,
>      /* Has Transaction Memory (ISA 2.07)                                =
     */
>      POWERPC_FLAG_TM       =3D 0x00100000,
> +    /* Has SCV (ISA 3.00)                                               =
     */
> +    POWERPC_FLAG_SCV      =3D 0x00200000,
>  };
> =20
>  /***********************************************************************=
******/
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index f052979664..170b3be4c4 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -67,6 +67,18 @@ static inline void dump_syscall(CPUPPCState *env)
>                    ppc_dump_gpr(env, 8), env->nip);
>  }
> =20
> +static inline void dump_syscall_vectored(CPUPPCState *env)
> +{
> +    qemu_log_mask(CPU_LOG_INT, "syscall r0=3D%016" PRIx64
> +                  " r3=3D%016" PRIx64 " r4=3D%016" PRIx64 " r5=3D%016" P=
RIx64
> +                  " r6=3D%016" PRIx64 " r7=3D%016" PRIx64 " r8=3D%016" P=
RIx64
> +                  " nip=3D" TARGET_FMT_lx "\n",
> +                  ppc_dump_gpr(env, 0), ppc_dump_gpr(env, 3),
> +                  ppc_dump_gpr(env, 4), ppc_dump_gpr(env, 5),
> +                  ppc_dump_gpr(env, 6), ppc_dump_gpr(env, 7),
> +                  ppc_dump_gpr(env, 8), env->nip);
> +}
> +
>  static inline void dump_hcall(CPUPPCState *env)
>  {
>      qemu_log_mask(CPU_LOG_INT, "hypercall r3=3D%016" PRIx64
> @@ -185,7 +197,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong msr, new_msr, vector;
> -    int srr0, srr1, asrr0, asrr1, lev, ail;
> +    int srr0, srr1, asrr0, asrr1, lev =3D -1, ail;
>      bool lpes0;
> =20
>      qemu_log_mask(CPU_LOG_INT, "Raise exception at " TARGET_FMT_lx
> @@ -421,6 +433,13 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>              new_msr |=3D (target_ulong)MSR_HVB;
>          }
>          break;
> +    case POWERPC_EXCP_SYSCALL_VECTORED: /* scv exception                =
     */
> +        lev =3D env->error_code;
> +        dump_syscall_vectored(env);
> +        env->nip +=3D 4;
> +        new_msr |=3D env->msr & ((target_ulong)1 << MSR_EE);
> +        new_msr |=3D env->msr & ((target_ulong)1 << MSR_RI);
> +        break;
>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception=
     */
>      case POWERPC_EXCP_APU:       /* Auxiliary processor unavailable     =
     */
>      case POWERPC_EXCP_DECR:      /* Decrementer exception               =
     */
> @@ -724,12 +743,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>          break;
>      }
> =20
> -    /* Save PC */
> -    env->spr[srr0] =3D env->nip;
> -
> -    /* Save MSR */
> -    env->spr[srr1] =3D msr;
> -
>      /* Sanity check */
>      if (!(env->msr_mask & MSR_HVB)) {
>          if (new_msr & MSR_HVB) {
> @@ -742,14 +755,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>          }
>      }
> =20
> -    /* If any alternate SRR register are defined, duplicate saved values=
 */
> -    if (asrr0 !=3D -1) {
> -        env->spr[asrr0] =3D env->spr[srr0];
> -    }
> -    if (asrr1 !=3D -1) {
> -        env->spr[asrr1] =3D env->spr[srr1];
> -    }
> -
>      /*
>       * Sort out endianness of interrupt, this differs depending on the
>       * CPU, the HV mode, etc...
> @@ -784,14 +789,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>      }
>  #endif
> =20
> -    /* Jump to handler */
> -    vector =3D env->excp_vectors[excp];
> -    if (vector =3D=3D (target_ulong)-1ULL) {
> -        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> -                  excp);
> -    }
> -    vector |=3D env->excp_prefix;
> -
>      /*
>       * AIL only works if there is no HV transition and we are running
>       * with translations enabled
> @@ -800,10 +797,21 @@ static inline void powerpc_excp(PowerPCCPU *cpu, in=
t excp_model, int excp)
>          ((new_msr & MSR_HVB) && !(msr & MSR_HVB))) {
>          ail =3D 0;
>      }
> -    /* Handle AIL */
> -    if (ail) {
> -        new_msr |=3D (1 << MSR_IR) | (1 << MSR_DR);
> -        vector |=3D ppc_excp_vector_offset(cs, ail);
> +
> +    vector =3D env->excp_vectors[excp];
> +    if (vector =3D=3D (target_ulong)-1ULL) {
> +        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> +                  excp);
> +    }
> +
> +    vector |=3D env->excp_prefix;
> +
> +    /* If any alternate SRR register are defined, duplicate saved values=
 */
> +    if (asrr0 !=3D -1) {
> +        env->spr[asrr0] =3D env->nip;
> +    }
> +    if (asrr1 !=3D -1) {
> +        env->spr[asrr1] =3D msr;
>      }
> =20
>  #if defined(TARGET_PPC64)
> @@ -823,6 +831,37 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>      }
>  #endif
> =20
> +    if (excp !=3D POWERPC_EXCP_SYSCALL_VECTORED) {
> +        /* Save PC */
> +        env->spr[srr0] =3D env->nip;
> +
> +        /* Save MSR */
> +        env->spr[srr1] =3D msr;
> +
> +        /* Handle AIL */
> +        if (ail) {
> +            new_msr |=3D (1 << MSR_IR) | (1 << MSR_DR);
> +            vector |=3D ppc_excp_vector_offset(cs, ail);
> +        }
> +
> +#if defined(TARGET_PPC64)
> +    } else {
> +        /* scv AIL is a little different */
> +        if (ail) {
> +            new_msr |=3D (1 << MSR_IR) | (1 << MSR_DR);
> +        }
> +        if (ail =3D=3D AIL_C000_0000_0000_4000) {
> +            vector |=3D 0xc000000000003000ull;
> +        } else {
> +            vector |=3D 0x0000000000017000ull;
> +        }
> +        vector +=3D lev * 0x20;
> +
> +        env->lr =3D env->nip;
> +        env->ctr =3D msr;
> +#endif
> +    }
> +
>      powerpc_set_excp_state(cpu, vector, new_msr);
>  }
> =20
> @@ -1160,6 +1199,11 @@ void helper_rfid(CPUPPCState *env)
>      do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1]);
>  }
> =20
> +void helper_rfscv(CPUPPCState *env)
> +{
> +    do_rfi(env, env->lr, env->ctr);
> +}
> +
>  void helper_hrfid(CPUPPCState *env)
>  {
>      do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index a95c010391..2dfa1c6942 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -15,6 +15,7 @@ DEF_HELPER_1(rfmci, void, env)
>  #if defined(TARGET_PPC64)
>  DEF_HELPER_2(pminsn, void, env, i32)
>  DEF_HELPER_1(rfid, void, env)
> +DEF_HELPER_1(rfscv, void, env)
>  DEF_HELPER_1(hrfid, void, env)
>  DEF_HELPER_2(store_lpcr, void, env, tl)
>  DEF_HELPER_2(store_pcr, void, env, tl)
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 807d14faaa..9a7ae9a160 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -173,6 +173,7 @@ struct DisasContext {
>      bool vsx_enabled;
>      bool spe_enabled;
>      bool tm_enabled;
> +    bool scv_enabled;
>      bool gtse;
>      ppc_spr_t *spr_cb; /* Needed to check rights for mfspr/mtspr */
>      int singlestep_enabled;
> @@ -4012,6 +4013,24 @@ static void gen_rfid(DisasContext *ctx)
>  #endif
>  }
> =20
> +#if !defined(CONFIG_USER_ONLY)
> +static void gen_rfscv(DisasContext *ctx)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    GEN_PRIV;
> +#else
> +    /* Restore CPU state */
> +    CHK_SV;
> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +        gen_io_start();
> +    }
> +    gen_update_cfar(ctx, ctx->base.pc_next - 4);
> +    gen_helper_rfscv(cpu_env);
> +    gen_sync_exception(ctx);
> +#endif
> +}
> +#endif
> +
>  static void gen_hrfid(DisasContext *ctx)
>  {
>  #if defined(CONFIG_USER_ONLY)
> @@ -4030,6 +4049,7 @@ static void gen_hrfid(DisasContext *ctx)
>  #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL_USER
>  #else
>  #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL
> +#define POWERPC_SYSCALL_VECTORED POWERPC_EXCP_SYSCALL_VECTORED
>  #endif
>  static void gen_sc(DisasContext *ctx)
>  {
> @@ -4039,6 +4059,23 @@ static void gen_sc(DisasContext *ctx)
>      gen_exception_err(ctx, POWERPC_SYSCALL, lev);
>  }
> =20
> +#if defined(TARGET_PPC64)
> +#if !defined(CONFIG_USER_ONLY)
> +static void gen_scv(DisasContext *ctx)
> +{
> +    uint32_t lev;
> +
> +    if (unlikely(!ctx->scv_enabled)) {
> +        gen_exception_err(ctx, POWERPC_EXCP_FU, FSCR_IC_SCV);
> +        return;
> +    }
> +
> +    lev =3D (ctx->opcode >> 5) & 0x7F;
> +    gen_exception_err(ctx, POWERPC_SYSCALL_VECTORED, lev);
> +}
> +#endif
> +#endif
> +
>  /***                                Trap                                =
   ***/
> =20
>  /* Check for unconditional traps (always or never) */
> @@ -7031,6 +7068,12 @@ GEN_HANDLER(mcrf, 0x13, 0x00, 0xFF, 0x00000001, PP=
C_INTEGER),
>  GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
>  #if defined(TARGET_PPC64)
>  GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
> +#if !defined(CONFIG_USER_ONLY)
> +/* Top bit of opc2 corresponds with low bit of LEV, so use two handlers =
*/
> +GEN_HANDLER_E(scv, 0x11, 0x10, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
> +GEN_HANDLER_E(scv, 0x11, 0x00, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
> +GEN_HANDLER_E(rfscv, 0x13, 0x12, 0x02, 0x03FF8001, PPC_NONE, PPC2_ISA300=
),
> +#endif
>  GEN_HANDLER_E(stop, 0x13, 0x12, 0x0b, 0x03FFF801, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER_E(doze, 0x13, 0x12, 0x0c, 0x03FFF801, PPC_NONE, PPC2_PM_ISA2=
06),
>  GEN_HANDLER_E(nap, 0x13, 0x12, 0x0d, 0x03FFF801, PPC_NONE, PPC2_PM_ISA20=
6),
> @@ -7038,7 +7081,9 @@ GEN_HANDLER_E(sleep, 0x13, 0x12, 0x0e, 0x03FFF801, =
PPC_NONE, PPC2_PM_ISA206),
>  GEN_HANDLER_E(rvwinkle, 0x13, 0x12, 0x0f, 0x03FFF801, PPC_NONE, PPC2_PM_=
ISA206),
>  GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
>  #endif
> -GEN_HANDLER(sc, 0x11, 0xFF, 0xFF, 0x03FFF01D, PPC_FLOW),
> +/* Top bit of opc2 corresponds with low bit of LEV, so use two handlers =
*/
> +GEN_HANDLER(sc, 0x11, 0x11, 0xFF, 0x03FFF01D, PPC_FLOW),
> +GEN_HANDLER(sc, 0x11, 0x01, 0xFF, 0x03FFF01D, PPC_FLOW),
>  GEN_HANDLER(tw, 0x1F, 0x04, 0x00, 0x00000001, PPC_FLOW),
>  GEN_HANDLER(twi, 0x03, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
>  #if defined(TARGET_PPC64)
> @@ -7817,6 +7862,11 @@ static void ppc_tr_init_disas_context(DisasContext=
Base *dcbase, CPUState *cs)
>      } else {
>          ctx->vsx_enabled =3D false;
>      }
> +    if ((env->flags & POWERPC_FLAG_SCV) && (env->spr[SPR_FSCR] & (1ull <=
< FSCR_SCV))) {
> +        ctx->scv_enabled =3D true;
> +    } else {
> +        ctx->scv_enabled =3D false;
> +    }
>  #if defined(TARGET_PPC64)
>      if ((env->flags & POWERPC_FLAG_TM) && msr_tm) {
>          ctx->tm_enabled =3D !!msr_tm;
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index fd763e588e..18f275d4fa 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -3382,6 +3382,7 @@ static void init_excp_POWER9(CPUPPCState *env)
> =20
>  #if !defined(CONFIG_USER_ONLY)
>      env->excp_vectors[POWERPC_EXCP_HVIRT]    =3D 0x00000EA0;
> +    env->excp_vectors[POWERPC_EXCP_SYSCALL_VECTORED] =3D 0x00000000;
>  #endif
>  }
> =20
> @@ -9030,7 +9031,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>      pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
>                   POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
>                   POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
> -                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM;
> +                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
>      pcc->l1_dcache_size =3D 0x8000;
>      pcc->l1_icache_size =3D 0x8000;
>      pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1rguoi8KZGYj2k4L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl64rFYACgkQbDjKyiDZ
s5IHKRAAiVdBGcLxTmRlGnq4BB9D3yELogeYjx9GRqujtucV8d9+6btDhFcVDSkc
LElMz7f0fKpmlE3KR5/ZmntLdZPMhY15H/YaH+8QJSIzrA5f+GRll+5NQpjxOtGa
5RIaGbEAR4cExMbGDjNHMkNB8lTGOEUql9HVWPcQ/k69q1HyqtJij1h/ypDEySQb
gShoZShqPosPJlX0oKHKngUwbMedwOjYrYcZ2ZoG9TrNKHlW4obDtQeVEHTkPKYE
1oOpQK2BW92DJPx7TvEdS15OFuZc3oXB311qtOjQb8JYAMd8R48SE1lXPZsTjBJe
VGG5ZtW+a0fMKThwcsG8q4Y2Ty4Mgw3ILBWn+l7Yg3D4J5nkPXxTU14MH8TYwftc
B7f1NGuNP88m0YDelqIfs44i6O9P/Bc5/vxXsx73W6goL8SbrCOTFqLDM71OB394
VLRRP5U8ArG+nPd6tsJKAuVOuu/mZIwpQLTJQ25mEfWpwsmmBQhV0U3ZhXZ15Vhr
7qCQUqYYkeF3ueYlWeHfLKuYy5sICveJqRPIEvs4uai/5HTVHHm6JI5jMxdmz3Sr
X+ghkh6y/+LOE+yD8cR9ZfvyDgEKBrbtORPfEHpS/WRJJ3dcGe3SZHsKd5myyj6t
3o6tMGJ0txIftnBMhtVH4G8mxYVefGGlKlisbARd8GluKLnUwGU=
=ZKuG
-----END PGP SIGNATURE-----

--1rguoi8KZGYj2k4L--

