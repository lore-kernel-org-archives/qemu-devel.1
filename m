Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A335BC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA68206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA68206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haMrE-000212-Mk
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 12:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57405)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1haMjv-0003pm-FZ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1haMjp-0008H1-Re
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:01:43 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39955)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1haMjp-0007tW-CY
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:01:37 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MfYHW-1gugBH4A2K-00g0yA; Mon, 10 Jun 2019 18:01:00 +0200
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>, qemu-devel@nongnu.org
References: <20190609164349.GA60211@localhost.localdomain>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4303b9d8-c66c-adf1-de97-6ade8f3fb427@vivier.eu>
Date: Mon, 10 Jun 2019 18:00:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190609164349.GA60211@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Gxx3+Xs9CFRv/wXejZVq7IpidHmfpafsGP7/w/uLAMvLAPUCzkE
 YGh0vbI3qwmIVo3NYk2H4ljYYDkx7YCkzMAg4BhO/qYD+rGWdSZDoHH+dcNHzFbAYLGdEMg
 +RQ6AqPSRqao+ULWqwB2ELfBVbrPbi2pcsqjd4p95UMBuRkG4ZD4rIVX3m8u4z+BXIr9gyM
 so71OOVgm9HlieQx/EjFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QAlQdzBu/rY=:HStjhWmjQFy+NimZ+YZRfV
 7xZ7hw5m0CNuzov+QpmXvEucTPmcPeyxFS5ZGoIYbVcdn5d0/FBULPpSFhUMO+CTBW6IyB97A
 kzogNOVjd97H6ZSQoNbQ0hgHGpB1gyXUjLy6qTqgcTp72Qo9pI6n/Ds3uJ85BAlugSGDdjs+q
 ebki1V560EJSEr0qMMgvsUtAb8q+Q1ScVVMvd9pYDHcdk2cmXuFA6IwMay9hwe3348lFSH7hh
 Veh9hvmiNBj47bq/h6kaK3+w/MM32EPkewm7S/X105+YlU90D1UVcrpBIcLTc4pEgTA2TMK5r
 ARo25H1J/UOB5/z5njYg19sHpvIfUb3g2kG4muo/OZZtUbL5PJX6l747DKynCS6DNtX/mVaq2
 Aet8bSZwQuL1t/8EUQDjvyYTYgLjXXUVz4dxKuLqN/d/pTpTBhfJK7Wxyjg8nPrGUVTrr9l+5
 KlWSao0ZDLStpErkHsjlzjC37it54n+d7ydlqvSPu8zd+MqGFcPJt0dvPdly0jSK+C2Bm4H1d
 63HzApuUC7O7a3HqLp2wkc297YSv1F038C2ZghgXQQwwb0TqECM/XNRrBU0xNzKWqeqslKjdf
 PFKNEveNzRgrVcrPODKKDIZxBsyhk58ZAL7nTN8/bJ9BmeX+FD8eOlwLcOOffCr5FkhtnjMYq
 AyMN9DqDbnQYIZQUVBtUvCPg07ErsEN0bVc0ihFisFi3UyjY73MIaqiL4/IGDvaSVRYaZaDKv
 +ECI0QHS5m/THMaW3I8BywAPfwiSq8OHMv9rXka3tLOxWq/hRTg1vVaTZ1k=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH v2] Incorrect Stack Pointer shadow register
 support on some m68k CPUs
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

Le 09/06/2019 à 18:43, Lucien Murray-Pitts a écrit :
> Brief overview;
> - Added "CPU class" m68k_feature to each CPU init
>   so MOVEC can detect wrong CR (Control Register) access
> - Added cascaded "inheritance" of m68k_features by calling m680xx_cpu_initfn()
>   of previous CPU so that 68060 inherits 68040, and so on
> - Added comments above m680xx_cpu_initfn to identify additional supported
>   features for that CPU class
> - Added more detailed comments, including CPU classes supported,
>   to enum m68k_features
> - Added more detailed comments to each case of m68k_move_to/from helpers
>   to list the supported CPUs for that CR
> - Added CPU class detection for each CR type, exits switch if unsupported
> - Added ILLEGAL INSTRUCITON exception condition when the helper fails to
>   decode the CR
> - Moved abort only to handle unimplemented control registers,
>   all other unknown CR will cause ILLEGAL instruciton
> - Fixed m68k_switch_sp so it switches only if MSP feature is implemented
> - Changed the MOVEC instruction in translate to be 68010 not 68000
> - Added missing BUSCR/PCR CR defines, and decodes for helpers for the 68060


For readability, could you split this patch in several ones?

For instance, one patch by item of the list above?
Globally, the approach looks good, but I'm not convinced we need one
feature bit for each CPU.

Thanks,
Laurent

> Long overview;
> The 68000 does not support the MOVEC instruction, it was added with the 68010.
> 
> Futher on the 68010, and CPU32 the ISP doesnt exist.
> These CPUs only have SSP/USP.
> 
> On supporting CPUs the SR register also implements a single bit,  the "M"
> (master-mode) bit that determines which of the ISP/MSP is active at the time.
> 
> When not supported by the CPU the MOVEC instruction when accessing these
> shadow registers should issue an ILLEGAL INSTRUCTION exception.
> 
> Futher this patch adds classes for each CPU family 680[012346] so that
> illegal access to specific control registers can be checked.
> 
> Additional comments added to the features set to claify
> exactly what differentiates each class.  (m68k_features)
> 
> The helpers m68k_movec_to, and m68k_movec_from have been updated to support
> the exception ILLEGAL INSTRUCTION for all control registers that
> are illegal per CPU class, and for any unkown control register.
> 
> Added defines for BUS, and Processor Configuration Register (PCR) for MC68060,
> and case statements in the helper for the missing Cache Address Register (CAAR),
> and the new BUS, and PCR which results in a cpu abort (unimplemented).
> 
> All other cases will result in an ILLEGAL INSTRUCTION exception as per the
> manual.
> 
> Because the MSP support results in an illegal instruction exception
> if the wrong Control Register is accessed then it was necessary to
> know the CPU class in the MOVEC instruction.
> 
> To do this a sizable overhaul of the CPU initialize funcitons was needed
> to add a feature showing the CPU class.
> 
> So in the CPU classes the m680XX_cpu_initfn functions have been rearranged
> to cascade starting from the base 68000, so that the 68010 then inherits
> from this, and so on until the 68060.
> 
> Because each cpu class inherits the previous CPU class, then for example
> the 68020 also has the feature 68010, and 68000 and so on upto the 68060.
> 
> Added some more detailed comments to each cpu initialization function
> to make it clear the instructions added/changed for that CPU to make
> future debugging easier, and the reason for the feature flags more clear.
> 
> These comments could go deeper into explaining supported/ehnaced modes,
> but this wasnt done in this patch.
> 
> There are comments in the existing code referring to the EC/L/and-so-on
> classes, however no code has been implemented to handle these specific
> varitations of each CPU class, and so no m68k_feature was mde to
> distinguish them that way.
> 
> Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
> ---
> 
> Notes:
>     v1->v2
>       - Submitted previous patch to fix existing non-compliant comment style 
>       - Added a comment about sp in CPUM68KState structure
>       - updated movec in the same patch to issue exception
>       - Reworked code in m68k_movec_from()/m68k_movec_to() because 
>         as they trigger a cpu_abort() with unknown code, 
>       - Above rework then required some additions for CPU class and so on.
>       - Maybe this is becoming more of an RFC? / should be split for the rework?
> 
> Based-on: 20190606234125.GA4830@localhost.localdomain
> ([PATCH v2] m68k comments break patch submission due to being incorrectly formatted)
> 
>  target/m68k/cpu.c       | 112 ++++++++++++++----
>  target/m68k/cpu.h       |  56 ++++++---
>  target/m68k/helper.c    | 247 +++++++++++++++++++++++++++++++---------
>  target/m68k/translate.c |   4 +-
>  4 files changed, 326 insertions(+), 93 deletions(-)
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index c144278661..09f3514715 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -42,6 +42,11 @@ static void m68k_set_feature(CPUM68KState *env, int feature)
>      env->features |= (1u << feature);
>  }
>  
> +static void m68k_unset_feature(CPUM68KState *env, int feature)
> +{
> +    env->features &= (-1u - (1u << feature));
> +}
> +
>  /* CPUClass::reset() */
>  static void m68k_cpu_reset(CPUState *s)
>  {
> @@ -104,6 +109,10 @@ static void m5206_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_CF_ISA_A);
>  }
>  
> +
> +/*
> + * Base feature set, including isns. for m68k family
> + */
>  static void m68000_cpu_initfn(Object *obj)
>  {
>      M68kCPU *cpu = M68K_CPU(obj);
> @@ -115,14 +124,36 @@ static void m68000_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_MOVEP);
>  }
>  
> +
> +/*
> + * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD
> + */
> +static void m68010_cpu_initfn(Object *obj)
> +{
> +    M68kCPU *cpu = M68K_CPU(obj);
> +    CPUM68KState *env = &cpu->env;
> +
> +    m68000_cpu_initfn(obj);
> +    m68k_set_feature(env, M68K_FEATURE_M68010);
> +    m68k_set_feature(env, M68K_FEATURE_RTD);
> +    m68k_set_feature(env, M68K_FEATURE_BKPT);
> +    m68k_set_feature(env, M68K_FEATURE_MSP);
> +}
> +
> +
> +/*
> + * Adds BFCHG, BFCLR, BFEXTS, BFEXTU, BFFFO, BFINS, BFSET, BFTST, CAS, CAS2,
> + *      CHK2, CMP2, DIVSL, DIVUL, EXTB, PACK, TRAPcc, UNPK.
> + *
> + * 68020/30 Only:CALLM, cpBcc, cpDBcc, cpGEN, cpRESTORE, cpSAVE, cpScc, cpTRAPcc
> + */
>  static void m68020_cpu_initfn(Object *obj)
>  {
>      M68kCPU *cpu = M68K_CPU(obj);
>      CPUM68KState *env = &cpu->env;
>  
> -    m68k_set_feature(env, M68K_FEATURE_M68000);
> -    m68k_set_feature(env, M68K_FEATURE_USP);
> -    m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
> +    m68010_cpu_initfn(obj);
> +    m68k_set_feature(env, M68K_FEATURE_M68020);
>      m68k_set_feature(env, M68K_FEATURE_QUAD_MULDIV);
>      m68k_set_feature(env, M68K_FEATURE_BRAL);
>      m68k_set_feature(env, M68K_FEATURE_BCCL);
> @@ -132,43 +163,79 @@ static void m68020_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_LONG_MULDIV);
>      m68k_set_feature(env, M68K_FEATURE_FPU);
>      m68k_set_feature(env, M68K_FEATURE_CAS);
> -    m68k_set_feature(env, M68K_FEATURE_BKPT);
> -    m68k_set_feature(env, M68K_FEATURE_RTD);
>      m68k_set_feature(env, M68K_FEATURE_CHK2);
> -    m68k_set_feature(env, M68K_FEATURE_MOVEP);
>  }
> -#define m68030_cpu_initfn m68020_cpu_initfn
>  
> -static void m68040_cpu_initfn(Object *obj)
> +
> +/*
> + * Adds: PFLUSH (*5)
> + * 68030 Only: PFLUSHA (*5), PLOAD (*5), PMOVE
> + * 68030/40 Only: PTEST
> + *
> + * NOTES:
> + *  5. Not valid on MC68EC030
> + */
> +static void m68030_cpu_initfn(Object *obj)
>  {
>      M68kCPU *cpu = M68K_CPU(obj);
>      CPUM68KState *env = &cpu->env;
>  
>      m68020_cpu_initfn(obj);
> +    m68k_set_feature(env, M68K_FEATURE_M68030);
> +}
> +
> +
> +/*
> + * Adds: CINV, CPUSH
> + * Adds all with Note *2: FABS, FSABS, FDABS, FADD, FSADD, FDADD, FBcc, FCMP,
> + *                        FDBcc, FDIV, FSDIV, FDDIV, FMOVE, FSMOVE, FDMOVE,
> + *                        FMOVEM, FMUL, FSMUL, FDMUL, FNEG, FSNEG, FDNEG, FNOP,
> + *                        FRESTORE, FSAVE, FScc, FSQRT, FSSQRT, FDSQRT, FSUB,
> + *                        FSSUB, FDSUB, FTRAPcc, FTST
> + *
> + * Adds with Notes *2, and *3: FACOS, FASIN, FATAN, FATANH, FCOS, FCOSH, FETOX,
> + *                             FETOXM, FGETEXP, FGETMAN, FINT, FINTRZ, FLOG10,
> + *                             FLOG2, FLOGN, FLOGNP1, FMOD, FMOVECR, FREM,
> + *                             FSCALE, FSGLDIV, FSGLMUL, FSIN, FSINCOS, FSINH,
> + *                             FTAN, FTANH, FTENTOX, FTWOTOX
> + * NOTES:
> + * 2. Not applicable to the MC68EC040, MC68LC040, MC68EC060, and MC68LC060.
> + * 3. These are software-supported instructions on the MC68040 and MC68060.
> + */
> +static void m68040_cpu_initfn(Object *obj)
> +{
> +    M68kCPU *cpu = M68K_CPU(obj);
> +    CPUM68KState *env = &cpu->env;
> +
> +    m68030_cpu_initfn(obj);
>      m68k_set_feature(env, M68K_FEATURE_M68040);
>  }
>  
> +
> +/*
> + * Adds: PLPA
> + * Adds all with Note *2: CAS, CAS2, MULS, MULU, CHK2, CMP2, DIVS, DIVU
> + * All Fxxxx instructions are as per m68040 with exception to; FMOVEM NOTE3
> + *
> + * Does NOT implement MOVEP
> + *
> + * NOTES:
> + * 2. Not applicable to the MC68EC040, MC68LC040, MC68EC060, and MC68LC060.
> + * 3. These are software-supported instructions on the MC68040 and MC68060.
> + */
>  static void m68060_cpu_initfn(Object *obj)
>  {
>      M68kCPU *cpu = M68K_CPU(obj);
>      CPUM68KState *env = &cpu->env;
>  
> -    m68k_set_feature(env, M68K_FEATURE_M68000);
> -    m68k_set_feature(env, M68K_FEATURE_USP);
> -    m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
> -    m68k_set_feature(env, M68K_FEATURE_BRAL);
> -    m68k_set_feature(env, M68K_FEATURE_BCCL);
> -    m68k_set_feature(env, M68K_FEATURE_BITFIELD);
> -    m68k_set_feature(env, M68K_FEATURE_EXT_FULL);
> -    m68k_set_feature(env, M68K_FEATURE_SCALED_INDEX);
> -    m68k_set_feature(env, M68K_FEATURE_LONG_MULDIV);
> -    m68k_set_feature(env, M68K_FEATURE_FPU);
> -    m68k_set_feature(env, M68K_FEATURE_CAS);
> -    m68k_set_feature(env, M68K_FEATURE_BKPT);
> -    m68k_set_feature(env, M68K_FEATURE_RTD);
> -    m68k_set_feature(env, M68K_FEATURE_CHK2);
> +    m68040_cpu_initfn(obj);
> +    m68k_unset_feature(env, M68K_FEATURE_MOVEP);
> +
> +    /* Implemented as a software feature */
> +    m68k_unset_feature(env, M68K_FEATURE_QUAD_MULDIV);
>  }
>  
> +
>  static void m5208_cpu_initfn(Object *obj)
>  {
>      M68kCPU *cpu = M68K_CPU(obj);
> @@ -303,6 +370,7 @@ static const TypeInfo m68k_cpus_type_infos[] = {
>          .class_init = m68k_cpu_class_init,
>      },
>      DEFINE_M68K_CPU_TYPE("m68000", m68000_cpu_initfn),
> +    DEFINE_M68K_CPU_TYPE("m68010", m68010_cpu_initfn),
>      DEFINE_M68K_CPU_TYPE("m68020", m68020_cpu_initfn),
>      DEFINE_M68K_CPU_TYPE("m68030", m68030_cpu_initfn),
>      DEFINE_M68K_CPU_TYPE("m68040", m68040_cpu_initfn),
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 3c4d7de017..7a8e4872e2 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -93,7 +93,13 @@ typedef struct CPUM68KState {
>      uint32_t pc;
>      uint32_t sr;
>  
> -    /* SSP and USP.  The current_sp is stored in aregs[7], the other here.  */
> +    /*
> +     * The 68020/30/40 support two supervisor stacks, ISP and MSP.
> +     * The 68000/10, Coldfire, and CPU32 only have USP/SSP.
> +     *
> +     * The current_sp is stored in aregs[7], the other here.
> +     * The USP, SSP, and if used the additional ISP for 68020/30/40.
> +     */
>      int current_sp;
>      uint32_t sp[3];
>  
> @@ -411,6 +417,10 @@ typedef enum {
>  #define M68K_CR_DACR0    0x006
>  #define M68K_CR_DACR1    0x007
>  
> +/* MC68060 */
> +#define M68K_CR_BUSCR    0x008
> +#define M68K_CR_PCR      0x808
> +
>  #define M68K_FPIAR_SHIFT  0
>  #define M68K_FPIAR        (1 << M68K_FPIAR_SHIFT)
>  #define M68K_FPSR_SHIFT   1
> @@ -468,36 +478,50 @@ void m68k_switch_sp(CPUM68KState *env);
>  void do_m68k_semihosting(CPUM68KState *env, int nr);
>  
>  /*
> + * The 68000 family is defined in six main CPU classes, the 680[012346]0.
> + * Generally each successive CPU adds enhanced data/stack/instructions.
> + * However, some features are only common to one, or a few classes.
> + * The features covers those subsets of instructons.
> + *
> + * CPU32/32+ are basically 680010 compatible with some 68020 class instructons,
> + * and some additional CPU32 instructions. Mostly Supervisor state differences.
> + *
> + * The ColdFire core ISA is a RISC-style reduction of the 68000 series cpu.
>   * There are 4 ColdFire core ISA revisions: A, A+, B and C.
>   * Each feature covers the subset of instructions common to the
>   * ISA revisions mentioned.
>   */
>  
>  enum m68k_features {
> -    M68K_FEATURE_M68000,
> -    M68K_FEATURE_CF_ISA_A,
> +    M68K_FEATURE_M68000,   /* Base m68k instruction set */
> +    M68K_FEATURE_M68010,   /* Additional insn. specific to MC68010 */
> +    M68K_FEATURE_M68020,   /* Additional insn. specific to MC68020 */
> +    M68K_FEATURE_M68030,   /* Additional insn. specific to MC68030 */
> +    M68K_FEATURE_M68040,   /* Additional insn. specific to MC68040 */
> +    M68K_FEATURE_M68060,   /* Additional insn. specific to MC68060 */
> +    M68K_FEATURE_CF_ISA_A, /* Base Coldfire set Rev A. */
>      M68K_FEATURE_CF_ISA_B, /* (ISA B or C).  */
>      M68K_FEATURE_CF_ISA_APLUSC, /* BIT/BITREV, FF1, STRLDSR (ISA A+ or C).  */
> -    M68K_FEATURE_BRAL, /* Long unconditional branch.  (ISA A+ or B).  */
> +    M68K_FEATURE_BRAL, /* BRA with Long branch.  (680[2346]0, ISA A+ or B). */
>      M68K_FEATURE_CF_FPU,
>      M68K_FEATURE_CF_MAC,
>      M68K_FEATURE_CF_EMAC,
>      M68K_FEATURE_CF_EMAC_B, /* Revision B EMAC (dual accumulate).  */
> -    M68K_FEATURE_USP, /* User Stack Pointer.  (ISA A+, B or C).  */
> +    M68K_FEATURE_USP, /* User Stack Pointer. (680[012346]0, ISA A+, B or C).*/
> +    M68K_FEATURE_MSP, /* Master Stack Pointer. (680[234]0) */
>      M68K_FEATURE_EXT_FULL, /* 68020+ full extension word.  */
>      M68K_FEATURE_WORD_INDEX, /* word sized address index registers.  */
>      M68K_FEATURE_SCALED_INDEX, /* scaled address index registers.  */
> -    M68K_FEATURE_LONG_MULDIV, /* 32 bit multiply/divide. */
> -    M68K_FEATURE_QUAD_MULDIV, /* 64 bit multiply/divide. */
> -    M68K_FEATURE_BCCL, /* Long conditional branches.  */
> -    M68K_FEATURE_BITFIELD, /* Bit field insns.  */
> -    M68K_FEATURE_FPU,
> -    M68K_FEATURE_CAS,
> -    M68K_FEATURE_BKPT,
> -    M68K_FEATURE_RTD,
> -    M68K_FEATURE_CHK2,
> -    M68K_FEATURE_M68040, /* instructions specific to MC68040 */
> -    M68K_FEATURE_MOVEP,
> +    M68K_FEATURE_LONG_MULDIV, /* 32 bit mul/div. (680[2346]0, and CPU32) */
> +    M68K_FEATURE_QUAD_MULDIV, /* 64 bit mul/div. (680[2346]0, and CPU32) */
> +    M68K_FEATURE_BCCL, /* Bcc with Long branches. (680[2346]0, and CPU32) */
> +    M68K_FEATURE_BITFIELD, /* BFxxx Bit field insns. (680[2346]0) */
> +    M68K_FEATURE_FPU, /* fpu insn. (680[46]0) */
> +    M68K_FEATURE_CAS, /* CAS/CAS2[WL] insns. (680[2346]0) */
> +    M68K_FEATURE_BKPT,/* BKPT insn. (680[12346]0, and CPU32) */
> +    M68K_FEATURE_RTD, /* RTD insn. (680[12346]0, and CPU32) */
> +    M68K_FEATURE_CHK2,/* CHL2 insn. (680[2346]0, and CPU32) */
> +    M68K_FEATURE_MOVEP,/* MOVEP insn. (680[01234]0, and CPU32) */
>  };
>  
>  static inline int m68k_feature(CPUM68KState *env, int feature)
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index b0bb579403..0661723aac 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -192,64 +192,138 @@ void HELPER(cf_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
>      }
>  }
>  
> +
> +
> +static void raise_exception_ra(CPUM68KState *env, int tt, uintptr_t raddr)
> +{
> +    CPUState *cs = CPU(m68k_env_get_cpu(env));
> +
> +    cs->exception_index = tt;
> +    cpu_loop_exit_restore(cs, raddr);
> +}
> +
>  void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
>  {
>      M68kCPU *cpu = m68k_env_get_cpu(env);
>  
>      switch (reg) {
> -    /* MC680[1234]0 */
> +    /* MC680[12346]0 */
>      case M68K_CR_SFC:
>          env->sfc = val & 7;
>          return;
> +    /* MC680[12346]0 */
>      case M68K_CR_DFC:
>          env->dfc = val & 7;
>          return;
> +    /* MC680[12346]0 */
>      case M68K_CR_VBR:
>          env->vbr = val;
>          return;
> -    /* MC680[234]0 */
> +    /* MC680[2346]0 */
>      case M68K_CR_CACR:
> -        env->cacr = val;
> -        m68k_switch_sp(env);
> -        return;
> -    /* MC680[34]0 */
> +        if (m68k_feature(env, M68K_FEATURE_M68020)
> +         || m68k_feature(env, M68K_FEATURE_M68030)
> +         || m68k_feature(env, M68K_FEATURE_M68040)
> +         || m68k_feature(env, M68K_FEATURE_M68060)) {
> +            env->cacr = val;
> +            m68k_switch_sp(env);
> +            return;
> +        }
> +        break;
> +    /* MC680[46]0 */
>      case M68K_CR_TC:
> -        env->mmu.tcr = val;
> -        return;
> +        if (m68k_feature(env, M68K_FEATURE_M68040)
> +         || m68k_feature(env, M68K_FEATURE_M68060)) {
> +            env->mmu.tcr = val;
> +            return;
> +        }
> +        break;
> +    /* MC680[4]0 */
>      case M68K_CR_MMUSR:
> -        env->mmu.mmusr = val;
> -        return;
> +        if (m68k_feature(env, M68K_FEATURE_M68040)) {
> +            env->mmu.mmusr = val;
> +            return;
> +        }
> +        break;
> +    /* MC680[46]0 */
>      case M68K_CR_SRP:
> -        env->mmu.srp = val;
> -        return;
> +        if (m68k_feature(env, M68K_FEATURE_M68040)
> +         || m68k_feature(env, M68K_FEATURE_M68060)) {
> +            env->mmu.srp = val;
> +            return;
> +        }
> +        break;
> +    /* MC680[46]0 */
>      case M68K_CR_URP:
> -        env->mmu.urp = val;
> -        return;
> +        if (m68k_feature(env, M68K_FEATURE_M68040)
> +         || m68k_feature(env, M68K_FEATURE_M68060)) {
> +            env->mmu.urp = val;
> +            return;
> +        }
> +        break;
> +    /* MC680[12346]0 */
>      case M68K_CR_USP:
>          env->sp[M68K_USP] = val;
>          return;
> +    /* MC680[234]0 */
>      case M68K_CR_MSP:
> -        env->sp[M68K_SSP] = val;
> -        return;
> +        if (m68k_feature(env, M68K_FEATURE_M68020)
> +         || m68k_feature(env, M68K_FEATURE_M68030)
> +         || m68k_feature(env, M68K_FEATURE_M68040)) {
> +            env->sp[M68K_SSP] = val;
> +            return;
> +        }
> +        break;
> +    /* MC680[234]0 */
>      case M68K_CR_ISP:
> -        env->sp[M68K_ISP] = val;
> -        return;
> +        if (m68k_feature(env, M68K_FEATURE_M68020)
> +         || m68k_feature(env, M68K_FEATURE_M68030)
> +         || m68k_feature(env, M68K_FEATURE_M68040)) {
> +            env->sp[M68K_ISP] = val;
> +            return;
> +        }
> +        break;
>      /* MC68040/MC68LC040 */
> -    case M68K_CR_ITT0:
> -        env->mmu.ttr[M68K_ITTR0] = val;
> -        return;
> -    case M68K_CR_ITT1:
> -         env->mmu.ttr[M68K_ITTR1] = val;
> -        return;
> -    case M68K_CR_DTT0:
> -        env->mmu.ttr[M68K_DTTR0] = val;
> -        return;
> -    case M68K_CR_DTT1:
> -        env->mmu.ttr[M68K_DTTR1] = val;
> +    case M68K_CR_ITT0: /* MC68EC040 only: M68K_CR_IACR0 */
> +        if (m68k_feature(env, M68K_FEATURE_M68040)) {
> +            env->mmu.ttr[M68K_ITTR0] = val;
> +            return;
> +        }
> +        break;
> +    /* MC68040/MC68LC040 */
> +    case M68K_CR_ITT1: /* MC68EC040 only: M68K_CR_IACR1 */
> +        if (m68k_feature(env, M68K_FEATURE_M68040)) {
> +            env->mmu.ttr[M68K_ITTR1] = val;
> +            return;
> +        }
> +        break;
> +    /* MC68040/MC68LC040 */
> +    case M68K_CR_DTT0: /* MC68EC040 only: M68K_CR_DACR0 */
> +        if (m68k_feature(env, M68K_FEATURE_M68040)) {
> +            env->mmu.ttr[M68K_DTTR0] = val;
> +            return;
> +        }
> +        break;
> +    /* MC68040/MC68LC040 */
> +    case M68K_CR_DTT1: /* MC68EC040 only: M68K_CR_DACR1 */
> +        if (m68k_feature(env, M68K_FEATURE_M68040)) {
> +            env->mmu.ttr[M68K_DTTR1] = val;
> +            return;
> +        }
> +        break;
> +    /* Unimplemented Registers */
> +    case M68K_CR_CAAR:
> +    case M68K_CR_PCR:
> +    case M68K_CR_BUSCR:
> +        cpu_abort(CPU(cpu),
> +                  "Unimplemented control register write 0x%x = 0x%x\n",
> +                  reg, val);
>          return;
>      }
> -    cpu_abort(CPU(cpu), "Unimplemented control register write 0x%x = 0x%x\n",
> -              reg, val);
> +
> +    /* Invalid control registers will generate an exception. */
> +    raise_exception_ra(env, EXCP_ILLEGAL, 0);
> +    return;
>  }
>  
>  uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
> @@ -257,43 +331,107 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
>      M68kCPU *cpu = m68k_env_get_cpu(env);
>  
>      switch (reg) {
> -    /* MC680[1234]0 */
> +    /* MC680[12346]0 */
>      case M68K_CR_SFC:
>          return env->sfc;
> +    /* MC680[12346]0 */
>      case M68K_CR_DFC:
>          return env->dfc;
> +    /* MC680[12346]0 */
>      case M68K_CR_VBR:
>          return env->vbr;
> -    /* MC680[234]0 */
> +    /* MC680[2346]0 */
>      case M68K_CR_CACR:
> -        return env->cacr;
> -    /* MC680[34]0 */
> +        if (m68k_feature(env, M68K_FEATURE_M68020)
> +         || m68k_feature(env, M68K_FEATURE_M68030)
> +         || m68k_feature(env, M68K_FEATURE_M68040)
> +         || m68k_feature(env, M68K_FEATURE_M68060)) {
> +            return env->cacr;
> +        }
> +        break;
> +    /* MC680[46]0 */
>      case M68K_CR_TC:
> -        return env->mmu.tcr;
> +        if (m68k_feature(env, M68K_FEATURE_M68040)
> +         || m68k_feature(env, M68K_FEATURE_M68060)) {
> +            return env->mmu.tcr;
> +        }
> +        break;
> +    /* MC680[4]0 */
>      case M68K_CR_MMUSR:
> -        return env->mmu.mmusr;
> +        if (m68k_feature(env, M68K_FEATURE_M68040)) {
> +            return env->mmu.mmusr;
> +        }
> +        break;
> +    /* MC680[46]0 */
>      case M68K_CR_SRP:
> -        return env->mmu.srp;
> +        if (m68k_feature(env, M68K_FEATURE_M68040)
> +         || m68k_feature(env, M68K_FEATURE_M68060)) {
> +            return env->mmu.srp;
> +        }
> +        break;
> +    /* MC68040/MC68LC040 */
> +    case M68K_CR_URP:
> +        if (m68k_feature(env, M68K_FEATURE_M68040)
> +         || m68k_feature(env, M68K_FEATURE_M68060)) {
> +            return env->mmu.urp;
> +        }
> +        break;
> +    /* MC680[46]0 */
>      case M68K_CR_USP:
>          return env->sp[M68K_USP];
> +    /* MC680[234]0 */
>      case M68K_CR_MSP:
> -        return env->sp[M68K_SSP];
> +        if (m68k_feature(env, M68K_FEATURE_M68020)
> +         || m68k_feature(env, M68K_FEATURE_M68030)
> +         || m68k_feature(env, M68K_FEATURE_M68040)) {
> +            return env->sp[M68K_SSP];
> +        }
> +        break;
> +    /* MC680[234]0 */
>      case M68K_CR_ISP:
> -        return env->sp[M68K_ISP];
> +        if (m68k_feature(env, M68K_FEATURE_M68020)
> +         || m68k_feature(env, M68K_FEATURE_M68030)
> +         || m68k_feature(env, M68K_FEATURE_M68040)) {
> +            return env->sp[M68K_ISP];
> +        }
> +        break;
>      /* MC68040/MC68LC040 */
> -    case M68K_CR_URP:
> -        return env->mmu.urp;
> -    case M68K_CR_ITT0:
> -        return env->mmu.ttr[M68K_ITTR0];
> -    case M68K_CR_ITT1:
> -        return env->mmu.ttr[M68K_ITTR1];
> -    case M68K_CR_DTT0:
> -        return env->mmu.ttr[M68K_DTTR0];
> -    case M68K_CR_DTT1:
> -        return env->mmu.ttr[M68K_DTTR1];
> -    }
> -    cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
> -              reg);
> +    case M68K_CR_ITT0: /* MC68EC040 only: M68K_CR_IACR0 */
> +        if (m68k_feature(env, M68K_FEATURE_M68040)) {
> +            return env->mmu.ttr[M68K_ITTR0];
> +        }
> +        break;
> +    /* MC68040/MC68LC040 */
> +    case M68K_CR_ITT1: /* MC68EC040 only: M68K_CR_IACR1 */
> +        if (m68k_feature(env, M68K_FEATURE_M68040)) {
> +            return env->mmu.ttr[M68K_ITTR1];
> +        }
> +        break;
> +    /* MC68040/MC68LC040 */
> +    case M68K_CR_DTT0: /* MC68EC040 only: M68K_CR_DACR0 */
> +        if (m68k_feature(env, M68K_FEATURE_M68040)) {
> +            return env->mmu.ttr[M68K_DTTR0];
> +        }
> +        break;
> +    /* MC68040/MC68LC040 */
> +    case M68K_CR_DTT1: /* MC68EC040 only: M68K_CR_DACR1 */
> +        if (m68k_feature(env, M68K_FEATURE_M68040)) {
> +            return env->mmu.ttr[M68K_DTTR1];
> +        }
> +        break;
> +    /* Unimplemented Registers */
> +    case M68K_CR_CAAR:
> +    case M68K_CR_PCR:
> +    case M68K_CR_BUSCR:
> +        cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
> +                  reg);
> +        return 0;
> +    }
> +
> +    /* Invalid control registers will generate an exception. */
> +    raise_exception_ra(env, EXCP_ILLEGAL, 0);
> +
> +    return 0;
>  }
>  
>  void HELPER(set_macsr)(CPUM68KState *env, uint32_t val)
> @@ -337,7 +475,8 @@ void m68k_switch_sp(CPUM68KState *env)
>      env->sp[env->current_sp] = env->aregs[7];
>      if (m68k_feature(env, M68K_FEATURE_M68000)) {
>          if (env->sr & SR_S) {
> -            if (env->sr & SR_M) {
> +            /* SR:Master-Mode bit unimplemented then ISP is not available */
> +            if (!m68k_feature(env, M68K_FEATURE_MSP) || env->sr & SR_M) {
>                  new_sp = M68K_SSP;
>              } else {
>                  new_sp = M68K_ISP;
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 9b0ca4c14c..7a5da254dd 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -4753,6 +4753,8 @@ DISAS_INSN(m68k_movec)
>      } else {
>          reg = DREG(ext, 12);
>      }
> +
> +    /* Decode ctrl reg field, issues exception if the cpu doesnt support it */
>      if (insn & 1) {
>          gen_helper_m68k_movec_to(cpu_env, tcg_const_i32(ext & 0xfff), reg);
>      } else {
> @@ -5990,7 +5992,7 @@ void register_m68k_insns (CPUM68KState *env)
>      BASE(stop,      4e72, ffff);
>      BASE(rte,       4e73, ffff);
>      INSN(cf_movec,  4e7b, ffff, CF_ISA_A);
> -    INSN(m68k_movec, 4e7a, fffe, M68000);
> +    INSN(m68k_movec, 4e7a, fffe, M68010);
>  #endif
>      BASE(nop,       4e71, ffff);
>      INSN(rtd,       4e74, ffff, RTD);
> 


