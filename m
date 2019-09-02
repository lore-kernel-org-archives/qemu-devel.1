Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0523C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B730A217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B730A217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4iyQ-0001Cg-Uy
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 05:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i4ixW-0000Q7-0j
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i4ixT-0002KT-4v
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:49:13 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34601)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i4ixO-0001z3-Ok; Mon, 02 Sep 2019 05:49:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.04436282|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.163324-0.00313813-0.833538; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03308; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=12; RT=12; SR=0;
 TI=SMTPD_---.FNRGL-N_1567417734; 
Received: from 172.16.28.187(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FNRGL-N_1567417734)
 by smtp.aliyun-inc.com(10.147.40.233);
 Mon, 02 Sep 2019 17:48:57 +0800
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <ba8c7451-b0a7-0405-f881-0c6d0d8574fb@linaro.org>
From: liuzhiwei <zhiwei_liu@c-sky.com>
Message-ID: <39fe5b33-86b1-cb42-9733-5d8e1ea08127@c-sky.com>
Date: Mon, 2 Sep 2019 17:43:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ba8c7451-b0a7-0405-f881-0c6d0d8574fb@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
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
Cc: peter.maydell@linaro.org, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 Alistair.Francis@wdc.com, alex.bennee@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/8/29 上午2:54, Richard Henderson wrote:
> On 8/27/19 7:36 PM, liuzhiwei wrote:
>> Change-Id: I3cf891bc400713b95f47ecca82b1bf773f3dcb25
>> Signed-off-by: liuzhiwei <zhiwei_liu@c-sky.com>
>> ---
>>   fpu/softfloat.c                         |   119 +
>>   include/fpu/softfloat.h                 |     4 +
>>   linux-user/riscv/cpu_loop.c             |     8 +-
>>   target/riscv/Makefile.objs              |     2 +-
>>   target/riscv/cpu.h                      |    30 +
>>   target/riscv/cpu_bits.h                 |    15 +
>>   target/riscv/cpu_helper.c               |     7 +
>>   target/riscv/csr.c                      |    65 +-
>>   target/riscv/helper.h                   |   354 +
>>   target/riscv/insn32.decode              |   374 +-
>>   target/riscv/insn_trans/trans_rvv.inc.c |   484 +
>>   target/riscv/translate.c                |     1 +
>>   target/riscv/vector_helper.c            | 26563 ++++++++++++++++++++++++++++++
>>   13 files changed, 28017 insertions(+), 9 deletions(-)
> As Alex mentioned, this is *far* too big to be presented as a single patch.
OK, split it into patch set in V2
>
>> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
>> index 3ff3fa5..3b0754c 100644
>> --- a/include/fpu/softfloat.h
>> +++ b/include/fpu/softfloat.h
>> @@ -293,6 +293,10 @@ float16 float16_maxnummag(float16, float16, float_status *status);
>>   float16 float16_sqrt(float16, float_status *status);
>>   int float16_compare(float16, float16, float_status *status);
>>   int float16_compare_quiet(float16, float16, float_status *status);
>> +int float16_unordered_quiet(float16, float16, float_status *status);
>> +int float16_le(float16, float16, float_status *status);
>> +int float16_lt(float16, float16, float_status *status);
>> +int float16_eq_quiet(float16, float16, float_status *status);
> As Alex mentioned, none of these changes are required, as all
> functionality is provided by float16_compare{,_quiet}.
Yes, use float16_compare instead.
>> diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
>> index 12aa3c0..b01548a 100644
>> --- a/linux-user/riscv/cpu_loop.c
>> +++ b/linux-user/riscv/cpu_loop.c
>> @@ -40,7 +40,13 @@ void cpu_loop(CPURISCVState *env)
>>           signum = 0;
>>           sigcode = 0;
>>           sigaddr = 0;
>> -
>> +        if (env->foflag) {
>> +            if (env->vfp.vl != 0) {
>> +                env->foflag = false;
>> +                env->pc += 4;
>> +                continue;
>> +            }
> This is most definitely not the correct way to implement first-fault.
>
> You need to have a look at target/arm/sve_helper.c, e.g. sve_ldff1_r,
> where we test pages for validity with tlb_vaddr_to_host.
Why should  test pages for validity? If there is a page fault in running 
time, it just the case why it must use the fault-only-first instruction.
>> +    /* vector coprocessor state.  */
>> +    struct {
>> +        union VECTOR {
>> +            float64  f64[VUNIT(64)];
>> +            float32  f32[VUNIT(32)];
>> +            float16  f16[VUNIT(16)];
>> +            target_ulong ul[VUNIT(sizeof(target_ulong))];
>> +            uint64_t u64[VUNIT(64)];
>> +            int64_t  s64[VUNIT(64)];
>> +            uint32_t u32[VUNIT(32)];
>> +            int32_t  s32[VUNIT(32)];
>> +            uint16_t u16[VUNIT(16)];
>> +            int16_t  s16[VUNIT(16)];
>> +            uint8_t  u8[VUNIT(8)];
>> +            int8_t   s8[VUNIT(8)];
>> +        } vreg[32];
>> +        target_ulong vxrm;
>> +        target_ulong vxsat;
>> +        target_ulong vl;
>> +        target_ulong vstart;
>> +        target_ulong vtype;
>> +        float_status fp_status;
>> +    } vfp;
> You've obviously copied "vfp" from target/arm.  Drop that.  It makes no sense
> in the context of risc-v.
> I'm not sure that vreg[].element[] really makes the most sense in the context
> of how risc-v rearranges its elements.  It will almost certainly fail clang
> validators, if enabled, since you'll be indexing beyond the end of vreg[n] into
> vreg[n+1].
>
> It might be best to have a single array:
>
>      union {
>          uint64_t u64[32 * VLEN / 64];
>          ...
>          uint8_t u8[32 * VLEN / 8];
>      } velt;
>
> This is clearer to the compiler that this is a single block of memory that we
> can index as we please.

A single array is a good idea. But vreg[] will be better for understanding as it preserve the register concepts.

> Note that float64/float32/float16 are legacy.  They will always be equivalent
> to the unsigned integer types of the same size.
>
> Is there really any vector operation at all that is dependent on XLEN?  If not,
> then there is no reason to confuse things by including target_ulong.
>
OK.
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index e32b612..405caf6 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -521,6 +521,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>           [PRV_H] = RISCV_EXCP_H_ECALL,
>>           [PRV_M] = RISCV_EXCP_M_ECALL
>>       };
>> +    if (env->foflag) {
>> +        if (env->vfp.vl != 0) {
>> +            env->foflag = false;
>> +            env->pc += 4;
>> +            return;
>> +        }
>> +    }
> Again, not the way to implement first-fault.
>
> In particular, you haven't even verified that do_interrupt has been called on
> behalf of a RISCV_EXCP_LOAD_PAGE_FAULT.  This could be a timer tick.

I don't think this could be a timer tick. A timer tick must not 
interrupt one instruction in qemu.

According to the specification, if there is a RISCV_EXCP_LOAD_PAGE_FAULT 
in the instruction,  and some elements had been loaded or stored,

the remaining elements will not be processed again after restore from 
the exception.

If there is a RISCV_EXCP_LOAD_PAGE_FAULT in the instruction,  and no 
elements had been loaded or stored, the remaining elements will be 
processed again after restore from the exception.

>
>> +#define MAX_U8      ((uint8_t)0xff)
>> +#define MIN_U8      ((uint8_t)0x0)
>> +#define MAX_S8      ((int8_t)0x7f)
>> +#define MIN_S8      ((int8_t)0x80)
>> +#define SIGNBIT16   (1 << 15)
>> +#define MAX_U16     ((uint16_t)0xffff)
>> +#define MIN_U16     ((uint16_t)0x0)
>> +#define MAX_S16     ((int16_t)0x7fff)
>> +#define MIN_S16     ((int16_t)0x8000)
>> +#define SIGNBIT32   (1 << 31)
>> +#define MAX_U32     ((uint32_t)0xffffffff)
>> +#define MIN_U32     ((uint32_t)0x0)
>> +#define MAX_S32     ((int32_t)0x7fffffff)
>> +#define MIN_S32     ((int32_t)0x80000000)
>> +#define SIGNBIT64   ((uint64_t)1 << 63)
>> +#define MAX_U64     ((uint64_t)0xffffffffffffffff)
>> +#define MIN_U64     ((uint64_t)0x0)
>> +#define MAX_S64     ((int64_t)0x7fffffffffffffff)
>> +#define MIN_S64     ((int64_t)0x8000000000000000)
> Why are you replicating INT8_MIN et al?
Thanks, it will be removed.
>
>
>> +static target_ulong vector_get_index(CPURISCVState *env, int rs1, int rs2,
>> +    int index, int mem, int width, int nf)
>> +{
>> +    target_ulong abs_off, base = env->gpr[rs1];
>> +    target_long offset;
>> +    switch (width) {
>> +    case 8:
>> +        offset = sign_extend(env->vfp.vreg[rs2].s8[index], 8) + nf * mem;
>> +        break;
>> +    case 16:
>> +        offset = sign_extend(env->vfp.vreg[rs2].s16[index], 16) + nf * mem;
>> +        break;
>> +    case 32:
>> +        offset = sign_extend(env->vfp.vreg[rs2].s32[index], 32) + nf * mem;
>> +        break;
>> +    case 64:
>> +        offset = env->vfp.vreg[rs2].s64[index] + nf * mem;
>> +        break;
>> +    default:
>> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> This is broken.  You cannot use GETPC() anywhere except in the outermost
> HELPER().  Otherwise you're not computing the return address back into the
> code_gen_buffer, which is what is required to properly unwind the guest state.

Yes, I will fix it.

>
>> +static inline bool vector_vtype_ill(CPURISCVState *env)
>> +{
>> +    if ((env->vfp.vtype >> (sizeof(target_ulong) - 1)) & 0x1) {
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>> +static inline void vector_vtype_set_ill(CPURISCVState *env)
>> +{
>> +    env->vfp.vtype = ((target_ulong)1) << (sizeof(target_ulong) - 1);
>> +    return;
>> +}
>> +
>> +static inline int vector_vtype_get_sew(CPURISCVState *env)
>> +{
>> +    return (env->vfp.vtype >> 2) & 0x7;
>> +}
>> +
>> +static inline int vector_get_width(CPURISCVState *env)
>> +{
>> +    return  8 * (1 << vector_vtype_get_sew(env));
>> +}
>> +
>> +static inline int vector_get_lmul(CPURISCVState *env)
>> +{
>> +    return 1 << (env->vfp.vtype & 0x3);
>> +}
>> +
>> +static inline int vector_get_vlmax(CPURISCVState *env)
>> +{
>> +    return vector_get_lmul(env) * VLEN / vector_get_width(env);
>> +}
>> +
>> +static inline int vector_elem_mask(CPURISCVState *env, uint32_t vm, int width,
>> +    int lmul, int index)
>> +{
>> +    int mlen = width / lmul;
>> +    int idx = (index * mlen) / 8;
>> +    int pos = (index * mlen) % 8;
>> +
>> +    return vm || ((env->vfp.vreg[0].u8[idx] >> pos) & 0x1);
>> +}
> I would strongly encourage you place the components of vtype within tb_flags
> via cpu_get_tb_cpu_state.  This would allow you to move quite a few checks from
> run-time to translation-time.
Good idea and some difficult.
> Recall that translation happens once (per configuration), whereas execution
> happens many times.  Obviously, the more configurations that we create, the
> more translation that must happen.
>
> But the vtypei argument to vsetvli is a good choice, because it is constant,
> relates directly to the compiled code, and is unrelated to the length of the
> data being processed.
Good choice for what? I am not quite understand.
> With that, you can verify at translation:
>
> (1) vill
> (2) v[n], for (n % lmul) != 0
> (3) v[n] overlapping v[0] for masked/carry operations, with lmul > 1
>
> and
>
> (4) you can arrange the helpers so that instead of 1 helper that has to
>      handle all SEW, you have N helpers, each handling a different SEW.
For all vector instructions or just vsetvli?
> And with all of this done, I believe you no longer need to pass the register
> number to the helper.  You can pass the address of v[n], which is much more
> like how the tcg generic vector support works.
>
> Whether or not to include VL in tb_flags is a harder choice.  Certainly not the
> exact value of VL, as that would lead to different translations for every loop
> tail.  But it might be reasonable to include (VSTART == 0 && VL == VLMAX) as a
> single bit.  Knowing that this condition is true would allow some use of the
> tcg generic vector support.
>
> E.g. vadd.vv could be
>
>      if (masked) {
>          switch (SEW) {
>          case MO_8:
>              gen_helper_vadd8_mask(...);
>              break;
>          ...
>          }
>      } else if (vl_eq_vlmax) {
>          tcg_gen_gvec_add(SEW, vreg_ofs(vd), vreg_ofs(vs2), vreg_ofs(vs1),
>                           VLEN * LMUL, VLEN * LMUL);
>      } else {
>          switch (SEW) {
>          case MO_8:
>              gen_helper_vadd8(...);
>              break;
>          ...
>          }
>      }
>
> Or, equivalently, pack pointers to the actual generator functions into a
> structure so that this code structure can be shared between many instructions.
>
> Bear in mind that all tcg gvec operations operate strictly upon lanes.  I.e.
>
>     vd[x] = vs1[x] op vs2[x]
>
> thus the actual arrangement of the elements in storage is irrelevant and SLEN
> need not be considered here.

Thank you very much.  Although it is some difficult for me to address 
your comments, they are very helpful.

Best Regards,

Zhiwei

>
>
> r~
>

