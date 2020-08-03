Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4ADC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC3220738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvSGWSoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC3220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YWV-0006j3-I8
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUe-0003le-S3
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:19:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUc-0004sa-OY
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:19:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id y3so33834971wrl.4
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WVrz2TM2NyRna3FiFYVkgyDOwt7IGSm5Yz6r2adar/U=;
 b=NvSGWSoBLJetqXNdwYo96/W38omvRb+umlpFKea4Mp6gwqduZxaTAxgQvXk7ZhXK9U
 bbNYVcuiPD3XCz0ZJ7DGXWet3IYrMJnsnSW6Srxu7kSgL/zC90cve0SAVW4Z7vTRQZqJ
 JEknAhLVKjf2l+vOATB8toQOVRaZzyxprj5QwNMaE1OYFxCiHtBwKQTJssRAzqF/XbFZ
 MfX0FNESJUTgv9suf2P8vkR/SJImfVDW4ZLvBa1xHirRQlQFWvP+Rkwr58JwXSs2IPNW
 KZlDJQcryEr/5dKwjSro75pvLRzwZzIITAHw3oxsC/3ysX3slVcZlqjObo+EhpRNbV4M
 ZvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WVrz2TM2NyRna3FiFYVkgyDOwt7IGSm5Yz6r2adar/U=;
 b=SrTD4cylv53K2gb3V/jaGeyC50yJu4lHhoKFxtCPHjlM7mfYAOnZOrg0K0AZXqJUhu
 kMPCoNr7oibJ1ecIraYW3QPxRZEpMmcWIuq5l1dYHNBt8K0Goa9ZqOm6ATXknvj64bYa
 qeVfm7rOtMzX+RT+3bpzBKMPq+Y7KuC2sYxL1nZJOsfBbRHrikeeQboHbhhJsw0cUd/u
 kLjn3FtoG1X7izB5QWdvjAN9Y2WS5wFqSjtPrFZT+0Ggb4qD5bsIw1L/SyI+JyfaJD1t
 tDBN7CFcKVNP3Ej8sa5Fd3xPABJB6jxu7jvjvjddU9Pjesfpp0Q0TpxTLCHi3ZIJVzOA
 vQKA==
X-Gm-Message-State: AOAM531UTs/ohvZPDCUCg38p0lPgBIfZPRxlukpFZv/nHJrLSkreeu2n
 TVHE+/5QMX3mYvsdxXplaJfolw==
X-Google-Smtp-Source: ABdhPJwy9ahWnfcRK20qOxI9Hy8UeCsMdrRSKe9Sd0klGsR4ZCJOt3VkY/r9+6TsMDIGIkRcqSvhcQ==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr15026360wrt.67.1596453536941; 
 Mon, 03 Aug 2020 04:18:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g3sm28013170wrb.59.2020.08.03.04.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 04:18:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/7] target/arm: Convert A32 coprocessor insns to decodetree
Date: Mon,  3 Aug 2020 12:18:45 +0100
Message-Id: <20200803111849.13368-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803111849.13368-1-peter.maydell@linaro.org>
References: <20200803111849.13368-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the A32 coprocessor instructions to decodetree.

Note that this corrects an underdecoding: for the 64-bit access case
(MRRC/MCRR) we did not check that bits [24:21] were 0b0010, so we
would incorrectly treat LDC/STC as MRRC/MCRR rather than UNDEFing
them.

The decodetree versions of these insns assume the coprocessor
is in the range 0..7 or 14..15. This is architecturally sensible
(as per the comments) and OK in practice for QEMU because the only
uses of the ARMCPRegInfo infrastructure we have that aren't
for coprocessors 14 or 15 are the pxa2xx use of coprocessor 6.
We add an assertion to the define_one_arm_cp_reg_with_opaque()
function to catch any accidental future attempts to use it to
define coprocessor registers for invalid coprocessors.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/a32.decode  | 19 +++++++++++
 target/arm/helper.c    | 29 +++++++++++++++++
 target/arm/translate.c | 74 +++++++++++++++++++++++++++++++++++-------
 3 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 0bd952c0692..4dfd9139bf3 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -47,6 +47,8 @@
 &bfi             rd rn lsb msb
 &sat             rd rn satimm imm sh
 &pkh             rd rn rm imm tb
+&mcr             cp opc1 crn crm opc2 rt
+&mcrr            cp opc1 crm rt rt2
 
 # Data-processing (register)
 
@@ -529,6 +531,23 @@ LDM_a32          ---- 100 b:1 i:1 u:1 w:1 1 rn:4 list:16   &ldst_block
 B                .... 1010 ........................           @branch
 BL               .... 1011 ........................           @branch
 
+# Coprocessor instructions
+
+# We decode MCR, MCR, MRRC and MCRR only, because for QEMU the
+# other coprocessor instructions always UNDEF.
+# The trans_ functions for these will ignore cp values 8..13 for v7 or
+# earlier, and 0..13 for v8 and later, because those areas of the
+# encoding space may be used for other things, such as VFP or Neon.
+
+@mcr             ---- .... opc1:3 . crn:4 rt:4 cp:4 opc2:3 . crm:4 &mcr
+@mcrr            ---- .... .... rt2:4 rt:4 cp:4 opc1:4 crm:4       &mcrr
+
+MCRR             .... 1100 0100 .... .... .... .... .... @mcrr
+MRRC             .... 1100 0101 .... .... .... .... .... @mcrr
+
+MCR              .... 1110 ... 0 .... .... .... ... 1 .... @mcr
+MRC              .... 1110 ... 1 .... .... .... ... 1 .... @mcr
+
 # Supervisor call
 
 SVC              ---- 1111 imm:24                             &i
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8ef0fb478f4..b0acc90e075 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8462,6 +8462,35 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
     assert((r->state != ARM_CP_STATE_AA32) || (r->opc0 == 0));
     /* AArch64 regs are all 64 bit so ARM_CP_64BIT is meaningless */
     assert((r->state != ARM_CP_STATE_AA64) || !(r->type & ARM_CP_64BIT));
+    /*
+     * This API is only for Arm's system coprocessors (14 and 15) or
+     * (M-profile or v7A-and-earlier only) for implementation defined
+     * coprocessors in the range 0..7.  Our decode assumes this, since
+     * 8..13 can be used for other insns including VFP and Neon. See
+     * valid_cp() in translate.c.  Assert here that we haven't tried
+     * to use an invalid coprocessor number.
+     */
+    switch (r->state) {
+    case ARM_CP_STATE_BOTH:
+        /* 0 has a special meaning, but otherwise the same rules as AA32. */
+        if (r->cp == 0) {
+            break;
+        }
+        /* fall through */
+    case ARM_CP_STATE_AA32:
+        if (arm_feature(&cpu->env, ARM_FEATURE_V8) &&
+            !arm_feature(&cpu->env, ARM_FEATURE_M)) {
+            assert(r->cp >= 14 && r->cp <= 15);
+        } else {
+            assert(r->cp < 8 || (r->cp >= 14 && r->cp <= 15));
+        }
+        break;
+    case ARM_CP_STATE_AA64:
+        assert(r->cp == 0 || r->cp == CP_REG_ARM64_SYSREG_CP);
+        break;
+    default:
+        g_assert_not_reached();
+    }
     /* The AArch64 pseudocode CheckSystemAccess() specifies that op1
      * encodes a minimum access level for the register. We roll this
      * runtime check into our general permission check code, so check
diff --git a/target/arm/translate.c b/target/arm/translate.c
index cfdcf5281d3..b1be4cb9d60 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5237,6 +5237,68 @@ static int t16_pop_list(DisasContext *s, int x)
 #include "decode-t32.inc.c"
 #include "decode-t16.inc.c"
 
+static bool valid_cp(DisasContext *s, int cp)
+{
+    /*
+     * Return true if this coprocessor field indicates something
+     * that's really a possible coprocessor.
+     * For v7 and earlier, coprocessors 8..15 were reserved for Arm use,
+     * and of those only cp14 and cp15 were used for registers.
+     * cp10 and cp11 were used for VFP and Neon, whose decode is
+     * dealt with elsewhere. With the advent of fp16, cp9 is also
+     * now part of VFP.
+     * For v8A and later, the encoding has been tightened so that
+     * only cp14 and cp15 are valid, and other values aren't considered
+     * to be in the coprocessor-instruction space at all. v8M still
+     * permits coprocessors 0..7.
+     */
+    if (arm_dc_feature(s, ARM_FEATURE_V8) &&
+        !arm_dc_feature(s, ARM_FEATURE_M)) {
+        return cp >= 14;
+    }
+    return cp < 8 || cp >= 14;
+}
+
+static bool trans_MCR(DisasContext *s, arg_MCR *a)
+{
+    if (!valid_cp(s, a->cp)) {
+        return false;
+    }
+    do_coproc_insn(s, a->cp, false, a->opc1, a->crn, a->crm, a->opc2,
+                   false, a->rt, 0);
+    return true;
+}
+
+static bool trans_MRC(DisasContext *s, arg_MRC *a)
+{
+    if (!valid_cp(s, a->cp)) {
+        return false;
+    }
+    do_coproc_insn(s, a->cp, false, a->opc1, a->crn, a->crm, a->opc2,
+                   true, a->rt, 0);
+    return true;
+}
+
+static bool trans_MCRR(DisasContext *s, arg_MCRR *a)
+{
+    if (!valid_cp(s, a->cp)) {
+        return false;
+    }
+    do_coproc_insn(s, a->cp, true, a->opc1, 0, a->crm, 0,
+                   false, a->rt, a->rt2);
+    return true;
+}
+
+static bool trans_MRRC(DisasContext *s, arg_MRRC *a)
+{
+    if (!valid_cp(s, a->cp)) {
+        return false;
+    }
+    do_coproc_insn(s, a->cp, true, a->opc1, 0, a->crm, 0,
+                   true, a->rt, a->rt2);
+    return true;
+}
+
 /* Helpers to swap operands for reverse-subtract.  */
 static void gen_rsb(TCGv_i32 dst, TCGv_i32 a, TCGv_i32 b)
 {
@@ -8293,17 +8355,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             disas_xscale_insn(s, insn);
             break;
         }
-
-        if ((cpnum & 0xe) == 10) {
-            /* VFP, but failed disas_vfp.  */
-            goto illegal_op;
-        }
-
-        if (disas_coproc_insn(s, insn)) {
-            /* Coprocessor.  */
-            goto illegal_op;
-        }
-        break;
+        /* fall through */
     }
     default:
     illegal_op:
-- 
2.20.1


