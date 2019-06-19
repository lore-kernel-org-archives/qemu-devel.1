Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76592C31E5E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5344621479
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5344621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdVby-0002Dh-L8
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 04:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38444)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david.brenken@efs-auto.org>) id 1hdVXu-0000eh-ME
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.brenken@efs-auto.org>) id 1hdVXs-0003fg-I9
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:02:18 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47333)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
 id 1hdVXr-0003dj-B5
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:02:16 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MEC8L-1hn6Ns3Tz3-00AF8V; Wed, 19 Jun 2019 09:57:01 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 09:56:42 +0200
Message-Id: <20190619075643.10048-5-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20190619075643.10048-1-david.brenken@efs-auto.org>
References: <20190619075643.10048-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:RBp7AlXiKVnBwJVc9JIlr+5H2M879qwb8M5GWY/goKg0AJN3Cih
 m2iH6B2JhwbmaUYrjXr+6Z6OpHPLjGKVXwdalwBdyP6pN4XJvZ4udIiYX8Q7Rva4Dr/1QWE
 bhu0WWudsQJhZ8usPgs6Otb+ej/k6CkWJU6q8T3ZGUbXJbuGdLy/Z8uVhBGNFkcK81GitDe
 KKGA5SgTkGyGJjf9yCStA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0j/myy9gUSQ=:byLOeOq/O2R/nWB8+GQU++
 UVMSXggal/+8XZvD6ijbP+csBXYAJo+fU/JyUNsPOysO5GNWO4C5XD3TQ6Nw4YTew8cemw7Dk
 GnEapWeh0ebZIXnx3OlirzkCQva0x67Ig5JLm5nQchglRAwt903zl7G3qEUCdJBCk9XwObSWU
 n25sKh6t72Z0daGviMb1GlFoVjul7NhtT3KTxDPibXKL0fi1eHKyYoqztFQRY46AVav8xEGja
 tMREj7NART0N7uQNiZbh6TUsXuG87rir6+IWk9ewKt6lSyY6wi4yZYC9EKPCRMdoswCaKhGtM
 dMQzYRJqV2+lmxokT0f5oPkhJQEm5JRpPU3QAj9rzOCJAqnfuTDw+RZTBxfzdvNcYZbjnBLRC
 X7K+paE5mfca/+G1BdRYHG/1/fsSzIP0jyrkWepORjsPvLvc2Jd2Lr0vZKgdxe1zg6rPL6DOY
 pEg5CAoWE9fzZzdKpzCz1TseS8LPEbmohgD1Tt59alOiuyA0Ing2lBuio62cEbpZnvHwAQLSZ
 sCq8gQ6+EsEocU7onQ5pcShJJ/CQbwwmpxceObKEiYxQLcC3duSD80+YAKj+DuPDUrbqPwwoS
 tEXtwgo3ICkRfNWCgAhWw9WHKpFUkZ2LuYdcTED2H3pQNRHJPoWssPlN64Xiaf4c+ScKdcaf3
 MicoFxFfAHHEwrmWXSFEtj0gHV931zsqLE+FDL7s0PzIL+q27iubxWbvl/lWuxJQIExDssNUi
 sB7rnoAreTuIwkA03hEN4OWFEfMXR8d/r5Aw4vgdFH1ToQ4UtgVQEzjtPVk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PATCH v2 4/5] tricore: add QSEED instruction
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
Cc: kbastian@mail.uni-paderborn.de,
 Lars Biermanski <lars.biermanski@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andreas Konopik <andreas.konopik@efs-auto.de>

Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
---
 target/tricore/fpu_helper.c | 85 +++++++++++++++++++++++++++++++++++++
 target/tricore/helper.h     |  1 +
 target/tricore/translate.c  |  3 ++
 3 files changed, 89 insertions(+)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 432079c8e2..a0bbc6a95b 100644
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
+
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
+    if (float32_is_any_nan(arg1) || result == float32_sqrt_nan) {
+        env->FPU_FI = 1;
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
index 5d4febf1c0..b3bfb3ca51 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6750,6 +6750,9 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
     case OPC2_32_RR_UTOF:
         gen_helper_utof(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
         break;
+    case OPC2_32_RR_QSEED_F:
+        gen_helper_qseed(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
+        break;				
     case OPC2_32_RR_FTOIZ:
         gen_helper_ftoiz(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
         break;
-- 
2.22.0.windows.1


