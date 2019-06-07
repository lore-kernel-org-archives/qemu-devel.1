Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA39C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1714E2080C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1714E2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48526 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCuT-00078g-9D
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59467)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hZBl5-0003pJ-92
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hZBl3-000888-2e
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:06:03 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50154 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hZBl1-0007uz-0O
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:06:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id E90FF1A1DF2;
 Fri,  7 Jun 2019 12:05:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id CB8C51A1CFA;
 Fri,  7 Jun 2019 12:05:49 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 12:05:35 +0200
Message-Id: <1559901944-4578-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559901944-4578-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559901944-4578-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 01/10] target/mips: Fix space-related format
 issues in msa_helper.c
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix space-related format issues reported by checkpatch in file
msa_helper.c.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1559838440-9866-2-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/msa_helper.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index f6e16c2..eacb5a4 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -360,16 +360,16 @@ static inline int64_t msa_binsr_df(uint32_t df, int64_t dest, int64_t arg1,
 
 static inline int64_t msa_sat_s_df(uint32_t df, int64_t arg, uint32_t m)
 {
-    return arg < M_MIN_INT(m+1) ? M_MIN_INT(m+1) :
-                                  arg > M_MAX_INT(m+1) ? M_MAX_INT(m+1) :
-                                                         arg;
+    return arg < M_MIN_INT(m + 1) ? M_MIN_INT(m + 1) :
+                                    arg > M_MAX_INT(m + 1) ? M_MAX_INT(m + 1) :
+                                                             arg;
 }
 
 static inline int64_t msa_sat_u_df(uint32_t df, int64_t arg, uint32_t m)
 {
     uint64_t u_arg = UNSIGNED(arg, df);
-    return  u_arg < M_MAX_UINT(m+1) ? u_arg :
-                                      M_MAX_UINT(m+1);
+    return  u_arg < M_MAX_UINT(m + 1) ? u_arg :
+                                        M_MAX_UINT(m + 1);
 }
 
 static inline int64_t msa_srar_df(uint32_t df, int64_t arg1, int64_t arg2)
@@ -668,16 +668,16 @@ static inline int64_t msa_mod_u_df(uint32_t df, int64_t arg1, int64_t arg2)
 }
 
 #define SIGNED_EVEN(a, df) \
-        ((((int64_t)(a)) << (64 - DF_BITS(df)/2)) >> (64 - DF_BITS(df)/2))
+        ((((int64_t)(a)) << (64 - DF_BITS(df) / 2)) >> (64 - DF_BITS(df) / 2))
 
 #define UNSIGNED_EVEN(a, df) \
-        ((((uint64_t)(a)) << (64 - DF_BITS(df)/2)) >> (64 - DF_BITS(df)/2))
+        ((((uint64_t)(a)) << (64 - DF_BITS(df) / 2)) >> (64 - DF_BITS(df) / 2))
 
 #define SIGNED_ODD(a, df) \
-        ((((int64_t)(a)) << (64 - DF_BITS(df))) >> (64 - DF_BITS(df)/2))
+        ((((int64_t)(a)) << (64 - DF_BITS(df))) >> (64 - DF_BITS(df) / 2))
 
 #define UNSIGNED_ODD(a, df) \
-        ((((uint64_t)(a)) << (64 - DF_BITS(df))) >> (64 - DF_BITS(df)/2))
+        ((((uint64_t)(a)) << (64 - DF_BITS(df))) >> (64 - DF_BITS(df) / 2))
 
 #define SIGNED_EXTRACT(e, o, a, df)     \
     do {                                \
@@ -1205,13 +1205,13 @@ void helper_msa_##FUNC(CPUMIPSState *env, uint32_t df, uint32_t wd, \
             (DF_ELEMENTS(DF) / 2)
 
 #define Rb(pwr, i) (pwr->b[i])
-#define Lb(pwr, i) (pwr->b[i + DF_ELEMENTS(DF_BYTE)/2])
+#define Lb(pwr, i) (pwr->b[i + DF_ELEMENTS(DF_BYTE) / 2])
 #define Rh(pwr, i) (pwr->h[i])
-#define Lh(pwr, i) (pwr->h[i + DF_ELEMENTS(DF_HALF)/2])
+#define Lh(pwr, i) (pwr->h[i + DF_ELEMENTS(DF_HALF) / 2])
 #define Rw(pwr, i) (pwr->w[i])
-#define Lw(pwr, i) (pwr->w[i + DF_ELEMENTS(DF_WORD)/2])
+#define Lw(pwr, i) (pwr->w[i + DF_ELEMENTS(DF_WORD) / 2])
 #define Rd(pwr, i) (pwr->d[i])
-#define Ld(pwr, i) (pwr->d[i + DF_ELEMENTS(DF_DOUBLE)/2])
+#define Ld(pwr, i) (pwr->d[i + DF_ELEMENTS(DF_DOUBLE) / 2])
 
 #undef MSA_LOOP_COND
 
@@ -3320,7 +3320,7 @@ void helper_msa_fmax_a_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 void helper_msa_fclass_df(CPUMIPSState *env, uint32_t df,
         uint32_t wd, uint32_t ws)
 {
-    float_status* status = &env->active_tc.msa_fp_status;
+    float_status *status = &env->active_tc.msa_fp_status;
 
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
-- 
2.7.4


