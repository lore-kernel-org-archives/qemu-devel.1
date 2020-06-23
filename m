Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960BBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647AB207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDPwGL1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647AB207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnotT-0006A1-Hh
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojP-0003an-97
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:19 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojN-0005bp-4D
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:18 -0400
Received: by mail-pf1-x442.google.com with SMTP id q17so3363302pfu.8
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QBDMF3A6g4i6U3PY+gnBip+Ec52Yqe21zljrRBJfq1A=;
 b=jDPwGL1Ly4EyM2axfeRipxpFaVFsYwyFNWHiahxJDkSbJLMqm9xlg7+j/CFNjJboE6
 Nv3z/WQKVl5552kArzR+es6hIa40KhnztZnxRzNHLyNgw+dEEoblwiz6S2ySe1n1XtgS
 duTYlA+yrzRL1hdw0jxFRd9L2I7FM6N85uE0qpF6Cxg5pkwXd145bp/kUUlW9ydwEuVw
 Q8LKO2J07+0WSF7PXyPY+mj5AGshZaGoPlqriWBjRysyhCX03BNzpFaTPNZ1s1FmTPM+
 9ioCESx4RPUwm37OJsOfcjp0lXqnmGEuoDIsfEIS7jBcHuIkjTwn4UfYdx9Gi5idAVa0
 AZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QBDMF3A6g4i6U3PY+gnBip+Ec52Yqe21zljrRBJfq1A=;
 b=i9d3mz/8GXqND9y2MlrXevnu4/wHzGrqaWmOrPV8cmHA6GPMJghFPW4NzUGizQc0ZB
 +kTqutT0Mn1HcUwAiLsApmNdrNgrfrRVcq7MwV0oRoKpY7FsQhsTAixhoOD2qbUyaf3u
 ilM1NlGxXD2PmvdtKMTivwRCyK7A8pUVUnzY7mMwTeFqEosq76ZherccfapAc4bYmU6h
 +Jia/JA2smsW1ZYWxmBG2kNeo7yKawQg7a6+9InXrObkm7MoCfBZEQAF1pSUDmYY5ss6
 rLX8aeO6ZjJYHgX0/i6Nxa0pE0LczoRoP3Q7Sljwof6Xf82yl3OSNaeoUGdG8wu5mF6o
 nJpA==
X-Gm-Message-State: AOAM533mjhXH1Uv8XKHMSiZTdLIsgEBOd1YrLwCWGL09kyp7piZiRiFI
 xzKX8aHG6bBrMlvlGHjol5HuSVuaDQg=
X-Google-Smtp-Source: ABdhPJy5yafM6q6AguhsbkvikRmJcaTBMf3NfPhOb0H/Nd/ECbBAoQgDaTezlkI3lHoL/R1iJSeHlw==
X-Received: by 2002:a65:6447:: with SMTP id s7mr17690553pgv.320.1592941035322; 
 Tue, 23 Jun 2020 12:37:15 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 11/45] target/arm: Implement the ADDG, SUBG instructions
Date: Tue, 23 Jun 2020 12:36:24 -0700
Message-Id: <20200623193658.623279-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Shift offset in translate; use extract32.
v6: Implement inline for !ATA.
v8: Use separate decode function.
---
 target/arm/helper-a64.h    |  1 +
 target/arm/internals.h     |  9 +++++++
 target/arm/mte_helper.c    | 10 ++++++++
 target/arm/translate-a64.c | 51 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)

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
index 59f44fc412..e9bc7e90af 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3808,6 +3808,54 @@ static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_result);
 }
 
+/*
+ * Add/subtract (immediate, with tags)
+ *
+ *  31 30 29 28         23 22 21     16 14      10 9   5 4   0
+ * +--+--+--+-------------+--+---------+--+-------+-----+-----+
+ * |sf|op| S| 1 0 0 0 1 0 |o2|  uimm6  |o3| uimm4 |  Rn | Rd  |
+ * +--+--+--+-------------+--+---------+--+-------+-----+-----+
+ *
+ *    op: 0 -> add, 1 -> sub
+ */
+static void disas_add_sub_imm_with_tags(DisasContext *s, uint32_t insn)
+{
+    int rd = extract32(insn, 0, 5);
+    int rn = extract32(insn, 5, 5);
+    int uimm4 = extract32(insn, 10, 4);
+    int uimm6 = extract32(insn, 16, 6);
+    bool sub_op = extract32(insn, 30, 1);
+    TCGv_i64 tcg_rn, tcg_rd;
+    int imm;
+
+    /* Test all of sf=1, S=0, o2=0, o3=0.  */
+    if ((insn & 0xc040e000u) != 0x80000000u ||
+        !dc_isar_feature(aa64_mte_insn_reg, s)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    imm = uimm6 << LOG2_TAG_GRANULE;
+    if (sub_op) {
+        imm = -imm;
+    }
+
+    tcg_rn = cpu_reg_sp(s, rn);
+    tcg_rd = cpu_reg_sp(s, rd);
+
+    if (s->ata) {
+        TCGv_i32 offset = tcg_const_i32(imm);
+        TCGv_i32 tag_offset = tcg_const_i32(uimm4);
+
+        gen_helper_addsubg(tcg_rd, cpu_env, tcg_rn, offset, tag_offset);
+        tcg_temp_free_i32(tag_offset);
+        tcg_temp_free_i32(offset);
+    } else {
+        tcg_gen_addi_i64(tcg_rd, tcg_rn, imm);
+        gen_address_with_allocation_tag0(tcg_rd, tcg_rd);
+    }
+}
+
 /* The input should be a value in the bottom e bits (with higher
  * bits zero); returns that value replicated into every element
  * of size e in a 64 bit integer.
@@ -4170,6 +4218,9 @@ static void disas_data_proc_imm(DisasContext *s, uint32_t insn)
     case 0x22: /* Add/subtract (immediate) */
         disas_add_sub_imm(s, insn);
         break;
+    case 0x23: /* Add/subtract (immediate, with tags) */
+        disas_add_sub_imm_with_tags(s, insn);
+        break;
     case 0x24: /* Logical (immediate) */
         disas_logic_imm(s, insn);
         break;
-- 
2.25.1


