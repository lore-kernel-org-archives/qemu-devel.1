Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE52C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382E020709
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cuGlvaxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382E020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofDQ-0005b9-F4
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5x-0008BF-Ba
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:05 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5v-0001oC-7r
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:05 -0400
Received: by mail-pl1-x644.google.com with SMTP id y18so3759476plr.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XoJrsJU/hBxn7ncf6hm9h/jSltj19qJCBJOfwezbMk0=;
 b=cuGlvaxDQCzpzbEtF3NNETpRhFIzGYo7AdQzjwKzDKqrZYWl1r5rq3OIvQNkK5tmzJ
 D0Xk2P2/E1vdI+NupXjsz5IxIWG50iiHjfuHq80FWQgDafYpdQYT0hIyNDHafWgKlBYZ
 z0IZOudyIcUU/aT1ab9/2qozOYw9HrGAQfU0jxKO9YxBLNnWyf6xZmqvS6VgA7hLQ/38
 Z/5wfOQ27hK6/05MKq0DgvMNmGStlzsR5kgf6bIblZDhYigUE4Z/ZkezlygCZtEJodC4
 LpT0G4mLmrhEho1gAgoep8dPzP86tLjlz8OuW0UNK8TARhilu83Rd1ywIrF3JK82GK2O
 suSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XoJrsJU/hBxn7ncf6hm9h/jSltj19qJCBJOfwezbMk0=;
 b=Udshuv/NPf+fpiBdUx1P275Yl1my4KoE79nxUKJJvXPbZlgQD3FsM+RJvuX3Hp0rlE
 eYpNRqxfFayCgSSrzydcvah7iuXqLE02BWFOk2cygb7kapZjyB69BYuCt/lJOFdJb3YV
 ZF22sVyAVKJEXls9zWHsbh1o2wLAOMovsyaS8J3OZyhlndPrPcOS8VojSoKLDIU9PdBj
 DQAE8P4CQmZ7SWs/GTGzt5rGWEKQY7aSaAFfgDRc14jwedXCdT68BJtUEJq+7KBg7upn
 k8vyrL3Bxu9Xs8xjr+W981+XGDCqZ723V3D6EgJ6QgJds8NM2+GD9b45iHyc3KoCuiKz
 zwkg==
X-Gm-Message-State: AOAM5318Bk8TFN340ZZ5H2LZs99gVUqUhPUI4ZuzrKE+/ADA+FCgks9D
 kRlH1EQwNLclKP75XWcEOkmcoki4VxI=
X-Google-Smtp-Source: ABdhPJy2to5sQraruPcjIfsjlWYnnyPqdtWj1vjhErRRi7tnBmjICCuhDP6U17tPVoxKQ6dnyW3OsQ==
X-Received: by 2002:a17:90a:3b09:: with SMTP id
 d9mr1226082pjc.225.1593142321381; 
 Thu, 25 Jun 2020 20:32:01 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 11/46] target/arm: Implement the ADDG, SUBG instructions
Date: Thu, 25 Jun 2020 20:31:09 -0700
Message-Id: <20200626033144.790098-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 03aa092598..2ec02c8a5f 100644
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
+ * |sf|op| S| 1 0 0 0 1 1 |o2|  uimm6  |o3| uimm4 |  Rn | Rd  |
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
+    if ((insn & 0xa040c000u) != 0x80000000u ||
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


