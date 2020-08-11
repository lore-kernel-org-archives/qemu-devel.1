Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CBDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EE9204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ao6M7Vtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EE9204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Q9k-0005uQ-EK
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 05:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k5Q8U-00045B-Li
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:59:58 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:45369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k5Q8R-0005U4-H4
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:59:58 -0400
Received: by mail-pf1-x429.google.com with SMTP id f193so7246399pfa.12
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Zu7rqHxSKkcifOLj33WtmEIrqrJqXtmC8yRbMszb1Wc=;
 b=Ao6M7VtkqHz+6A33OHTtfe1NuBXN0j0vrG9rAFMHT2IxvGa7ifPMuMjBca3hSYNQC0
 f906rpHZtqSbFirRb3G8xbn9WM72Ny2wPP84FGr6bTcFs186lDY3v8EcKB23JZhRpX+N
 ZEpiRK1Ul1UeYNYMXWB4ww7vVjwEF9jHAJA5IycGODwTnSmCB78WLQlWASCO8eA4i4jV
 /asl3PUGS5iKH/aQ7rwrq4yCuBFncwHq8n+PALNsmxDjBEbXhap4Um48w+s0YwiDOnlm
 QAFe+9/I/K4pCQ4hUfNptaWF/80otY6xoBM2LyCMJdlFCNC7WbZZS+IEYlW0DY0P6Nys
 ww+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Zu7rqHxSKkcifOLj33WtmEIrqrJqXtmC8yRbMszb1Wc=;
 b=T4Cm6U6U0XiOnsxxOGGY5Q4CZHgNhuVK4W5Yky23XWWKsVoOZLQD4ipMgOPbYJJuMK
 6XIjcYv5akB63IbQAOhaOnYm8U6VTIyfthT8YK/LgWG3INlEM7tWBSYOpHpPdvx55Sei
 pRWS2Zy3f55gNcQiEdE6ga70nv0PqpDGHV61QrdAmHfXDoKJ85UZ17XlQ0NnS8W6Meil
 Xyj0LUWVAo+iNAsHEs+jkrC368K9C4jrZLQgC579kZLEyl4f1T8xkiJkdLLjoMsllAFh
 U/PptxOWPoEtR+19wT+gFA2NZVVygakUJwdaAdkUZMg2Jok6Rm3mXTq+JyKaqdsjiq89
 SwCA==
X-Gm-Message-State: AOAM533TnHKL8AuiT4pPc0ao6XjlQvp8nK9ayQLFtWOrpLIWecFhq7u7
 wAy+JC2dyvvXNcQsoeig3MSw10X4IUoHkw==
X-Google-Smtp-Source: ABdhPJwtBLcEkwCpLQXDW/L6TZoDzgU58Qwjk7pV2kCeG0LJgv5Z5Yo0ZOC8QEfxKEhjBtUyx5Mtsw==
X-Received: by 2002:a63:1342:: with SMTP id 2mr28552pgt.214.1597136393608;
 Tue, 11 Aug 2020 01:59:53 -0700 (PDT)
Received: from gamma11.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id w10sm1282499pjq.46.2020.08.11.01.59.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Aug 2020 01:59:53 -0700 (PDT)
From: Chih-Min Chao <chihmin.chao@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 2/3] target/riscv: Implement zfh extension
Date: Tue, 11 Aug 2020 01:59:25 -0700
Message-Id: <1597136381-17296-3-git-send-email-chihmin.chao@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597136381-17296-1-git-send-email-chihmin.chao@sifive.com>
References: <1597136381-17296-1-git-send-email-chihmin.chao@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=chihmin.chao@sifive.com; helo=mail-pf1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chih-Min Chao <chihmin.chao@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Kito Cheng <kito.cheng@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kito Cheng <kito.cheng@sifive.com>

All of instructions listed in spec has been implemented. The spec is still
under discussion and not included master branch.

ref:
  https://github.com/riscv/riscv-isa-manual/tree/zfh

Signed-off-by: Kito Cheng <kito.cheng@sifive.com>
Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
---
 target/riscv/cpu.h                        |   1 +
 target/riscv/fpu_helper.c                 | 180 ++++++++++
 target/riscv/helper.h                     |  34 ++
 target/riscv/insn32-64.decode             |   6 +
 target/riscv/insn32.decode                |  32 ++
 target/riscv/insn_trans/trans_rvzfh.inc.c | 531 ++++++++++++++++++++++++++++++
 target/riscv/translate.c                  |   1 +
 7 files changed, 785 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzfh.inc.c

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a804a5d..6a077c1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -65,6 +65,7 @@
 #define RVS RV('S')
 #define RVU RV('U')
 #define RVH RV('H')
+#define RVZfh RV('K')
 
 /* S extension denotes that Supervisor mode exists, however it is possible
    to have a core that support S mode but does not have an MMU and there
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 2c52ff1..5b1b210 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -81,6 +81,15 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
     set_float_rounding_mode(softrm, &env->fp_status);
 }
 
+static uint64_t do_fmadd_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2,
+                           uint64_t rs3, int flags)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    float16 frs2 = check_nanbox_h(rs2);
+    float16 frs3 = check_nanbox_h(rs3);
+    return nanbox_h(float16_muladd(frs1, frs2, frs3, flags, &env->fp_status));
+}
+
 static uint64_t do_fmadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2,
                            uint64_t rs3, int flags)
 {
@@ -102,6 +111,12 @@ uint64_t helper_fmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
     return float64_muladd(frs1, frs2, frs3, 0, &env->fp_status);
 }
 
+uint64_t helper_fmadd_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                        uint64_t frs3)
+{
+    return do_fmadd_h(env, frs1, frs2, frs3, 0);
+}
+
 uint64_t helper_fmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                         uint64_t frs3)
 {
@@ -115,6 +130,12 @@ uint64_t helper_fmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                           &env->fp_status);
 }
 
+uint64_t helper_fmsub_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                        uint64_t frs3)
+{
+    return do_fmadd_h(env, frs1, frs2, frs3, float_muladd_negate_c);
+}
+
 uint64_t helper_fnmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                          uint64_t frs3)
 {
@@ -128,6 +149,12 @@ uint64_t helper_fnmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                           &env->fp_status);
 }
 
+uint64_t helper_fnmsub_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                         uint64_t frs3)
+{
+    return do_fmadd_h(env, frs1, frs2, frs3, float_muladd_negate_product);
+}
+
 uint64_t helper_fnmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                          uint64_t frs3)
 {
@@ -142,6 +169,13 @@ uint64_t helper_fnmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                           float_muladd_negate_product, &env->fp_status);
 }
 
+uint64_t helper_fnmadd_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                         uint64_t frs3)
+{
+    return do_fmadd_h(env, frs1, frs2, frs3,
+                      float_muladd_negate_c | float_muladd_negate_product);
+}
+
 uint64_t helper_fadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(rs1);
@@ -374,3 +408,149 @@ target_ulong helper_fclass_d(uint64_t frs1)
 {
     return fclass_d(frs1);
 }
+
+uint64_t helper_fadd_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    float16 frs2 = check_nanbox_h(rs2);
+    return nanbox_h(float16_add(frs1, frs2, &env->fp_status));
+}
+
+uint64_t helper_fsub_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    float16 frs2 = check_nanbox_h(rs2);
+    return nanbox_h(float16_sub(frs1, frs2, &env->fp_status));
+}
+
+uint64_t helper_fmul_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    float16 frs2 = check_nanbox_h(rs2);
+    return nanbox_h(float16_mul(frs1, frs2, &env->fp_status));
+}
+
+uint64_t helper_fdiv_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    float16 frs2 = check_nanbox_h(rs2);
+    return nanbox_h(float16_div(frs1, frs2, &env->fp_status));
+}
+
+uint64_t helper_fmin_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    float16 frs2 = check_nanbox_h(rs2);
+    return nanbox_h(float16_minnum_noprop(frs1, frs2, &env->fp_status));
+}
+
+uint64_t helper_fmax_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    float16 frs2 = check_nanbox_h(rs2);
+    return nanbox_h(float16_maxnum_noprop(frs1, frs2, &env->fp_status));
+}
+
+uint64_t helper_fsqrt_h(CPURISCVState *env, uint64_t rs1)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    return nanbox_h(float16_sqrt(frs1, &env->fp_status));
+}
+
+target_ulong helper_fle_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    float16 frs2 = check_nanbox_h(rs2);
+    return float16_le(frs1, frs2, &env->fp_status);
+}
+
+target_ulong helper_flt_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    float16 frs2 = check_nanbox_h(rs2);
+    return float16_lt(frs1, frs2, &env->fp_status);
+}
+
+target_ulong helper_feq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    float16 frs2 = check_nanbox_h(rs2);
+    return float16_eq_quiet(frs1, frs2, &env->fp_status);
+}
+
+target_ulong helper_fclass_h(uint64_t rs1)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    return fclass_h(frs1);
+}
+
+target_ulong helper_fcvt_w_h(CPURISCVState *env, uint64_t rs1)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    return float16_to_int32(frs1, &env->fp_status);
+}
+
+target_ulong helper_fcvt_wu_h(CPURISCVState *env, uint64_t rs1)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    return (int32_t)float16_to_uint32(frs1, &env->fp_status);
+}
+
+#if defined(TARGET_RISCV64)
+uint64_t helper_fcvt_l_h(CPURISCVState *env, uint64_t rs1)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    return float16_to_int64(frs1, &env->fp_status);
+}
+
+uint64_t helper_fcvt_lu_h(CPURISCVState *env, uint64_t rs1)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    return float16_to_uint64(frs1, &env->fp_status);
+}
+#endif
+
+uint64_t helper_fcvt_h_w(CPURISCVState *env, target_ulong rs1)
+{
+    return nanbox_h(int32_to_float16((int32_t)rs1, &env->fp_status));
+}
+
+uint64_t helper_fcvt_h_wu(CPURISCVState *env, target_ulong rs1)
+{
+    return nanbox_h(uint32_to_float16((uint32_t)rs1, &env->fp_status));
+}
+
+#if defined(TARGET_RISCV64)
+uint64_t helper_fcvt_h_l(CPURISCVState *env, uint64_t rs1)
+{
+    return nanbox_h(int64_to_float16(rs1, &env->fp_status));
+}
+
+uint64_t helper_fcvt_h_lu(CPURISCVState *env, uint64_t rs1)
+{
+    return nanbox_h(uint64_to_float16(rs1, &env->fp_status));
+}
+#endif
+
+uint64_t helper_fcvt_h_s(CPURISCVState *env, uint64_t rs1)
+{
+    float32 frs1 = check_nanbox_s(rs1);
+    return nanbox_h(float32_to_float16(frs1, true, &env->fp_status));
+}
+
+uint64_t helper_fcvt_s_h(CPURISCVState *env, uint64_t rs1)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    return nanbox_s(float16_to_float32(frs1, true, &env->fp_status));
+}
+
+uint64_t helper_fcvt_h_d(CPURISCVState *env, uint64_t rs1)
+{
+    return nanbox_h(float64_to_float16(rs1, true, &env->fp_status));
+}
+
+uint64_t helper_fcvt_d_h(CPURISCVState *env, uint64_t rs1)
+{
+    float16 frs1 = check_nanbox_h(rs1);
+    return float16_to_float64(frs1, true, &env->fp_status);
+}
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index acc2982..66c95dc 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -7,12 +7,16 @@ DEF_HELPER_FLAGS_2(set_rounding_mode, TCG_CALL_NO_WG, void, env, i32)
 /* Floating Point - fused */
 DEF_HELPER_FLAGS_4(fmadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(fmadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(fmadd_h, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(fmsub_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(fmsub_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(fmsub_h, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(fnmsub_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(fnmsub_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(fnmsub_h, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(fnmadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(fnmadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(fnmadd_h, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 
 /* Floating Point - Single Precision */
 DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
@@ -66,6 +70,36 @@ DEF_HELPER_FLAGS_2(fcvt_d_lu, TCG_CALL_NO_RWG, i64, env, tl)
 #endif
 DEF_HELPER_FLAGS_1(fclass_d, TCG_CALL_NO_RWG_SE, tl, i64)
 
+/* Floating Point - Half Precision */
+DEF_HELPER_FLAGS_3(fadd_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fsub_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fmul_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fdiv_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fmin_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fmax_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_2(fsqrt_h, TCG_CALL_NO_RWG, i64, env, i64)
+DEF_HELPER_FLAGS_3(fle_h, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(flt_h, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(feq_h, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_2(fcvt_s_h, TCG_CALL_NO_RWG, i64, env, i64)
+DEF_HELPER_FLAGS_2(fcvt_h_s, TCG_CALL_NO_RWG, i64, env, i64)
+DEF_HELPER_FLAGS_2(fcvt_d_h, TCG_CALL_NO_RWG, i64, env, i64)
+DEF_HELPER_FLAGS_2(fcvt_h_d, TCG_CALL_NO_RWG, i64, env, i64)
+DEF_HELPER_FLAGS_2(fcvt_w_h, TCG_CALL_NO_RWG, tl, env, i64)
+DEF_HELPER_FLAGS_2(fcvt_wu_h, TCG_CALL_NO_RWG, tl, env, i64)
+#if defined(TARGET_RISCV64)
+DEF_HELPER_FLAGS_2(fcvt_l_h, TCG_CALL_NO_RWG, tl, env, i64)
+DEF_HELPER_FLAGS_2(fcvt_lu_h, TCG_CALL_NO_RWG, tl, env, i64)
+#endif
+DEF_HELPER_FLAGS_2(fcvt_h_w, TCG_CALL_NO_RWG, i64, env, tl)
+DEF_HELPER_FLAGS_2(fcvt_h_wu, TCG_CALL_NO_RWG, i64, env, tl)
+#if defined(TARGET_RISCV64)
+DEF_HELPER_FLAGS_2(fcvt_h_l, TCG_CALL_NO_RWG, i64, env, tl)
+DEF_HELPER_FLAGS_2(fcvt_h_lu, TCG_CALL_NO_RWG, i64, env, tl)
+#endif
+DEF_HELPER_FLAGS_1(fclass_h, TCG_CALL_NO_RWG_SE, tl, i64)
+
+
 /* Special functions */
 DEF_HELPER_3(csrrw, tl, env, tl, tl)
 DEF_HELPER_4(csrrs, tl, env, tl, tl, tl)
diff --git a/target/riscv/insn32-64.decode b/target/riscv/insn32-64.decode
index 86153d9..f6f1ac9 100644
--- a/target/riscv/insn32-64.decode
+++ b/target/riscv/insn32-64.decode
@@ -81,3 +81,9 @@ fmv_x_d    1110001  00000 ..... 000 ..... 1010011 @r2
 fcvt_d_l   1101001  00010 ..... ... ..... 1010011 @r2_rm
 fcvt_d_lu  1101001  00011 ..... ... ..... 1010011 @r2_rm
 fmv_d_x    1111001  00000 ..... 000 ..... 1010011 @r2
+
+# *** RV64Zfh Standard Extension (in addition to RV32Zfh) ***
+fcvt_l_h   1100010  00010 ..... ... ..... 1010011 @r2_rm
+fcvt_lu_h  1100010  00011 ..... ... ..... 1010011 @r2_rm
+fcvt_h_l   1101010  00010 ..... ... ..... 1010011 @r2_rm
+fcvt_h_lu  1101010  00011 ..... ... ..... 1010011 @r2_rm
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index bdd8563..185fc4b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -581,3 +581,35 @@ vcompress_vm    010111 - ..... ..... 010 ..... 1010111 @r
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
+
+# *** RV32Zfh Extension ***
+flh        ............   ..... 001 ..... 0000111 @i
+fsh        .......  ..... ..... 001 ..... 0100111 @s
+fmadd_h    ..... 10 ..... ..... ... ..... 1000011 @r4_rm
+fmsub_h    ..... 10 ..... ..... ... ..... 1000111 @r4_rm
+fnmsub_h   ..... 10 ..... ..... ... ..... 1001011 @r4_rm
+fnmadd_h   ..... 10 ..... ..... ... ..... 1001111 @r4_rm
+fadd_h     0000010  ..... ..... ... ..... 1010011 @r_rm
+fsub_h     0000110  ..... ..... ... ..... 1010011 @r_rm
+fmul_h     0001010  ..... ..... ... ..... 1010011 @r_rm
+fdiv_h     0001110  ..... ..... ... ..... 1010011 @r_rm
+fsqrt_h    0101110  00000 ..... ... ..... 1010011 @r2_rm
+fsgnj_h    0010010  ..... ..... 000 ..... 1010011 @r
+fsgnjn_h   0010010  ..... ..... 001 ..... 1010011 @r
+fsgnjx_h   0010010  ..... ..... 010 ..... 1010011 @r
+fmin_h     0010110  ..... ..... 000 ..... 1010011 @r
+fmax_h     0010110  ..... ..... 001 ..... 1010011 @r
+fcvt_h_s   0100010  00000 ..... ... ..... 1010011 @r2_rm
+fcvt_s_h   0100000  00010 ..... ... ..... 1010011 @r2_rm
+fcvt_h_d   0100010  00001 ..... ... ..... 1010011 @r2_rm
+fcvt_d_h   0100001  00010 ..... ... ..... 1010011 @r2_rm
+fcvt_w_h   1100010  00000 ..... ... ..... 1010011 @r2_rm
+fcvt_wu_h  1100010  00001 ..... ... ..... 1010011 @r2_rm
+fmv_x_h    1110010  00000 ..... 000 ..... 1010011 @r2
+feq_h      1010010  ..... ..... 010 ..... 1010011 @r
+flt_h      1010010  ..... ..... 001 ..... 1010011 @r
+fle_h      1010010  ..... ..... 000 ..... 1010011 @r
+fclass_h   1110010  00000 ..... 001 ..... 1010011 @r2
+fcvt_h_w   1101010  00000 ..... ... ..... 1010011 @r2_rm
+fcvt_h_wu  1101010  00001 ..... ... ..... 1010011 @r2_rm
+fmv_h_x    1111010  00000 ..... 000 ..... 1010011 @r2
diff --git a/target/riscv/insn_trans/trans_rvzfh.inc.c b/target/riscv/insn_trans/trans_rvzfh.inc.c
new file mode 100644
index 0000000..1b4dede
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzfh.inc.c
@@ -0,0 +1,531 @@
+/*
+ * RISC-V translation routines for the RV64Zfh Standard Extension.
+ *
+ * Copyright (c) 2020 SiFive, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+static bool trans_flh(DisasContext *ctx, arg_flh *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    tcg_gen_addi_tl(t0, t0, a->imm);
+
+    tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUW);
+
+    gen_nanbox_h(cpu_fpr[a->rd], cpu_fpr[a->rd]);
+
+    mark_fs_dirty(ctx);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_addi_tl(t0, t0, a->imm);
+
+    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEUW);
+
+    mark_fs_dirty(ctx);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fmadd_h(DisasContext *ctx, arg_fmadd_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fmadd_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
+                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fmsub_h(DisasContext *ctx, arg_fmsub_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fmsub_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
+                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fnmsub_h(DisasContext *ctx, arg_fnmsub_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fnmsub_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
+                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fnmadd_h(DisasContext *ctx, arg_fnmadd_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fnmadd_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
+                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fadd_h(DisasContext *ctx, arg_fadd_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fadd_h(cpu_fpr[a->rd], cpu_env,
+                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fsub_h(DisasContext *ctx, arg_fsub_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fsub_h(cpu_fpr[a->rd], cpu_env,
+                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fmul_h(DisasContext *ctx, arg_fmul_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fmul_h(cpu_fpr[a->rd], cpu_env,
+                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fdiv_h(DisasContext *ctx, arg_fdiv_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fdiv_h(cpu_fpr[a->rd], cpu_env,
+                      cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fsqrt_h(DisasContext *ctx, arg_fsqrt_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fsqrt_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fsgnj_h(DisasContext *ctx, arg_fsgnj_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    if (a->rs1 == a->rs2) { /* FMOV */
+        gen_check_nanbox_h(cpu_fpr[a->rd], cpu_fpr[a->rs1]);
+    } else {
+        TCGv_i64 rs1 = tcg_temp_new_i64();
+        TCGv_i64 rs2 = tcg_temp_new_i64();
+
+        gen_check_nanbox_h(rs1, cpu_fpr[a->rs1]);
+        gen_check_nanbox_h(rs2, cpu_fpr[a->rs2]);
+
+        /* This formulation retains the nanboxing of rs2. */
+        tcg_gen_deposit_i64(cpu_fpr[a->rd], rs2, rs1, 0, 15);
+        tcg_temp_free_i64(rs1);
+        tcg_temp_free_i64(rs2);
+    }
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fsgnjn_h(DisasContext *ctx, arg_fsgnjn_h *a)
+{
+    TCGv_i64 rs1, rs2, mask;
+
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    rs1 = tcg_temp_new_i64();
+    gen_check_nanbox_h(rs1, cpu_fpr[a->rs1]);
+
+    if (a->rs1 == a->rs2) { /* FNEG */
+        tcg_gen_xori_i64(cpu_fpr[a->rd], rs1, MAKE_64BIT_MASK(15, 1));
+    } else {
+        rs2 = tcg_temp_new_i64();
+        gen_check_nanbox_h(rs2, cpu_fpr[a->rs2]);
+
+        /*
+         * Replace bit 15 in rs1 with inverse in rs2.
+         * This formulation retains the nanboxing of rs1.
+         */
+        mask = tcg_const_i64(~MAKE_64BIT_MASK(15, 1));
+        tcg_gen_not_i64(rs2, rs2);
+        tcg_gen_andc_i64(rs2, rs2, mask);
+        tcg_gen_and_i64(rs1, mask, rs1);
+        tcg_gen_or_i64(cpu_fpr[a->rd], rs1, rs2);
+
+        tcg_temp_free_i64(mask);
+        tcg_temp_free_i64(rs2);
+    }
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fsgnjx_h(DisasContext *ctx, arg_fsgnjx_h *a)
+{
+    TCGv_i64 rs1, rs2;
+
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    rs1 = tcg_temp_new_i64();
+    gen_check_nanbox_s(rs1, cpu_fpr[a->rs1]);
+
+    if (a->rs1 == a->rs2) { /* FABS */
+        tcg_gen_andi_i64(cpu_fpr[a->rd], rs1, ~MAKE_64BIT_MASK(15, 1));
+    } else {
+        rs2 = tcg_temp_new_i64();
+        gen_check_nanbox_s(rs2, cpu_fpr[a->rs2]);
+
+        /*
+         * Xor bit 15 in rs1 with that in rs2.
+         * This formulation retains the nanboxing of rs1.
+         */
+        tcg_gen_andi_i64(rs2, rs2, MAKE_64BIT_MASK(15, 1));
+        tcg_gen_xor_i64(cpu_fpr[a->rd], rs1, rs2);
+
+        tcg_temp_free_i64(rs2);
+    }
+
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fmin_h(DisasContext *ctx, arg_fmin_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    gen_helper_fmin_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
+                      cpu_fpr[a->rs2]);
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fmax_h(DisasContext *ctx, arg_fmax_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    gen_helper_fmax_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
+                      cpu_fpr[a->rs2]);
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fcvt_s_h(DisasContext *ctx, arg_fcvt_s_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_s_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
+
+    mark_fs_dirty(ctx);
+
+    return true;
+}
+
+static bool trans_fcvt_d_h(DisasContext *ctx, arg_fcvt_d_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+    REQUIRE_EXT(ctx, RVD);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_d_h(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
+
+    mark_fs_dirty(ctx);
+
+
+    return true;
+}
+
+static bool trans_fcvt_h_s(DisasContext *ctx, arg_fcvt_h_s *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_h_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
+
+    mark_fs_dirty(ctx);
+
+    return true;
+}
+
+static bool trans_fcvt_h_d(DisasContext *ctx, arg_fcvt_h_d *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+    REQUIRE_EXT(ctx, RVD);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_h_d(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
+
+    mark_fs_dirty(ctx);
+
+    return true;
+}
+
+static bool trans_feq_h(DisasContext *ctx, arg_feq_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+    TCGv t0 = tcg_temp_new();
+    gen_helper_feq_h(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_flt_h(DisasContext *ctx, arg_flt_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+    TCGv t0 = tcg_temp_new();
+    gen_helper_flt_h(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fle_h(DisasContext *ctx, arg_fle_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+    TCGv t0 = tcg_temp_new();
+    gen_helper_fle_h(t0, cpu_env, cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fclass_h(DisasContext *ctx, arg_fclass_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    TCGv t0 = tcg_temp_new();
+
+    gen_helper_fclass_h(t0, cpu_fpr[a->rs1]);
+
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fcvt_w_h(DisasContext *ctx, arg_fcvt_w_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    TCGv t0 = tcg_temp_new();
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_w_h(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fcvt_wu_h(DisasContext *ctx, arg_fcvt_wu_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    TCGv t0 = tcg_temp_new();
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_wu_h(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fcvt_h_w(DisasContext *ctx, arg_fcvt_h_w *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_h_w(cpu_fpr[a->rd], cpu_env, t0);
+
+    mark_fs_dirty(ctx);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fcvt_h_wu(DisasContext *ctx, arg_fcvt_h_wu *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_h_wu(cpu_fpr[a->rd], cpu_env, t0);
+
+    mark_fs_dirty(ctx);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fmv_x_h(DisasContext *ctx, arg_fmv_x_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    TCGv t0 = tcg_temp_new();
+
+#if defined(TARGET_RISCV64)
+    tcg_gen_ext16s_tl(t0, cpu_fpr[a->rs1]); // 16 bits->64 bits
+#else
+    tcg_gen_extrl_i64_i32(t0, cpu_fpr[a->rs1]); //16 bits->32 bits
+    tcg_gen_ext16s_tl(t0, t0);
+#endif
+
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fmv_h_x(DisasContext *ctx, arg_fmv_h_x *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    tcg_gen_extu_tl_i64(cpu_fpr[a->rd], t0);
+    gen_nanbox_h(cpu_fpr[a->rd], cpu_fpr[a->rd]);
+
+    mark_fs_dirty(ctx);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+#ifdef TARGET_RISCV64
+
+static bool trans_fcvt_l_h(DisasContext *ctx, arg_fcvt_l_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    TCGv t0 = tcg_temp_new();
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_l_h(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fcvt_lu_h(DisasContext *ctx, arg_fcvt_lu_h *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    TCGv t0 = tcg_temp_new();
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_lu_h(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fcvt_h_l(DisasContext *ctx, arg_fcvt_h_l *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_h_l(cpu_fpr[a->rd], cpu_env, t0);
+
+    mark_fs_dirty(ctx);
+    tcg_temp_free(t0);
+
+    return true;
+}
+
+static bool trans_fcvt_h_lu(DisasContext *ctx, arg_fcvt_h_lu *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVZfh);
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_h_lu(cpu_fpr[a->rd], cpu_env, t0);
+
+    mark_fs_dirty(ctx);
+    tcg_temp_free(t0);
+
+    return true;
+}
+#endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e227534..6dbd8c9 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -769,6 +769,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #include "insn_trans/trans_rvd.inc.c"
 #include "insn_trans/trans_rvh.inc.c"
 #include "insn_trans/trans_rvv.inc.c"
+#include "insn_trans/trans_rvzfh.inc.c"
 #include "insn_trans/trans_privileged.inc.c"
 
 /* Include the auto-generated decoder for 16 bit insn */
-- 
2.7.4


