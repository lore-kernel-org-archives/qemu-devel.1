Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AA6C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D5520661
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JNOYpCwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D5520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaW1-0001w9-6n
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI4-0000m9-0I
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:44 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI2-00018y-VT
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:43 -0400
Received: by mail-wr1-x436.google.com with SMTP id x18so20725587wrq.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=chF/NVoyCGuJ1keytiSJkl3G1F0aAh65Nt8FVkaImg4=;
 b=JNOYpCwg7vhNZn24W+j1iwVuJCp1ut7u+c01L2zSiFvdKpaxnFbdTSmcwWbWADiuaT
 d4JHQb/twodk0CdeJUCmeIkmrym08IKdxpwQQwG5MrVHIN0wpVj8S+Te6RvxqOt1DkVC
 MYr5Wh02P1+MoD7c89TrA9VwRHyPY7HJzCZ+zxQVLAeKVEH7BC6JnDngCtlU/TAOdDdH
 Nm0IUy7QyOOvR0vSPTikyKCFmfe+Kw5pob/46gpH1+/rqE9dTqro3fpKZ1NrDPRJkZm2
 LdQAoI6EgL1CeMEcUN3HljLXQnOfL1b3qXI2/HXcIw2x3y8gmE72FyZEsw7G2AY2ROFw
 /7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=chF/NVoyCGuJ1keytiSJkl3G1F0aAh65Nt8FVkaImg4=;
 b=IdvypInQ6TEvk14hehfdelh80z8VYZiYTxeTKowbdoHs3lYkVlt82SDCUoKivLelxc
 huaoao3/mhopnLaaMLSdX4PXI+9okKSzKEh8ZWN1ugam5UhjJ04qimv7EgfErvJZX/B2
 jtR5vOMRy1Ua4tIexUL97yj8YChsiWDYH0qevMRQ9Ge0olGdE5DgWFyFnpN3n13VYRXQ
 VTDzVnRbt5Px8oC5pv0fEE/FN0wyAtGel+vmZfCvBYU8804oojFhxGm/x9zS00E5ePKq
 s4Tlq6+VAcqhiBESpI1T2pHMgzSyeN5IfiWaLtxBHX6ISjkwy1v+lJgI3YmxL1+zOLxP
 Guqg==
X-Gm-Message-State: AGi0PuabSgdQEAiCJUw4VAkyYBCFqgcwp2NLXwMzKChWrw6AyIy2nn4n
 0d8C2pwgV4FnVshOx51RhFHq4Ez19LhA+w==
X-Google-Smtp-Source: APiQypLteh6lNMd/gCG+BE9uX8PwswuNEp9+Jhp5h37aMdpuxwl/pJO3RXHZGyBDCKqMJnqqxOcFrw==
X-Received: by 2002:adf:a2d7:: with SMTP id t23mr4718716wra.402.1588595621138; 
 Mon, 04 May 2020 05:33:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/39] target/arm: Convert VCMLA (scalar) to decodetree
Date: Mon,  4 May 2020 13:32:57 +0100
Message-Id: <20200504123309.3808-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert VCMLA (scalar) in the 2reg-scalar-ext group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-9-peter.maydell@linaro.org
---
 target/arm/neon-shared.decode   |  5 +++++
 target/arm/translate-neon.inc.c | 40 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 26 +--------------------
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index 90cd5c871e2..c11d755ed14 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -49,3 +49,8 @@ VFML           1111 110 0 s:1 . 10 .... .... 1000 . 0 . 1 .... \
                vm=%vm_sp vn=%vn_sp vd=%vd_dp q=0
 VFML           1111 110 0 s:1 . 10 .... .... 1000 . 1 . 1 .... \
                vm=%vm_dp vn=%vn_dp vd=%vd_dp q=1
+
+VCMLA_scalar   1111 1110 0 . rot:2 .... .... 1000 . q:1 index:1 0 vm:4 \
+               vn=%vn_dp vd=%vd_dp size=0
+VCMLA_scalar   1111 1110 1 . rot:2 .... .... 1000 . q:1 . 0 .... \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp size=1 index=0
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 6c58abc54b5..92eccbf8236 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -167,3 +167,43 @@ static bool trans_VFML(DisasContext *s, arg_VFML *a)
                        gen_helper_gvec_fmlal_a32);
     return true;
 }
+
+static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
+{
+    gen_helper_gvec_3_ptr *fn_gvec_ptr;
+    int opr_sz;
+    TCGv_ptr fpst;
+
+    if (!dc_isar_feature(aa32_vcma, s)) {
+        return false;
+    }
+    if (a->size == 0 && !dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vd | a->vn) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fn_gvec_ptr = (a->size ? gen_helper_gvec_fcmlas_idx
+                   : gen_helper_gvec_fcmlah_idx);
+    opr_sz = (1 + a->q) * 8;
+    fpst = get_fpstatus_ptr(1);
+    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(1, a->vn),
+                       vfp_reg_offset(1, a->vm),
+                       fpst, opr_sz, opr_sz,
+                       (a->index << 2) | a->rot, fn_gvec_ptr);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 79cd9138fe7..4cb8c6d55b1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7049,31 +7049,7 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
     bool is_long = false, q = extract32(insn, 6, 1);
     bool ptr_is_env = false;
 
-    if ((insn & 0xff000f10) == 0xfe000800) {
-        /* VCMLA (indexed) -- 1111 1110 S.RR .... .... 1000 ...0 .... */
-        int rot = extract32(insn, 20, 2);
-        int size = extract32(insn, 23, 1);
-        int index;
-
-        if (!dc_isar_feature(aa32_vcma, s)) {
-            return 1;
-        }
-        if (size == 0) {
-            if (!dc_isar_feature(aa32_fp16_arith, s)) {
-                return 1;
-            }
-            /* For fp16, rm is just Vm, and index is M.  */
-            rm = extract32(insn, 0, 4);
-            index = extract32(insn, 5, 1);
-        } else {
-            /* For fp32, rm is the usual M:Vm, and index is 0.  */
-            VFP_DREG_M(rm, insn);
-            index = 0;
-        }
-        data = (index << 2) | rot;
-        fn_gvec_ptr = (size ? gen_helper_gvec_fcmlas_idx
-                       : gen_helper_gvec_fcmlah_idx);
-    } else if ((insn & 0xffb00f00) == 0xfe200d00) {
+    if ((insn & 0xffb00f00) == 0xfe200d00) {
         /* V[US]DOT -- 1111 1110 0.10 .... .... 1101 .Q.U .... */
         int u = extract32(insn, 4, 1);
 
-- 
2.20.1


