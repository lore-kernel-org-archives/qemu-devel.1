Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F78BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCA920773
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZl9YFZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCA920773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqCo-0000Tz-Ek
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq48-0002Sx-AT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:56 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq46-0006QF-HJ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:56 -0400
Received: by mail-wr1-x42c.google.com with SMTP id f18so1796338wrs.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8VSF8mtn2rKIPWEKD7pM39hWrvESRKdjWGtuiRVbIO0=;
 b=NZl9YFZRu9s+AV+U8EX1O6NaaSl9GYuJVY55d3FyrWWkm0CZ3NgXStjQGo+s7AnUHW
 kCuCdjzE8PayKAYxZ6vRR1whlBsgKBpN+BRkgWzKt+dD3vBL9Ne7bzgjMXmomUTAHvkz
 n4gcQ6TmZIA/17uKtUjNplKbKQtQxkmJUFsIJKLNmYGzI8tioDhI8TzLJtot73/52yvz
 b+bZlm5jF37uKDKJuFAydLcdfD/+SESGqbaFRRCW6gW/04iM/fOrAhRQC7wRnrdtos41
 IzW1lA7J+BmC2K6/CDHM3ufgto4uGOVoLaOM/yNHmEVLurAbaWWceCkMw///KyA51WWz
 hN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8VSF8mtn2rKIPWEKD7pM39hWrvESRKdjWGtuiRVbIO0=;
 b=I6obyJSjDMfjypKzpJ/BrVHcHg0rD4kL3s1ye3ZNOLjIXcXmii0sezjHCwR7TwWtqS
 XOYRd4WdXQ/pp9n51VBd1IfX6AKmnjok1cnnVfxnP54YdYI8lf744A18ZMHkgcTvQphK
 6F5XZTXjZxLNQd1yCJNX/F/aCYN66L62Q6WUic7MYTV9eE4vHIfk8UbgnI6joDgsMahO
 1Fb/eWI5VNRxdXzmm6CeS8PMvA8RCuQADFW4VlSOA14TvyxY+7e1UAhuDWlo/65WfXlS
 dZ6+WMhcxsequE1/RooSjOhvklNFv2pOyhicz2qWosapq7Tp/YXqqKCSRS9cXb5mJ+Y/
 7lNg==
X-Gm-Message-State: AOAM531qaHtHY3IhppmWfmYQ/O6KIuftWbpDeVlWp663QWrZRrj5mEbT
 RnOBWlfMCg9vJQsQ3TDsSjxpxQk40hNEuQ==
X-Google-Smtp-Source: ABdhPJz2U9FK5yCPdC6s6Xq8QttGqFwFlDNAD8EQ707CEJYBgti1kJS3Zt1oWQAGuYKNNpHwkg1hKg==
X-Received: by 2002:adf:dc90:: with SMTP id r16mr4361009wrj.264.1593184492820; 
 Fri, 26 Jun 2020 08:14:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/57] target/arm: Implement the ADDG, SUBG instructions
Date: Fri, 26 Jun 2020 16:13:50 +0100
Message-Id: <20200626151424.30117-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h    |  1 +
 target/arm/internals.h     |  9 +++++++
 target/arm/mte_helper.c    | 10 ++++++++
 target/arm/translate-a64.c | 51 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 587ccbe42ff..6c116481e8f 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -105,3 +105,4 @@ DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
 
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_4(addsubg, TCG_CALL_NO_RWG_SE, i64, env, i64, s32, i32)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index ae611a6ff5d..5c69d4e5a56 100644
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
index 539a04de84b..9ab9ed749d8 100644
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
index 03aa0925983..2ec02c8a5f3 100644
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
2.20.1


