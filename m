Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31ACC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8139220707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qa5C1gPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8139220707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8T4-0002xQ-M8
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LF-00079d-Px
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LE-00041Y-2s
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id e1so20115026wrt.5
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RWaFdHsNmoZiIGD3MhG3D1b0aLfu9vsKuqSW1LCpePY=;
 b=qa5C1gPXolPkSznK8ZoLu9IWgxeoRssor+5DLKE87Vmrjak0ZtnH4mzt/N3iJ+/qpl
 LkW6tAlbdXZkqvMNRfW4182fQOv78O6TUJOz68Bgn08XEc3VXuSoXl613dQioGPCJleK
 bu2LbuUUKanaSutgBy93WSFJW1uJjgr/izE8Q1/13wpH5kCRAOQy9yvbkEpuFJGhqGIx
 wwSnb+QKBbAwV3Wrlkiw/YPdtrq22wQrADICsdsl3Y9f/2lD6I4a7muDSrXb3bqj9X3l
 VAg6hujw4GwgINjS0jMDe5Z7qeD1H1dpR/Zx7ewQoZ2hDx7XyLXV0UJ6hJsGpWFLyg0p
 0h+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RWaFdHsNmoZiIGD3MhG3D1b0aLfu9vsKuqSW1LCpePY=;
 b=acOIRrSbtywcRa1Bfo6IqcvmZwLi+tgHE2zyuAnEnIe7ehP2woCTEjBzczGIX5+Obx
 iDX550vddcWZJ1XxGVZdEOhb0U042Jv7lcMeSqsK9Nle0fBnXdz/OnGHKCPIaUA3/ntF
 QoXMncgHV7c/SBC7cOIVh8LmGwb77YIc4FE5aZ7beq8W1SuBo9/FOwfdaRj3epQyRsOh
 IlLFOLuub3zKrS/0quyrkzlNZeR1kcDXZgzxKGcIsY7w6w0dY+VepwjQ0/KKq9ZCTOGI
 Sn3HpMbxDLOuB3ALX3XZEcf/7BpBQHzk3tsRXp2NGyOKezL+hSOVmMlbgTL8tmlvYmRS
 xH6w==
X-Gm-Message-State: AOAM530GCh+DY1o7du3sDYL2loAh5td2G3IW+xSav1QLhUhNB7JTnB1R
 s9kH5xRNbwCltf7xnsoWuOcGMjk0FvMPVQ==
X-Google-Smtp-Source: ABdhPJwDgxhxjzVJbVlFRA1HVDQ6TtIQ/y/hzTUtkpVFklzn9jtiUWX+VHijefPr6zOVAwILkGckZQ==
X-Received: by 2002:adf:c6c5:: with SMTP id c5mr2075325wrh.13.1592301434016;
 Tue, 16 Jun 2020 02:57:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/23] target/arm: Convert Neon 3-reg-diff polynomial VMULL
Date: Tue, 16 Jun 2020 10:56:46 +0100
Message-Id: <20200616095702.25848-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Convert the Neon 3-reg-diff insn polynomial VMULL. This is the last
insn in this group to be converted.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |  2 ++
 target/arm/translate-neon.inc.c | 43 +++++++++++++++++++++++
 target/arm/translate.c          | 60 ++-------------------------------
 3 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 65ea30d3edf..ed49726abf5 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -465,5 +465,7 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VMULL_U_3d   1111 001 1 1 . .. .... .... 1100 . 0 . 0 .... @3diff
 
     VQDMULL_3d   1111 001 0 1 . .. .... .... 1101 . 0 . 0 .... @3diff
+
+    VMULL_P_3d   1111 001 0 1 . .. .... .... 1110 . 0 . 0 .... @3diff
   ]
 }
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 083e3af8c56..c2cc10913f8 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2304,3 +2304,46 @@ static bool trans_VQDMLSL_3d(DisasContext *s, arg_3diff *a)
 
     return do_long_3d(s, a, opfn[a->size], accfn[a->size]);
 }
+
+static bool trans_VMULL_P_3d(DisasContext *s, arg_3diff *a)
+{
+    gen_helper_gvec_3 *fn_gvec;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (a->vd & 1) {
+        return false;
+    }
+
+    switch (a->size) {
+    case 0:
+        fn_gvec = gen_helper_neon_pmull_h;
+        break;
+    case 2:
+        if (!dc_isar_feature(aa32_pmull, s)) {
+            return false;
+        }
+        fn_gvec = gen_helper_gvec_pmull_q;
+        break;
+    default:
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tcg_gen_gvec_3_ool(neon_reg_offset(a->vd, 0),
+                       neon_reg_offset(a->vn, 0),
+                       neon_reg_offset(a->vm, 0),
+                       16, 16, 0, fn_gvec);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 88e91845c02..f459fad8646 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5181,7 +5181,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
 {
     int op;
     int q;
-    int rd, rn, rm, rd_ofs, rn_ofs, rm_ofs;
+    int rd, rn, rm, rd_ofs, rm_ofs;
     int size;
     int pass;
     int u;
@@ -5215,7 +5215,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     size = (insn >> 20) & 3;
     vec_size = q ? 16 : 8;
     rd_ofs = neon_reg_offset(rd, 0);
-    rn_ofs = neon_reg_offset(rn, 0);
     rm_ofs = neon_reg_offset(rm, 0);
 
     if ((insn & (1 << 23)) == 0) {
@@ -5228,61 +5227,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         if (size != 3) {
             op = (insn >> 8) & 0xf;
             if ((insn & (1 << 6)) == 0) {
-                /* Three registers of different lengths.  */
-                /* undefreq: bit 0 : UNDEF if size == 0
-                 *           bit 1 : UNDEF if size == 1
-                 *           bit 2 : UNDEF if size == 2
-                 *           bit 3 : UNDEF if U == 1
-                 * Note that [2:0] set implies 'always UNDEF'
-                 */
-                int undefreq;
-                /* prewiden, src1_wide, src2_wide, undefreq */
-                static const int neon_3reg_wide[16][4] = {
-                    {0, 0, 0, 7}, /* VADDL: handled by decodetree */
-                    {0, 0, 0, 7}, /* VADDW: handled by decodetree */
-                    {0, 0, 0, 7}, /* VSUBL: handled by decodetree */
-                    {0, 0, 0, 7}, /* VSUBW: handled by decodetree */
-                    {0, 0, 0, 7}, /* VADDHN: handled by decodetree */
-                    {0, 0, 0, 7}, /* VABAL */
-                    {0, 0, 0, 7}, /* VSUBHN: handled by decodetree */
-                    {0, 0, 0, 7}, /* VABDL */
-                    {0, 0, 0, 7}, /* VMLAL */
-                    {0, 0, 0, 7}, /* VQDMLAL */
-                    {0, 0, 0, 7}, /* VMLSL */
-                    {0, 0, 0, 7}, /* VQDMLSL */
-                    {0, 0, 0, 7}, /* Integer VMULL */
-                    {0, 0, 0, 7}, /* VQDMULL */
-                    {0, 0, 0, 0xa}, /* Polynomial VMULL */
-                    {0, 0, 0, 7}, /* Reserved: always UNDEF */
-                };
-
-                undefreq = neon_3reg_wide[op][3];
-
-                if ((undefreq & (1 << size)) ||
-                    ((undefreq & 8) && u)) {
-                    return 1;
-                }
-                if (rd & 1) {
-                    return 1;
-                }
-
-                /* Handle polynomial VMULL in a single pass.  */
-                if (op == 14) {
-                    if (size == 0) {
-                        /* VMULL.P8 */
-                        tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, 16, 16,
-                                           0, gen_helper_neon_pmull_h);
-                    } else {
-                        /* VMULL.P64 */
-                        if (!dc_isar_feature(aa32_pmull, s)) {
-                            return 1;
-                        }
-                        tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, 16, 16,
-                                           0, gen_helper_gvec_pmull_q);
-                    }
-                    return 0;
-                }
-                abort(); /* all others handled by decodetree */
+                /* Three registers of different lengths: handled by decodetree */
+                return 1;
             } else {
                 /* Two registers and a scalar. NB that for ops of this form
                  * the ARM ARM labels bit 24 as Q, but it is in our variable
-- 
2.20.1


