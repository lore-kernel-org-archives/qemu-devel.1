Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D82CC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A6820842
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVIrv8KN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A6820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1bSw-0005er-7P
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 14:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1bQZ-00038D-1W
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1bQX-000275-Ln
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:42:34 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1bQX-000257-Fr
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:42:33 -0500
Received: by mail-pf1-x443.google.com with SMTP id k29so5985470pfp.13
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 11:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cuIlZvUXMnVPxJ3FgP3jCwxFvB2IJPIWn75y+XC+HB0=;
 b=kVIrv8KNznyyr35Wb8dBxsS5No5cIV2FxJPS4OBmMFTW+0waDjoNPNdjdaox9rznOO
 Nw40AsEZmj6q7PaEL8byPVWhzBCcg/51IaPOKwGSgaxlkM4Jf4o2JlhJ6QreMNcOaLzV
 aHPBQy538pz7u+u4nattRixtiLcholEoQBMd1C52Q+khjZnwiKFQi3NGL1LRQQ1eSTlJ
 azAVcoJQRxpP7+RtyUhkXvOij2KRSx4J4G7MUGUJktmLxEEqWfkBatMpJTIGRcPUwB0/
 vgYf9PYFTxQBR3SH26Mb12zZEaEbR3Y2feyluEKOOtKobGDxNkInP13yzdEk6mHGr7NJ
 4Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cuIlZvUXMnVPxJ3FgP3jCwxFvB2IJPIWn75y+XC+HB0=;
 b=i4qC9IsDu3PcjIueYWQ3Sv0APDSroPbtTNUkWJK3WmSr4nL1PNrB1tOhC0IPowYxJG
 RPO1K+mHQpwD7bXwQbDyyol5RrWOD3jd6gVZtZDD8FR9FzWFa5uzCN9yV9ZrlwlxqTiT
 xVDYI9jtTFrblSneR9rd9mUjhK1MEQx4SrKWC6ApBTTt0jvRp1/rFh0gJ7ldP9bcbuf1
 rFmt6tHCjv3SkGREVqbSjJdRSfZiieeqduJHhC14GPGWSYweq9zJYWrImcyH4NteTEK3
 JtYD+tt6MHeui1Xhsde/3f226N+y+wYJ26Qhp3KPwmnf7bgMgz0wZzqkDCvSHFW0NO6K
 ua7g==
X-Gm-Message-State: APjAAAV026J7vm89cH5RAOiuJrQ/qhGp+nPh+5dV22mpfVKqnYkx0yzS
 t7ESeZqOThQLkoJGmbgNv/ZHiQAZS8A=
X-Google-Smtp-Source: APXvYqztrVHkJawv27iuRxx0N+94cQKYfeOk6Qfj9Ssc0J/KNCcgph2bzEtypZXv6mr2Q64ukYRmvg==
X-Received: by 2002:aa7:96b0:: with SMTP id g16mr4461787pfk.99.1581450152039; 
 Tue, 11 Feb 2020 11:42:32 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id b18sm5306281pfd.63.2020.02.11.11.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 11:42:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] target/arm: Split out aa64_va_parameter_tbi,
 aa64_va_parameter_tbid
Date: Tue, 11 Feb 2020 11:42:28 -0800
Message-Id: <20200211194228.16907-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211194228.16907-1-richard.henderson@linaro.org>
References: <20200211194228.16907-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For the purpose of rebuild_hflags_a64, we do not need to compute
all of the va parameters, only tbi.  Moreover, we can compute them
in a form that is more useful to storing in hflags.

This eliminates the need for aa64_va_parameter_both, so fold that
in to aa64_va_parameter.  The remaining calls to aa64_va_parameter
are in get_phys_addr_lpae and in pauth_helper.c.

This reduces the total cpu consumption of aa64_va_parameter in a
kernel boot plus a kvm guest kernel boot from 3% to 0.5%.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  3 --
 target/arm/helper.c    | 68 +++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6d4a942bde..6ac84bbca7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1042,15 +1042,12 @@ typedef struct ARMVAParameters {
     unsigned tsz    : 8;
     unsigned select : 1;
     bool tbi        : 1;
-    bool tbid       : 1;
     bool epd        : 1;
     bool hpd        : 1;
     bool using16k   : 1;
     bool using64k   : 1;
 } ARMVAParameters;
 
-ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
-                                        ARMMMUIdx mmu_idx);
 ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a008c70c87..9ebd7e9459 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10067,12 +10067,34 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
-                                        ARMMMUIdx mmu_idx)
+static int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx)
+{
+    if (regime_has_2_ranges(mmu_idx)) {
+        return extract64(tcr, 37, 2);
+    } else if (mmu_idx == ARMMMUIdx_Stage2) {
+        return 0; /* VTCR_EL2 */
+    } else {
+        return extract32(tcr, 20, 1);
+    }
+}
+
+static int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx)
+{
+    if (regime_has_2_ranges(mmu_idx)) {
+        return extract64(tcr, 51, 2);
+    } else if (mmu_idx == ARMMMUIdx_Stage2) {
+        return 0; /* VTCR_EL2 */
+    } else {
+        return extract32(tcr, 29, 1);
+    }
+}
+
+ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
+                                   ARMMMUIdx mmu_idx, bool data)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
-    bool tbi, tbid, epd, hpd, using16k, using64k;
-    int select, tsz;
+    bool epd, hpd, using16k, using64k;
+    int select, tsz, tbi;
 
     if (!regime_has_2_ranges(mmu_idx)) {
         select = 0;
@@ -10081,11 +10103,9 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         using16k = extract32(tcr, 15, 1);
         if (mmu_idx == ARMMMUIdx_Stage2) {
             /* VTCR_EL2 */
-            tbi = tbid = hpd = false;
+            hpd = false;
         } else {
-            tbi = extract32(tcr, 20, 1);
             hpd = extract32(tcr, 24, 1);
-            tbid = extract32(tcr, 29, 1);
         }
         epd = false;
     } else {
@@ -10099,28 +10119,30 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
             epd = extract32(tcr, 7, 1);
             using64k = extract32(tcr, 14, 1);
             using16k = extract32(tcr, 15, 1);
-            tbi = extract64(tcr, 37, 1);
             hpd = extract64(tcr, 41, 1);
-            tbid = extract64(tcr, 51, 1);
         } else {
             int tg = extract32(tcr, 30, 2);
             using16k = tg == 1;
             using64k = tg == 3;
             tsz = extract32(tcr, 16, 6);
             epd = extract32(tcr, 23, 1);
-            tbi = extract64(tcr, 38, 1);
             hpd = extract64(tcr, 42, 1);
-            tbid = extract64(tcr, 52, 1);
         }
     }
     tsz = MIN(tsz, 39);  /* TODO: ARMv8.4-TTST */
     tsz = MAX(tsz, 16);  /* TODO: ARMv8.2-LVA  */
 
+    /* Present TBI as a composite with TBID.  */
+    tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
+    if (!data) {
+        tbi &= ~aa64_va_parameter_tbid(tcr, mmu_idx);
+    }
+    tbi = (tbi >> select) & 1;
+
     return (ARMVAParameters) {
         .tsz = tsz,
         .select = select,
         .tbi = tbi,
-        .tbid = tbid,
         .epd = epd,
         .hpd = hpd,
         .using16k = using16k,
@@ -10128,16 +10150,6 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
     };
 }
 
-ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
-                                   ARMMMUIdx mmu_idx, bool data)
-{
-    ARMVAParameters ret = aa64_va_parameters_both(env, va, mmu_idx);
-
-    /* Present TBI as a composite with TBID.  */
-    ret.tbi &= (data || !ret.tbid);
-    return ret;
-}
-
 #ifndef CONFIG_USER_ONLY
 static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
                                           ARMMMUIdx mmu_idx)
@@ -11957,21 +11969,15 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 {
     uint32_t flags = rebuild_hflags_aprofile(env);
     ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
-    ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
+    uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
     uint64_t sctlr;
     int tbii, tbid;
 
     flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
 
     /* Get control bits for tagged addresses.  */
-    if (regime_has_2_ranges(mmu_idx)) {
-        ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
-        tbid = (p1.tbi << 1) | p0.tbi;
-        tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
-    } else {
-        tbid = p0.tbi;
-        tbii = tbid & !p0.tbid;
-    }
+    tbid = aa64_va_parameter_tbi(tcr, mmu_idx);
+    tbii = tbid & ~aa64_va_parameter_tbid(tcr, mmu_idx);
 
     flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
     flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
-- 
2.20.1


