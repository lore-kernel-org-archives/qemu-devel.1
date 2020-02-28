Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DB4C3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0D3246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0D3246A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7bot-00049t-IL
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 04:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j7boG-0003jO-6t
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j7boE-0008QJ-Gf
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:19:51 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58150)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j7boD-0008Mh-P7; Fri, 28 Feb 2020 04:19:50 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436313|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.348218-0.0323094-0.619473;
 DS=CONTINUE|ham_regular_dialog|0.0311077-0.0068173-0.962075;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03312; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GteTI6o_1582881580; 
Received: from 192.168.43.249(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GteTI6o_1582881580)
 by smtp.aliyun-inc.com(10.147.40.233);
 Fri, 28 Feb 2020 17:19:41 +0800
Subject: Re: [PATCH v4 5/5] target/riscv: add vector amo operations
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-6-zhiwei_liu@c-sky.com>
 <03bf483e-d6bb-9de4-9934-12bfa7093ad3@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <6d008841-4356-b0f1-ece2-df8323ad8254@c-sky.com>
Date: Fri, 28 Feb 2020 17:19:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <03bf483e-d6bb-9de4-9934-12bfa7093ad3@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, linux-csky@vger.kernel.org,
 wxy194768@alibaba-inc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/2/28 13:38, Richard Henderson wrote:
> On 2/25/20 2:35 AM, LIU Zhiwei wrote:
>> +    if (s->sew < 2) {
>> +        return false;
>> +    }
> This could just as easily be in amo_check?
Yes, it can be done in amo_check.
>> +
>> +    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
>> +#ifdef CONFIG_ATOMIC64
>> +        fn = fns[0][seq][s->sew - 2];
>> +#else
>> +        gen_helper_exit_atomic(cpu_env);
>> +        s->base.is_jmp = DISAS_NORETURN;
>> +        return true;
>> +#endif
> Why are you raising exit_atomic without first checking that s->sew == 3?
Yes, it should be

     if (s->sew == 3) {

#ifdef CONFIG_ATOMIC64
         fn = fns[0][seq][1];
#else
         gen_helper_exit_atomic(cpu_env);
         s->base.is_jmp = DISAS_NORETURN;
         return true;
#endif

     } else {
#ifdef TARGET_RISCV64

     fn = fns[0][seq][0];
#else
     fn = fns[0][seq];
#endif

   }
Is it OK?
> We
> can do 32-bit atomic operations always.
Good.
>
>> +    } else {
>> +        fn = fns[1][seq][s->sew - 2];
>> +    }
>> +    if (fn == NULL) {
>> +        return false;
>> +    }
>> +
>> +    return amo_trans(a->rd, a->rs1, a->rs2, data, fn, s);
>> +}
>> +
>> +static bool amo_check(DisasContext *s, arg_rwdvm* a)
>> +{
>> +    return (vext_check_isa_ill(s, RVV | RVA) &&
>> +            (a->wd ? vext_check_overlap_mask(s, a->rd, a->vm) : 1) &&
>> +            vext_check_reg(s, a->rd, false) &&
>> +            vext_check_reg(s, a->rs2, false));
>> +}
> I guess the "If SEW is greater than XLEN, an illegal instruction exception is
> raised" requirement is currently in the column of NULLs in the !CONFIG_RISCV64
> block.  But it might be better to have it explicit and save the column of NULLs.
maybe  adds

(1 << s->sew) <= sizeof(target_ulong) &&

in amo_check
> It makes sense to me to do both sew checks together, whether in amo_check or in
> amo_op.
>
>> +#define GEN_VEXT_AMO_NOATOMIC_OP(NAME, ETYPE, MTYPE, H, DO_OP, SUF)      \
>> +static void vext_##NAME##_noatomic_op(void *vs3, target_ulong addr,      \
>> +        uint32_t wd, uint32_t idx, CPURISCVState *env, uintptr_t retaddr)\
>> +{                                                                        \
>> +    ETYPE ret;                                                           \
>> +    target_ulong tmp;                                                    \
>> +    int mmu_idx = cpu_mmu_index(env, false);                             \
>> +    tmp = cpu_ld##SUF##_mmuidx_ra(env, addr, mmu_idx, retaddr);          \
>> +    ret = DO_OP((ETYPE)(MTYPE)tmp, *((ETYPE *)vs3 + H(idx)));            \
>> +    cpu_st##SUF##_mmuidx_ra(env, addr, ret, mmu_idx, retaddr);           \
>> +    if (wd) {                                                            \
>> +        *((ETYPE *)vs3 + H(idx)) = (target_long)(MTYPE)tmp;              \
> The target_long cast is wrong; should be ETYPE.
"If the AMO memory element width is less than SEW, the value returned 
from memory
  is sign-extended to fill SEW"

So just use (target_long) to sign-extended. As you see, instructions like

vamominud

have the uint64_t as ETYPE.  And it can't sign-extend the value from 
memory by (ETYPE)(MTYPE)tmp.
> You can use cpu_ldX/stX_data (no mmu_idx or retaddr argument).  There should be
> no faults, since you've already checked for read+write.
Good idea.
>> +/* atomic opreation for vector atomic insructions */
>> +#ifndef CONFIG_USER_ONLY
>> +#define GEN_VEXT_ATOMIC_OP(NAME, ETYPE, MTYPE, MOFLAG, H, AMO)           \
>> +static void vext_##NAME##_atomic_op(void *vs3, target_ulong addr,        \
>> +        uint32_t wd, uint32_t idx, CPURISCVState *env)                   \
>> +{                                                                        \
>> +    target_ulong tmp;                                                    \
>> +    int mem_idx = cpu_mmu_index(env, false);                             \
>> +    tmp = helper_atomic_##AMO##_le(env, addr, *((ETYPE *)vs3 + H(idx)),  \
>> +            make_memop_idx(MO_ALIGN | MOFLAG, mem_idx));                 \
>> +    if (wd) {                                                            \
>> +        *((ETYPE *)vs3 + H(idx)) = (target_long)(MTYPE)tmp;              \
>> +    }                                                                    \
>> +}
>> +#else
>> +#define GEN_VEXT_ATOMIC_OP(NAME, ETYPE, MTYPE, MOFLAG, H, AMO)           \
>> +static void vext_##NAME##_atomic_op(void *vs3, target_ulong addr,        \
>> +        uint32_t wd, uint32_t idx, CPURISCVState *env)                   \
>> +{                                                                        \
>> +    target_ulong tmp;                                                    \
>> +    tmp = helper_atomic_##AMO##_le(env, addr, *((ETYPE *)vs3 + H(idx))); \
>> +    if (wd) {                                                            \
>> +        *((ETYPE *)vs3 + H(idx)) = (target_long)(MTYPE)tmp;              \
>> +    }                                                                    \
>> +}
>> +#endif
> This is not right.  It is not legal to call these helpers from another helper
> -- they will use the wrong GETPC() and will not unwind properly.
Oh. I didn't notice it.
>> +static inline void vext_amo_atomic(void *vs3, void *v0, target_ulong base,
>> +        void *vs2, CPURISCVState *env, uint32_t desc,
>> +        vext_get_index_addr get_index_addr,
>> +        vext_amo_atomic_fn atomic_op,
>> +        vext_ld_clear_elem clear_elem,
>> +        uint32_t esz, uint32_t msz, uintptr_t ra)
>> +{
>> +    uint32_t i;
>> +    target_long addr;
>> +    uint32_t wd = vext_wd(desc);
>> +    uint32_t vm = vext_vm(desc);
>> +    uint32_t mlen = vext_mlen(desc);
>> +    uint32_t vlmax = vext_maxsz(desc) / esz;
>> +
>> +    for (i = 0; i < env->vl; i++) {
>> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
>> +            continue;
>> +        }
>> +        probe_read_access(env, get_index_addr(base, i, vs2), msz, ra);
>> +        probe_write_access(env, get_index_addr(base, i, vs2), msz, ra);
>> +    }
> You probably need to check for aligned address here too, probably first so an
> unaligned fault has priority over an invalid page fault.
OK, I will use  cpu_unaligned_access() to check unaligned access.
> The missing aligned address check is the only remaining exception that the
> helper_atomic_* functions would raise, since you have properly checked for
> read+write.  So it might be possible to get away with using the helpers, but I
> don't like it.
Do you mean write my own helpers to implement atomic operations?

What's the meaning of " but I don't like it. "?
> But I do think it would be better to write your own helpers for the atomic
> paths.  They need not check quite so much, since we have already done the
> validation above.  You pretty much only need to use tlb_vaddr_to_host.
>
> If that gets too ugly, we can talk about rearranging
> accel/tcg/atomic_template.h so that it could be reused.
Good idea.  Perhaps use tlb_vaddr_to_host instead of atomic_mmu_lookup
to define another macro like GEN_ATOMIC_HELPER?
> Alternately, we could simply *always* use the non-atomic helpers, and raise
> exit_atomic if PARALLEL.
Yes, it's the simplest way.
However I prefer try to define something like GEN_ATOMIC_HELPER in 
vector_helper.c.
>> +static inline void vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
>> +        void *vs2, CPURISCVState *env, uint32_t desc,
>> +        vext_get_index_addr get_index_addr,
>> +        vext_amo_noatomic_fn noatomic_op,
>> +        vext_ld_clear_elem clear_elem,
>> +        uint32_t esz, uint32_t msz, uintptr_t ra)
> Without the retaddr argument to the noatomic_fn, as described above,
> vext_amo_noatomic and vext_amo_atomic are identical.
Yes.

It's very kind of you to spend so much time to review.
Thanks very much.

Best Regards,
Zhiwei
>
> r~


