Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1BBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B456020738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLByYNFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B456020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YZc-000235-QQ
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUc-0003hI-Ig
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:18:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUa-0004sE-JA
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:18:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id k20so15047229wmi.5
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 04:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GdK1Bc8JNmdYj342FXS0zCz0nM9XuyCr0eFVY1VBs2Q=;
 b=xLByYNFXUy8ENf1HBwA0fIR6SHk/p6AI3SIUWqykqtbWlwS+siTiTE4GHVATZjatOw
 ViLTRlu332AUKOc8AmacvfA5XA6HCxwRleEDDn+mHRg8FqaXb51976/139U3jodnvdDb
 iC41aVLb26dkC2nqJpAVAFMOvKtGba0MDADOMw23ClGu/R/5pb7I/MtWtAG0+21Icw3d
 Uqu+lYNli1lP5flBM2SIY4Po3TjrJzuqAT2Efh5UKuG2VvrO+WCnf9bqMqNr9nDMS55a
 YqJPsG4EHeoCLY+mUN93Tti4FoLT1uC2ksumJKkd8eh5Ev1CnWC7eaLwZqcgwQHHp8yb
 g0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GdK1Bc8JNmdYj342FXS0zCz0nM9XuyCr0eFVY1VBs2Q=;
 b=N+WJjK5y2ZeKhV6MAVsc4o4l1MpG3rpVfyDySfO8taEFMvDNx4f8nHlUmd0vo1fO6c
 hSxxZS1rvf6p1+8d5y3bWsxlfjSHKdsoryGX8vQERfxNaKKWJBg4ANrVtDOl37/RcqRK
 weUFmrOAUMuAbSPLI8DofzAK5cP9+TCsB/AmaKFwkRwLkHbLrnOt1cu0sKY3JYyFktnY
 ZndGgHZr2CxknqnWafvYEHAd0ulMne6pODf/44u9cniY6ypMt8jai4LzzCMq2MtJgsRu
 cpo19sDP5DDmktfGgGaz8Cdku6AkiddWI29yns5wVazXAddNUI2eCg4lpfTczyhZ4aIA
 EGnw==
X-Gm-Message-State: AOAM5327cUbTazD8qwbtqbs6lz45vX3Zymb4MK+ajtHABhHkxS1IPicX
 arQ8UMEKdB/RXv18CZHGlBeXOefvkcx1kw==
X-Google-Smtp-Source: ABdhPJyUU1CezH1iYPBmMHSsVlXE6SaFt+VsWaExyLoKybBZf89z891THvJ+VlR8pjK6pM3fITDtSA==
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr15368269wma.30.1596453534856; 
 Mon, 03 Aug 2020 04:18:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g3sm28013170wrb.59.2020.08.03.04.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 04:18:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/7] target/arm: Separate decode from handling of coproc insns
Date: Mon,  3 Aug 2020 12:18:44 +0100
Message-Id: <20200803111849.13368-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803111849.13368-1-peter.maydell@linaro.org>
References: <20200803111849.13368-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

As a prelude to making coproc insns use decodetree, split out the
part of disas_coproc_insn() which does instruction decoding from the
part which does the actual work, and make do_coproc_insn() handle the
UNDEF-on-bad-permissions and similar cases itself rather than
returning 1 to eventually percolate up to a callsite that calls
unallocated_encoding() for it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 76 ++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a2765fc60b2..cfdcf5281d3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4544,34 +4544,12 @@ void gen_gvec_uaba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
-static int disas_coproc_insn(DisasContext *s, uint32_t insn)
+static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
+                           int opc1, int crn, int crm, int opc2,
+                           bool isread, int rt, int rt2)
 {
-    int cpnum, is64, crn, crm, opc1, opc2, isread, rt, rt2;
     const ARMCPRegInfo *ri;
 
-    cpnum = (insn >> 8) & 0xf;
-
-    is64 = (insn & (1 << 25)) == 0;
-    if (!is64 && ((insn & (1 << 4)) == 0)) {
-        /* cdp */
-        return 1;
-    }
-
-    crm = insn & 0xf;
-    if (is64) {
-        crn = 0;
-        opc1 = (insn >> 4) & 0xf;
-        opc2 = 0;
-        rt2 = (insn >> 16) & 0xf;
-    } else {
-        crn = (insn >> 16) & 0xf;
-        opc1 = (insn >> 21) & 7;
-        opc2 = (insn >> 5) & 7;
-        rt2 = 0;
-    }
-    isread = (insn >> 20) & 1;
-    rt = (insn >> 12) & 0xf;
-
     ri = get_arm_cp_reginfo(s->cp_regs,
             ENCODE_CP_REG(cpnum, is64, s->ns, crn, crm, opc1, opc2));
     if (ri) {
@@ -4579,7 +4557,8 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 
         /* Check access permissions */
         if (!cp_access_ok(s->current_el, ri, isread)) {
-            return 1;
+            unallocated_encoding(s);
+            return;
         }
 
         if (s->hstr_active || ri->accessfn ||
@@ -4653,14 +4632,15 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
         /* Handle special cases first */
         switch (ri->type & ~(ARM_CP_FLAG_MASK & ~ARM_CP_SPECIAL)) {
         case ARM_CP_NOP:
-            return 0;
+            return;
         case ARM_CP_WFI:
             if (isread) {
-                return 1;
+                unallocated_encoding(s);
+                return;
             }
             gen_set_pc_im(s, s->base.pc_next);
             s->base.is_jmp = DISAS_WFI;
-            return 0;
+            return;
         default:
             break;
         }
@@ -4720,7 +4700,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             /* Write */
             if (ri->type & ARM_CP_CONST) {
                 /* If not forbidden by access permissions, treat as WI */
-                return 0;
+                return;
             }
 
             if (is64) {
@@ -4786,7 +4766,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             gen_lookup_tb(s);
         }
 
-        return 0;
+        return;
     }
 
     /* Unknown register; this might be a guest error or a QEMU
@@ -4806,7 +4786,39 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
                       s->ns ? "non-secure" : "secure");
     }
 
-    return 1;
+    unallocated_encoding(s);
+    return;
+}
+
+static int disas_coproc_insn(DisasContext *s, uint32_t insn)
+{
+    int cpnum, is64, crn, crm, opc1, opc2, isread, rt, rt2;
+
+    cpnum = (insn >> 8) & 0xf;
+
+    is64 = (insn & (1 << 25)) == 0;
+    if (!is64 && ((insn & (1 << 4)) == 0)) {
+        /* cdp */
+        return 1;
+    }
+
+    crm = insn & 0xf;
+    if (is64) {
+        crn = 0;
+        opc1 = (insn >> 4) & 0xf;
+        opc2 = 0;
+        rt2 = (insn >> 16) & 0xf;
+    } else {
+        crn = (insn >> 16) & 0xf;
+        opc1 = (insn >> 21) & 7;
+        opc2 = (insn >> 5) & 7;
+        rt2 = 0;
+    }
+    isread = (insn >> 20) & 1;
+    rt = (insn >> 12) & 0xf;
+
+    do_coproc_insn(s, cpnum, is64, opc1, crn, crm, opc2, isread, rt, rt2);
+    return 0;
 }
 
 /* Decode XScale DSP or iWMMXt insn (in the copro space, cp=0 or 1) */
-- 
2.20.1


