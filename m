Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0059CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 07:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB48B20809
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 07:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB48B20809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqAqt-0007VO-0x
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 03:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqAq5-00071M-Hw; Tue, 30 Jun 2020 03:37:57 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:53719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqAq1-0006JI-3h; Tue, 30 Jun 2020 03:37:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07608247|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.415385-0.0926819-0.491933;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l10434; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.Hv2zGhJ_1593502660; 
Received: from 30.225.208.21(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Hv2zGhJ_1593502660)
 by smtp.aliyun-inc.com(10.147.42.197);
 Tue, 30 Jun 2020 15:37:41 +0800
Subject: Re: [PATCH 5/6] target/riscv: Flush not valid NaN-boxing input to
 canonical NaN
To: Chih-Min Chao <chihmin.chao@sifive.com>
References: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
 <20200626205917.4545-6-zhiwei_liu@c-sky.com>
 <CAEiOBXVqe06_ODA_wou0R8QthNP-g87Apvgpx0jhLNmz9-pmPQ@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <dda16a36-0814-7bc6-6ee8-dec9a75fe1e4@c-sky.com>
Date: Tue, 30 Jun 2020 15:37:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAEiOBXVqe06_ODA_wou0R8QthNP-g87Apvgpx0jhLNmz9-pmPQ@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------8597DABE0A314A0E1AD3D2A4"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:56:46
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Ian Jiang <ianjiang.ict@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------8597DABE0A314A0E1AD3D2A4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/6/30 15:31, Chih-Min Chao wrote:
> On Sat, Jun 27, 2020 at 5:09 AM LIU Zhiwei <zhiwei_liu@c-sky.com 
> <mailto:zhiwei_liu@c-sky.com>> wrote:
>
>     Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com
>     <mailto:zhiwei_liu@c-sky.com>>
>     ---
>      target/riscv/insn_trans/trans_rvd.inc.c |   7 +-
>      target/riscv/insn_trans/trans_rvf.inc.c | 272
>     ++++++++++++++++++++----
>      2 files changed, 235 insertions(+), 44 deletions(-)
>
>     diff --git a/target/riscv/insn_trans/trans_rvd.inc.c
>     b/target/riscv/insn_trans/trans_rvd.inc.c
>     index c0f4a0c789..16947ea6da 100644
>     --- a/target/riscv/insn_trans/trans_rvd.inc.c
>     +++ b/target/riscv/insn_trans/trans_rvd.inc.c
>     @@ -241,10 +241,15 @@ static bool trans_fcvt_d_s(DisasContext
>     *ctx, arg_fcvt_d_s *a)
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVD);
>
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    check_nanboxed(ctx, 1, t1);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fcvt_d_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
>     +    gen_helper_fcvt_d_s(cpu_fpr[a->rd], cpu_env, t1);
>
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>          return true;
>      }
>
>     diff --git a/target/riscv/insn_trans/trans_rvf.inc.c
>     b/target/riscv/insn_trans/trans_rvf.inc.c
>     index 04bc8e5cb5..b0379b9d1f 100644
>     --- a/target/riscv/insn_trans/trans_rvf.inc.c
>     +++ b/target/riscv/insn_trans/trans_rvf.inc.c
>     @@ -58,11 +58,23 @@ static bool trans_fmadd_s(DisasContext *ctx,
>     arg_fmadd_s *a)
>      {
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>     +
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    TCGv_i64 t3 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]);
>     +    check_nanboxed(ctx, 3, t1, t2, t3);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fmadd_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
>     -                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
>     +    gen_helper_fmadd_s(cpu_fpr[a->rd], cpu_env, t1, t2, t3);
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>     +    tcg_temp_free_i64(t3);
>          return true;
>      }
>
>     @@ -70,11 +82,23 @@ static bool trans_fmsub_s(DisasContext *ctx,
>     arg_fmsub_s *a)
>      {
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>     +
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    TCGv_i64 t3 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]);
>     +    check_nanboxed(ctx, 3, t1, t2, t3);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fmsub_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
>     -                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
>     +    gen_helper_fmsub_s(cpu_fpr[a->rd], cpu_env, t1, t2, t3);
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>     +    tcg_temp_free_i64(t3);
>          return true;
>      }
>
>     @@ -82,11 +106,23 @@ static bool trans_fnmsub_s(DisasContext *ctx,
>     arg_fnmsub_s *a)
>      {
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>     +
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    TCGv_i64 t3 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]);
>     +    check_nanboxed(ctx, 3, t1, t2, t3);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fnmsub_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
>     -                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
>     +    gen_helper_fnmsub_s(cpu_fpr[a->rd], cpu_env, t1, t2, t3);
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>     +    tcg_temp_free_i64(t3);
>          return true;
>      }
>
>     @@ -94,11 +130,23 @@ static bool trans_fnmadd_s(DisasContext *ctx,
>     arg_fnmadd_s *a)
>      {
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>     +
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    TCGv_i64 t3 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]);
>     +    check_nanboxed(ctx, 3, t1, t2, t3);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fnmadd_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
>     -                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
>     -    mark_fs_dirty(ctx);
>     +    gen_helper_fnmadd_s(cpu_fpr[a->rd], cpu_env, t1, t2, t3);
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>     +    mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>     +    tcg_temp_free_i64(t3);
>          return true;
>      }
>
>     @@ -107,11 +155,19 @@ static bool trans_fadd_s(DisasContext *ctx,
>     arg_fadd_s *a)
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    check_nanboxed(ctx, 2, t1, t2);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fadd_s(cpu_fpr[a->rd], cpu_env,
>     -                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>     +    gen_helper_fadd_s(cpu_fpr[a->rd], cpu_env, t1, t2);
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>          return true;
>      }
>
>     @@ -120,11 +176,19 @@ static bool trans_fsub_s(DisasContext *ctx,
>     arg_fsub_s *a)
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    check_nanboxed(ctx, 2, t1, t2);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fsub_s(cpu_fpr[a->rd], cpu_env,
>     -                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>     +    gen_helper_fsub_s(cpu_fpr[a->rd], cpu_env, t1, t2);
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>          return true;
>      }
>
>     @@ -133,11 +197,19 @@ static bool trans_fmul_s(DisasContext *ctx,
>     arg_fmul_s *a)
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    check_nanboxed(ctx, 2, t1, t2);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fmul_s(cpu_fpr[a->rd], cpu_env,
>     -                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>     +    gen_helper_fmul_s(cpu_fpr[a->rd], cpu_env, t1, t2);
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>          return true;
>      }
>
>     @@ -146,11 +218,19 @@ static bool trans_fdiv_s(DisasContext *ctx,
>     arg_fdiv_s *a)
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    check_nanboxed(ctx, 2, t1, t2);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fdiv_s(cpu_fpr[a->rd], cpu_env,
>     -                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>     +    gen_helper_fdiv_s(cpu_fpr[a->rd], cpu_env, t1, t2);
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>          return true;
>      }
>
>     @@ -159,10 +239,16 @@ static bool trans_fsqrt_s(DisasContext *ctx,
>     arg_fsqrt_s *a)
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    check_nanboxed(ctx, 1, t1);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fsqrt_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
>     +    gen_helper_fsqrt_s(cpu_fpr[a->rd], cpu_env, t1);
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>          return true;
>      }
>
>     @@ -170,14 +256,23 @@ static bool trans_fsgnj_s(DisasContext *ctx,
>     arg_fsgnj_s *a)
>      {
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>     +
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    check_nanboxed(ctx, 2, t1, t2);
>     +
>          if (a->rs1 == a->rs2) { /* FMOV */
>     -        tcg_gen_mov_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1]);
>     +        tcg_gen_mov_i64(cpu_fpr[a->rd], t1);
>          } else { /* FSGNJ */
>     -        tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rs2],
>     cpu_fpr[a->rs1],
>     -                            0, 31);
>     +        tcg_gen_deposit_i64(cpu_fpr[a->rd], t2, t1, 0, 31);
>          }
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>          return true;
>      }
>
>     @@ -185,16 +280,26 @@ static bool trans_fsgnjn_s(DisasContext
>     *ctx, arg_fsgnjn_s *a)
>      {
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>     +
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    check_nanboxed(ctx, 2, t1, t2);
>     +
>          if (a->rs1 == a->rs2) { /* FNEG */
>     -        tcg_gen_xori_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], INT32_MIN);
>     +        tcg_gen_xori_i64(cpu_fpr[a->rd], t1, INT32_MIN);
>          } else {
>              TCGv_i64 t0 = tcg_temp_new_i64();
>     -        tcg_gen_not_i64(t0, cpu_fpr[a->rs2]);
>     -        tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1],
>     0, 31);
>     +        tcg_gen_not_i64(t0, t2);
>     +        tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, t1, 0, 31);
>              tcg_temp_free_i64(t0);
>          }
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>          return true;
>      }
>
>     @@ -202,16 +307,26 @@ static bool trans_fsgnjx_s(DisasContext
>     *ctx, arg_fsgnjx_s *a)
>      {
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>     +
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    check_nanboxed(ctx, 2, t1, t2);
>     +
>          if (a->rs1 == a->rs2) { /* FABS */
>     -        tcg_gen_andi_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1],
>     ~INT32_MIN);
>     +        tcg_gen_andi_i64(cpu_fpr[a->rd], t1, ~INT32_MIN);
>          } else {
>              TCGv_i64 t0 = tcg_temp_new_i64();
>     -        tcg_gen_andi_i64(t0, cpu_fpr[a->rs2], INT32_MIN);
>     -        tcg_gen_xor_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], t0);
>     +        tcg_gen_andi_i64(t0, t2, INT32_MIN);
>     +        tcg_gen_xor_i64(cpu_fpr[a->rd], t1, t0);
>              tcg_temp_free_i64(t0);
>          }
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>          return true;
>      }
>
>     @@ -220,10 +335,18 @@ static bool trans_fmin_s(DisasContext *ctx,
>     arg_fmin_s *a)
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>
>     -    gen_helper_fmin_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
>     -                      cpu_fpr[a->rs2]);
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    check_nanboxed(ctx, 2, t1, t2);
>     +
>     +    gen_helper_fmin_s(cpu_fpr[a->rd], cpu_env, t1, t2);
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>          return true;
>      }
>
>     @@ -232,10 +355,18 @@ static bool trans_fmax_s(DisasContext *ctx,
>     arg_fmax_s *a)
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>
>     -    gen_helper_fmax_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
>     -                      cpu_fpr[a->rs2]);
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    check_nanboxed(ctx, 2, t1, t2);
>     +
>     +    gen_helper_fmax_s(cpu_fpr[a->rd], cpu_env, t1, t2);
>          gen_nanbox_fpr(ctx, a->rd);
>     +
>          mark_fs_dirty(ctx);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>          return true;
>      }
>
>     @@ -245,11 +376,16 @@ static bool trans_fcvt_w_s(DisasContext
>     *ctx, arg_fcvt_w_s *a)
>          REQUIRE_EXT(ctx, RVF);
>
>          TCGv t0 = tcg_temp_new();
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    check_nanboxed(ctx, 1, t1);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fcvt_w_s(t0, cpu_env, cpu_fpr[a->rs1]);
>     +    gen_helper_fcvt_w_s(t0, cpu_env, t1);
>          gen_set_gpr(a->rd, t0);
>     -    tcg_temp_free(t0);
>
>     +    tcg_temp_free(t0);
>     +    tcg_temp_free_i64(t1);
>          return true;
>      }
>
>     @@ -259,11 +395,16 @@ static bool trans_fcvt_wu_s(DisasContext
>     *ctx, arg_fcvt_wu_s *a)
>          REQUIRE_EXT(ctx, RVF);
>
>          TCGv t0 = tcg_temp_new();
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    check_nanboxed(ctx, 1, t1);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fcvt_wu_s(t0, cpu_env, cpu_fpr[a->rs1]);
>     +    gen_helper_fcvt_wu_s(t0, cpu_env, t1);
>          gen_set_gpr(a->rd, t0);
>     -    tcg_temp_free(t0);
>
>     +    tcg_temp_free(t0);
>     +    tcg_temp_free_i64(t1);
>          return true;
>      }
>
>     @@ -291,10 +432,20 @@ static bool trans_feq_s(DisasContext *ctx,
>     arg_feq_s *a)
>      {
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>     +
>          TCGv t0 = tcg_temp_new();
>     -    gen_helper_feq_s(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    check_nanboxed(ctx, 2, t1, t2);
>     +
>     +    gen_helper_feq_s(t0, cpu_env, t1, t2);
>          gen_set_gpr(a->rd, t0);
>     +
>          tcg_temp_free(t0);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>          return true;
>      }
>
>     @@ -302,10 +453,20 @@ static bool trans_flt_s(DisasContext *ctx,
>     arg_flt_s *a)
>      {
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>     +
>          TCGv t0 = tcg_temp_new();
>     -    gen_helper_flt_s(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    check_nanboxed(ctx, 2, t1, t2);
>     +
>     +    gen_helper_flt_s(t0, cpu_env, t1, t2);
>          gen_set_gpr(a->rd, t0);
>     +
>          tcg_temp_free(t0);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>          return true;
>      }
>
>     @@ -313,10 +474,20 @@ static bool trans_fle_s(DisasContext *ctx,
>     arg_fle_s *a)
>      {
>          REQUIRE_FPU;
>          REQUIRE_EXT(ctx, RVF);
>     +
>          TCGv t0 = tcg_temp_new();
>     -    gen_helper_fle_s(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    TCGv_i64 t2 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>     +    check_nanboxed(ctx, 2, t1, t2);
>     +
>     +    gen_helper_fle_s(t0, cpu_env, t1, t2);
>          gen_set_gpr(a->rd, t0);
>     +
>          tcg_temp_free(t0);
>     +    tcg_temp_free_i64(t1);
>     +    tcg_temp_free_i64(t2);
>          return true;
>      }
>
>     @@ -326,12 +497,15 @@ static bool trans_fclass_s(DisasContext
>     *ctx, arg_fclass_s *a)
>          REQUIRE_EXT(ctx, RVF);
>
>          TCGv t0 = tcg_temp_new();
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    check_nanboxed(ctx, 1, t1);
>
>     -    gen_helper_fclass_s(t0, cpu_fpr[a->rs1]);
>     -
>     +    gen_helper_fclass_s(t0, t1);
>          gen_set_gpr(a->rd, t0);
>     -    tcg_temp_free(t0);
>
>     +    tcg_temp_free(t0);
>     +    tcg_temp_free_i64(t1);
>          return true;
>      }
>
>     @@ -400,10 +574,16 @@ static bool trans_fcvt_l_s(DisasContext
>     *ctx, arg_fcvt_l_s *a)
>          REQUIRE_EXT(ctx, RVF);
>
>          TCGv t0 = tcg_temp_new();
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    check_nanboxed(ctx, 1, t1);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fcvt_l_s(t0, cpu_env, cpu_fpr[a->rs1]);
>     +    gen_helper_fcvt_l_s(t0, cpu_env, t1);
>          gen_set_gpr(a->rd, t0);
>     +
>          tcg_temp_free(t0);
>     +    tcg_temp_free_i64(t1);
>          return true;
>      }
>
>     @@ -413,10 +593,16 @@ static bool trans_fcvt_lu_s(DisasContext
>     *ctx, arg_fcvt_lu_s *a)
>          REQUIRE_EXT(ctx, RVF);
>
>          TCGv t0 = tcg_temp_new();
>     +    TCGv_i64 t1 = tcg_temp_new_i64();
>     +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>     +    check_nanboxed(ctx, 1, t1);
>     +
>          gen_set_rm(ctx, a->rm);
>     -    gen_helper_fcvt_lu_s(t0, cpu_env, cpu_fpr[a->rs1]);
>     +    gen_helper_fcvt_lu_s(t0, cpu_env, t1);
>          gen_set_gpr(a->rd, t0);
>     +
>          tcg_temp_free(t0);
>     +    tcg_temp_free_i64(t1);
>          return true;
>      }
>
>     -- 
>     2.23.0
>
>
> It may be more readable to use local macro to wrap allocation and free 
> of tcg temp variables. Most functions are two-operands,
> some requires one and the other needs three operands. They may be like
>
> #define GEN_ONE_OPERAND \
>       TCGv_i64 t1 = tcg_temp_new_i64(); \
>       tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]); \
>       check_nanboxed(ctx, 1, t1);
>
>  #define GEN_TWO_OPERAND \
>       TCGv_i64 t1 = tcg_temp_new_i64(); \
>       TCGv_i64 t2 = tcg_temp_new_i64(); \
>       tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]); \
>       tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]); \
>       check_nanboxed(ctx, 2, t1, t2);
>
>   #define GEN_THREE_OPERAND \
>       TCGv_i64 t1 = tcg_temp_new_i64(); \
>       TCGv_i64 t2 = tcg_temp_new_i64(); \
>       TCGv_i64 t3 = tcg_temp_new_i64(); \
>       tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]); \
>       tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]); \
>       tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]); \
>       check_nanboxed(ctx, 3, t1, t2, t3);
>
>   #define FREE_ONE_OPERAND \
>       tcg_temp_free_i64(t1);
>
>   #define FREE_TWO_OPERAND \
>       tcg_temp_free_i64(t1); \
>       tcg_temp_free_i64(t2);
>
>   #define FREE_THREE_OPERAND \
>       tcg_temp_free_i64(t1); \
>       tcg_temp_free_i64(t2); \
>       tcg_temp_free_i64(t3);
>
Good.

Do you think inline function will be better? I just don't like many 
MACROS in one function.

Zhiwei
> Chih-Min Chao


--------------8597DABE0A314A0E1AD3D2A4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/6/30 15:31, Chih-Min Chao
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAEiOBXVqe06_ODA_wou0R8QthNP-g87Apvgpx0jhLNmz9-pmPQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">On Sat, Jun 27, 2020 at 5:09 AM LIU Zhiwei &lt;<a
            href="mailto:zhiwei_liu@c-sky.com" target="_blank"
            moz-do-not-send="true">zhiwei_liu@c-sky.com</a>&gt; wrote:<br>
        </div>
        <div class="gmail_quote">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Signed-off-by: LIU Zhiwei
            &lt;<a href="mailto:zhiwei_liu@c-sky.com" target="_blank"
              moz-do-not-send="true">zhiwei_liu@c-sky.com</a>&gt;<br>
            ---<br>
             target/riscv/insn_trans/trans_rvd.inc.c |   7 +-<br>
             target/riscv/insn_trans/trans_rvf.inc.c | 272
            ++++++++++++++++++++----<br>
             2 files changed, 235 insertions(+), 44 deletions(-)<br>
            <br>
            diff --git a/target/riscv/insn_trans/trans_rvd.inc.c
            b/target/riscv/insn_trans/trans_rvd.inc.c<br>
            index c0f4a0c789..16947ea6da 100644<br>
            --- a/target/riscv/insn_trans/trans_rvd.inc.c<br>
            +++ b/target/riscv/insn_trans/trans_rvd.inc.c<br>
            @@ -241,10 +241,15 @@ static bool
            trans_fcvt_d_s(DisasContext *ctx, arg_fcvt_d_s *a)<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVD);<br>
            <br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    check_nanboxed(ctx, 1, t1);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fcvt_d_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1]);<br>
            +    gen_helper_fcvt_d_s(cpu_fpr[a-&gt;rd], cpu_env, t1);<br>
            <br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
                 return true;<br>
             }<br>
            <br>
            diff --git a/target/riscv/insn_trans/trans_rvf.inc.c
            b/target/riscv/insn_trans/trans_rvf.inc.c<br>
            index 04bc8e5cb5..b0379b9d1f 100644<br>
            --- a/target/riscv/insn_trans/trans_rvf.inc.c<br>
            +++ b/target/riscv/insn_trans/trans_rvf.inc.c<br>
            @@ -58,11 +58,23 @@ static bool trans_fmadd_s(DisasContext
            *ctx, arg_fmadd_s *a)<br>
             {<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t3 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    tcg_gen_mov_i64(t3, cpu_fpr[a-&gt;rs3]);<br>
            +    check_nanboxed(ctx, 3, t1, t2, t3);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fmadd_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1],<br>
            -                       cpu_fpr[a-&gt;rs2],
            cpu_fpr[a-&gt;rs3]);<br>
            +    gen_helper_fmadd_s(cpu_fpr[a-&gt;rd], cpu_env, t1, t2,
            t3);<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
            +    tcg_temp_free_i64(t3);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -70,11 +82,23 @@ static bool trans_fmsub_s(DisasContext
            *ctx, arg_fmsub_s *a)<br>
             {<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t3 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    tcg_gen_mov_i64(t3, cpu_fpr[a-&gt;rs3]);<br>
            +    check_nanboxed(ctx, 3, t1, t2, t3);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fmsub_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1],<br>
            -                       cpu_fpr[a-&gt;rs2],
            cpu_fpr[a-&gt;rs3]);<br>
            +    gen_helper_fmsub_s(cpu_fpr[a-&gt;rd], cpu_env, t1, t2,
            t3);<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
            +    tcg_temp_free_i64(t3);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -82,11 +106,23 @@ static bool trans_fnmsub_s(DisasContext
            *ctx, arg_fnmsub_s *a)<br>
             {<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t3 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    tcg_gen_mov_i64(t3, cpu_fpr[a-&gt;rs3]);<br>
            +    check_nanboxed(ctx, 3, t1, t2, t3);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fnmsub_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1],<br>
            -                        cpu_fpr[a-&gt;rs2],
            cpu_fpr[a-&gt;rs3]);<br>
            +    gen_helper_fnmsub_s(cpu_fpr[a-&gt;rd], cpu_env, t1, t2,
            t3);<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
            +    tcg_temp_free_i64(t3);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -94,11 +130,23 @@ static bool trans_fnmadd_s(DisasContext
            *ctx, arg_fnmadd_s *a)<br>
             {<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t3 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    tcg_gen_mov_i64(t3, cpu_fpr[a-&gt;rs3]);<br>
            +    check_nanboxed(ctx, 3, t1, t2, t3);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fnmadd_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1],<br>
            -                        cpu_fpr[a-&gt;rs2],
            cpu_fpr[a-&gt;rs3]);<br>
            -    mark_fs_dirty(ctx);<br>
            +    gen_helper_fnmadd_s(cpu_fpr[a-&gt;rd], cpu_env, t1, t2,
            t3);<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            +    mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
            +    tcg_temp_free_i64(t3);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -107,11 +155,19 @@ static bool trans_fadd_s(DisasContext
            *ctx, arg_fadd_s *a)<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            <br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fadd_s(cpu_fpr[a-&gt;rd], cpu_env,<br>
            -                      cpu_fpr[a-&gt;rs1],
            cpu_fpr[a-&gt;rs2]);<br>
            +    gen_helper_fadd_s(cpu_fpr[a-&gt;rd], cpu_env, t1, t2);<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -120,11 +176,19 @@ static bool trans_fsub_s(DisasContext
            *ctx, arg_fsub_s *a)<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            <br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fsub_s(cpu_fpr[a-&gt;rd], cpu_env,<br>
            -                      cpu_fpr[a-&gt;rs1],
            cpu_fpr[a-&gt;rs2]);<br>
            +    gen_helper_fsub_s(cpu_fpr[a-&gt;rd], cpu_env, t1, t2);<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -133,11 +197,19 @@ static bool trans_fmul_s(DisasContext
            *ctx, arg_fmul_s *a)<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            <br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fmul_s(cpu_fpr[a-&gt;rd], cpu_env,<br>
            -                      cpu_fpr[a-&gt;rs1],
            cpu_fpr[a-&gt;rs2]);<br>
            +    gen_helper_fmul_s(cpu_fpr[a-&gt;rd], cpu_env, t1, t2);<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -146,11 +218,19 @@ static bool trans_fdiv_s(DisasContext
            *ctx, arg_fdiv_s *a)<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            <br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fdiv_s(cpu_fpr[a-&gt;rd], cpu_env,<br>
            -                      cpu_fpr[a-&gt;rs1],
            cpu_fpr[a-&gt;rs2]);<br>
            +    gen_helper_fdiv_s(cpu_fpr[a-&gt;rd], cpu_env, t1, t2);<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -159,10 +239,16 @@ static bool trans_fsqrt_s(DisasContext
            *ctx, arg_fsqrt_s *a)<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            <br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    check_nanboxed(ctx, 1, t1);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fsqrt_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1]);<br>
            +    gen_helper_fsqrt_s(cpu_fpr[a-&gt;rd], cpu_env, t1);<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -170,14 +256,23 @@ static bool trans_fsgnj_s(DisasContext
            *ctx, arg_fsgnj_s *a)<br>
             {<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
                 if (a-&gt;rs1 == a-&gt;rs2) { /* FMOV */<br>
            -        tcg_gen_mov_i64(cpu_fpr[a-&gt;rd],
            cpu_fpr[a-&gt;rs1]);<br>
            +        tcg_gen_mov_i64(cpu_fpr[a-&gt;rd], t1);<br>
                 } else { /* FSGNJ */<br>
            -        tcg_gen_deposit_i64(cpu_fpr[a-&gt;rd],
            cpu_fpr[a-&gt;rs2], cpu_fpr[a-&gt;rs1],<br>
            -                            0, 31);<br>
            +        tcg_gen_deposit_i64(cpu_fpr[a-&gt;rd], t2, t1, 0,
            31);<br>
                 }<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -185,16 +280,26 @@ static bool
            trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)<br>
             {<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
                 if (a-&gt;rs1 == a-&gt;rs2) { /* FNEG */<br>
            -        tcg_gen_xori_i64(cpu_fpr[a-&gt;rd],
            cpu_fpr[a-&gt;rs1], INT32_MIN);<br>
            +        tcg_gen_xori_i64(cpu_fpr[a-&gt;rd], t1, INT32_MIN);<br>
                 } else {<br>
                     TCGv_i64 t0 = tcg_temp_new_i64();<br>
            -        tcg_gen_not_i64(t0, cpu_fpr[a-&gt;rs2]);<br>
            -        tcg_gen_deposit_i64(cpu_fpr[a-&gt;rd], t0,
            cpu_fpr[a-&gt;rs1], 0, 31);<br>
            +        tcg_gen_not_i64(t0, t2);<br>
            +        tcg_gen_deposit_i64(cpu_fpr[a-&gt;rd], t0, t1, 0,
            31);<br>
                     tcg_temp_free_i64(t0);<br>
                 }<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -202,16 +307,26 @@ static bool
            trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)<br>
             {<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
                 if (a-&gt;rs1 == a-&gt;rs2) { /* FABS */<br>
            -        tcg_gen_andi_i64(cpu_fpr[a-&gt;rd],
            cpu_fpr[a-&gt;rs1], ~INT32_MIN);<br>
            +        tcg_gen_andi_i64(cpu_fpr[a-&gt;rd], t1,
            ~INT32_MIN);<br>
                 } else {<br>
                     TCGv_i64 t0 = tcg_temp_new_i64();<br>
            -        tcg_gen_andi_i64(t0, cpu_fpr[a-&gt;rs2],
            INT32_MIN);<br>
            -        tcg_gen_xor_i64(cpu_fpr[a-&gt;rd],
            cpu_fpr[a-&gt;rs1], t0);<br>
            +        tcg_gen_andi_i64(t0, t2, INT32_MIN);<br>
            +        tcg_gen_xor_i64(cpu_fpr[a-&gt;rd], t1, t0);<br>
                     tcg_temp_free_i64(t0);<br>
                 }<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -220,10 +335,18 @@ static bool trans_fmin_s(DisasContext
            *ctx, arg_fmin_s *a)<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            <br>
            -    gen_helper_fmin_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1],<br>
            -                      cpu_fpr[a-&gt;rs2]);<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            +    gen_helper_fmin_s(cpu_fpr[a-&gt;rd], cpu_env, t1, t2);<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -232,10 +355,18 @@ static bool trans_fmax_s(DisasContext
            *ctx, arg_fmax_s *a)<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            <br>
            -    gen_helper_fmax_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1],<br>
            -                      cpu_fpr[a-&gt;rs2]);<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            +    gen_helper_fmax_s(cpu_fpr[a-&gt;rd], cpu_env, t1, t2);<br>
                 gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
                 mark_fs_dirty(ctx);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -245,11 +376,16 @@ static bool
            trans_fcvt_w_s(DisasContext *ctx, arg_fcvt_w_s *a)<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            <br>
                 TCGv t0 = tcg_temp_new();<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    check_nanboxed(ctx, 1, t1);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fcvt_w_s(t0, cpu_env, cpu_fpr[a-&gt;rs1]);<br>
            +    gen_helper_fcvt_w_s(t0, cpu_env, t1);<br>
                 gen_set_gpr(a-&gt;rd, t0);<br>
            -    tcg_temp_free(t0);<br>
            <br>
            +    tcg_temp_free(t0);<br>
            +    tcg_temp_free_i64(t1);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -259,11 +395,16 @@ static bool
            trans_fcvt_wu_s(DisasContext *ctx, arg_fcvt_wu_s *a)<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            <br>
                 TCGv t0 = tcg_temp_new();<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    check_nanboxed(ctx, 1, t1);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fcvt_wu_s(t0, cpu_env, cpu_fpr[a-&gt;rs1]);<br>
            +    gen_helper_fcvt_wu_s(t0, cpu_env, t1);<br>
                 gen_set_gpr(a-&gt;rd, t0);<br>
            -    tcg_temp_free(t0);<br>
            <br>
            +    tcg_temp_free(t0);<br>
            +    tcg_temp_free_i64(t1);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -291,10 +432,20 @@ static bool trans_feq_s(DisasContext
            *ctx, arg_feq_s *a)<br>
             {<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            +<br>
                 TCGv t0 = tcg_temp_new();<br>
            -    gen_helper_feq_s(t0, cpu_env, cpu_fpr[a-&gt;rs1],
            cpu_fpr[a-&gt;rs2]);<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            +    gen_helper_feq_s(t0, cpu_env, t1, t2);<br>
                 gen_set_gpr(a-&gt;rd, t0);<br>
            +<br>
                 tcg_temp_free(t0);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -302,10 +453,20 @@ static bool trans_flt_s(DisasContext
            *ctx, arg_flt_s *a)<br>
             {<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            +<br>
                 TCGv t0 = tcg_temp_new();<br>
            -    gen_helper_flt_s(t0, cpu_env, cpu_fpr[a-&gt;rs1],
            cpu_fpr[a-&gt;rs2]);<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            +    gen_helper_flt_s(t0, cpu_env, t1, t2);<br>
                 gen_set_gpr(a-&gt;rd, t0);<br>
            +<br>
                 tcg_temp_free(t0);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -313,10 +474,20 @@ static bool trans_fle_s(DisasContext
            *ctx, arg_fle_s *a)<br>
             {<br>
                 REQUIRE_FPU;<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            +<br>
                 TCGv t0 = tcg_temp_new();<br>
            -    gen_helper_fle_s(t0, cpu_env, cpu_fpr[a-&gt;rs1],
            cpu_fpr[a-&gt;rs2]);<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    TCGv_i64 t2 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +    check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            +    gen_helper_fle_s(t0, cpu_env, t1, t2);<br>
                 gen_set_gpr(a-&gt;rd, t0);<br>
            +<br>
                 tcg_temp_free(t0);<br>
            +    tcg_temp_free_i64(t1);<br>
            +    tcg_temp_free_i64(t2);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -326,12 +497,15 @@ static bool
            trans_fclass_s(DisasContext *ctx, arg_fclass_s *a)<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            <br>
                 TCGv t0 = tcg_temp_new();<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    check_nanboxed(ctx, 1, t1);<br>
            <br>
            -    gen_helper_fclass_s(t0, cpu_fpr[a-&gt;rs1]);<br>
            -<br>
            +    gen_helper_fclass_s(t0, t1);<br>
                 gen_set_gpr(a-&gt;rd, t0);<br>
            -    tcg_temp_free(t0);<br>
            <br>
            +    tcg_temp_free(t0);<br>
            +    tcg_temp_free_i64(t1);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -400,10 +574,16 @@ static bool
            trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a)<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            <br>
                 TCGv t0 = tcg_temp_new();<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    check_nanboxed(ctx, 1, t1);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fcvt_l_s(t0, cpu_env, cpu_fpr[a-&gt;rs1]);<br>
            +    gen_helper_fcvt_l_s(t0, cpu_env, t1);<br>
                 gen_set_gpr(a-&gt;rd, t0);<br>
            +<br>
                 tcg_temp_free(t0);<br>
            +    tcg_temp_free_i64(t1);<br>
                 return true;<br>
             }<br>
            <br>
            @@ -413,10 +593,16 @@ static bool
            trans_fcvt_lu_s(DisasContext *ctx, arg_fcvt_lu_s *a)<br>
                 REQUIRE_EXT(ctx, RVF);<br>
            <br>
                 TCGv t0 = tcg_temp_new();<br>
            +    TCGv_i64 t1 = tcg_temp_new_i64();<br>
            +    tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +    check_nanboxed(ctx, 1, t1);<br>
            +<br>
                 gen_set_rm(ctx, a-&gt;rm);<br>
            -    gen_helper_fcvt_lu_s(t0, cpu_env, cpu_fpr[a-&gt;rs1]);<br>
            +    gen_helper_fcvt_lu_s(t0, cpu_env, t1);<br>
                 gen_set_gpr(a-&gt;rd, t0);<br>
            +<br>
                 tcg_temp_free(t0);<br>
            +    tcg_temp_free_i64(t1);<br>
                 return true;<br>
             }<br>
            <br>
            -- <br>
            2.23.0<br>
            <br>
          </blockquote>
          <div><br>
          </div>
          <div>It may be more readable to use local macro to wrap
            allocation and free of tcg temp variables. Most functions
            are two-operands, </div>
          <div>some requires one and the other needs three operands. 
            They may be like<br>
            <br>
            #define GEN_ONE_OPERAND \                                  
                                <br>
                  TCGv_i64 t1 = tcg_temp_new_i64(); \   <br>
                  tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]); \<br>
                  check_nanboxed(ctx, 1, t1);<br>
                                                                       
                                 <br>
             #define GEN_TWO_OPERAND \                                  
                                <br>
                  TCGv_i64 t1 = tcg_temp_new_i64(); \                  
                                  <br>
                  TCGv_i64 t2 = tcg_temp_new_i64(); \                  
                                  <br>
                  tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]); \      </div>
          <div>      tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]); \      <br>
                  check_nanboxed(ctx, 2, t1, t2);<br>
                                                                       
                                  <br>
              #define GEN_THREE_OPERAND \                              
                                  <br>
                  TCGv_i64 t1 = tcg_temp_new_i64(); \                  
                                  <br>
                  TCGv_i64 t2 = tcg_temp_new_i64(); \                  
                                  <br>
                  TCGv_i64 t3 = tcg_temp_new_i64(); \                  
                                  <br>
            <div>      tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]); \      </div>
            <div>      tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]); \      <br>
                    tcg_gen_mov_i64(t3, cpu_fpr[a-&gt;rs3]); \      <br>
            </div>
                  check_nanboxed(ctx, 3, t1, t2, t3);<br>
                                                                       
                                  <br>
              #define FREE_ONE_OPERAND \                                
                                 <br>
                  tcg_temp_free_i64(t1);                                
                                 <br>
                                                                       
                                  <br>
              #define FREE_TWO_OPERAND \                                
                                 <br>
                  tcg_temp_free_i64(t1); \                              
                                 <br>
                  tcg_temp_free_i64(t2);                                
                                 <br>
                                                                       
                                  <br>
              #define FREE_THREE_OPERAND \                              
                                 <br>
                  tcg_temp_free_i64(t1); \                              
                                 <br>
                  tcg_temp_free_i64(t2); \                              
                                 <br>
                  tcg_temp_free_i64(t3);<br>
            <br>
          </div>
        </div>
      </div>
    </blockquote>
    Good. <br>
    <br>
    Do you think inline function will be better? I just don't like many
    MACROS in one function. <br>
    <br>
    Zhiwei<br>
    <blockquote type="cite"
cite="mid:CAEiOBXVqe06_ODA_wou0R8QthNP-g87Apvgpx0jhLNmz9-pmPQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div>Chih-Min Chao</div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------8597DABE0A314A0E1AD3D2A4--

