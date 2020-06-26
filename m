Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADAAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D4620773
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YoEdmUlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D4620773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqFY-0006Ns-IK
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq46-0002MR-2P
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:35857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq43-0006OW-Rl
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:53 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 17so9710434wmo.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/G8k8+jbJUrLWrICrwU7nxlVad0l1SACguDlrS0IJC8=;
 b=YoEdmUlxTqip1kfnxGvBa+I+xO2K23RFMsRvaOn/KyYNF+IuvwX/uviuL6TxjdQDFf
 ehlBpq6peKXOkDDY6R81dAglZwErAvL/Ix/RnYpCmmC3gPrpvcr8vSqaHKf+pNZgFjsw
 Y7nnA3cH9SWS1BcMfMs0CnN59jUzVfOx2fWdV4qQx4of2x/bgFCLivAz1vW6RTN/PT5D
 MokJ8IfdhuAUTyw47UI306QpcrNwltEp2NTqgbjXHHNT+Olk2YvWqYHznlBNqOIoxzjZ
 KzSLm3xa/D4ZkJ7vdg/I5RRJAWEw9YKOoryKUPSzlgeAR8wkn3uEFi28YqjV1H34sBZj
 Uz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/G8k8+jbJUrLWrICrwU7nxlVad0l1SACguDlrS0IJC8=;
 b=bycbRLOh3oA3BTQXCqrS+klOyCHND8kYGvTdTUpFAn1susMmQhXH+LRt8opAR/hpd+
 G0zvkDAhah3u3yFiRJIKkCcBHugdaNCZ8v7h1Dx6OW+d8MWgV7Ja0ibOMx4wPaZpIdM/
 BpyJat4qGZHxPZP+YPTXA5GFurhqIMTWVq7ZY6s/ld9DPMx+v8YmJdcWFaihDaCiNtJ2
 jfOt6Tbb62wEQopDVWONmPVUuKhcDaECVBf13pkrFICxc1UHIhWk4MkipwQc3Bv4hQ53
 /mOPJL1BmKzw7asoWod5cXsY0kW3Ju+znVmQktFtEQVHCerwhV0/vP+Y/6EPJZLX6WQd
 db5Q==
X-Gm-Message-State: AOAM533WEVxmfnCCyodIBO4/kMCq29XFrl6LiVvRVyUaF8Z3oRrtkwZl
 RyUwUtgmxAVLsKSE7eSEVeRPTqD9BLOWdA==
X-Google-Smtp-Source: ABdhPJycNFYKlUFTIG1TPgw4Y29RfGQ9B4MIMNioMFvSlKnzyUN1yocRkAFEp0QaC0Y1YfoNUYfvhw==
X-Received: by 2002:a05:600c:218f:: with SMTP id
 e15mr3685971wme.63.1593184489990; 
 Fri, 26 Jun 2020 08:14:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/57] target/arm: Implement the IRG instruction
Date: Fri, 26 Jun 2020 16:13:48 +0100
Message-Id: <20200626151424.30117-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Message-id: 20200626033144.790098-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h    |  2 ++
 target/arm/internals.h     |  5 +++
 target/arm/mte_helper.c    | 72 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 18 ++++++++++
 target/arm/Makefile.objs   |  1 +
 5 files changed, 98 insertions(+)
 create mode 100644 target/arm/mte_helper.c

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 3df7c185aa1..587ccbe42ff 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -103,3 +103,5 @@ DEF_HELPER_FLAGS_3(autda, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
+
+DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 53e249687ba..ae611a6ff5d 100644
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
index 00000000000..539a04de84b
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
index 55f49585be4..30683061f94 100644
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
@@ -5284,6 +5290,18 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
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
index 83febd232c8..fa39fd7c831 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -86,3 +86,4 @@ obj-$(CONFIG_SOFTMMU) += psci.o
 obj-$(TARGET_AARCH64) += translate-a64.o helper-a64.o
 obj-$(TARGET_AARCH64) += translate-sve.o sve_helper.o
 obj-$(TARGET_AARCH64) += pauth_helper.o
+obj-$(TARGET_AARCH64) += mte_helper.o
-- 
2.20.1


