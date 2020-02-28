Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20D6C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC662468D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5u91R6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC662468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ilX-0003ys-H7
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifY-0008Kw-Mb
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifX-00027f-9T
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:20 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifX-00027E-26
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:19 -0500
Received: by mail-wr1-x430.google.com with SMTP id v2so3600858wrp.12
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kVj8xiNy7P+impZo0PATu9zmL7PfKEv61GKapK4HB3M=;
 b=n5u91R6eRFocJHArmg6rLlH+evDOkI7c6BcilazFITxHqvtq/bJY3sQarvwKrgrwbX
 sPfHUTvM9y5wy/6lbJb28KIFW/AGSyTZtVriET4U6gxh3jwcgrSZqFpURbPITOeoeL5s
 2ohZoqhaHlj9Yaa5v5p+CQMc4wxwfDRKKjWoEP12YqnpScanRXds+pYnBv8C2WSOUPb4
 wpVbulEpDdSXICerpOzLPBUHpRzTiNC8ESIAmusj9B33ExJNetE8C9fEE1RJZG9gc7uQ
 zBuBGF/C7H0N+9VW7V8pVhG7UqtqZI83mF+pASeNxJK+LkYzP7y06vA0xVoVyWnVOgzH
 e8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kVj8xiNy7P+impZo0PATu9zmL7PfKEv61GKapK4HB3M=;
 b=PFYgKiAyoat/rx2ja9pNZFCtmRDTosZ+GCjvzVcSixZfZb5Z32M7oKcPD8vmbyKvb/
 PpdTj6sS07xpoZz0lmPgSP9tX16sVJnOBabdbHSjwhHhai97dV/5nwQ2wdYwxzw4TfdQ
 kXh/sLsnehg3moc3orRH23UATwun2LGYVgsSzzpMjLzHAaQAtFdbOznxy3UZs+o5Vm41
 uufdcbZhMCImPITWs027NVi/g5hocjci1t+gtI0Jo6RCQ7se/Qvi6O2OxdE0pMNa9x4R
 EZB6v7LMMU7LTE+J3Oq2cIbn9CpCmPOrusNPwQijZvYbcMD1IQOa8PPyISfH9hRXe0La
 Kcrw==
X-Gm-Message-State: APjAAAXe3rxkuH6HfQm7bM6gaIDb8t9E6PMHrBJ5wGZhLRfzuj+z86gI
 OsBjPt3htfR2e9dTC30TJGLkXiDrVSOnrw==
X-Google-Smtp-Source: APXvYqyrTvJxaFQ4V9KyXYLkW+WuW/Fpa6jxejFBRmsdMHkhctjVLCTihkQuNafdYzCpWLZWhDMqtA==
X-Received: by 2002:a5d:628e:: with SMTP id k14mr5318873wru.425.1582907957592; 
 Fri, 28 Feb 2020 08:39:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/33] target/arm: Implement v8.4-RCPC
Date: Fri, 28 Feb 2020 16:38:38 +0000
Message-Id: <20200228163840.23585-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

The v8.4-RCPC extension implements some new instructions:
 * LDAPUR, LDAPURB, LDAPURH, LDAPRSB, LDAPRSH, LDAPRSW
 * STLUR, STLURB, STLURH

These are all in a new subgroup of encodings that sits below the
top-level "Loads and Stores" group in the Arm ARM.

The STLUR* instructions have standard store-release semantics; the
LDAPUR* have Load-AcquirePC semantics, but (as with LDAPR*) we choose
to implement them as the slightly stronger Load-Acquire.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200224172846.13053-4-peter.maydell@linaro.org
---
 target/arm/cpu.h           |  5 +++
 linux-user/elfload.c       |  1 +
 target/arm/cpu64.c         |  2 +-
 target/arm/translate-a64.c | 90 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ff30985ead4..ce1e2a090e5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3779,6 +3779,11 @@ static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
 }
 
+static inline bool isar_feature_aa64_rcpc_8_4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) >= 2;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d76b828a789..db748c58775 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -662,6 +662,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
     GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
     GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
+    GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
 
     return hwcaps;
 }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 18c7b40f98c..b842e2b664a 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -654,7 +654,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 1);
-        t = FIELD_DP64(t, ID_AA64ISAR1, LRCPC, 1); /* ARMv8.3-RCPC */
+        t = FIELD_DP64(t, ID_AA64ISAR1, LRCPC, 2); /* ARMv8.4-RCPC */
         cpu->isar.id_aa64isar1 = t;
 
         t = cpu->isar.id_aa64pfr0;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7a066fb7cb2..579180af0a9 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3283,6 +3283,88 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
     }
 }
 
+/*
+ * LDAPR/STLR (unscaled immediate)
+ *
+ *  31  30            24    22  21       12    10    5     0
+ * +------+-------------+-----+---+--------+-----+----+-----+
+ * | size | 0 1 1 0 0 1 | opc | 0 |  imm9  | 0 0 | Rn |  Rt |
+ * +------+-------------+-----+---+--------+-----+----+-----+
+ *
+ * Rt: source or destination register
+ * Rn: base register
+ * imm9: unscaled immediate offset
+ * opc: 00: STLUR*, 01/10/11: various LDAPUR*
+ * size: size of load/store
+ */
+static void disas_ldst_ldapr_stlr(DisasContext *s, uint32_t insn)
+{
+    int rt = extract32(insn, 0, 5);
+    int rn = extract32(insn, 5, 5);
+    int offset = sextract32(insn, 12, 9);
+    int opc = extract32(insn, 22, 2);
+    int size = extract32(insn, 30, 2);
+    TCGv_i64 clean_addr, dirty_addr;
+    bool is_store = false;
+    bool is_signed = false;
+    bool extend = false;
+    bool iss_sf;
+
+    if (!dc_isar_feature(aa64_rcpc_8_4, s)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    switch (opc) {
+    case 0: /* STLURB */
+        is_store = true;
+        break;
+    case 1: /* LDAPUR* */
+        break;
+    case 2: /* LDAPURS* 64-bit variant */
+        if (size == 3) {
+            unallocated_encoding(s);
+            return;
+        }
+        is_signed = true;
+        break;
+    case 3: /* LDAPURS* 32-bit variant */
+        if (size > 1) {
+            unallocated_encoding(s);
+            return;
+        }
+        is_signed = true;
+        extend = true; /* zero-extend 32->64 after signed load */
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    iss_sf = disas_ldst_compute_iss_sf(size, is_signed, opc);
+
+    if (rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+
+    dirty_addr = read_cpu_reg_sp(s, rn, 1);
+    tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
+    clean_addr = clean_data_tbi(s, dirty_addr);
+
+    if (is_store) {
+        /* Store-Release semantics */
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+        do_gpr_st(s, cpu_reg(s, rt), clean_addr, size, true, rt, iss_sf, true);
+    } else {
+        /*
+         * Load-AcquirePC semantics; we implement as the slightly more
+         * restrictive Load-Acquire.
+         */
+        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, size, is_signed, extend,
+                  true, rt, iss_sf, true);
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    }
+}
+
 /* Load/store register (all forms) */
 static void disas_ldst_reg(DisasContext *s, uint32_t insn)
 {
@@ -3634,6 +3716,14 @@ static void disas_ldst(DisasContext *s, uint32_t insn)
     case 0x0d: /* AdvSIMD load/store single structure */
         disas_ldst_single_struct(s, insn);
         break;
+    case 0x19: /* LDAPR/STLR (unscaled immediate) */
+        if (extract32(insn, 10, 2) != 0 ||
+            extract32(insn, 21, 1) != 0) {
+            unallocated_encoding(s);
+            break;
+        }
+        disas_ldst_ldapr_stlr(s, insn);
+        break;
     default:
         unallocated_encoding(s);
         break;
-- 
2.20.1


