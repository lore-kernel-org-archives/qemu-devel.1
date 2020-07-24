Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09E4C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 02:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B690B207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 02:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B690B207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jynZA-0001Og-Vs
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 22:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jynYc-0000vS-1N; Thu, 23 Jul 2020 22:35:34 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jynYa-0007Bw-1x; Thu, 23 Jul 2020 22:35:33 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.510024-0.000164307-0.489811;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03297; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.I6iq7OD_1595558120; 
Received: from 30.225.208.37(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I6iq7OD_1595558120)
 by smtp.aliyun-inc.com(10.147.40.44); Fri, 24 Jul 2020 10:35:23 +0800
Subject: Re: [PATCH v2 1/7] target/riscv: Generate nanboxed results from fp
 helpers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200724002807.441147-1-richard.henderson@linaro.org>
 <20200724002807.441147-2-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <1aa6cb56-2f41-45c1-2d32-ec8b3b10780b@c-sky.com>
Date: Fri, 24 Jul 2020 10:35:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724002807.441147-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 22:31:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: frank.chang@sifive.com, alistair23@gmail.com, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/7/24 8:28, Richard Henderson wrote:
> Make sure that all results from single-precision scalar helpers
> are properly nan-boxed to 64-bits.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/internals.h  |  5 +++++
>   target/riscv/fpu_helper.c | 42 +++++++++++++++++++++------------------
>   2 files changed, 28 insertions(+), 19 deletions(-)
>
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 37d33820ad..9f4ba7d617 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -38,4 +38,9 @@ target_ulong fclass_d(uint64_t frs1);
>   #define SEW32 2
>   #define SEW64 3
>   
> +static inline uint64_t nanbox_s(float32 f)
> +{
> +    return f | MAKE_64BIT_MASK(32, 32);
> +}
> +
If define it here,  we can also define a more general  function with flen.

+static inline uint64_t nanbox_s(float32 f, uint32_t flen)
+{
+    return f | MAKE_64BIT_MASK(flen, 64 - flen);
+}
+

So we can reuse it in fp16 or bf16 scalar instruction and in vector 
instructions.

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Zhiwei
>   #endif
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index 4379756dc4..72541958a7 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -81,10 +81,16 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
>       set_float_rounding_mode(softrm, &env->fp_status);
>   }
>   
> +static uint64_t do_fmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> +                           uint64_t frs3, int flags)
> +{
> +    return nanbox_s(float32_muladd(frs1, frs2, frs3, flags, &env->fp_status));
> +}
> +
>   uint64_t helper_fmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>                           uint64_t frs3)
>   {
> -    return float32_muladd(frs1, frs2, frs3, 0, &env->fp_status);
> +    return do_fmadd_s(env, frs1, frs2, frs3, 0);
>   }
>   
>   uint64_t helper_fmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> @@ -96,8 +102,7 @@ uint64_t helper_fmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>   uint64_t helper_fmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>                           uint64_t frs3)
>   {
> -    return float32_muladd(frs1, frs2, frs3, float_muladd_negate_c,
> -                          &env->fp_status);
> +    return do_fmadd_s(env, frs1, frs2, frs3, float_muladd_negate_c);
>   }
>   
>   uint64_t helper_fmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> @@ -110,8 +115,7 @@ uint64_t helper_fmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>   uint64_t helper_fnmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>                            uint64_t frs3)
>   {
> -    return float32_muladd(frs1, frs2, frs3, float_muladd_negate_product,
> -                          &env->fp_status);
> +    return do_fmadd_s(env, frs1, frs2, frs3, float_muladd_negate_product);
>   }
>   
>   uint64_t helper_fnmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> @@ -124,8 +128,8 @@ uint64_t helper_fnmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>   uint64_t helper_fnmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>                            uint64_t frs3)
>   {
> -    return float32_muladd(frs1, frs2, frs3, float_muladd_negate_c |
> -                          float_muladd_negate_product, &env->fp_status);
> +    return do_fmadd_s(env, frs1, frs2, frs3,
> +                      float_muladd_negate_c | float_muladd_negate_product);
>   }
>   
>   uint64_t helper_fnmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> @@ -137,37 +141,37 @@ uint64_t helper_fnmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>   
>   uint64_t helper_fadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
>   {
> -    return float32_add(frs1, frs2, &env->fp_status);
> +    return nanbox_s(float32_add(frs1, frs2, &env->fp_status));
>   }
>   
>   uint64_t helper_fsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
>   {
> -    return float32_sub(frs1, frs2, &env->fp_status);
> +    return nanbox_s(float32_sub(frs1, frs2, &env->fp_status));
>   }
>   
>   uint64_t helper_fmul_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
>   {
> -    return float32_mul(frs1, frs2, &env->fp_status);
> +    return nanbox_s(float32_mul(frs1, frs2, &env->fp_status));
>   }
>   
>   uint64_t helper_fdiv_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
>   {
> -    return float32_div(frs1, frs2, &env->fp_status);
> +    return nanbox_s(float32_div(frs1, frs2, &env->fp_status));
>   }
>   
>   uint64_t helper_fmin_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
>   {
> -    return float32_minnum(frs1, frs2, &env->fp_status);
> +    return nanbox_s(float32_minnum(frs1, frs2, &env->fp_status));
>   }
>   
>   uint64_t helper_fmax_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
>   {
> -    return float32_maxnum(frs1, frs2, &env->fp_status);
> +    return nanbox_s(float32_maxnum(frs1, frs2, &env->fp_status));
>   }
>   
>   uint64_t helper_fsqrt_s(CPURISCVState *env, uint64_t frs1)
>   {
> -    return float32_sqrt(frs1, &env->fp_status);
> +    return nanbox_s(float32_sqrt(frs1, &env->fp_status));
>   }
>   
>   target_ulong helper_fle_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> @@ -209,23 +213,23 @@ uint64_t helper_fcvt_lu_s(CPURISCVState *env, uint64_t frs1)
>   
>   uint64_t helper_fcvt_s_w(CPURISCVState *env, target_ulong rs1)
>   {
> -    return int32_to_float32((int32_t)rs1, &env->fp_status);
> +    return nanbox_s(int32_to_float32((int32_t)rs1, &env->fp_status));
>   }
>   
>   uint64_t helper_fcvt_s_wu(CPURISCVState *env, target_ulong rs1)
>   {
> -    return uint32_to_float32((uint32_t)rs1, &env->fp_status);
> +    return nanbox_s(uint32_to_float32((uint32_t)rs1, &env->fp_status));
>   }
>   
>   #if defined(TARGET_RISCV64)
>   uint64_t helper_fcvt_s_l(CPURISCVState *env, uint64_t rs1)
>   {
> -    return int64_to_float32(rs1, &env->fp_status);
> +    return nanbox_s(int64_to_float32(rs1, &env->fp_status));
>   }
>   
>   uint64_t helper_fcvt_s_lu(CPURISCVState *env, uint64_t rs1)
>   {
> -    return uint64_to_float32(rs1, &env->fp_status);
> +    return nanbox_s(uint64_to_float32(rs1, &env->fp_status));
>   }
>   #endif
>   
> @@ -266,7 +270,7 @@ uint64_t helper_fmax_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
>   
>   uint64_t helper_fcvt_s_d(CPURISCVState *env, uint64_t rs1)
>   {
> -    return float64_to_float32(rs1, &env->fp_status);
> +    return nanbox_s(float64_to_float32(rs1, &env->fp_status));
>   }
>   
>   uint64_t helper_fcvt_d_s(CPURISCVState *env, uint64_t rs1)


