Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FC8C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF7320663
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5G/mGkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF7320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmaB-0000tw-Gt
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJf-00075U-H3
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJa-00013x-PZ
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:17 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:35788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJa-00013T-KD
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:14 -0400
Received: by mail-pf1-x434.google.com with SMTP id 205so9281939pfw.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QD+wZzGPXKzCZAwgjUrbeScdVsIlsrL6yXXxm/mMbjU=;
 b=t5G/mGkfKBnoN0J+svQUqMBJaIPYg7iDZP5FKD7Rmhpf7LrNfT5iIQUgAdHKssawpV
 W+Q0LwZCuK4mAo4r1FNemOBHR3PwINtFm9FOCem8hpx6GY5TMyc604pitw9k1j7pbXwK
 l6ofuOS9LMNrm2hbAXm1DLCZhpWrkIqNfV8jBXNlW3jbU7NR6t/X/Op4Itn3Op61L4vb
 3zbLAi/VDrooYRDXHcwGxKqdr6mR7gpfkvdWXQG3T62dJSzEnnn8HgjWa/5nmXe8ExyC
 pip3NjBkyjWOMHaG1E6E7jW+92yocN9fxiTIAmF+29RB2UdITgYkW5BCzumEFmO9Kbaa
 B5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QD+wZzGPXKzCZAwgjUrbeScdVsIlsrL6yXXxm/mMbjU=;
 b=iNCjQblSaEInc/cMYPI6X0ReAiO4wBmwcqU9ZdfypG7SF0xxm8SQhR1KsSWzwrLA6m
 TbuymPaG9S/2xigBYGV44pmfKLbef6tBeMMjf3Z4lzNVcADncHNkCL9pLiR4JVBbX2Qd
 XIxFKjflZyZO/+2EO34/PbhfewdwUzY/vd35kQ3R2YONiDMx6vjIye2MTmY250ejTWAv
 GkGEtk/B90avut/TL2P0KFAI/ujJkqJPyZCbquYZHy8XzQBrs18QSXXeyxZlnvpjHnLc
 U1qrPb9vhGXqzKWatCDBTwB2ni/X9C9dqAcHo8emK0mAv/Wkj2gZK3hSwwvS9rMq7RsI
 RpJA==
X-Gm-Message-State: APjAAAXh0/Aox8ExwHg1rxbFonGEHLaxOTNFYXj6j3p+epD5B/GhoKpJ
 +31jEkrHkYRJ6vmQ/NGYHsfz15L9tSU=
X-Google-Smtp-Source: APXvYqxrBr62bbWe174IhXasUIazAKk7gFHY64leihoCLEIhdQirNQCtdVjkxiIybYwiMOUmW+8yng==
X-Received: by 2002:a17:90a:cf8c:: with SMTP id
 i12mr32697855pju.77.1571005572881; 
 Sun, 13 Oct 2019 15:26:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:26:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/23] tcg/ppc: Update vector support for v3.00 Altivec
Date: Sun, 13 Oct 2019 15:25:41 -0700
Message-Id: <20191013222544.3679-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::434
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These new instructions are conditional only on MSR.VEC and
are thus part of the Altivec instruction set, and not VSX.
This includes negation and compare not equal.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.h     |  2 +-
 tcg/ppc/tcg-target.inc.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 13197eddce..4fa21f0e71 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -159,7 +159,7 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_andc_vec         1
 #define TCG_TARGET_HAS_orc_vec          have_isa_2_07
 #define TCG_TARGET_HAS_not_vec          1
-#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_neg_vec          have_isa_3_00
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 840464aab5..bd9259c60f 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -499,6 +499,9 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VSUBUWM    VX4(1152)
 #define VSUBUDM    VX4(1216)      /* v2.07 */
 
+#define VNEGW      (VX4(1538) | (6 << 16))  /* v3.00 */
+#define VNEGD      (VX4(1538) | (7 << 16))  /* v3.00 */
+
 #define VMAXSB     VX4(258)
 #define VMAXSH     VX4(322)
 #define VMAXSW     VX4(386)
@@ -528,6 +531,9 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VCMPGTUH   VX4(582)
 #define VCMPGTUW   VX4(646)
 #define VCMPGTUD   VX4(711)       /* v2.07 */
+#define VCMPNEB    VX4(7)         /* v3.00 */
+#define VCMPNEH    VX4(71)        /* v3.00 */
+#define VCMPNEW    VX4(135)       /* v3.00 */
 
 #define VSLB       VX4(260)
 #define VSLH       VX4(324)
@@ -2976,6 +2982,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
         return vece <= MO_32 || have_isa_2_07 ? -1 : 0;
+    case INDEX_op_neg_vec:
+        return vece >= MO_32 && have_isa_3_00;
     case INDEX_op_mul_vec:
         switch (vece) {
         case MO_8:
@@ -3090,7 +3098,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const uint32_t
         add_op[4] = { VADDUBM, VADDUHM, VADDUWM, VADDUDM },
         sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, VSUBUDM },
+        neg_op[4] = { 0, 0, VNEGW, VNEGD },
         eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
+        ne_op[4]  = { VCMPNEB, VCMPNEH, VCMPNEW, 0 },
         gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, VCMPGTSD },
         gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, VCMPGTUD },
         ssadd_op[4] = { VADDSBS, VADDSHS, VADDSWS, 0 },
@@ -3132,6 +3142,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sub_vec:
         insn = sub_op[vece];
         break;
+    case INDEX_op_neg_vec:
+        insn = neg_op[vece];
+        a2 = a1;
+        a1 = 0;
+        break;
     case INDEX_op_mul_vec:
         tcg_debug_assert(vece == MO_32 && have_isa_2_07);
         insn = VMULUWM;
@@ -3194,6 +3209,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         case TCG_COND_EQ:
             insn = eq_op[vece];
             break;
+        case TCG_COND_NE:
+            insn = ne_op[vece];
+            break;
         case TCG_COND_GT:
             insn = gts_op[vece];
             break;
@@ -3276,6 +3294,10 @@ static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
     case TCG_COND_GTU:
         break;
     case TCG_COND_NE:
+        if (have_isa_3_00 && vece <= MO_32) {
+            break;
+        }
+        /* fall through */
     case TCG_COND_LE:
     case TCG_COND_LEU:
         need_inv = true;
@@ -3599,6 +3621,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dup2_vec:
         return &v_v_v;
     case INDEX_op_not_vec:
+    case INDEX_op_neg_vec:
     case INDEX_op_dup_vec:
         return &v_v;
     case INDEX_op_ld_vec:
-- 
2.17.1


