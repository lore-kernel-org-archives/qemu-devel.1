Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C86C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B6320693
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B6320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35363 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvmT-0003Kr-ER
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:02:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYvkr-0002OY-TI
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYvkj-00075D-SQ
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:00:41 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYvke-0006tj-6z; Thu, 06 Jun 2019 13:00:33 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1N4h7p-1gao4j1sGt-011iII; Thu, 06 Jun 2019 19:00:26 +0200
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>, qemu-devel@nongnu.org
References: <20190606164330.GA83448@localhost.localdomain>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <80017d43-88b7-5337-e89f-59596a81a1b6@vivier.eu>
Date: Thu, 6 Jun 2019 19:00:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606164330.GA83448@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:q8j6pnXUen/jA3OCl/D8RNRpOGpr9o96dgkfODuEoNxLuaiz3G4
	KQPWjeFp7RUlUqrA1NKyeoQKWkCwENf0rM5v339jfB1iUw07gAbvrXy0TfIabDX0Z7ToJUt
	XiqlZFJie/oLiimwMAsKt8thY7PrV6G7FrLGGnCM9ZJdhO8ooDZ949Ye74pHXJS/QL0t3SE
	ju6f0soIdNyRlp1Um0iJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aIrGdRf6Eh0=:EXSfEsw0m6GRZMqfYtEfi4
	QjL1794QxdhuBA07sqsL+cmIE62o+O13rJgmrKYRwmKapW48/F8OQnufgewr51qR3SC4afaXR
	Bf7UKTiIAl0Ilkf9xOh2iXdtlT7YhJEqkbYtSi0usP3PhUdiZYztzSMDfKmnG7o06d9Rm8orf
	Yttgyac6oJtMpFuCU2NdmezULCuFSQ0pQn3WX2d4EAkISp77Kpm74cV3rDm7+RayJNmtBVh5i
	SGg+q8xNYGtX1AzPUkTI222MLurBkEJ+A8wGmKuJHb4T/fQbXGV2tW/JvDNQWt8kfD1c2zek0
	GvRN8V8qcCUXfpf8DS99GR76QZ9vI2Y6fNSrn/wmvl3wbATydHbCn6Taczzabt09Y7L/sFUJ1
	Png1GY+4cWNUAaCrnvT/xUizpfgV9tKbnhhJRm5wKTBr+CoP3YjJsY2f6obKrR1AEf710mqTc
	zMHfmFBcEv2BuqWLKCmQutKHoB2J5aAyJCCeOHYtloAwJcAJFsJ8dd7ok5ohUDDNdj4CYAhyt
	we1O0i470EVJDmGlo+xECiuZHNBB3c40UAmr92B+GWXm0ul0bvgflq7rElpMkX6LsqRRlNbzM
	KpxcbuHxT43S5mFsOTnCQTnYJuUvHkA11iGwg4Ee+74MIjeVRyrGp7G7oOv1NFQQIk1mVxj4r
	w8PNzxMzUpsXSguexhA9PHyQNW7bxDMRYjZDIE+2aufKLBPVWWSRIC56nKaqJE+SIjkuKTPZR
	ehBLofmfG+j6Z3CVDK63eoR8TlYtlxat5qnLMMU1LznylzCQ1eSwhKDVmus=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH] m68k comments break patch submission due
 to being incorrectly formatted
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CC Trivial

Le 06/06/2019 à 18:43, Lucien Murray-Pitts a écrit :
> Altering all comments in target/m68k to match Qemu coding styles so that future
> patches wont fail due to style breaches.
> 
> Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
> ---
>  target/m68k/cpu.c        |   4 +-
>  target/m68k/cpu.h        |  30 ++++--
>  target/m68k/fpu_helper.c |   6 +-
>  target/m68k/gdbstub.c    |   6 +-
>  target/m68k/helper.c     |  16 +--
>  target/m68k/m68k-semi.c  |  18 ++--
>  target/m68k/op_helper.c  |  54 ++++++----
>  target/m68k/softfloat.c  | 226 +++++++++++++++++++++++---------------
>  target/m68k/translate.c  | 227 ++++++++++++++++++++++++---------------
>  9 files changed, 365 insertions(+), 222 deletions(-)

Looks good, except:

> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index b16957934a..d12d906b11 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -204,8 +204,8 @@ static void any_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_CF_ISA_APLUSC);
>      m68k_set_feature(env, M68K_FEATURE_BRAL);
>      m68k_set_feature(env, M68K_FEATURE_CF_FPU);
> -    /* MAC and EMAC are mututally exclusive, so pick EMAC.
> -       It's mostly backwards compatible.  */
> +    /* MAC and EMAC are mututally exclusive, so pick EMAC. */
> +    /* It's mostly backwards compatible.  */

Use /*
     * MAC and EMAC are mututally exclusive, so pick EMAC.
     * It's mostly backwards compatible.
     */

>      m68k_set_feature(env, M68K_FEATURE_CF_EMAC);
>      m68k_set_feature(env, M68K_FEATURE_CF_EMAC_B);
>      m68k_set_feature(env, M68K_FEATURE_USP);
...
> diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
> index 1402145c8f..ed9245f366 100644
> --- a/target/m68k/m68k-semi.c
> +++ b/target/m68k/m68k-semi.c
> @@ -131,7 +131,8 @@ static void m68k_semi_return_u32(CPUM68KState *env, uint32_t ret, uint32_t err)
>      target_ulong args = env->dregs[1];
>      if (put_user_u32(ret, args) ||
>          put_user_u32(err, args + 4)) {
> -        /* The m68k semihosting ABI does not provide any way to report this
> +        /*
> +         * The m68k semihosting ABI does not provide any way to report this
>           * error to the guest, so the best we can do is log it in qemu.
>           * It is always a guest error not to pass us a valid argument block.
>           */
> @@ -160,8 +161,8 @@ static void m68k_semi_cb(CPUState *cs, target_ulong ret, target_ulong err)
>      CPUM68KState *env = &cpu->env;
>  
>      if (m68k_semi_is_fseek) {
> -        /* FIXME: We've already lost the high bits of the fseek
> -           return value.  */
> +        /* FIXME: We've already lost the high bits of the fseek */
> +        /* return value.  */

ditto like:

/*
 * FIXME: We've already lost the high bits of the fseek
 * return value.
 */

>          m68k_semi_return_u64(env, ret, err);
>          m68k_semi_is_fseek = 0;
>      } else {
> @@ -169,7 +170,8 @@ static void m68k_semi_cb(CPUState *cs, target_ulong ret, target_ulong err)
>      }
>  }
>  
> -/* Read the input value from the argument block; fail the semihosting
> +/*
> + * Read the input value from the argument block; fail the semihosting
>   * call if the memory read fails.
>   */
>  #define GET_ARG(n) do {                                 \
> @@ -441,14 +443,14 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
>              }
>              ts->heap_limit = base + size;
>          }
> -        /* This call may happen before we have writable memory, so return
> -           values directly in registers.  */
> +        /* This call may happen before we have writable memory, so return */
> +        /* values directly in registers.  */
>          env->dregs[1] = ts->heap_limit;
>          env->aregs[7] = ts->stack_base;
>          }
>  #else
> -        /* FIXME: This is wrong for boards where RAM does not start at
> -           address zero.  */
> +        /* FIXME: This is wrong for boards where RAM does not start at */
> +        /* address zero.  */

ditto

>          env->dregs[1] = ram_size;
>          env->aregs[7] = ram_size;
>  #endif
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index bde2d551ff..0fa6f2c92e 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c

> @@ -838,14 +844,16 @@ static struct bf_data bf_prep(uint32_t addr, int32_t ofs, uint32_t len)
>          addr -= 1;
>      }
>  
> -    /* Compute the number of bytes required (minus one) to
> -       satisfy the bitfield.  */
> +    /* Compute the number of bytes required (minus one) to */
> +    /* satisfy the bitfield.  */

ditto

>      blen = (bofs + len - 1) / 8;
>  
> -    /* Canonicalize the bit offset for data loaded into a 64-bit big-endian
> -       word.  For the cases where BLEN is not a power of 2, adjust ADDR so
> -       that we can use the next power of two sized load without crossing a
> -       page boundary, unless the field itself crosses the boundary.  */
> +    /*
> +     * Canonicalize the bit offset for data loaded into a 64-bit big-endian
> +     * word.  For the cases where BLEN is not a power of 2, adjust ADDR so
> +     * that we can use the next power of two sized load without crossing a
> +     * page boundary, unless the field itself crosses the boundary.
> +     */
>      switch (blen) {
>      case 0:
>          bofs += 56;
> @@ -937,8 +945,8 @@ uint64_t HELPER(bfextu_mem)(CPUM68KState *env, uint32_t addr,
>      struct bf_data d = bf_prep(addr, ofs, len);
>      uint64_t data = bf_load(env, d.addr, d.blen, ra);
>  
> -    /* Put CC_N at the top of the high word; put the zero-extended value
> -       at the bottom of the low word.  */
> +    /* Put CC_N at the top of the high word; put the zero-extended value */
> +    /* at the bottom of the low word.  */

ditto

>      data <<= d.bofs;
>      data >>= 64 - d.len;
>      data |= data << (64 - d.len);
...
> diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
> index b45a5e8690..3cb1f494ba 100644
> --- a/target/m68k/softfloat.c
> +++ b/target/m68k/softfloat.c

In this file, it's better to remove the "/*------------------------" and
"*---------------------------------------*/" lines if you update them.

> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index f0534a4ba0..b796b6c22e 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -248,8 +248,8 @@ static void set_cc_op(DisasContext *s, CCOp op)
>      s->cc_op = op;
>      s->cc_op_synced = 0;
>  
> -    /* Discard CC computation that will no longer be used.
> -       Note that X and N are never dead.  */
> +    /* Discard CC computation that will no longer be used. */
> +    /* Note that X and N are never dead.  */

don't split in two comments.

>      dead = cc_op_live[old_op] & ~cc_op_live[op];
>      if (dead & CCF_C) {
>          tcg_gen_discard_i32(QREG_CC_C);
...

> @@ -2029,8 +2055,8 @@ DISAS_INSN(movem)
>              /* pre-decrement is not allowed */
>              goto do_addr_fault;
>          }
> -        /* We want a bare copy of the address reg, without any pre-decrement
> -           adjustment, as gen_lea would provide.  */
> +        /* We want a bare copy of the address reg, without any pre-decrement */
> +        /* adjustment, as gen_lea would provide.  */

ditto

>          break;
>  
>      default:
...
> @@ -2938,8 +2972,8 @@ DISAS_INSN(jump)
>  {
>      TCGv tmp;
>  
> -    /* Load the target address first to ensure correct exception
> -       behavior.  */
> +    /* Load the target address first to ensure correct exception */
> +    /* behavior.  */

ditto

>      tmp = gen_lea(env, s, insn, OS_LONG);
>      if (IS_NULL_QREG(tmp)) {
>          gen_addr_fault(s);
> @@ -2976,8 +3010,8 @@ DISAS_INSN(addsubq)
>      dest = tcg_temp_new();
>      tcg_gen_mov_i32(dest, src);
>      if ((insn & 0x38) == 0x08) {
> -        /* Don't update condition codes if the destination is an
> -           address register.  */
> +        /* Don't update condition codes if the destination is an */
> +        /* address register.  */

ditto

>          if (insn & 0x0100) {
>              tcg_gen_sub_i32(dest, dest, val);
>          } else {

> @@ -4028,8 +4073,8 @@ DISAS_INSN(bfext_reg)
>              src = tmp;
>              pos = 32 - len;
>          } else {
> -            /* Immediate offset.  If the field doesn't wrap around the
> -               end of the word, rely on (s)extract completely.  */
> +            /* Immediate offset.  If the field doesn't wrap around the */
> +            /*   end of the word, rely on (s)extract completely.  */

ditto

>              if (pos < 0) {
>                  tcg_gen_rotli_i32(tmp, src, ofs);
>                  src = tmp;
...
> @@ -5635,8 +5686,8 @@ DISAS_INSN(mac)
>          TCGv rw;
>          rw = (insn & 0x40) ? AREG(insn, 9) : DREG(insn, 9);
>          tcg_gen_mov_i32(rw, loadval);
> -        /* FIXME: Should address writeback happen with the masked or
> -           unmasked value?  */
> +        /* FIXME: Should address writeback happen with the masked or */
> +        /*  unmasked value?  */

ditto

>          switch ((insn >> 3) & 7) {
>          case 3: /* Post-increment.  */
>              tcg_gen_addi_i32(AREG(insn, 0), addr, 4);
> @@ -5786,8 +5837,8 @@ register_opcode (disas_proc proc, uint16_t opcode, uint16_t mask)
>                opcode, mask);
>        abort();
>    }
> -  /* This could probably be cleverer.  For now just optimize the case where
> -     the top bits are known.  */
> +  /* This could probably be cleverer.  For now just optimize the case where */
> +  /*   the top bits are known.  */

ditto

>    /* Find the first zero bit in the mask.  */
>    i = 0x8000;
>    while ((i & mask) != 0)
> @@ -5805,17 +5856,20 @@ register_opcode (disas_proc proc, uint16_t opcode, uint16_t mask)
>    }
>  }
>  
> -/* Register m68k opcode handlers.  Order is important.
> -   Later insn override earlier ones.  */
> +/*
> + * Register m68k opcode handlers.  Order is important.
> + * Later insn override earlier ones.
> + */
>  void register_m68k_insns (CPUM68KState *env)
>  {
> -    /* Build the opcode table only once to avoid
> -       multithreading issues. */
> +    /* Build the opcode table only once to avoid */
> +    /*   multithreading issues. */

ditto

>      if (opcode_table[0] != NULL) {
>          return;
>      }
>  
> -    /* use BASE() for instruction available
> +    /*
> +     * use BASE() for instruction available
>       * for CF_ISA_A and M68000.
>       */
>  #define BASE(name, opcode, mask) \

Thanks,
Laurent

