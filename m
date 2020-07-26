Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6FBC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 10:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB29206D8
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 10:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB29206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzdXa-0005Pr-Rz
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 06:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jzdWt-0004nh-8v; Sun, 26 Jul 2020 06:05:15 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:57298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jzdWq-0006u8-27; Sun, 26 Jul 2020 06:05:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E1ECA74638A;
 Sun, 26 Jul 2020 12:04:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 98BBB745712; Sun, 26 Jul 2020 12:04:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 94EED745702;
 Sun, 26 Jul 2020 12:04:58 +0200 (CEST)
Date: Sun, 26 Jul 2020 12:04:58 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>
Subject: Re: [PATCH] target/ppc: Fix SPE unavailable exception triggering
In-Reply-To: <20200725191436.31828-1-matthieu.bucchianeri@leostella.com>
Message-ID: <alpine.BSF.2.22.395.2007261202050.35472@zero.eik.bme.hu>
References: <20200725191436.31828-1-matthieu.bucchianeri@leostella.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1406235146-1595757898=:35472"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 06:04:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1406235146-1595757898=:35472
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 25 Jul 2020, Matthieu Bucchianeri wrote:
> When emulating certain floating point instructions or vector instructions on
> PowerPC machines, QEMU did not properly generate the SPE/Embedded Floating-
> Point Unavailable interrupt. See the buglink further below for references to
> the relevant NXP documentation.
>
> This patch fixes the behavior of some evfs* instructions that were
> incorrectly emitting the interrupt.
>
> More importantly, this patch fixes the behavior of several efd* and ev*
> instructions that were not generating the interrupt. Triggering the
> interrupt for these instructions fixes lazy FPU/vector context switching on
> some operating systems like Linux.
>
> Without this patch, the result of some double-precision arithmetic could be
> corrupted due to the lack of proper saving and restoring of the upper
> 32-bit part of the general-purpose registers.
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1888918
> Buglink: https://bugs.launchpad.net/qemu/+bug/1611394
> Signed-off-by: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>
> ---
> target/ppc/translate/spe-impl.inc.c | 101 ++++++++++++++++++----------
> 1 file changed, 66 insertions(+), 35 deletions(-)
>
> diff --git a/target/ppc/translate/spe-impl.inc.c b/target/ppc/translate/spe-impl.inc.c
> index 36b4d5654d..2e6e799a25 100644
> --- a/target/ppc/translate/spe-impl.inc.c
> +++ b/target/ppc/translate/spe-impl.inc.c
> @@ -349,14 +349,24 @@ static inline void gen_evmergelohi(DisasContext *ctx)
> }
> static inline void gen_evsplati(DisasContext *ctx)
> {
> -    uint64_t imm = ((int32_t)(rA(ctx->opcode) << 27)) >> 27;
> +    uint64_t imm;
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
> +    imm = ((int32_t)(rA(ctx->opcode) << 27)) >> 27;
>
>     tcg_gen_movi_tl(cpu_gpr[rD(ctx->opcode)], imm);
>     tcg_gen_movi_tl(cpu_gprh[rD(ctx->opcode)], imm);
> }
> static inline void gen_evsplatfi(DisasContext *ctx)
> {
> -    uint64_t imm = rA(ctx->opcode) << 27;
> +    uint64_t imm;
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
> +    imm = rA(ctx->opcode) << 27;
>
>     tcg_gen_movi_tl(cpu_gpr[rD(ctx->opcode)], imm);
>     tcg_gen_movi_tl(cpu_gprh[rD(ctx->opcode)], imm);
> @@ -389,21 +399,37 @@ static inline void gen_evsel(DisasContext *ctx)
>
> static void gen_evsel0(DisasContext *ctx)
> {
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
>     gen_evsel(ctx);
> }
>
> static void gen_evsel1(DisasContext *ctx)
> {
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
>     gen_evsel(ctx);
> }
>
> static void gen_evsel2(DisasContext *ctx)
> {
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
>     gen_evsel(ctx);
> }
>
> static void gen_evsel3(DisasContext *ctx)
> {
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
>     gen_evsel(ctx);
> }
>
> @@ -518,6 +544,11 @@ static inline void gen_evmwsmia(DisasContext *ctx)
> {
>     TCGv_i64 tmp;
>
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
> +
>     gen_evmwsmi(ctx);            /* rD := rA * rB */
>
>     tmp = tcg_temp_new_i64();
> @@ -531,8 +562,13 @@ static inline void gen_evmwsmia(DisasContext *ctx)
>
> static inline void gen_evmwsmiaa(DisasContext *ctx)
> {
> -    TCGv_i64 acc = tcg_temp_new_i64();
> -    TCGv_i64 tmp = tcg_temp_new_i64();
> +    TCGv_i64 acc;
> +    TCGv_i64 tmp;
> +
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }

Isn't this missing here:

acc = tcg_temp_new_i64();
tmp = tcg_temp_new_i64();

You've removed allocating temps but this hunk does not add it back after 
the exception unlike others in this patch.

Regards,
BALATON Zoltan

>
>     gen_evmwsmi(ctx);           /* rD := rA * rB */
>
> @@ -892,8 +928,14 @@ static inline void gen_##name(DisasContext *ctx)                              \
> #define GEN_SPEFPUOP_CONV_32_64(name)                                         \
> static inline void gen_##name(DisasContext *ctx)                              \
> {                                                                             \
> -    TCGv_i64 t0 = tcg_temp_new_i64();                                         \
> -    TCGv_i32 t1 = tcg_temp_new_i32();                                         \
> +    TCGv_i64 t0;                                                              \
> +    TCGv_i32 t1;                                                              \
> +    if (unlikely(!ctx->spe_enabled)) {                                        \
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);                                \
> +        return;                                                               \
> +    }                                                                         \
> +    t0 = tcg_temp_new_i64();                                                  \
> +    t1 = tcg_temp_new_i32();                                                  \
>     gen_load_gpr64(t0, rB(ctx->opcode));                                      \
>     gen_helper_##name(t1, cpu_env, t0);                                       \
>     tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], t1);                        \
> @@ -903,8 +945,14 @@ static inline void gen_##name(DisasContext *ctx)                              \
> #define GEN_SPEFPUOP_CONV_64_32(name)                                         \
> static inline void gen_##name(DisasContext *ctx)                              \
> {                                                                             \
> -    TCGv_i64 t0 = tcg_temp_new_i64();                                         \
> -    TCGv_i32 t1 = tcg_temp_new_i32();                                         \
> +    TCGv_i64 t0;                                                              \
> +    TCGv_i32 t1;                                                              \
> +    if (unlikely(!ctx->spe_enabled)) {                                        \
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);                                \
> +        return;                                                               \
> +    }                                                                         \
> +    t0 = tcg_temp_new_i64();                                                  \
> +    t1 = tcg_temp_new_i32();                                                  \
>     tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);                       \
>     gen_helper_##name(t0, cpu_env, t1);                                       \
>     gen_store_gpr64(rD(ctx->opcode), t0);                                     \
> @@ -914,7 +962,12 @@ static inline void gen_##name(DisasContext *ctx)                              \
> #define GEN_SPEFPUOP_CONV_64_64(name)                                         \
> static inline void gen_##name(DisasContext *ctx)                              \
> {                                                                             \
> -    TCGv_i64 t0 = tcg_temp_new_i64();                                         \
> +    TCGv_i64 t0;                                                              \
> +    if (unlikely(!ctx->spe_enabled)) {                                        \
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);                                \
> +        return;                                                               \
> +    }                                                                         \
> +    t0 = tcg_temp_new_i64();                                                  \
>     gen_load_gpr64(t0, rB(ctx->opcode));                                      \
>     gen_helper_##name(t0, cpu_env, t0);                                       \
>     gen_store_gpr64(rD(ctx->opcode), t0);                                     \
> @@ -923,13 +976,8 @@ static inline void gen_##name(DisasContext *ctx)                              \
> #define GEN_SPEFPUOP_ARITH2_32_32(name)                                       \
> static inline void gen_##name(DisasContext *ctx)                              \
> {                                                                             \
> -    TCGv_i32 t0, t1;                                                          \
> -    if (unlikely(!ctx->spe_enabled)) {                                        \
> -        gen_exception(ctx, POWERPC_EXCP_SPEU);                                \
> -        return;                                                               \
> -    }                                                                         \
> -    t0 = tcg_temp_new_i32();                                                  \
> -    t1 = tcg_temp_new_i32();                                                  \
> +    TCGv_i32 t0 = tcg_temp_new_i32();                                         \
> +    TCGv_i32 t1 = tcg_temp_new_i32();                                         \
>     tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);                       \
>     tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);                       \
>     gen_helper_##name(t0, cpu_env, t0, t1);                                   \
> @@ -958,13 +1006,8 @@ static inline void gen_##name(DisasContext *ctx)                              \
> #define GEN_SPEFPUOP_COMP_32(name)                                            \
> static inline void gen_##name(DisasContext *ctx)                              \
> {                                                                             \
> -    TCGv_i32 t0, t1;                                                          \
> -    if (unlikely(!ctx->spe_enabled)) {                                        \
> -        gen_exception(ctx, POWERPC_EXCP_SPEU);                                \
> -        return;                                                               \
> -    }                                                                         \
> -    t0 = tcg_temp_new_i32();                                                  \
> -    t1 = tcg_temp_new_i32();                                                  \
> +    TCGv_i32 t0 = tcg_temp_new_i32();                                         \
> +    TCGv_i32 t1 = tcg_temp_new_i32();                                         \
>                                                                               \
>     tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);                       \
>     tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);                       \
> @@ -1074,28 +1117,16 @@ GEN_SPEFPUOP_ARITH2_32_32(efsmul);
> GEN_SPEFPUOP_ARITH2_32_32(efsdiv);
> static inline void gen_efsabs(DisasContext *ctx)
> {
> -    if (unlikely(!ctx->spe_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_SPEU);
> -        return;
> -    }
>     tcg_gen_andi_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
>                     (target_long)~0x80000000LL);
> }
> static inline void gen_efsnabs(DisasContext *ctx)
> {
> -    if (unlikely(!ctx->spe_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_SPEU);
> -        return;
> -    }
>     tcg_gen_ori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
>                    0x80000000);
> }
> static inline void gen_efsneg(DisasContext *ctx)
> {
> -    if (unlikely(!ctx->spe_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_SPEU);
> -        return;
> -    }
>     tcg_gen_xori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
>                     0x80000000);
> }
> --
> 2.17.1
>
> LeoStella, LLC
> A joint venture of Thales Alenia Space and Spaceflight Industries
>
> 12501 E Marginal Way S • Tukwila, WA 98168
>
> Proprietary Document: This document may contain trade secrets or otherwise proprietary and confidential information owned by LeoStella LLC. It is intended only for the individual addressee and may not be copied, distributed, or otherwise disclosed without LeoStella LLC express prior written authorization.
> Export Controlled: This document may contain technical data whose export is restricted by the Arms Export Control Act (Title 22, U.S.C., Sec 2751 et seq.) or the Export Administration Act of 1979, as amended, Title 50,U.S.C., app 2401 et seq. Violation of these export laws are subject to severe criminal penalties. Recipient shall not export, re-export, or otherwise transfer or share this document to any foreign person (as defined by U.S. export laws) without advance written authorization from LeoStella LLC.
>
>
--3866299591-1406235146-1595757898=:35472--

