Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475ECC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19FA9208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FA9208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopWd-0005Xe-GU
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iootH-0001QW-QF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iootG-0003NG-BO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:23 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:58475)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iootG-0003Mi-28
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:22 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1HqM-1irZmP3KaQ-002p4r; Tue, 07 Jan 2020 14:27:19 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] target/m68k: only change valid bits in CACR
Date: Tue,  7 Jan 2020 14:27:15 +0100
Message-Id: <20200107132715.722101-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107132715.722101-1-laurent@vivier.eu>
References: <20200107132715.722101-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xfELSbcbZwG8HdqIRr4st/peBT4HWSZ9RYZNHFq8L5Gsfcn4RGx
 NaJ43g3WbzBz2sbvngwHcaVT19bxeO3FyoCrZlEBitms19MjZtkvkQ7a2nfBlFi9qhSRmH7
 EU3J7lOH/idcxTbU/1vEIuvdLA7JSbDKx5+JycpE4i3Bu14KS9cSObBZfjxTd7n/Hl6BNp1
 7czmPfT7t1OVZgPWIkSDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MaTsPoU9Xu8=:Ude4iFeLzsCNL6zDKyYk0u
 bPy2q7N/sLApulwz+Hm11qTMrSGcU9s+dlqBOurRlqW2dz1UtA8iAZT7Gx9PTdANui4yqfUXt
 gZW8/pNTl13Wvez4PCYUlhPVgjsbH6EoNjfR2BixOMUYFaur4DaMeaLdfMYFYG7Ib5VZhCwDx
 ElNtTXeLUbTAB3SFwCTRnMTWpXFSkyx6a+cwf7dcJk9EKpf4CMCY1nzO1Z/5a+izpRMREVf41
 DQV516XzkQYRxAhqYmVd91skfSFVxY3MBOSICt1L/kzLstxj+vH42p5lyDTQbfVQO4ygYUHDV
 O9mkl06v9ioLiPPC61NeFBLtGPS84UMeqock4ZsdwKIdXATa1u9dxQumMhDGOBBsTmS/M6mkw
 OIL2eBTD4HpH9wid/Z4cbIRA9iOMJz3VcXCxi6xRPyjzJyIugyEGwsJysRAG2XHLngfUatDZ5
 2oHEs/P5QaLBw2IjLWtWy4xOnbJa+Di0BsXNi2Gce7ntpIFT1y6bDYU3GAMDlQpRcHslm9jDn
 jmhb/IbCaV7AIGa/o/L4UlzOlkbsUrjAZrqqkaRTEWy1Q5XzkbQ1MXuo69M/uQ1Z8s+g1NWRN
 +eIH2GP6ExlvVbnxcKzzMtpYhHaVCPMK8IKnBscMHcpOfZpvPZ0OWqPexEPHexjc6rGhwtXkr
 hfUXKEnofV73Jzs1gl/oYfmLiE30bMwf20GdyLj/8JZ1HDfhpWtNLb/erOGeomjFLEwCJiFGT
 FZgg3nEQUv0IPqaZHIl+S5kM+zPJR7gmP2pS/1fNyUDTsPY5c1KrCH1nOARcVdvMB1+/j58Lw
 iZdl3Z3n6DgtFqIhGUDFm37QjtheaYF8mfeoBxIWs47YWpcVjQne6LKR2kb03ObickdMlo/QC
 wn2QsZdjnz/cv7iR+SsA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is used by netBSD (and MacOS ROM) to detect the MMU type

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20191220172415.35838-1-laurent@vivier.eu>
[lv: add a comment before m680x0_cpu_common()]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.c    | 28 ++++++++++++++++++++++------
 target/m68k/cpu.h    |  5 ++++-
 target/m68k/helper.c | 12 ++++++++++--
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index e6596de29c..f276335faf 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -114,11 +114,9 @@ static void m68000_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_MOVEP);
 }
 
-static void m68020_cpu_initfn(Object *obj)
+/* common features for 68020, 68030 and 68040 */
+static void m680x0_cpu_common(CPUM68KState *env)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
-
     m68k_set_feature(env, M68K_FEATURE_M68000);
     m68k_set_feature(env, M68K_FEATURE_USP);
     m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
@@ -136,14 +134,31 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_CHK2);
     m68k_set_feature(env, M68K_FEATURE_MOVEP);
 }
-#define m68030_cpu_initfn m68020_cpu_initfn
+
+static void m68020_cpu_initfn(Object *obj)
+{
+    M68kCPU *cpu = M68K_CPU(obj);
+    CPUM68KState *env = &cpu->env;
+
+    m680x0_cpu_common(env);
+    m68k_set_feature(env, M68K_FEATURE_M68020);
+}
+
+static void m68030_cpu_initfn(Object *obj)
+{
+    M68kCPU *cpu = M68K_CPU(obj);
+    CPUM68KState *env = &cpu->env;
+
+    m680x0_cpu_common(env);
+    m68k_set_feature(env, M68K_FEATURE_M68030);
+}
 
 static void m68040_cpu_initfn(Object *obj)
 {
     M68kCPU *cpu = M68K_CPU(obj);
     CPUM68KState *env = &cpu->env;
 
-    m68020_cpu_initfn(obj);
+    m680x0_cpu_common(env);
     m68k_set_feature(env, M68K_FEATURE_M68040);
 }
 
@@ -166,6 +181,7 @@ static void m68060_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_BKPT);
     m68k_set_feature(env, M68K_FEATURE_RTD);
     m68k_set_feature(env, M68K_FEATURE_CHK2);
+    m68k_set_feature(env, M68K_FEATURE_M68060);
 }
 
 static void m5208_cpu_initfn(Object *obj)
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 20de3c379a..11c71fa962 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -460,6 +460,10 @@ void do_m68k_semihosting(CPUM68KState *env, int nr);
 
 enum m68k_features {
     M68K_FEATURE_M68000,
+    M68K_FEATURE_M68020,
+    M68K_FEATURE_M68030,
+    M68K_FEATURE_M68040,
+    M68K_FEATURE_M68060,
     M68K_FEATURE_CF_ISA_A,
     M68K_FEATURE_CF_ISA_B, /* (ISA B or C).  */
     M68K_FEATURE_CF_ISA_APLUSC, /* BIT/BITREV, FF1, STRLDSR (ISA A+ or C).  */
@@ -481,7 +485,6 @@ enum m68k_features {
     M68K_FEATURE_BKPT,
     M68K_FEATURE_RTD,
     M68K_FEATURE_CHK2,
-    M68K_FEATURE_M68040, /* instructions specific to MC68040 */
     M68K_FEATURE_MOVEP,
 };
 
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index ae766a6cb0..baf7729af0 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -203,9 +203,17 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
     case M68K_CR_VBR:
         env->vbr = val;
         return;
-    /* MC680[234]0 */
+    /* MC680[2346]0 */
     case M68K_CR_CACR:
-        env->cacr = val;
+        if (m68k_feature(env, M68K_FEATURE_M68020)) {
+            env->cacr = val & 0x0000000f;
+        } else if (m68k_feature(env, M68K_FEATURE_M68030)) {
+            env->cacr = val & 0x00003f1f;
+        } else if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->cacr = val & 0x80008000;
+        } else if (m68k_feature(env, M68K_FEATURE_M68060)) {
+            env->cacr = val & 0xf8e0e000;
+        }
         m68k_switch_sp(env);
         return;
     /* MC680[34]0 */
-- 
2.24.1


