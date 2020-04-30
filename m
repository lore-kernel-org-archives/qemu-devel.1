Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95862C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E16C20836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zl76gNt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E16C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDnR-0007Il-Em
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeC-0001cY-SD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdg-00012x-VG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:56 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:37846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdg-0000xM-FT
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:24 -0400
Received: by mail-wr1-x432.google.com with SMTP id k1so8184296wrx.4
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eBspgQk++mtdWViFX+jGsC5B+/dbLN5PYD4I61Sc2EE=;
 b=zl76gNt2QiZpPrDaUCtRXW/Ki2/35vwiYTdmmXddmdEx1cJNaIv17Rr3ld+uE8Q+CS
 VT+m+wHFstbnea0wtce62sdTj5QQsff1LjIFjDuQX7VyjtnCM1d3uikOlBgGhEszhusD
 mtACQViSSwlHC/zRgFN7S3LbZ5wC0X8sfMVgpXu8vUPZTjl0i7LhSj7oZy0C0Emxrvel
 0nQLrBiibZoljhlWtHuey3f7ZAiYNd1AkrlKPyCEPeKdXI7TRlXYt6oCxZESuoSBNQWJ
 R+9j0zwcDI7gRHaHl29wIQVhATOsQpUpK4enxmKzf/SOOXL3+8rRs51X4KxGiqoE4L72
 CMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eBspgQk++mtdWViFX+jGsC5B+/dbLN5PYD4I61Sc2EE=;
 b=U8t94yrd0h89axAa9Sm8PLI/waVGq58jlZ5IG6Grkron+QHqYDHt8AKYKN4IOl+GuQ
 9ZKBOwnJMB3uR/XIhFsXKp42UmjvKwm+0A5zV5RXV/Zf10dH9Uc+1oD0fexmkFwe/F2q
 JkE+jlKKxp23dAekTT2jcFbhcoIGt7X009AC+7d7i60RMSEnh8ykQKM+R9LTjmd/8OuD
 vRgUdW7EOtUqc1ELAY1TDV47wnn7Sduy9Ytr2WVcQsm0DtETjTohjRpy+BFy8YMSRbcJ
 56OT4ILUlTKxeAMHf6177SpyiR23adInV/6r3QOOPEvKNKJskEwjGA7xyhmFBNt5dZMD
 jSwA==
X-Gm-Message-State: AGi0PuZbRug0w6ErOhZDkkaRNQQJCxOg3dY7VS4XzU1NGdh47m2TNHgi
 olYuqkcE9pGNcWQHUC2MIy1k8Q==
X-Google-Smtp-Source: APiQypLCdB+74nCYphjdF0aRoSJQNwUx/HUqutmwW6onY3+qp7gRPf49LSKQBo+KcrAiZ04jYS8WZQ==
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr5444300wrr.160.1588270222903; 
 Thu, 30 Apr 2020 11:10:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 13/36] target/arm: Convert Neon 'load/store single structure'
 to decodetree
Date: Thu, 30 Apr 2020 19:09:40 +0100
Message-Id: <20200430181003.21682-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::432
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

Convert the Neon "load/store single structure to one lane" insns to
decodetree.

As this is the last set of insns in the neon load/store group,
we can remove the whole disas_neon_ls_insn() function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c |  89 +++++++++++++++++++
 target/arm/translate.c          | 147 --------------------------------
 target/arm/neon-ls.decode       |  11 +++
 3 files changed, 100 insertions(+), 147 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index e60e9559bad..c881d1cf607 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -26,6 +26,11 @@
  * It might be possible to convert it to a standalone .c file eventually.
  */
 
+static inline int plus1(DisasContext *s, int x)
+{
+    return x + 1;
+}
+
 /* Include the generated Neon decoder */
 #include "decode-neon-dp.inc.c"
 #include "decode-neon-ls.inc.c"
@@ -471,3 +476,87 @@ static bool trans_VLD_all_lanes(DisasContext *s, arg_VLD_all_lanes *a)
 
     return true;
 }
+
+static bool trans_VLDST_single(DisasContext *s, arg_VLDST_single *a)
+{
+    /* Neon load/store single structure to one lane */
+    int reg;
+    int nregs = a->n + 1;
+    int vd = a->vd;
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
+    /* Catch the UNDEF cases. This is unavoidably a bit messy. */
+    switch (nregs) {
+    case 1:
+        if (((a->align & (1 << a->size)) != 0) ||
+            (a->size == 2 && ((a->align & 3) == 1 || (a->align & 3) == 2))) {
+            return false;
+        }
+        break;
+    case 3:
+        if ((a->align & 1) != 0) {
+            return false;
+        }
+        /* fall through */
+    case 2:
+        if (a->size == 2 && (a->align & 2) != 0) {
+            return false;
+        }
+        break;
+    case 4:
+        if ((a->size == 2) && ((a->align & 3) == 3)) {
+            return false;
+        }
+        break;
+    default:
+        abort();
+    }
+    if ((vd + a->stride * (nregs - 1)) > 31) {
+        /*
+         * Attempts to write off the end of the register file are
+         * UNPREDICTABLE; we choose to UNDEF because otherwise we would
+         * access off the end of the array that holds the register data.
+         */
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i32();
+    addr = tcg_temp_new_i32();
+    load_reg_var(s, addr, a->rn);
+    /*
+     * TODO: if we implemented alignment exceptions, we should check
+     * addr against the alignment encoded in a->align here.
+     */
+    for (reg = 0; reg < nregs; reg++) {
+        if (a->l) {
+            gen_aa32_ld_i32(s, tmp, addr, get_mem_index(s),
+                            s->be_data | a->size);
+            neon_store_element(vd, a->reg_idx, a->size, tmp);
+        } else { /* Store */
+            neon_load_element(tmp, vd, a->reg_idx, a->size);
+            gen_aa32_st_i32(s, tmp, addr, get_mem_index(s),
+                            s->be_data | a->size);
+        }
+        vd += a->stride;
+        tcg_gen_addi_i32(addr, addr, 1 << a->size);
+    }
+    tcg_temp_free_i32(addr);
+    tcg_temp_free_i32(tmp);
+
+    gen_neon_ldst_base_update(s, a->rm, a->rn, (1 << a->size) * nregs);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a9cad04ba91..8c059af0e7e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3213,140 +3213,6 @@ static void gen_neon_trn_u16(TCGv_i32 t0, TCGv_i32 t1)
     tcg_temp_free_i32(rd);
 }
 
-
-/* Translate a NEON load/store element instruction.  Return nonzero if the
-   instruction is invalid.  */
-static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
-{
-    int rd, rn, rm;
-    int nregs;
-    int stride;
-    int size;
-    int reg;
-    int load;
-    TCGv_i32 addr;
-    TCGv_i32 tmp;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return 1;
-    }
-
-    /* FIXME: this access check should not take precedence over UNDEF
-     * for invalid encodings; we will generate incorrect syndrome information
-     * for attempts to execute invalid vfp/neon encodings with FP disabled.
-     */
-    if (s->fp_excp_el) {
-        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
-                           syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
-        return 0;
-    }
-
-    if (!s->vfp_enabled)
-      return 1;
-    VFP_DREG_D(rd, insn);
-    rn = (insn >> 16) & 0xf;
-    rm = insn & 0xf;
-    load = (insn & (1 << 21)) != 0;
-    if ((insn & (1 << 23)) == 0) {
-        /* Load store all elements -- handled already by decodetree */
-        return 1;
-    } else {
-        size = (insn >> 10) & 3;
-        if (size == 3) {
-            /* Load single element to all lanes -- handled by decodetree  */
-            return 1;
-        } else {
-            /* Single element.  */
-            int idx = (insn >> 4) & 0xf;
-            int reg_idx;
-            switch (size) {
-            case 0:
-                reg_idx = (insn >> 5) & 7;
-                stride = 1;
-                break;
-            case 1:
-                reg_idx = (insn >> 6) & 3;
-                stride = (insn & (1 << 5)) ? 2 : 1;
-                break;
-            case 2:
-                reg_idx = (insn >> 7) & 1;
-                stride = (insn & (1 << 6)) ? 2 : 1;
-                break;
-            default:
-                abort();
-            }
-            nregs = ((insn >> 8) & 3) + 1;
-            /* Catch the UNDEF cases. This is unavoidably a bit messy. */
-            switch (nregs) {
-            case 1:
-                if (((idx & (1 << size)) != 0) ||
-                    (size == 2 && ((idx & 3) == 1 || (idx & 3) == 2))) {
-                    return 1;
-                }
-                break;
-            case 3:
-                if ((idx & 1) != 0) {
-                    return 1;
-                }
-                /* fall through */
-            case 2:
-                if (size == 2 && (idx & 2) != 0) {
-                    return 1;
-                }
-                break;
-            case 4:
-                if ((size == 2) && ((idx & 3) == 3)) {
-                    return 1;
-                }
-                break;
-            default:
-                abort();
-            }
-            if ((rd + stride * (nregs - 1)) > 31) {
-                /* Attempts to write off the end of the register file
-                 * are UNPREDICTABLE; we choose to UNDEF because otherwise
-                 * the neon_load_reg() would write off the end of the array.
-                 */
-                return 1;
-            }
-            tmp = tcg_temp_new_i32();
-            addr = tcg_temp_new_i32();
-            load_reg_var(s, addr, rn);
-            for (reg = 0; reg < nregs; reg++) {
-                if (load) {
-                    gen_aa32_ld_i32(s, tmp, addr, get_mem_index(s),
-                                    s->be_data | size);
-                    neon_store_element(rd, reg_idx, size, tmp);
-                } else { /* Store */
-                    neon_load_element(tmp, rd, reg_idx, size);
-                    gen_aa32_st_i32(s, tmp, addr, get_mem_index(s),
-                                    s->be_data | size);
-                }
-                rd += stride;
-                tcg_gen_addi_i32(addr, addr, 1 << size);
-            }
-            tcg_temp_free_i32(addr);
-            tcg_temp_free_i32(tmp);
-            stride = nregs * (1 << size);
-        }
-    }
-    if (rm != 15) {
-        TCGv_i32 base;
-
-        base = load_reg(s, rn);
-        if (rm == 13) {
-            tcg_gen_addi_i32(base, base, stride);
-        } else {
-            TCGv_i32 index;
-            index = load_reg(s, rm);
-            tcg_gen_add_i32(base, base, index);
-            tcg_temp_free_i32(index);
-        }
-        store_reg(s, rn, base);
-    }
-    return 0;
-}
-
 static inline void gen_neon_narrow(int size, TCGv_i32 dest, TCGv_i64 src)
 {
     switch (size) {
@@ -10596,13 +10462,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             }
             return;
         }
-        if ((insn & 0x0f100000) == 0x04000000) {
-            /* NEON load/store.  */
-            if (disas_neon_ls_insn(s, insn)) {
-                goto illegal_op;
-            }
-            return;
-        }
         if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
@@ -10807,12 +10666,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         }
         break;
     case 12:
-        if ((insn & 0x01100000) == 0x01000000) {
-            if (disas_neon_ls_insn(s, insn)) {
-                goto illegal_op;
-            }
-            break;
-        }
         goto illegal_op;
     default:
     illegal_op:
diff --git a/target/arm/neon-ls.decode b/target/arm/neon-ls.decode
index f0ab6d2c987..c7b03a72e8d 100644
--- a/target/arm/neon-ls.decode
+++ b/target/arm/neon-ls.decode
@@ -39,3 +39,14 @@ VLDST_multiple 1111 0100 0 . l:1 0 rn:4 .... itype:4 size:2 align:2 rm:4 \
 
 VLD_all_lanes  1111 0100 1 . 1 0 rn:4 .... 11 n:2 size:2 t:1 a:1 rm:4 \
                vd=%vd_dp
+
+# Neon load/store single structure to one lane
+%imm1_5_p1 5:1 !function=plus1
+%imm1_6_p1 6:1 !function=plus1
+
+VLDST_single   1111 0100 1 . l:1 0 rn:4 .... 00 n:2 reg_idx:3 align:1 rm:4 \
+               vd=%vd_dp size=0 stride=1
+VLDST_single   1111 0100 1 . l:1 0 rn:4 .... 01 n:2 reg_idx:2 align:2 rm:4 \
+               vd=%vd_dp size=1 stride=%imm1_5_p1
+VLDST_single   1111 0100 1 . l:1 0 rn:4 .... 10 n:2 reg_idx:1 align:3 rm:4 \
+               vd=%vd_dp size=2 stride=%imm1_6_p1
-- 
2.20.1


