Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E826EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34BF206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d11Z01Sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34BF206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaZs-0000fz-Gg
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI8-0000zD-Qz
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:39702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI7-0001Hi-Pd
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id y24so8846302wma.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KUeLOJcnXNXY/bA4/CLGp725F/U7BSs+iFJgq6rC70c=;
 b=d11Z01SkQs1kMYJeCtYpQoVQvhmRgQjoaTOJtEW34ZWe/6+9hlL/XAH0UTYkIImCll
 GyjB0asuiWxcLAPN98XKTCMMvlXZ4Xr4zCj4zeidlu5FCfbc2wrjwPOKWO0ybvCF8ku3
 q4vYBSPSLsGMcPdMGeB1g7H/n9uU/RfQKfMF2uvsac0sdm0LupWcOWXRCJKbneEZNEVe
 O1x+vfIvezg9ZtxMulmpQT5LU7Vu/y/O9e+IpQrEa3CisHAls3aXTXf04g1uhdoCL5w5
 jPAK2Ix7H9Qre9ctXv1VxkA24oZpRUBmaUSjonmDjIMr7iONrjXbNZjh5rT40/cIcq0B
 NPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KUeLOJcnXNXY/bA4/CLGp725F/U7BSs+iFJgq6rC70c=;
 b=gz4AfdSXcKk1f34q2HkrtqMqWfi9NmrZcLWkcBDOQW5DBtakrZ97mlVs7gTfmYeKxH
 KV8CUlrRrVD2Ol9r8ZatZkPfkcQIoHZvW7gl5qgbhTtq7v02uEisH6fk5EZ4rFQhNCFW
 8sQwrRVmeA14deBSeen4z05fy42NLm76MX1hfJDQLbyK1hllSlZSLdZJMuQZavDaY0Mg
 H0DbL1xFNnYJ8ODtBsyXDCi4XiLuO1rkZVgWJHgzeCIe6A+Oy0bDuc+zbtbsDcub9NHa
 Il5m8TyqpqQu85eUc7x0pWZh7q5rheok17HKy/r4/Hd1MqzaqFyo/adl1+iVizyJs7UQ
 Lq7A==
X-Gm-Message-State: AGi0PuZHeyR/tUtCmieW8BzJrR8mlV6Xf8TdeuTy6r+rNfkBuOlemxX3
 xD1Jce71Ggq8USO4gA03IAwIDcWVOXysfA==
X-Google-Smtp-Source: APiQypJr232M6+RjM65YhvZ+aTZcnWr94qKFzX2Wat6OhIg6q7d5Q3dNgu8uRvSS3mLk1A9qU9kspA==
X-Received: by 2002:a1c:dfc2:: with SMTP id w185mr13830870wmg.1.1588595626008; 
 Mon, 04 May 2020 05:33:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/39] target/arm: Convert Neon 'load single structure to all
 lanes' to decodetree
Date: Mon,  4 May 2020 13:33:01 +0100
Message-Id: <20200504123309.3808-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Convert the Neon "load single structure to all lanes" insns to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-13-peter.maydell@linaro.org
---
 target/arm/neon-ls.decode       |  5 +++
 target/arm/translate-neon.inc.c | 73 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 55 +------------------------
 3 files changed, 80 insertions(+), 53 deletions(-)

diff --git a/target/arm/neon-ls.decode b/target/arm/neon-ls.decode
index dd03d5a37bd..f0ab6d2c987 100644
--- a/target/arm/neon-ls.decode
+++ b/target/arm/neon-ls.decode
@@ -34,3 +34,8 @@
 
 VLDST_multiple 1111 0100 0 . l:1 0 rn:4 .... itype:4 size:2 align:2 rm:4 \
                vd=%vd_dp
+
+# Neon load single element to all lanes
+
+VLD_all_lanes  1111 0100 1 . 1 0 rn:4 .... 11 n:2 size:2 t:1 a:1 rm:4 \
+               vd=%vd_dp
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 966c0d92012..e60e9559bad 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -398,3 +398,76 @@ static bool trans_VLDST_multiple(DisasContext *s, arg_VLDST_multiple *a)
     gen_neon_ldst_base_update(s, a->rm, a->rn, nregs * interleave * 8);
     return true;
 }
+
+static bool trans_VLD_all_lanes(DisasContext *s, arg_VLD_all_lanes *a)
+{
+    /* Neon load single structure to all lanes */
+    int reg, stride, vec_size;
+    int vd = a->vd;
+    int size = a->size;
+    int nregs = a->n + 1;
+    TCGv_i32 addr, tmp;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+        return false;
+    }
+
+    if (size == 3) {
+        if (nregs != 4 || a->a == 0) {
+            return false;
+        }
+        /* For VLD4 size == 3 a == 1 means 32 bits at 16 byte alignment */
+        size = 2;
+    }
+    if (nregs == 1 && a->a == 1 && size == 0) {
+        return false;
+    }
+    if (nregs == 3 && a->a == 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /*
+     * VLD1 to all lanes: T bit indicates how many Dregs to write.
+     * VLD2/3/4 to all lanes: T bit indicates register stride.
+     */
+    stride = a->t ? 2 : 1;
+    vec_size = nregs == 1 ? stride * 8 : 8;
+
+    tmp = tcg_temp_new_i32();
+    addr = tcg_temp_new_i32();
+    load_reg_var(s, addr, a->rn);
+    for (reg = 0; reg < nregs; reg++) {
+        gen_aa32_ld_i32(s, tmp, addr, get_mem_index(s),
+                        s->be_data | size);
+        if ((vd & 1) && vec_size == 16) {
+            /*
+             * We cannot write 16 bytes at once because the
+             * destination is unaligned.
+             */
+            tcg_gen_gvec_dup_i32(size, neon_reg_offset(vd, 0),
+                                 8, 8, tmp);
+            tcg_gen_gvec_mov(0, neon_reg_offset(vd + 1, 0),
+                             neon_reg_offset(vd, 0), 8, 8);
+        } else {
+            tcg_gen_gvec_dup_i32(size, neon_reg_offset(vd, 0),
+                                 vec_size, vec_size, tmp);
+        }
+        tcg_gen_addi_i32(addr, addr, 1 << size);
+        vd += stride;
+    }
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(addr);
+
+    gen_neon_ldst_base_update(s, a->rm, a->rn, (1 << size) * nregs);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index be56cbb0614..7099274c92a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3224,7 +3224,6 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
     int size;
     int reg;
     int load;
-    int vec_size;
     TCGv_i32 addr;
     TCGv_i32 tmp;
 
@@ -3254,58 +3253,8 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
     } else {
         size = (insn >> 10) & 3;
         if (size == 3) {
-            /* Load single element to all lanes.  */
-            int a = (insn >> 4) & 1;
-            if (!load) {
-                return 1;
-            }
-            size = (insn >> 6) & 3;
-            nregs = ((insn >> 8) & 3) + 1;
-
-            if (size == 3) {
-                if (nregs != 4 || a == 0) {
-                    return 1;
-                }
-                /* For VLD4 size==3 a == 1 means 32 bits at 16 byte alignment */
-                size = 2;
-            }
-            if (nregs == 1 && a == 1 && size == 0) {
-                return 1;
-            }
-            if (nregs == 3 && a == 1) {
-                return 1;
-            }
-            addr = tcg_temp_new_i32();
-            load_reg_var(s, addr, rn);
-
-            /* VLD1 to all lanes: bit 5 indicates how many Dregs to write.
-             * VLD2/3/4 to all lanes: bit 5 indicates register stride.
-             */
-            stride = (insn & (1 << 5)) ? 2 : 1;
-            vec_size = nregs == 1 ? stride * 8 : 8;
-
-            tmp = tcg_temp_new_i32();
-            for (reg = 0; reg < nregs; reg++) {
-                gen_aa32_ld_i32(s, tmp, addr, get_mem_index(s),
-                                s->be_data | size);
-                if ((rd & 1) && vec_size == 16) {
-                    /* We cannot write 16 bytes at once because the
-                     * destination is unaligned.
-                     */
-                    tcg_gen_gvec_dup_i32(size, neon_reg_offset(rd, 0),
-                                         8, 8, tmp);
-                    tcg_gen_gvec_mov(0, neon_reg_offset(rd + 1, 0),
-                                     neon_reg_offset(rd, 0), 8, 8);
-                } else {
-                    tcg_gen_gvec_dup_i32(size, neon_reg_offset(rd, 0),
-                                         vec_size, vec_size, tmp);
-                }
-                tcg_gen_addi_i32(addr, addr, 1 << size);
-                rd += stride;
-            }
-            tcg_temp_free_i32(tmp);
-            tcg_temp_free_i32(addr);
-            stride = (1 << size) * nregs;
+            /* Load single element to all lanes -- handled by decodetree  */
+            return 1;
         } else {
             /* Single element.  */
             int idx = (insn >> 4) & 0xf;
-- 
2.20.1


