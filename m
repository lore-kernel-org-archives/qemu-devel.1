Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020AAC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 04:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C942083D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 04:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eigezh4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C942083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43755 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSDZG-0002lp-3t
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 00:37:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSDSo-0005d1-TQ
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSDEP-0004lA-1y
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:15:32 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSDEO-0004kA-6c
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:15:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id c13so5162617pgt.1
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 21:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ivzXz7WaxGAoU4CgTEArJPFa5XQwFPUyGBuwDQJ+uGA=;
	b=Eigezh4Xyk+wzecWdqALTm8sZPUZkU5XcKRyrE/rUDSXlBkIWcJgs71alG+n6V3nbb
	KzxPJvCmvomAd0+dPtXE9nvTAUlbfGD31HFIJ2aPqvHsLwCml9OGOu3N7Bfj46zev+mp
	JrJAGwUZ960kXhQC2Od1dXuvxHWnNDUnJVT0MjLzWj6sVGKCMjjaFI5ts91QAkoXKv0Y
	Bs9rAeEJNY729hOA4uxHmdMBRyVqFSg1dHFDsDkT4HSycGed5R//o1LSptoAyOgh1k/i
	LKTXTL2rXkYEY/14P7U4XfwKkC41jO2wCRQfLLwVZpgrbWz0kIOO7Myp4ljDjb0z7msr
	anEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ivzXz7WaxGAoU4CgTEArJPFa5XQwFPUyGBuwDQJ+uGA=;
	b=D+IHs8xM/thcJduVQ87uP6S7nWBnKb2TpETS6uADmOMwTMZiSnVr09QLpiphqFWQIg
	ugbDGX81O2F9vmF5vyujhxjpwUTMb1b3aReFwOC/7MBipI3WmwBiuSuPb9sMEU9p8CVM
	mU/5tZrKu31+qMsMJhj79vMEonEGuY6OJ5kO9UwPUAEzI3T1v0els5etqJiYL0ZoCxiA
	z3rQD2eDYgaJD3y2G/D21/ySHRxvAB08RnkGTxnHtQVfOXpkseCoF5B7Qw9PrgRkAwAM
	GMUZyHVgn9Cx1NHWym8lAiYeOUcbITMywI0mqhjkw7Pp4/3IREmlCzYYBuOMX8IA2kZk
	5YyA==
X-Gm-Message-State: APjAAAWAk0iRj906/Xt5qr12I4TGxBXzJKetMsl7o6/rGexDvocNtvyY
	xHsOkjsUftTxXfLOgFQmR1+0eWCpZ1s=
X-Google-Smtp-Source: APXvYqy+3kmX8DlTm4UbNwYNbOPieUkaPkfa1Np/Ril6djGTn+dN9IQk0mEuRg43nesPiBvUnC50hA==
X-Received: by 2002:aa7:8dc3:: with SMTP id j3mr72397650pfr.141.1558239326259; 
	Sat, 18 May 2019 21:15:26 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	k63sm19381200pfb.108.2019.05.18.21.15.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 21:15:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 21:15:16 -0700
Message-Id: <20190519041522.12327-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519041522.12327-1-richard.henderson@linaro.org>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v4 1/7] tcg/ppc: Initial backend support for
 Altivec
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
Cc: mark.cave-ayland@ilande.co.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are a few missing operations yet, like expansion of
multiply and shifts.  But this has move, load, store, and
basic arithmetic.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.h     |  36 +-
 tcg/ppc/tcg-target.opc.h |   3 +
 tcg/ppc/tcg-target.inc.c | 707 +++++++++++++++++++++++++++++++++++----
 3 files changed, 685 insertions(+), 61 deletions(-)
 create mode 100644 tcg/ppc/tcg-target.opc.h

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 7627fb62d3..368c250c6a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -31,7 +31,7 @@
 # define TCG_TARGET_REG_BITS  32
 #endif
 
-#define TCG_TARGET_NB_REGS 32
+#define TCG_TARGET_NB_REGS 64
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 
@@ -45,10 +45,20 @@ typedef enum {
     TCG_REG_R24, TCG_REG_R25, TCG_REG_R26, TCG_REG_R27,
     TCG_REG_R28, TCG_REG_R29, TCG_REG_R30, TCG_REG_R31,
 
+    TCG_REG_V0,  TCG_REG_V1,  TCG_REG_V2,  TCG_REG_V3,
+    TCG_REG_V4,  TCG_REG_V5,  TCG_REG_V6,  TCG_REG_V7,
+    TCG_REG_V8,  TCG_REG_V9,  TCG_REG_V10, TCG_REG_V11,
+    TCG_REG_V12, TCG_REG_V13, TCG_REG_V14, TCG_REG_V15,
+    TCG_REG_V16, TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
+    TCG_REG_V20, TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
+    TCG_REG_V24, TCG_REG_V25, TCG_REG_V26, TCG_REG_V27,
+    TCG_REG_V28, TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
+
     TCG_REG_CALL_STACK = TCG_REG_R1,
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
 
+extern bool have_isa_altivec;
 extern bool have_isa_2_06;
 extern bool have_isa_3_00;
 
@@ -126,6 +136,30 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_mulsh_i64        1
 #endif
 
+/*
+ * While technically Altivec could support V64, it has no 64-bit store
+ * instruction and substituting two 32-bit stores makes the generated
+ * code quite large.
+ */
+#define TCG_TARGET_HAS_v64              0
+#define TCG_TARGET_HAS_v128             have_isa_altivec
+#define TCG_TARGET_HAS_v256             0
+
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_not_vec          1
+#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_cmp_vec          1
+#define TCG_TARGET_HAS_mul_vec          0
+#define TCG_TARGET_HAS_sat_vec          1
+#define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       0
+
 void flush_icache_range(uintptr_t start, uintptr_t stop);
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
diff --git a/tcg/ppc/tcg-target.opc.h b/tcg/ppc/tcg-target.opc.h
new file mode 100644
index 0000000000..4816a6c3d4
--- /dev/null
+++ b/tcg/ppc/tcg-target.opc.h
@@ -0,0 +1,3 @@
+/* Target-specific opcodes for host vector expansion.  These will be
+   emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+   consider these to be UNSPEC with names.  */
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 30c095d3d5..479e653da6 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -42,6 +42,9 @@
 # define TCG_REG_TMP1   TCG_REG_R12
 #endif
 
+#define TCG_VEC_TMP1    TCG_REG_V0
+#define TCG_VEC_TMP2    TCG_REG_V1
+
 #define TCG_REG_TB     TCG_REG_R31
 #define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
 
@@ -61,6 +64,7 @@
 
 static tcg_insn_unit *tb_ret_addr;
 
+bool have_isa_altivec;
 bool have_isa_2_06;
 bool have_isa_3_00;
 
@@ -72,39 +76,15 @@ bool have_isa_3_00;
 #endif
 
 #ifdef CONFIG_DEBUG_TCG
-static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
-    "r0",
-    "r1",
-    "r2",
-    "r3",
-    "r4",
-    "r5",
-    "r6",
-    "r7",
-    "r8",
-    "r9",
-    "r10",
-    "r11",
-    "r12",
-    "r13",
-    "r14",
-    "r15",
-    "r16",
-    "r17",
-    "r18",
-    "r19",
-    "r20",
-    "r21",
-    "r22",
-    "r23",
-    "r24",
-    "r25",
-    "r26",
-    "r27",
-    "r28",
-    "r29",
-    "r30",
-    "r31"
+static const char tcg_target_reg_names[TCG_TARGET_NB_REGS][4] = {
+    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
+    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
+    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
+    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
+    "v0",  "v1",  "v2",  "v3",  "v4",  "v5",  "v6",  "v7",
+    "v8",  "v9",  "v10", "v11", "v12", "v13", "v14", "v15",
+    "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+    "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31",
 };
 #endif
 
@@ -139,6 +119,26 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_R5,
     TCG_REG_R4,
     TCG_REG_R3,
+
+    /* V0 and V1 reserved as temporaries; V20 - V31 are call-saved */
+    TCG_REG_V2,   /* call clobbered, vectors */
+    TCG_REG_V3,
+    TCG_REG_V4,
+    TCG_REG_V5,
+    TCG_REG_V6,
+    TCG_REG_V7,
+    TCG_REG_V8,
+    TCG_REG_V9,
+    TCG_REG_V10,
+    TCG_REG_V11,
+    TCG_REG_V12,
+    TCG_REG_V13,
+    TCG_REG_V14,
+    TCG_REG_V15,
+    TCG_REG_V16,
+    TCG_REG_V17,
+    TCG_REG_V18,
+    TCG_REG_V19,
 };
 
 static const int tcg_target_call_iarg_regs[] = {
@@ -233,6 +233,10 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         ct->ct |= TCG_CT_REG;
         ct->u.regs = 0xffffffff;
         break;
+    case 'v':
+        ct->ct |= TCG_CT_REG;
+        ct->u.regs = 0xffffffff00000000ull;
+        break;
     case 'L':                   /* qemu_ld constraint */
         ct->ct |= TCG_CT_REG;
         ct->u.regs = 0xffffffff;
@@ -320,6 +324,7 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define XO31(opc) (OPCD(31)|((opc)<<1))
 #define XO58(opc) (OPCD(58)|(opc))
 #define XO62(opc) (OPCD(62)|(opc))
+#define VX4(opc)  (OPCD(4)|(opc))
 
 #define B      OPCD( 18)
 #define BC     OPCD( 16)
@@ -461,6 +466,72 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 
 #define NOP    ORI  /* ori 0,0,0 */
 
+#define LVX        XO31(103)
+#define LVEBX      XO31(7)
+#define LVEHX      XO31(39)
+#define LVEWX      XO31(71)
+
+#define STVX       XO31(231)
+#define STVEWX     XO31(199)
+
+#define VADDSBS    VX4(768)
+#define VADDUBS    VX4(512)
+#define VADDUBM    VX4(0)
+#define VADDSHS    VX4(832)
+#define VADDUHS    VX4(576)
+#define VADDUHM    VX4(64)
+#define VADDSWS    VX4(896)
+#define VADDUWS    VX4(640)
+#define VADDUWM    VX4(128)
+
+#define VSUBSBS    VX4(1792)
+#define VSUBUBS    VX4(1536)
+#define VSUBUBM    VX4(1024)
+#define VSUBSHS    VX4(1856)
+#define VSUBUHS    VX4(1600)
+#define VSUBUHM    VX4(1088)
+#define VSUBSWS    VX4(1920)
+#define VSUBUWS    VX4(1664)
+#define VSUBUWM    VX4(1152)
+
+#define VMAXSB     VX4(258)
+#define VMAXSH     VX4(322)
+#define VMAXSW     VX4(386)
+#define VMAXUB     VX4(2)
+#define VMAXUH     VX4(66)
+#define VMAXUW     VX4(130)
+#define VMINSB     VX4(770)
+#define VMINSH     VX4(834)
+#define VMINSW     VX4(898)
+#define VMINUB     VX4(514)
+#define VMINUH     VX4(578)
+#define VMINUW     VX4(642)
+
+#define VCMPEQUB   VX4(6)
+#define VCMPEQUH   VX4(70)
+#define VCMPEQUW   VX4(134)
+#define VCMPGTSB   VX4(774)
+#define VCMPGTSH   VX4(838)
+#define VCMPGTSW   VX4(902)
+#define VCMPGTUB   VX4(518)
+#define VCMPGTUH   VX4(582)
+#define VCMPGTUW   VX4(646)
+
+#define VAND       VX4(1028)
+#define VANDC      VX4(1092)
+#define VNOR       VX4(1284)
+#define VOR        VX4(1156)
+#define VXOR       VX4(1220)
+
+#define VSPLTB     VX4(524)
+#define VSPLTH     VX4(588)
+#define VSPLTW     VX4(652)
+#define VSPLTISB   VX4(780)
+#define VSPLTISH   VX4(844)
+#define VSPLTISW   VX4(908)
+
+#define VSLDOI     VX4(44)
+
 #define RT(r) ((r)<<21)
 #define RS(r) ((r)<<21)
 #define RA(r) ((r)<<16)
@@ -473,6 +544,11 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define MB64(b) ((b)<<5)
 #define FXM(b) (1 << (19 - (b)))
 
+#define VRT(r)  (((r) & 31) << 21)
+#define VRA(r)  (((r) & 31) << 16)
+#define VRB(r)  (((r) & 31) << 11)
+#define VRC(r)  (((r) & 31) <<  6)
+
 #define LK    1
 
 #define TAB(t, a, b) (RT(t) | RA(a) | RB(b))
@@ -529,6 +605,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     tcg_insn_unit *target;
+    int16_t lo;
+    int32_t hi;
 
     value += addend;
     target = (tcg_insn_unit *)value;
@@ -550,6 +628,20 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         }
         *code_ptr = (*code_ptr & ~0xfffc) | (value & 0xfffc);
         break;
+    case R_PPC_ADDR32:
+        /*
+         * We are abusing this relocation type.  Again, this points to
+         * a pair of insns, lis + load.  This is an absolute address
+         * relocation for PPC32 so the lis cannot be removed.
+         */
+        lo = value;
+        hi = value - lo;
+        if (hi + lo != value) {
+            return false;
+        }
+        code_ptr[0] = deposit32(code_ptr[0], 0, 16, hi >> 16);
+        code_ptr[1] = deposit32(code_ptr[1], 0, 16, lo);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -561,9 +653,29 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
 
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
-    if (ret != arg) {
-        tcg_out32(s, OR | SAB(arg, ret, arg));
+    if (ret == arg) {
+        return true;
+    }
+    switch (type) {
+    case TCG_TYPE_I64:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+        /* fallthru */
+    case TCG_TYPE_I32:
+        if (ret < 32 && arg < 32) {
+            tcg_out32(s, OR | SAB(arg, ret, arg));
+            break;
+        } else if (ret < 32 || arg < 32) {
+            /* Altivec does not support vector/integer moves.  */
+            return false;
+        }
+        /* fallthru */
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= 32 && arg >= 32);
+        tcg_out32(s, VOR | VRT(ret) | VRA(arg) | VRB(arg));
+        break;
+    default:
+        g_assert_not_reached();
     }
     return true;
 }
@@ -712,10 +824,76 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 }
 
-static inline void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
-                                tcg_target_long arg)
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
+                             tcg_target_long val)
 {
-    tcg_out_movi_int(s, type, ret, arg, false);
+    uint32_t load_insn;
+    int rel, low;
+    intptr_t add;
+
+    low = (int8_t)val;
+    if (low >= -16 && low < 16) {
+        if (val == (tcg_target_long)dup_const(MO_8, low)) {
+            tcg_out32(s, VSPLTISB | VRT(ret) | ((val & 31) << 16));
+            return;
+        }
+        if (val == (tcg_target_long)dup_const(MO_16, low)) {
+            tcg_out32(s, VSPLTISH | VRT(ret) | ((val & 31) << 16));
+            return;
+        }
+        if (val == (tcg_target_long)dup_const(MO_32, low)) {
+            tcg_out32(s, VSPLTISW | VRT(ret) | ((val & 31) << 16));
+            return;
+        }
+    }
+
+    /*
+     * Otherwise we must load the value from the constant pool.
+     */
+    if (USE_REG_TB) {
+        rel = R_PPC_ADDR16;
+        add = -(intptr_t)s->code_gen_ptr;
+    } else {
+        rel = R_PPC_ADDR32;
+        add = 0;
+    }
+
+    load_insn = LVX | VRT(ret) | RB(TCG_REG_TMP1);
+    if (TCG_TARGET_REG_BITS == 64) {
+        new_pool_l2(s, rel, s->code_ptr, add, val, val);
+    } else {
+        new_pool_l4(s, rel, s->code_ptr, add, val, val, val, val);
+    }
+
+    if (USE_REG_TB) {
+        tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, 0, 0));
+        load_insn |= RA(TCG_REG_TB);
+    } else {
+        tcg_out32(s, ADDIS | TAI(TCG_REG_TMP1, 0, 0));
+        tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, TCG_REG_TMP1, 0));
+    }
+    tcg_out32(s, load_insn);
+}
+
+static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
+                         tcg_target_long arg)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_debug_assert(ret < 32);
+        tcg_out_movi_int(s, type, ret, arg, false);
+        break;
+
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= 32);
+        tcg_out_dupi_vec(s, type, ret, arg);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static bool mask_operand(uint32_t c, int *mb, int *me)
@@ -868,7 +1046,7 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
     }
 
     /* For unaligned, or very large offsets, use the indexed form.  */
-    if (offset & align || offset != (int32_t)offset) {
+    if (offset & align || offset != (int32_t)offset || opi == 0) {
         if (rs == base) {
             rs = TCG_REG_R0;
         }
@@ -899,32 +1077,96 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
     }
 }
 
-static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
-                              TCGReg arg1, intptr_t arg2)
+static void tcg_out_vsldoi(TCGContext *s, TCGReg ret,
+                           TCGReg va, TCGReg vb, int shb)
 {
-    int opi, opx;
-
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
-    if (type == TCG_TYPE_I32) {
-        opi = LWZ, opx = LWZX;
-    } else {
-        opi = LD, opx = LDX;
-    }
-    tcg_out_mem_long(s, opi, opx, ret, arg1, arg2);
+    tcg_out32(s, VSLDOI | VRT(ret) | VRA(va) | VRB(vb) | (shb << 6));
 }
 
-static inline void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
-                              TCGReg arg1, intptr_t arg2)
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
+                       TCGReg base, intptr_t offset)
 {
-    int opi, opx;
+    int shift;
 
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
-    if (type == TCG_TYPE_I32) {
-        opi = STW, opx = STWX;
-    } else {
-        opi = STD, opx = STDX;
+    switch (type) {
+    case TCG_TYPE_I32:
+        if (ret < 32) {
+            tcg_out_mem_long(s, LWZ, LWZX, ret, base, offset);
+            break;
+        }
+        assert((offset & 3) == 0);
+        tcg_out_mem_long(s, 0, LVEWX, ret & 31, base, offset);
+        shift = (offset - 4) & 0xc;
+        if (shift) {
+            tcg_out_vsldoi(s, ret, ret, ret, shift);
+        }
+        break;
+    case TCG_TYPE_I64:
+        if (ret < 32) {
+            tcg_out_mem_long(s, LD, LDX, ret, base, offset);
+            break;
+        }
+        /* fallthru */
+    case TCG_TYPE_V64:
+        tcg_debug_assert(ret >= 32);
+        assert((offset & 7) == 0);
+        tcg_out_mem_long(s, 0, LVX, ret & 31, base, offset & -16);
+        if (offset & 8) {
+            tcg_out_vsldoi(s, ret, ret, ret, 8);
+        }
+        break;
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= 32);
+        assert((offset & 15) == 0);
+        tcg_out_mem_long(s, 0, LVX, ret & 31, base, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
+                              TCGReg base, intptr_t offset)
+{
+    int shift;
+
+    switch (type) {
+    case TCG_TYPE_I32:
+        if (arg < 32) {
+            tcg_out_mem_long(s, STW, STWX, arg, base, offset);
+            break;
+        }
+        assert((offset & 3) == 0);
+        shift = (offset - 4) & 0xc;
+        if (shift) {
+            tcg_out_vsldoi(s, TCG_VEC_TMP1, arg, arg, shift);
+            arg = TCG_VEC_TMP1;
+        }
+        tcg_out_mem_long(s, 0, STVEWX, arg & 31, base, offset);
+        break;
+    case TCG_TYPE_I64:
+        if (arg < 32) {
+            tcg_out_mem_long(s, STD, STDX, arg, base, offset);
+            break;
+        }
+        /* fallthru */
+    case TCG_TYPE_V64:
+        tcg_debug_assert(arg >= 32);
+        assert((offset & 7) == 0);
+        if (offset & 8) {
+            tcg_out_vsldoi(s, TCG_VEC_TMP1, arg, arg, 8);
+            arg = TCG_VEC_TMP1;
+        }
+        tcg_out_mem_long(s, 0, STVEWX, arg & 31, base, offset);
+        tcg_out_mem_long(s, 0, STVEWX, arg & 31, base, offset + 4);
+        break;
+    case TCG_TYPE_V128:
+        tcg_debug_assert(arg >= 32);
+        tcg_out_mem_long(s, 0, STVX, arg & 31, base, offset);
+        break;
+    default:
+        g_assert_not_reached();
     }
-    tcg_out_mem_long(s, opi, opx, arg, arg1, arg2);
 }
 
 static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
@@ -2616,6 +2858,292 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
     }
 }
 
+int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
+{
+    switch (opc) {
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_not_vec:
+        return 1;
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
+        return vece <= MO_32;
+    case INDEX_op_cmp_vec:
+        return vece <= MO_32 ? -1 : 0;
+    default:
+        return 0;
+    }
+}
+
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                            TCGReg dst, TCGReg src)
+{
+    tcg_debug_assert(dst >= 32);
+    tcg_debug_assert(src >= 32);
+
+    /*
+     * Recall we use (or emulate) VSX integer loads, so the integer is
+     * right justified within the left (zero-index) double-word.
+     */
+    switch (vece) {
+    case MO_8:
+        tcg_out32(s, VSPLTB | VRT(dst) | VRB(src) | (7 << 16));
+        break;
+    case MO_16:
+        tcg_out32(s, VSPLTH | VRT(dst) | VRB(src) | (3 << 16));
+        break;
+    case MO_32:
+        tcg_out32(s, VSPLTW | VRT(dst) | VRB(src) | (1 << 16));
+        break;
+    case MO_64:
+        tcg_out_vsldoi(s, TCG_VEC_TMP1, src, src, 8);
+        tcg_out_vsldoi(s, dst, TCG_VEC_TMP1, src, 8);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
+}
+
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg out, TCGReg base, intptr_t offset)
+{
+    int elt;
+
+    tcg_debug_assert(out >= 32);
+    out &= 31;
+    switch (vece) {
+    case MO_8:
+        tcg_out_mem_long(s, 0, LVEBX, out, base, offset);
+        elt = extract32(offset, 0, 4);
+#ifndef HOST_WORDS_BIGENDIAN
+        elt ^= 15;
+#endif
+        tcg_out32(s, VSPLTB | VRT(out) | VRB(out) | (elt << 16));
+        break;
+    case MO_16:
+        assert((offset & 1) == 0);
+        tcg_out_mem_long(s, 0, LVEHX, out, base, offset);
+        elt = extract32(offset, 1, 3);
+#ifndef HOST_WORDS_BIGENDIAN
+        elt ^= 7;
+#endif
+        tcg_out32(s, VSPLTH | VRT(out) | VRB(out) | (elt << 16));
+        break;
+    case MO_32:
+        assert((offset & 3) == 0);
+        tcg_out_mem_long(s, 0, LVEWX, out, base, offset);
+        elt = extract32(offset, 2, 2);
+#ifndef HOST_WORDS_BIGENDIAN
+        elt ^= 3;
+#endif
+        tcg_out32(s, VSPLTW | VRT(out) | VRB(out) | (elt << 16));
+        break;
+    case MO_64:
+        assert((offset & 7) == 0);
+        tcg_out_mem_long(s, 0, LVX, out, base, offset & -16);
+        tcg_out_vsldoi(s, TCG_VEC_TMP1, out, out, 8);
+        elt = extract32(offset, 3, 1);
+#ifndef HOST_WORDS_BIGENDIAN
+        elt = !elt;
+#endif
+        if (elt) {
+            tcg_out_vsldoi(s, out, out, TCG_VEC_TMP1, 8);
+        } else {
+            tcg_out_vsldoi(s, out, TCG_VEC_TMP1, out, 8);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
+}
+
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
+                           unsigned vecl, unsigned vece,
+                           const TCGArg *args, const int *const_args)
+{
+    static const uint32_t
+        add_op[4] = { VADDUBM, VADDUHM, VADDUWM, 0 },
+        sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, 0 },
+        eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, 0 },
+        gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, 0 },
+        gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, 0 },
+        ssadd_op[4] = { VADDSBS, VADDSHS, VADDSWS, 0 },
+        usadd_op[4] = { VADDUBS, VADDUHS, VADDUWS, 0 },
+        sssub_op[4] = { VSUBSBS, VSUBSHS, VSUBSWS, 0 },
+        ussub_op[4] = { VSUBUBS, VSUBUHS, VSUBUWS, 0 },
+        umin_op[4] = { VMINUB, VMINUH, VMINUW, 0 },
+        smin_op[4] = { VMINSB, VMINSH, VMINSW, 0 },
+        umax_op[4] = { VMAXUB, VMAXUH, VMAXUW, 0 },
+        smax_op[4] = { VMAXSB, VMAXSH, VMAXSW, 0 };
+
+    TCGType type = vecl + TCG_TYPE_V64;
+    TCGArg a0 = args[0], a1 = args[1], a2 = args[2];
+    uint32_t insn;
+
+    switch (opc) {
+    case INDEX_op_ld_vec:
+        tcg_out_ld(s, type, a0, a1, a2);
+        return;
+    case INDEX_op_st_vec:
+        tcg_out_st(s, type, a0, a1, a2);
+        return;
+    case INDEX_op_dupm_vec:
+        tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
+        return;
+
+    case INDEX_op_add_vec:
+        insn = add_op[vece];
+        break;
+    case INDEX_op_sub_vec:
+        insn = sub_op[vece];
+        break;
+    case INDEX_op_ssadd_vec:
+        insn = ssadd_op[vece];
+        break;
+    case INDEX_op_sssub_vec:
+        insn = sssub_op[vece];
+        break;
+    case INDEX_op_usadd_vec:
+        insn = usadd_op[vece];
+        break;
+    case INDEX_op_ussub_vec:
+        insn = ussub_op[vece];
+        break;
+    case INDEX_op_smin_vec:
+        insn = smin_op[vece];
+        break;
+    case INDEX_op_umin_vec:
+        insn = umin_op[vece];
+        break;
+    case INDEX_op_smax_vec:
+        insn = smax_op[vece];
+        break;
+    case INDEX_op_umax_vec:
+        insn = umax_op[vece];
+        break;
+    case INDEX_op_and_vec:
+        insn = VAND;
+        break;
+    case INDEX_op_or_vec:
+        insn = VOR;
+        break;
+    case INDEX_op_xor_vec:
+        insn = VXOR;
+        break;
+    case INDEX_op_andc_vec:
+        insn = VANDC;
+        break;
+    case INDEX_op_not_vec:
+        insn = VNOR;
+        a2 = a1;
+        break;
+
+    case INDEX_op_cmp_vec:
+        switch (args[3]) {
+        case TCG_COND_EQ:
+            insn = eq_op[vece];
+            break;
+        case TCG_COND_GT:
+            insn = gts_op[vece];
+            break;
+        case TCG_COND_GTU:
+            insn = gtu_op[vece];
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
+    case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
+    default:
+        g_assert_not_reached();
+    }
+
+    tcg_debug_assert(insn != 0);
+    tcg_out32(s, insn | VRT(a0) | VRA(a1) | VRB(a2));
+}
+
+static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
+                           TCGv_vec v1, TCGv_vec v2, TCGCond cond)
+{
+    bool need_swap = false, need_inv = false;
+
+    tcg_debug_assert(vece <= MO_32);
+
+    switch (cond) {
+    case TCG_COND_EQ:
+    case TCG_COND_GT:
+    case TCG_COND_GTU:
+        break;
+    case TCG_COND_NE:
+    case TCG_COND_LE:
+    case TCG_COND_LEU:
+        need_inv = true;
+        break;
+    case TCG_COND_LT:
+    case TCG_COND_LTU:
+        need_swap = true;
+        break;
+    case TCG_COND_GE:
+    case TCG_COND_GEU:
+        need_swap = need_inv = true;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (need_inv) {
+        cond = tcg_invert_cond(cond);
+    }
+    if (need_swap) {
+        TCGv_vec t1;
+        t1 = v1, v1 = v2, v2 = t1;
+        cond = tcg_swap_cond(cond);
+    }
+
+    vec_gen_4(INDEX_op_cmp_vec, type, vece, tcgv_vec_arg(v0),
+              tcgv_vec_arg(v1), tcgv_vec_arg(v2), cond);
+
+    if (need_inv) {
+        tcg_gen_not_vec(vece, v0, v0);
+    }
+}
+
+void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
+                       TCGArg a0, ...)
+{
+    va_list va;
+    TCGv_vec v0, v1, v2;
+
+    va_start(va, a0);
+    v0 = temp_tcgv_vec(arg_temp(a0));
+    v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+    v2 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+
+    switch (opc) {
+    case INDEX_op_cmp_vec:
+        expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    va_end(va);
+}
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
     static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
@@ -2653,6 +3181,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "r", "r", "rI", "rZM" } };
     static const TCGTargetOpDef sub2
         = { .args_ct_str = { "r", "r", "rI", "rZM", "r", "r" } };
+    static const TCGTargetOpDef v_r = { .args_ct_str = { "v", "r" } };
+    static const TCGTargetOpDef v_v = { .args_ct_str = { "v", "v" } };
+    static const TCGTargetOpDef v_v_v = { .args_ct_str = { "v", "v", "v" } };
 
     switch (op) {
     case INDEX_op_goto_ptr:
@@ -2788,6 +3319,32 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return (TCG_TARGET_REG_BITS == 64 ? &S_S
                 : TARGET_LONG_BITS == 32 ? &S_S_S : &S_S_S_S);
 
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_mul_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_orc_vec:
+    case INDEX_op_cmp_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
+        return &v_v_v;
+    case INDEX_op_not_vec:
+    case INDEX_op_dup_vec:
+        return &v_v;
+    case INDEX_op_ld_vec:
+    case INDEX_op_st_vec:
+    case INDEX_op_dupm_vec:
+        return &v_r;
+
     default:
         return NULL;
     }
@@ -2798,6 +3355,9 @@ static void tcg_target_init(TCGContext *s)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
 
+    if (hwcap & PPC_FEATURE_HAS_ALTIVEC) {
+        have_isa_altivec = true;
+    }
     if (hwcap & PPC_FEATURE_ARCH_2_06) {
         have_isa_2_06 = true;
     }
@@ -2809,6 +3369,10 @@ static void tcg_target_init(TCGContext *s)
 
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
+    if (have_isa_altivec) {
+        tcg_target_available_regs[TCG_TYPE_V64] = 0xffffffff00000000ull;
+        tcg_target_available_regs[TCG_TYPE_V128] = 0xffffffff00000000ull;
+    }
 
     tcg_target_call_clobber_regs = 0;
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R0);
@@ -2824,6 +3388,27 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R11);
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R12);
 
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V0);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V1);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V2);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V3);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V4);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V5);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V6);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V7);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V8);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V9);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V10);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V11);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V12);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V13);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V14);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V15);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V16);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V17);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V18);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V19);
+
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R0); /* tcg temp */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R1); /* stack pointer */
@@ -2834,6 +3419,8 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R13); /* thread pointer */
 #endif
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP1); /* mem temp */
+    tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP1);
+    tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP2);
     if (USE_REG_TB) {
         tcg_regset_set_reg(s->reserved_regs, TCG_REG_TB);  /* tb->tc_ptr */
     }
-- 
2.17.1


