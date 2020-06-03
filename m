Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1224C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3532072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdaW0Hce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3532072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgI5H-0000H5-0c
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyG-0003gq-Us
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:32 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyF-0003Y1-VM
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:32 -0400
Received: by mail-pl1-x643.google.com with SMTP id y18so201799plr.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GhH3aRALfbOeqG40MvYbNczfufYSgHXrHQfwMMscNhw=;
 b=vdaW0Hcels1M2Zq9beZmzpEqhiEFPjFw30z7uAwoOk5TdlRoKypGt3YjaQKlwyExuO
 13McAgFS9Z4COlbTv9r5B0DZmOtQW9/R22/UmerUXZQJXK3hhXvm86qsvmzI3jXavAzI
 bKmHLRhIVzG/OODNFNyK9s510s1QpV/NmTd+nI2sj3Okk42xQwClEqa/Ge1FRFHC5nyD
 7OBzMWe1+Iw78s8CrNNlxyKqzUwE6EC6Tsc44v37n3EpwHFwNXOlNujJiwgeUK40YQcy
 oot2w0We8uclqJuMivQDu7z2UkXWUdqLfjvMM4lHlSpUP8xf1TVJEr1Vp2PIXdD5bFv7
 7oSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GhH3aRALfbOeqG40MvYbNczfufYSgHXrHQfwMMscNhw=;
 b=nOMuwCBChftZgI5G7Y/LK9Gm1R1gVBIznC9rBUA9AYwYWaVOP8bHSvolfj7UQzG4ol
 u5aA+XzCfYCklLWNoRvwXzP64YiV1N1QCymT9n5wsos5abulZYwKQa3WMLZg9ux7CNyy
 VuLMxizNbeSlhAHejW3aVy0zN3k8ctLYI7eUqkvNBc21sXAuRxt1O+FJg8NyfZMl6+bd
 yyseisBV6G5B55wd/38HvqakMp5diBybtNmUkPpId4Afb1UujXaS67dEjWw2DCWjPGdN
 nQ/M+9IiAWBDrONvHPf/UAHOPplNvayZWzIU5ZksLRNmbPzza/GYhuhqIb+1QYUnZpSH
 7QOw==
X-Gm-Message-State: AOAM532u5mtohw+GmwNy8Yt+DXASh4yxIYKjBHrn0xjLYdadyaqlZGjI
 e8upK8xYeFt4f3d3dukvr/ktzq+6/CQ=
X-Google-Smtp-Source: ABdhPJwdwEhk5m5RfqAAPg+UO18/Xl6xA8XjyU2C3NUS/GcMXyW2/o0EqdVe+GJIssPHMXKxELpvxA==
X-Received: by 2002:a17:902:b185:: with SMTP id
 s5mr28116718plr.304.1591146810187; 
 Tue, 02 Jun 2020 18:13:30 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 09/42] target/arm: Implement the IRG instruction
Date: Tue,  2 Jun 2020 18:12:44 -0700
Message-Id: <20200603011317.473934-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
index 53e249687b..ae611a6ff5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1261,4 +1261,9 @@ void arm_log_exception(int idx);
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
index ec2013782d..2481561925 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -226,6 +226,12 @@ static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
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
@@ -5275,6 +5281,18 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
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
index 83febd232c..fa39fd7c83 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -86,3 +86,4 @@ obj-$(CONFIG_SOFTMMU) += psci.o
 obj-$(TARGET_AARCH64) += translate-a64.o helper-a64.o
 obj-$(TARGET_AARCH64) += translate-sve.o sve_helper.o
 obj-$(TARGET_AARCH64) += pauth_helper.o
+obj-$(TARGET_AARCH64) += mte_helper.o
-- 
2.25.1


