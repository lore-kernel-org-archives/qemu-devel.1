Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C9CC47247
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5838206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StccK8ZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5838206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaKX-0005Kx-03
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHh-0008HX-Tj
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHg-0000mB-Eg
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id x25so8239338wmc.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QEJ0w710SIt08fa3FWIfG3Dv/CaK6JOkbM4j68/oS7U=;
 b=StccK8ZSLV0TOx2OSw0UfbVy+meHcbMH9RTrQlJBnd++7BQEKG/83WNow4oViSshmc
 HIuga8oBekmBo7wsS3WauOXWgQRVJPO8Ftq3/mb14BsblrsO5NBftaXEigQsfXD/omi2
 e9ohoUjEe+zrPx93I2Uq4Wh9ZkBFhMV++avOyB7OuygV1C3cUTKx+AN1xhaOg2Qh/3Ns
 JzpJZKkOuQr1E0LjPiXsACB+J9hW+RXP+/3HSycC67r4ub3kOZmHiqh5kCNB9rCzUiJb
 eYXl91bsdpYKMcoatsuIA/zouK6YjQe7Sk3mW4ZgHJmjT60Vttqk+6Y4WuDW5EINZ+9w
 0zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QEJ0w710SIt08fa3FWIfG3Dv/CaK6JOkbM4j68/oS7U=;
 b=ODm1KBoc80YiyIAVk9Gpkpi4fTmfW+0O2vx1ieRwUEgeDpLlMjO9V4mOsmnJgrt/7I
 tMSDd7G9SI+W8JiVuMHpyxDoIkEvkKTyPIDSNhdsu9huCuDuMedybmkU7aqpWDsWeLxG
 TnigrDCXuFsSKJtSJb3BbXA0CLW22bXE435eOrX+BQAcPKzN72n0fGBWtc6zDZjXiJbc
 gJEisEO7lmaJJs9CRiUePc54tWBqsN1kiDbktNy0nV2llpJZO3Dfs+/Md7FLZPFKIvsT
 Ncfqq8/WPDlxdJotLj8zkUtBtsK1Nu1b74NPNZr+Sot6UvA843B8swRac37LrJnhd08v
 Aprg==
X-Gm-Message-State: AGi0PubGCm14228/RYpuFNOC7bq9rpNXoymKTzkIE9roJCd/u60THndo
 6qDJkYqHoErqppdYTr+SZpoK/pZZLGl79A==
X-Google-Smtp-Source: APiQypI2ewI8QW8yD0/G6x2UUI4RKW7kmN9CQDdP5XUIbhIAYGAylAKTmhUristag0hQpgouADLCBw==
X-Received: by 2002:a1c:2dc7:: with SMTP id
 t190mr13777234wmt.129.1588595598688; 
 Mon, 04 May 2020 05:33:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/39] target/arm: Implement ARMv8.2-TTS2UXN
Date: Mon,  4 May 2020 13:32:36 +0100
Message-Id: <20200504123309.3808-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ARMv8.2-TTS2UXN feature extends the XN field in stage 2
translation table descriptors from just bit [54] to bits [54:53],
allowing stage 2 to control execution permissions separately for EL0
and EL1. Implement the new semantics of the XN field and enable
the feature for our 'max' CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200330210400.11724-5-peter.maydell@linaro.org
---
 target/arm/cpu.h    | 15 +++++++++++++++
 target/arm/cpu.c    |  1 +
 target/arm/cpu64.c  |  2 ++
 target/arm/helper.c | 37 +++++++++++++++++++++++++++++++------
 4 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fe03a74bf08..9aae324d0f6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3610,6 +3610,11 @@ static inline bool isar_feature_aa32_ccidx(const ARMISARegisters *id)
     return FIELD_EX32(id->id_mmfr4, ID_MMFR4, CCIDX) != 0;
 }
 
+static inline bool isar_feature_aa32_tts2uxn(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, XNX) != 0;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
@@ -3822,6 +3827,11 @@ static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
 }
 
+static inline bool isar_feature_aa64_tts2uxn(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, XNX) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
@@ -3850,6 +3860,11 @@ static inline bool isar_feature_any_ccidx(const ARMISARegisters *id)
     return isar_feature_aa64_ccidx(id) || isar_feature_aa32_ccidx(id);
 }
 
+static inline bool isar_feature_any_tts2uxn(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_tts2uxn(id) || isar_feature_aa32_tts2uxn(id);
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 141d947775a..f588344df83 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2686,6 +2686,7 @@ static void arm_max_initfn(Object *obj)
             t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
             t = FIELD_DP32(t, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
             t = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
+            t = FIELD_DP32(t, ID_MMFR4, XNX, 1); /* TTS2UXN */
             cpu->isar.id_mmfr4 = t;
         }
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 74afc28d537..e232c0ea12c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -673,6 +673,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
         t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
         t = FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* VMID16 */
+        t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1); /* TTS2UXN */
         cpu->isar.id_aa64mmfr1 = t;
 
         t = cpu->isar.id_aa64mmfr2;
@@ -706,6 +707,7 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_MMFR4, HPDS, 1); /* AA32HPD */
         u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
         u = FIELD_DP32(u, ID_MMFR4, CNP, 1); /* TTCNP */
+        u = FIELD_DP32(u, ID_MMFR4, XNX, 1); /* TTS2UXN */
         cpu->isar.id_mmfr4 = u;
 
         u = cpu->isar.id_aa64dfr0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b26f5801943..a94f6507950 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9908,9 +9908,10 @@ simple_ap_to_rw_prot(CPUARMState *env, ARMMMUIdx mmu_idx, int ap)
  *
  * @env:     CPUARMState
  * @s2ap:    The 2-bit stage2 access permissions (S2AP)
- * @xn:      XN (execute-never) bit
+ * @xn:      XN (execute-never) bits
+ * @s1_is_el0: true if this is S2 of an S1+2 walk for EL0
  */
-static int get_S2prot(CPUARMState *env, int s2ap, int xn)
+static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
 {
     int prot = 0;
 
@@ -9920,9 +9921,32 @@ static int get_S2prot(CPUARMState *env, int s2ap, int xn)
     if (s2ap & 2) {
         prot |= PAGE_WRITE;
     }
-    if (!xn) {
-        if (arm_el_is_aa64(env, 2) || prot & PAGE_READ) {
+
+    if (cpu_isar_feature(any_tts2uxn, env_archcpu(env))) {
+        switch (xn) {
+        case 0:
             prot |= PAGE_EXEC;
+            break;
+        case 1:
+            if (s1_is_el0) {
+                prot |= PAGE_EXEC;
+            }
+            break;
+        case 2:
+            break;
+        case 3:
+            if (!s1_is_el0) {
+                prot |= PAGE_EXEC;
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        if (!extract32(xn, 1, 1)) {
+            if (arm_el_is_aa64(env, 2) || prot & PAGE_READ) {
+                prot |= PAGE_EXEC;
+            }
         }
     }
     return prot;
@@ -10901,13 +10925,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     }
 
     ap = extract32(attrs, 4, 2);
-    xn = extract32(attrs, 12, 1);
 
     if (mmu_idx == ARMMMUIdx_Stage2) {
         ns = true;
-        *prot = get_S2prot(env, ap, xn);
+        xn = extract32(attrs, 11, 2);
+        *prot = get_S2prot(env, ap, xn, s1_is_el0);
     } else {
         ns = extract32(attrs, 3, 1);
+        xn = extract32(attrs, 12, 1);
         pxn = extract32(attrs, 11, 1);
         *prot = get_S1prot(env, mmu_idx, aarch64, ap, ns, xn, pxn);
     }
-- 
2.20.1


