Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B722C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBE32182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ai6nUB/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBE32182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35929 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOvpr-0005LY-2o
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 23:04:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjN-0000WC-Bd
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjL-0001BV-2e
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:53 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOvjK-00016y-BN; Thu, 09 May 2019 22:57:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450ZdM0qrHz9sMM; Fri, 10 May 2019 12:57:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557457063;
	bh=KlQ9fGrMu/G8oLqdJQI7SQVm5rs+fq57t6B//lsO1vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ai6nUB/n7VjYPBQ7sdxKCEozvPHIBSGseKKhRXFbSL1/KMobAyLJEZbBgQgrdbYVe
	7EN/hqx1Zh/Lxbtx7ecjpPST8YMH5frvcDfMDKfuyy3AOhqVWdkP9Tt0iu4cY+a9Rh
	dFHV2lExHQ3SyU5JGG081h9EHIBLoGInvVhZZJx8=
Date: Fri, 10 May 2019 12:09:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190510020909.GA20559@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190503055316.6441-6-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20190503055316.6441-6-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 05/13] target/ppc: Add
 privileged message send facilities
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:53:08PM +1000, Suraj Jitindar Singh wrote:
> Privileged message send facilities exist on POWER8 processors and later
> and include a register and instructions which can be used to generate,
> observe/modify the state of and clear privileged doorbell exceptions as
> described below.
>=20
> The Directed Privileged Doorbell Exception State (DPDES) register
> reflects the state of pending privileged doorbell exceptions and can
> also be used to modify that state. The register can be used to read and
> modify the state of privileged doorbell exceptions for all threads of a
> subprocessor and thus is a shared facility for that subprocessor. The
> register can be read/written by the hypervisor and read by the
> supervisor if enabled in the HFSCR, otherwise a hypervisor facility
> unavailable exception is generated.
>=20
> The privileged message send and clear instructions (msgsndp & msgclrp)
> are used to generate and clear the presence of a directed privileged
> doorbell exception, respectively. The msgsndp instruction can be used to
> target any thread of the current subprocessor, msgclrp acts on the
> thread issuing the instruction. These instructions are privileged, but
> will generate a hypervisor facility unavailable exception if not enabled
> in the HFSCR and executed in privileged non-hypervisor state.
>=20
> Add and implement this register and instructions by reading or modifying =
the
> pending interrupt state of the cpu.
>=20
> Note that TCG only supports one thread per core and so we only need to
> worry about the cpu making the access.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

I think this would be clearer if you put the framework for the
facility unavailable exception into a separate patch.  Apart from
that, LGTM.

> ---
>  target/ppc/cpu.h                |  7 +++++
>  target/ppc/excp_helper.c        | 63 +++++++++++++++++++++++++++++++++++=
++----
>  target/ppc/helper.h             |  5 ++++
>  target/ppc/misc_helper.c        | 46 ++++++++++++++++++++++++++++++
>  target/ppc/translate.c          | 28 ++++++++++++++++++
>  target/ppc/translate_init.inc.c | 40 ++++++++++++++++++++++++++
>  6 files changed, 184 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index e324064111..1d2a088391 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -425,6 +425,10 @@ typedef struct ppc_v3_pate_t {
>  #define PSSCR_ESL         PPC_BIT(42) /* Enable State Loss */
>  #define PSSCR_EC          PPC_BIT(43) /* Exit Criterion */
> =20
> +/* HFSCR bits */
> +#define HFSCR_MSGSNDP     PPC_BIT(53) /* Privileged Message Send Facilit=
ies */
> +#define HFSCR_IC_MSGSNDP  0xA
> +
>  #define msr_sf   ((env->msr >> MSR_SF)   & 1)
>  #define msr_isf  ((env->msr >> MSR_ISF)  & 1)
>  #define msr_shv  ((env->msr >> MSR_SHV)  & 1)
> @@ -1355,6 +1359,8 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHy=
pervisor *vhyp);
>  #endif
> =20
>  void store_fpscr(CPUPPCState *env, uint64_t arg, uint32_t mask);
> +void gen_hfscr_facility_check(DisasContext *ctx, int facility_sprn, int =
bit,
> +                              int sprn, int cause);
> =20
>  static inline uint64_t ppc_dump_gpr(CPUPPCState *env, int gprn)
>  {
> @@ -1501,6 +1507,7 @@ void ppc_compat_add_property(Object *obj, const cha=
r *name,
>  #define SPR_MPC_ICTRL         (0x09E)
>  #define SPR_MPC_BAR           (0x09F)
>  #define SPR_PSPB              (0x09F)
> +#define SPR_DPDES             (0x0B0)
>  #define SPR_DAWR              (0x0B4)
>  #define SPR_RPR               (0x0BA)
>  #define SPR_CIABR             (0x0BB)
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index beafcf1ebd..7a4da7bdba 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -461,6 +461,13 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>          env->spr[SPR_FSCR] |=3D ((target_ulong)env->error_code << 56);
>  #endif
>          break;
> +    case POWERPC_EXCP_HV_FU:     /* Hypervisor Facility Unavailable Exce=
ption */
> +        env->spr[SPR_HFSCR] |=3D ((target_ulong)env->error_code << FSCR_=
IC_POS);
> +        srr0 =3D SPR_HSRR0;
> +        srr1 =3D SPR_HSRR1;
> +        new_msr |=3D (target_ulong)MSR_HVB;
> +        new_msr |=3D env->msr & ((target_ulong)1 << MSR_RI);
> +        break;
>      case POWERPC_EXCP_PIT:       /* Programmable interval timer interrup=
t    */
>          LOG_EXCP("PIT exception\n");
>          break;
> @@ -884,7 +891,11 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>          }
>          if (env->pending_interrupts & (1 << PPC_INTERRUPT_DOORBELL)) {
>              env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_DOORBELL);
> -            powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_DOORI);
> +            if (env->insns_flags & PPC_SEGMENT_64B) {
> +                powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_SDOOR);
> +            } else {
> +                powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_DOORI);
> +            }
>              return;
>          }
>          if (env->pending_interrupts & (1 << PPC_INTERRUPT_HDOORBELL)) {
> @@ -1202,19 +1213,26 @@ void helper_msgsnd(target_ulong rb)
>  }
> =20
>  /* Server Processor Control */
> -static int book3s_dbell2irq(target_ulong rb)
> +static int book3s_dbell2irq(target_ulong rb, bool hv_dbell)
>  {
>      int msg =3D rb & DBELL_TYPE_MASK;
> =20
>      /* A Directed Hypervisor Doorbell message is sent only if the
>       * message type is 5. All other types are reserved and the
>       * instruction is a no-op */
> -    return msg =3D=3D DBELL_TYPE_DBELL_SERVER ? PPC_INTERRUPT_HDOORBELL =
: -1;
> +    if (msg =3D=3D DBELL_TYPE_DBELL_SERVER) {
> +        if (hv_dbell)
> +            return PPC_INTERRUPT_HDOORBELL;
> +        else
> +            return PPC_INTERRUPT_DOORBELL;
> +    }
> +
> +    return -1;
>  }
> =20
>  void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
>  {
> -    int irq =3D book3s_dbell2irq(rb);
> +    int irq =3D book3s_dbell2irq(rb, 1);
> =20
>      if (irq < 0) {
>          return;
> @@ -1225,7 +1243,42 @@ void helper_book3s_msgclr(CPUPPCState *env, target=
_ulong rb)
> =20
>  void helper_book3s_msgsnd(target_ulong rb)
>  {
> -    int irq =3D book3s_dbell2irq(rb);
> +    int irq =3D book3s_dbell2irq(rb, 1);
> +    int pir =3D rb & DBELL_PROCIDTAG_MASK;
> +    CPUState *cs;
> +
> +    if (irq < 0) {
> +        return;
> +    }
> +
> +    qemu_mutex_lock_iothread();
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +        CPUPPCState *cenv =3D &cpu->env;
> +
> +        /* TODO: broadcast message to all threads of the same  processor=
 */
> +        if (cenv->spr_cb[SPR_PIR].default_value =3D=3D pir) {
> +            cenv->pending_interrupts |=3D 1 << irq;
> +            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +        }
> +    }
> +    qemu_mutex_unlock_iothread();
> +}
> +
> +void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
> +{
> +    int irq =3D book3s_dbell2irq(rb, 0);
> +
> +    if (irq < 0) {
> +        return;
> +    }
> +
> +    env->pending_interrupts &=3D ~(1 << irq);
> +}
> +
> +void helper_book3s_msgsndp(target_ulong rb)
> +{
> +    int irq =3D book3s_dbell2irq(rb, 0);
>      int pir =3D rb & DBELL_PROCIDTAG_MASK;
>      CPUState *cs;
> =20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 6aee195528..040f59d1af 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -657,6 +657,8 @@ DEF_HELPER_1(msgsnd, void, tl)
>  DEF_HELPER_2(msgclr, void, env, tl)
>  DEF_HELPER_1(book3s_msgsnd, void, tl)
>  DEF_HELPER_2(book3s_msgclr, void, env, tl)
> +DEF_HELPER_1(book3s_msgsndp, void, tl)
> +DEF_HELPER_2(book3s_msgclrp, void, env, tl)
>  #endif
> =20
>  DEF_HELPER_4(dlmzb, tl, env, tl, tl, i32)
> @@ -674,6 +676,7 @@ DEF_HELPER_3(store_dcr, void, env, tl, tl)
> =20
>  DEF_HELPER_2(load_dump_spr, void, env, i32)
>  DEF_HELPER_2(store_dump_spr, void, env, i32)
> +DEF_HELPER_4(hfscr_facility_check, void, env, i32, i32, i32)
>  DEF_HELPER_4(fscr_facility_check, void, env, i32, i32, i32)
>  DEF_HELPER_4(msr_facility_check, void, env, i32, i32, i32)
>  DEF_HELPER_FLAGS_1(load_tbl, TCG_CALL_NO_RWG, tl, env)
> @@ -688,6 +691,8 @@ DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl=
, env)
>  DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
>  DEF_HELPER_FLAGS_2(store_purr, TCG_CALL_NO_RWG, void, env, tl)
>  DEF_HELPER_2(store_ptcr, void, env, tl)
> +DEF_HELPER_FLAGS_1(load_dpdes, TCG_CALL_NO_RWG, tl, env)
> +DEF_HELPER_FLAGS_2(store_dpdes, TCG_CALL_NO_RWG, void, env, tl)
>  #endif
>  DEF_HELPER_2(store_sdr1, void, env, tl)
>  DEF_HELPER_2(store_pidr, void, env, tl)
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index c65d1ade15..d7d4acca7f 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -39,6 +39,17 @@ void helper_store_dump_spr(CPUPPCState *env, uint32_t =
sprn)
>  }
> =20
>  #ifdef TARGET_PPC64
> +static void raise_hv_fu_exception(CPUPPCState *env, uint32_t bit,
> +                                  uint32_t sprn, uint32_t cause,
> +                                  uintptr_t raddr)
> +{
> +    qemu_log("Facility SPR %d is unavailable (SPR HFSCR:%d)\n", sprn, bi=
t);
> +
> +    env->spr[SPR_HFSCR] &=3D ~((target_ulong)FSCR_IC_MASK << FSCR_IC_POS=
);
> +
> +    raise_exception_err_ra(env, POWERPC_EXCP_HV_FU, cause, raddr);
> +}
> +
>  static void raise_fu_exception(CPUPPCState *env, uint32_t bit,
>                                 uint32_t sprn, uint32_t cause,
>                                 uintptr_t raddr)
> @@ -53,6 +64,17 @@ static void raise_fu_exception(CPUPPCState *env, uint3=
2_t bit,
>  }
>  #endif
> =20
> +void helper_hfscr_facility_check(CPUPPCState *env, uint32_t bit,
> +                                 uint32_t sprn, uint32_t cause)
> +{
> +#ifdef TARGET_PPC64
> +    if ((env->msr_mask & MSR_HVB) && !msr_hv &&
> +                                     !(env->spr[SPR_HFSCR] & (1UL << bit=
))) {
> +        raise_hv_fu_exception(env, bit, sprn, cause, GETPC());
> +    }
> +#endif
> +}
> +
>  void helper_fscr_facility_check(CPUPPCState *env, uint32_t bit,
>                                  uint32_t sprn, uint32_t cause)
>  {
> @@ -107,6 +129,30 @@ void helper_store_pcr(CPUPPCState *env, target_ulong=
 value)
> =20
>      env->spr[SPR_PCR] =3D value & pcc->pcr_mask;
>  }
> +
> +target_ulong helper_load_dpdes(CPUPPCState *env)
> +{
> +    helper_hfscr_facility_check(env, HFSCR_MSGSNDP, SPR_DPDES,
> +                                HFSCR_IC_MSGSNDP);
> +
> +    if (env->pending_interrupts & (1 << PPC_INTERRUPT_DOORBELL))
> +        return 1;
> +    return 0;
> +}
> +
> +void helper_store_dpdes(CPUPPCState *env, target_ulong val)
> +{
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +    CPUState *cs =3D CPU(cpu);
> +
> +    if (val) {
> +        /* Only one cpu for now */
> +        env->pending_interrupts |=3D 1 << PPC_INTERRUPT_DOORBELL;
> +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +    } else {
> +        env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_DOORBELL);
> +    }
> +}
>  #endif /* defined(TARGET_PPC64) */
> =20
>  void helper_store_pidr(CPUPPCState *env, target_ulong val)
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index fb42585a1c..2c3e83d18e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6537,6 +6537,30 @@ static void gen_msgsnd(DisasContext *ctx)
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
> =20
> +static void gen_msgclrp(DisasContext *ctx)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    GEN_PRIV;
> +#else
> +    CHK_SV;
> +    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGSNDP, 0,
> +                             HFSCR_IC_MSGSNDP);
> +    gen_helper_book3s_msgclrp(cpu_env, cpu_gpr[rB(ctx->opcode)]);
> +#endif /* defined(CONFIG_USER_ONLY) */
> +}
> +
> +static void gen_msgsndp(DisasContext *ctx)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    GEN_PRIV;
> +#else
> +    CHK_SV;
> +    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGSNDP, 0,
> +                             HFSCR_IC_MSGSNDP);
> +    gen_helper_book3s_msgsndp(cpu_gpr[rB(ctx->opcode)]);
> +#endif /* defined(CONFIG_USER_ONLY) */
> +}
> +
>  static void gen_msgsync(DisasContext *ctx)
>  {
>  #if defined(CONFIG_USER_ONLY)
> @@ -7054,6 +7078,10 @@ GEN_HANDLER2_E(msgclr, "msgclr", 0x1F, 0x0E, 0x07,=
 0x03ff0001,
>                 PPC_NONE, PPC2_PRCNTL),
>  GEN_HANDLER2_E(msgsync, "msgsync", 0x1F, 0x16, 0x1B, 0x00000000,
>                 PPC_NONE, PPC2_PRCNTL),
> +GEN_HANDLER2_E(msgsndp, "msgsndp", 0x1F, 0x0E, 0x04, 0x03ff0001,
> +               PPC_NONE, PPC2_ISA207S),
> +GEN_HANDLER2_E(msgclrp, "msgclrp", 0x1F, 0x0E, 0x05, 0x03ff0001,
> +               PPC_NONE, PPC2_ISA207S),
>  GEN_HANDLER(wrtee, 0x1F, 0x03, 0x04, 0x000FFC01, PPC_WRTEE),
>  GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
>  GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 8e287066e5..46f9399097 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -454,6 +454,19 @@ static void spr_write_pcr(DisasContext *ctx, int spr=
n, int gprn)
>  {
>      gen_helper_store_pcr(cpu_env, cpu_gpr[gprn]);
>  }
> +
> +/* DPDES */
> +static void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
> +{
> +    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGSNDP, sprn,
> +                             HFSCR_IC_MSGSNDP);
> +    gen_helper_load_dpdes(cpu_gpr[gprn], cpu_env);
> +}
> +
> +static void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
> +{
> +    gen_helper_store_dpdes(cpu_env, cpu_gpr[gprn]);
> +}
>  #endif
>  #endif
> =20
> @@ -7478,6 +7491,20 @@ POWERPC_FAMILY(e600)(ObjectClass *oc, void *data)
>  #define POWERPC970_HID5_INIT 0x00000000
>  #endif
> =20
> +void gen_hfscr_facility_check(DisasContext *ctx, int facility_sprn, int =
bit,
> +                              int sprn, int cause)
> +{
> +    TCGv_i32 t1 =3D tcg_const_i32(bit);
> +    TCGv_i32 t2 =3D tcg_const_i32(sprn);
> +    TCGv_i32 t3 =3D tcg_const_i32(cause);
> +
> +    gen_helper_hfscr_facility_check(cpu_env, t1, t2, t3);
> +
> +    tcg_temp_free_i32(t3);
> +    tcg_temp_free_i32(t2);
> +    tcg_temp_free_i32(t1);
> +}
> +
>  static void gen_fscr_facility_check(DisasContext *ctx, int facility_sprn,
>                                      int bit, int sprn, int cause)
>  {
> @@ -8249,6 +8276,17 @@ static void gen_spr_power8_rpr(CPUPPCState *env)
>  #endif
>  }
> =20
> +static void gen_spr_power8_dpdes(CPUPPCState *env)
> +{
> +#if !defined(CONFIG_USER_ONLY)
> +    spr_register_kvm_hv(env, SPR_DPDES, "DPDES",
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        &spr_read_dpdes, SPR_NOACCESS,
> +                        &spr_read_dpdes, &spr_write_dpdes,
> +                        KVM_REG_PPC_DPDES, 0x0UL);
> +#endif
> +}
> +
>  static void gen_spr_power9_mmu(CPUPPCState *env)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> @@ -8637,6 +8675,7 @@ static void init_proc_POWER8(CPUPPCState *env)
>      gen_spr_power8_ic(env);
>      gen_spr_power8_book4(env);
>      gen_spr_power8_rpr(env);
> +    gen_spr_power8_dpdes(env);
> =20
>      /* env variables */
>      env->dcache_line_size =3D 128;
> @@ -8826,6 +8865,7 @@ static void init_proc_POWER9(CPUPPCState *env)
>      gen_spr_power8_ic(env);
>      gen_spr_power8_book4(env);
>      gen_spr_power8_rpr(env);
> +    gen_spr_power8_dpdes(env);
>      gen_spr_power9_mmu(env);
> =20
>      /* POWER9 Specific registers */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzU3UUACgkQbDjKyiDZ
s5KBZBAAyQ6PDeROgeq9TFXsIt1Si/6g45i1CNylAFDVImn7dAVSxyzueRdUTj7k
SA0i++V1b/5PSoYGcn8T4QDtk5qXs7X9nNnvoBS75P3N5gJl4CIj8vAaKfPF0bJy
UPzI2lcMTglmd/pAwn3g5M79KPaaX/lWThWVv9h0zsFWiGdYNQKN/RCpel/DTqpp
7biYlhRW4zJKJ4xGXhKIWlS7C+SxmF0a/wdq0FnPWAIjx4kBz8j40mszKiJ/UU/Z
sj2qGg0oOXewU71C1V1dfoKFq65VIc8HzLuOlzVWsnXzVD7G2GU3RTREkF47Q1Ba
9C/gXh96R7yiTyMEZJcndeByL5EaRFTpXuVAQQmMjFil546KlZ+O8t9w/1bupRPn
NwLYSKWgxOGNwXOdUgIwW3tlmyrwcO/PTsyMrZpgS5wlsDddsIjqSD9j4nitjakv
2JVMv6cO33rPgAUyibPAiolk1U7wI7pjtrXBJgva7K8RX06KtuyDbXCa8ShorfLf
XFqUGwO3WYLSTU7vj9FEnydCv8Tnwuj9lvDGjn/1zQxQz9bD92+sIxd1fc8yRqDQ
pnD/rlo0U7xZDG6+LeXW0i8j341mEZBLZys0mlWDhU5dJpNhO1Do0zW6ch3bnTH3
DhLyRqwih99NryBtOxsxmGeX4dZ/5o/W+uTTRTbs/cdPOVzSXNA=
=UJum
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

