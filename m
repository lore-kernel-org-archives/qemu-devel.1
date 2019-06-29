Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCD4C5B57A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBC82054F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v39UDOqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBC82054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhDDr-0004c7-72
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41349)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCyE-0007zh-9n
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy9-0003dO-F7
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhCy8-0003Ve-Ms
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id u8so11457069wmm.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XPHGJnkUqknth5qUlLC6GFG5OlC/xqIM0plxsRWWXgI=;
 b=v39UDOqDHPMJoBMhRND60LchwGtqX/ybHq0l/VJgySMchX/r1zeP8B7q1+7ncF1O+N
 9dJpIP4dUSSk6xQlrd7KCnFzLXjQSkwvReXht/PvYHbrl/EXMcPcEheTEwYDCNP8HACT
 No5g+vsqayj57IxjyxPo1DJ2gZiM4QMwg8OAAcbshhpb495sZbrvJz/ReTIfLnY0Q/7h
 hn1Dufc5NPJnWZ/fdJq+GI7s+xuu03hfiMCb7TBqm0skMS5/cqQcyjxiPBsKVwcE5OBP
 NjZQrncHewQvhPQulz4vRtqZcplMIs2GtyGbU/sAnICpxenGlcmMtYP/vDz/s7VspOnf
 uVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XPHGJnkUqknth5qUlLC6GFG5OlC/xqIM0plxsRWWXgI=;
 b=NHvUURYxgYcelBcnN4XsS0nSiQPwrKEX1aMUduliMyxtzaTI1CMNGSoQw3Ij0AXtq5
 HotwDh6wNIif68Np9R4bydBBm8jA/Zv/uHCgTTjWjN7fZylmJsqcnHSsuFNEsQHhvCWJ
 waWetfqvlDHTDiIOFGppxv3pAqY+UU37cNwxXmR3XwwORhE6naJ49j+mlEGg0x+AvmvH
 D7V2aifRRX0D6OsqFApqk/VuBQvVtxVgmSbhmXmEvH5TGCzBT5eqht2uSGeqvriFMSPh
 nuAR5ARUXjK00DZD+rTqp/CzdDIMZx+IGDBuW5BUHiSPtJp0ORpAJsIelwm8QPrsUiHb
 PtvQ==
X-Gm-Message-State: APjAAAWe0pC26KV76HJgbY3HGCKvQQ8iMa1sICUJp0R2rJ8hHHtOu46E
 WTJCjJtIrw4tMDklZE2kfcLCM997GrOGjA==
X-Google-Smtp-Source: APXvYqx/revoGO9OLBvGfV5p/PHWwdrY6t4kweBGrZ3hSJGDIPT4WhliYfj22PFPLlWdYJzlAoMhOw==
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr11425472wmc.75.1561813234136; 
 Sat, 29 Jun 2019 06:00:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id d10sm4937676wro.18.2019.06.29.06.00.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 06:00:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 15:00:16 +0200
Message-Id: <20190629130017.2973-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629130017.2973-1-richard.henderson@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v6 15/16] tcg/ppc: Update vector support to
 v2.07
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes single-word loads and stores, lots of double-word
arithmetic, and a few extra logical operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |   3 +-
 tcg/ppc/tcg-target.inc.c | 128 ++++++++++++++++++++++++++++++---------
 2 files changed, 103 insertions(+), 28 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 40544f996d..b8355d0a56 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -61,6 +61,7 @@ typedef enum {
 extern bool have_isa_altivec;
 extern bool have_isa_2_06;
 extern bool have_isa_2_06_vsx;
+extern bool have_isa_2_07_vsx;
 extern bool have_isa_3_00;
 
 /* optional instructions automatically implemented */
@@ -147,7 +148,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_v256             0
 
 #define TCG_TARGET_HAS_andc_vec         1
-#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_orc_vec          have_isa_2_07_vsx
 #define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_abs_vec          0
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 50d1b5612c..af86ab07dd 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -67,6 +67,7 @@ static tcg_insn_unit *tb_ret_addr;
 bool have_isa_altivec;
 bool have_isa_2_06;
 bool have_isa_2_06_vsx;
+bool have_isa_2_07_vsx;
 bool have_isa_3_00;
 
 #define HAVE_ISA_2_06  have_isa_2_06
@@ -473,10 +474,12 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define LVEWX      XO31(71)
 #define LXSDX      XO31(588)      /* v2.06 */
 #define LXVDSX     XO31(332)      /* v2.06 */
+#define LXSIWZX    XO31(12)       /* v2.07 */
 
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
 #define STXSDX     XO31(716)      /* v2.06 */
+#define STXSIWX    XO31(140)      /* v2.07 */
 
 #define VADDSBS    VX4(768)
 #define VADDUBS    VX4(512)
@@ -487,6 +490,7 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VADDSWS    VX4(896)
 #define VADDUWS    VX4(640)
 #define VADDUWM    VX4(128)
+#define VADDUDM    VX4(192)       /* v2.07 */
 
 #define VSUBSBS    VX4(1792)
 #define VSUBUBS    VX4(1536)
@@ -497,47 +501,62 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VSUBSWS    VX4(1920)
 #define VSUBUWS    VX4(1664)
 #define VSUBUWM    VX4(1152)
+#define VSUBUDM    VX4(1216)      /* v2.07 */
 
 #define VMAXSB     VX4(258)
 #define VMAXSH     VX4(322)
 #define VMAXSW     VX4(386)
+#define VMAXSD     VX4(450)       /* v2.07 */
 #define VMAXUB     VX4(2)
 #define VMAXUH     VX4(66)
 #define VMAXUW     VX4(130)
+#define VMAXUD     VX4(194)       /* v2.07 */
 #define VMINSB     VX4(770)
 #define VMINSH     VX4(834)
 #define VMINSW     VX4(898)
+#define VMINSD     VX4(962)       /* v2.07 */
 #define VMINUB     VX4(514)
 #define VMINUH     VX4(578)
 #define VMINUW     VX4(642)
+#define VMINUD     VX4(706)       /* v2.07 */
 
 #define VCMPEQUB   VX4(6)
 #define VCMPEQUH   VX4(70)
 #define VCMPEQUW   VX4(134)
+#define VCMPEQUD   VX4(199)       /* v2.07 */
 #define VCMPGTSB   VX4(774)
 #define VCMPGTSH   VX4(838)
 #define VCMPGTSW   VX4(902)
+#define VCMPGTSD   VX4(967)       /* v2.07 */
 #define VCMPGTUB   VX4(518)
 #define VCMPGTUH   VX4(582)
 #define VCMPGTUW   VX4(646)
+#define VCMPGTUD   VX4(711)       /* v2.07 */
 
 #define VSLB       VX4(260)
 #define VSLH       VX4(324)
 #define VSLW       VX4(388)
+#define VSLD       VX4(1476)      /* v2.07 */
 #define VSRB       VX4(516)
 #define VSRH       VX4(580)
 #define VSRW       VX4(644)
+#define VSRD       VX4(1732)      /* v2.07 */
 #define VSRAB      VX4(772)
 #define VSRAH      VX4(836)
 #define VSRAW      VX4(900)
+#define VSRAD      VX4(964)       /* v2.07 */
 #define VRLB       VX4(4)
 #define VRLH       VX4(68)
 #define VRLW       VX4(132)
+#define VRLD       VX4(196)       /* v2.07 */
 
 #define VMULEUB    VX4(520)
 #define VMULEUH    VX4(584)
+#define VMULEUW    VX4(648)       /* v2.07 */
 #define VMULOUB    VX4(8)
 #define VMULOUH    VX4(72)
+#define VMULOUW    VX4(136)       /* v2.07 */
+#define VMULUWM    VX4(137)       /* v2.07 */
 #define VMSUMUHM   VX4(38)
 
 #define VMRGHB     VX4(12)
@@ -555,6 +574,9 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VNOR       VX4(1284)
 #define VOR        VX4(1156)
 #define VXOR       VX4(1220)
+#define VEQV       VX4(1668)      /* v2.07 */
+#define VNAND      VX4(1412)      /* v2.07 */
+#define VORC       VX4(1348)      /* v2.07 */
 
 #define VSPLTB     VX4(524)
 #define VSPLTH     VX4(588)
@@ -568,6 +590,11 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define XXPERMDI   (OPCD(60) | (10 << 3))   /* v2.06 */
 #define XXSEL      (OPCD(60) | (3 << 4))    /* v2.06 */
 
+#define MFVSRD     XO31(51)       /* v2.07 */
+#define MFVSRWZ    XO31(115)      /* v2.07 */
+#define MTVSRD     XO31(179)      /* v2.07 */
+#define MTVSRWZ    XO31(179)      /* v2.07 */
+
 #define RT(r) ((r)<<21)
 #define RS(r) ((r)<<21)
 #define RA(r) ((r)<<16)
@@ -697,12 +724,27 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         /* fallthru */
     case TCG_TYPE_I32:
-        if (ret < TCG_REG_V0 && arg < TCG_REG_V0) {
-            tcg_out32(s, OR | SAB(arg, ret, arg));
-            break;
-        } else if (ret < TCG_REG_V0 || arg < TCG_REG_V0) {
-            /* Altivec does not support vector/integer moves.  */
-            return false;
+        if (ret < TCG_REG_V0) {
+            if (arg < TCG_REG_V0) {
+                tcg_out32(s, OR | SAB(arg, ret, arg));
+                break;
+            } else if (have_isa_2_07_vsx) {
+                tcg_out32(s, (type == TCG_TYPE_I32 ? MFVSRWZ : MFVSRD)
+                          | VRT(arg) | RA(ret) | 1);
+                break;
+            } else {
+                /* Altivec does not support vector->integer moves.  */
+                return false;
+            }
+        } else if (arg < TCG_REG_V0) {
+            if (have_isa_2_07_vsx) {
+                tcg_out32(s, (type == TCG_TYPE_I32 ? MTVSRWZ : MTVSRD)
+                          | VRT(ret) | RA(arg) | 1);
+                break;
+            } else {
+                /* Altivec does not support integer->vector moves.  */
+                return false;
+            }
         }
         /* fallthru */
     case TCG_TYPE_V64:
@@ -1140,6 +1182,10 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
             tcg_out_mem_long(s, LWZ, LWZX, ret, base, offset);
             break;
         }
+        if (have_isa_2_07_vsx) {
+            tcg_out_mem_long(s, 0, LXSIWZX | 1, ret, base, offset);
+            break;
+        }
         assert((offset & 3) == 0);
         tcg_out_mem_long(s, 0, LVEWX, ret, base, offset);
         shift = (offset - 4) & 0xc;
@@ -1187,6 +1233,10 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
             tcg_out_mem_long(s, STW, STWX, arg, base, offset);
             break;
         }
+        if (have_isa_2_07_vsx) {
+            tcg_out_mem_long(s, 0, STXSIWX | 1, arg, base, offset);
+            break;
+        }
         assert((offset & 3) == 0);
         shift = (offset - 4) & 0xc;
         if (shift) {
@@ -2907,26 +2957,37 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_andc_vec:
     case INDEX_op_not_vec:
         return 1;
+    case INDEX_op_orc_vec:
+        return have_isa_2_07_vsx;
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
     case INDEX_op_smax_vec:
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+        return vece <= MO_32 || have_isa_2_07_vsx;
     case INDEX_op_ssadd_vec:
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
-    case INDEX_op_shlv_vec:
-    case INDEX_op_shrv_vec:
-    case INDEX_op_sarv_vec:
         return vece <= MO_32;
     case INDEX_op_cmp_vec:
-    case INDEX_op_mul_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
-        return vece <= MO_32 ? -1 : 0;
+        return vece <= MO_32 || have_isa_2_07_vsx ? -1 : 0;
+    case INDEX_op_mul_vec:
+        switch (vece) {
+        case MO_8:
+        case MO_16:
+            return -1;
+        case MO_32:
+            return have_isa_2_07_vsx ? 1 : -1;
+        }
+        return 0;
     case INDEX_op_bitsel_vec:
         return have_isa_2_06_vsx;
     default:
@@ -3030,28 +3091,28 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            const TCGArg *args, const int *const_args)
 {
     static const uint32_t
-        add_op[4] = { VADDUBM, VADDUHM, VADDUWM, 0 },
-        sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, 0 },
-        eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, 0 },
-        gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, 0 },
-        gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, 0 },
+        add_op[4] = { VADDUBM, VADDUHM, VADDUWM, VADDUDM },
+        sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, VSUBUDM },
+        eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
+        gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, VCMPGTSD },
+        gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, VCMPGTUD },
         ssadd_op[4] = { VADDSBS, VADDSHS, VADDSWS, 0 },
         usadd_op[4] = { VADDUBS, VADDUHS, VADDUWS, 0 },
         sssub_op[4] = { VSUBSBS, VSUBSHS, VSUBSWS, 0 },
         ussub_op[4] = { VSUBUBS, VSUBUHS, VSUBUWS, 0 },
-        umin_op[4] = { VMINUB, VMINUH, VMINUW, 0 },
-        smin_op[4] = { VMINSB, VMINSH, VMINSW, 0 },
-        umax_op[4] = { VMAXUB, VMAXUH, VMAXUW, 0 },
-        smax_op[4] = { VMAXSB, VMAXSH, VMAXSW, 0 },
-        shlv_op[4] = { VSLB, VSLH, VSLW, 0 },
-        shrv_op[4] = { VSRB, VSRH, VSRW, 0 },
-        sarv_op[4] = { VSRAB, VSRAH, VSRAW, 0 },
+        umin_op[4] = { VMINUB, VMINUH, VMINUW, VMINUD },
+        smin_op[4] = { VMINSB, VMINSH, VMINSW, VMINSD },
+        umax_op[4] = { VMAXUB, VMAXUH, VMAXUW, VMAXUD },
+        smax_op[4] = { VMAXSB, VMAXSH, VMAXSW, VMAXSD },
+        shlv_op[4] = { VSLB, VSLH, VSLW, VSLD },
+        shrv_op[4] = { VSRB, VSRH, VSRW, VSRD },
+        sarv_op[4] = { VSRAB, VSRAH, VSRAW, VSRAD },
         mrgh_op[4] = { VMRGHB, VMRGHH, VMRGHW, 0 },
         mrgl_op[4] = { VMRGLB, VMRGLH, VMRGLW, 0 },
-        muleu_op[4] = { VMULEUB, VMULEUH, 0, 0 },
-        mulou_op[4] = { VMULOUB, VMULOUH, 0, 0 },
+        muleu_op[4] = { VMULEUB, VMULEUH, VMULEUW, 0 },
+        mulou_op[4] = { VMULOUB, VMULOUH, VMULOUW, 0 },
         pkum_op[4] = { VPKUHUM, VPKUWUM, 0, 0 },
-        rotl_op[4] = { VRLB, VRLH, VRLW, 0 };
+        rotl_op[4] = { VRLB, VRLH, VRLW, VRLD };
 
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0 = args[0], a1 = args[1], a2 = args[2];
@@ -3074,6 +3135,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sub_vec:
         insn = sub_op[vece];
         break;
+    case INDEX_op_mul_vec:
+        tcg_debug_assert(vece == MO_32 && have_isa_2_07_vsx);
+        insn = VMULUWM;
+        break;
     case INDEX_op_ssadd_vec:
         insn = ssadd_op[vece];
         break;
@@ -3123,6 +3188,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         insn = VNOR;
         a2 = a1;
         break;
+    case INDEX_op_orc_vec:
+        insn = VORC;
+        break;
 
     case INDEX_op_cmp_vec:
         switch (args[3]) {
@@ -3203,7 +3271,7 @@ static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
 {
     bool need_swap = false, need_inv = false;
 
-    tcg_debug_assert(vece <= MO_32);
+    tcg_debug_assert(vece <= MO_32 || have_isa_2_07_vsx);
 
     switch (cond) {
     case TCG_COND_EQ:
@@ -3267,6 +3335,7 @@ static void expand_vec_mul(TCGType type, unsigned vece, TCGv_vec v0,
 	break;
 
     case MO_32:
+        tcg_debug_assert(!have_isa_2_07_vsx);
         t3 = tcg_temp_new_vec(type);
         t4 = tcg_temp_new_vec(type);
         tcg_gen_dupi_vec(MO_8, t4, -16);
@@ -3562,6 +3631,11 @@ static void tcg_target_init(TCGContext *s)
             have_isa_2_06_vsx = true;
         }
     }
+    if (hwcap2 & PPC_FEATURE2_ARCH_2_07) {
+        if (hwcap & PPC_FEATURE_HAS_VSX) {
+            have_isa_2_07_vsx = true;
+        }
+    }
 #ifdef PPC_FEATURE2_ARCH_3_00
     if (hwcap2 & PPC_FEATURE2_ARCH_3_00) {
         have_isa_3_00 = true;
-- 
2.17.1


