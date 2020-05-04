Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220C4C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09CD206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+D8ZMKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09CD206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVabg-0004KA-3D
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaIB-00015k-9v
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:53661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaIA-0001ID-9a
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id k12so8191268wmj.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=z4KT7v0mrw5vLzSt/Xa9ojHSKKH+88BzrTrmmEv3EwY=;
 b=N+D8ZMKAQmDUNsbWRfN3ryIEGxeFWv6eD1dUK98wG1vyvSNQ6gjayeHV80qQrCnqfS
 gocV8rJGMIw68yKR1B0SeE6Xd3k8+zQuQ21f+ZwrpZSfw03Bn6gA11CuPfg7bP5LfgXI
 MURDtnvpbPwOwoLj2qS3Xy/CiUO/s0CycPU8vy+ti2PUTUFpKDlkQhkI4NrWSskihVub
 R6hzx2fP+7GC5mX3HiSeuL/ObD0amjWZLr/EXHf9AuyB/qjw39FNGQnepYq3eei8TBOU
 WI9p9yeswj8wE/PfOWWbaf5bn+0GRpOBheEoj5HnyRLBnTUvY8jP9XYLtYOi0rXacS2V
 DNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z4KT7v0mrw5vLzSt/Xa9ojHSKKH+88BzrTrmmEv3EwY=;
 b=BJxricWsMQtL1U5Od3LaNUuKmnavYyGI9FpXTefiPlHJLTw/3lB0e+zlon0CHI4nfM
 3Gr8iwQNxdh3xVGY8UkRuhQqMl1JQ2F6af5J+zcOFLAGivSY9cJY31aAU5vop0ZB1fB/
 s7oUcrg4dK2gB6X4uxyTapgdkw9FwA9/tyr5p2dprUsbT/i2NSJIyBno6xgUe07GaA8y
 yDZhlKLPeoYBCzz3M/xD5GD0+WcgzSRo77WU86bxa3MyGtcGJzHrGasaNvPYkPW3HG6Z
 sId1OPoR2V0Lsx5+37EiiLkn7NmNpYoJs3WaJ2qnMxhCbICqhmjwisN5LDVO/2BW2DpP
 I4lg==
X-Gm-Message-State: AGi0Pub8rmRZx6DEMSv7W3zH+HRPG7lB0JM+1d8zjFtz4BlZeV3ePSxe
 uBbA2apUOTtYpHZf8ThLPMqIu7I3pzSG7Q==
X-Google-Smtp-Source: APiQypJN99if2yFeSsrQYcEJNAEbi7nduEDXF7EyWrR9joaczbx4pcjVROs/e6KJkw4NUZGo+5UpfA==
X-Received: by 2002:a7b:c38b:: with SMTP id s11mr14366775wmj.55.1588595628431; 
 Mon, 04 May 2020 05:33:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/39] target/arm: Convert Neon 3-reg-same VADD/VSUB to
 decodetree
Date: Mon,  4 May 2020 13:33:03 +0100
Message-Id: <20200504123309.3808-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Convert the Neon 3-reg-same VADD and VSUB insns to decodetree.

Note that we don't need the neon_3r_sizes[op] check here because all
size values are OK for VADD and VSUB; we'll add this when we convert
the first insn that has size restrictions.

For this we need one of the GVecGen*Fn typedefs currently in
translate-a64.h; move them all to translate.h as a block so they
are visible to the 32-bit decoder.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-15-peter.maydell@linaro.org
---
 target/arm/translate-a64.h      |  9 --------
 target/arm/translate.h          |  9 ++++++++
 target/arm/neon-dp.decode       | 17 +++++++++++++++
 target/arm/translate-neon.inc.c | 38 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 14 ++++--------
 5 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 4c2c91ae1b2..f02fbb63a4a 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -115,13 +115,4 @@ static inline int vec_full_reg_size(DisasContext *s)
 
 bool disas_sve(DisasContext *, uint32_t);
 
-/* Note that the gvec expanders operate on offsets + sizes.  */
-typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
-typedef void GVecGen2iFn(unsigned, uint32_t, uint32_t, int64_t,
-                         uint32_t, uint32_t);
-typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
-                        uint32_t, uint32_t, uint32_t);
-typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
-                        uint32_t, uint32_t, uint32_t);
-
 #endif /* TARGET_ARM_TRANSLATE_A64_H */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 98b319f3f69..95b43e7ab65 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -305,4 +305,13 @@ void gen_sshl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 #define dc_isar_feature(name, ctx) \
     ({ DisasContext *ctx_ = (ctx); isar_feature_##name(ctx_->isar); })
 
+/* Note that the gvec expanders operate on offsets + sizes.  */
+typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
+typedef void GVecGen2iFn(unsigned, uint32_t, uint32_t, int64_t,
+                         uint32_t, uint32_t);
+typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
+                        uint32_t, uint32_t, uint32_t);
+typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
+                        uint32_t, uint32_t, uint32_t);
+
 #endif /* TARGET_ARM_TRANSLATE_H */
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index c89a1a58591..a61b1e88476 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -18,6 +18,10 @@
 #
 # This file is processed by scripts/decodetree.py
 #
+# VFP/Neon register fields; same as vfp.decode
+%vm_dp  5:1 0:4
+%vn_dp  7:1 16:4
+%vd_dp  22:1 12:4
 
 # Encodings for Neon data processing instructions where the T32 encoding
 # is a simple transformation of the A32 encoding.
@@ -27,3 +31,16 @@
 #   0b111p_1111_qqqq_qqqq_qqqq_qqqq_qqqq_qqqq
 # This file works on the A32 encoding only; calling code for T32 has to
 # transform the insn into the A32 version first.
+
+######################################################################
+# 3-reg-same grouping:
+# 1111 001 U 0 D sz:2 Vn:4 Vd:4 opc:4 N Q M op Vm:4
+######################################################################
+
+&3same vm vn vd q size
+
+@3same           .... ... . . . size:2 .... .... .... . q:1 . . .... \
+                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VADD_3s          1111 001 0 0 . .. .... .... 1000 . . . 0 .... @3same
+VSUB_3s          1111 001 1 0 . .. .... .... 1000 . . . 0 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index c881d1cf607..bd9e697b3e2 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -560,3 +560,41 @@ static bool trans_VLDST_single(DisasContext *s, arg_VLDST_single *a)
 
     return true;
 }
+
+static bool do_3same(DisasContext *s, arg_3same *a, GVecGen3Fn fn)
+{
+    int vec_size = a->q ? 16 : 8;
+    int rd_ofs = neon_reg_offset(a->vd, 0);
+    int rn_ofs = neon_reg_offset(a->vn, 0);
+    int rm_ofs = neon_reg_offset(a->vm, 0);
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
+    if ((a->vn | a->vm | a->vd) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fn(a->size, rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
+    return true;
+}
+
+#define DO_3SAME(INSN, FUNC)                                            \
+    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        return do_3same(s, a, FUNC);                                    \
+    }
+
+DO_3SAME(VADD, tcg_gen_gvec_add)
+DO_3SAME(VSUB, tcg_gen_gvec_sub)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 613be39ef36..061bc7c31c9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4885,16 +4885,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             return 0;
 
-        case NEON_3R_VADD_VSUB:
-            if (u) {
-                tcg_gen_gvec_sub(size, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-            } else {
-                tcg_gen_gvec_add(size, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-            }
-            return 0;
-
         case NEON_3R_VQADD:
             tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                            rn_ofs, rm_ofs, vec_size, vec_size,
@@ -4970,6 +4960,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs, vec_size, vec_size,
                            u ? &ushl_op[size] : &sshl_op[size]);
             return 0;
+
+        case NEON_3R_VADD_VSUB:
+            /* Already handled by decodetree */
+            return 1;
         }
 
         if (size == 3) {
-- 
2.20.1


