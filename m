Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55996C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D31720656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D31720656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgST0-0006Us-CY
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55857)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hgS5y-0001zs-4f
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hgS5v-0001hj-Km
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:57:38 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36495 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1hgS5v-0001fl-85
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:57:35 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 280661A45A6;
 Thu, 27 Jun 2019 12:56:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
 [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id E2BA91A4539;
 Thu, 27 Jun 2019 12:56:29 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 12:56:20 +0200
Message-Id: <1561632985-24866-9-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561632985-24866-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1561632985-24866-1-git-send-email-stefan.brankovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v4 08/13] tcg: Add opcodes for vector vmrgh
 instructions
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
Cc: stefan.brankovic@rt-rk.com, hsp.cat7@gmail.com,
 richard.henderson@linaro.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
---
 accel/tcg/tcg-runtime-gvec.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-runtime.h      |  4 ++++
 tcg/i386/tcg-target.h        |  1 +
 tcg/tcg-op-gvec.c            | 23 +++++++++++++++++++++++
 tcg/tcg-op-gvec.h            |  3 +++
 tcg/tcg-op-vec.c             |  5 +++++
 tcg/tcg-op.h                 |  2 ++
 tcg/tcg-opc.h                |  2 ++
 tcg/tcg.c                    |  2 ++
 tcg/tcg.h                    |  1 +
 10 files changed, 85 insertions(+)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 51cb29c..28173ae 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -1458,3 +1458,45 @@ void HELPER(gvec_bitsel)(void *d, void *a, void *b, void *c, uint32_t desc)
     }
     clear_high(d, oprsz, desc);
 }
+
+void HELPER(gvec_vmrgh8)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < (oprsz / 2); i += sizeof(uint8_t)) {
+        uint8_t aa = *(uint8_t *)(a + 8 * sizeof(uint8_t) + i);
+        uint8_t bb = *(uint8_t *)(b + 8 * sizeof(uint8_t) + i);
+        *(uint8_t *)(d + 2 * i) = bb;
+        *(uint8_t *)(d + 2 * i + sizeof(uint8_t)) = aa;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_vmrgh16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < (oprsz / 2); i += sizeof(uint16_t)) {
+        uint16_t aa = *(uint16_t *)(a + 4 * sizeof(uint16_t) + i);
+        uint16_t bb = *(uint16_t *)(b + 4 * sizeof(uint16_t) + i);
+        *(uint16_t *)(d + 2 * i) = bb;
+        *(uint16_t *)(d + 2 * i + sizeof(uint16_t)) = aa;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_vmrgh32)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        uint32_t aa = *(uint32_t *)(a + 2 * sizeof(uint32_t) + i);
+        uint32_t bb = *(uint32_t *)(b + 2 * sizeof(uint32_t) + i);
+        *(uint32_t *)(d + 2 * i) = bb;
+        *(uint32_t *)(d + 2 * i + sizeof(uint32_t)) = aa;
+    }
+    clear_high(d, oprsz, desc);
+}
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 4fa61b4..089956f 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -305,3 +305,7 @@ DEF_HELPER_FLAGS_4(gvec_leu32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_leu64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_bitsel, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_vmrgh8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vmrgh16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vmrgh32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 928e8b8..e11b22d 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -192,6 +192,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       -1
+#define TCG_TARGET_HAS_vmrgh_vec        0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 17679b6..2560fb6 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2102,6 +2102,29 @@ void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
+static const TCGOpcode vecop_list_vmrgh[] = { INDEX_op_vmrgh_vec, 0 };
+
+void tcg_gen_gvec_vmrgh(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[3] = {
+        { .fniv = tcg_gen_vmrgh_vec,
+          .fno = gen_helper_gvec_vmrgh8,
+          .opt_opc = vecop_list_vmrgh,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_vmrgh_vec,
+          .fno = gen_helper_gvec_vmrgh16,
+          .opt_opc = vecop_list_vmrgh,
+          .vece = MO_16 },
+        { .fniv = tcg_gen_vmrgh_vec,
+          .fno = gen_helper_gvec_vmrgh32,
+          .opt_opc = vecop_list_vmrgh,
+          .vece = MO_32 }
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
 /* Perform a vector negation using normal negation and a mask.
    Compare gen_subv_mask above.  */
 static void gen_negv_mask(TCGv_i64 d, TCGv_i64 b, TCGv_i64 m)
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 830d68f..8c04d71 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -272,6 +272,9 @@ void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+/* Vector merge. */
+void tcg_gen_gvec_vmrgh(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 
 void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index c8fdc24..fb0b83e 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -663,6 +663,11 @@ void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
     do_minmax(vece, r, a, b, INDEX_op_umax_vec, TCG_COND_GTU);
 }
 
+void tcg_gen_vmrgh_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_vmrgh_vec);
+}
+
 void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
     do_op3_nofail(vece, r, a, b, INDEX_op_shlv_vec);
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 2d4dd5c..d8de022 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -985,6 +985,8 @@ void tcg_gen_umin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_smax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 
+void tcg_gen_vmrgh_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+
 void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 242d608..2bc3bdf 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -235,6 +235,8 @@ DEF(umin_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_minmax_vec))
 DEF(smax_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_minmax_vec))
 DEF(umax_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_minmax_vec))
 
+DEF(vmrgh_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_vmrgh_vec))
+
 DEF(and_vec, 1, 2, 0, IMPLVEC)
 DEF(or_vec, 1, 2, 0, IMPLVEC)
 DEF(xor_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 02a2680..fed9a6f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1646,6 +1646,8 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_smax_vec:
     case INDEX_op_umax_vec:
         return have_vec && TCG_TARGET_HAS_minmax_vec;
+    case INDEX_op_vmrgh_vec:
+        return have_vec && TCG_TARGET_HAS_vmrgh_vec;
     case INDEX_op_bitsel_vec:
         return have_vec && TCG_TARGET_HAS_bitsel_vec;
     case INDEX_op_cmpsel_vec:
diff --git a/tcg/tcg.h b/tcg/tcg.h
index b411e17..05b9b51 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -186,6 +186,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_mul_vec          0
 #define TCG_TARGET_HAS_sat_vec          0
 #define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_vmrgh_vec        0
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       0
 #else
-- 
2.7.4


