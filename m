Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA21C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2AC2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwOThDNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2AC2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA999-0004ch-Ls
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95f-0005Ae-GJ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95d-0004oE-L2
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id u18so7678332wmc.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Ers+2j+PuXTXZBmM5L2AbHjg4xxB43Gsae3bEhiWv7U=;
 b=GwOThDNJxE+MXtMBO/W6ShAW7d3zawWWujDY2vR7uiL8IICRgU4v4ViRwjgI9Gdz88
 olB7u5KMEQ2o+9C4yuBt1xsJLpIv59Dy36WMqdhUkjsO4hw1renXLamuWTUfVKGbUkvM
 7SRAB2xAYr71hG5x8OuxJzCBDhGYVvLgGTIb3qsGXLW0soUIQ+67jqnl1jwihV1IUrUs
 /w5SVxbuBZjXWtQlv2Mu5o/QhMQONNdC9dOL86zvG3qev8KVQzjoE2podWUZpFmAdzhr
 4fc8AV3JszUHa4SKuGUIHKT9U3DsG8Q1QC7F9AHkLgRi0uYtJQQv9JbFvXHkWEkppM7V
 czYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ers+2j+PuXTXZBmM5L2AbHjg4xxB43Gsae3bEhiWv7U=;
 b=oQ/CQl1DcEmCahz1JwOJsMPkOYwFZIY1JZznN6oM9HUJO357antgX8nE/A008heLGt
 ryPB65TnKrK9RwCiN3XD5sZ4ifonMdbtaPS1Dp44nlyAurNTQtDoYZpdOyF9FT47AwBF
 hzgL8rHPyW5+kRz+Oe9OkQ8z9Nrs1v9VTMo/OfG/hlssktTh+zwbwyUcrAA7CnP4d531
 8tt42WIEih7x7toCq3g7pPrvBjrNZCUJpSRIv3CK+jlh0JPgDrE7GFDHMZeVlGYXMiUb
 HMaSyDKUGbFMLZGkX8AQ7t8Q0QRQo9da/3SC6KJd4DPhtCfrEzIM8b9nRoLdATZFyOYj
 HE7w==
X-Gm-Message-State: AOAM5318AtwF5rC7nGD3ZYDWwp5ZgsA22gDwHOzjZiig5Co4NJOq8qUW
 K88bpgq79G/StZhxoiqr8cwkWRppkTPMb9Zc
X-Google-Smtp-Source: ABdhPJyCLH2nsnVGVsTlixf7UT7qUUaAESanCIIAEzEKQqmu8wlrgUIM/raNsfmGvf3eZixGCKRu2Q==
X-Received: by 2002:a1c:81cb:: with SMTP id c194mr4985684wmd.45.1598262511754; 
 Mon, 24 Aug 2020 02:48:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/27] target/arm: Separate decode from handling of coproc insns
Date: Mon, 24 Aug 2020 10:47:59 +0100
Message-Id: <20200824094811.15439-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200803111849.13368-3-peter.maydell@linaro.org
---
 target/arm/translate.c | 76 ++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 99663236aa9..01591f0e325 100644
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


