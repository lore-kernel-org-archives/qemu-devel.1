Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFBBC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006522085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006522085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzh1p-000536-KH
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTs-0002Fa-AR
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTm-0002kj-GY
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:48 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58006 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hzgTl-0002ao-Si
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id E32CC1A21B2;
 Mon, 19 Aug 2019 14:08:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 2173A1A20C5;
 Mon, 19 Aug 2019 14:08:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:07:50 +0200
Message-Id: <1566216496-17375-12-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v8 11/37] target/mips: Style improvements in
 translate.c
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
Cc: arikalo@wavecomp.com, philmd@redhat.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 608 ++++++++++++++++++++++++------------------------
 1 file changed, 309 insertions(+), 299 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3f9f113..fe4a05c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -43,7 +43,7 @@
 #define MIPS_DEBUG_DISAS 0
 
 /* MIPS major opcodes */
-#define MASK_OP_MAJOR(op)  (op & (0x3F << 26))
+#define MASK_OP_MAJOR(op)       (op & (0x3F << 26))
 
 enum {
     /* indirect opcode tables */
@@ -153,8 +153,8 @@ enum {
 };
 
 /* PC-relative address computation / loads  */
-#define MASK_OPC_PCREL_TOP2BITS(op)  (MASK_OP_MAJOR(op) | (op & (3 << 19)))
-#define MASK_OPC_PCREL_TOP5BITS(op)  (MASK_OP_MAJOR(op) | (op & (0x1f << 16)))
+#define MASK_OPC_PCREL_TOP2BITS(op) (MASK_OP_MAJOR(op) | (op & (3 << 19)))
+#define MASK_OPC_PCREL_TOP5BITS(op) (MASK_OP_MAJOR(op) | (op & (0x1f << 16)))
 enum {
     /* Instructions determined by bits 19 and 20 */
     OPC_ADDIUPC = OPC_PCREL | (0 << 19),
@@ -170,7 +170,7 @@ enum {
 };
 
 /* MIPS special opcodes */
-#define MASK_SPECIAL(op)   MASK_OP_MAJOR(op) | (op & 0x3F)
+#define MASK_SPECIAL(op)            (MASK_OP_MAJOR(op) | (op & 0x3F))
 
 enum {
     /* Shifts */
@@ -263,7 +263,7 @@ enum {
  * R6 Multiply and Divide instructions have the same opcode
  * and function field as legacy OPC_MULT[U]/OPC_DIV[U]
  */
-#define MASK_R6_MULDIV(op)   (MASK_SPECIAL(op) | (op & (0x7ff)))
+#define MASK_R6_MULDIV(op)          (MASK_SPECIAL(op) | (op & (0x7ff)))
 
 enum {
     R6_OPC_MUL   = OPC_MULT  | (2 << 6),
@@ -295,7 +295,7 @@ enum {
 };
 
 /* Multiplication variants of the vr54xx. */
-#define MASK_MUL_VR54XX(op)   MASK_SPECIAL(op) | (op & (0x1F << 6))
+#define MASK_MUL_VR54XX(op)         (MASK_SPECIAL(op) | (op & (0x1F << 6)))
 
 enum {
     OPC_VR54XX_MULS    = (0x03 << 6) | OPC_MULT,
@@ -315,7 +315,7 @@ enum {
 };
 
 /* REGIMM (rt field) opcodes */
-#define MASK_REGIMM(op)    MASK_OP_MAJOR(op) | (op & (0x1F << 16))
+#define MASK_REGIMM(op)             (MASK_OP_MAJOR(op) | (op & (0x1F << 16)))
 
 enum {
     OPC_BLTZ     = (0x00 << 16) | OPC_REGIMM,
@@ -340,7 +340,7 @@ enum {
 };
 
 /* Special2 opcodes */
-#define MASK_SPECIAL2(op)  MASK_OP_MAJOR(op) | (op & 0x3F)
+#define MASK_SPECIAL2(op)           (MASK_OP_MAJOR(op) | (op & 0x3F))
 
 enum {
     /* Multiply & xxx operations */
@@ -372,7 +372,7 @@ enum {
 };
 
 /* Special3 opcodes */
-#define MASK_SPECIAL3(op)  MASK_OP_MAJOR(op) | (op & 0x3F)
+#define MASK_SPECIAL3(op)           (MASK_OP_MAJOR(op) | (op & 0x3F))
 
 enum {
     OPC_EXT      = 0x00 | OPC_SPECIAL3,
@@ -462,7 +462,7 @@ enum {
 };
 
 /* BSHFL opcodes */
-#define MASK_BSHFL(op)     MASK_SPECIAL3(op) | (op & (0x1F << 6))
+#define MASK_BSHFL(op)              (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 
 enum {
     OPC_WSBH      = (0x02 << 6) | OPC_BSHFL,
@@ -476,7 +476,7 @@ enum {
 };
 
 /* DBSHFL opcodes */
-#define MASK_DBSHFL(op)    MASK_SPECIAL3(op) | (op & (0x1F << 6))
+#define MASK_DBSHFL(op)             (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 
 enum {
     OPC_DSBH       = (0x02 << 6) | OPC_DBSHFL,
@@ -498,7 +498,7 @@ enum {
     OPC_BPOSGE64 = (0x1D << 16) | OPC_REGIMM,
 };
 
-#define MASK_LX(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_LX(op)                 (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 /* MIPS DSP Load */
 enum {
     OPC_LBUX = (0x06 << 6) | OPC_LX_DSP,
@@ -507,7 +507,7 @@ enum {
     OPC_LDX = (0x08 << 6) | OPC_LX_DSP,
 };
 
-#define MASK_ADDU_QB(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_ADDU_QB(op)            (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP Arithmetic Sub-class */
     OPC_ADDQ_PH        = (0x0A << 6) | OPC_ADDU_QB_DSP,
@@ -538,7 +538,7 @@ enum {
 };
 
 #define OPC_ADDUH_QB_DSP OPC_MULT_G_2E
-#define MASK_ADDUH_QB(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_ADDUH_QB(op)           (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP Arithmetic Sub-class */
     OPC_ADDUH_QB   = (0x00 << 6) | OPC_ADDUH_QB_DSP,
@@ -560,7 +560,7 @@ enum {
     OPC_MULQ_RS_W  = (0x17 << 6) | OPC_ADDUH_QB_DSP,
 };
 
-#define MASK_ABSQ_S_PH(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_ABSQ_S_PH(op)          (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP Arithmetic Sub-class */
     OPC_ABSQ_S_QB       = (0x01 << 6) | OPC_ABSQ_S_PH_DSP,
@@ -584,7 +584,7 @@ enum {
     OPC_REPLV_PH        = (0x0B << 6) | OPC_ABSQ_S_PH_DSP,
 };
 
-#define MASK_CMPU_EQ_QB(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_CMPU_EQ_QB(op)         (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP Arithmetic Sub-class */
     OPC_PRECR_QB_PH      = (0x0D << 6) | OPC_CMPU_EQ_QB_DSP,
@@ -612,7 +612,7 @@ enum {
     OPC_PACKRL_PH        = (0x0E << 6) | OPC_CMPU_EQ_QB_DSP,
 };
 
-#define MASK_SHLL_QB(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_SHLL_QB(op)            (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP GPR-Based Shift Sub-class */
     OPC_SHLL_QB    = (0x00 << 6) | OPC_SHLL_QB_DSP,
@@ -639,7 +639,7 @@ enum {
     OPC_SHRAV_R_W  = (0x17 << 6) | OPC_SHLL_QB_DSP,
 };
 
-#define MASK_DPA_W_PH(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_DPA_W_PH(op)           (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP Multiply Sub-class insns */
     OPC_DPAU_H_QBL    = (0x03 << 6) | OPC_DPA_W_PH_DSP,
@@ -666,13 +666,13 @@ enum {
     OPC_MULSA_W_PH    = (0x02 << 6) | OPC_DPA_W_PH_DSP,
 };
 
-#define MASK_INSV(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_INSV(op)               (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* DSP Bit/Manipulation Sub-class */
     OPC_INSV = (0x00 << 6) | OPC_INSV_DSP,
 };
 
-#define MASK_APPEND(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_APPEND(op)             (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP Append Sub-class */
     OPC_APPEND  = (0x00 << 6) | OPC_APPEND_DSP,
@@ -680,7 +680,7 @@ enum {
     OPC_BALIGN  = (0x10 << 6) | OPC_APPEND_DSP,
 };
 
-#define MASK_EXTR_W(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_EXTR_W(op)             (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP Accumulator and DSPControl Access Sub-class */
     OPC_EXTR_W     = (0x00 << 6) | OPC_EXTR_W_DSP,
@@ -702,7 +702,7 @@ enum {
     OPC_RDDSP      = (0x12 << 6) | OPC_EXTR_W_DSP,
 };
 
-#define MASK_ABSQ_S_QH(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_ABSQ_S_QH(op)          (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP Arithmetic Sub-class */
     OPC_PRECEQ_L_PWL    = (0x14 << 6) | OPC_ABSQ_S_QH_DSP,
@@ -731,7 +731,7 @@ enum {
     OPC_REPLV_QH        = (0x0B << 6) | OPC_ABSQ_S_QH_DSP,
 };
 
-#define MASK_ADDU_OB(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_ADDU_OB(op)            (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP Multiply Sub-class insns */
     OPC_MULEQ_S_PW_QHL = (0x1C << 6) | OPC_ADDU_OB_DSP,
@@ -763,7 +763,7 @@ enum {
     OPC_ADDUH_R_OB     = (0x1A << 6) | OPC_ADDU_OB_DSP,
 };
 
-#define MASK_CMPU_EQ_OB(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_CMPU_EQ_OB(op)         (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* DSP Compare-Pick Sub-class */
     OPC_CMP_EQ_PW         = (0x10 << 6) | OPC_CMPU_EQ_OB_DSP,
@@ -796,7 +796,7 @@ enum {
     OPC_PRECRQU_S_OB_QH   = (0x0F << 6) | OPC_CMPU_EQ_OB_DSP,
 };
 
-#define MASK_DAPPEND(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_DAPPEND(op)            (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* DSP Append Sub-class */
     OPC_DAPPEND  = (0x00 << 6) | OPC_DAPPEND_DSP,
@@ -805,7 +805,7 @@ enum {
     OPC_DBALIGN  = (0x10 << 6) | OPC_DAPPEND_DSP,
 };
 
-#define MASK_DEXTR_W(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_DEXTR_W(op)            (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP Accumulator and DSPControl Access Sub-class */
     OPC_DMTHLIP     = (0x1F << 6) | OPC_DEXTR_W_DSP,
@@ -831,13 +831,13 @@ enum {
     OPC_DSHILOV     = (0x1B << 6) | OPC_DEXTR_W_DSP,
 };
 
-#define MASK_DINSV(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_DINSV(op)              (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* DSP Bit/Manipulation Sub-class */
     OPC_DINSV = (0x00 << 6) | OPC_DINSV_DSP,
 };
 
-#define MASK_DPAQ_W_QH(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_DPAQ_W_QH(op)          (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP Multiply Sub-class insns */
     OPC_DMADD         = (0x19 << 6) | OPC_DPAQ_W_QH_DSP,
@@ -868,7 +868,7 @@ enum {
     OPC_MULSAQ_S_W_QH = (0x06 << 6) | OPC_DPAQ_W_QH_DSP,
 };
 
-#define MASK_SHLL_OB(op) (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
+#define MASK_SHLL_OB(op)            (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP GPR-Based Shift Sub-class */
     OPC_SHLL_PW    = (0x10 << 6) | OPC_SHLL_OB_DSP,
@@ -900,7 +900,7 @@ enum {
 };
 
 /* Coprocessor 0 (rs field) */
-#define MASK_CP0(op)       MASK_OP_MAJOR(op) | (op & (0x1F << 21))
+#define MASK_CP0(op)                (MASK_OP_MAJOR(op) | (op & (0x1F << 21)))
 
 enum {
     OPC_MFC0     = (0x00 << 21) | OPC_CP0,
@@ -933,7 +933,7 @@ enum {
 };
 
 /* MFMC0 opcodes */
-#define MASK_MFMC0(op)     MASK_CP0(op) | (op & 0xFFFF)
+#define MASK_MFMC0(op)              (MASK_CP0(op) | (op & 0xFFFF))
 
 enum {
     OPC_DMT      = 0x01 | (0 << 5) | (0x0F << 6) | (0x01 << 11) | OPC_MFMC0,
@@ -947,7 +947,7 @@ enum {
 };
 
 /* Coprocessor 0 (with rs == C0) */
-#define MASK_C0(op)        MASK_CP0(op) | (op & 0x3F)
+#define MASK_C0(op)                 (MASK_CP0(op) | (op & 0x3F))
 
 enum {
     OPC_TLBR     = 0x01 | OPC_C0,
@@ -963,7 +963,7 @@ enum {
 };
 
 /* Coprocessor 1 (rs field) */
-#define MASK_CP1(op)       MASK_OP_MAJOR(op) | (op & (0x1F << 21))
+#define MASK_CP1(op)                (MASK_OP_MAJOR(op) | (op & (0x1F << 21)))
 
 /* Values for the fmt field in FP instructions */
 enum {
@@ -1011,8 +1011,8 @@ enum {
     OPC_BNZ_D    = (0x1F << 21) | OPC_CP1,
 };
 
-#define MASK_CP1_FUNC(op)       MASK_CP1(op) | (op & 0x3F)
-#define MASK_BC1(op)            MASK_CP1(op) | (op & (0x3 << 16))
+#define MASK_CP1_FUNC(op)           (MASK_CP1(op) | (op & 0x3F))
+#define MASK_BC1(op)                (MASK_CP1(op) | (op & (0x3 << 16)))
 
 enum {
     OPC_BC1F     = (0x00 << 16) | OPC_BC1,
@@ -1031,7 +1031,7 @@ enum {
     OPC_BC1TANY4     = (0x01 << 16) | OPC_BC1ANY4,
 };
 
-#define MASK_CP2(op)       MASK_OP_MAJOR(op) | (op & (0x1F << 21))
+#define MASK_CP2(op)                (MASK_OP_MAJOR(op) | (op & (0x1F << 21)))
 
 enum {
     OPC_MFC2    = (0x00 << 21) | OPC_CP2,
@@ -1047,35 +1047,35 @@ enum {
     OPC_BC2NEZ  = (0x0D << 21) | OPC_CP2,
 };
 
-#define MASK_LMI(op)  (MASK_OP_MAJOR(op) | (op & (0x1F << 21)) | (op & 0x1F))
+#define MASK_LMI(op)    (MASK_OP_MAJOR(op) | (op & (0x1F << 21)) | (op & 0x1F))
 
 enum {
-    OPC_PADDSH  = (24 << 21) | (0x00) | OPC_CP2,
-    OPC_PADDUSH = (25 << 21) | (0x00) | OPC_CP2,
-    OPC_PADDH   = (26 << 21) | (0x00) | OPC_CP2,
-    OPC_PADDW   = (27 << 21) | (0x00) | OPC_CP2,
-    OPC_PADDSB  = (28 << 21) | (0x00) | OPC_CP2,
-    OPC_PADDUSB = (29 << 21) | (0x00) | OPC_CP2,
-    OPC_PADDB   = (30 << 21) | (0x00) | OPC_CP2,
-    OPC_PADDD   = (31 << 21) | (0x00) | OPC_CP2,
-
-    OPC_PSUBSH  = (24 << 21) | (0x01) | OPC_CP2,
-    OPC_PSUBUSH = (25 << 21) | (0x01) | OPC_CP2,
-    OPC_PSUBH   = (26 << 21) | (0x01) | OPC_CP2,
-    OPC_PSUBW   = (27 << 21) | (0x01) | OPC_CP2,
-    OPC_PSUBSB  = (28 << 21) | (0x01) | OPC_CP2,
-    OPC_PSUBUSB = (29 << 21) | (0x01) | OPC_CP2,
-    OPC_PSUBB   = (30 << 21) | (0x01) | OPC_CP2,
-    OPC_PSUBD   = (31 << 21) | (0x01) | OPC_CP2,
-
-    OPC_PSHUFH   = (24 << 21) | (0x02) | OPC_CP2,
-    OPC_PACKSSWH = (25 << 21) | (0x02) | OPC_CP2,
-    OPC_PACKSSHB = (26 << 21) | (0x02) | OPC_CP2,
-    OPC_PACKUSHB = (27 << 21) | (0x02) | OPC_CP2,
-    OPC_XOR_CP2  = (28 << 21) | (0x02) | OPC_CP2,
-    OPC_NOR_CP2  = (29 << 21) | (0x02) | OPC_CP2,
-    OPC_AND_CP2  = (30 << 21) | (0x02) | OPC_CP2,
-    OPC_PANDN    = (31 << 21) | (0x02) | OPC_CP2,
+    OPC_PADDSH      = (24 << 21) | (0x00) | OPC_CP2,
+    OPC_PADDUSH     = (25 << 21) | (0x00) | OPC_CP2,
+    OPC_PADDH       = (26 << 21) | (0x00) | OPC_CP2,
+    OPC_PADDW       = (27 << 21) | (0x00) | OPC_CP2,
+    OPC_PADDSB      = (28 << 21) | (0x00) | OPC_CP2,
+    OPC_PADDUSB     = (29 << 21) | (0x00) | OPC_CP2,
+    OPC_PADDB       = (30 << 21) | (0x00) | OPC_CP2,
+    OPC_PADDD       = (31 << 21) | (0x00) | OPC_CP2,
+
+    OPC_PSUBSH      = (24 << 21) | (0x01) | OPC_CP2,
+    OPC_PSUBUSH     = (25 << 21) | (0x01) | OPC_CP2,
+    OPC_PSUBH       = (26 << 21) | (0x01) | OPC_CP2,
+    OPC_PSUBW       = (27 << 21) | (0x01) | OPC_CP2,
+    OPC_PSUBSB      = (28 << 21) | (0x01) | OPC_CP2,
+    OPC_PSUBUSB     = (29 << 21) | (0x01) | OPC_CP2,
+    OPC_PSUBB       = (30 << 21) | (0x01) | OPC_CP2,
+    OPC_PSUBD       = (31 << 21) | (0x01) | OPC_CP2,
+
+    OPC_PSHUFH      = (24 << 21) | (0x02) | OPC_CP2,
+    OPC_PACKSSWH    = (25 << 21) | (0x02) | OPC_CP2,
+    OPC_PACKSSHB    = (26 << 21) | (0x02) | OPC_CP2,
+    OPC_PACKUSHB    = (27 << 21) | (0x02) | OPC_CP2,
+    OPC_XOR_CP2     = (28 << 21) | (0x02) | OPC_CP2,
+    OPC_NOR_CP2     = (29 << 21) | (0x02) | OPC_CP2,
+    OPC_AND_CP2     = (30 << 21) | (0x02) | OPC_CP2,
+    OPC_PANDN       = (31 << 21) | (0x02) | OPC_CP2,
 
     OPC_PUNPCKLHW = (24 << 21) | (0x03) | OPC_CP2,
     OPC_PUNPCKHHW = (25 << 21) | (0x03) | OPC_CP2,
@@ -1144,33 +1144,33 @@ enum {
 };
 
 
-#define MASK_CP3(op)       MASK_OP_MAJOR(op) | (op & 0x3F)
+#define MASK_CP3(op)                (MASK_OP_MAJOR(op) | (op & 0x3F))
 
 enum {
-    OPC_LWXC1   = 0x00 | OPC_CP3,
-    OPC_LDXC1   = 0x01 | OPC_CP3,
-    OPC_LUXC1   = 0x05 | OPC_CP3,
-    OPC_SWXC1   = 0x08 | OPC_CP3,
-    OPC_SDXC1   = 0x09 | OPC_CP3,
-    OPC_SUXC1   = 0x0D | OPC_CP3,
-    OPC_PREFX   = 0x0F | OPC_CP3,
-    OPC_ALNV_PS = 0x1E | OPC_CP3,
-    OPC_MADD_S  = 0x20 | OPC_CP3,
-    OPC_MADD_D  = 0x21 | OPC_CP3,
-    OPC_MADD_PS = 0x26 | OPC_CP3,
-    OPC_MSUB_S  = 0x28 | OPC_CP3,
-    OPC_MSUB_D  = 0x29 | OPC_CP3,
-    OPC_MSUB_PS = 0x2E | OPC_CP3,
-    OPC_NMADD_S = 0x30 | OPC_CP3,
-    OPC_NMADD_D = 0x31 | OPC_CP3,
-    OPC_NMADD_PS= 0x36 | OPC_CP3,
-    OPC_NMSUB_S = 0x38 | OPC_CP3,
-    OPC_NMSUB_D = 0x39 | OPC_CP3,
-    OPC_NMSUB_PS= 0x3E | OPC_CP3,
+    OPC_LWXC1       = 0x00 | OPC_CP3,
+    OPC_LDXC1       = 0x01 | OPC_CP3,
+    OPC_LUXC1       = 0x05 | OPC_CP3,
+    OPC_SWXC1       = 0x08 | OPC_CP3,
+    OPC_SDXC1       = 0x09 | OPC_CP3,
+    OPC_SUXC1       = 0x0D | OPC_CP3,
+    OPC_PREFX       = 0x0F | OPC_CP3,
+    OPC_ALNV_PS     = 0x1E | OPC_CP3,
+    OPC_MADD_S      = 0x20 | OPC_CP3,
+    OPC_MADD_D      = 0x21 | OPC_CP3,
+    OPC_MADD_PS     = 0x26 | OPC_CP3,
+    OPC_MSUB_S      = 0x28 | OPC_CP3,
+    OPC_MSUB_D      = 0x29 | OPC_CP3,
+    OPC_MSUB_PS     = 0x2E | OPC_CP3,
+    OPC_NMADD_S     = 0x30 | OPC_CP3,
+    OPC_NMADD_D     = 0x31 | OPC_CP3,
+    OPC_NMADD_PS    = 0x36 | OPC_CP3,
+    OPC_NMSUB_S     = 0x38 | OPC_CP3,
+    OPC_NMSUB_D     = 0x39 | OPC_CP3,
+    OPC_NMSUB_PS    = 0x3E | OPC_CP3,
 };
 
 /* MSA Opcodes */
-#define MASK_MSA_MINOR(op)    (MASK_OP_MAJOR(op) | (op & 0x3F))
+#define MASK_MSA_MINOR(op)          (MASK_OP_MAJOR(op) | (op & 0x3F))
 enum {
     OPC_MSA_I8_00   = 0x00 | OPC_MSA,
     OPC_MSA_I8_01   = 0x01 | OPC_MSA,
@@ -1195,14 +1195,14 @@ enum {
     OPC_MSA_VEC     = 0x1E | OPC_MSA,
 
     /* MI10 instruction */
-    OPC_LD_B    = (0x20) | OPC_MSA,
-    OPC_LD_H    = (0x21) | OPC_MSA,
-    OPC_LD_W    = (0x22) | OPC_MSA,
-    OPC_LD_D    = (0x23) | OPC_MSA,
-    OPC_ST_B    = (0x24) | OPC_MSA,
-    OPC_ST_H    = (0x25) | OPC_MSA,
-    OPC_ST_W    = (0x26) | OPC_MSA,
-    OPC_ST_D    = (0x27) | OPC_MSA,
+    OPC_LD_B        = (0x20) | OPC_MSA,
+    OPC_LD_H        = (0x21) | OPC_MSA,
+    OPC_LD_W        = (0x22) | OPC_MSA,
+    OPC_LD_D        = (0x23) | OPC_MSA,
+    OPC_ST_B        = (0x24) | OPC_MSA,
+    OPC_ST_H        = (0x25) | OPC_MSA,
+    OPC_ST_W        = (0x26) | OPC_MSA,
+    OPC_ST_D        = (0x27) | OPC_MSA,
 };
 
 enum {
@@ -1221,34 +1221,34 @@ enum {
     OPC_LDI_df      = (0x6 << 23) | OPC_MSA_I5_07,
 
     /* I8 instruction */
-    OPC_ANDI_B  = (0x0 << 24) | OPC_MSA_I8_00,
-    OPC_BMNZI_B = (0x0 << 24) | OPC_MSA_I8_01,
-    OPC_SHF_B   = (0x0 << 24) | OPC_MSA_I8_02,
-    OPC_ORI_B   = (0x1 << 24) | OPC_MSA_I8_00,
-    OPC_BMZI_B  = (0x1 << 24) | OPC_MSA_I8_01,
-    OPC_SHF_H   = (0x1 << 24) | OPC_MSA_I8_02,
-    OPC_NORI_B  = (0x2 << 24) | OPC_MSA_I8_00,
-    OPC_BSELI_B = (0x2 << 24) | OPC_MSA_I8_01,
-    OPC_SHF_W   = (0x2 << 24) | OPC_MSA_I8_02,
-    OPC_XORI_B  = (0x3 << 24) | OPC_MSA_I8_00,
+    OPC_ANDI_B      = (0x0 << 24) | OPC_MSA_I8_00,
+    OPC_BMNZI_B     = (0x0 << 24) | OPC_MSA_I8_01,
+    OPC_SHF_B       = (0x0 << 24) | OPC_MSA_I8_02,
+    OPC_ORI_B       = (0x1 << 24) | OPC_MSA_I8_00,
+    OPC_BMZI_B      = (0x1 << 24) | OPC_MSA_I8_01,
+    OPC_SHF_H       = (0x1 << 24) | OPC_MSA_I8_02,
+    OPC_NORI_B      = (0x2 << 24) | OPC_MSA_I8_00,
+    OPC_BSELI_B     = (0x2 << 24) | OPC_MSA_I8_01,
+    OPC_SHF_W       = (0x2 << 24) | OPC_MSA_I8_02,
+    OPC_XORI_B      = (0x3 << 24) | OPC_MSA_I8_00,
 
     /* VEC/2R/2RF instruction */
-    OPC_AND_V   = (0x00 << 21) | OPC_MSA_VEC,
-    OPC_OR_V    = (0x01 << 21) | OPC_MSA_VEC,
-    OPC_NOR_V   = (0x02 << 21) | OPC_MSA_VEC,
-    OPC_XOR_V   = (0x03 << 21) | OPC_MSA_VEC,
-    OPC_BMNZ_V  = (0x04 << 21) | OPC_MSA_VEC,
-    OPC_BMZ_V   = (0x05 << 21) | OPC_MSA_VEC,
-    OPC_BSEL_V  = (0x06 << 21) | OPC_MSA_VEC,
+    OPC_AND_V       = (0x00 << 21) | OPC_MSA_VEC,
+    OPC_OR_V        = (0x01 << 21) | OPC_MSA_VEC,
+    OPC_NOR_V       = (0x02 << 21) | OPC_MSA_VEC,
+    OPC_XOR_V       = (0x03 << 21) | OPC_MSA_VEC,
+    OPC_BMNZ_V      = (0x04 << 21) | OPC_MSA_VEC,
+    OPC_BMZ_V       = (0x05 << 21) | OPC_MSA_VEC,
+    OPC_BSEL_V      = (0x06 << 21) | OPC_MSA_VEC,
 
     OPC_MSA_2R      = (0x18 << 21) | OPC_MSA_VEC,
     OPC_MSA_2RF     = (0x19 << 21) | OPC_MSA_VEC,
 
     /* 2R instruction df(bits 17..16) = _b, _h, _w, _d */
-    OPC_FILL_df = (0x00 << 18) | OPC_MSA_2R,
-    OPC_PCNT_df = (0x01 << 18) | OPC_MSA_2R,
-    OPC_NLOC_df = (0x02 << 18) | OPC_MSA_2R,
-    OPC_NLZC_df = (0x03 << 18) | OPC_MSA_2R,
+    OPC_FILL_df     = (0x00 << 18) | OPC_MSA_2R,
+    OPC_PCNT_df     = (0x01 << 18) | OPC_MSA_2R,
+    OPC_NLOC_df     = (0x02 << 18) | OPC_MSA_2R,
+    OPC_NLZC_df     = (0x03 << 18) | OPC_MSA_2R,
 
     /* 2RF instruction df(bit 16) = _w, _d */
     OPC_FCLASS_df   = (0x00 << 17) | OPC_MSA_2RF,
@@ -2478,43 +2478,43 @@ static TCGv mxu_CR;
     TCGv_i32 helper_tmp = tcg_const_i32(arg);                     \
     gen_helper_##name(cpu_env, helper_tmp);                       \
     tcg_temp_free_i32(helper_tmp);                                \
-    } while(0)
+    } while (0)
 
 #define gen_helper_0e1i(name, arg1, arg2) do {                    \
     TCGv_i32 helper_tmp = tcg_const_i32(arg2);                    \
     gen_helper_##name(cpu_env, arg1, helper_tmp);                 \
     tcg_temp_free_i32(helper_tmp);                                \
-    } while(0)
+    } while (0)
 
 #define gen_helper_1e0i(name, ret, arg1) do {                     \
     TCGv_i32 helper_tmp = tcg_const_i32(arg1);                    \
     gen_helper_##name(ret, cpu_env, helper_tmp);                  \
     tcg_temp_free_i32(helper_tmp);                                \
-    } while(0)
+    } while (0)
 
 #define gen_helper_1e1i(name, ret, arg1, arg2) do {               \
     TCGv_i32 helper_tmp = tcg_const_i32(arg2);                    \
     gen_helper_##name(ret, cpu_env, arg1, helper_tmp);            \
     tcg_temp_free_i32(helper_tmp);                                \
-    } while(0)
+    } while (0)
 
 #define gen_helper_0e2i(name, arg1, arg2, arg3) do {              \
     TCGv_i32 helper_tmp = tcg_const_i32(arg3);                    \
     gen_helper_##name(cpu_env, arg1, arg2, helper_tmp);           \
     tcg_temp_free_i32(helper_tmp);                                \
-    } while(0)
+    } while (0)
 
 #define gen_helper_1e2i(name, ret, arg1, arg2, arg3) do {         \
     TCGv_i32 helper_tmp = tcg_const_i32(arg3);                    \
     gen_helper_##name(ret, cpu_env, arg1, arg2, helper_tmp);      \
     tcg_temp_free_i32(helper_tmp);                                \
-    } while(0)
+    } while (0)
 
 #define gen_helper_0e3i(name, arg1, arg2, arg3, arg4) do {        \
     TCGv_i32 helper_tmp = tcg_const_i32(arg4);                    \
     gen_helper_##name(cpu_env, arg1, arg2, arg3, helper_tmp);     \
     tcg_temp_free_i32(helper_tmp);                                \
-    } while(0)
+    } while (0)
 
 typedef struct DisasContext {
     DisasContextBase base;
@@ -2666,7 +2666,7 @@ static inline void gen_load_srsgpr(int from, int to)
     tcg_temp_free(t0);
 }
 
-static inline void gen_store_srsgpr (int from, int to)
+static inline void gen_store_srsgpr(int from, int to)
 {
     if (to != 0) {
         TCGv t0 = tcg_temp_new();
@@ -3364,28 +3364,28 @@ FOP_CONDNS(s, FMT_S, 32, gen_store_fpr32(ctx, fp0, fd))
 
 /* load/store instructions. */
 #ifdef CONFIG_USER_ONLY
-#define OP_LD_ATOMIC(insn,fname)                                           \
+#define OP_LD_ATOMIC(insn, fname)                                          \
 static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
                                 DisasContext *ctx)                         \
 {                                                                          \
     TCGv t0 = tcg_temp_new();                                              \
     tcg_gen_mov_tl(t0, arg1);                                              \
     tcg_gen_qemu_##fname(ret, arg1, ctx->mem_idx);                         \
-    tcg_gen_st_tl(t0, cpu_env, offsetof(CPUMIPSState, lladdr));                \
-    tcg_gen_st_tl(ret, cpu_env, offsetof(CPUMIPSState, llval));                \
+    tcg_gen_st_tl(t0, cpu_env, offsetof(CPUMIPSState, lladdr));            \
+    tcg_gen_st_tl(ret, cpu_env, offsetof(CPUMIPSState, llval));            \
     tcg_temp_free(t0);                                                     \
 }
 #else
-#define OP_LD_ATOMIC(insn,fname)                                           \
+#define OP_LD_ATOMIC(insn, fname)                                          \
 static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
                                 DisasContext *ctx)                         \
 {                                                                          \
     gen_helper_1e1i(insn, ret, arg1, mem_idx);                             \
 }
 #endif
-OP_LD_ATOMIC(ll,ld32s);
+OP_LD_ATOMIC(ll, ld32s);
 #if defined(TARGET_MIPS64)
-OP_LD_ATOMIC(lld,ld64);
+OP_LD_ATOMIC(lld, ld64);
 #endif
 #undef OP_LD_ATOMIC
 
@@ -9794,7 +9794,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 7:
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_st_tl(arg, cpu_env,
-                          offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
+                          offsetof(CPUMIPSState, CP0_KScratch[sel - 2]));
             register_name = "KScratch";
             break;
         default:
@@ -9960,84 +9960,86 @@ static void gen_mftr(CPUMIPSState *env, DisasContext *ctx, int rt, int rd,
         default:
             gen_mfc0(ctx, t0, rt, sel);
         }
-    } else switch (sel) {
-    /* GPR registers. */
-    case 0:
-        gen_helper_1e0i(mftgpr, t0, rt);
-        break;
-    /* Auxiliary CPU registers */
-    case 1:
-        switch (rt) {
+    } else {
+        switch (sel) {
+        /* GPR registers. */
         case 0:
-            gen_helper_1e0i(mftlo, t0, 0);
+            gen_helper_1e0i(mftgpr, t0, rt);
             break;
+        /* Auxiliary CPU registers */
         case 1:
-            gen_helper_1e0i(mfthi, t0, 0);
+            switch (rt) {
+            case 0:
+                gen_helper_1e0i(mftlo, t0, 0);
+                break;
+            case 1:
+                gen_helper_1e0i(mfthi, t0, 0);
+                break;
+            case 2:
+                gen_helper_1e0i(mftacx, t0, 0);
+                break;
+            case 4:
+                gen_helper_1e0i(mftlo, t0, 1);
+                break;
+            case 5:
+                gen_helper_1e0i(mfthi, t0, 1);
+                break;
+            case 6:
+                gen_helper_1e0i(mftacx, t0, 1);
+                break;
+            case 8:
+                gen_helper_1e0i(mftlo, t0, 2);
+                break;
+            case 9:
+                gen_helper_1e0i(mfthi, t0, 2);
+                break;
+            case 10:
+                gen_helper_1e0i(mftacx, t0, 2);
+                break;
+            case 12:
+                gen_helper_1e0i(mftlo, t0, 3);
+                break;
+            case 13:
+                gen_helper_1e0i(mfthi, t0, 3);
+                break;
+            case 14:
+                gen_helper_1e0i(mftacx, t0, 3);
+                break;
+            case 16:
+                gen_helper_mftdsp(t0, cpu_env);
+                break;
+            default:
+                goto die;
+            }
             break;
+        /* Floating point (COP1). */
         case 2:
-            gen_helper_1e0i(mftacx, t0, 0);
+            /* XXX: For now we support only a single FPU context. */
+            if (h == 0) {
+                TCGv_i32 fp0 = tcg_temp_new_i32();
+
+                gen_load_fpr32(ctx, fp0, rt);
+                tcg_gen_ext_i32_tl(t0, fp0);
+                tcg_temp_free_i32(fp0);
+            } else {
+                TCGv_i32 fp0 = tcg_temp_new_i32();
+
+                gen_load_fpr32h(ctx, fp0, rt);
+                tcg_gen_ext_i32_tl(t0, fp0);
+                tcg_temp_free_i32(fp0);
+            }
             break;
-        case 4:
-            gen_helper_1e0i(mftlo, t0, 1);
+        case 3:
+            /* XXX: For now we support only a single FPU context. */
+            gen_helper_1e0i(cfc1, t0, rt);
             break;
+        /* COP2: Not implemented. */
+        case 4:
         case 5:
-            gen_helper_1e0i(mfthi, t0, 1);
-            break;
-        case 6:
-            gen_helper_1e0i(mftacx, t0, 1);
-            break;
-        case 8:
-            gen_helper_1e0i(mftlo, t0, 2);
-            break;
-        case 9:
-            gen_helper_1e0i(mfthi, t0, 2);
-            break;
-        case 10:
-            gen_helper_1e0i(mftacx, t0, 2);
-            break;
-        case 12:
-            gen_helper_1e0i(mftlo, t0, 3);
-            break;
-        case 13:
-            gen_helper_1e0i(mfthi, t0, 3);
-            break;
-        case 14:
-            gen_helper_1e0i(mftacx, t0, 3);
-            break;
-        case 16:
-            gen_helper_mftdsp(t0, cpu_env);
-            break;
+            /* fall through */
         default:
             goto die;
         }
-        break;
-    /* Floating point (COP1). */
-    case 2:
-        /* XXX: For now we support only a single FPU context. */
-        if (h == 0) {
-            TCGv_i32 fp0 = tcg_temp_new_i32();
-
-            gen_load_fpr32(ctx, fp0, rt);
-            tcg_gen_ext_i32_tl(t0, fp0);
-            tcg_temp_free_i32(fp0);
-        } else {
-            TCGv_i32 fp0 = tcg_temp_new_i32();
-
-            gen_load_fpr32h(ctx, fp0, rt);
-            tcg_gen_ext_i32_tl(t0, fp0);
-            tcg_temp_free_i32(fp0);
-        }
-        break;
-    case 3:
-        /* XXX: For now we support only a single FPU context. */
-        gen_helper_1e0i(cfc1, t0, rt);
-        break;
-    /* COP2: Not implemented. */
-    case 4:
-    case 5:
-        /* fall through */
-    default:
-        goto die;
     }
     trace_mips_translate_tr("mftr", rt, u, sel, h);
     gen_store_gpr(t0, rd);
@@ -10162,91 +10164,93 @@ static void gen_mttr(CPUMIPSState *env, DisasContext *ctx, int rd, int rt,
         default:
             gen_mtc0(ctx, t0, rd, sel);
         }
-    } else switch (sel) {
-    /* GPR registers. */
-    case 0:
-        gen_helper_0e1i(mttgpr, t0, rd);
-        break;
-    /* Auxiliary CPU registers */
-    case 1:
-        switch (rd) {
+    } else {
+        switch (sel) {
+        /* GPR registers. */
         case 0:
-            gen_helper_0e1i(mttlo, t0, 0);
+            gen_helper_0e1i(mttgpr, t0, rd);
             break;
+        /* Auxiliary CPU registers */
         case 1:
-            gen_helper_0e1i(mtthi, t0, 0);
+            switch (rd) {
+            case 0:
+                gen_helper_0e1i(mttlo, t0, 0);
+                break;
+            case 1:
+                gen_helper_0e1i(mtthi, t0, 0);
+                break;
+            case 2:
+                gen_helper_0e1i(mttacx, t0, 0);
+                break;
+            case 4:
+                gen_helper_0e1i(mttlo, t0, 1);
+                break;
+            case 5:
+                gen_helper_0e1i(mtthi, t0, 1);
+                break;
+            case 6:
+                gen_helper_0e1i(mttacx, t0, 1);
+                break;
+            case 8:
+                gen_helper_0e1i(mttlo, t0, 2);
+                break;
+            case 9:
+                gen_helper_0e1i(mtthi, t0, 2);
+                break;
+            case 10:
+                gen_helper_0e1i(mttacx, t0, 2);
+                break;
+            case 12:
+                gen_helper_0e1i(mttlo, t0, 3);
+                break;
+            case 13:
+                gen_helper_0e1i(mtthi, t0, 3);
+                break;
+            case 14:
+                gen_helper_0e1i(mttacx, t0, 3);
+                break;
+            case 16:
+                gen_helper_mttdsp(cpu_env, t0);
+                break;
+            default:
+                goto die;
+            }
             break;
+        /* Floating point (COP1). */
         case 2:
-            gen_helper_0e1i(mttacx, t0, 0);
+            /* XXX: For now we support only a single FPU context. */
+            if (h == 0) {
+                TCGv_i32 fp0 = tcg_temp_new_i32();
+
+                tcg_gen_trunc_tl_i32(fp0, t0);
+                gen_store_fpr32(ctx, fp0, rd);
+                tcg_temp_free_i32(fp0);
+            } else {
+                TCGv_i32 fp0 = tcg_temp_new_i32();
+
+                tcg_gen_trunc_tl_i32(fp0, t0);
+                gen_store_fpr32h(ctx, fp0, rd);
+                tcg_temp_free_i32(fp0);
+            }
             break;
-        case 4:
-            gen_helper_0e1i(mttlo, t0, 1);
+        case 3:
+            /* XXX: For now we support only a single FPU context. */
+            {
+                TCGv_i32 fs_tmp = tcg_const_i32(rd);
+
+                gen_helper_0e2i(ctc1, t0, fs_tmp, rt);
+                tcg_temp_free_i32(fs_tmp);
+            }
+            /* Stop translation as we may have changed hflags */
+            ctx->base.is_jmp = DISAS_STOP;
             break;
+        /* COP2: Not implemented. */
+        case 4:
         case 5:
-            gen_helper_0e1i(mtthi, t0, 1);
-            break;
-        case 6:
-            gen_helper_0e1i(mttacx, t0, 1);
-            break;
-        case 8:
-            gen_helper_0e1i(mttlo, t0, 2);
-            break;
-        case 9:
-            gen_helper_0e1i(mtthi, t0, 2);
-            break;
-        case 10:
-            gen_helper_0e1i(mttacx, t0, 2);
-            break;
-        case 12:
-            gen_helper_0e1i(mttlo, t0, 3);
-            break;
-        case 13:
-            gen_helper_0e1i(mtthi, t0, 3);
-            break;
-        case 14:
-            gen_helper_0e1i(mttacx, t0, 3);
-            break;
-        case 16:
-            gen_helper_mttdsp(cpu_env, t0);
-            break;
+            /* fall through */
         default:
             goto die;
         }
-        break;
-    /* Floating point (COP1). */
-    case 2:
-        /* XXX: For now we support only a single FPU context. */
-        if (h == 0) {
-            TCGv_i32 fp0 = tcg_temp_new_i32();
-
-            tcg_gen_trunc_tl_i32(fp0, t0);
-            gen_store_fpr32(ctx, fp0, rd);
-            tcg_temp_free_i32(fp0);
-        } else {
-            TCGv_i32 fp0 = tcg_temp_new_i32();
-
-            tcg_gen_trunc_tl_i32(fp0, t0);
-            gen_store_fpr32h(ctx, fp0, rd);
-            tcg_temp_free_i32(fp0);
-        }
-        break;
-    case 3:
-        /* XXX: For now we support only a single FPU context. */
-        {
-            TCGv_i32 fs_tmp = tcg_const_i32(rd);
-
-            gen_helper_0e2i(ctc1, t0, fs_tmp, rt);
-            tcg_temp_free_i32(fs_tmp);
-        }
-        /* Stop translation as we may have changed hflags */
-        ctx->base.is_jmp = DISAS_STOP;
-        break;
-    /* COP2: Not implemented. */
-    case 4:
-    case 5:
-        /* fall through */
-    default:
-        goto die;
     }
     trace_mips_translate_tr("mttr", rd, u, sel, h);
     tcg_temp_free(t0);
@@ -10492,7 +10496,7 @@ static void gen_compute_branch1(DisasContext *ctx, uint32_t op,
         {
             TCGv_i32 t1 = tcg_temp_new_i32();
             tcg_gen_shri_i32(t0, fpu_fcr31, get_fp_bit(cc));
-            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc+1));
+            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc + 1));
             tcg_gen_nand_i32(t0, t0, t1);
             tcg_temp_free_i32(t1);
             tcg_gen_andi_i32(t0, t0, 1);
@@ -10503,7 +10507,7 @@ static void gen_compute_branch1(DisasContext *ctx, uint32_t op,
         {
             TCGv_i32 t1 = tcg_temp_new_i32();
             tcg_gen_shri_i32(t0, fpu_fcr31, get_fp_bit(cc));
-            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc+1));
+            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc + 1));
             tcg_gen_or_i32(t0, t0, t1);
             tcg_temp_free_i32(t1);
             tcg_gen_andi_i32(t0, t0, 1);
@@ -10514,11 +10518,11 @@ static void gen_compute_branch1(DisasContext *ctx, uint32_t op,
         {
             TCGv_i32 t1 = tcg_temp_new_i32();
             tcg_gen_shri_i32(t0, fpu_fcr31, get_fp_bit(cc));
-            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc+1));
+            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc + 1));
             tcg_gen_and_i32(t0, t0, t1);
-            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc+2));
+            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc + 2));
             tcg_gen_and_i32(t0, t0, t1);
-            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc+3));
+            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc + 3));
             tcg_gen_nand_i32(t0, t0, t1);
             tcg_temp_free_i32(t1);
             tcg_gen_andi_i32(t0, t0, 1);
@@ -10529,11 +10533,11 @@ static void gen_compute_branch1(DisasContext *ctx, uint32_t op,
         {
             TCGv_i32 t1 = tcg_temp_new_i32();
             tcg_gen_shri_i32(t0, fpu_fcr31, get_fp_bit(cc));
-            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc+1));
+            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc + 1));
             tcg_gen_or_i32(t0, t0, t1);
-            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc+2));
+            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc + 2));
             tcg_gen_or_i32(t0, t0, t1);
-            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc+3));
+            tcg_gen_shri_i32(t1, fpu_fcr31, get_fp_bit(cc + 3));
             tcg_gen_or_i32(t0, t0, t1);
             tcg_temp_free_i32(t1);
             tcg_gen_andi_i32(t0, t0, 1);
@@ -10997,7 +11001,7 @@ static inline void gen_movcf_ps(DisasContext *ctx, int fs, int fd,
     gen_store_fpr32(ctx, t0, fd);
     gen_set_label(l1);
 
-    tcg_gen_andi_i32(t0, fpu_fcr31, 1 << get_fp_bit(cc+1));
+    tcg_gen_andi_i32(t0, fpu_fcr31, 1 << get_fp_bit(cc + 1));
     tcg_gen_brcondi_i32(cond, t0, 0, l2);
     gen_load_fpr32h(ctx, t0, fs);
     gen_store_fpr32h(ctx, t0, fd);
@@ -11611,9 +11615,9 @@ static void gen_farith(DisasContext *ctx, enum fopcode op1,
     case OPC_CMP_NGT_S:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
         if (ctx->opcode & (1 << 6)) {
-            gen_cmpabs_s(ctx, func-48, ft, fs, cc);
+            gen_cmpabs_s(ctx, func - 48, ft, fs, cc);
         } else {
-            gen_cmp_s(ctx, func-48, ft, fs, cc);
+            gen_cmp_s(ctx, func - 48, ft, fs, cc);
         }
         break;
     case OPC_ADD_D:
@@ -12093,9 +12097,9 @@ static void gen_farith(DisasContext *ctx, enum fopcode op1,
     case OPC_CMP_NGT_D:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
         if (ctx->opcode & (1 << 6)) {
-            gen_cmpabs_d(ctx, func-48, ft, fs, cc);
+            gen_cmpabs_d(ctx, func - 48, ft, fs, cc);
         } else {
-            gen_cmp_d(ctx, func-48, ft, fs, cc);
+            gen_cmp_d(ctx, func - 48, ft, fs, cc);
         }
         break;
     case OPC_CVT_S_D:
@@ -12495,9 +12499,9 @@ static void gen_farith(DisasContext *ctx, enum fopcode op1,
     case OPC_CMP_LE_PS:
     case OPC_CMP_NGT_PS:
         if (ctx->opcode & (1 << 6)) {
-            gen_cmpabs_ps(ctx, func-48, ft, fs, cc);
+            gen_cmpabs_ps(ctx, func - 48, ft, fs, cc);
         } else {
-            gen_cmp_ps(ctx, func-48, ft, fs, cc);
+            gen_cmp_ps(ctx, func - 48, ft, fs, cc);
         }
         break;
     default:
@@ -14310,7 +14314,7 @@ static int decode_mips16_opc(CPUMIPSState *env, DisasContext *ctx)
             case RR_RY_CNVT_SEH:
                 tcg_gen_ext16s_tl(cpu_gpr[rx], cpu_gpr[rx]);
                 break;
-#if defined (TARGET_MIPS64)
+#if defined(TARGET_MIPS64)
             case RR_RY_CNVT_ZEW:
                 check_insn(ctx, ISA_MIPS64);
                 check_mips_64(ctx);
@@ -15034,11 +15038,11 @@ static int mmreg2(int r)
 
 /* Signed immediate */
 #define SIMM(op, start, width)                                          \
-    ((int32_t)(((op >> start) & ((~0U) >> (32-width)))                 \
-               << (32-width))                                           \
-     >> (32-width))
+    ((int32_t)(((op >> start) & ((~0U) >> (32 - width)))                \
+               << (32 - width))                                         \
+     >> (32 - width))
 /* Zero-extended immediate */
-#define ZIMM(op, start, width) ((op >> start) & ((~0U) >> (32-width)))
+#define ZIMM(op, start, width) ((op >> start) & ((~0U) >> (32 - width)))
 
 static void gen_addiur1sp(DisasContext *ctx)
 {
@@ -15732,7 +15736,10 @@ static void gen_pool32axf(CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
                 save_cpu_state(ctx, 1);
                 gen_helper_di(t0, cpu_env);
                 gen_store_gpr(t0, rs);
-                /* Stop translation as we may have switched the execution mode */
+                /*
+                 * Stop translation as we may have switched the execution
+                 * mode.
+                 */
                 ctx->base.is_jmp = DISAS_STOP;
                 tcg_temp_free(t0);
             }
@@ -15854,9 +15861,9 @@ static void gen_pool32fxf(DisasContext *ctx, int rt, int rs)
     int extension = (ctx->opcode >> 6) & 0x3ff;
     uint32_t mips32_op;
 
-#define FLOAT_1BIT_FMT(opc, fmt) (fmt << 8) | opc
-#define FLOAT_2BIT_FMT(opc, fmt) (fmt << 7) | opc
-#define COND_FLOAT_MOV(opc, cond) (cond << 7) | opc
+#define FLOAT_1BIT_FMT(opc, fmt)    ((fmt << 8) | opc)
+#define FLOAT_2BIT_FMT(opc, fmt)    ((fmt << 7) | opc)
+#define COND_FLOAT_MOV(opc, cond)   ((cond << 7) | opc)
 
     switch (extension) {
     case FLOAT_1BIT_FMT(CFC1, 0):
@@ -30253,7 +30260,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     translator_loop(&mips_tr_ops, &ctx.base, cs, tb, max_insns);
 }
 
-static void fpu_dump_state(CPUMIPSState *env, FILE *f, int flags)
+static void fpu_dump_state(CPUMIPSState *env, FILE * f, int flags)
 {
     int i;
     int is_fpu64 = !!(env->hflags & MIPS_HFLAG_F64);
@@ -30278,7 +30285,7 @@ static void fpu_dump_state(CPUMIPSState *env, FILE *f, int flags)
                          (double)tmp.fs[FP_ENDIAN_IDX],                 \
                          (double)tmp.fs[!FP_ENDIAN_IDX]);               \
         }                                                               \
-    } while(0)
+    } while (0)
 
 
     qemu_fprintf(f,
@@ -30315,7 +30322,8 @@ void mips_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
     }
 
-    qemu_fprintf(f, "CP0 Status  0x%08x Cause   0x%08x EPC    0x" TARGET_FMT_lx "\n",
+    qemu_fprintf(f, "CP0 Status  0x%08x Cause   0x%08x EPC    0x"
+                 TARGET_FMT_lx "\n",
                  env->CP0_Status, env->CP0_Cause, env->CP0_EPC);
     qemu_fprintf(f, "    Config0 0x%08x Config1 0x%08x LLAddr 0x%016"
                  PRIx64 "\n",
@@ -30336,7 +30344,8 @@ void mips_tcg_init(void)
     cpu_gpr[0] = NULL;
     for (i = 1; i < 32; i++)
         cpu_gpr[i] = tcg_global_mem_new(cpu_env,
-                                        offsetof(CPUMIPSState, active_tc.gpr[i]),
+                                        offsetof(CPUMIPSState,
+                                                 active_tc.gpr[i]),
                                         regnames[i]);
 
     for (i = 0; i < 32; i++) {
@@ -30364,7 +30373,8 @@ void mips_tcg_init(void)
                                        regnames_LO[i]);
     }
     cpu_dspctrl = tcg_global_mem_new(cpu_env,
-                                     offsetof(CPUMIPSState, active_tc.DSPControl),
+                                     offsetof(CPUMIPSState,
+                                              active_tc.DSPControl),
                                      "DSPControl");
     bcond = tcg_global_mem_new(cpu_env,
                                offsetof(CPUMIPSState, bcond), "bcond");
-- 
2.7.4



