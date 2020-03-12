Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AEAC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5CDC20637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynJQy5vD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CDC20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTpC-0006H3-Uv
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj4-0005A5-Ev
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj3-0001s9-3A
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:38 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:39596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTj2-0001qG-TL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:37 -0400
Received: by mail-pj1-x1043.google.com with SMTP id d8so3072410pje.4
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KVh1PjkTSIf81i4jFeoQokSOAEnUoVWj3KgKbBOigI0=;
 b=ynJQy5vDLRaZntNHzQOfrRyhzJ5y6MEh/m47daaScFtiG+Cx8Qd+xhsrdwBt6LWY/4
 liUKM+3buVV8Pfa7dWDihHItMZhrmAlfKhl9j/rmTV0gYUWYkb431LQPmsAMB1L4PT4C
 MIAcrqTGhFwWRP6u9wAdw2MJVbFs71yc/lhpKsBKgaGVdqjkJRe9U6oZNsHVnt9bJyoO
 OMnjcHRsuYcl8SWpnQ4OHUaLIcxfSR3Qsh1C6SY+y0TMwuqN2LgKTKH5+b+3zITrvoLJ
 eiuDBwGZ+ktFoGA4cgLlOGaqf5r2KTRZCFiN2DuHp5Ado7XMojKa2d6qZhgqwXUoEQJi
 7rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KVh1PjkTSIf81i4jFeoQokSOAEnUoVWj3KgKbBOigI0=;
 b=XxbDjST2wO4LSUDp04FwWG08wMLWLI5uDxYGQKZvlq++A6C6Uzybfj6nokNVSeMj5u
 Ri/LGw5jDebW4V2uNngw8S6sDwR0MdIKgZuE18xZ9smxAf6G0wfX6hH6oEfCW6aNQUfg
 dOJDCB+YiOz4ITBcIdhffrX1uJthUHm8/50XNlv6t2d1qoFKB4xMKoH5ju95xxC5OCFu
 /z4buPx7e2sxPI7wUUEvZjsDGNno0t5c8KDAhdBjrF6uFT0YJdK9hGow3LPz1PtXNZEl
 E+vWePUOQckB6Z7gCyai0EdsiEa1FLIGJ32ypwI1+t1c1nU6hgESjzjKZojHET0d37Lt
 +OQg==
X-Gm-Message-State: ANhLgQ1kl2hsqgMA6sZ4peHVgisZcFJHW5gMbXGrOWpZ18ml+kAD0Wkn
 X0CexjEOvPE4G0oh/A3xj0fNhuYLgVw=
X-Google-Smtp-Source: ADFU+vvqQW/uUnDRVKu4GBHb6aqY9uNq3D9AsmmHp/s4eH6CTIhYSt1hkYlaSAk8Vuz9oXzRhRqk1w==
X-Received: by 2002:a17:902:7298:: with SMTP id
 d24mr9598358pll.134.1584042154568; 
 Thu, 12 Mar 2020 12:42:34 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 10/42] target/arm: Implement the ADDG, SUBG instructions
Date: Thu, 12 Mar 2020 12:41:47 -0700
Message-Id: <20200312194219.24406-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
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
index e4450302a6..3190fc40fc 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1257,6 +1257,15 @@ void arm_log_exception(int idx);
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
index f1e2fe0060..02f31d5948 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3807,17 +3807,20 @@ static void disas_pc_rel_adr(DisasContext *s, uint32_t insn)
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
@@ -3829,11 +3832,40 @@ static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
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
2.20.1


