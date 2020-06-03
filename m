Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F46C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B34206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ak3KhUJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B34206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgI40-0006J9-07
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyI-0003kN-4y
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:34 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyH-0003YG-9u
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:33 -0400
Received: by mail-pl1-x644.google.com with SMTP id y18so201814plr.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MehLLPs7OH2d6Ox8Z4/DEtryQBHArcvcM5ew1vNvLQQ=;
 b=Ak3KhUJginINoFqCHKHBtNmOVSbXtdWbSHFc0M1UYoiTOC5/tqwWY1FkxRiDFgM0g/
 nNQR8uL2qIYdvwFc0jFA1UrIOGLJcuWfbcSAnIJ2gwJiktPHS6juDqM02DWoRAHKDE1u
 AtOpxZcdN7IT4KCUWafayECCLuF1mQH9dizLahlIEh8Ddqp1r3uchxVp4OLn84RkcRD+
 kXpCf1J6pETkqiyT3V+Bk+whJp2GcEZcFYI2X9vW8Gge52oj1+LNpzmGZHRX4ILk6PUw
 CcG49UQuj1s4keYlrlCETsEeunqnai8iGGZwYPTKxaY7hBcHgazlbxqAVsmluMBW+RWU
 6n1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MehLLPs7OH2d6Ox8Z4/DEtryQBHArcvcM5ew1vNvLQQ=;
 b=L6DZ/6xgU34Q2Hg7mpGXQuD89kvYZ7SW0YXgTOCbuhx+T262X7ZGZcXqmKT7DgetGN
 SJ8UfnT7XqoCRUFkctok2WyOJpvgORLTU6rm1BMrtPxp6tWkuQDxOWaI6Jeq/UW+GeWD
 NB8DthfRp021gOwDlIj3c7YkqwKBom9TTiW+SDgXllKZvYA5gq7lUlDdbC/1zajstzzI
 41O4je9RaBDhga4wjXVo9wgmActw4niD1jYtQYgRLsMs+7Xws0lZccIAUVe92INWgpZ4
 RDk/FXJfX8ogA68riMvSsRmxk+eVcdc298+fceQhOEOVm3DRa2FXP5UZcLB4dAnjBRCc
 pxCA==
X-Gm-Message-State: AOAM531UPFSWDaWjXv6xPmqjks814mFDalVgoqARg0xnU5Tsx9BMDoxt
 lWz3Iy1JKrRET6d2OQSdVhgFyZkNeKk=
X-Google-Smtp-Source: ABdhPJxbn+qv5LccmnOW4sggAGuvT1yPGoFN0ZDJ7eN3lDYbkQ2bztwXnlUXaGqkNT+H1vm5O4PdSg==
X-Received: by 2002:a17:902:8509:: with SMTP id
 bj9mr27287428plb.151.1591146811617; 
 Tue, 02 Jun 2020 18:13:31 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 10/42] target/arm: Implement the ADDG, SUBG instructions
Date: Tue,  2 Jun 2020 18:12:45 -0700
Message-Id: <20200603011317.473934-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Shift offset in translate; use extract32.
v6: Implement inline for !ATA.
---
 target/arm/helper-a64.h    |  1 +
 target/arm/internals.h     |  9 +++++++++
 target/arm/mte_helper.c    | 10 ++++++++++
 target/arm/translate-a64.c | 36 ++++++++++++++++++++++++++++++++++--
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 587ccbe42f..6c116481e8 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -105,3 +105,4 @@ DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
 
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_4(addsubg, TCG_CALL_NO_RWG_SE, i64, env, i64, s32, i32)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index ae611a6ff5..5c69d4e5a5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1261,6 +1261,15 @@ void arm_log_exception(int idx);
  */
 #define GMID_EL1_BS  6
 
+/* We associate one allocation tag per 16 bytes, the minimum.  */
+#define LOG2_TAG_GRANULE 4
+#define TAG_GRANULE      (1 << LOG2_TAG_GRANULE)
+
+static inline int allocation_tag_from_addr(uint64_t ptr)
+{
+    return extract64(ptr, 56, 4);
+}
+
 static inline uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
 {
     return deposit64(ptr, 56, 4, rtag);
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 539a04de84..9ab9ed749d 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -70,3 +70,13 @@ uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
 
     return address_with_allocation_tag(rn, rtag);
 }
+
+uint64_t HELPER(addsubg)(CPUARMState *env, uint64_t ptr,
+                         int32_t offset, uint32_t tag_offset)
+{
+    int start_tag = allocation_tag_from_addr(ptr);
+    uint16_t exclude = extract32(env->cp15.gcr_el1, 0, 16);
+    int rtag = choose_nonexcluded_tag(start_tag, tag_offset, exclude);
+
+    return address_with_allocation_tag(ptr + offset, rtag);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2481561925..a18d71ad98 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3753,17 +3753,20 @@ static void disas_pc_rel_adr(DisasContext *s, uint32_t insn)
  *    sf: 0 -> 32bit, 1 -> 64bit
  *    op: 0 -> add  , 1 -> sub
  *     S: 1 -> set flags
- * shift: 00 -> LSL imm by 0, 01 -> LSL imm by 12
+ * shift: 00 -> LSL imm by 0,
+ *        01 -> LSL imm by 12
+ *        10 -> ADDG, SUBG
  */
 static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
 {
     int rd = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
-    uint64_t imm = extract32(insn, 10, 12);
+    int imm = extract32(insn, 10, 12);
     int shift = extract32(insn, 22, 2);
     bool setflags = extract32(insn, 29, 1);
     bool sub_op = extract32(insn, 30, 1);
     bool is_64bit = extract32(insn, 31, 1);
+    bool is_tag = false;
 
     TCGv_i64 tcg_rn = cpu_reg_sp(s, rn);
     TCGv_i64 tcg_rd = setflags ? cpu_reg(s, rd) : cpu_reg_sp(s, rd);
@@ -3775,11 +3778,40 @@ static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
     case 0x1:
         imm <<= 12;
         break;
+    case 0x2:
+        /* ADDG, SUBG */
+        if (!is_64bit || setflags || (imm & 0x30) ||
+            !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        }
+        is_tag = true;
+        break;
     default:
+    do_unallocated:
         unallocated_encoding(s);
         return;
     }
 
+    if (is_tag) {
+        imm = (imm >> 6) << LOG2_TAG_GRANULE;
+        if (sub_op) {
+            imm = -imm;
+        }
+
+        if (s->ata) {
+            TCGv_i32 tag_offset = tcg_const_i32(imm & 15);
+            TCGv_i32 offset = tcg_const_i32(imm);
+
+            gen_helper_addsubg(tcg_rd, cpu_env, tcg_rn, offset, tag_offset);
+            tcg_temp_free_i32(tag_offset);
+            tcg_temp_free_i32(offset);
+        } else {
+            tcg_gen_addi_i64(tcg_rd, tcg_rn, imm);
+            gen_address_with_allocation_tag0(tcg_rd, tcg_rd);
+        }
+        return;
+    }
+
     tcg_result = tcg_temp_new_i64();
     if (!setflags) {
         if (sub_op) {
-- 
2.25.1


