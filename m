Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC46C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 02:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48E520714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 02:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48E520714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jynko-0005gY-Tt
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 22:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jynkE-0005Cy-QY; Thu, 23 Jul 2020 22:47:34 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jynkC-0002mj-MJ; Thu, 23 Jul 2020 22:47:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.563953-6.42188e-05-0.435982;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03307; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.I6id2jM_1595558846; 
Received: from 30.225.208.37(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I6id2jM_1595558846)
 by smtp.aliyun-inc.com(10.147.40.200);
 Fri, 24 Jul 2020 10:47:26 +0800
Subject: Re: [PATCH v2 4/7] target/riscv: Check nanboxed inputs to fp helpers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200724002807.441147-1-richard.henderson@linaro.org>
 <20200724002807.441147-5-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <abf8bc3d-b021-6d01-3b7d-fa42bfe64653@c-sky.com>
Date: Fri, 24 Jul 2020 10:47:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724002807.441147-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
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
> If a 32-bit input is not properly nanboxed, then the input is
> replaced with the default qnan.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/internals.h  | 11 +++++++
>   target/riscv/fpu_helper.c | 64 ++++++++++++++++++++++++++++-----------
>   2 files changed, 57 insertions(+), 18 deletions(-)
>
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 9f4ba7d617..f1a546dba6 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -43,4 +43,15 @@ static inline uint64_t nanbox_s(float32 f)
>       return f | MAKE_64BIT_MASK(32, 32);
>   }
>   
> +static inline float32 check_nanbox_s(uint64_t f)
> +{
> +    uint64_t mask = MAKE_64BIT_MASK(32, 32);
> +
> +    if (likely((f & mask) == mask)) {
> +        return (uint32_t)f;
> +    } else {
> +        return 0x7fc00000u; /* default qnan */
> +    }
> +}
> +
If possible,

+static inline float32 check_nanbox(uint64_t f, uint32_t flen)
+{
+    uint64_t mask = MAKE_64BIT_MASK(flen, 64 - flen);
+
+    if (likely((f & mask) == mask)) {
+        return (uint32_t)f;
+    } else {
+        return (flen == 32) ? 0x7fc00000u : 0x7e00u; /* default qnan */
+    }
+}
+

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Zhiwei
>   #endif
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index 72541958a7..bb346a8249 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -81,9 +81,12 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
>       set_float_rounding_mode(softrm, &env->fp_status);
>   }
>   
> -static uint64_t do_fmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> -                           uint64_t frs3, int flags)
> +static uint64_t do_fmadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2,
> +                           uint64_t rs3, int flags)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
> +    float32 frs2 = check_nanbox_s(rs2);
> +    float32 frs3 = check_nanbox_s(rs3);
>       return nanbox_s(float32_muladd(frs1, frs2, frs3, flags, &env->fp_status));
>   }
>   
> @@ -139,74 +142,97 @@ uint64_t helper_fnmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>                             float_muladd_negate_product, &env->fp_status);
>   }
>   
> -uint64_t helper_fadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> +uint64_t helper_fadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
> +    float32 frs2 = check_nanbox_s(rs2);
>       return nanbox_s(float32_add(frs1, frs2, &env->fp_status));
>   }
>   
> -uint64_t helper_fsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> +uint64_t helper_fsub_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
> +    float32 frs2 = check_nanbox_s(rs2);
>       return nanbox_s(float32_sub(frs1, frs2, &env->fp_status));
>   }
>   
> -uint64_t helper_fmul_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> +uint64_t helper_fmul_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
> +    float32 frs2 = check_nanbox_s(rs2);
>       return nanbox_s(float32_mul(frs1, frs2, &env->fp_status));
>   }
>   
> -uint64_t helper_fdiv_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> +uint64_t helper_fdiv_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
> +    float32 frs2 = check_nanbox_s(rs2);
>       return nanbox_s(float32_div(frs1, frs2, &env->fp_status));
>   }
>   
> -uint64_t helper_fmin_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> +uint64_t helper_fmin_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
> +    float32 frs2 = check_nanbox_s(rs2);
>       return nanbox_s(float32_minnum(frs1, frs2, &env->fp_status));
>   }
>   
> -uint64_t helper_fmax_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> +uint64_t helper_fmax_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
> +    float32 frs2 = check_nanbox_s(rs2);
>       return nanbox_s(float32_maxnum(frs1, frs2, &env->fp_status));
>   }
>   
> -uint64_t helper_fsqrt_s(CPURISCVState *env, uint64_t frs1)
> +uint64_t helper_fsqrt_s(CPURISCVState *env, uint64_t rs1)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
>       return nanbox_s(float32_sqrt(frs1, &env->fp_status));
>   }
>   
> -target_ulong helper_fle_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> +target_ulong helper_fle_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
> +    float32 frs2 = check_nanbox_s(rs2);
>       return float32_le(frs1, frs2, &env->fp_status);
>   }
>   
> -target_ulong helper_flt_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> +target_ulong helper_flt_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
> +    float32 frs2 = check_nanbox_s(rs2);
>       return float32_lt(frs1, frs2, &env->fp_status);
>   }
>   
> -target_ulong helper_feq_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> +target_ulong helper_feq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
> +    float32 frs2 = check_nanbox_s(rs2);
>       return float32_eq_quiet(frs1, frs2, &env->fp_status);
>   }
>   
> -target_ulong helper_fcvt_w_s(CPURISCVState *env, uint64_t frs1)
> +target_ulong helper_fcvt_w_s(CPURISCVState *env, uint64_t rs1)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
>       return float32_to_int32(frs1, &env->fp_status);
>   }
>   
> -target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t frs1)
> +target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t rs1)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
>       return (int32_t)float32_to_uint32(frs1, &env->fp_status);
>   }
>   
>   #if defined(TARGET_RISCV64)
> -uint64_t helper_fcvt_l_s(CPURISCVState *env, uint64_t frs1)
> +uint64_t helper_fcvt_l_s(CPURISCVState *env, uint64_t rs1)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
>       return float32_to_int64(frs1, &env->fp_status);
>   }
>   
> -uint64_t helper_fcvt_lu_s(CPURISCVState *env, uint64_t frs1)
> +uint64_t helper_fcvt_lu_s(CPURISCVState *env, uint64_t rs1)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
>       return float32_to_uint64(frs1, &env->fp_status);
>   }
>   #endif
> @@ -233,8 +259,9 @@ uint64_t helper_fcvt_s_lu(CPURISCVState *env, uint64_t rs1)
>   }
>   #endif
>   
> -target_ulong helper_fclass_s(uint64_t frs1)
> +target_ulong helper_fclass_s(uint64_t rs1)
>   {
> +    float32 frs1 = check_nanbox_s(rs1);
>       return fclass_s(frs1);
>   }
>   
> @@ -275,7 +302,8 @@ uint64_t helper_fcvt_s_d(CPURISCVState *env, uint64_t rs1)
>   
>   uint64_t helper_fcvt_d_s(CPURISCVState *env, uint64_t rs1)
>   {
> -    return float32_to_float64(rs1, &env->fp_status);
> +    float32 frs1 = check_nanbox_s(rs1);
> +    return float32_to_float64(frs1, &env->fp_status);
>   }
>   
>   uint64_t helper_fsqrt_d(CPURISCVState *env, uint64_t frs1)


