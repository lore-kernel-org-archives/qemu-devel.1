Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3083C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE75320637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNdabXgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE75320637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTn6-0000kS-S3
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj3-00056V-EV
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj0-0001pp-Pl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:37 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTj0-0001p6-Jf
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:34 -0400
Received: by mail-pf1-x442.google.com with SMTP id 2so3750430pfg.12
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JoyDuvitqL3gplX8QkVPoVTvT8uYIpXUkFPIRitQ3hc=;
 b=kNdabXgE3qiHP8TZpaYHR/fPNPnri+tPPxzECMwHJPQhQpDKA0YZkseLSTqtBeTwRR
 EjN7f8a38PJC3rJDyepe10jEy96b/EsHs3SljHMwAcK6OTPAyCpWfvI9C65aXTsRyLb9
 u0iX+IhNL8KDglG87KWG39vrJDjCG8jUalq5xVLZR/WOd0LOoUTjEAosZ4S9teGuJV27
 MG+3nT57RvAHI+Fj8fPpSN7mV0iXcYFSSa3spw1sW9Qjpl97erASfZL9Y6T99Pu7AYiU
 pFdcjCJIScWWpRsBl57NmQ0aQSY0txvZYPlUzw7WNzd8ToupKD2duBM92gsZOrwEA65l
 /poA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JoyDuvitqL3gplX8QkVPoVTvT8uYIpXUkFPIRitQ3hc=;
 b=dFOl6BWHQCORCs1WkTvCI3UjRXwTajQgdymROfUXQdRzi1iYRV6uyA5QnEYnNy3jvh
 YFTw78dSL1kTVw9/gLPhI6VfG9pa+g6w4JJLPwgC6NfhH+VLooZWXScuMjn++CsY43e2
 7PhvqkVxv/lYlaeO61dSlETOr+3t2QAsrFhQYIJpVCNJReYlvkFEL//wUOKiTJlVcVnm
 sn/jbln9n15OBAk3DcjI4FO1lACMQlqCNRgeK3FFZbzP5mBZRWrMYHKUZF2R1rvJ/2Tu
 v5/uMWK1d/eOO5bXKNib36PMi4Hj4gXo3p2EYO3kxkwBbNL4bXkVIHnqM1aV8Kn7yczn
 gMtA==
X-Gm-Message-State: ANhLgQ2fzF6jXWx5d4Z13scLl2/evQm0rtovNn0INxI3Jx0T7+FZL22U
 iAsk1AHNvYeCsTlkHNYq/Fk32JdrfvA=
X-Google-Smtp-Source: ADFU+vtpOfY5UAeNzelvJHqgomyDyij3YJm/GVRYDYM+nZHmC6IegQI5PG3fMjLa19GWrm8h30aLgA==
X-Received: by 2002:a62:ea08:: with SMTP id t8mr9578256pfh.163.1584042153218; 
 Thu, 12 Mar 2020 12:42:33 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/42] target/arm: Implement the IRG instruction
Date: Thu, 12 Mar 2020 12:41:46 -0700
Message-Id: <20200312194219.24406-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
v2: Update to 00eac5.
    Merge choose_random_nonexcluded_tag into helper_irg since
    that pseudo function no longer exists separately.
v6: Remove obsolete logical/physical tag distinction;
    implement inline for !ATA.
---
 target/arm/helper-a64.h    |  2 ++
 target/arm/internals.h     |  5 +++
 target/arm/mte_helper.c    | 72 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 18 ++++++++++
 target/arm/Makefile.objs   |  1 +
 5 files changed, 98 insertions(+)
 create mode 100644 target/arm/mte_helper.c

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 3df7c185aa..587ccbe42f 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -103,3 +103,5 @@ DEF_HELPER_FLAGS_3(autda, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
+
+DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 45f445cf3e..e4450302a6 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1257,4 +1257,9 @@ void arm_log_exception(int idx);
  */
 #define GMID_EL1_BS  6
 
+static inline uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
+{
+    return deposit64(ptr, 56, 4, rtag);
+}
+
 #endif
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
new file mode 100644
index 0000000000..539a04de84
--- /dev/null
+++ b/target/arm/mte_helper.c
@@ -0,0 +1,72 @@
+/*
+ * ARM v8.5-MemTag Operations
+ *
+ * Copyright (c) 2020 Linaro, Ltd.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+#include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
+
+
+static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
+{
+    if (exclude == 0xffff) {
+        return 0;
+    }
+    if (offset == 0) {
+        while (exclude & (1 << tag)) {
+            tag = (tag + 1) & 15;
+        }
+    } else {
+        do {
+            do {
+                tag = (tag + 1) & 15;
+            } while (exclude & (1 << tag));
+        } while (--offset > 0);
+    }
+    return tag;
+}
+
+uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
+{
+    int rtag;
+
+    /*
+     * Our IMPDEF choice for GCR_EL1.RRND==1 is to behave as if
+     * GCR_EL1.RRND==0, always producing deterministic results.
+     */
+    uint16_t exclude = extract32(rm | env->cp15.gcr_el1, 0, 16);
+    int start = extract32(env->cp15.rgsr_el1, 0, 4);
+    int seed = extract32(env->cp15.rgsr_el1, 8, 16);
+    int offset, i;
+
+    /* RandomTag */
+    for (i = offset = 0; i < 4; ++i) {
+        /* NextRandomTagBit */
+        int top = (extract32(seed, 5, 1) ^ extract32(seed, 3, 1) ^
+                   extract32(seed, 2, 1) ^ extract32(seed, 0, 1));
+        seed = (top << 15) | (seed >> 1);
+        offset |= top << i;
+    }
+    rtag = choose_nonexcluded_tag(start, offset, exclude);
+    env->cp15.rgsr_el1 = rtag | (seed << 8);
+
+    return address_with_allocation_tag(rn, rtag);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5eda6ff975..f1e2fe0060 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -243,6 +243,12 @@ static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
     return clean;
 }
 
+/* Insert a zero tag into src, with the result at dst. */
+static void gen_address_with_allocation_tag0(TCGv_i64 dst, TCGv_i64 src)
+{
+    tcg_gen_andi_i64(dst, src, ~MAKE_64BIT_MASK(56, 4));
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -5329,6 +5335,18 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     case 3: /* SDIV */
         handle_div(s, true, sf, rm, rn, rd);
         break;
+    case 4: /* IRG */
+        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        }
+        if (s->ata) {
+            gen_helper_irg(cpu_reg_sp(s, rd), cpu_env,
+                           cpu_reg_sp(s, rn), cpu_reg(s, rm));
+        } else {
+            gen_address_with_allocation_tag0(cpu_reg_sp(s, rd),
+                                             cpu_reg_sp(s, rn));
+        }
+        break;
     case 8: /* LSLV */
         handle_shift_reg(s, A64_SHIFT_TYPE_LSL, sf, rm, rn, rd);
         break;
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index cf26c16f5f..8fd7d086c8 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -67,3 +67,4 @@ obj-$(CONFIG_SOFTMMU) += psci.o
 obj-$(TARGET_AARCH64) += translate-a64.o helper-a64.o
 obj-$(TARGET_AARCH64) += translate-sve.o sve_helper.o
 obj-$(TARGET_AARCH64) += pauth_helper.o
+obj-$(TARGET_AARCH64) += mte_helper.o
-- 
2.20.1


