Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2107AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A47C235FC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A47C235FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL3Ks-0003iM-8Q
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 07:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1kL3H0-0000nG-9j
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:49:22 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1kL3Gv-0008FU-Vq
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:49:22 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436283|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_system_inform|0.33157-5.4566e-05-0.668376;
 FP=5070877581392817289|1|1|2|0|-1|-1|-1; HT=e02c03267; MF=zhiwei_liu@c-sky.com;
 NM=1; PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.IbAz.vq_1600861747; 
Received: from 30.225.208.89(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.IbAz.vq_1600861747)
 by smtp.aliyun-inc.com(10.147.42.22); Wed, 23 Sep 2020 19:49:07 +0800
Subject: Re: [PATCH v3 51/81] target/arm: Pass separate addend to {U, S}DOT
 helpers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
 <20200918183751.2787647-52-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <f7b50204-0f53-5275-32c9-fdc9900142dc@c-sky.com>
Date: Wed, 23 Sep 2020 19:48:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918183751.2787647-52-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 06:01:54
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/9/19 2:37, Richard Henderson wrote:
> For SVE, we potentially have a 4th argument coming from the
> movprfx instruction.  Currently we do not optimize movprfx,
> so the problem is not visible.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.h             |  20 +++---
>   target/arm/sve.decode           |   7 +-
>   target/arm/translate-a64.c      |  15 ++++-
>   target/arm/translate-sve.c      |  13 ++--
>   target/arm/vec_helper.c         | 112 ++++++++++++++++++--------------
>   target/arm/translate-neon.c.inc |  10 +--
>   6 files changed, 105 insertions(+), 72 deletions(-)
>
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 8294055cab..97222bd256 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -595,15 +595,19 @@ DEF_HELPER_FLAGS_5(sve2_sqrdmlah_d, TCG_CALL_NO_RWG,
>   DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_d, TCG_CALL_NO_RWG,
>                      void, ptr, ptr, ptr, ptr, i32)
>   
> -DEF_HELPER_FLAGS_4(gvec_sdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> -DEF_HELPER_FLAGS_4(gvec_udot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> -DEF_HELPER_FLAGS_4(gvec_sdot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> -DEF_HELPER_FLAGS_4(gvec_udot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_sdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_udot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_sdot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_udot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>   
> -DEF_HELPER_FLAGS_4(gvec_sdot_idx_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> -DEF_HELPER_FLAGS_4(gvec_udot_idx_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> -DEF_HELPER_FLAGS_4(gvec_sdot_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> -DEF_HELPER_FLAGS_4(gvec_udot_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_sdot_idx_b, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_udot_idx_b, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_sdot_idx_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(gvec_udot_idx_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
>   
>   DEF_HELPER_FLAGS_5(gvec_fcaddh, TCG_CALL_NO_RWG,
>                      void, ptr, ptr, ptr, ptr, i32)
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 0688dae450..5815ba9b1c 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -756,12 +756,13 @@ UMIN_zzi        00100101 .. 101 011 110 ........ .....          @rdn_i8u
>   MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
>   
>   # SVE integer dot product (unpredicated)
> -DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5      ra=%reg_movprfx
> +DOT_zzzz        01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5 \
> +                ra=%reg_movprfx
>   
>   # SVE integer dot product (indexed)
> -DOT_zzx         01000100 101 index:2 rm:3 00000 u:1 rn:5 rd:5 \
> +DOT_zzxw        01000100 101 index:2 rm:3 00000 u:1 rn:5 rd:5 \
>                   sz=0 ra=%reg_movprfx
> -DOT_zzx         01000100 111 index:1 rm:4 00000 u:1 rn:5 rd:5 \
> +DOT_zzxw        01000100 111 index:1 rm:4 00000 u:1 rn:5 rd:5 \
>                   sz=1 ra=%reg_movprfx
>   
>   # SVE floating-point complex add (predicated)
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 76e54c1a4e..1a9251db67 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -692,6 +692,17 @@ static void gen_gvec_op3_qc(DisasContext *s, bool is_q, int rd, int rn,
>       tcg_temp_free_ptr(qc_ptr);
>   }
>   
> +/* Expand a 4-operand operation using an out-of-line helper.  */
> +static void gen_gvec_op4_ool(DisasContext *s, bool is_q, int rd, int rn,
> +                             int rm, int ra, int data, gen_helper_gvec_4 *fn)
> +{
> +    tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
> +                       vec_full_reg_offset(s, rn),
> +                       vec_full_reg_offset(s, rm),
> +                       vec_full_reg_offset(s, ra),
> +                       is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
> +}
> +
>   /* Set ZF and NF based on a 64 bit result. This is alas fiddlier
>    * than the 32 bit equivalent.
>    */
> @@ -12202,7 +12213,7 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
>           return;
>   
>       case 0x2: /* SDOT / UDOT */
> -        gen_gvec_op3_ool(s, is_q, rd, rn, rm, 0,
> +        gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0,
>                            u ? gen_helper_gvec_udot_b : gen_helper_gvec_sdot_b);
>           return;
>   
> @@ -13461,7 +13472,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
>       switch (16 * u + opcode) {
>       case 0x0e: /* SDOT */
>       case 0x1e: /* UDOT */
> -        gen_gvec_op3_ool(s, is_q, rd, rn, rm, index,
> +        gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, index,
>                            u ? gen_helper_gvec_udot_idx_b
>                            : gen_helper_gvec_sdot_idx_b);
>           return;
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 5e8291e44b..66303dac54 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -3804,28 +3804,29 @@ DO_ZZI(UMIN, umin)
>   
>   #undef DO_ZZI
>   
> -static bool trans_DOT_zzz(DisasContext *s, arg_DOT_zzz *a)
> +static bool trans_DOT_zzzz(DisasContext *s, arg_DOT_zzzz *a)
>   {
> -    static gen_helper_gvec_3 * const fns[2][2] = {
> +    static gen_helper_gvec_4 * const fns[2][2] = {
>           { gen_helper_gvec_sdot_b, gen_helper_gvec_sdot_h },
>           { gen_helper_gvec_udot_b, gen_helper_gvec_udot_h }
>       };
>   
>       if (sve_access_check(s)) {
> -        gen_gvec_ool_zzz(s, fns[a->u][a->sz], a->rd, a->rn, a->rm, 0);
> +        gen_gvec_ool_zzzz(s, fns[a->u][a->sz], a->rd, a->rn, a->rm, a->ra, 0);
>       }
>       return true;
>   }
>   
> -static bool trans_DOT_zzx(DisasContext *s, arg_DOT_zzx *a)
> +static bool trans_DOT_zzxw(DisasContext *s, arg_DOT_zzxw *a)
>   {
> -    static gen_helper_gvec_3 * const fns[2][2] = {
> +    static gen_helper_gvec_4 * const fns[2][2] = {
>           { gen_helper_gvec_sdot_idx_b, gen_helper_gvec_sdot_idx_h },
>           { gen_helper_gvec_udot_idx_b, gen_helper_gvec_udot_idx_h }
>       };
>   
>       if (sve_access_check(s)) {
> -        gen_gvec_ool_zzz(s, fns[a->u][a->sz], a->rd, a->rn, a->rm, a->index);
> +        gen_gvec_ool_zzzz(s, fns[a->u][a->sz], a->rd, a->rn, a->rm,
> +                          a->ra, a->index);
>       }
>       return true;
>   }
> diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
> index 32a4403256..d7ef31915b 100644
> --- a/target/arm/vec_helper.c
> +++ b/target/arm/vec_helper.c
> @@ -375,71 +375,76 @@ void HELPER(sve2_sqrdmlsh_d)(void *vd, void *vn, void *vm,
>    * All elements are treated equally, no matter where they are.
>    */
>   
> -void HELPER(gvec_sdot_b)(void *vd, void *vn, void *vm, uint32_t desc)
> +void HELPER(gvec_sdot_b)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
>   {
>       intptr_t i, opr_sz = simd_oprsz(desc);
> -    uint32_t *d = vd;
> +    int32_t *d = vd, *a = va;
>       int8_t *n = vn, *m = vm;
>   
>       for (i = 0; i < opr_sz / 4; ++i) {
> -        d[i] += n[i * 4 + 0] * m[i * 4 + 0]
> -              + n[i * 4 + 1] * m[i * 4 + 1]
> -              + n[i * 4 + 2] * m[i * 4 + 2]
> -              + n[i * 4 + 3] * m[i * 4 + 3];
> +        d[i] = (a[i] +
> +                n[i * 4 + 0] * m[i * 4 + 0] +
> +                n[i * 4 + 1] * m[i * 4 + 1] +
> +                n[i * 4 + 2] * m[i * 4 + 2] +
> +                n[i * 4 + 3] * m[i * 4 + 3]);
>       }
>       clear_tail(d, opr_sz, simd_maxsz(desc));
>   }
>   
> -void HELPER(gvec_udot_b)(void *vd, void *vn, void *vm, uint32_t desc)
> +void HELPER(gvec_udot_b)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
>   {
>       intptr_t i, opr_sz = simd_oprsz(desc);
> -    uint32_t *d = vd;
> +    uint32_t *d = vd, *a = va;
>       uint8_t *n = vn, *m = vm;
>   
>       for (i = 0; i < opr_sz / 4; ++i) {
> -        d[i] += n[i * 4 + 0] * m[i * 4 + 0]
> -              + n[i * 4 + 1] * m[i * 4 + 1]
> -              + n[i * 4 + 2] * m[i * 4 + 2]
> -              + n[i * 4 + 3] * m[i * 4 + 3];
> +        d[i] = (a[i] +
> +                n[i * 4 + 0] * m[i * 4 + 0] +
> +                n[i * 4 + 1] * m[i * 4 + 1] +
> +                n[i * 4 + 2] * m[i * 4 + 2] +
> +                n[i * 4 + 3] * m[i * 4 + 3]);
>       }
>       clear_tail(d, opr_sz, simd_maxsz(desc));
>   }
>   
> -void HELPER(gvec_sdot_h)(void *vd, void *vn, void *vm, uint32_t desc)
> +void HELPER(gvec_sdot_h)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
>   {
>       intptr_t i, opr_sz = simd_oprsz(desc);
> -    uint64_t *d = vd;
> +    int64_t *d = vd, *a = va;
>       int16_t *n = vn, *m = vm;
>   
>       for (i = 0; i < opr_sz / 8; ++i) {
> -        d[i] += (int64_t)n[i * 4 + 0] * m[i * 4 + 0]
> -              + (int64_t)n[i * 4 + 1] * m[i * 4 + 1]
> -              + (int64_t)n[i * 4 + 2] * m[i * 4 + 2]
> -              + (int64_t)n[i * 4 + 3] * m[i * 4 + 3];
> +        d[i] = (a[i] +
> +                (int64_t)n[i * 4 + 0] * m[i * 4 + 0] +
> +                (int64_t)n[i * 4 + 1] * m[i * 4 + 1] +
> +                (int64_t)n[i * 4 + 2] * m[i * 4 + 2] +
> +                (int64_t)n[i * 4 + 3] * m[i * 4 + 3]);
>       }
>       clear_tail(d, opr_sz, simd_maxsz(desc));
>   }
>   
> -void HELPER(gvec_udot_h)(void *vd, void *vn, void *vm, uint32_t desc)
> +void HELPER(gvec_udot_h)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
>   {
>       intptr_t i, opr_sz = simd_oprsz(desc);
> -    uint64_t *d = vd;
> +    uint64_t *d = vd, *a = va;
>       uint16_t *n = vn, *m = vm;
>   
>       for (i = 0; i < opr_sz / 8; ++i) {
> -        d[i] += (uint64_t)n[i * 4 + 0] * m[i * 4 + 0]
> -              + (uint64_t)n[i * 4 + 1] * m[i * 4 + 1]
> -              + (uint64_t)n[i * 4 + 2] * m[i * 4 + 2]
> -              + (uint64_t)n[i * 4 + 3] * m[i * 4 + 3];
> +        d[i] = (a[i] +
> +                (uint64_t)n[i * 4 + 0] * m[i * 4 + 0] +
> +                (uint64_t)n[i * 4 + 1] * m[i * 4 + 1] +
> +                (uint64_t)n[i * 4 + 2] * m[i * 4 + 2] +
> +                (uint64_t)n[i * 4 + 3] * m[i * 4 + 3]);
>       }
>       clear_tail(d, opr_sz, simd_maxsz(desc));
>   }
>   
> -void HELPER(gvec_sdot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
> +void HELPER(gvec_sdot_idx_b)(void *vd, void *vn, void *vm,
> +                             void *va, uint32_t desc)
>   {
>       intptr_t i, segend, opr_sz = simd_oprsz(desc), opr_sz_4 = opr_sz / 4;
>       intptr_t index = simd_data(desc);
> -    uint32_t *d = vd;
> +    int32_t *d = vd, *a = va;
>       int8_t *n = vn;
>       int8_t *m_indexed = (int8_t *)vm + index * 4;
>   
> @@ -455,10 +460,11 @@ void HELPER(gvec_sdot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
>           int8_t m3 = m_indexed[i * 4 + 3];
>   
>           do {
> -            d[i] += n[i * 4 + 0] * m0
> -                  + n[i * 4 + 1] * m1
> -                  + n[i * 4 + 2] * m2
> -                  + n[i * 4 + 3] * m3;
> +            d[i] = (a[i] +
> +                    n[i * 4 + 0] * m0 +
> +                    n[i * 4 + 1] * m1 +
> +                    n[i * 4 + 2] * m2 +
> +                    n[i * 4 + 3] * m3);
>           } while (++i < segend);
>           segend = i + 4;
>       } while (i < opr_sz_4);
> @@ -466,11 +472,12 @@ void HELPER(gvec_sdot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
>       clear_tail(d, opr_sz, simd_maxsz(desc));
>   }
>   
> -void HELPER(gvec_udot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
> +void HELPER(gvec_udot_idx_b)(void *vd, void *vn, void *vm,
> +                             void *va, uint32_t desc)
>   {
>       intptr_t i, segend, opr_sz = simd_oprsz(desc), opr_sz_4 = opr_sz / 4;
>       intptr_t index = simd_data(desc);
> -    uint32_t *d = vd;
> +    uint32_t *d = vd, *a = va;
>       uint8_t *n = vn;
>       uint8_t *m_indexed = (uint8_t *)vm + index * 4;
>   
> @@ -486,10 +493,11 @@ void HELPER(gvec_udot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
>           uint8_t m3 = m_indexed[i * 4 + 3];
>   
>           do {
> -            d[i] += n[i * 4 + 0] * m0
> -                  + n[i * 4 + 1] * m1
> -                  + n[i * 4 + 2] * m2
> -                  + n[i * 4 + 3] * m3;
> +            d[i] = (a[i] +
> +                    n[i * 4 + 0] * m0 +
> +                    n[i * 4 + 1] * m1 +
> +                    n[i * 4 + 2] * m2 +
> +                    n[i * 4 + 3] * m3);
>           } while (++i < segend);
>           segend = i + 4;
>       } while (i < opr_sz_4);
> @@ -497,11 +505,12 @@ void HELPER(gvec_udot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
>       clear_tail(d, opr_sz, simd_maxsz(desc));
>   }
>   
> -void HELPER(gvec_sdot_idx_h)(void *vd, void *vn, void *vm, uint32_t desc)
> +void HELPER(gvec_sdot_idx_h)(void *vd, void *vn, void *vm,
> +                             void *va, uint32_t desc)
>   {
>       intptr_t i, opr_sz = simd_oprsz(desc), opr_sz_8 = opr_sz / 8;
>       intptr_t index = simd_data(desc);
> -    uint64_t *d = vd;
> +    int64_t *d = vd, *a = va;
>       int16_t *n = vn;
>       int16_t *m_indexed = (int16_t *)vm + index * 4;
>   
> @@ -509,14 +518,17 @@ void HELPER(gvec_sdot_idx_h)(void *vd, void *vn, void *vm, uint32_t desc)
>        * Process the entire segment all at once, writing back the results
>        * only after we've consumed all of the inputs.
>        */
> -    for (i = 0; i < opr_sz_8 ; i += 2) {
> -        uint64_t d0, d1;
> +    for (i = 0; i < opr_sz_8; i += 2) {
> +        int64_t d0, d1;
>   
> -        d0  = n[i * 4 + 0] * (int64_t)m_indexed[i * 4 + 0];
> +        d0  = a[i + 0];
> +        d0 += n[i * 4 + 0] * (int64_t)m_indexed[i * 4 + 0];
>           d0 += n[i * 4 + 1] * (int64_t)m_indexed[i * 4 + 1];
>           d0 += n[i * 4 + 2] * (int64_t)m_indexed[i * 4 + 2];
>           d0 += n[i * 4 + 3] * (int64_t)m_indexed[i * 4 + 3];
> -        d1  = n[i * 4 + 4] * (int64_t)m_indexed[i * 4 + 0];
> +
> +        d1  = a[i + 1];
> +        d1 += n[i * 4 + 4] * (int64_t)m_indexed[i * 4 + 0];
>           d1 += n[i * 4 + 5] * (int64_t)m_indexed[i * 4 + 1];
>           d1 += n[i * 4 + 6] * (int64_t)m_indexed[i * 4 + 2];
>           d1 += n[i * 4 + 7] * (int64_t)m_indexed[i * 4 + 3];
> @@ -524,15 +536,15 @@ void HELPER(gvec_sdot_idx_h)(void *vd, void *vn, void *vm, uint32_t desc)
>           d[i + 0] += d0;
>           d[i + 1] += d1;
>       }
> -
>       clear_tail(d, opr_sz, simd_maxsz(desc));
>   }
>   
> -void HELPER(gvec_udot_idx_h)(void *vd, void *vn, void *vm, uint32_t desc)
> +void HELPER(gvec_udot_idx_h)(void *vd, void *vn, void *vm,
> +                             void *va, uint32_t desc)
>   {
>       intptr_t i, opr_sz = simd_oprsz(desc), opr_sz_8 = opr_sz / 8;
>       intptr_t index = simd_data(desc);
> -    uint64_t *d = vd;
> +    uint64_t *d = vd, *a = va;
>       uint16_t *n = vn;
>       uint16_t *m_indexed = (uint16_t *)vm + index * 4;
>   
> @@ -540,14 +552,17 @@ void HELPER(gvec_udot_idx_h)(void *vd, void *vn, void *vm, uint32_t desc)
>        * Process the entire segment all at once, writing back the results
>        * only after we've consumed all of the inputs.
>        */
> -    for (i = 0; i < opr_sz_8 ; i += 2) {
> +    for (i = 0; i < opr_sz_8; i += 2) {
>           uint64_t d0, d1;
>   
> -        d0  = n[i * 4 + 0] * (uint64_t)m_indexed[i * 4 + 0];
> +        d0  = a[i + 0];
Add once.
> +        d0 += n[i * 4 + 0] * (uint64_t)m_indexed[i * 4 + 0];
>           d0 += n[i * 4 + 1] * (uint64_t)m_indexed[i * 4 + 1];
>           d0 += n[i * 4 + 2] * (uint64_t)m_indexed[i * 4 + 2];
>           d0 += n[i * 4 + 3] * (uint64_t)m_indexed[i * 4 + 3];
> -        d1  = n[i * 4 + 4] * (uint64_t)m_indexed[i * 4 + 0];
> +
> +        d1  = a[i + 1];
> +        d1 += n[i * 4 + 4] * (uint64_t)m_indexed[i * 4 + 0];
>           d1 += n[i * 4 + 5] * (uint64_t)m_indexed[i * 4 + 1];
>           d1 += n[i * 4 + 6] * (uint64_t)m_indexed[i * 4 + 2];
>           d1 += n[i * 4 + 7] * (uint64_t)m_indexed[i * 4 + 3];
> @@ -555,7 +570,6 @@ void HELPER(gvec_udot_idx_h)(void *vd, void *vn, void *vm, uint32_t desc)
>           d[i + 0] += d0;
Add twice.

I think it is wrong here. Do you thinks so?

Zhiwei
>           d[i + 1] += d1;
>       }
> -
>       clear_tail(d, opr_sz, simd_maxsz(desc));
>   }
>   
> diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
> index 4d1a292981..7efe3d9556 100644
> --- a/target/arm/translate-neon.c.inc
> +++ b/target/arm/translate-neon.c.inc
> @@ -240,7 +240,7 @@ static bool trans_VCADD(DisasContext *s, arg_VCADD *a)
>   static bool trans_VDOT(DisasContext *s, arg_VDOT *a)
>   {
>       int opr_sz;
> -    gen_helper_gvec_3 *fn_gvec;
> +    gen_helper_gvec_4 *fn_gvec;
>   
>       if (!dc_isar_feature(aa32_dp, s)) {
>           return false;
> @@ -262,9 +262,10 @@ static bool trans_VDOT(DisasContext *s, arg_VDOT *a)
>   
>       opr_sz = (1 + a->q) * 8;
>       fn_gvec = a->u ? gen_helper_gvec_udot_b : gen_helper_gvec_sdot_b;
> -    tcg_gen_gvec_3_ool(vfp_reg_offset(1, a->vd),
> +    tcg_gen_gvec_4_ool(vfp_reg_offset(1, a->vd),
>                          vfp_reg_offset(1, a->vn),
>                          vfp_reg_offset(1, a->vm),
> +                       vfp_reg_offset(1, a->vd),
>                          opr_sz, opr_sz, 0, fn_gvec);
>       return true;
>   }
> @@ -342,7 +343,7 @@ static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
>   
>   static bool trans_VDOT_scalar(DisasContext *s, arg_VDOT_scalar *a)
>   {
> -    gen_helper_gvec_3 *fn_gvec;
> +    gen_helper_gvec_4 *fn_gvec;
>       int opr_sz;
>       TCGv_ptr fpst;
>   
> @@ -367,9 +368,10 @@ static bool trans_VDOT_scalar(DisasContext *s, arg_VDOT_scalar *a)
>       fn_gvec = a->u ? gen_helper_gvec_udot_idx_b : gen_helper_gvec_sdot_idx_b;
>       opr_sz = (1 + a->q) * 8;
>       fpst = fpstatus_ptr(FPST_STD);
> -    tcg_gen_gvec_3_ool(vfp_reg_offset(1, a->vd),
> +    tcg_gen_gvec_4_ool(vfp_reg_offset(1, a->vd),
>                          vfp_reg_offset(1, a->vn),
>                          vfp_reg_offset(1, a->rm),
> +                       vfp_reg_offset(1, a->vd),
>                          opr_sz, opr_sz, a->index, fn_gvec);
>       tcg_temp_free_ptr(fpst);
>       return true;


