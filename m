Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A4BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 06:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BEE020874
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 06:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KI/x/zuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEE020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqsjw-00053e-FV
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 02:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1jqsiw-0004Xx-OT
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 02:29:30 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:35234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1jqsit-0007bm-7r
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 02:29:30 -0400
Received: by mail-io1-xd41.google.com with SMTP id v8so27609346iox.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 23:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jPrvwtBC4msht07XU6HfXreW0edx7kKMedH4nk4y2i0=;
 b=KI/x/zuBnFAdiqoyYgOJNOcBNEzsdF4u+yywWa+81PtRO5R7OvVd5U55HploMyMwnQ
 aAw12lliTQTgqu7NvQD7QYpKWzQHaAd1d/HRMp1+s8aN7kNye1vrSm0n9d57jgZWoBPl
 zAlTedMAEbP4Qikh8S6CdmeS8F6LAF7mJn6hSIG6yrsE6pAwp9HeTClVQ60bZ0Zq1SYd
 keOIAcu+NfZ4UvO7MggnXwkV5NeGF8L1PyjftqdnKkQzZ4XynZYu1VnuaAEkmX6GuJAn
 0h6hBrRinImwZ+QeAHnBqx5AK+bhrtY5unWkaKje7icN6I85K9eGvfAJIZu1/l30wL8R
 JHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jPrvwtBC4msht07XU6HfXreW0edx7kKMedH4nk4y2i0=;
 b=MU1OeYomaSaLweIUGRJucR34hQiEqEEhW6E6EgBkNYzGLSCVmnjZNrq2OXPMFA2aGF
 2QOSeSZxacnxPWL+YVWoxzzutXUe3nGojwJLHereTXW3ycJhXfghKoBs4NMArMVUYSpE
 H4BD47BiRQ9ZHK3OWNgmiAnrxagnsFGEKxcC42uJYDei0GSQBsqFWN4v7okBdpMyECDS
 VyskatriGUGZkHcISBZfG6Lit9UXKOI4JGbPDM9sT1/GHt7yAPxo9ZJwzfeeG6BrPwNp
 7yznUQ8YAJvHVDVIY7OMlmNYTWN0zX6Q5PCkpJgR1izrShidwYJfGUmsRs1fEpkiGkVD
 0XZw==
X-Gm-Message-State: AOAM531bOKwuPtI7968gNXljyaEOUICq8gg3nO6o+Ac6TgXX3jnftf5f
 lmuBamBV8QdXHBdHZzYbjz7dUHmpaBhOYupVERkp3g==
X-Google-Smtp-Source: ABdhPJy5oi4XQxJQzOHFHe26aXtmxvML8JciZ5xW8I+q1weAkYLmxp7GHEfnJsQ0FP/rE8UCcoG+IhoVDthh0s8oGLo=
X-Received: by 2002:a05:6638:1187:: with SMTP id
 f7mr32722798jas.58.1593671365175; 
 Wed, 01 Jul 2020 23:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
 <20200626205917.4545-6-zhiwei_liu@c-sky.com>
 <CAEiOBXVqe06_ODA_wou0R8QthNP-g87Apvgpx0jhLNmz9-pmPQ@mail.gmail.com>
 <dda16a36-0814-7bc6-6ee8-dec9a75fe1e4@c-sky.com>
In-Reply-To: <dda16a36-0814-7bc6-6ee8-dec9a75fe1e4@c-sky.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Thu, 2 Jul 2020 14:29:14 +0800
Message-ID: <CAEiOBXWs5VCGGrLTB6CqJPQN7rX6NEZcdRH7nBktb_ufZ+W+jQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] target/riscv: Flush not valid NaN-boxing input to
 canonical NaN
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: multipart/alternative; boundary="0000000000009c3e6505a96f8762"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=chihmin.chao@sifive.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

--0000000000009c3e6505a96f8762
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 30, 2020 at 3:37 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:

>
>
> On 2020/6/30 15:31, Chih-Min Chao wrote:
>
> On Sat, Jun 27, 2020 at 5:09 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>> ---
>>  target/riscv/insn_trans/trans_rvd.inc.c |   7 +-
>>  target/riscv/insn_trans/trans_rvf.inc.c | 272 ++++++++++++++++++++----
>>  2 files changed, 235 insertions(+), 44 deletions(-)
>>
>> diff --git a/target/riscv/insn_trans/trans_rvd.inc.c
>> b/target/riscv/insn_trans/trans_rvd.inc.c
>> index c0f4a0c789..16947ea6da 100644
>> --- a/target/riscv/insn_trans/trans_rvd.inc.c
>> +++ b/target/riscv/insn_trans/trans_rvd.inc.c
>> @@ -241,10 +241,15 @@ static bool trans_fcvt_d_s(DisasContext *ctx,
>> arg_fcvt_d_s *a)
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVD);
>>
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    check_nanboxed(ctx, 1, t1);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fcvt_d_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
>> +    gen_helper_fcvt_d_s(cpu_fpr[a->rd], cpu_env, t1);
>>
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>>      return true;
>>  }
>>
>> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c
>> b/target/riscv/insn_trans/trans_rvf.inc.c
>> index 04bc8e5cb5..b0379b9d1f 100644
>> --- a/target/riscv/insn_trans/trans_rvf.inc.c
>> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
>> @@ -58,11 +58,23 @@ static bool trans_fmadd_s(DisasContext *ctx,
>> arg_fmadd_s *a)
>>  {
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>> +
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    TCGv_i64 t3 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]);
>> +    check_nanboxed(ctx, 3, t1, t2, t3);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fmadd_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
>> -                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
>> +    gen_helper_fmadd_s(cpu_fpr[a->rd], cpu_env, t1, t2, t3);
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>> +    tcg_temp_free_i64(t3);
>>      return true;
>>  }
>>
>> @@ -70,11 +82,23 @@ static bool trans_fmsub_s(DisasContext *ctx,
>> arg_fmsub_s *a)
>>  {
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>> +
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    TCGv_i64 t3 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]);
>> +    check_nanboxed(ctx, 3, t1, t2, t3);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fmsub_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
>> -                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
>> +    gen_helper_fmsub_s(cpu_fpr[a->rd], cpu_env, t1, t2, t3);
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>> +    tcg_temp_free_i64(t3);
>>      return true;
>>  }
>>
>> @@ -82,11 +106,23 @@ static bool trans_fnmsub_s(DisasContext *ctx,
>> arg_fnmsub_s *a)
>>  {
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>> +
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    TCGv_i64 t3 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]);
>> +    check_nanboxed(ctx, 3, t1, t2, t3);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fnmsub_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
>> -                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
>> +    gen_helper_fnmsub_s(cpu_fpr[a->rd], cpu_env, t1, t2, t3);
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>> +    tcg_temp_free_i64(t3);
>>      return true;
>>  }
>>
>> @@ -94,11 +130,23 @@ static bool trans_fnmadd_s(DisasContext *ctx,
>> arg_fnmadd_s *a)
>>  {
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>> +
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    TCGv_i64 t3 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]);
>> +    check_nanboxed(ctx, 3, t1, t2, t3);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fnmadd_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
>> -                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
>> -    mark_fs_dirty(ctx);
>> +    gen_helper_fnmadd_s(cpu_fpr[a->rd], cpu_env, t1, t2, t3);
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>> +    mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>> +    tcg_temp_free_i64(t3);
>>      return true;
>>  }
>>
>> @@ -107,11 +155,19 @@ static bool trans_fadd_s(DisasContext *ctx,
>> arg_fadd_s *a)
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>>
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    check_nanboxed(ctx, 2, t1, t2);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fadd_s(cpu_fpr[a->rd], cpu_env,
>> -                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>> +    gen_helper_fadd_s(cpu_fpr[a->rd], cpu_env, t1, t2);
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>>      return true;
>>  }
>>
>> @@ -120,11 +176,19 @@ static bool trans_fsub_s(DisasContext *ctx,
>> arg_fsub_s *a)
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>>
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    check_nanboxed(ctx, 2, t1, t2);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fsub_s(cpu_fpr[a->rd], cpu_env,
>> -                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>> +    gen_helper_fsub_s(cpu_fpr[a->rd], cpu_env, t1, t2);
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>>      return true;
>>  }
>>
>> @@ -133,11 +197,19 @@ static bool trans_fmul_s(DisasContext *ctx,
>> arg_fmul_s *a)
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>>
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    check_nanboxed(ctx, 2, t1, t2);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fmul_s(cpu_fpr[a->rd], cpu_env,
>> -                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>> +    gen_helper_fmul_s(cpu_fpr[a->rd], cpu_env, t1, t2);
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>>      return true;
>>  }
>>
>> @@ -146,11 +218,19 @@ static bool trans_fdiv_s(DisasContext *ctx,
>> arg_fdiv_s *a)
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>>
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    check_nanboxed(ctx, 2, t1, t2);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fdiv_s(cpu_fpr[a->rd], cpu_env,
>> -                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>> +    gen_helper_fdiv_s(cpu_fpr[a->rd], cpu_env, t1, t2);
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>>      return true;
>>  }
>>
>> @@ -159,10 +239,16 @@ static bool trans_fsqrt_s(DisasContext *ctx,
>> arg_fsqrt_s *a)
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>>
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    check_nanboxed(ctx, 1, t1);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fsqrt_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
>> +    gen_helper_fsqrt_s(cpu_fpr[a->rd], cpu_env, t1);
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>>      return true;
>>  }
>>
>> @@ -170,14 +256,23 @@ static bool trans_fsgnj_s(DisasContext *ctx,
>> arg_fsgnj_s *a)
>>  {
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>> +
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    check_nanboxed(ctx, 2, t1, t2);
>> +
>>      if (a->rs1 == a->rs2) { /* FMOV */
>> -        tcg_gen_mov_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1]);
>> +        tcg_gen_mov_i64(cpu_fpr[a->rd], t1);
>>      } else { /* FSGNJ */
>> -        tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rs2],
>> cpu_fpr[a->rs1],
>> -                            0, 31);
>> +        tcg_gen_deposit_i64(cpu_fpr[a->rd], t2, t1, 0, 31);
>>      }
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>>      return true;
>>  }
>>
>> @@ -185,16 +280,26 @@ static bool trans_fsgnjn_s(DisasContext *ctx,
>> arg_fsgnjn_s *a)
>>  {
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>> +
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    check_nanboxed(ctx, 2, t1, t2);
>> +
>>      if (a->rs1 == a->rs2) { /* FNEG */
>> -        tcg_gen_xori_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], INT32_MIN);
>> +        tcg_gen_xori_i64(cpu_fpr[a->rd], t1, INT32_MIN);
>>      } else {
>>          TCGv_i64 t0 = tcg_temp_new_i64();
>> -        tcg_gen_not_i64(t0, cpu_fpr[a->rs2]);
>> -        tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1], 0, 31);
>> +        tcg_gen_not_i64(t0, t2);
>> +        tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, t1, 0, 31);
>
>  t0 is not necessary but t2 could be leveraged directly.

+        tcg_gen_not_i64(t2, t2);
+        tcg_gen_deposit_i64(cpu_fpr[a->rd], t2, t1, 0, 31);

>          tcg_temp_free_i64(t0);
>>      }
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>>      return true;
>>  }
>>
>> @@ -202,16 +307,26 @@ static bool trans_fsgnjx_s(DisasContext *ctx,
>> arg_fsgnjx_s *a)
>>  {
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>> +
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    check_nanboxed(ctx, 2, t1, t2);
>> +
>>      if (a->rs1 == a->rs2) { /* FABS */
>> -        tcg_gen_andi_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], ~INT32_MIN);
>> +        tcg_gen_andi_i64(cpu_fpr[a->rd], t1, ~INT32_MIN);
>>      } else {
>>          TCGv_i64 t0 = tcg_temp_new_i64();
>> -        tcg_gen_andi_i64(t0, cpu_fpr[a->rs2], INT32_MIN);
>> -        tcg_gen_xor_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], t0);
>> +        tcg_gen_andi_i64(t0, t2, INT32_MIN);
>> +        tcg_gen_xor_i64(cpu_fpr[a->rd], t1, t0);
>>          tcg_temp_free_i64(t0);
>>
> the same as above,  t0 could be removed

>      }
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>>      return true;
>>  }
>>
>> @@ -220,10 +335,18 @@ static bool trans_fmin_s(DisasContext *ctx,
>> arg_fmin_s *a)
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>>
>> -    gen_helper_fmin_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
>> -                      cpu_fpr[a->rs2]);
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    check_nanboxed(ctx, 2, t1, t2);
>> +
>> +    gen_helper_fmin_s(cpu_fpr[a->rd], cpu_env, t1, t2);
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>>      return true;
>>  }
>>
>> @@ -232,10 +355,18 @@ static bool trans_fmax_s(DisasContext *ctx,
>> arg_fmax_s *a)
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>>
>> -    gen_helper_fmax_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
>> -                      cpu_fpr[a->rs2]);
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    check_nanboxed(ctx, 2, t1, t2);
>> +
>> +    gen_helper_fmax_s(cpu_fpr[a->rd], cpu_env, t1, t2);
>>      gen_nanbox_fpr(ctx, a->rd);
>> +
>>      mark_fs_dirty(ctx);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>>      return true;
>>  }
>>
>> @@ -245,11 +376,16 @@ static bool trans_fcvt_w_s(DisasContext *ctx,
>> arg_fcvt_w_s *a)
>>      REQUIRE_EXT(ctx, RVF);
>>
>>      TCGv t0 = tcg_temp_new();
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    check_nanboxed(ctx, 1, t1);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fcvt_w_s(t0, cpu_env, cpu_fpr[a->rs1]);
>> +    gen_helper_fcvt_w_s(t0, cpu_env, t1);
>>      gen_set_gpr(a->rd, t0);
>> -    tcg_temp_free(t0);
>>
>> +    tcg_temp_free(t0);
>> +    tcg_temp_free_i64(t1);
>>      return true;
>>  }
>>
>> @@ -259,11 +395,16 @@ static bool trans_fcvt_wu_s(DisasContext *ctx,
>> arg_fcvt_wu_s *a)
>>      REQUIRE_EXT(ctx, RVF);
>>
>>      TCGv t0 = tcg_temp_new();
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    check_nanboxed(ctx, 1, t1);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fcvt_wu_s(t0, cpu_env, cpu_fpr[a->rs1]);
>> +    gen_helper_fcvt_wu_s(t0, cpu_env, t1);
>>      gen_set_gpr(a->rd, t0);
>> -    tcg_temp_free(t0);
>>
>> +    tcg_temp_free(t0);
>> +    tcg_temp_free_i64(t1);
>>      return true;
>>  }
>>
>> @@ -291,10 +432,20 @@ static bool trans_feq_s(DisasContext *ctx,
>> arg_feq_s *a)
>>  {
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>> +
>>      TCGv t0 = tcg_temp_new();
>> -    gen_helper_feq_s(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    check_nanboxed(ctx, 2, t1, t2);
>> +
>> +    gen_helper_feq_s(t0, cpu_env, t1, t2);
>>      gen_set_gpr(a->rd, t0);
>> +
>>      tcg_temp_free(t0);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>>      return true;
>>  }
>>
>> @@ -302,10 +453,20 @@ static bool trans_flt_s(DisasContext *ctx,
>> arg_flt_s *a)
>>  {
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>> +
>>      TCGv t0 = tcg_temp_new();
>> -    gen_helper_flt_s(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    check_nanboxed(ctx, 2, t1, t2);
>> +
>> +    gen_helper_flt_s(t0, cpu_env, t1, t2);
>>      gen_set_gpr(a->rd, t0);
>> +
>>      tcg_temp_free(t0);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>>      return true;
>>  }
>>
>> @@ -313,10 +474,20 @@ static bool trans_fle_s(DisasContext *ctx,
>> arg_fle_s *a)
>>  {
>>      REQUIRE_FPU;
>>      REQUIRE_EXT(ctx, RVF);
>> +
>>      TCGv t0 = tcg_temp_new();
>> -    gen_helper_fle_s(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]);
>> +    check_nanboxed(ctx, 2, t1, t2);
>> +
>> +    gen_helper_fle_s(t0, cpu_env, t1, t2);
>>      gen_set_gpr(a->rd, t0);
>> +
>>      tcg_temp_free(t0);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>>      return true;
>>  }
>>
>> @@ -326,12 +497,15 @@ static bool trans_fclass_s(DisasContext *ctx,
>> arg_fclass_s *a)
>>      REQUIRE_EXT(ctx, RVF);
>>
>>      TCGv t0 = tcg_temp_new();
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    check_nanboxed(ctx, 1, t1);
>>
>> -    gen_helper_fclass_s(t0, cpu_fpr[a->rs1]);
>> -
>> +    gen_helper_fclass_s(t0, t1);
>>      gen_set_gpr(a->rd, t0);
>> -    tcg_temp_free(t0);
>>
>> +    tcg_temp_free(t0);
>> +    tcg_temp_free_i64(t1);
>>      return true;
>>  }
>>
>> @@ -400,10 +574,16 @@ static bool trans_fcvt_l_s(DisasContext *ctx,
>> arg_fcvt_l_s *a)
>>      REQUIRE_EXT(ctx, RVF);
>>
>>      TCGv t0 = tcg_temp_new();
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    check_nanboxed(ctx, 1, t1);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fcvt_l_s(t0, cpu_env, cpu_fpr[a->rs1]);
>> +    gen_helper_fcvt_l_s(t0, cpu_env, t1);
>>      gen_set_gpr(a->rd, t0);
>> +
>>      tcg_temp_free(t0);
>> +    tcg_temp_free_i64(t1);
>>      return true;
>>  }
>>
>> @@ -413,10 +593,16 @@ static bool trans_fcvt_lu_s(DisasContext *ctx,
>> arg_fcvt_lu_s *a)
>>      REQUIRE_EXT(ctx, RVF);
>>
>>      TCGv t0 = tcg_temp_new();
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +    check_nanboxed(ctx, 1, t1);
>> +
>>      gen_set_rm(ctx, a->rm);
>> -    gen_helper_fcvt_lu_s(t0, cpu_env, cpu_fpr[a->rs1]);
>> +    gen_helper_fcvt_lu_s(t0, cpu_env, t1);
>>      gen_set_gpr(a->rd, t0);
>> +
>>      tcg_temp_free(t0);
>> +    tcg_temp_free_i64(t1);
>>      return true;
>>  }
>>
>> --
>> 2.23.0
>>
>>
> It may be more readable to use local macro to wrap allocation and free of
> tcg temp variables. Most functions are two-operands,
> some requires one and the other needs three operands.  They may be like
>
> #define GEN_ONE_OPERAND \
>
>       TCGv_i64 t1 = tcg_temp_new_i64(); \
>       tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]); \
>       check_nanboxed(ctx, 1, t1);
>
>
>  #define GEN_TWO_OPERAND \
>
>       TCGv_i64 t1 = tcg_temp_new_i64(); \
>
>       TCGv_i64 t2 = tcg_temp_new_i64(); \
>
>       tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]); \
>       tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]); \
>       check_nanboxed(ctx, 2, t1, t2);
>
>
>   #define GEN_THREE_OPERAND \
>
>       TCGv_i64 t1 = tcg_temp_new_i64(); \
>
>       TCGv_i64 t2 = tcg_temp_new_i64(); \
>
>       TCGv_i64 t3 = tcg_temp_new_i64(); \
>
>       tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]); \
>       tcg_gen_mov_i64(t2, cpu_fpr[a->rs2]); \
>       tcg_gen_mov_i64(t3, cpu_fpr[a->rs3]); \
>       check_nanboxed(ctx, 3, t1, t2, t3);
>
>
>   #define FREE_ONE_OPERAND \
>
>       tcg_temp_free_i64(t1);
>
>
>
>   #define FREE_TWO_OPERAND \
>
>       tcg_temp_free_i64(t1); \
>
>       tcg_temp_free_i64(t2);
>
>
>
>   #define FREE_THREE_OPERAND \
>
>       tcg_temp_free_i64(t1); \
>
>       tcg_temp_free_i64(t2); \
>
>       tcg_temp_free_i64(t3);
>
> Good.
>
> Do you think inline function will be better? I just don't like many MACROS
> in one function.
>
> Zhiwei
>
> Chih-Min Chao
>
> Either macro or inline is ok to me.  Just want an simple wrapping of
duplicated tcg new and free.

Chih-Min Chao

--0000000000009c3e6505a96f8762
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><br></div></div>=
</div></div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Jun 30, 2020 at 3:37 PM LIU Zhiwei &lt;<a href=3D"mailto:zhiwei_l=
iu@c-sky.com">zhiwei_liu@c-sky.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    <br>
    <br>
    <div>On 2020/6/30 15:31, Chih-Min Chao
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div dir=3D"ltr">On Sat, Jun 27, 2020 at 5:09 AM LIU Zhiwei &lt;<a =
href=3D"mailto:zhiwei_liu@c-sky.com" target=3D"_blank">zhiwei_liu@c-sky.com=
</a>&gt; wrote:<br>
        </div>
        <div class=3D"gmail_quote">
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: =
LIU Zhiwei
            &lt;<a href=3D"mailto:zhiwei_liu@c-sky.com" target=3D"_blank">z=
hiwei_liu@c-sky.com</a>&gt;<br>
            ---<br>
            =C2=A0target/riscv/insn_trans/trans_rvd.inc.c |=C2=A0 =C2=A07 +=
-<br>
            =C2=A0target/riscv/insn_trans/trans_rvf.inc.c | 272
            ++++++++++++++++++++----<br>
            =C2=A02 files changed, 235 insertions(+), 44 deletions(-)<br>
            <br>
            diff --git a/target/riscv/insn_trans/trans_rvd.inc.c
            b/target/riscv/insn_trans/trans_rvd.inc.c<br>
            index c0f4a0c789..16947ea6da 100644<br>
            --- a/target/riscv/insn_trans/trans_rvd.inc.c<br>
            +++ b/target/riscv/insn_trans/trans_rvd.inc.c<br>
            @@ -241,10 +241,15 @@ static bool
            trans_fcvt_d_s(DisasContext *ctx, arg_fcvt_d_s *a)<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVD);<br>
            <br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 1, t1);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fcvt_d_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 gen_helper_fcvt_d_s(cpu_fpr[a-&gt;rd], cpu_env, =
t1);<br>
            <br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            diff --git a/target/riscv/insn_trans/trans_rvf.inc.c
            b/target/riscv/insn_trans/trans_rvf.inc.c<br>
            index 04bc8e5cb5..b0379b9d1f 100644<br>
            --- a/target/riscv/insn_trans/trans_rvf.inc.c<br>
            +++ b/target/riscv/insn_trans/trans_rvf.inc.c<br>
            @@ -58,11 +58,23 @@ static bool trans_fmadd_s(DisasContext
            *ctx, arg_fmadd_s *a)<br>
            =C2=A0{<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t3 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t3, cpu_fpr[a-&gt;rs3]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 3, t1, t2, t3);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fmadd_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1],<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0cpu_fpr[a-&gt;rs2],
            cpu_fpr[a-&gt;rs3]);<br>
            +=C2=A0 =C2=A0 gen_helper_fmadd_s(cpu_fpr[a-&gt;rd], cpu_env, t=
1, t2,
            t3);<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t3);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -70,11 +82,23 @@ static bool trans_fmsub_s(DisasContext
            *ctx, arg_fmsub_s *a)<br>
            =C2=A0{<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t3 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t3, cpu_fpr[a-&gt;rs3]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 3, t1, t2, t3);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fmsub_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1],<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0cpu_fpr[a-&gt;rs2],
            cpu_fpr[a-&gt;rs3]);<br>
            +=C2=A0 =C2=A0 gen_helper_fmsub_s(cpu_fpr[a-&gt;rd], cpu_env, t=
1, t2,
            t3);<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t3);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -82,11 +106,23 @@ static bool trans_fnmsub_s(DisasContext
            *ctx, arg_fnmsub_s *a)<br>
            =C2=A0{<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t3 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t3, cpu_fpr[a-&gt;rs3]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 3, t1, t2, t3);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fnmsub_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1],<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 cpu_fpr[a-&gt;rs2],
            cpu_fpr[a-&gt;rs3]);<br>
            +=C2=A0 =C2=A0 gen_helper_fnmsub_s(cpu_fpr[a-&gt;rd], cpu_env, =
t1, t2,
            t3);<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t3);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -94,11 +130,23 @@ static bool trans_fnmadd_s(DisasContext
            *ctx, arg_fnmadd_s *a)<br>
            =C2=A0{<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t3 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t3, cpu_fpr[a-&gt;rs3]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 3, t1, t2, t3);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fnmadd_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1],<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 cpu_fpr[a-&gt;rs2],
            cpu_fpr[a-&gt;rs3]);<br>
            -=C2=A0 =C2=A0 mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 gen_helper_fnmadd_s(cpu_fpr[a-&gt;rd], cpu_env, =
t1, t2,
            t3);<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            +=C2=A0 =C2=A0 mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t3);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -107,11 +155,19 @@ static bool trans_fadd_s(DisasContext
            *ctx, arg_fadd_s *a)<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            <br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fadd_s(cpu_fpr[a-&gt;rd], cpu_env,<br=
>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 cpu_fpr[a-&gt;rs1],
            cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 gen_helper_fadd_s(cpu_fpr[a-&gt;rd], cpu_env, t1=
, t2);<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -120,11 +176,19 @@ static bool trans_fsub_s(DisasContext
            *ctx, arg_fsub_s *a)<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            <br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fsub_s(cpu_fpr[a-&gt;rd], cpu_env,<br=
>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 cpu_fpr[a-&gt;rs1],
            cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 gen_helper_fsub_s(cpu_fpr[a-&gt;rd], cpu_env, t1=
, t2);<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -133,11 +197,19 @@ static bool trans_fmul_s(DisasContext
            *ctx, arg_fmul_s *a)<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            <br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fmul_s(cpu_fpr[a-&gt;rd], cpu_env,<br=
>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 cpu_fpr[a-&gt;rs1],
            cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 gen_helper_fmul_s(cpu_fpr[a-&gt;rd], cpu_env, t1=
, t2);<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -146,11 +218,19 @@ static bool trans_fdiv_s(DisasContext
            *ctx, arg_fdiv_s *a)<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            <br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fdiv_s(cpu_fpr[a-&gt;rd], cpu_env,<br=
>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 cpu_fpr[a-&gt;rs1],
            cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 gen_helper_fdiv_s(cpu_fpr[a-&gt;rd], cpu_env, t1=
, t2);<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -159,10 +239,16 @@ static bool trans_fsqrt_s(DisasContext
            *ctx, arg_fsqrt_s *a)<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            <br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 1, t1);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fsqrt_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 gen_helper_fsqrt_s(cpu_fpr[a-&gt;rd], cpu_env, t=
1);<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -170,14 +256,23 @@ static bool trans_fsgnj_s(DisasContext
            *ctx, arg_fsgnj_s *a)<br>
            =C2=A0{<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0if (a-&gt;rs1 =3D=3D a-&gt;rs2) { /* FMOV *=
/<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(cpu_fpr[a-&gt;rd],
            cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(cpu_fpr[a-&gt;rd],=
 t1);<br>
            =C2=A0 =C2=A0 =C2=A0} else { /* FSGNJ */<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_deposit_i64(cpu_fpr[a-&gt;=
rd],
            cpu_fpr[a-&gt;rs2], cpu_fpr[a-&gt;rs1],<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 31);<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_deposit_i64(cpu_fpr[a-&gt;=
rd], t2, t1, 0,
            31);<br>
            =C2=A0 =C2=A0 =C2=A0}<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -185,16 +280,26 @@ static bool
            trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)<br>
            =C2=A0{<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0if (a-&gt;rs1 =3D=3D a-&gt;rs2) { /* FNEG *=
/<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_xori_i64(cpu_fpr[a-&gt;rd]=
,
            cpu_fpr[a-&gt;rs1], INT32_MIN);<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_xori_i64(cpu_fpr[a-&gt;rd]=
, t1, INT32_MIN);<br>
            =C2=A0 =C2=A0 =C2=A0} else {<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i64 t0 =3D tcg_temp_new_=
i64();<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_not_i64(t0, cpu_fpr[a-&gt;=
rs2]);<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_deposit_i64(cpu_fpr[a-&gt;=
rd], t0,
            cpu_fpr[a-&gt;rs1], 0, 31);<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_not_i64(t0, t2);<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_deposit_i64(cpu_fpr[a-&gt;=
rd], t0, t1, 0,
            31);</blockquote></div></div></blockquote></div></blockquote><d=
iv>=C2=A0t0 is not necessary but t2 could be leveraged directly.=C2=A0</div=
><div>=C2=A0<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_not_i64(t2, t2);<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_deposit_i64(cpu_fpr[a-&gt;=
rd], t2, t1, 0,
            31);<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><div><blockquote type=3D"cite"><div dir=3D"ltr"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_temp_free_i64(t0);<br>
            =C2=A0 =C2=A0 =C2=A0}<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -202,16 +307,26 @@ static bool
            trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)<br>
            =C2=A0{<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0if (a-&gt;rs1 =3D=3D a-&gt;rs2) { /* FABS *=
/<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(cpu_fpr[a-&gt;rd]=
,
            cpu_fpr[a-&gt;rs1], ~INT32_MIN);<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(cpu_fpr[a-&gt;rd]=
, t1,
            ~INT32_MIN);<br>
            =C2=A0 =C2=A0 =C2=A0} else {<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i64 t0 =3D tcg_temp_new_=
i64();<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(t0, cpu_fpr[a-&gt=
;rs2],
            INT32_MIN);<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_xor_i64(cpu_fpr[a-&gt;rd],
            cpu_fpr[a-&gt;rs1], t0);<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(t0, t2, INT32_MIN=
);<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_xor_i64(cpu_fpr[a-&gt;rd],=
 t1, t0);<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_temp_free_i64(t0);<br></b=
lockquote></div></div></blockquote></div></blockquote><div>the same as abov=
e,=C2=A0 t0 could be removed=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div><blockquote type=3D"cite"><div dir=3D"ltr"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            =C2=A0 =C2=A0 =C2=A0}<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -220,10 +335,18 @@ static bool trans_fmin_s(DisasContext
            *ctx, arg_fmin_s *a)<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            <br>
            -=C2=A0 =C2=A0 gen_helper_fmin_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1],<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            +=C2=A0 =C2=A0 gen_helper_fmin_s(cpu_fpr[a-&gt;rd], cpu_env, t1=
, t2);<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -232,10 +355,18 @@ static bool trans_fmax_s(DisasContext
            *ctx, arg_fmax_s *a)<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            <br>
            -=C2=A0 =C2=A0 gen_helper_fmax_s(cpu_fpr[a-&gt;rd], cpu_env,
            cpu_fpr[a-&gt;rs1],<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            +=C2=A0 =C2=A0 gen_helper_fmax_s(cpu_fpr[a-&gt;rd], cpu_env, t1=
, t2);<br>
            =C2=A0 =C2=A0 =C2=A0gen_nanbox_fpr(ctx, a-&gt;rd);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -245,11 +376,16 @@ static bool
            trans_fcvt_w_s(DisasContext *ctx, arg_fcvt_w_s *a)<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            <br>
            =C2=A0 =C2=A0 =C2=A0TCGv t0 =3D tcg_temp_new();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 1, t1);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fcvt_w_s(t0, cpu_env, cpu_fpr[a-&gt;r=
s1]);<br>
            +=C2=A0 =C2=A0 gen_helper_fcvt_w_s(t0, cpu_env, t1);<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_gpr(a-&gt;rd, t0);<br>
            -=C2=A0 =C2=A0 tcg_temp_free(t0);<br>
            <br>
            +=C2=A0 =C2=A0 tcg_temp_free(t0);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -259,11 +395,16 @@ static bool
            trans_fcvt_wu_s(DisasContext *ctx, arg_fcvt_wu_s *a)<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            <br>
            =C2=A0 =C2=A0 =C2=A0TCGv t0 =3D tcg_temp_new();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 1, t1);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fcvt_wu_s(t0, cpu_env, cpu_fpr[a-&gt;=
rs1]);<br>
            +=C2=A0 =C2=A0 gen_helper_fcvt_wu_s(t0, cpu_env, t1);<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_gpr(a-&gt;rd, t0);<br>
            -=C2=A0 =C2=A0 tcg_temp_free(t0);<br>
            <br>
            +=C2=A0 =C2=A0 tcg_temp_free(t0);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -291,10 +432,20 @@ static bool trans_feq_s(DisasContext
            *ctx, arg_feq_s *a)<br>
            =C2=A0{<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0TCGv t0 =3D tcg_temp_new();<br>
            -=C2=A0 =C2=A0 gen_helper_feq_s(t0, cpu_env, cpu_fpr[a-&gt;rs1]=
,
            cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            +=C2=A0 =C2=A0 gen_helper_feq_s(t0, cpu_env, t1, t2);<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_gpr(a-&gt;rd, t0);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0tcg_temp_free(t0);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -302,10 +453,20 @@ static bool trans_flt_s(DisasContext
            *ctx, arg_flt_s *a)<br>
            =C2=A0{<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0TCGv t0 =3D tcg_temp_new();<br>
            -=C2=A0 =C2=A0 gen_helper_flt_s(t0, cpu_env, cpu_fpr[a-&gt;rs1]=
,
            cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            +=C2=A0 =C2=A0 gen_helper_flt_s(t0, cpu_env, t1, t2);<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_gpr(a-&gt;rd, t0);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0tcg_temp_free(t0);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -313,10 +474,20 @@ static bool trans_fle_s(DisasContext
            *ctx, arg_fle_s *a)<br>
            =C2=A0{<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_FPU;<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0TCGv t0 =3D tcg_temp_new();<br>
            -=C2=A0 =C2=A0 gen_helper_fle_s(t0, cpu_env, cpu_fpr[a-&gt;rs1]=
,
            cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 2, t1, t2);<br>
            +<br>
            +=C2=A0 =C2=A0 gen_helper_fle_s(t0, cpu_env, t1, t2);<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_gpr(a-&gt;rd, t0);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0tcg_temp_free(t0);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -326,12 +497,15 @@ static bool
            trans_fclass_s(DisasContext *ctx, arg_fclass_s *a)<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            <br>
            =C2=A0 =C2=A0 =C2=A0TCGv t0 =3D tcg_temp_new();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 1, t1);<br>
            <br>
            -=C2=A0 =C2=A0 gen_helper_fclass_s(t0, cpu_fpr[a-&gt;rs1]);<br>
            -<br>
            +=C2=A0 =C2=A0 gen_helper_fclass_s(t0, t1);<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_gpr(a-&gt;rd, t0);<br>
            -=C2=A0 =C2=A0 tcg_temp_free(t0);<br>
            <br>
            +=C2=A0 =C2=A0 tcg_temp_free(t0);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -400,10 +574,16 @@ static bool
            trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a)<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            <br>
            =C2=A0 =C2=A0 =C2=A0TCGv t0 =3D tcg_temp_new();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 1, t1);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fcvt_l_s(t0, cpu_env, cpu_fpr[a-&gt;r=
s1]);<br>
            +=C2=A0 =C2=A0 gen_helper_fcvt_l_s(t0, cpu_env, t1);<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_gpr(a-&gt;rd, t0);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0tcg_temp_free(t0);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            @@ -413,10 +593,16 @@ static bool
            trans_fcvt_lu_s(DisasContext *ctx, arg_fcvt_lu_s *a)<br>
            =C2=A0 =C2=A0 =C2=A0REQUIRE_EXT(ctx, RVF);<br>
            <br>
            =C2=A0 =C2=A0 =C2=A0TCGv t0 =3D tcg_temp_new();<br>
            +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();<br>
            +=C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]);<br>
            +=C2=A0 =C2=A0 check_nanboxed(ctx, 1, t1);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_rm(ctx, a-&gt;rm);<br>
            -=C2=A0 =C2=A0 gen_helper_fcvt_lu_s(t0, cpu_env, cpu_fpr[a-&gt;=
rs1]);<br>
            +=C2=A0 =C2=A0 gen_helper_fcvt_lu_s(t0, cpu_env, t1);<br>
            =C2=A0 =C2=A0 =C2=A0gen_set_gpr(a-&gt;rd, t0);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0tcg_temp_free(t0);<br>
            +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);<br>
            =C2=A0 =C2=A0 =C2=A0return true;<br>
            =C2=A0}<br>
            <br>
            -- <br>
            2.23.0<br>
            <br>
          </blockquote>
          <div><br>
          </div>
          <div>It may be more readable to use local macro to wrap
            allocation and free of tcg temp variables. Most functions
            are two-operands,=C2=A0</div>
          <div>some requires one and the other needs three operands.=C2=A0
            They may be like<br>
            <br>
            #define GEN_ONE_OPERAND \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <br>
            =C2=A0 =C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64(); \=C2=
=A0 =C2=A0<br>
            =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]); \=
<br>
            =C2=A0 =C2=A0 =C2=A0=C2=A0check_nanboxed(ctx, 1, t1);<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
            =C2=A0#define GEN_TWO_OPERAND \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <br>
            =C2=A0 =C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64(); \ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <br>
            =C2=A0 =C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64(); \ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <br>
            =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1]); \=
=C2=A0 =C2=A0 =C2=A0=C2=A0</div>
          <div>=C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2])=
; \=C2=A0 =C2=A0 =C2=A0=C2=A0<br>
            =C2=A0 =C2=A0 =C2=A0=C2=A0check_nanboxed(ctx, 2, t1, t2);<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0<br>
            =C2=A0 #define GEN_THREE_OPERAND \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <br>
            =C2=A0 =C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64(); \ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <br>
            =C2=A0 =C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64(); \ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <br>
            =C2=A0 =C2=A0 =C2=A0 TCGv_i64 t3 =3D tcg_temp_new_i64(); \ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <br>
            <div>=C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(t1, cpu_fpr[a-&gt;rs1=
]); \=C2=A0 =C2=A0 =C2=A0=C2=A0</div>
            <div>=C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(t2, cpu_fpr[a-&gt;rs2=
]); \=C2=A0 =C2=A0 =C2=A0=C2=A0<br>
              =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(t3, cpu_fpr[a-&gt;rs3]);=
 \=C2=A0 =C2=A0 =C2=A0=C2=A0<br>
            </div>
            =C2=A0 =C2=A0 =C2=A0 check_nanboxed(ctx, 3, t1, t2, t3);<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0<br>
            =C2=A0 #define FREE_ONE_OPERAND \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
            =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i64(t1); =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <br>
            =C2=A0 #define FREE_TWO_OPERAND \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
            =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i64(t1); \ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
            =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i64(t2); =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <br>
            =C2=A0 #define FREE_THREE_OPERAND \ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
            =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i64(t1); \ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
            =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i64(t2); \ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
            =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i64(t3);<br>
            <br>
          </div>
        </div>
      </div>
    </blockquote>
    Good. <br>
    <br>
    Do you think inline function will be better? I just don&#39;t like many
    MACROS in one function. <br>
    <br>
    Zhiwei<br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div>Chih-Min Chao</div></div></div></blockquote></div></blockquo=
te><div>Either macro or inline is ok to me.=C2=A0 Just want an simple wrapp=
ing of duplicated tcg new and free.</div><div><br></div><div>Chih-Min Chao=
=C2=A0</div></div></div>

--0000000000009c3e6505a96f8762--

