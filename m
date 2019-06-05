Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0ACC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C5020673
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C5020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36072 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYPAk-0005vC-Ad
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 02:13:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1hYP9N-0004yt-3t
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1hYP9L-0008LY-Sw
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:11:53 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1hYP9L-0008KP-II
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:11:51 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MhDEq-1guNcz24dW-00eMcp; Wed, 05 Jun 2019 08:11:43 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 08:11:25 +0200
Message-Id: <20190605061126.10244-5-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20190605061126.10244-1-david.brenken@efs-auto.org>
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:yE3P60ywRocg4EbxzYVgR0QUtrq/c5FiKoGT6Iu+BNe7KP+G+eA
	seHYJES9sm0Luqex3meuqOH3By23AzYyHXaJHRS6kdGpxRTx3+IJG7iAVb9kgHxCSYWSVW3
	2MtPV/t7mbsf5pqIdvOzWwol8CLlEw/+88SM0COU145UMQA3DmKmao2KgExoOZCX/AdwC+2
	5AUTAcP8F2wwBF0K56BFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VlNSRQPAw6U=:9egakEuMPp4LP132e1QDuQ
	E/WHzqxRbRw0SU5mfAV7oT/QY8Jz2Fma7lnroY4cq/7v+OLCAdkamJLbotX4abTP1p549dbYb
	aGM4GR9GlwDg2aVQnSxOjD137CM4uY8DicIqzkLGCPVHvm92gOpZvr9pn4ssN33qgkiUuUTvl
	BSTU9VL4fAndA9vKSj6E92rgrH40o1LdLc3NUhb68LKrp0QCRB5019Q+2r6+WNUv0W4X/qJec
	VIR+EWfwmxfWOGWSnPk1TcfuFZcJR0rHPbD5SuhGOrgGfB8Y5OuRZ/uV8WjNfOx7te2EMfff0
	BPtHDNPR4YL7bKw9sbh7YboLtGLgZ9xdIYeSHqk+Ku0JaVfqnbkagv8mk0l+7RBbRBCNOgtMO
	G5GS+EvC7xlCnNKSC1rPQCfCUosspznTDen3uc6pbtBOl2V+oT6DUI+ZRsSgml3k7WaaHjHMx
	hEGYZbOcfF5J7vofmW1oseQktFAnD8na8oE9OOTRhUzhqUxOkS1sncc8Sa+wfnhuEDyVPWhqZ
	SZKbC0N85d8gdf/Oli6lkbC21sJ0wCwXg6OhKG+BNXQuYkzITmhEPNUb0oPo0BExcXhFyMeHq
	JTfdWPsAVod4Zwcx06booNTMi2FaSdkx9iPtNabiQFcIm6DdLBbxWJT44KQXujaykEL66k23f
	7xgMrhNt8UkUWmDGUq5AfYLU1iFpclbhsyzsNyDpuhVR7dMvQThg23auzkvb85ZWsGE+ednGy
	4ubyev7Ewm7nHeOJUuHcRjdACEtID+4jCDvCK77jLa6NxfCPNPEv+iR23Vo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PATCH 4/5] tricore: add QSEED instruction
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
Cc: kbastian@mail.uni-paderborn.de,
	Lars Biermanski <lars.biermanski@efs-auto.de>,
	Andreas Konopik <andreas.konopik@efs-auto.com>,
	Georg Hofstetter <georg.hofstetter@efs-auto.de>,
	David Brenken <david.brenken@efs-auto.de>,
	Robert Rasche <robert.rasche@efs-auto.de>,
	Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andreas Konopik <andreas.konopik@efs-auto.com>

Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>

---
 target/tricore/fpu_helper.c | 88 +++++++++++++++++++++++++++++++++++++
 target/tricore/helper.h     |  1 +
 target/tricore/translate.c  |  3 ++
 3 files changed, 92 insertions(+)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 432079c8e2..68515ee3e0 100644
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
@@ -166,6 +170,90 @@ uint32_t helper_fmul(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 
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
+    uint32_t flags;
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
+        env->FPU_FI = 1;
+    } else if (E == 0) {
+        if (float32_is_neg(arg1)) {
+            result = float32_infinity | (1 << 31);
+        } else {
+            result = float32_infinity;
+        }
+    } else if (float32_is_neg(arg1)) {
+        result = float32_sqrt_nan;
+        env->FPU_FI = 1;
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
+    flags = f_get_excp_flags(env);
+    if (flags) {
+        if (flags & float_flag_invalid) {
+            f_update_psw_flags(env, flags);
+        } else {
+            env->FPU_FS = 0;
+        }
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
index 19d8db7a46..dbc964901f 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6764,6 +6764,9 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
     case OPC2_32_RR_UPDFL:
         gen_helper_updfl(cpu_env, cpu_gpr_d[r1]);
         break;
+    case OPC2_32_RR_QSEED_F:
+        gen_helper_qseed(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
+        break;
     case OPC2_32_RR_UTOF:
         gen_helper_utof(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
         break;
-- 
2.17.1


