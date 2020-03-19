Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2148C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 06:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8D22072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 06:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="N3jkhgQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8D22072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEobV-0002Jn-JT
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 02:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jEoaM-0001LU-V9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 02:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jEoaK-0002Cy-K8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 02:23:18 -0400
Received: from ozlabs.org ([203.11.71.1]:47437)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jEoaJ-0002CU-VG; Thu, 19 Mar 2020 02:23:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48jcKY2YCRz9sPk; Thu, 19 Mar 2020 17:23:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584598993;
 bh=+4XBs/upme9Y0X3CX/zYbW9PkTL+5D/M8QfMDyPlb2g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N3jkhgQar8v6vggBynyIaMJXBrhOjpc266MgMqAkAblD+WzOwL1+GMX0smqJ3JTfH
 iros2uYd8CJ+Z0ahfau+onW1j8RbHQ/3tObahLnxw0AsfihYpB+szwp3jKx1ZXGZZL
 64ZbdbWX8jS8HfG/MifjMh56HNKp9UVaW+NhmZbQ=
Date: Thu, 19 Mar 2020 17:22:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 2/2] target/ppc: Add support for scv and rfscv
 instructions
Message-ID: <20200319062234.GK628315@umbus.fritz.box>
References: <20200317054918.199161-1-npiggin@gmail.com>
 <20200317054918.199161-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ucgz5Oc/kKURWzXs"
Content-Disposition: inline
In-Reply-To: <20200317054918.199161-2-npiggin@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--Ucgz5Oc/kKURWzXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 03:49:18PM +1000, Nicholas Piggin wrote:
> POWER9 adds scv and rfscv instructions and the system call vectored
> interrupt. Linux does not support this instruction yet but it has
> been tested with a modified kernel that runs on real hardware.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.1.

> ---
> Since v2:
> - Rebased on top of FWNMI series
>=20
>  linux-user/ppc/cpu_loop.c       |  1 +
>  target/ppc/cpu.h                |  7 ++-
>  target/ppc/excp_helper.c        | 98 ++++++++++++++++++++++++---------
>  target/ppc/helper.h             |  1 +
>  target/ppc/translate.c          | 46 +++++++++++++++-
>  target/ppc/translate_init.inc.c |  3 +-
>  6 files changed, 126 insertions(+), 30 deletions(-)
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
> index ed8d2015bd..992f0a49e8 100644
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
> @@ -475,6 +476,7 @@ typedef struct ppc_v3_pate_t {
>  /* Facility Status and Control (FSCR) bits */
>  #define FSCR_EBB        (63 - 56) /* Event-Based Branch Facility */
>  #define FSCR_TAR        (63 - 55) /* Target Address Register */
> +#define FSCR_SCV        (63 - 51) /* System call vectored */
>  /* Interrupt cause mask and position in FSCR. HFSCR has the same format =
*/
>  #define FSCR_IC_MASK    (0xFFULL)
>  #define FSCR_IC_POS     (63 - 7)
> @@ -484,6 +486,7 @@ typedef struct ppc_v3_pate_t {
>  #define FSCR_IC_TM          5
>  #define FSCR_IC_EBB         7
>  #define FSCR_IC_TAR         8
> +#define FSCR_IC_SCV        12
> =20
>  /* Exception state register bits definition                             =
     */
>  #define ESR_PIL   PPC_BIT(36) /* Illegal Instruction                    =
*/
> @@ -551,6 +554,8 @@ enum {
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
> index 81ee19ebae..73b5c28d03 100644
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
> @@ -723,12 +742,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
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
> @@ -741,14 +754,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
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
> @@ -783,14 +788,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
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
> @@ -799,10 +796,21 @@ static inline void powerpc_excp(PowerPCCPU *cpu, in=
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
> @@ -822,6 +830,37 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
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
> @@ -1162,6 +1201,11 @@ void helper_rfid(CPUPPCState *env)
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
> index cfb4c07085..ee1498050d 100644
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
> index 127c82a24e..eb0ddba850 100644
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
> @@ -4012,6 +4013,22 @@ static void gen_rfid(DisasContext *ctx)
>  #endif
>  }
> =20
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
> +
>  static void gen_hrfid(DisasContext *ctx)
>  {
>  #if defined(CONFIG_USER_ONLY)
> @@ -4030,6 +4047,7 @@ static void gen_hrfid(DisasContext *ctx)
>  #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL_USER
>  #else
>  #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL
> +#define POWERPC_SYSCALL_VECTORED POWERPC_EXCP_SYSCALL_VECTORED
>  #endif
>  static void gen_sc(DisasContext *ctx)
>  {
> @@ -4039,6 +4057,21 @@ static void gen_sc(DisasContext *ctx)
>      gen_exception_err(ctx, POWERPC_SYSCALL, lev);
>  }
> =20
> +#if defined(TARGET_PPC64)
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
> +
>  /***                                Trap                                =
   ***/
> =20
>  /* Check for unconditional traps (always or never) */
> @@ -7019,6 +7052,10 @@ GEN_HANDLER(mcrf, 0x13, 0x00, 0xFF, 0x00000001, PP=
C_INTEGER),
>  GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
>  #if defined(TARGET_PPC64)
>  GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
> +/* Top bit of opc2 corresponds with low bit of LEV, so use two handlers =
*/
> +GEN_HANDLER_E(scv, 0x11, 0x10, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
> +GEN_HANDLER_E(scv, 0x11, 0x00, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
> +GEN_HANDLER_E(rfscv, 0x13, 0x12, 0x02, 0x03FF8001, PPC_NONE, PPC2_ISA300=
),
>  GEN_HANDLER_E(stop, 0x13, 0x12, 0x0b, 0x03FFF801, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER_E(doze, 0x13, 0x12, 0x0c, 0x03FFF801, PPC_NONE, PPC2_PM_ISA2=
06),
>  GEN_HANDLER_E(nap, 0x13, 0x12, 0x0d, 0x03FFF801, PPC_NONE, PPC2_PM_ISA20=
6),
> @@ -7026,7 +7063,9 @@ GEN_HANDLER_E(sleep, 0x13, 0x12, 0x0e, 0x03FFF801, =
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
> @@ -7805,6 +7844,11 @@ static void ppc_tr_init_disas_context(DisasContext=
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
> index 0ae145e18d..15025cd5ea 100644
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

--Ucgz5Oc/kKURWzXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5zD6oACgkQbDjKyiDZ
s5K81w//ecS2+owNu7drMx2d1RAEb6tSfiMnfHOpXQspROhD0qr53rEFZup47v32
224WslgwHxQ7L+kMph7WxTUxX+qX3ArurqSmJbXNXagHHpmuZtaoVYpVaBeaIrll
h+O5HKe2IIUjjc8iOYnDWDLQafJtRR78VQuzr2oBIV8rdlZL/lt0X1bLpYdihNMt
t/eiQkcKUn55FggvscKvIlxfooypCvvyrjzxWCPqI7CoUWzf+Uw1E5oEeXkgVjbX
gU3myp2qz5pJM5y5tBhs1ZcCvn1B50iE6cstfDTktd9/Nmr6YifkbeGZksIc6bEO
BSYm7oJIXp4+2SjgIADqwgciRBfpYmsEIsbSn+EfFUNJSHzPLiHEaiJw4qRNFet1
j7OoWhcdZjc93aBDzkn+odcY+4GR3LIX+S8tRe211enmXJL5h7z1k/xUM72ua2LG
6ddvVbTb9ykC2O9DmTX2N0IJE4Uqj9Ul95jhSF5bv8+EmmTy62GFOTd2QgjpmhXw
ZJpv0bzuXRHdQjDbizXYyHSvfv/YOyIbWQor1g6rSgEtE40fskQdt+OYjahrmq1/
P3b5V45yIbDOsRKAekt1BgJ2cIo4mhnHnrwIbxqpwuo5nLysif/fSMZZVjK9YntR
R3dx1RKdl6DCBqVIcmLztxxYDS8kBnZXS4wSanzvAzqNMpDUurY=
=2WER
-----END PGP SIGNATURE-----

--Ucgz5Oc/kKURWzXs--

