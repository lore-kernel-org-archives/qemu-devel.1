Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89565C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F92520714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F92520714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyqpM-0002Y1-FF
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jyqon-000277-EH; Fri, 24 Jul 2020 02:04:29 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:53040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jyqok-00040Z-Ew; Fri, 24 Jul 2020 02:04:29 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0744274|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.0251564-0.00101945-0.973824; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01l07440; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.I6o5CbQ_1595570654; 
Received: from 30.225.208.37(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I6o5CbQ_1595570654)
 by smtp.aliyun-inc.com(10.147.41.120);
 Fri, 24 Jul 2020 14:04:16 +0800
Subject: Re: [PATCH v2 5/7] target/riscv: Check nanboxed inputs in
 trans_rvf.inc.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200724002807.441147-1-richard.henderson@linaro.org>
 <20200724002807.441147-6-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <e953ce76-984f-7931-4979-9b140f22ea84@c-sky.com>
Date: Fri, 24 Jul 2020 14:04:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724002807.441147-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 02:04:16
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
> If a 32-bit input is not properly nanboxed, then the input is replaced
> with the default qnan.  The only inline expansion is for the sign-changing
> set of instructions: FSGNJ.S, FSGNJX.S, FSGNJN.S.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/insn_trans/trans_rvf.inc.c | 71 +++++++++++++++++++------
>   target/riscv/translate.c                | 18 +++++++
>   2 files changed, 73 insertions(+), 16 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
> index 264d3139f1..f9a9e0643a 100644
> --- a/target/riscv/insn_trans/trans_rvf.inc.c
> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> @@ -161,47 +161,86 @@ static bool trans_fsgnj_s(DisasContext *ctx, arg_fsgnj_s *a)
>   {
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVF);
> +
>       if (a->rs1 == a->rs2) { /* FMOV */
> -        tcg_gen_mov_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1]);
> +        gen_check_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rs1]);
>       } else { /* FSGNJ */
> -        tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rs2], cpu_fpr[a->rs1],
> -                            0, 31);
> +        TCGv_i64 rs1 = tcg_temp_new_i64();
> +        TCGv_i64 rs2 = tcg_temp_new_i64();
> +
> +        gen_check_nanbox_s(rs1, cpu_fpr[a->rs1]);
> +        gen_check_nanbox_s(rs2, cpu_fpr[a->rs2]);
> +
> +        /* This formulation retains the nanboxing of rs2. */
> +        tcg_gen_deposit_i64(cpu_fpr[a->rd], rs2, rs1, 0, 31);
> +        tcg_temp_free_i64(rs1);
> +        tcg_temp_free_i64(rs2);
>       }
> -    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
>       mark_fs_dirty(ctx);
>       return true;
>   }
>   
>   static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
>   {
> +    TCGv_i64 rs1, rs2, mask;
> +
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVF);
> +
> +    rs1 = tcg_temp_new_i64();
> +    gen_check_nanbox_s(rs1, cpu_fpr[a->rs1]);
> +
>       if (a->rs1 == a->rs2) { /* FNEG */
> -        tcg_gen_xori_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], INT32_MIN);
> +        tcg_gen_xori_i64(cpu_fpr[a->rd], rs1, MAKE_64BIT_MASK(31, 1));
>       } else {
> -        TCGv_i64 t0 = tcg_temp_new_i64();
> -        tcg_gen_not_i64(t0, cpu_fpr[a->rs2]);
> -        tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1], 0, 31);
> -        tcg_temp_free_i64(t0);
> +        rs2 = tcg_temp_new_i64();
> +        gen_check_nanbox_s(rs2, cpu_fpr[a->rs2]);
> +
> +        /*
> +         * Replace bit 31 in rs1 with inverse in rs2.
> +         * This formulation retains the nanboxing of rs1.
> +         */
> +        mask = tcg_const_i64(~MAKE_64BIT_MASK(31, 1));
> +        tcg_gen_andc_i64(rs2, mask, rs2);
> +        tcg_gen_and_i64(rs1, mask, rs1);
> +        tcg_gen_or_i64(cpu_fpr[a->rd], rs1, rs2);
> +
> +        tcg_temp_free_i64(mask);
> +        tcg_temp_free_i64(rs2);
>       }
> -    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
> +    tcg_temp_free_i64(rs1);
> +
>       mark_fs_dirty(ctx);
>       return true;
>   }
>   
>   static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
>   {
> +    TCGv_i64 rs1, rs2;
> +
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVF);
> +
> +    rs1 = tcg_temp_new_i64();
> +    gen_check_nanbox_s(rs1, cpu_fpr[a->rs1]);
> +
>       if (a->rs1 == a->rs2) { /* FABS */
> -        tcg_gen_andi_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], ~INT32_MIN);
> +        tcg_gen_andi_i64(cpu_fpr[a->rd], rs1, ~MAKE_64BIT_MASK(31, 1));
>       } else {
> -        TCGv_i64 t0 = tcg_temp_new_i64();
> -        tcg_gen_andi_i64(t0, cpu_fpr[a->rs2], INT32_MIN);
> -        tcg_gen_xor_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], t0);
> -        tcg_temp_free_i64(t0);
> +        rs2 = tcg_temp_new_i64();
> +        gen_check_nanbox_s(rs2, cpu_fpr[a->rs2]);
> +
> +        /*
> +         * Xor bit 31 in rs1 with that in rs2.
> +         * This formulation retains the nanboxing of rs1.
> +         */
> +        tcg_gen_andi_i64(rs2, rs2, MAKE_64BIT_MASK(31, 1));
> +        tcg_gen_xor_i64(cpu_fpr[a->rd], rs1, rs2);
> +
> +        tcg_temp_free_i64(rs2);
>       }
> -    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
> +    tcg_temp_free_i64(rs1);
> +
>       mark_fs_dirty(ctx);
>       return true;
>   }
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 12a746da97..bf35182776 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -101,6 +101,24 @@ static void gen_nanbox_s(TCGv_i64 out, TCGv_i64 in)
>       tcg_gen_ori_i64(out, in, MAKE_64BIT_MASK(32, 32));
>   }
>   
> +/*
> + * A narrow n-bit operation, where n < FLEN, checks that input operands
> + * are correctly Nan-boxed, i.e., all upper FLEN - n bits are 1.
> + * If so, the least-significant bits of the input are used, otherwise the
> + * input value is treated as an n-bit canonical NaN (v2.2 section 9.2).
> + *
> + * Here, the result is always nan-boxed, even the canonical nan.
> + */
> +static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
> +{
> +    TCGv_i64 t_max = tcg_const_i64(0xffffffff00000000ull);
> +    TCGv_i64 t_nan = tcg_const_i64(0xffffffff7fc00000ull);
> +
> +    tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
> +    tcg_temp_free_i64(t_max);
> +    tcg_temp_free_i64(t_nan);
> +}
> +
Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Zhiwei
>   static void generate_exception(DisasContext *ctx, int excp)
>   {
>       tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);


