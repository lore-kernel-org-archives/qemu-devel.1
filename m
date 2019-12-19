Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BEEC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 09:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868C721D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 09:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868C721D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihrwM-0004Ba-J6
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 04:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1ihrvU-0003Y1-Fc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 04:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1ihrvS-0003ZT-Fa
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 04:16:56 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1ihrvR-0002vn-Tn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 04:16:54 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06436282|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.373768-0.00822152-0.618011;
 DS=CONTINUE|ham_regular_dialog|0.063209-0.00200723-0.934784;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07447; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.GKIATES_1576746692; 
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GKIATES_1576746692)
 by smtp.aliyun-inc.com(10.147.44.118);
 Thu, 19 Dec 2019 17:11:36 +0800
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
To: Richard Henderson <richard.henderson@linaro.org>
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <ba8c7451-b0a7-0405-f881-0c6d0d8574fb@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <1b1826c3-50e4-2481-56a2-4ebb01e04498@c-sky.com>
Date: Thu, 19 Dec 2019 17:11:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <ba8c7451-b0a7-0405-f881-0c6d0d8574fb@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: Chih-Min Chao <chihmin.chao@sifive.com>, palmer@sifive.com,
 Alistair.Francis@wdc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard，

Sorry to reply so late.

Upstream is really difficult . I was really frustrated to recieve so 
many difficult comments.

It is hard for me to absorb them and will take a lot of time to fixup. 
Now I will move on.

On 2019/8/29 2:54, Richard Henderson wrote:
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
>
> I'm not sure that vreg[].element[] really makes the most sense in the context
> of how risc-v rearranges its elements.

Use vreg[].element[] is my gut feeling.  It will be easiest to 
understand the code.

As you said, view all vector registers as a single block of memory is 
good for programing.

> It will almost certainly fail clang
> validators, if enabled, since you'll be indexing beyond the end of vreg[n] into
> vreg[n+1].

I'm sorry that it's really hard to absorb your opinion. I don't know why 
clang will fail

when index beyond the end of vreg[n] into vreg[n+1].

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

As Chih-Min Chao said in another part of PATCH V2 thread,  VLEN will be 
a property which can be

specified from command line.  So the sub-struct maybe defined as

struct {
     union{
         uint64_t *u64 ;
         int64_t  *s64;
         uint32_t *u32;
         int32_t  *s32;
         uint16_t *u16;
         int16_t  *s16;
         uint8_t  *u8;
         int8_t   *s8;
     } mem;
     target_ulong vxrm;
     target_ulong vxsat;
     target_ulong vl;
     target_ulong vstart;
     target_ulong vtype;
} vext;

Will that be OK?

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
>
> Recall that translation happens once (per configuration), whereas execution
> happens many times.  Obviously, the more configurations that we create, the
> more translation that must happen.
All check code will be moved from execution time to translation.
> But the vtypei argument to vsetvli is a good choice, because it is constant,
> relates directly to the compiled code, and is unrelated to the length of the
> data being processed.
>
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
>
> And with all of this done, I believe you no longer need to pass the register
> number to the helper.  You can pass the address of v[n], which is much more
> like how the tcg generic vector support works.
>
> Whether or not to include VL in tb_flags is a harder choice.  Certainly not the
> exact value of VL, as that would lead to different translations for every loop
> tail.  But it might be reasonable to include (VSTART == 0 && VL == VLMAX) as a
> single bit.  Knowing that this condition is true would allow some use of the
> tcg generic vector support.

The (ill, lmul, sew ) of vtype  will be placed within tb_flags, also the 
bit of (VSTART == 0 && VL == VLMAX).

So it will take 8 bits of tb flags for vector extension at least.

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

It's quiker to use generic vector of TCG.

However, I have one problem to support both command line VLEN and vreg_ofs.

As in SVE,  vreg ofs is the offset from cpu_env. If the structure of 
vector extension (to support command line VLEN） is

struct {
     union{
         uint64_t *u64 ;
         int64_t  *s64;
         uint32_t *u32;
         int32_t  *s32;
         uint16_t *u16;
         int16_t  *s16;
         uint8_t  *u8;
         int8_t   *s8;
     } mem;
     target_ulong vxrm;
     target_ulong vxsat;
     target_ulong vl;
     target_ulong vstart;
     target_ulong vtype;
} vext

I can't find the way to get the direct offset of vreg from cpu_env.

Maybe I should specify a max VLEN like the way of SVE?

Best Regards,

LIU Zhiwei

> Bear in mind that all tcg gvec operations operate strictly upon lanes.  I.e.
>
>     vd[x] = vs1[x] op vs2[x]
>
> thus the actual arrangement of the elements in storage is irrelevant and SLEN
> need not be considered here.
>
>
> r~

