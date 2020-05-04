Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D057C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A9C20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ih4wqJWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A9C20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVabG-0003fQ-4n
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI5-0000pQ-6W
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:45 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:34051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI4-0001B6-An
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:44 -0400
Received: by mail-wr1-x430.google.com with SMTP id y3so1667494wrt.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=goNw3Ssg8wfTd+slGYHgDUUUDcHds7bx8PNTd/noDQ8=;
 b=ih4wqJWxkkfmMIVK+E1FntHWr8AfDtz/CPBpaqgmCHYcgOViVth8Yq8Nb4g88EsMkB
 2yIGxSNOI0ciQM5tu6HP/lvs0K0+tvMsNzCWWRjI4bb6R7VZVpg/vVDTEZxqQVBSZJZF
 X7mAwbPu9Yz1FlKosbv3oDUI/qzvnVgr3gu18yxVcg8bMj0DwA1ltEikzKFPLD2d9WqX
 nPJXfjPLjTUvjsp7OfYTBOxuWaqUW4IyiW8QU5RMjTcyTWraR0fnwZp1pZqxWSoqo9pB
 P1j/uuHGwM/jDKYPOapWNLgR/VHtSIYDLJSw4ZJVrJNXzo8xkoCWf8HD1h+4RzEMV+I+
 QAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=goNw3Ssg8wfTd+slGYHgDUUUDcHds7bx8PNTd/noDQ8=;
 b=PORQI2FU+xcmwtAfPOssGdO7hfNKxJSkZEJfRlwCV/JuIwday18dM43OOBzgiVbaN9
 kQc5rrHbxBSzagCRtatP3O5Un8XnavDYiBbcOnX5afaBhk4o6kfnthdrZVKqGP25P9aT
 08st096M1FhIoxE48GWLiy/Ytijj3SMqt10szSA1k+u03i3EleMB+5feuMSf9stOOGin
 REBUvMT7MriEfI1uoGmoYnoOKcz+k2vbLeqBmkRHDNDU7LSSI7kujYWftXnldAFZOhq+
 HSFhD7Omb4LvHrw5PvRelHE7v+FHNezdJQDfYNDj7F3LVKym5bpIaAL1zcJaQapLO/v3
 KTdg==
X-Gm-Message-State: AGi0PuYhsOqQnPlO54YPSWBOzgt8BOPRCgAe+aAufZkfhpRNkBmI0Eph
 aU+oR9CDxBXjtt/u46v449YgFTW8x3NkBw==
X-Google-Smtp-Source: APiQypImwJvOvv2eUyG1v8BEfYUV9UB4lsKqxAnQcKoQZqgpFBcQVCOdzQc+alrGCP5sy0oV2UT46A==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr18845057wrn.173.1588595622260; 
 Mon, 04 May 2020 05:33:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/39] target/arm: Convert V[US]DOT (scalar) to decodetree
Date: Mon,  4 May 2020 13:32:58 +0100
Message-Id: <20200504123309.3808-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Convert the V[US]DOT (scalar) insns in the 2reg-scalar-ext group
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-10-peter.maydell@linaro.org
---
 target/arm/neon-shared.decode   |  3 +++
 target/arm/translate-neon.inc.c | 35 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 13 +-----------
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index c11d755ed14..63a46c63c07 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -54,3 +54,6 @@ VCMLA_scalar   1111 1110 0 . rot:2 .... .... 1000 . q:1 index:1 0 vm:4 \
                vn=%vn_dp vd=%vd_dp size=0
 VCMLA_scalar   1111 1110 1 . rot:2 .... .... 1000 . q:1 . 0 .... \
                vm=%vm_dp vn=%vn_dp vd=%vd_dp size=1 index=0
+
+VDOT_scalar    1111 1110 0 . 10 .... .... 1101 . q:1 index:1 u:1 rm:4 \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 92eccbf8236..7cc6ccb0697 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -207,3 +207,38 @@ static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+static bool trans_VDOT_scalar(DisasContext *s, arg_VDOT_scalar *a)
+{
+    gen_helper_gvec_3 *fn_gvec;
+    int opr_sz;
+    TCGv_ptr fpst;
+
+    if (!dc_isar_feature(aa32_dp, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn) & 0x10)) {
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
+    fn_gvec = a->u ? gen_helper_gvec_udot_idx_b : gen_helper_gvec_sdot_idx_b;
+    opr_sz = (1 + a->q) * 8;
+    fpst = get_fpstatus_ptr(1);
+    tcg_gen_gvec_3_ool(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(1, a->vn),
+                       vfp_reg_offset(1, a->rm),
+                       opr_sz, opr_sz, a->index, fn_gvec);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4cb8c6d55b1..8574d0964f7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7049,18 +7049,7 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
     bool is_long = false, q = extract32(insn, 6, 1);
     bool ptr_is_env = false;
 
-    if ((insn & 0xffb00f00) == 0xfe200d00) {
-        /* V[US]DOT -- 1111 1110 0.10 .... .... 1101 .Q.U .... */
-        int u = extract32(insn, 4, 1);
-
-        if (!dc_isar_feature(aa32_dp, s)) {
-            return 1;
-        }
-        fn_gvec = u ? gen_helper_gvec_udot_idx_b : gen_helper_gvec_sdot_idx_b;
-        /* rm is just Vm, and index is M.  */
-        data = extract32(insn, 5, 1); /* index */
-        rm = extract32(insn, 0, 4);
-    } else if ((insn & 0xffa00f10) == 0xfe000810) {
+    if ((insn & 0xffa00f10) == 0xfe000810) {
         /* VFM[AS]L -- 1111 1110 0.0S .... .... 1000 .Q.1 .... */
         int is_s = extract32(insn, 20, 1);
         int vm20 = extract32(insn, 0, 3);
-- 
2.20.1


