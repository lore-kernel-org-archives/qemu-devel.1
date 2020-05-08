Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91891C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0D820725
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fvha3XBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0D820725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5Sq-0008TW-DX
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Ns-0000aM-6W
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:57:56 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Np-0008Rn-Li
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:57:55 -0400
Received: by mail-pj1-x1041.google.com with SMTP id a5so4487544pjh.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cQR0DnnbxGaY78EvOLIZ4VmiNRAasi9kA4MIU1TaSUQ=;
 b=Fvha3XBoKiw8K30DK0VlPdjktUioOqxeJQG47h8ZCF4iTq4aGs4fVkIzSqN603q5is
 DiueX7fHGW98DcmBczfr8p+eCj5LeZ5RBMD7DmNq5cSin4zlDqvY/xG71a/r7j9/OEiK
 pzCX/7sLHHFxn/oO/BOt7iUkLNC5GOXskHAsQasUD4T7FEHeiRQNwBVVUBEVEvscVJ+O
 CcAMoDvuicJOp4gKrazxw1xF7TsHYvKP9r6qQPiiu8W/0diCbaH+Lzf8jQPG5XR8IAiG
 We4VMmuOVFkq0yGONZLJe8vopZcUsN7s/L1uijw10OxNHcEHykEjLh7rPQTm2S7sj/8o
 kIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cQR0DnnbxGaY78EvOLIZ4VmiNRAasi9kA4MIU1TaSUQ=;
 b=p3QLUXJW8VKBVhlbLYHvKFOQsh7ZTDL/EUNjbzmoR6t9OORmQsGD6BKUtl2P/d3geA
 XZGC+JWNEjiM0kti4pgVNAeS7lN+zzi3ymDuAbQamJ3K/f0UJabFul7/cU9fR4zFQCao
 nkOv2RPOeN7HNomyfCuoOYER61hPmXny4wzuPe6yVGRhwwcSPsb0R0MpSt0VanaXld1S
 iEqjBIGejk2qJy6uK/v6q6u1tpEr1nBtOftry2yqYzJygc8o8OtXy3SC6W9xnTt80UQt
 VC2ZIEv7JRdiZszGuH2Fpe6uUJsO080WkjfP8ApJKX0QkFC8Rpj265+9QV6RFcd+k8Io
 NBRg==
X-Gm-Message-State: AGi0PuYWpRI3at6cpeNduF7t9NLi/SOt7KTVlKrOr8X/kLAvfuvmRcVG
 et0+eX0nMeQ1uO5s71cRv9k18CaB9zc=
X-Google-Smtp-Source: APiQypKSc1siqpgS8u0st9/vzwxl/IWdhxzGPa/FK2pPr9mpkuGtFW6+kDXNznC2KXS2xSHGWEHR3Q==
X-Received: by 2002:a17:90b:3887:: with SMTP id
 mu7mr6520054pjb.168.1588953471294; 
 Fri, 08 May 2020 08:57:51 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id z7sm2141601pff.47.2020.05.08.08.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:57:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] tcg/s390: Implement vector operations
Date: Fri,  8 May 2020 08:57:45 -0700
Message-Id: <20200508155745.8223-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508155745.8223-1-richard.henderson@linaro.org>
References: <20200508155745.8223-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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

From z13, s390x has 128-bit vectors.  The ISA is quite regular
and easy to support under tcg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390/tcg-target.h     |  37 +-
 tcg/s390/tcg-target.opc.h |   5 +
 tcg/s390/tcg-target.inc.c | 790 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 807 insertions(+), 25 deletions(-)
 create mode 100644 tcg/s390/tcg-target.opc.h

diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 1e67c90ed2..9b98119969 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -34,11 +34,20 @@ typedef enum TCGReg {
     TCG_REG_R8,  TCG_REG_R9,  TCG_REG_R10, TCG_REG_R11,
     TCG_REG_R12, TCG_REG_R13, TCG_REG_R14, TCG_REG_R15,
 
+    TCG_REG_V0 = 32, TCG_REG_V1,  TCG_REG_V2,  TCG_REG_V3,
+    TCG_REG_V4,  TCG_REG_V5,  TCG_REG_V6,  TCG_REG_V7,
+    TCG_REG_V8,  TCG_REG_V9,  TCG_REG_V10, TCG_REG_V11,
+    TCG_REG_V12, TCG_REG_V13, TCG_REG_V14, TCG_REG_V15,
+    TCG_REG_V16, TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
+    TCG_REG_V20, TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
+    TCG_REG_V24, TCG_REG_V25, TCG_REG_V26, TCG_REG_V27,
+    TCG_REG_V28, TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
+
     TCG_AREG0 = TCG_REG_R10,
     TCG_REG_CALL_STACK = TCG_REG_R15
 } TCGReg;
 
-#define TCG_TARGET_NB_REGS 16
+#define TCG_TARGET_NB_REGS 64
 
 /* A list of relevant facilities used by this translator.  Some of these
    are required for proper operation, and these are checked at startup.  */
@@ -51,8 +60,10 @@ typedef enum TCGReg {
 #define FACILITY_FAST_BCR_SER         FACILITY_LOAD_ON_COND
 #define FACILITY_DISTINCT_OPS         FACILITY_LOAD_ON_COND
 #define FACILITY_LOAD_ON_COND2        53
+#define FACILITY_VECTOR               129
+#define FACILITY_VECTOR_EXT1          135
 
-extern uint64_t s390_facilities[1];
+extern uint64_t s390_facilities[3];
 
 #define FACILITY(X) \
     ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
@@ -125,6 +136,28 @@ extern uint64_t s390_facilities[1];
 #define TCG_TARGET_HAS_muluh_i64      0
 #define TCG_TARGET_HAS_mulsh_i64      0
 
+#define TCG_TARGET_HAS_v64            FACILITY(VECTOR)
+#define TCG_TARGET_HAS_v128           FACILITY(VECTOR)
+#define TCG_TARGET_HAS_v256           0
+
+#define TCG_TARGET_HAS_andc_vec       1
+#define TCG_TARGET_HAS_orc_vec        0
+#define TCG_TARGET_HAS_not_vec        1
+#define TCG_TARGET_HAS_neg_vec        1
+#define TCG_TARGET_HAS_abs_vec        1
+#define TCG_TARGET_HAS_roti_vec       1
+#define TCG_TARGET_HAS_rots_vec       1
+#define TCG_TARGET_HAS_rotv_vec       1
+#define TCG_TARGET_HAS_shi_vec        1
+#define TCG_TARGET_HAS_shs_vec        1
+#define TCG_TARGET_HAS_shv_vec        1
+#define TCG_TARGET_HAS_cmp_vec        1
+#define TCG_TARGET_HAS_mul_vec        1
+#define TCG_TARGET_HAS_sat_vec        1
+#define TCG_TARGET_HAS_minmax_vec     1
+#define TCG_TARGET_HAS_bitsel_vec     1
+#define TCG_TARGET_HAS_cmpsel_vec     0
+
 /* used for function call generation */
 #define TCG_TARGET_STACK_ALIGN		8
 #define TCG_TARGET_CALL_STACK_OFFSET	160
diff --git a/tcg/s390/tcg-target.opc.h b/tcg/s390/tcg-target.opc.h
new file mode 100644
index 0000000000..fa680dd6a0
--- /dev/null
+++ b/tcg/s390/tcg-target.opc.h
@@ -0,0 +1,5 @@
+/*
+ * Target-specific opcodes for host vector expansion.  These will be
+ * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+ * consider these to be UNSPEC with names.
+ */
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 123286857f..6f05aab8af 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -250,13 +250,63 @@ typedef enum S390Opcode {
     RX_STC      = 0x42,
     RX_STH      = 0x40,
 
+    VRIa_VGBM   = 0xe744,
+    VRIa_VREPI  = 0xe745,
+    VRIb_VGM    = 0xe746,
+    VRIc_VREP   = 0xe74d,
+
+    VRRa_VLC    = 0xe7de,
+    VRRa_VLP    = 0xe7df,
+    VRRa_VLR    = 0xe756,
+    VRRc_VA     = 0xe7f3,
+    VRRc_VCEQ   = 0xe7f8,   /* we leave the m5 cs field 0 */
+    VRRc_VCH    = 0xe7fb,   /* " */
+    VRRc_VCHL   = 0xe7f9,   /* " */
+    VRRc_VERLLV = 0xe773,
+    VRRc_VESLV  = 0xe770,
+    VRRc_VESRAV = 0xe77a,
+    VRRc_VESRLV = 0xe778,
+    VRRc_VMN    = 0xe7fe,
+    VRRc_VMNL   = 0xe7fc,
+    VRRc_VML    = 0xe7a2,
+    VRRc_VMX    = 0xe7ff,
+    VRRc_VMXL   = 0xe7fd,
+    VRRc_VN     = 0xe768,
+    VRRc_VNC    = 0xe769,
+    VRRc_VNO    = 0xe76b,
+    VRRc_VO     = 0xe76a,
+    VRRc_VS     = 0xe7f7,
+    VRRc_VX     = 0xe76d,
+    VRRe_VSEL   = 0xe78d,
+    VRRf_VLVGP  = 0xe762,
+
+    VRSa_VERLL  = 0xe733,
+    VRSa_VESL   = 0xe730,
+    VRSa_VESRA  = 0xe73a,
+    VRSa_VESRL  = 0xe738,
+    VRSb_VLVG   = 0xe722,
+    VRSc_VLGV   = 0xe721,
+
+    VRX_VL      = 0xe706,
+    VRX_VLLEZ   = 0xe704,
+    VRX_VLREP   = 0xe705,
+    VRX_VST     = 0xe70e,
+    VRX_VSTEF   = 0xe70b,
+    VRX_VSTEG   = 0xe70a,
+
     NOP         = 0x0707,
 } S390Opcode;
 
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
-    "%r0", "%r1", "%r2", "%r3", "%r4", "%r5", "%r6", "%r7",
-    "%r8", "%r9", "%r10" "%r11" "%r12" "%r13" "%r14" "%r15"
+    "%r0",  "%r1",  "%r2",  "%r3",  "%r4",  "%r5",  "%r6",  "%r7",
+    "%r8",  "%r9",  "%r10", "%r11", "%r12", "%r13", "%r14", "%r15",
+    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+    "%v0",  "%v1",  "%v2",  "%v3",  "%v4",  "%v5",  "%v6",  "%v7",
+    "%v8",  "%v9",  "%v10", "%v11", "%v12", "%v13", "%v14", "%v15",
+    "%v16", "%v17", "%v18", "%v19", "%v20", "%v21", "%v22", "%v23",
+    "%v24", "%v25", "%v26", "%v27", "%v28", "%v29", "%v30", "%v31",
+
 };
 #endif
 
@@ -282,6 +332,32 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_R4,
     TCG_REG_R3,
     TCG_REG_R2,
+
+    /* V8-V15 are call saved, and omitted. */
+    TCG_REG_V0,
+    TCG_REG_V1,
+    TCG_REG_V2,
+    TCG_REG_V3,
+    TCG_REG_V4,
+    TCG_REG_V5,
+    TCG_REG_V6,
+    TCG_REG_V7,
+    TCG_REG_V16,
+    TCG_REG_V17,
+    TCG_REG_V18,
+    TCG_REG_V19,
+    TCG_REG_V20,
+    TCG_REG_V21,
+    TCG_REG_V22,
+    TCG_REG_V23,
+    TCG_REG_V24,
+    TCG_REG_V25,
+    TCG_REG_V26,
+    TCG_REG_V27,
+    TCG_REG_V28,
+    TCG_REG_V29,
+    TCG_REG_V30,
+    TCG_REG_V31,
 };
 
 static const int tcg_target_call_iarg_regs[] = {
@@ -364,7 +440,9 @@ static void * const qemu_st_helpers[16] = {
 #endif
 
 static tcg_insn_unit *tb_ret_addr;
-uint64_t s390_facilities[1];
+uint64_t s390_facilities[3];
+
+static bool risbg_mask(uint64_t c);
 
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
@@ -411,6 +489,10 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         ct->ct |= TCG_CT_REG;
         ct->u.regs = 0xffff;
         break;
+    case 'v':
+        ct->ct |= TCG_CT_REG;
+        ct->u.regs = 0xffffffff00000000ull;
+        break;
     case 'L':                  /* qemu_ld/st constraint */
         ct->ct |= TCG_CT_REG;
         ct->u.regs = 0xffff;
@@ -529,6 +611,133 @@ static void tcg_out_insn_RSY(TCGContext *s, S390Opcode op, TCGReg r1,
 #define tcg_out_insn_RX   tcg_out_insn_RS
 #define tcg_out_insn_RXY  tcg_out_insn_RSY
 
+static int RXB(TCGReg v1, TCGReg v2, TCGReg v3, TCGReg v4)
+{
+    return ((v1 & 16) << (7 - 3))
+         | ((v2 & 16) << (6 - 3))
+         | ((v3 & 16) << (5 - 3))
+         | ((v4 & 16) << (4 - 3));
+}
+
+static void tcg_out_insn_VRIa(TCGContext *s, S390Opcode op,
+                              TCGReg v1, uint16_t i2, int m3)
+{
+    tcg_debug_assert(v1 >= TCG_REG_V0 && v1 <= TCG_REG_V31);
+    tcg_out16(s, (op & 0xff00) | ((v1 & 15) << 4));
+    tcg_out16(s, i2);
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, 0, 0) | (m3 << 12));
+}
+
+static void tcg_out_insn_VRIb(TCGContext *s, S390Opcode op,
+                              TCGReg v1, uint8_t i2, uint8_t i3, int m4)
+{
+    tcg_debug_assert(v1 >= TCG_REG_V0 && v1 <= TCG_REG_V31);
+    tcg_out16(s, (op & 0xff00) | ((v1 & 15) << 4));
+    tcg_out16(s, (i2 << 8) | (i3 & 0xff));
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, 0, 0) | (m4 << 12));
+}
+
+static void tcg_out_insn_VRIc(TCGContext *s, S390Opcode op,
+                              TCGReg v1, uint16_t i2, TCGReg v3, int m4)
+{
+    tcg_debug_assert(v1 >= TCG_REG_V0 && v1 <= TCG_REG_V31);
+    tcg_debug_assert(v3 >= TCG_REG_V0 && v3 <= TCG_REG_V31);
+    tcg_out16(s, (op & 0xff00) | ((v1 & 15) << 4) | (v3 & 15));
+    tcg_out16(s, i2);
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, v3, 0) | (m4 << 12));
+}
+
+static void tcg_out_insn_VRRa(TCGContext *s, S390Opcode op,
+                              TCGReg v1, TCGReg v2, int m3)
+{
+    tcg_debug_assert(v1 >= TCG_REG_V0 && v1 <= TCG_REG_V31);
+    tcg_debug_assert(v2 >= TCG_REG_V0 && v2 <= TCG_REG_V31);
+    tcg_out16(s, (op & 0xff00) | ((v1 & 15) << 4) | (v2 & 15));
+    tcg_out32(s, (op & 0x00ff) | RXB(v1, v2, 0, 0) | (m3 << 12));
+}
+
+static void tcg_out_insn_VRRc(TCGContext *s, S390Opcode op,
+                              TCGReg v1, TCGReg v2, TCGReg v3, int m4)
+{
+    tcg_debug_assert(v1 >= TCG_REG_V0 && v1 <= TCG_REG_V31);
+    tcg_debug_assert(v2 >= TCG_REG_V0 && v2 <= TCG_REG_V31);
+    tcg_debug_assert(v3 >= TCG_REG_V0 && v3 <= TCG_REG_V31);
+    tcg_out16(s, (op & 0xff00) | ((v1 & 15) << 4) | (v2 & 15));
+    tcg_out16(s, v3 << 12);
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, v2, v3, 0) | (m4 << 12));
+}
+
+static void tcg_out_insn_VRRe(TCGContext *s, S390Opcode op,
+                              TCGReg v1, TCGReg v2, TCGReg v3, TCGReg v4)
+{
+    tcg_debug_assert(v1 >= TCG_REG_V0 && v1 <= TCG_REG_V31);
+    tcg_debug_assert(v2 >= TCG_REG_V0 && v2 <= TCG_REG_V31);
+    tcg_debug_assert(v3 >= TCG_REG_V0 && v3 <= TCG_REG_V31);
+    tcg_debug_assert(v4 >= TCG_REG_V0 && v4 <= TCG_REG_V31);
+    tcg_out16(s, (op & 0xff00) | ((v1 & 15) << 4) | (v2 & 15));
+    tcg_out16(s, v3 << 12);
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, v2, v3, v4) | ((v4 & 15) << 12));
+}
+
+static void tcg_out_insn_VRRf(TCGContext *s, S390Opcode op,
+                              TCGReg v1, TCGReg r2, TCGReg r3)
+{
+    tcg_debug_assert(v1 >= TCG_REG_V0 && v1 <= TCG_REG_V31);
+    tcg_debug_assert(r2 <= TCG_REG_R15);
+    tcg_debug_assert(r3 <= TCG_REG_R15);
+    tcg_out16(s, (op & 0xff00) | ((v1 & 15) << 4) | r2);
+    tcg_out16(s, r3 << 12);
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, 0, 0));
+}
+
+static void tcg_out_insn_VRSa(TCGContext *s, S390Opcode op, TCGReg v1,
+                              intptr_t d2, TCGReg b2, TCGReg v3, int m4)
+{
+    tcg_debug_assert(v1 >= TCG_REG_V0 && v1 <= TCG_REG_V31);
+    tcg_debug_assert(d2 >= 0 && d2 <= 0xfff);
+    tcg_debug_assert(b2 <= TCG_REG_R15);
+    tcg_debug_assert(v3 >= TCG_REG_V0 && v3 <= TCG_REG_V31);
+    tcg_out16(s, (op & 0xff00) | ((v1 & 15) << 4) | (v3 & 15));
+    tcg_out16(s, b2 << 12 | d2);
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, v3, 0) | (m4 << 12));
+}
+
+static void tcg_out_insn_VRSb(TCGContext *s, S390Opcode op, TCGReg v1,
+                              intptr_t d2, TCGReg b2, TCGReg r3, int m4)
+{
+    tcg_debug_assert(v1 >= TCG_REG_V0 && v1 <= TCG_REG_V31);
+    tcg_debug_assert(d2 >= 0 && d2 <= 0xfff);
+    tcg_debug_assert(b2 <= TCG_REG_R15);
+    tcg_debug_assert(r3 <= TCG_REG_R15);
+    tcg_out16(s, (op & 0xff00) | ((v1 & 15) << 4) | r3);
+    tcg_out16(s, b2 << 12 | d2);
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, 0, 0) | (m4 << 12));
+}
+
+static void tcg_out_insn_VRSc(TCGContext *s, S390Opcode op, TCGReg r1,
+                              intptr_t d2, TCGReg b2, TCGReg v3, int m4)
+{
+    tcg_debug_assert(r1 <= TCG_REG_R15);
+    tcg_debug_assert(d2 >= 0 && d2 <= 0xfff);
+    tcg_debug_assert(b2 <= TCG_REG_R15);
+    tcg_debug_assert(v3 >= TCG_REG_V0 && v3 <= TCG_REG_V31);
+    tcg_out16(s, (op & 0xff00) | (r1 << 4) | (v3 & 15));
+    tcg_out16(s, b2 << 12 | d2);
+    tcg_out16(s, (op & 0x00ff) | RXB(0, 0, v3, 0) | (m4 << 12));
+}
+
+static void tcg_out_insn_VRX(TCGContext *s, S390Opcode op, TCGReg v1,
+                             TCGReg b2, TCGReg x2, intptr_t d2, int m3)
+{
+    tcg_debug_assert(v1 >= TCG_REG_V0 && v1 <= TCG_REG_V31);
+    tcg_debug_assert(d2 >= 0 && d2 <= 0xfff);
+    tcg_debug_assert(x2 <= TCG_REG_R15);
+    tcg_debug_assert(b2 <= TCG_REG_R15);
+    tcg_out16(s, (op & 0xff00) | ((v1 & 15) << 4) | x2);
+    tcg_out16(s, (b2 << 12) | d2);
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, 0, 0) | (m3 << 12));
+}
+
 /* Emit an opcode with "type-checking" of the format.  */
 #define tcg_out_insn(S, FMT, OP, ...) \
     glue(tcg_out_insn_,FMT)(S, glue(glue(FMT,_),OP), ## __VA_ARGS__)
@@ -550,12 +759,38 @@ static void tcg_out_sh32(TCGContext* s, S390Opcode op, TCGReg dest,
 
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
 {
-    if (src != dst) {
-        if (type == TCG_TYPE_I32) {
+    if (src == dst) {
+        return true;
+    }
+    switch (type) {
+    case TCG_TYPE_I32:
+        if (likely(dst < 16 && src < 16)) {
             tcg_out_insn(s, RR, LR, dst, src);
-        } else {
-            tcg_out_insn(s, RRE, LGR, dst, src);
+            break;
         }
+        /* fallthru */
+
+    case TCG_TYPE_I64:
+        if (likely(dst < 16)) {
+            if (likely(src < 16)) {
+                tcg_out_insn(s, RRE, LGR, dst, src);
+            } else {
+                tcg_out_insn(s, VRSc, VLGV, dst, 0, 0, src, 3);
+            }
+            break;
+        } else if (src < 16) {
+            tcg_out_insn(s, VRSb, VLVG, dst, 0, 0, src, 3);
+            break;
+        }
+        /* fallthru */
+
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+        tcg_out_insn(s, VRRa, VLR, dst, src, 0);
+        break;
+
+    default:
+        g_assert_not_reached();
     }
     return true;
 }
@@ -668,10 +903,101 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 }
 
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
+                             tcg_target_long val)
+{
+    MemOp es = MO_64;
+    int i, mask, msb, lsb;
+
+    /* Look for int16_t elements.  */
+    if (val == (tcg_target_long)dup_const(MO_8, val)) {
+        tcg_out_insn(s, VRIa, VREPI, ret, val, MO_8);
+        return;
+    }
+    if (val == (tcg_target_long)dup_const(MO_16, val)) {
+        tcg_out_insn(s, VRIa, VREPI, ret, val, MO_16);
+        return;
+    }
+    if (val == (tcg_target_long)dup_const(MO_32, val)) {
+        es = MO_32;
+        if ((int32_t)val == (int16_t)val) {
+            tcg_out_insn(s, VRIa, VREPI, ret, val, MO_32);
+            return;
+        }
+    } else if (val == (int16_t)val) {
+        tcg_out_insn(s, VRIa, VREPI, ret, val, MO_64);
+        return;
+    }
+
+    /* Look for bit masks.  */
+    if (es == MO_32) {
+        if (risbg_mask((int32_t)val)) {
+            /* Handle wraparound by swapping msb and lsb.  */
+            if ((val & 0x80000001u) == 0x80000001u) {
+                msb = 32 - ctz32(~val);
+                lsb = clz32(~val) - 1;
+            } else {
+                msb = clz32(val);
+                lsb = 31 - ctz32(val);
+            }
+            tcg_out_insn(s, VRIb, VGM, ret, lsb, msb, MO_32);
+            return;
+        }
+    } else {
+        if (risbg_mask(val)) {
+            /* Handle wraparound by swapping msb and lsb.  */
+            if ((val & 0x8000000000000001ull) == 0x8000000000000001ull) {
+                /* Handle wraparound by swapping msb and lsb.  */
+                msb = 64 - ctz64(~val);
+                lsb = clz64(~val) - 1;
+            } else {
+                msb = clz64(val);
+                lsb = 63 - ctz64(val);
+            }
+            tcg_out_insn(s, VRIb, VGM, ret, lsb, msb, MO_64);
+            return;
+        }
+    }
+
+    /* Look for all bytes 0x00 or 0xff.  */
+    for (i = mask = 0; i < 8; i++) {
+        uint8_t byte = val >> (i * 8);
+        if (byte == 0xff) {
+            mask |= 1 << i;
+        } else if (byte != 0) {
+            break;
+        }
+    }
+    if (i == 8) {
+        tcg_out_insn(s, VRIa, VGBM, ret, mask * 0x0101, 0);
+        return;
+    }
+
+    /* Otherwise, stuff it in the constant pool.  */
+    tcg_out_insn(s, RIL, LARL, TCG_TMP0, 0);
+    new_pool_label(s, val, R_390_PC32DBL, s->code_ptr - 2, 2);
+    tcg_out_insn(s, VRX, VLREP, ret, TCG_TMP0, TCG_REG_NONE, 0, MO_64);
+}
+
 static void tcg_out_movi(TCGContext *s, TCGType type,
                          TCGReg ret, tcg_target_long sval)
 {
-    tcg_out_movi_int(s, type, ret, sval, false);
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_debug_assert(ret < 16);
+        tcg_out_movi_int(s, type, ret, sval, false);
+        break;
+
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= TCG_REG_V0);
+        tcg_out_dupi_vec(s, type, ret, sval);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 }
 
 /* Emit a load/store type instruction.  Inputs are:
@@ -705,25 +1031,91 @@ static void tcg_out_mem(TCGContext *s, S390Opcode opc_rx, S390Opcode opc_rxy,
     }
 }
 
+static void tcg_out_vrx_mem(TCGContext *s, S390Opcode opc_vrx,
+                            TCGReg data, TCGReg base, TCGReg index,
+                            tcg_target_long ofs, int m4)
+{
+    if (ofs < 0 || ofs >= 0x1000) {
+        if (ofs >= -0x80000 && ofs < 0x80000) {
+            tcg_out_insn(s, RXY, LAY, TCG_TMP0, base, index, ofs);
+            base = TCG_TMP0;
+            index = TCG_REG_NONE;
+            ofs = 0;
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_TMP0, ofs);
+            if (index != TCG_REG_NONE) {
+                tcg_out_insn(s, RRE, AGR, TCG_TMP0, index);
+            }
+            index = TCG_TMP0;
+            ofs = 0;
+        }
+    }
+    tcg_out_insn_VRX(s, opc_vrx, data, base, index, ofs, m4);
+}
 
 /* load data without address translation or endianness conversion */
-static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg data,
-                              TCGReg base, intptr_t ofs)
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg data,
+                       TCGReg base, intptr_t ofs)
 {
-    if (type == TCG_TYPE_I32) {
-        tcg_out_mem(s, RX_L, RXY_LY, data, base, TCG_REG_NONE, ofs);
-    } else {
-        tcg_out_mem(s, 0, RXY_LG, data, base, TCG_REG_NONE, ofs);
+    switch (type) {
+    case TCG_TYPE_I32:
+        if (likely(data < 16)) {
+            tcg_out_mem(s, RX_L, RXY_LY, data, base, TCG_REG_NONE, ofs);
+        } else {
+            tcg_out_vrx_mem(s, VRX_VLLEZ, data, base, TCG_REG_NONE, ofs, MO_32);
+        }
+        break;
+
+    case TCG_TYPE_I64:
+        if (likely(data < 16)) {
+            tcg_out_mem(s, 0, RXY_LG, data, base, TCG_REG_NONE, ofs);
+            break;
+        }
+        /* fallthru */
+
+    case TCG_TYPE_V64:
+        tcg_out_vrx_mem(s, VRX_VLLEZ, data, base, TCG_REG_NONE, ofs, MO_64);
+        break;
+
+    case TCG_TYPE_V128:
+        /* Hint quadword aligned.  */
+        tcg_out_vrx_mem(s, VRX_VL, data, base, TCG_REG_NONE, ofs, 4);
+        break;
+
+    default:
+        g_assert_not_reached();
     }
 }
 
-static inline void tcg_out_st(TCGContext *s, TCGType type, TCGReg data,
-                              TCGReg base, intptr_t ofs)
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg data,
+                       TCGReg base, intptr_t ofs)
 {
-    if (type == TCG_TYPE_I32) {
-        tcg_out_mem(s, RX_ST, RXY_STY, data, base, TCG_REG_NONE, ofs);
-    } else {
-        tcg_out_mem(s, 0, RXY_STG, data, base, TCG_REG_NONE, ofs);
+    switch (type) {
+    case TCG_TYPE_I32:
+        if (likely(data < 16)) {
+            tcg_out_mem(s, RX_ST, RXY_STY, data, base, TCG_REG_NONE, ofs);
+        } else {
+            tcg_out_vrx_mem(s, VRX_VSTEF, data, base, TCG_REG_NONE, ofs, 1);
+        }
+        break;
+
+    case TCG_TYPE_I64:
+        if (likely(data < 16)) {
+            tcg_out_mem(s, 0, RXY_STG, data, base, TCG_REG_NONE, ofs);
+        }
+        /* fallthru */
+
+    case TCG_TYPE_V64:
+        tcg_out_vrx_mem(s, VRX_VSTEG, data, base, TCG_REG_NONE, ofs, 0);
+        break;
+
+    case TCG_TYPE_V128:
+        /* Hint quadword aligned.  */
+        tcg_out_vrx_mem(s, VRX_VST, data, base, TCG_REG_NONE, ofs, 4);
+        break;
+
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -866,7 +1258,7 @@ static inline void tgen_ext32u(TCGContext *s, TCGReg dest, TCGReg src)
     1..10..01..1
     0..01..10..0
    Copied from gcc sources.  */
-static inline bool risbg_mask(uint64_t c)
+static bool risbg_mask(uint64_t c)
 {
     uint64_t lsb;
     /* We don't change the number of transitions by inverting,
@@ -2317,6 +2709,274 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
+int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
+{
+    switch (opc) {
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_mul_vec:
+    case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
+    case INDEX_op_rotli_vec:
+    case INDEX_op_shls_vec:
+    case INDEX_op_shrs_vec:
+    case INDEX_op_sars_vec:
+    case INDEX_op_rotls_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+    case INDEX_op_rotlv_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_not_vec:
+    case INDEX_op_bitsel_vec:
+        return 1;
+    case INDEX_op_cmp_vec:
+    case INDEX_op_rotrv_vec:
+        return -1;
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
+        return 0;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                            TCGReg dst, TCGReg src)
+{
+    if (src < 16) {
+        /* Replication from general register only easy for MO_64.  */
+        if (vece == MO_64) {
+            tcg_out_insn(s, VRRf, VLVGP, dst, src, src);
+            return true;
+        }
+        return false;
+    }
+
+    /*
+     * Recall that the "standard" integer, within a vector, is the
+     * rightmost element of the leftmost doubleword, a-la VLLEZ.
+     */
+    tcg_out_insn(s, VRIc, VREP, dst, (8 >> vece) - 1, src, MO_8);
+    return true;
+}
+
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg dst, TCGReg base, intptr_t offset)
+{
+    tcg_out_vrx_mem(s, VRX_VLREP, dst, base, TCG_REG_NONE, offset, vece);
+    return true;
+}
+
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
+                           unsigned vecl, unsigned vece,
+                           const TCGArg *args, const int *const_args)
+{
+    TCGType type = vecl + TCG_TYPE_V64;
+    TCGArg a0 = args[0], a1 = args[1], a2 = args[2];
+
+    switch (opc) {
+    case INDEX_op_ld_vec:
+        tcg_out_ld(s, type, a0, a1, a2);
+        break;
+    case INDEX_op_st_vec:
+        tcg_out_st(s, type, a0, a1, a2);
+        break;
+    case INDEX_op_dupm_vec:
+        tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
+        break;
+
+    case INDEX_op_add_vec:
+        tcg_out_insn(s, VRRc, VA, a0, a1, a2, vece);
+        break;
+    case INDEX_op_sub_vec:
+        tcg_out_insn(s, VRRc, VS, a0, a1, a2, vece);
+        break;
+    case INDEX_op_neg_vec:
+        tcg_out_insn(s, VRRa, VLC, a0, a1, vece);
+        break;
+    case INDEX_op_mul_vec:
+        tcg_out_insn(s, VRRc, VML, a0, a1, a2, vece);
+        break;
+    case INDEX_op_abs_vec:
+        tcg_out_insn(s, VRRa, VLP, a0, a1, vece);
+        break;
+    case INDEX_op_shli_vec:
+        tcg_out_insn(s, VRSa, VESL, a0, a2, TCG_REG_NONE, a1, vece);
+        break;
+    case INDEX_op_shri_vec:
+        tcg_out_insn(s, VRSa, VESRL, a0, a2, TCG_REG_NONE, a1, vece);
+        break;
+    case INDEX_op_sari_vec:
+        tcg_out_insn(s, VRSa, VESRA, a0, a2, TCG_REG_NONE, a1, vece);
+        break;
+    case INDEX_op_rotli_vec:
+        tcg_out_insn(s, VRSa, VERLL, a0, a2, TCG_REG_NONE, a1, vece);
+        break;
+    case INDEX_op_shls_vec:
+        tcg_out_insn(s, VRSa, VESL, a0, 0, a2, a1, vece);
+        break;
+    case INDEX_op_shrs_vec:
+        tcg_out_insn(s, VRSa, VESRL, a0, 0, a2, a1, vece);
+        break;
+    case INDEX_op_sars_vec:
+        tcg_out_insn(s, VRSa, VESRA, a0, 0, a2, a1, vece);
+        break;
+    case INDEX_op_rotls_vec:
+        tcg_out_insn(s, VRSa, VERLL, a0, 0, a2, a1, vece);
+        break;
+    case INDEX_op_shlv_vec:
+        tcg_out_insn(s, VRRc, VESLV, a0, a1, a2, vece);
+        break;
+    case INDEX_op_shrv_vec:
+        tcg_out_insn(s, VRRc, VESRLV, a0, a1, a2, vece);
+        break;
+    case INDEX_op_sarv_vec:
+        tcg_out_insn(s, VRRc, VESRAV, a0, a1, a2, vece);
+        break;
+    case INDEX_op_rotlv_vec:
+        tcg_out_insn(s, VRRc, VERLLV, a0, a1, a2, vece);
+        break;
+    case INDEX_op_smin_vec:
+        tcg_out_insn(s, VRRc, VMN, a0, a1, a2, vece);
+        break;
+    case INDEX_op_smax_vec:
+        tcg_out_insn(s, VRRc, VMX, a0, a1, a2, vece);
+        break;
+    case INDEX_op_umin_vec:
+        tcg_out_insn(s, VRRc, VMNL, a0, a1, a2, vece);
+        break;
+    case INDEX_op_umax_vec:
+        tcg_out_insn(s, VRRc, VMXL, a0, a1, a2, vece);
+        break;
+    case INDEX_op_and_vec:
+        tcg_out_insn(s, VRRc, VN, a0, a1, a2, 0);
+        break;
+    case INDEX_op_andc_vec:
+        tcg_out_insn(s, VRRc, VNC, a0, a1, a2, 0);
+        break;
+    case INDEX_op_or_vec:
+        tcg_out_insn(s, VRRc, VO, a0, a1, a2, 0);
+        break;
+    case INDEX_op_xor_vec:
+        tcg_out_insn(s, VRRc, VX, a0, a1, a2, 0);
+        break;
+    case INDEX_op_not_vec:
+        tcg_out_insn(s, VRRc, VNO, a0, a1, a1, 0);
+        break;
+    case INDEX_op_bitsel_vec:
+        tcg_out_insn(s, VRRe, VSEL, a0, a1, a2, args[3]);
+        break;
+
+    case INDEX_op_cmp_vec:
+        switch ((TCGCond)args[3]) {
+        case TCG_COND_EQ:
+            tcg_out_insn(s, VRRc, VCEQ, a0, a1, a2, vece);
+            break;
+        case TCG_COND_GT:
+            tcg_out_insn(s, VRRc, VCH, a0, a1, a2, vece);
+            break;
+        case TCG_COND_GTU:
+            tcg_out_insn(s, VRRc, VCHL, a0, a1, a2, vece);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    case INDEX_op_mov_vec:   /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_dup_vec:   /* Always emitted via tcg_out_dup_vec.  */
+    case INDEX_op_dupi_vec:  /* Always emitted via tcg_out_movi.  */
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
+                           TCGv_vec v1, TCGv_vec v2, TCGCond cond)
+{
+    bool need_swap = false, need_inv = false;
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
+    TCGv_vec v0, v1, v2, t0;
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
+
+    case INDEX_op_rotrv_vec:
+        t0 = tcg_temp_new_vec(type);
+        tcg_gen_neg_vec(vece, t0, v2);
+        tcg_gen_rotlv_vec(vece, v0, v1, t0);
+        tcg_temp_free_vec(t0);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+    va_end(va);
+}
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
     static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
@@ -2334,6 +2994,12 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "0", "1", "ri", "r" } };
     static const TCGTargetOpDef a2_rA
         = { .args_ct_str = { "r", "r", "0", "1", "rA", "r" } };
+    static const TCGTargetOpDef v_r = { .args_ct_str = { "v", "r" } };
+    static const TCGTargetOpDef v_v = { .args_ct_str = { "v", "v" } };
+    static const TCGTargetOpDef v_v_r = { .args_ct_str = { "v", "v", "r" } };
+    static const TCGTargetOpDef v_v_v = { .args_ct_str = { "v", "v", "v" } };
+    static const TCGTargetOpDef v_v_v_v
+        = { .args_ct_str = { "v", "v", "v", "v" } };
 
     switch (op) {
     case INDEX_op_goto_ptr:
@@ -2475,6 +3141,43 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sub2_i64:
         return FACILITY(EXT_IMM) ? &a2_rA : &a2_r;
 
+    case INDEX_op_ld_vec:
+    case INDEX_op_st_vec:
+        return &v_r;
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
+    case INDEX_op_rotli_vec:
+    case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
+    case INDEX_op_not_vec:
+        return &v_v;
+    case INDEX_op_shls_vec:
+    case INDEX_op_shrs_vec:
+    case INDEX_op_sars_vec:
+    case INDEX_op_rotls_vec:
+        return &v_v_r;
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_mul_vec:
+    case INDEX_op_rotlv_vec:
+    case INDEX_op_rotrv_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_cmp_vec:
+        return &v_v_v;
+    case INDEX_op_bitsel_vec:
+        return &v_v_v_v;
+
     default:
         break;
     }
@@ -2485,8 +3188,10 @@ static void query_s390_facilities(void)
 {
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
 
-    /* Is STORE FACILITY LIST EXTENDED available?  Honestly, I believe this
-       is present on all 64-bit systems, but let's check for it anyway.  */
+    /*
+     * Is STORE FACILITY LIST EXTENDED available?  Honestly, I believe this
+     * is present on all 64-bit systems, but let's check for it anyway.
+     */
     if (hwcap & HWCAP_S390_STFLE) {
         register int r0 __asm__("0") = ARRAY_SIZE(s390_facilities) - 1;
         register void *r1 __asm__("1") = s390_facilities;
@@ -2495,6 +3200,16 @@ static void query_s390_facilities(void)
         asm volatile(".word 0xb2b0,0x1000"
                      : "=r"(r0) : "r"(r0), "r"(r1) : "memory", "cc");
     }
+
+    /*
+     * Use of vector registers requires os support beyond the facility bit.
+     * If the kernel does not advertise support, disable the facility bits.
+     * There is nothing else we currently care about in the 3rd word, so
+     * disable VECTOR and VECTOR_EXT1 in one go.
+     */
+    if (!(hwcap & HWCAP_S390_VX)) {
+        s390_facilities[2] = 0;
+    }
 }
 
 static void tcg_target_init(TCGContext *s)
@@ -2503,6 +3218,10 @@ static void tcg_target_init(TCGContext *s)
 
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffff;
+    if (FACILITY(VECTOR)) {
+        tcg_target_available_regs[TCG_TYPE_V64] = 0xffffffff00000000ull;
+        tcg_target_available_regs[TCG_TYPE_V128] = 0xffffffff00000000ull;
+    }
 
     tcg_target_call_clobber_regs = 0;
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R0);
@@ -2517,6 +3236,31 @@ static void tcg_target_init(TCGContext *s)
     /* The return register can be considered call-clobbered.  */
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R14);
 
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V0);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V1);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V2);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V3);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V4);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V5);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V6);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V7);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V16);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V17);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V18);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V19);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V20);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V21);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V22);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V23);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V24);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V25);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V26);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V27);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V28);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V29);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V30);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V31);
+
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_TMP0);
     /* XXX many insns can't be used with R0, so we better avoid it for now */
-- 
2.20.1


