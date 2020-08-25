Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A218CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64EE62071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/9zXHe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EE62071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAePy-0002lw-Mf
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAeLz-00071W-Ip; Tue, 25 Aug 2020 15:11:31 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29]:43201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAeLw-0004dg-04; Tue, 25 Aug 2020 15:11:31 -0400
Received: by mail-io1-xd29.google.com with SMTP id s1so13646030iot.10;
 Tue, 25 Aug 2020 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8kuu8m76nI7ILhR2nWQ8449DPSjfAX5AK4rdQ2mEEmY=;
 b=R/9zXHe7eE8Q+hMKV8q7viAj9xDXuKZdcGrjkSle2cMiulHwJiLqvzIaohrtLlqJXG
 LwE2Wg5o2stJg+51JHOG3A448Uof6CIW9Ni8V9xgIY3e2EeQsBStJmxFuUkyqR0nnzUC
 NkvavOxIp9CUP7p3ZyMjHs3pOSoZcq/VMOPFfIy/lvXpCBl2fIyBpX0DdraEae6tS/hJ
 N02fk6GyI1hTxUuSc1foTRmVUtpTWcOwKlo/8mWx60CdC2Bs/aVdc6kbavocO67mOjyY
 qmT7yIARMTFU8wwsYm7HTFokcSu0hQxGdxoYhY0XGCOu9KYSHQtpcH7WFbvuu6vsC3Mi
 gkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8kuu8m76nI7ILhR2nWQ8449DPSjfAX5AK4rdQ2mEEmY=;
 b=MiszJRxkOGiKORnpv3E+MI8y2MO3QZ8w7aw0VguYAkapNXUqYH7rOLDmiGHj/Gcz7V
 +7w4xrjQOr9agKnRlxmefMU9DX/l39HitgD3VbbsuQCE0CL5FUZZ7lN6HylkJ5XxkzFm
 kTMocRtNT3BxHUANQW9RH/AdH+KvCnz7GOcJjhxsb0+0/MOtVsB6f35OR5zba99HOc0h
 4m+K/SdF1fByUuyrNdGJzHJkzb1UJjz8wHh7VR5jzX2YMiOCPy5JQwMILFujuVe0FMsR
 4lPrfh//F5KSqcT96TFQrv8wZlEX/PWvBW6bJ7rnp0NeJNWzrL2EhAqF74gLug88xsL+
 K2kw==
X-Gm-Message-State: AOAM533zwG1TN249H3SKHPjSJAFYZWRgSAOTBIAVKQ7Uu5vnaBdnsdw3
 ohRxlOm0RDBxPOjfhnmw3g3fw+hRPHtvFqT1q9Q=
X-Google-Smtp-Source: ABdhPJy1u6djQNprW/ht6Osaq6gJBnQR4bdbIinGPw1iSGddeF+/bgIyqLpTod0r8Q1lQuRZD4EJsqGD9wbDAQX+4qE=
X-Received: by 2002:a5d:995a:: with SMTP id v26mr10082661ios.176.1598382686054; 
 Tue, 25 Aug 2020 12:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <1597136381-17296-1-git-send-email-chihmin.chao@sifive.com>
 <1597136381-17296-3-git-send-email-chihmin.chao@sifive.com>
In-Reply-To: <1597136381-17296-3-git-send-email-chihmin.chao@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Aug 2020 12:00:43 -0700
Message-ID: <CAKmqyKM5SfOOHqUfHuuKJVqY8pGTDq8HbV4VTJB9Pa7a41AuKQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/riscv: Implement zfh extension
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd29.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Kito Cheng <kito.cheng@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 2:00 AM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>
> From: Kito Cheng <kito.cheng@sifive.com>
>
> All of instructions listed in spec has been implemented. The spec is still
> under discussion and not included master branch.

QEMU is happy to accept draft specs, but we need the draft spec at
least somewhat finalised. What that means here is that this probably
has to wait until the draft spec is merged into the master branch of
the RISC-V ISA spec.

Also, the QEMU implementation will need to be fully implemented, at
least all of the mandatory parts of the spec (optional parts can be
left out).

I had a quick skim through this patch and it looks good. Maybe it will
be worth splitting it up a bit more especially if the final
implementation will be larger.

Alistair

>
> ref:
>   https://github.com/riscv/riscv-isa-manual/tree/zfh
>
> Signed-off-by: Kito Cheng <kito.cheng@sifive.com>
> Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
> ---
>  target/riscv/cpu.h                        |   1 +
>  target/riscv/fpu_helper.c                 | 180 ++++++++++
>  target/riscv/helper.h                     |  34 ++
>  target/riscv/insn32-64.decode             |   6 +
>  target/riscv/insn32.decode                |  32 ++
>  target/riscv/insn_trans/trans_rvzfh.inc.c | 531 ++++++++++++++++++++++++++++++
>  target/riscv/translate.c                  |   1 +
>  7 files changed, 785 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_rvzfh.inc.c
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index a804a5d..6a077c1 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -65,6 +65,7 @@
>  #define RVS RV('S')
>  #define RVU RV('U')
>  #define RVH RV('H')
> +#define RVZfh RV('K')
>
>  /* S extension denotes that Supervisor mode exists, however it is possible
>     to have a core that support S mode but does not have an MMU and there
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index 2c52ff1..5b1b210 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -81,6 +81,15 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
>      set_float_rounding_mode(softrm, &env->fp_status);
>  }
>
> +static uint64_t do_fmadd_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2,
> +                           uint64_t rs3, int flags)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    float16 frs2 = check_nanbox_h(rs2);
> +    float16 frs3 = check_nanbox_h(rs3);
> +    return nanbox_h(float16_muladd(frs1, frs2, frs3, flags, &env->fp_status));
> +}
> +
>  static uint64_t do_fmadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2,
>                             uint64_t rs3, int flags)
>  {
> @@ -102,6 +111,12 @@ uint64_t helper_fmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>      return float64_muladd(frs1, frs2, frs3, 0, &env->fp_status);
>  }
>
> +uint64_t helper_fmadd_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> +                        uint64_t frs3)
> +{
> +    return do_fmadd_h(env, frs1, frs2, frs3, 0);
> +}
> +
>  uint64_t helper_fmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>                          uint64_t frs3)
>  {
> @@ -115,6 +130,12 @@ uint64_t helper_fmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>                            &env->fp_status);
>  }
>
> +uint64_t helper_fmsub_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> +                        uint64_t frs3)
> +{
> +    return do_fmadd_h(env, frs1, frs2, frs3, float_muladd_negate_c);
> +}
> +
>  uint64_t helper_fnmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>                           uint64_t frs3)
>  {
> @@ -128,6 +149,12 @@ uint64_t helper_fnmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>                            &env->fp_status);
>  }
>
> +uint64_t helper_fnmsub_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> +                         uint64_t frs3)
> +{
> +    return do_fmadd_h(env, frs1, frs2, frs3, float_muladd_negate_product);
> +}
> +
>  uint64_t helper_fnmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>                           uint64_t frs3)
>  {
> @@ -142,6 +169,13 @@ uint64_t helper_fnmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>                            float_muladd_negate_product, &env->fp_status);
>  }
>
> +uint64_t helper_fnmadd_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> +                         uint64_t frs3)
> +{
> +    return do_fmadd_h(env, frs1, frs2, frs3,
> +                      float_muladd_negate_c | float_muladd_negate_product);
> +}
> +
>  uint64_t helper_fadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>  {
>      float32 frs1 = check_nanbox_s(rs1);
> @@ -374,3 +408,149 @@ target_ulong helper_fclass_d(uint64_t frs1)
>  {
>      return fclass_d(frs1);
>  }
> +
> +uint64_t helper_fadd_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    float16 frs2 = check_nanbox_h(rs2);
> +    return nanbox_h(float16_add(frs1, frs2, &env->fp_status));
> +}
> +
> +uint64_t helper_fsub_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    float16 frs2 = check_nanbox_h(rs2);
> +    return nanbox_h(float16_sub(frs1, frs2, &env->fp_status));
> +}
> +
> +uint64_t helper_fmul_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    float16 frs2 = check_nanbox_h(rs2);
> +    return nanbox_h(float16_mul(frs1, frs2, &env->fp_status));
> +}
> +
> +uint64_t helper_fdiv_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    float16 frs2 = check_nanbox_h(rs2);
> +    return nanbox_h(float16_div(frs1, frs2, &env->fp_status));
> +}
> +
> +uint64_t helper_fmin_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    float16 frs2 = check_nanbox_h(rs2);
> +    return nanbox_h(float16_minnum_noprop(frs1, frs2, &env->fp_status));
> +}
> +
> +uint64_t helper_fmax_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    float16 frs2 = check_nanbox_h(rs2);
> +    return nanbox_h(float16_maxnum_noprop(frs1, frs2, &env->fp_status));
> +}
> +
> +uint64_t helper_fsqrt_h(CPURISCVState *env, uint64_t rs1)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    return nanbox_h(float16_sqrt(frs1, &env->fp_status));
> +}
> +
> +target_ulong helper_fle_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    float16 frs2 = check_nanbox_h(rs2);
> +    return float16_le(frs1, frs2, &env->fp_status);
> +}
> +
> +target_ulong helper_flt_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    float16 frs2 = check_nanbox_h(rs2);
> +    return float16_lt(frs1, frs2, &env->fp_status);
> +}
> +
> +target_ulong helper_feq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    float16 frs2 = check_nanbox_h(rs2);
> +    return float16_eq_quiet(frs1, frs2, &env->fp_status);
> +}
> +
> +target_ulong helper_fclass_h(uint64_t rs1)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    return fclass_h(frs1);
> +}
> +
> +target_ulong helper_fcvt_w_h(CPURISCVState *env, uint64_t rs1)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    return float16_to_int32(frs1, &env->fp_status);
> +}
> +
> +target_ulong helper_fcvt_wu_h(CPURISCVState *env, uint64_t rs1)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    return (int32_t)float16_to_uint32(frs1, &env->fp_status);
> +}
> +
> +#if defined(TARGET_RISCV64)
> +uint64_t helper_fcvt_l_h(CPURISCVState *env, uint64_t rs1)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    return float16_to_int64(frs1, &env->fp_status);
> +}
> +
> +uint64_t helper_fcvt_lu_h(CPURISCVState *env, uint64_t rs1)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    return float16_to_uint64(frs1, &env->fp_status);
> +}
> +#endif
> +
> +uint64_t helper_fcvt_h_w(CPURISCVState *env, target_ulong rs1)
> +{
> +    return nanbox_h(int32_to_float16((int32_t)rs1, &env->fp_status));
> +}
> +
> +uint64_t helper_fcvt_h_wu(CPURISCVState *env, target_ulong rs1)
> +{
> +    return nanbox_h(uint32_to_float16((uint32_t)rs1, &env->fp_status));
> +}
> +
> +#if defined(TARGET_RISCV64)
> +uint64_t helper_fcvt_h_l(CPURISCVState *env, uint64_t rs1)
> +{
> +    return nanbox_h(int64_to_float16(rs1, &env->fp_status));
> +}
> +
> +uint64_t helper_fcvt_h_lu(CPURISCVState *env, uint64_t rs1)
> +{
> +    return nanbox_h(uint64_to_float16(rs1, &env->fp_status));
> +}
> +#endif
> +
> +uint64_t helper_fcvt_h_s(CPURISCVState *env, uint64_t rs1)
> +{
> +    float32 frs1 = check_nanbox_s(rs1);
> +    return nanbox_h(float32_to_float16(frs1, true, &env->fp_status));
> +}
> +
> +uint64_t helper_fcvt_s_h(CPURISCVState *env, uint64_t rs1)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    return nanbox_s(float16_to_float32(frs1, true, &env->fp_status));
> +}
> +
> +uint64_t helper_fcvt_h_d(CPURISCVState *env, uint64_t rs1)
> +{
> +    return nanbox_h(float64_to_float16(rs1, true, &env->fp_status));
> +}
> +
> +uint64_t helper_fcvt_d_h(CPURISCVState *env, uint64_t rs1)
> +{
> +    float16 frs1 = check_nanbox_h(rs1);
> +    return float16_to_float64(frs1, true, &env->fp_status);
> +}
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index acc2982..66c95dc 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -7,12 +7,16 @@ DEF_HELPER_FLAGS_2(set_rounding_mode, TCG_CALL_NO_WG, void, env, i32)
>  /* Floating Point - fused */
>  DEF_HELPER_FLAGS_4(fmadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
>  DEF_HELPER_FLAGS_4(fmadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
> +DEF_HELPER_FLAGS_4(fmadd_h, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
>  DEF_HELPER_FLAGS_4(fmsub_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
>  DEF_HELPER_FLAGS_4(fmsub_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
> +DEF_HELPER_FLAGS_4(fmsub_h, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
>  DEF_HELPER_FLAGS_4(fnmsub_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
>  DEF_HELPER_FLAGS_4(fnmsub_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
> +DEF_HELPER_FLAGS_4(fnmsub_h, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
>  DEF_HELPER_FLAGS_4(fnmadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
>  DEF_HELPER_FLAGS_4(fnmadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
> +DEF_HELPER_FLAGS_4(fnmadd_h, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
>
>  /* Floating Point - Single Precision */
>  DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
> @@ -66,6 +70,36 @@ DEF_HELPER_FLAGS_2(fcvt_d_lu, TCG_CALL_NO_RWG, i64, env, tl)
>  #endif
>  DEF_HELPER_FLAGS_1(fclass_d, TCG_CALL_NO_RWG_SE, tl, i64)
>
> +/* Floating Point - Half Precision */
> +DEF_HELPER_FLAGS_3(fadd_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(fsub_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(fmul_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(fdiv_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(fmin_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(fmax_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_2(fsqrt_h, TCG_CALL_NO_RWG, i64, env, i64)
> +DEF_HELPER_FLAGS_3(fle_h, TCG_CALL_NO_RWG, tl, env, i64, i64)
> +DEF_HELPER_FLAGS_3(flt_h, TCG_CALL_NO_RWG, tl, env, i64, i64)
> +DEF_HELPER_FLAGS_3(feq_h, TCG_CALL_NO_RWG, tl, env, i64, i64)
> +DEF_HELPER_FLAGS_2(fcvt_s_h, TCG_CALL_NO_RWG, i64, env, i64)
> +DEF_HELPER_FLAGS_2(fcvt_h_s, TCG_CALL_NO_RWG, i64, env, i64)
> +DEF_HELPER_FLAGS_2(fcvt_d_h, TCG_CALL_NO_RWG, i64, env, i64)
> +DEF_HELPER_FLAGS_2(fcvt_h_d, TCG_CALL_NO_RWG, i64, env, i64)
> +DEF_HELPER_FLAGS_2(fcvt_w_h, TCG_CALL_NO_RWG, tl, env, i64)
> +DEF_HELPER_FLAGS_2(fcvt_wu_h, TCG_CALL_NO_RWG, tl, env, i64)
> +#if defined(TARGET_RISCV64)
> +DEF_HELPER_FLAGS_2(fcvt_l_h, TCG_CALL_NO_RWG, tl, env, i64)
> +DEF_HELPER_FLAGS_2(fcvt_lu_h, TCG_CALL_NO_RWG, tl, env, i64)
> +#endif
> +DEF_HELPER_FLAGS_2(fcvt_h_w, TCG_CALL_NO_RWG, i64, env, tl)
> +DEF_HELPER_FLAGS_2(fcvt_h_wu, TCG_CALL_NO_RWG, i64, env, tl)
> +#if defined(TARGET_RISCV64)
> +DEF_HELPER_FLAGS_2(fcvt_h_l, TCG_CALL_NO_RWG, i64, env, tl)
> +DEF_HELPER_FLAGS_2(fcvt_h_lu, TCG_CALL_NO_RWG, i64, env, tl)
> +#endif
> +DEF_HELPER_FLAGS_1(fclass_h, TCG_CALL_NO_RWG_SE, tl, i64)
> +
> +
>  /* Special functions */
>  DEF_HELPER_3(csrrw, tl, env, tl, tl)
>  DEF_HELPER_4(csrrs, tl, env, tl, tl, tl)
> diff --git a/target/riscv/insn32-64.decode b/target/riscv/insn32-64.decode
> index 86153d9..f6f1ac9 100644
> --- a/target/riscv/insn32-64.decode
> +++ b/target/riscv/insn32-64.decode
> @@ -81,3 +81,9 @@ fmv_x_d    1110001  00000 ..... 000 ..... 1010011 @r2
>  fcvt_d_l   1101001  00010 ..... ... ..... 1010011 @r2_rm
>  fcvt_d_lu  1101001  00011 ..... ... ..... 1010011 @r2_rm
>  fmv_d_x    1111001  00000 ..... 000 ..... 1010011 @r2
> +
> +# *** RV64Zfh Standard Extension (in addition to RV32Zfh) ***
> +fcvt_l_h   1100010  00010 ..... ... ..... 1010011 @r2_rm
> +fcvt_lu_h  1100010  00011 ..... ... ..... 1010011 @r2_rm
> +fcvt_h_l   1101010  00010 ..... ... ..... 1010011 @r2_rm
> +fcvt_h_lu  1101010  00011 ..... ... ..... 1010011 @r2_rm
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index bdd8563..185fc4b 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -581,3 +581,35 @@ vcompress_vm    010111 - ..... ..... 010 ..... 1010111 @r
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> +
> +# *** RV32Zfh Extension ***
> +flh        ............   ..... 001 ..... 0000111 @i
> +fsh        .......  ..... ..... 001 ..... 0100111 @s
> +fmadd_h    ..... 10 ..... ..... ... ..... 1000011 @r4_rm
> +fmsub_h    ..... 10 ..... ..... ... ..... 1000111 @r4_rm
> +fnmsub_h   ..... 10 ..... ..... ... ..... 1001011 @r4_rm
> +fnmadd_h   ..... 10 ..... ..... ... ..... 1001111 @r4_rm
> +fadd_h     0000010  ..... ..... ... ..... 1010011 @r_rm
> +fsub_h     0000110  ..... ..... ... ..... 1010011 @r_rm
> +fmul_h     0001010  ..... ..... ... ..... 1010011 @r_rm
> +fdiv_h     0001110  ..... ..... ... ..... 1010011 @r_rm
> +fsqrt_h    0101110  00000 ..... ... ..... 1010011 @r2_rm
> +fsgnj_h    0010010  ..... ..... 000 ..... 1010011 @r
> +fsgnjn_h   0010010  ..... ..... 001 ..... 1010011 @r
> +fsgnjx_h   0010010  ..... ..... 010 ..... 1010011 @r
> +fmin_h     0010110  ..... ..... 000 ..... 1010011 @r
> +fmax_h     0010110  ..... ..... 001 ..... 1010011 @r
> +fcvt_h_s   0100010  00000 ..... ... ..... 1010011 @r2_rm
> +fcvt_s_h   0100000  00010 ..... ... ..... 1010011 @r2_rm
> +fcvt_h_d   0100010  00001 ..... ... ..... 1010011 @r2_rm
> +fcvt_d_h   0100001  00010 ..... ... ..... 1010011 @r2_rm
> +fcvt_w_h   1100010  00000 ..... ... ..... 1010011 @r2_rm
> +fcvt_wu_h  1100010  00001 ..... ... ..... 1010011 @r2_rm
> +fmv_x_h    1110010  00000 ..... 000 ..... 1010011 @r2
> +feq_h      1010010  ..... ..... 010 ..... 1010011 @r
> +flt_h      1010010  ..... ..... 001 ..... 1010011 @r
> +fle_h      1010010  ..... ..... 000 ..... 1010011 @r
> +fclass_h   1110010  00000 ..... 001 ..... 1010011 @r2
> +fcvt_h_w   1101010  00000 ..... ... ..... 1010011 @r2_rm
> +fcvt_h_wu  1101010  00001 ..... ... ..... 1010011 @r2_rm
> +fmv_h_x    1111010  00000 ..... 000 ..... 1010011 @r2
> diff --git a/target/riscv/insn_trans/trans_rvzfh.inc.c b/target/riscv/insn_trans/trans_rvzfh.inc.c
> new file mode 100644
> index 0000000..1b4dede
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzfh.inc.c
> @@ -0,0 +1,531 @@
> +/*
> + * RISC-V translation routines for the RV64Zfh Standard Extension.
> + *
> + * Copyright (c) 2020 SiFive, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +static bool trans_flh(DisasContext *ctx, arg_flh *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_get_gpr(t0, a->rs1);
> +
> +    tcg_gen_addi_tl(t0, t0, a->imm);
> +
> +    tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUW);
> +
> +    gen_nanbox_h(cpu_fpr[a->rd], cpu_fpr[a->rd]);
> +
> +    mark_fs_dirty(ctx);
> +    tcg_temp_free(t0);
> +    return true;
> +}
> +
> +static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_get_gpr(t0, a->rs1);
> +    tcg_gen_addi_tl(t0, t0, a->imm);
> +
> +    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEUW);
> +
> +    mark_fs_dirty(ctx);
> +    tcg_temp_free(t0);
> +    return true;
> +}
> +
> +static bool trans_fmadd_h(DisasContext *ctx, arg_fmadd_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fmadd_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
> +                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fmsub_h(DisasContext *ctx, arg_fmsub_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fmsub_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
> +                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fnmsub_h(DisasContext *ctx, arg_fnmsub_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fnmsub_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
> +                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fnmadd_h(DisasContext *ctx, arg_fnmadd_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fnmadd_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
> +                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fadd_h(DisasContext *ctx, arg_fadd_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fadd_h(cpu_fpr[a->rd], cpu_env,
> +                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fsub_h(DisasContext *ctx, arg_fsub_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fsub_h(cpu_fpr[a->rd], cpu_env,
> +                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fmul_h(DisasContext *ctx, arg_fmul_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fmul_h(cpu_fpr[a->rd], cpu_env,
> +                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fdiv_h(DisasContext *ctx, arg_fdiv_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fdiv_h(cpu_fpr[a->rd], cpu_env,
> +                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fsqrt_h(DisasContext *ctx, arg_fsqrt_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fsqrt_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fsgnj_h(DisasContext *ctx, arg_fsgnj_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    if (a->rs1 == a->rs2) { /* FMOV */
> +        gen_check_nanbox_h(cpu_fpr[a->rd], cpu_fpr[a->rs1]);
> +    } else {
> +        TCGv_i64 rs1 = tcg_temp_new_i64();
> +        TCGv_i64 rs2 = tcg_temp_new_i64();
> +
> +        gen_check_nanbox_h(rs1, cpu_fpr[a->rs1]);
> +        gen_check_nanbox_h(rs2, cpu_fpr[a->rs2]);
> +
> +        /* This formulation retains the nanboxing of rs2. */
> +        tcg_gen_deposit_i64(cpu_fpr[a->rd], rs2, rs1, 0, 15);
> +        tcg_temp_free_i64(rs1);
> +        tcg_temp_free_i64(rs2);
> +    }
> +
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fsgnjn_h(DisasContext *ctx, arg_fsgnjn_h *a)
> +{
> +    TCGv_i64 rs1, rs2, mask;
> +
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    rs1 = tcg_temp_new_i64();
> +    gen_check_nanbox_h(rs1, cpu_fpr[a->rs1]);
> +
> +    if (a->rs1 == a->rs2) { /* FNEG */
> +        tcg_gen_xori_i64(cpu_fpr[a->rd], rs1, MAKE_64BIT_MASK(15, 1));
> +    } else {
> +        rs2 = tcg_temp_new_i64();
> +        gen_check_nanbox_h(rs2, cpu_fpr[a->rs2]);
> +
> +        /*
> +         * Replace bit 15 in rs1 with inverse in rs2.
> +         * This formulation retains the nanboxing of rs1.
> +         */
> +        mask = tcg_const_i64(~MAKE_64BIT_MASK(15, 1));
> +        tcg_gen_not_i64(rs2, rs2);
> +        tcg_gen_andc_i64(rs2, rs2, mask);
> +        tcg_gen_and_i64(rs1, mask, rs1);
> +        tcg_gen_or_i64(cpu_fpr[a->rd], rs1, rs2);
> +
> +        tcg_temp_free_i64(mask);
> +        tcg_temp_free_i64(rs2);
> +    }
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fsgnjx_h(DisasContext *ctx, arg_fsgnjx_h *a)
> +{
> +    TCGv_i64 rs1, rs2;
> +
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    rs1 = tcg_temp_new_i64();
> +    gen_check_nanbox_s(rs1, cpu_fpr[a->rs1]);
> +
> +    if (a->rs1 == a->rs2) { /* FABS */
> +        tcg_gen_andi_i64(cpu_fpr[a->rd], rs1, ~MAKE_64BIT_MASK(15, 1));
> +    } else {
> +        rs2 = tcg_temp_new_i64();
> +        gen_check_nanbox_s(rs2, cpu_fpr[a->rs2]);
> +
> +        /*
> +         * Xor bit 15 in rs1 with that in rs2.
> +         * This formulation retains the nanboxing of rs1.
> +         */
> +        tcg_gen_andi_i64(rs2, rs2, MAKE_64BIT_MASK(15, 1));
> +        tcg_gen_xor_i64(cpu_fpr[a->rd], rs1, rs2);
> +
> +        tcg_temp_free_i64(rs2);
> +    }
> +
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fmin_h(DisasContext *ctx, arg_fmin_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    gen_helper_fmin_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
> +                      cpu_fpr[a->rs2]);
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fmax_h(DisasContext *ctx, arg_fmax_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    gen_helper_fmax_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
> +                      cpu_fpr[a->rs2]);
> +    mark_fs_dirty(ctx);
> +    return true;
> +}
> +
> +static bool trans_fcvt_s_h(DisasContext *ctx, arg_fcvt_s_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_s_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
> +
> +    mark_fs_dirty(ctx);
> +
> +    return true;
> +}
> +
> +static bool trans_fcvt_d_h(DisasContext *ctx, arg_fcvt_d_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +    REQUIRE_EXT(ctx, RVD);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_d_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
> +
> +    mark_fs_dirty(ctx);
> +
> +
> +    return true;
> +}
> +
> +static bool trans_fcvt_h_s(DisasContext *ctx, arg_fcvt_h_s *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_h_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
> +
> +    mark_fs_dirty(ctx);
> +
> +    return true;
> +}
> +
> +static bool trans_fcvt_h_d(DisasContext *ctx, arg_fcvt_h_d *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +    REQUIRE_EXT(ctx, RVD);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_h_d(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
> +
> +    mark_fs_dirty(ctx);
> +
> +    return true;
> +}
> +
> +static bool trans_feq_h(DisasContext *ctx, arg_feq_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +    TCGv t0 = tcg_temp_new();
> +    gen_helper_feq_h(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
> +    gen_set_gpr(a->rd, t0);
> +    tcg_temp_free(t0);
> +    return true;
> +}
> +
> +static bool trans_flt_h(DisasContext *ctx, arg_flt_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +    TCGv t0 = tcg_temp_new();
> +    gen_helper_flt_h(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
> +    gen_set_gpr(a->rd, t0);
> +    tcg_temp_free(t0);
> +    return true;
> +}
> +
> +static bool trans_fle_h(DisasContext *ctx, arg_fle_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +    TCGv t0 = tcg_temp_new();
> +    gen_helper_fle_h(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
> +    gen_set_gpr(a->rd, t0);
> +    tcg_temp_free(t0);
> +    return true;
> +}
> +
> +static bool trans_fclass_h(DisasContext *ctx, arg_fclass_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    TCGv t0 = tcg_temp_new();
> +
> +    gen_helper_fclass_h(t0, cpu_fpr[a->rs1]);
> +
> +    gen_set_gpr(a->rd, t0);
> +    tcg_temp_free(t0);
> +
> +    return true;
> +}
> +
> +static bool trans_fcvt_w_h(DisasContext *ctx, arg_fcvt_w_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_w_h(t0, cpu_env, cpu_fpr[a->rs1]);
> +    gen_set_gpr(a->rd, t0);
> +    tcg_temp_free(t0);
> +
> +    return true;
> +}
> +
> +static bool trans_fcvt_wu_h(DisasContext *ctx, arg_fcvt_wu_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_wu_h(t0, cpu_env, cpu_fpr[a->rs1]);
> +    gen_set_gpr(a->rd, t0);
> +    tcg_temp_free(t0);
> +
> +    return true;
> +}
> +
> +static bool trans_fcvt_h_w(DisasContext *ctx, arg_fcvt_h_w *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_get_gpr(t0, a->rs1);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_h_w(cpu_fpr[a->rd], cpu_env, t0);
> +
> +    mark_fs_dirty(ctx);
> +    tcg_temp_free(t0);
> +
> +    return true;
> +}
> +
> +static bool trans_fcvt_h_wu(DisasContext *ctx, arg_fcvt_h_wu *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_get_gpr(t0, a->rs1);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_h_wu(cpu_fpr[a->rd], cpu_env, t0);
> +
> +    mark_fs_dirty(ctx);
> +    tcg_temp_free(t0);
> +
> +    return true;
> +}
> +
> +static bool trans_fmv_x_h(DisasContext *ctx, arg_fmv_x_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    TCGv t0 = tcg_temp_new();
> +
> +#if defined(TARGET_RISCV64)
> +    tcg_gen_ext16s_tl(t0, cpu_fpr[a->rs1]); // 16 bits->64 bits
> +#else
> +    tcg_gen_extrl_i64_i32(t0, cpu_fpr[a->rs1]); //16 bits->32 bits
> +    tcg_gen_ext16s_tl(t0, t0);
> +#endif
> +
> +    gen_set_gpr(a->rd, t0);
> +    tcg_temp_free(t0);
> +
> +    return true;
> +}
> +
> +static bool trans_fmv_h_x(DisasContext *ctx, arg_fmv_h_x *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_get_gpr(t0, a->rs1);
> +
> +    tcg_gen_extu_tl_i64(cpu_fpr[a->rd], t0);
> +    gen_nanbox_h(cpu_fpr[a->rd], cpu_fpr[a->rd]);
> +
> +    mark_fs_dirty(ctx);
> +    tcg_temp_free(t0);
> +
> +    return true;
> +}
> +
> +#ifdef TARGET_RISCV64
> +
> +static bool trans_fcvt_l_h(DisasContext *ctx, arg_fcvt_l_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_l_h(t0, cpu_env, cpu_fpr[a->rs1]);
> +    gen_set_gpr(a->rd, t0);
> +    tcg_temp_free(t0);
> +
> +    return true;
> +}
> +
> +static bool trans_fcvt_lu_h(DisasContext *ctx, arg_fcvt_lu_h *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_lu_h(t0, cpu_env, cpu_fpr[a->rs1]);
> +    gen_set_gpr(a->rd, t0);
> +    tcg_temp_free(t0);
> +
> +    return true;
> +}
> +
> +static bool trans_fcvt_h_l(DisasContext *ctx, arg_fcvt_h_l *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_get_gpr(t0, a->rs1);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_h_l(cpu_fpr[a->rd], cpu_env, t0);
> +
> +    mark_fs_dirty(ctx);
> +    tcg_temp_free(t0);
> +
> +    return true;
> +}
> +
> +static bool trans_fcvt_h_lu(DisasContext *ctx, arg_fcvt_h_lu *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_EXT(ctx, RVZfh);
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_get_gpr(t0, a->rs1);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_h_lu(cpu_fpr[a->rd], cpu_env, t0);
> +
> +    mark_fs_dirty(ctx);
> +    tcg_temp_free(t0);
> +
> +    return true;
> +}
> +#endif
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index e227534..6dbd8c9 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -769,6 +769,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>  #include "insn_trans/trans_rvd.inc.c"
>  #include "insn_trans/trans_rvh.inc.c"
>  #include "insn_trans/trans_rvv.inc.c"
> +#include "insn_trans/trans_rvzfh.inc.c"
>  #include "insn_trans/trans_privileged.inc.c"
>
>  /* Include the auto-generated decoder for 16 bit insn */
> --
> 2.7.4
>
>

