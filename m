Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB2DC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9D720725
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJU3Guc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9D720725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5Pg-0003t4-Eu
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Np-0000UT-MV
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:57:53 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:50433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Nn-0008LA-6g
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:57:53 -0400
Received: by mail-pj1-x1043.google.com with SMTP id t9so4508617pjw.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jxLoNReJJL5KF4Ar6fPotnMAR/lcvKW06PVOX3O9p8o=;
 b=CJU3Guc/YMxUmmDafPAGtMBKPhSWjKxiDxafMwTG+Nurpkq4KgfJ1RojZeO5XLEDDS
 cbY3Sw3iqxX9BukPSSE8bCIjAjroyFSQ6wPOEid/Hm7T5dJJP8Iw8snonztsf0gN29z4
 DdRLawI/r7Y8JgFCgSwJov6YPpATmurcfYZL24X3lWBCCwCI27JIsah6TzOu3A9AhSN7
 5IYww5Au7wnEdU0Vmmr2bFJBoW6Z43RC3gpHO3aQa0+RVUNPPkrcOoQRB0cWVdbFEjuD
 mbIAvOytQGdwPnNhNRF+ELGGhWKNl1l1aCs28WMcx0PiEQUwebqaFHrGwwqTdASY3JjJ
 AEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jxLoNReJJL5KF4Ar6fPotnMAR/lcvKW06PVOX3O9p8o=;
 b=AsqqAWa0SduNTCwqXCpRFmIf2sLPlXB6jm9Fa4UxsQxV/urZBXXMDNN4Uks7cbiWAm
 U8M8Az4PEjUtLixNA8Cajm8XX84CFANCge8i6Hem3M+Oe3BEvsfT84fv6o5Phvl6ErrU
 K8H4vCzNIcIAqG8UtjGkRph/VIlRT54Z+go4vL9WuiJTzwJEW7NpUQmh/3u3smDlJGQK
 SyL8N5iJpOSfH/lM0pPqF5rNUr8DO3O0dUTkqZU5HRTEZ6g35IPk25+J57CTYpnKhN9E
 oCVoJQ3AP7yilZTaJr+0X1cp5eiVlfs9dAi9MNLOeCiHmQJK0gmu7bmBFepfPGZVM7Wr
 sHmA==
X-Gm-Message-State: AGi0PuZV9XgVw/ERV0L8StqbdJCdaDzUb3kmUDQ3GpUjiMYLoxuC3y+2
 7zhtMJnpu/TeWufw4z9+4eDS65AuQdM=
X-Google-Smtp-Source: APiQypJNQhhzX/PxHvVSw3wXjfRTsbBcGj5I8uA7I0ifzbaJa7gZP+8FOm2QL9NJhJU0ffI9cGAWtA==
X-Received: by 2002:a17:902:c406:: with SMTP id
 k6mr2961820plk.203.1588953468984; 
 Fri, 08 May 2020 08:57:48 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id z7sm2141601pff.47.2020.05.08.08.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:57:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] tcg/s390: Change FACILITY representation
Date: Fri,  8 May 2020 08:57:43 -0700
Message-Id: <20200508155745.8223-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508155745.8223-1-richard.henderson@linaro.org>
References: <20200508155745.8223-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will shortly need to be able to check facilities
beyond the first 64.  Instead of explicitly masking
against s390_facilities, create a FACILITY macro
that indexes an array.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390/tcg-target.h     | 29 ++++++++-------
 tcg/s390/tcg-target.inc.c | 74 +++++++++++++++++++--------------------
 2 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 07accabbd1..7ca48457ff 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -52,16 +52,19 @@ typedef enum TCGReg {
 /* A list of relevant facilities used by this translator.  Some of these
    are required for proper operation, and these are checked at startup.  */
 
-#define FACILITY_ZARCH_ACTIVE         (1ULL << (63 - 2))
-#define FACILITY_LONG_DISP            (1ULL << (63 - 18))
-#define FACILITY_EXT_IMM              (1ULL << (63 - 21))
-#define FACILITY_GEN_INST_EXT         (1ULL << (63 - 34))
-#define FACILITY_LOAD_ON_COND         (1ULL << (63 - 45))
+#define FACILITY_ZARCH_ACTIVE         2
+#define FACILITY_LONG_DISP            18
+#define FACILITY_EXT_IMM              21
+#define FACILITY_GEN_INST_EXT         34
+#define FACILITY_LOAD_ON_COND         45
 #define FACILITY_FAST_BCR_SER         FACILITY_LOAD_ON_COND
 #define FACILITY_DISTINCT_OPS         FACILITY_LOAD_ON_COND
-#define FACILITY_LOAD_ON_COND2        (1ULL << (63 - 53))
+#define FACILITY_LOAD_ON_COND2        53
 
-extern uint64_t s390_facilities;
+extern uint64_t s390_facilities[1];
+
+#define FACILITY(X) \
+    ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
 
 /* optional instructions */
 #define TCG_TARGET_HAS_div2_i32       1
@@ -82,8 +85,8 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_clz_i32        0
 #define TCG_TARGET_HAS_ctz_i32        0
 #define TCG_TARGET_HAS_ctpop_i32      0
-#define TCG_TARGET_HAS_deposit_i32    (s390_facilities & FACILITY_GEN_INST_EXT)
-#define TCG_TARGET_HAS_extract_i32    (s390_facilities & FACILITY_GEN_INST_EXT)
+#define TCG_TARGET_HAS_deposit_i32    FACILITY(GEN_INST_EXT)
+#define TCG_TARGET_HAS_extract_i32    FACILITY(GEN_INST_EXT)
 #define TCG_TARGET_HAS_sextract_i32   0
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_movcond_i32    1
@@ -96,7 +99,7 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_extrl_i64_i32  0
 #define TCG_TARGET_HAS_extrh_i64_i32  0
 #define TCG_TARGET_HAS_goto_ptr       1
-#define TCG_TARGET_HAS_direct_jump    (s390_facilities & FACILITY_GEN_INST_EXT)
+#define TCG_TARGET_HAS_direct_jump    FACILITY(GEN_INST_EXT)
 
 #define TCG_TARGET_HAS_div2_i64       1
 #define TCG_TARGET_HAS_rot_i64        1
@@ -116,11 +119,11 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_eqv_i64        0
 #define TCG_TARGET_HAS_nand_i64       0
 #define TCG_TARGET_HAS_nor_i64        0
-#define TCG_TARGET_HAS_clz_i64        (s390_facilities & FACILITY_EXT_IMM)
+#define TCG_TARGET_HAS_clz_i64        FACILITY(EXT_IMM)
 #define TCG_TARGET_HAS_ctz_i64        0
 #define TCG_TARGET_HAS_ctpop_i64      0
-#define TCG_TARGET_HAS_deposit_i64    (s390_facilities & FACILITY_GEN_INST_EXT)
-#define TCG_TARGET_HAS_extract_i64    (s390_facilities & FACILITY_GEN_INST_EXT)
+#define TCG_TARGET_HAS_deposit_i64    FACILITY(GEN_INST_EXT)
+#define TCG_TARGET_HAS_extract_i64    FACILITY(GEN_INST_EXT)
 #define TCG_TARGET_HAS_sextract_i64   0
 #define TCG_TARGET_HAS_extract2_i64   0
 #define TCG_TARGET_HAS_movcond_i64    1
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index b07e9ff7d6..123286857f 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -53,7 +53,7 @@
    We don't need this when we have pc-relative loads with the general
    instructions extension facility.  */
 #define TCG_REG_TB      TCG_REG_R12
-#define USE_REG_TB      (!(s390_facilities & FACILITY_GEN_INST_EXT))
+#define USE_REG_TB      (!FACILITY(GEN_INST_EXT))
 
 #ifndef CONFIG_SOFTMMU
 #define TCG_GUEST_BASE_REG TCG_REG_R13
@@ -364,7 +364,7 @@ static void * const qemu_st_helpers[16] = {
 #endif
 
 static tcg_insn_unit *tb_ret_addr;
-uint64_t s390_facilities;
+uint64_t s390_facilities[1];
 
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
@@ -610,7 +610,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 
     /* Try all 48-bit insns that can load it in one go.  */
-    if (s390_facilities & FACILITY_EXT_IMM) {
+    if (FACILITY(EXT_IMM)) {
         if (sval == (int32_t)sval) {
             tcg_out_insn(s, RIL, LGFI, ret, sval);
             return;
@@ -653,7 +653,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 
     /* Otherwise, stuff it in the constant pool.  */
-    if (s390_facilities & FACILITY_GEN_INST_EXT) {
+    if (FACILITY(GEN_INST_EXT)) {
         tcg_out_insn(s, RIL, LGRL, ret, 0);
         new_pool_label(s, sval, R_390_PC32DBL, s->code_ptr - 2, 2);
     } else if (USE_REG_TB && !in_prologue) {
@@ -738,7 +738,7 @@ static void tcg_out_ld_abs(TCGContext *s, TCGType type, TCGReg dest, void *abs)
 {
     intptr_t addr = (intptr_t)abs;
 
-    if ((s390_facilities & FACILITY_GEN_INST_EXT) && !(addr & 1)) {
+    if (FACILITY(GEN_INST_EXT) && !(addr & 1)) {
         ptrdiff_t disp = tcg_pcrel_diff(s, abs) >> 1;
         if (disp == (int32_t)disp) {
             if (type == TCG_TYPE_I32) {
@@ -772,7 +772,7 @@ static inline void tcg_out_risbg(TCGContext *s, TCGReg dest, TCGReg src,
 
 static void tgen_ext8s(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 {
-    if (s390_facilities & FACILITY_EXT_IMM) {
+    if (FACILITY(EXT_IMM)) {
         tcg_out_insn(s, RRE, LGBR, dest, src);
         return;
     }
@@ -792,7 +792,7 @@ static void tgen_ext8s(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 
 static void tgen_ext8u(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 {
-    if (s390_facilities & FACILITY_EXT_IMM) {
+    if (FACILITY(EXT_IMM)) {
         tcg_out_insn(s, RRE, LLGCR, dest, src);
         return;
     }
@@ -812,7 +812,7 @@ static void tgen_ext8u(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 
 static void tgen_ext16s(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 {
-    if (s390_facilities & FACILITY_EXT_IMM) {
+    if (FACILITY(EXT_IMM)) {
         tcg_out_insn(s, RRE, LGHR, dest, src);
         return;
     }
@@ -832,7 +832,7 @@ static void tgen_ext16s(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 
 static void tgen_ext16u(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 {
-    if (s390_facilities & FACILITY_EXT_IMM) {
+    if (FACILITY(EXT_IMM)) {
         tcg_out_insn(s, RRE, LLGHR, dest, src);
         return;
     }
@@ -920,7 +920,7 @@ static void tgen_andi(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
         tgen_ext32u(s, dest, dest);
         return;
     }
-    if (s390_facilities & FACILITY_EXT_IMM) {
+    if (FACILITY(EXT_IMM)) {
         if ((val & valid) == 0xff) {
             tgen_ext8u(s, TCG_TYPE_I64, dest, dest);
             return;
@@ -941,7 +941,7 @@ static void tgen_andi(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
     }
 
     /* Try all 48-bit insns that can perform it in one go.  */
-    if (s390_facilities & FACILITY_EXT_IMM) {
+    if (FACILITY(EXT_IMM)) {
         for (i = 0; i < 2; i++) {
             tcg_target_ulong mask = ~(0xffffffffull << i*32);
             if (((val | ~valid) & mask) == mask) {
@@ -950,7 +950,7 @@ static void tgen_andi(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
             }
         }
     }
-    if ((s390_facilities & FACILITY_GEN_INST_EXT) && risbg_mask(val)) {
+    if (FACILITY(GEN_INST_EXT) && risbg_mask(val)) {
         tgen_andi_risbg(s, dest, dest, val);
         return;
     }
@@ -999,7 +999,7 @@ static void tgen_ori(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
     }
 
     /* Try all 48-bit insns that can perform it in one go.  */
-    if (s390_facilities & FACILITY_EXT_IMM) {
+    if (FACILITY(EXT_IMM)) {
         for (i = 0; i < 2; i++) {
             tcg_target_ulong mask = (0xffffffffull << i*32);
             if ((val & mask) != 0 && (val & ~mask) == 0) {
@@ -1024,7 +1024,7 @@ static void tgen_ori(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
         /* Perform the OR via sequential modifications to the high and
            low parts.  Do this via recursion to handle 16-bit vs 32-bit
            masks in each half.  */
-        tcg_debug_assert(s390_facilities & FACILITY_EXT_IMM);
+        tcg_debug_assert(FACILITY(EXT_IMM));
         tgen_ori(s, type, dest, val & 0x00000000ffffffffull);
         tgen_ori(s, type, dest, val & 0xffffffff00000000ull);
     }
@@ -1033,7 +1033,7 @@ static void tgen_ori(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
 static void tgen_xori(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
 {
     /* Try all 48-bit insns that can perform it in one go.  */
-    if (s390_facilities & FACILITY_EXT_IMM) {
+    if (FACILITY(EXT_IMM)) {
         if ((val & 0xffffffff00000000ull) == 0) {
             tcg_out_insn(s, RIL, XILF, dest, val);
             return;
@@ -1057,7 +1057,7 @@ static void tgen_xori(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
                        -(intptr_t)s->code_gen_ptr);
     } else {
         /* Perform the xor by parts.  */
-        tcg_debug_assert(s390_facilities & FACILITY_EXT_IMM);
+        tcg_debug_assert(FACILITY(EXT_IMM));
         if (val & 0xffffffff) {
             tcg_out_insn(s, RIL, XILF, dest, val);
         }
@@ -1091,7 +1091,7 @@ static int tgen_cmp(TCGContext *s, TCGType type, TCGCond c, TCGReg r1,
             goto exit;
         }
 
-        if (s390_facilities & FACILITY_EXT_IMM) {
+        if (FACILITY(EXT_IMM)) {
             if (type == TCG_TYPE_I32) {
                 op = (is_unsigned ? RIL_CLFI : RIL_CFI);
                 tcg_out_insn_RIL(s, op, r1, c2);
@@ -1154,7 +1154,7 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
     bool have_loc;
 
     /* With LOC2, we can always emit the minimum 3 insns.  */
-    if (s390_facilities & FACILITY_LOAD_ON_COND2) {
+    if (FACILITY(LOAD_ON_COND2)) {
         /* Emit: d = 0, d = (cc ? 1 : d).  */
         cc = tgen_cmp(s, type, cond, c1, c2, c2const, false);
         tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
@@ -1162,7 +1162,7 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
         return;
     }
 
-    have_loc = (s390_facilities & FACILITY_LOAD_ON_COND) != 0;
+    have_loc = FACILITY(LOAD_ON_COND);
 
     /* For HAVE_LOC, only the paths through GTU/GT/LEU/LE are smaller.  */
  restart:
@@ -1248,7 +1248,7 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond c, TCGReg dest,
                          TCGArg v3, int v3const)
 {
     int cc;
-    if (s390_facilities & FACILITY_LOAD_ON_COND) {
+    if (FACILITY(LOAD_ON_COND)) {
         cc = tgen_cmp(s, type, c, c1, c2, c2const, false);
         if (v3const) {
             tcg_out_insn(s, RIE, LOCGHI, dest, v3, cc);
@@ -1281,7 +1281,7 @@ static void tgen_clz(TCGContext *s, TCGReg dest, TCGReg a1,
         } else {
             tcg_out_mov(s, TCG_TYPE_I64, dest, a2);
         }
-        if (s390_facilities & FACILITY_LOAD_ON_COND) {
+        if (FACILITY(LOAD_ON_COND)) {
             /* Emit: if (one bit found) dest = r0.  */
             tcg_out_insn(s, RRF, LOCGR, dest, TCG_REG_R0, 2);
         } else {
@@ -1373,7 +1373,7 @@ static void tgen_brcond(TCGContext *s, TCGType type, TCGCond c,
 {
     int cc;
 
-    if (s390_facilities & FACILITY_GEN_INST_EXT) {
+    if (FACILITY(GEN_INST_EXT)) {
         bool is_unsigned = is_unsigned_cond(c);
         bool in_range;
         S390Opcode opc;
@@ -1567,7 +1567,7 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, MemOp opc,
        cross pages using the address of the last byte of the access.  */
     a_off = (a_bits >= s_bits ? 0 : s_mask - a_mask);
     tlb_mask = (uint64_t)TARGET_PAGE_MASK | a_mask;
-    if ((s390_facilities & FACILITY_GEN_INST_EXT) && a_off == 0) {
+    if (FACILITY(GEN_INST_EXT) && a_off == 0) {
         tgen_andi_risbg(s, TCG_REG_R3, addr_reg, tlb_mask);
     } else {
         tcg_out_insn(s, RX, LA, TCG_REG_R3, addr_reg, TCG_REG_NONE, a_off);
@@ -1854,7 +1854,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                     tcg_out_insn(s, RI, AHI, a0, a2);
                     break;
                 }
-                if (s390_facilities & FACILITY_EXT_IMM) {
+                if (FACILITY(EXT_IMM)) {
                     tcg_out_insn(s, RIL, AFI, a0, a2);
                     break;
                 }
@@ -2078,7 +2078,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                     tcg_out_insn(s, RI, AGHI, a0, a2);
                     break;
                 }
-                if (s390_facilities & FACILITY_EXT_IMM) {
+                if (FACILITY(EXT_IMM)) {
                     if (a2 == (int32_t)a2) {
                         tcg_out_insn(s, RIL, AGFI, a0, a2);
                         break;
@@ -2303,8 +2303,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         /* The host memory model is quite strong, we simply need to
            serialize the instruction stream.  */
         if (args[0] & TCG_MO_ST_LD) {
-            tcg_out_insn(s, RR, BCR,
-                         s390_facilities & FACILITY_FAST_BCR_SER ? 14 : 15, 0);
+            tcg_out_insn(s, RR, BCR, FACILITY(FAST_BCR_SER) ? 14 : 15, 0);
         }
         break;
 
@@ -2372,20 +2371,20 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
-        return (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri);
+        return FACILITY(DISTINCT_OPS) ? &r_r_ri : &r_0_ri;
 
     case INDEX_op_mul_i32:
         /* If we have the general-instruction-extensions, then we have
            MULTIPLY SINGLE IMMEDIATE with a signed 32-bit, otherwise we
            have only MULTIPLY HALFWORD IMMEDIATE, with a signed 16-bit.  */
-        return (s390_facilities & FACILITY_GEN_INST_EXT ? &r_0_ri : &r_0_rI);
+        return FACILITY(GEN_INST_EXT) ? &r_0_ri : &r_0_rI;
     case INDEX_op_mul_i64:
-        return (s390_facilities & FACILITY_GEN_INST_EXT ? &r_0_rJ : &r_0_rI);
+        return FACILITY(GEN_INST_EXT) ? &r_0_rJ : &r_0_rI;
 
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
-        return (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri);
+        return FACILITY(DISTINCT_OPS) ? &r_r_ri : &r_0_ri;
 
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
@@ -2451,7 +2450,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
                 = { .args_ct_str = { "r", "r", "ri", "r", "0" } };
             static const TCGTargetOpDef movc_l
                 = { .args_ct_str = { "r", "r", "ri", "rI", "0" } };
-            return (s390_facilities & FACILITY_LOAD_ON_COND2 ? &movc_l : &movc);
+            return FACILITY(LOAD_ON_COND2) ? &movc_l : &movc;
         }
     case INDEX_op_div2_i32:
     case INDEX_op_div2_i64:
@@ -2471,10 +2470,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
-        return (s390_facilities & FACILITY_EXT_IMM ? &a2_ri : &a2_r);
+        return FACILITY(EXT_IMM) ? &a2_ri : &a2_r;
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i64:
-        return (s390_facilities & FACILITY_EXT_IMM ? &a2_rA : &a2_r);
+        return FACILITY(EXT_IMM) ? &a2_rA : &a2_r;
 
     default:
         break;
@@ -2489,13 +2488,12 @@ static void query_s390_facilities(void)
     /* Is STORE FACILITY LIST EXTENDED available?  Honestly, I believe this
        is present on all 64-bit systems, but let's check for it anyway.  */
     if (hwcap & HWCAP_S390_STFLE) {
-        register int r0 __asm__("0");
-        register void *r1 __asm__("1");
+        register int r0 __asm__("0") = ARRAY_SIZE(s390_facilities) - 1;
+        register void *r1 __asm__("1") = s390_facilities;
 
         /* stfle 0(%r1) */
-        r1 = &s390_facilities;
         asm volatile(".word 0xb2b0,0x1000"
-                     : "=r"(r0) : "0"(0), "r"(r1) : "memory", "cc");
+                     : "=r"(r0) : "r"(r0), "r"(r1) : "memory", "cc");
     }
 }
 
-- 
2.20.1


