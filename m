Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6495C282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FE621773
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FE621773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hItfl-0002r2-Nk
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 07:33:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItdb-0001e1-Ti
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItda-0005YI-FH
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:59 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45019 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hItda-0005WP-3V
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 8A4DA1A2460;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 5FC951A2447;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 13:29:39 +0200
Message-Id: <1556018982-3715-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 5/8] target/mips: Clean up dsp_helper.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423112939.TwdWfDuzYlAqdvNx282z0_Un1QhNWQK6Rbqe-k3t9yY@z>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove several minor checkpatch warnings and errors.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/dsp_helper.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/target/mips/dsp_helper.c b/target/mips/dsp_helper.c
index 739b69d..8c58eeb 100644
--- a/target/mips/dsp_helper.c
+++ b/target/mips/dsp_helper.c
@@ -22,8 +22,10 @@
 #include "exec/helper-proto.h"
 #include "qemu/bitops.h"
 
-/* As the byte ordering doesn't matter, i.e. all columns are treated
-   identically, these unions can be used directly.  */
+/*
+ * As the byte ordering doesn't matter, i.e. all columns are treated
+ * identically, these unions can be used directly.
+ */
 typedef union {
     uint8_t  ub[4];
     int8_t   sb[4];
@@ -1445,9 +1447,15 @@ target_ulong helper_precr_ob_qh(target_ulong rs, target_ulong rt)
     return temp;
 }
 
-#define PRECR_QH_PW(name, var) \
-target_ulong helper_precr_##name##_qh_pw(target_ulong rs, target_ulong rt, \
-                                    uint32_t sa)                      \
+
+/*
+ * In case sa == 0, use rt2, rt0, rs2, rs0.
+ * In case sa != 0, use rt3, rt1, rs3, rs1.
+ */
+#define PRECR_QH_PW(name, var)                                        \
+target_ulong helper_precr_##name##_qh_pw(target_ulong rs,             \
+                                         target_ulong rt,             \
+                                         uint32_t sa)                 \
 {                                                                     \
     uint16_t rs3, rs2, rs1, rs0;                                      \
     uint16_t rt3, rt2, rt1, rt0;                                      \
@@ -1456,8 +1464,6 @@ target_ulong helper_precr_##name##_qh_pw(target_ulong rs, target_ulong rt, \
     MIPSDSP_SPLIT64_16(rs, rs3, rs2, rs1, rs0);                       \
     MIPSDSP_SPLIT64_16(rt, rt3, rt2, rt1, rt0);                       \
                                                                       \
-    /* When sa = 0, we use rt2, rt0, rs2, rs0;                        \
-     * when sa != 0, we use rt3, rt1, rs3, rs1. */                    \
     if (sa == 0) {                                                    \
         tempD = rt2 << var;                                           \
         tempC = rt0 << var;                                           \
@@ -1965,7 +1971,8 @@ SHIFT_PH(shra_r, rnd16_rashift);
 #undef SHIFT_PH
 
 /** DSP Multiply Sub-class insns **/
-/* Return value made up by two 16bits value.
+/*
+ * Return value made up by two 16bits value.
  * FIXME give the macro a better name.
  */
 #define MUL_RETURN32_16_PH(name, func, \
@@ -3274,11 +3281,15 @@ target_ulong helper_dextr_l(target_ulong ac, target_ulong shift,
                             CPUMIPSState *env)
 {
     uint64_t temp[3];
+    target_ulong ret;
 
     shift = shift & 0x3F;
 
     mipsdsp_rndrashift_acc(temp, ac, shift, env);
-    return (temp[1] << 63) | (temp[0] >> 1);
+
+    ret = (temp[1] << 63) | (temp[0] >> 1);
+
+    return ret;
 }
 
 target_ulong helper_dextr_r_l(target_ulong ac, target_ulong shift,
@@ -3286,6 +3297,7 @@ target_ulong helper_dextr_r_l(target_ulong ac, target_ulong shift,
 {
     uint64_t temp[3];
     uint32_t temp128;
+    target_ulong ret;
 
     shift = shift & 0x3F;
     mipsdsp_rndrashift_acc(temp, ac, shift, env);
@@ -3305,7 +3317,9 @@ target_ulong helper_dextr_r_l(target_ulong ac, target_ulong shift,
         set_DSPControl_overflow_flag(1, 23, env);
     }
 
-    return (temp[1] << 63) | (temp[0] >> 1);
+    ret = (temp[1] << 63) | (temp[0] >> 1);
+
+    return ret;
 }
 
 target_ulong helper_dextr_rs_l(target_ulong ac, target_ulong shift,
@@ -3313,6 +3327,7 @@ target_ulong helper_dextr_rs_l(target_ulong ac, target_ulong shift,
 {
     uint64_t temp[3];
     uint32_t temp128;
+    target_ulong ret;
 
     shift = shift & 0x3F;
     mipsdsp_rndrashift_acc(temp, ac, shift, env);
@@ -3338,7 +3353,10 @@ target_ulong helper_dextr_rs_l(target_ulong ac, target_ulong shift,
         }
         set_DSPControl_overflow_flag(1, 23, env);
     }
-    return (temp[1] << 63) | (temp[0] >> 1);
+
+    ret = (temp[1] << 63) | (temp[0] >> 1);
+
+    return ret;
 }
 #endif
 
-- 
2.7.4


