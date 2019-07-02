Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F901C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C44420659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C44420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiEzS-0001et-JL
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35400)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiEye-00014N-B7
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiEya-0006mB-W6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:21:28 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50101)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hiEyZ-0006k5-5h
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:21:24 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MqbI0-1iLxWI0q7k-00mb2o; Tue, 02 Jul 2019 11:21:10 +0200
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>, qemu-devel@nongnu.org
References: <20190616142250.GA71201@localhost.localdomain>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5383c4ec-6da3-f7fd-0369-f2e63631b04b@vivier.eu>
Date: Tue, 2 Jul 2019 11:21:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190616142250.GA71201@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lRGLP3miioRrorNHgyl2bNq7x2KNBRVTiYWNdfnik1Nfrl/g/J8
 J7OfAb2lBPQ+81OXbGINle3wLUNU/ewjnAEXfXm/6zFQguh8xCsWFTwh6tw+wccIxhw2cUD
 ysjI/IEFFMuGDIjGwd2Qgg8ATX538qkc+bpzjJXnS/Gdgtd4VL2dT6/dVLhOZyrSMMs5fW/
 Ukf0jyGCwG468zIWqtC+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cOeaGIVoFb4=:u4tU5td6f9ZJ6QPtUwfRdK
 PGD7R+1x1xo6HbbE5Xo5aaV5Yz0Wfmo4NlubLah1rPEW8rLpjTEgYFGcAafmye7Ikc/HgLXGQ
 T9xJTsBXoBkAt8Hz22SbuWvNIalJAZpbeftZUZhu5d4amuV2YjBVl68L+jtrNPTrjfEtP+qik
 fEt5rbVlYUgpMRdHafizGKTien2SvWksZzYSy7M4URbf/atMrGapzj0yog6Ymy1NwQe+/XPsn
 Zydpt5+ow4/5Yt/jO9sSx1zCOkcl5U0CU5ttoIbwlMPtqxKnvywBiQvHdYHuguxOjH3upybZN
 yntTvlNiCuo0wZW8xx/q1oHWEyx0TP8ySW8bw03Pcdb7Z/GLQughwP2w7wp11jyI3RzgpfVgX
 y/JHOtOpQSUC9twp22IbOARbEC6GCJ3QB+WoWqSemENjqsRpALneCDqmKN7D1u/nr35xyElFW
 TVUSPYBi3FdhVz/hexC1z+AsENl+x3ImiBxxzZklnrsG2ySmzbktNjvxNJOD3wOaXzWWEi67k
 nKxoif0jLk3CMIiAAdFQbhJc1K5XbddMHczIuMknJXIuPaTkYEv4XjuACLc2a7Lj/82lUGH4i
 +b8GIpHx+PWNC77dBj2Vnw2d1Ar1i9tRlNOE3uI6rX+4+D6d5d4pEMi8bcFsQUjsUwYLY4/2G
 DZ1JDKoHVxGDm3JaGm5iRBGZtqlHgBTZFifYsNrn+myJHYTBPk+Pi5/ElWO0qEGheW/QHB0dZ
 dNhsmM93J9uzv7nARyPkVyWbvjVMo/cebn26xfZQDSgWACt56jRziIVIeFg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: Re: [Qemu-devel] [PATCH 1/6] m68k cpu instantiation comments
 improvements
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

Le 16/06/2019 à 16:22, Lucien Murray-Pitts a écrit :
> Improvement in comments for the instantiation functions.
> This is to highlight what each cpu class, in the 68000 series, contains
> in terms of instructions/features.
> 
> Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
> ---
>  target/m68k/cpu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  target/m68k/cpu.h | 40 +++++++++++++++++++++++++---------------
>  2 files changed, 72 insertions(+), 15 deletions(-)
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index c144278661..cc770a8042 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -104,6 +104,10 @@ static void m5206_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_CF_ISA_A);
>  }
>  

Adding some references can help, for instance:

/* MC68000 FAMILY PROGRAMMER’S REFERENCE MANUAL
 * APPENDIX A
 * PROCESSOR INSTRUCTION SUMMARY
 * Table A-1. M68000 Family Instruction Set And
 *            Processor Cross-Reference
 */

> +
> +/*
> + * Base feature set, including isns. for m68k family
> + */
>  static void m68000_cpu_initfn(Object *obj)
>  {
>      M68kCPU *cpu = M68K_CPU(obj);
> @@ -115,6 +119,12 @@ static void m68000_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_MOVEP);
>  }
>  
> +/*
> + * Adds BFCHG, BFCLR, BFEXTS, BFEXTU, BFFFO, BFINS, BFSET, BFTST, CAS, CAS2,
> + *      CHK2, CMP2, DIVSL, DIVUL, EXTB, PACK, TRAPcc, UNPK.
> + *
> + * 68020/30 Only:CALLM, cpBcc, cpDBcc, cpGEN, cpRESTORE, cpSAVE, cpScc, cpTRAPcc
> + */

Add BKPT (since 68010)
CALLM and RTM are 68020 only


>  static void m68020_cpu_initfn(Object *obj)
>  {
>      M68kCPU *cpu = M68K_CPU(obj);
> @@ -137,8 +147,34 @@ static void m68020_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_CHK2);
>      m68k_set_feature(env, M68K_FEATURE_MOVEP);
>  }
> +
> +/*
> + * Adds: PFLUSH (*5)

PFLUSH is also 68030 only

> + * 68030 Only: PFLUSHA (*5), PLOAD (*5), PMOVE
> + * 68030/40 Only: PTEST

Don't speak about 040 in the 030 section.
You should group PFLUSH and PTEST, as they exist on 030 and 040, but
their syntax and opcodes differ between 030 and 040

> + *
> + * NOTES:
> + *  5. Not valid on MC68EC030
> + */
>  #define m68030_cpu_initfn m68020_cpu_initfn
>  
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

All are FPU operations.
Perhaps you can add details to show which are also supported by 68881/68882.

> + * NOTES:
> + * 2. Not applicable to the MC68EC040, MC68LC040, MC68EC060, and MC68LC060.
> + * 3. These are software-supported instructions on the MC68040 and MC68060.
> + */
>  static void m68040_cpu_initfn(Object *obj)
>  {
>      M68kCPU *cpu = M68K_CPU(obj);
> @@ -148,6 +184,17 @@ static void m68040_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_M68040);
>  }
>  
> +/*
> + * Adds: PLPA
> + * Adds all with Note *2: CAS, CAS2, MULS, MULU, CHK2, CMP2, DIVS, DIVU
> + * All Fxxxx instructions are as per m68040 with exception to; FMOVEM NOTE3
> + *
> + * Does NOT implement MOVEP
> + *
> + * NOTES:
> + * 2. Not applicable to the MC68EC040, MC68LC040, MC68EC060, and MC68LC060.

Don't need to speak about 040 in the 060 section. The comment is already
in the 040 section.

> + * 3. These are software-supported instructions on the MC68040 and MC68060.
> + */
>  static void m68060_cpu_initfn(Object *obj)
>  {
>      M68kCPU *cpu = M68K_CPU(obj);
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 3c4d7de017..b5b3db01c9 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -468,36 +468,46 @@ void m68k_switch_sp(CPUM68KState *env);
>  void do_m68k_semihosting(CPUM68KState *env, int nr);
>  
>  /*
> + * The 68000 family is defined in six main CPU classes, the 680[012346]0.
> + * Generally each successive CPU adds enhanced data/stack/instructions.
> + * However, some features are only common to one, or a few classes.
> + * The features covers those subsets of instructons.
> + *
> + * CPU32/32+ are basically 680010 compatible with some 68020 class instructons,

s/instructons/instructions/

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
> +    M68K_FEATURE_M68040,   /* Additional insn. specific to MC68040 */
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

Introduce M68K_FEATURE_MSP when you need it: in patch 6.

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
> 

Thanks,
Laurent

