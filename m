Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E05C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF685206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlvlT0O5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF685206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFkz-0003PJ-0d
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFYL-0002Mw-3X
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:45 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:45379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFYJ-0001o9-Lq
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:44 -0400
Received: by mail-wr1-x42d.google.com with SMTP id c3so10426169wru.12
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=NcydEn5x6urWExYuIY1mQiFymhq7MqBYT7aFwZfapag=;
 b=LlvlT0O5CwSmDPbfMF1w5M8JZneTf7hWfEEtzGwpaWMv+xlqAOZfwgMTPWaXc1q/6G
 pWYQ/Nhbm1f/UkfFx1nk1v6Rt01kYk+QtN/rtnEJZNQnD+amFJa2Qb7BiMifYAa2Rogb
 mfghqh1ckQTydk5/SMHTWsvy74lCUk7e+aJGO0cgKaDXv4OCm5q0Sdc7HHRyLaTS8Udx
 0Jlf4O6jjXdLWXmNrlgnQFDyx8/jO0go+gsYmDB3Kx2ktwfuKzLa9jhNj6ovRkXGiQN0
 JqVRMboHqfCyTtHlv1fTOL4cneiugKZpX0T5QzcRQKvebCtnylx5ki37S8o86b7Vhsee
 Jl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NcydEn5x6urWExYuIY1mQiFymhq7MqBYT7aFwZfapag=;
 b=B320uaDYSF34Bl4aiyIo5+Kh1UO2est0bwGTW5l+TF0VrjNTibaQi4cPrp/Y07Gz95
 MTRBlVR/FVrIsDk6If6E8VF9V0i5eMGc8VFUgWgw+AST966aqmZZgpZ80xmIfHVV+I2P
 l1yUVUT8uUIPtrbuewL+mzjbRVLY+2cGdvvbwoFwQ+VpL8vy/N55mnb3NBf6jco+yi6u
 TRP6TVI2SjDB9cxYBwcj1fgdPoNI1/abvJcLuefLE/hxzwXVbyrRfpaOOTMIdEB+xZv/
 axxbKtR7xU0B1c/iXvlJVl7BM3j7BvNCnxQkG3/WDVZMem6CO0NchnDReOl1iAjbtzan
 hvZw==
X-Gm-Message-State: AOAM532vJgVt0wL9XOdFNPMv7omD+F3ZzFXxrGnmCv33/V0PrNoBkJ3h
 yrWOWhWmnO3UkhZPD957a9HZiOZHPPaG9g==
X-Google-Smtp-Source: ABdhPJyX26xKqNb8mbLSPXZ6kAIr1ViK3HVH0iuk3rrLP4IYL7oNq1L1/y6quPB4+FdyygsebULZXQ==
X-Received: by 2002:a05:6000:18c:: with SMTP id
 p12mr11050397wrx.66.1591375841637; 
 Fri, 05 Jun 2020 09:50:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/29] target/arm: Convert Neon one-register-and-immediate
 insns to decodetree
Date: Fri,  5 Jun 2020 17:50:07 +0100
Message-Id: <20200605165007.12095-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Convert the insns in the one-register-and-immediate group to decodetree.

In the new decode, our asimd_imm_const() function returns a 64-bit value
rather than a 32-bit one, which means we don't need to treat cmode=14 op=1
as a special case in the decoder (it is the only encoding where the two
halves of the 64-bit value are different).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200522145520.6778-10-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  22 ++++++
 target/arm/translate-neon.inc.c | 118 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 101 +--------------------------
 3 files changed, 142 insertions(+), 99 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 47a5c90b5d8..bd1b0e13f7d 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -375,3 +375,25 @@ VCVT_SF_2sh      1111 001 0 1 . ...... .... 1110 0 . . 1 .... @2reg_vcvt
 VCVT_UF_2sh      1111 001 1 1 . ...... .... 1110 0 . . 1 .... @2reg_vcvt
 VCVT_FS_2sh      1111 001 0 1 . ...... .... 1111 0 . . 1 .... @2reg_vcvt
 VCVT_FU_2sh      1111 001 1 1 . ...... .... 1111 0 . . 1 .... @2reg_vcvt
+
+######################################################################
+# 1-reg-and-modified-immediate grouping:
+# 1111 001 i 1 D 000 imm:3 Vd:4 cmode:4 0 Q op 1 Vm:4
+######################################################################
+
+&1reg_imm        vd q imm cmode op
+
+%asimd_imm_value 24:1 16:3 0:4
+
+@1reg_imm        .... ... . . . ... ... .... .... . q:1 . . .... \
+                 &1reg_imm imm=%asimd_imm_value vd=%vd_dp
+
+# The cmode/op bits here decode VORR/VBIC/VMOV/VMNV, but
+# not in a way we can conveniently represent in decodetree without
+# a lot of repetition:
+# VORR: op=0, (cmode & 1) && cmode < 12
+# VBIC: op=1, (cmode & 1) && cmode < 12
+# VMOV: everything else
+# So we have a single decode line and check the cmode/op in the
+# trans function.
+Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 2a445c7589c..664d3612607 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1708,3 +1708,121 @@ DO_FP_2SH(VCVT_SF, gen_helper_vfp_sltos)
 DO_FP_2SH(VCVT_UF, gen_helper_vfp_ultos)
 DO_FP_2SH(VCVT_FS, gen_helper_vfp_tosls_round_to_zero)
 DO_FP_2SH(VCVT_FU, gen_helper_vfp_touls_round_to_zero)
+
+static uint64_t asimd_imm_const(uint32_t imm, int cmode, int op)
+{
+    /*
+     * Expand the encoded constant.
+     * Note that cmode = 2,3,4,5,6,7,10,11,12,13 imm=0 is UNPREDICTABLE.
+     * We choose to not special-case this and will behave as if a
+     * valid constant encoding of 0 had been given.
+     * cmode = 15 op = 1 must UNDEF; we assume decode has handled that.
+     */
+    switch (cmode) {
+    case 0: case 1:
+        /* no-op */
+        break;
+    case 2: case 3:
+        imm <<= 8;
+        break;
+    case 4: case 5:
+        imm <<= 16;
+        break;
+    case 6: case 7:
+        imm <<= 24;
+        break;
+    case 8: case 9:
+        imm |= imm << 16;
+        break;
+    case 10: case 11:
+        imm = (imm << 8) | (imm << 24);
+        break;
+    case 12:
+        imm = (imm << 8) | 0xff;
+        break;
+    case 13:
+        imm = (imm << 16) | 0xffff;
+        break;
+    case 14:
+        if (op) {
+            /*
+             * This is the only case where the top and bottom 32 bits
+             * of the encoded constant differ.
+             */
+            uint64_t imm64 = 0;
+            int n;
+
+            for (n = 0; n < 8; n++) {
+                if (imm & (1 << n)) {
+                    imm64 |= (0xffULL << (n * 8));
+                }
+            }
+            return imm64;
+        }
+        imm |= (imm << 8) | (imm << 16) | (imm << 24);
+        break;
+    case 15:
+        imm = ((imm & 0x80) << 24) | ((imm & 0x3f) << 19)
+            | ((imm & 0x40) ? (0x1f << 25) : (1 << 30));
+        break;
+    }
+    if (op) {
+        imm = ~imm;
+    }
+    return dup_const(MO_32, imm);
+}
+
+static bool do_1reg_imm(DisasContext *s, arg_1reg_imm *a,
+                        GVecGen2iFn *fn)
+{
+    uint64_t imm;
+    int reg_ofs, vec_size;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+        return false;
+    }
+
+    if (a->vd & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    reg_ofs = neon_reg_offset(a->vd, 0);
+    vec_size = a->q ? 16 : 8;
+    imm = asimd_imm_const(a->imm, a->cmode, a->op);
+
+    fn(MO_64, reg_ofs, reg_ofs, imm, vec_size, vec_size);
+    return true;
+}
+
+static void gen_VMOV_1r(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        int64_t c, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, c);
+}
+
+static bool trans_Vimm_1r(DisasContext *s, arg_1reg_imm *a)
+{
+    /* Handle decode of cmode/op here between VORR/VBIC/VMOV */
+    GVecGen2iFn *fn;
+
+    if ((a->cmode & 1) && a->cmode < 12) {
+        /* for op=1, the imm will be inverted, so BIC becomes AND. */
+        fn = a->op ? tcg_gen_gvec_andi : tcg_gen_gvec_ori;
+    } else {
+        /* There is one unallocated cmode/op combination in this space */
+        if (a->cmode == 15 && a->op == 1) {
+            return false;
+        }
+        fn = gen_VMOV_1r;
+    }
+    return do_1reg_imm(s, a, fn);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 166349ee203..bcdfec34d28 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5232,105 +5232,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         /* Three register same length: handled by decodetree */
         return 1;
     } else if (insn & (1 << 4)) {
-        if ((insn & 0x00380080) != 0) {
-            /* Two registers and shift: handled by decodetree */
-            return 1;
-        } else { /* (insn & 0x00380080) == 0 */
-            int invert, reg_ofs, vec_size;
-
-            if (q && (rd & 1)) {
-                return 1;
-            }
-
-            op = (insn >> 8) & 0xf;
-            /* One register and immediate.  */
-            imm = (u << 7) | ((insn >> 12) & 0x70) | (insn & 0xf);
-            invert = (insn & (1 << 5)) != 0;
-            /* Note that op = 2,3,4,5,6,7,10,11,12,13 imm=0 is UNPREDICTABLE.
-             * We choose to not special-case this and will behave as if a
-             * valid constant encoding of 0 had been given.
-             */
-            switch (op) {
-            case 0: case 1:
-                /* no-op */
-                break;
-            case 2: case 3:
-                imm <<= 8;
-                break;
-            case 4: case 5:
-                imm <<= 16;
-                break;
-            case 6: case 7:
-                imm <<= 24;
-                break;
-            case 8: case 9:
-                imm |= imm << 16;
-                break;
-            case 10: case 11:
-                imm = (imm << 8) | (imm << 24);
-                break;
-            case 12:
-                imm = (imm << 8) | 0xff;
-                break;
-            case 13:
-                imm = (imm << 16) | 0xffff;
-                break;
-            case 14:
-                imm |= (imm << 8) | (imm << 16) | (imm << 24);
-                if (invert) {
-                    imm = ~imm;
-                }
-                break;
-            case 15:
-                if (invert) {
-                    return 1;
-                }
-                imm = ((imm & 0x80) << 24) | ((imm & 0x3f) << 19)
-                      | ((imm & 0x40) ? (0x1f << 25) : (1 << 30));
-                break;
-            }
-            if (invert) {
-                imm = ~imm;
-            }
-
-            reg_ofs = neon_reg_offset(rd, 0);
-            vec_size = q ? 16 : 8;
-
-            if (op & 1 && op < 12) {
-                if (invert) {
-                    /* The immediate value has already been inverted,
-                     * so BIC becomes AND.
-                     */
-                    tcg_gen_gvec_andi(MO_32, reg_ofs, reg_ofs, imm,
-                                      vec_size, vec_size);
-                } else {
-                    tcg_gen_gvec_ori(MO_32, reg_ofs, reg_ofs, imm,
-                                     vec_size, vec_size);
-                }
-            } else {
-                /* VMOV, VMVN.  */
-                if (op == 14 && invert) {
-                    TCGv_i64 t64 = tcg_temp_new_i64();
-
-                    for (pass = 0; pass <= q; ++pass) {
-                        uint64_t val = 0;
-                        int n;
-
-                        for (n = 0; n < 8; n++) {
-                            if (imm & (1 << (n + pass * 8))) {
-                                val |= 0xffull << (n * 8);
-                            }
-                        }
-                        tcg_gen_movi_i64(t64, val);
-                        neon_store_reg64(t64, rd + pass);
-                    }
-                    tcg_temp_free_i64(t64);
-                } else {
-                    tcg_gen_gvec_dup_imm(MO_32, reg_ofs, vec_size,
-                                         vec_size, imm);
-                }
-            }
-        }
+        /* Two registers and shift or reg and imm: handled by decodetree */
+        return 1;
     } else { /* (insn & 0x00800010 == 0x00800000) */
         if (size != 3) {
             op = (insn >> 8) & 0xf;
-- 
2.20.1


