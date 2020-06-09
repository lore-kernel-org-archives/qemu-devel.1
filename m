Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8C5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6221920760
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0Vi58wM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6221920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigs1-0007rV-J4
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jighl-0003QF-Bq
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:02:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jighk-0003S9-1M
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:02:24 -0400
Received: by mail-wm1-x344.google.com with SMTP id u13so3364317wml.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4BxyhI/HWfoITPOBcBEsWHge5VKsc4W1GIwr7qvVtEk=;
 b=U0Vi58wMh2szpgpW6gLa5+IUnXLA7WbmBmkIfMdN/VBGeAV7I3zL/mcRDOml4WrHcK
 cu+Vkhnl5cfNBxoqumm69X1mu6NDjCjykwUHfn1pxcRzvFPuws6x0zA82N4jfVyz+s0g
 34t8oaQ21r4hX+7Wzeo4+6DWdRBX/czj10rUz1TJHqt8del95InkmupaltA4ZrDD+wz8
 G4RWFo1+ypK48C3YEqegU16OFKkhanv3fAHg238x8MYwAS/XmMsxnRTpsi124D8i++ng
 zyANMIj5xCsxz+Wpa94S9TdWu1eshnLee7K/tLZleGvW2IZBs4xvH97JTpV1xzkGRzJ4
 lg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4BxyhI/HWfoITPOBcBEsWHge5VKsc4W1GIwr7qvVtEk=;
 b=CwZI7lueaQHm/6RbvfSNITBJYO8H6XA9uLxlRby7vkSy6J9zANtFuNH8hSZlaXmUJJ
 BqGnjuOL+m8nDkKzQx0nn5d0qrMepKzJ0mIRFw1qZBu+8qjCyyLRRVIKm5fCgp8bqL5y
 /bq+hYvUCMbTVVr97ysz1shpE/83+NFDaAOsOrUcwdP01pf5EF/4nlBKvrL+vVHh7gkR
 joU1IoHds+CokjC7MwTYMeNRI5WUScr8ASSYJvL0/NY0ccOayaLffvVid5RpKgOZ9chU
 zqQqdfh5lzMrebMIUjJlmqyVkra6/b3R9klVTSkUcI7pjXTU8sEogp+SPbJtSGfPZQoH
 qbCw==
X-Gm-Message-State: AOAM533WkuGx6boNkS0wIlEoOIlLQUu3c5hZs5TeDpG9jrMzjbVBzvyq
 rRr1marT82+agWTuA0PfgsQ/9A==
X-Google-Smtp-Source: ABdhPJzu3HAtqxJ852+lgKj7oRhV4kLkhR5kjc5BgpN6uJRxxgPyQx0SRDYtZ9ceLnMCWhoPTK38yw==
X-Received: by 2002:a1c:6583:: with SMTP id z125mr4838456wmb.102.1591718542281; 
 Tue, 09 Jun 2020 09:02:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b81sm3699867wmc.5.2020.06.09.09.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:02:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 7/7] target/arm: Convert Neon 3-reg-diff polynomial VMULL
Date: Tue,  9 Jun 2020 17:02:09 +0100
Message-Id: <20200609160209.29960-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609160209.29960-1-peter.maydell@linaro.org>
References: <20200609160209.29960-1-peter.maydell@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon 3-reg-diff insn polynomial VMULL. This is the last
insn in this group to be converted.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index 5965b5ed845..7dbbfaaac41 100644
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


