Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0FEC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B79020644
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="LERcHrdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B79020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hflNe-0001Xk-4Q
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 09:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50953)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hflAU-0001DA-Oz
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hflAQ-0007ny-TA
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:07:24 -0400
Received: from telepax.uni-paderborn.de ([131.234.189.14]:50808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1hflAN-0007gu-9p
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sX1mU8mDb7NpK39AZ1baVGHeDU9x5UyiX+zE47nhvKs=; b=LERcHrdOzIVEr6uqyV/Kf5kNub
 hYPzDrdcyIeqxgyniae466zMK1tGcmjUno5eJZiaPt6LPgjRpDMlDi2opVPW4Qkn3unTRO0MtdXJ8
 SuoZwJ+GdekuH0/Bzck5q8hVR1xNnr02ilVPboMYaCYqw92SRMO2Jp1o/pYAbrsPL4yo=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 15:06:58 +0200
Message-Id: <20190625130658.24895-6-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190625130658.24895-1-kbastian@mail.uni-paderborn.de>
References: <20190625130658.24895-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.6.25.125716, AntiVirus-Engine: 5.63.0,
 AntiVirus-Data: 2019.6.18.5630002
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.14
Subject: [Qemu-devel] [PULL 5/5] tricore: add QSEED instruction
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
Cc: peter.maydell@linaro.org, Lars Biermanski <lars.biermanski@efs-auto.de>,
 Andreas Konopik <andreas.konopik@fau.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andreas Konopik <andreas.konopik@fau.de>

Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20190624070339.4408-6-david.brenken@efs-auto.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
[BK: Added fp_status arg to float32_is_signaling_nan()]
---
 target/tricore/fpu_helper.c | 85 +++++++++++++++++++++++++++++++++++++
 target/tricore/helper.h     |  1 +
 target/tricore/translate.c  |  3 ++
 3 files changed, 89 insertions(+)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 432079c8e2..cb7ee7dd35 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -24,6 +24,7 @@
 
 #define QUIET_NAN 0x7fc00000
 #define ADD_NAN   0x7fc00001
+#define SQRT_NAN  0x7fc00004
 #define DIV_NAN   0x7fc00008
 #define MUL_NAN   0x7fc00002
 #define FPU_FS PSW_USB_C
@@ -32,6 +33,9 @@
 #define FPU_FZ PSW_USB_AV
 #define FPU_FU PSW_USB_SAV
 
+#define float32_sqrt_nan make_float32(SQRT_NAN)
+#define float32_quiet_nan make_float32(QUIET_NAN)
+
 /* we don't care about input_denormal */
 static inline uint8_t f_get_excp_flags(CPUTriCoreState *env)
 {
@@ -166,6 +170,87 @@ uint32_t helper_fmul(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 
 }
 
+/*
+ * Target TriCore QSEED.F significand Lookup Table
+ *
+ * The QSEED.F output significand depends on the least-significant
+ * exponent bit and the 6 most-significant significand bits.
+ *
+ * IEEE 754 float datatype
+ * partitioned into Sign (S), Exponent (E) and Significand (M):
+ *
+ * S   E E E E E E E E   M M M M M M ...
+ *    |             |               |
+ *    +------+------+-------+-------+
+ *           |              |
+ *          for        lookup table
+ *      calculating     index for
+ *        output E       output M
+ *
+ * This lookup table was extracted by analyzing QSEED output
+ * from the real hardware
+ */
+static const uint8_t target_qseed_significand_table[128] = {
+    253, 252, 245, 244, 239, 238, 231, 230, 225, 224, 217, 216,
+    211, 210, 205, 204, 201, 200, 195, 194, 189, 188, 185, 184,
+    179, 178, 175, 174, 169, 168, 165, 164, 161, 160, 157, 156,
+    153, 152, 149, 148, 145, 144, 141, 140, 137, 136, 133, 132,
+    131, 130, 127, 126, 123, 122, 121, 120, 117, 116, 115, 114,
+    111, 110, 109, 108, 103, 102, 99, 98, 93, 92, 89, 88, 83,
+    82, 79, 78, 75, 74, 71, 70, 67, 66, 63, 62, 59, 58, 55,
+    54, 53, 52, 49, 48, 45, 44, 43, 42, 39, 38, 37, 36, 33,
+    32, 31, 30, 27, 26, 25, 24, 23, 22, 19, 18, 17, 16, 15,
+    14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2
+};
+
+uint32_t helper_qseed(CPUTriCoreState *env, uint32_t r1)
+{
+    uint32_t arg1, S, E, M, E_minus_one, m_idx;
+    uint32_t new_E, new_M, new_S, result;
+
+    arg1 = make_float32(r1);
+
+    /* fetch IEEE-754 fields S, E and the uppermost 6-bit of M */
+    S = extract32(arg1, 31, 1);
+    E = extract32(arg1, 23, 8);
+    M = extract32(arg1, 17, 6);
+
+    if (float32_is_any_nan(arg1)) {
+        result = float32_quiet_nan;
+    } else if (float32_is_zero_or_denormal(arg1)) {
+        if (float32_is_neg(arg1)) {
+            result = float32_infinity | (1 << 31);
+        } else {
+            result = float32_infinity;
+        }
+    } else if (float32_is_neg(arg1)) {
+        result = float32_sqrt_nan;
+    } else if (float32_is_infinity(arg1)) {
+        result = float32_zero;
+    } else {
+        E_minus_one = E - 1;
+        m_idx = ((E_minus_one & 1) << 6) | M;
+        new_S = S;
+        new_E = 0xBD - E_minus_one / 2;
+        new_M = target_qseed_significand_table[m_idx];
+
+        result = 0;
+        result = deposit32(result, 31, 1, new_S);
+        result = deposit32(result, 23, 8, new_E);
+        result = deposit32(result, 15, 8, new_M);
+    }
+
+    if (float32_is_signaling_nan(arg1, &env->fp_status)
+        || result == float32_sqrt_nan) {
+        env->FPU_FI = 1 << 31;
+        env->FPU_FS = 1;
+    } else {
+        env->FPU_FS = 0;
+    }
+
+    return (uint32_t) result;
+}
+
 uint32_t helper_fdiv(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t flags;
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index f1a5cb367e..b64780c37d 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -109,6 +109,7 @@ DEF_HELPER_3(fdiv, i32, env, i32, i32)
 DEF_HELPER_4(fmadd, i32, env, i32, i32, i32)
 DEF_HELPER_4(fmsub, i32, env, i32, i32, i32)
 DEF_HELPER_3(fcmp, i32, env, i32, i32)
+DEF_HELPER_2(qseed, i32, env, i32)
 DEF_HELPER_2(ftoi, i32, env, i32)
 DEF_HELPER_2(itof, i32, env, i32)
 DEF_HELPER_2(utof, i32, env, i32)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index c79566e56a..dc2a65f3f9 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6753,6 +6753,9 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
     case OPC2_32_RR_FTOIZ:
         gen_helper_ftoiz(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
         break;
+    case OPC2_32_RR_QSEED_F:
+        gen_helper_qseed(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
+        break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
-- 
2.22.0


