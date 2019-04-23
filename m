Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC62BC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C61217D9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C61217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58050 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ0Hh-0007Nd-9b
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 14:36:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0Gq-00076e-1T
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0Go-00075e-AA
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:35:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hJ0Go-00072H-0o
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:35:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2276AC04FFFA;
	Tue, 23 Apr 2019 18:35:52 +0000 (UTC)
Received: from [10.36.116.61] (ovpn-116-61.ams2.redhat.com [10.36.116.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4963119936;
	Tue, 23 Apr 2019 18:35:51 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-21-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <2c311907-8954-fe86-536e-880d39307c97@redhat.com>
Date: Tue, 23 Apr 2019 20:35:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 23 Apr 2019 18:35:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 20/38] tcg: Add support for vector absolute
 value
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423183550.dGBXWen1peQxrKAa6CWSEh0x3PgIBuJgS4BSdDxhnMg@z>

On 20.04.19 09:34, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tcg-runtime.h      |  5 +++
>  tcg/aarch64/tcg-target.h     |  1 +
>  tcg/i386/tcg-target.h        |  1 +
>  tcg/tcg-op-gvec.h            |  2 +
>  tcg/tcg-opc.h                |  1 +
>  tcg/tcg.h                    |  1 +
>  accel/tcg/tcg-runtime-gvec.c | 48 ++++++++++++++++++++++++
>  tcg/tcg-op-gvec.c            | 71 ++++++++++++++++++++++++++++++++++++
>  tcg/tcg-op-vec.c             | 31 ++++++++++++++++
>  tcg/tcg.c                    |  2 +
>  tcg/README                   |  4 ++
>  11 files changed, 167 insertions(+)
> 
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index ed3ce5fd91..6d73dc2d65 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -225,6 +225,11 @@ DEF_HELPER_FLAGS_3(gvec_neg16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_3(gvec_neg32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_3(gvec_neg64, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  
> +DEF_HELPER_FLAGS_3(gvec_abs8, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(gvec_abs16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(gvec_abs32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(gvec_abs64, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +
>  DEF_HELPER_FLAGS_3(gvec_not, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_and, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_or, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index f5640a229b..21d06d928c 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -132,6 +132,7 @@ typedef enum {
>  #define TCG_TARGET_HAS_orc_vec          1
>  #define TCG_TARGET_HAS_not_vec          1
>  #define TCG_TARGET_HAS_neg_vec          1
> +#define TCG_TARGET_HAS_abs_vec          0
>  #define TCG_TARGET_HAS_shi_vec          1
>  #define TCG_TARGET_HAS_shs_vec          0
>  #define TCG_TARGET_HAS_shv_vec          1
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index 618aa520d2..7445f05885 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -182,6 +182,7 @@ extern bool have_avx2;
>  #define TCG_TARGET_HAS_orc_vec          0
>  #define TCG_TARGET_HAS_not_vec          0
>  #define TCG_TARGET_HAS_neg_vec          0
> +#define TCG_TARGET_HAS_abs_vec          0
>  #define TCG_TARGET_HAS_shi_vec          1
>  #define TCG_TARGET_HAS_shs_vec          1
>  #define TCG_TARGET_HAS_shv_vec          have_avx2
> diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
> index f9c6058e92..46f58febbf 100644
> --- a/tcg/tcg-op-gvec.h
> +++ b/tcg/tcg-op-gvec.h
> @@ -228,6 +228,8 @@ void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t oprsz, uint32_t maxsz);
>  void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t oprsz, uint32_t maxsz);
>  
>  void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
> index 4bf71f261f..4a2dd116eb 100644
> --- a/tcg/tcg-opc.h
> +++ b/tcg/tcg-opc.h
> @@ -225,6 +225,7 @@ DEF(add_vec, 1, 2, 0, IMPLVEC)
>  DEF(sub_vec, 1, 2, 0, IMPLVEC)
>  DEF(mul_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_mul_vec))
>  DEF(neg_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_neg_vec))
> +DEF(abs_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_abs_vec))
>  DEF(ssadd_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
>  DEF(usadd_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
>  DEF(sssub_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 48d4d2e03e..986055fdfa 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -176,6 +176,7 @@ typedef uint64_t TCGRegSet;
>      && !defined(TCG_TARGET_HAS_v128) \
>      && !defined(TCG_TARGET_HAS_v256)
>  #define TCG_TARGET_MAYBE_vec            0
> +#define TCG_TARGET_HAS_abs_vec          0
>  #define TCG_TARGET_HAS_neg_vec          0
>  #define TCG_TARGET_HAS_not_vec          0
>  #define TCG_TARGET_HAS_andc_vec         0
> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
> index 7b88f5590c..dd08095773 100644
> --- a/accel/tcg/tcg-runtime-gvec.c
> +++ b/accel/tcg/tcg-runtime-gvec.c
> @@ -398,6 +398,54 @@ void HELPER(gvec_neg64)(void *d, void *a, uint32_t desc)
>      clear_high(d, oprsz, desc);
>  }
>  
> +void HELPER(gvec_abs8)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(int8_t)) {
> +        int8_t aa = *(int8_t *)(a + i);
> +        *(int8_t *)(d + i) = aa < 0 ? -aa : aa;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_abs16)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
> +        int16_t aa = *(int16_t *)(a + i);
> +        *(int16_t *)(d + i) = aa < 0 ? -aa : aa;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_abs32)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(int32_t)) {
> +        int32_t aa = *(int32_t *)(a + i);
> +        *(int32_t *)(d + i) = aa < 0 ? -aa : aa;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_abs64)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(int64_t)) {
> +        int64_t aa = *(int64_t *)(a + i);
> +        *(int64_t *)(d + i) = aa < 0 ? -aa : aa;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
>  void HELPER(gvec_mov)(void *d, void *a, uint32_t desc)
>  {
>      intptr_t oprsz = simd_oprsz(desc);
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 4eb0747ddd..87d5a01cc9 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -88,6 +88,14 @@ static bool tcg_can_emit_vecop_list(const TCGOpcode *list,
>                  continue;
>              }
>              break;
> +        case INDEX_op_abs_vec:
> +            if (tcg_can_emit_vec_op(INDEX_op_sub_vec, type, vece)
> +                && (tcg_can_emit_vec_op(INDEX_op_smax_vec, type, vece) > 0
> +                    || tcg_can_emit_vec_op(INDEX_op_sari_vec, type, vece) > 0
> +                    || tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece))) {
> +                continue;
> +            }
> +            break;
>          default:
>              break;
>          }
> @@ -2239,6 +2247,69 @@ void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
>      tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g[vece]);
>  }
>  
> +static void gen_absv_mask(TCGv_i64 d, TCGv_i64 b, unsigned vece)
> +{
> +    TCGv_i64 t = tcg_temp_new_i64();
> +    int nbit = 8 << vece;
> +
> +    /* Create -1 for each negative element.  */
> +    tcg_gen_shri_i64(t, b, nbit - 1);
> +    tcg_gen_andi_i64(t, t, dup_const(vece, 1));
> +    tcg_gen_muli_i64(t, t, (1 << nbit) - 1);
> +
> +    /*
> +     * Invert (via xor -1) and add one (via sub -1).
> +     * Because of the ordering the msb is cleared,
> +     * so we never have carry into the next element.
> +     */
> +    tcg_gen_xor_i64(d, b, t);
> +    tcg_gen_sub_i64(d, d, t);
> +
> +    tcg_temp_free_i64(t);
> +}
> +
> +static void tcg_gen_vec_abs8_i64(TCGv_i64 d, TCGv_i64 b)
> +{
> +    gen_absv_mask(d, b, MO_8);
> +}
> +
> +static void tcg_gen_vec_abs16_i64(TCGv_i64 d, TCGv_i64 b)
> +{
> +    gen_absv_mask(d, b, MO_16);
> +}
> +
> +void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const TCGOpcode vecop_list[] = { INDEX_op_abs_vec, 0 };
> +    static const GVecGen2 g[4] = {
> +        { .fni8 = tcg_gen_vec_abs8_i64,
> +          .fniv = tcg_gen_abs_vec,
> +          .fno = gen_helper_gvec_abs8,
> +          .opt_opc = vecop_list,
> +          .vece = MO_8 },
> +        { .fni8 = tcg_gen_vec_abs16_i64,
> +          .fniv = tcg_gen_abs_vec,
> +          .fno = gen_helper_gvec_abs16,
> +          .opt_opc = vecop_list,
> +          .vece = MO_16 },
> +        { .fni4 = tcg_gen_abs_i32,
> +          .fniv = tcg_gen_abs_vec,
> +          .fno = gen_helper_gvec_abs32,
> +          .opt_opc = vecop_list,
> +          .vece = MO_32 },
> +        { .fni8 = tcg_gen_abs_i64,
> +          .fniv = tcg_gen_abs_vec,
> +          .fno = gen_helper_gvec_abs64,
> +          .opt_opc = vecop_list,
> +          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +          .vece = MO_64 },
> +    };
> +
> +    tcg_debug_assert(vece <= MO_64);
> +    tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g[vece]);
> +}
> +
>  void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
>  {
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index 5ec8e0b1a0..b7f21145bb 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -345,6 +345,37 @@ void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
>      tcg_swap_vecop_list(hold_list);
>  }
>  
> +void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
> +{
> +    const TCGOpcode *hold_list;
> +
> +    tcg_assert_listed_vecop(INDEX_op_abs_vec);
> +    hold_list = tcg_swap_vecop_list(NULL);
> +
> +    if (!do_op2(vece, r, a, INDEX_op_abs_vec)) {
> +        TCGType type = tcgv_vec_temp(r)->base_type;
> +        TCGv_vec t = tcg_temp_new_vec(type);
> +
> +        tcg_debug_assert(tcg_can_emit_vec_op(INDEX_op_sub_vec, type, vece));
> +        if (tcg_can_emit_vec_op(INDEX_op_smax_vec, type, vece) > 0) {
> +            tcg_gen_neg_vec(vece, t, a);
> +            tcg_gen_smax_vec(vece, r, a, t);
> +        } else {
> +            if (tcg_can_emit_vec_op(INDEX_op_sari_vec, type, vece) > 0) {
> +                tcg_gen_sari_vec(vece, t, a, (8 << vece) - 1);
> +            } else {
> +                do_dupi_vec(t, MO_REG, 0);
> +                tcg_gen_cmp_vec(TCG_COND_LT, vece, t, a, t);
> +            }
> +            tcg_gen_xor_vec(vece, r, a, t);
> +            tcg_gen_sub_vec(vece, r, r, t);
> +        }
> +
> +        tcg_temp_free_vec(t);
> +    }
> +    tcg_swap_vecop_list(hold_list);
> +}
> +
>  static void do_shifti(TCGOpcode opc, unsigned vece,
>                        TCGv_vec r, TCGv_vec a, int64_t i)
>  {
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 0b0b228bb5..86a95a636b 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1621,6 +1621,8 @@ bool tcg_op_supported(TCGOpcode op)
>          return have_vec && TCG_TARGET_HAS_not_vec;
>      case INDEX_op_neg_vec:
>          return have_vec && TCG_TARGET_HAS_neg_vec;
> +    case INDEX_op_abs_vec:
> +        return have_vec && TCG_TARGET_HAS_abs_vec;
>      case INDEX_op_andc_vec:
>          return have_vec && TCG_TARGET_HAS_andc_vec;
>      case INDEX_op_orc_vec:
> diff --git a/tcg/README b/tcg/README
> index c30e5418a6..cbdfd3b6bc 100644
> --- a/tcg/README
> +++ b/tcg/README
> @@ -561,6 +561,10 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
>  
>    Similarly, v0 = -v1.
>  
> +* abs_vec   v0, v1
> +
> +  Similarly, v0 = v1 < 0 ? -v1 : v1, in elements across the vector.
> +
>  * smin_vec:
>  * umin_vec:
>  
> 

Thanks, using this for VECTOR LOAD POSITIVE on s390x.

-- 

Thanks,

David / dhildenb

