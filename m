Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B4AC35280
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE54122509
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g59BHi7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE54122509
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2Vz-0000X2-R2
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2BB-0004z2-4b
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2B9-0005p1-Mn
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:56 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2B9-0005od-H6
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:55 -0400
Received: by mail-pf1-x444.google.com with SMTP id q5so6210085pfg.13
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HeKQyFXdAD3p3CrTgUxvWn1tBUXGzKhYow9Z2REu0SA=;
 b=g59BHi7ycK/1gMeFlt/v4xzFWBdRUbi7mfa3y9F+6hERZR5K9L9wkBWsYq7yeYBKn/
 01pJC3XyLSmFNSRSwgpigmkoyX12o8xyGRs0IY9bDlq9Di3GnN0+XcKA/xfNah7rOdVO
 42mGMN5CDmU7cByM+587JMyNoUgBWdFq93jc16Jw4pQUP8w7UMfGn56yhS1b7WKiL59e
 AjCaqb8nC0V0v30gcKMPGXpIOf2GNboYnJIqYh7jHsFoUOoxmmPB0ym/O+MTiIf/1R5f
 uVHvbIdl0ujPqEODORAjMOCRppPdFlXGcdEZiGnJZHBykTw5v1LOt7fMmWTVPGzUXVnR
 Hvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HeKQyFXdAD3p3CrTgUxvWn1tBUXGzKhYow9Z2REu0SA=;
 b=nF0HHB34lPE/N/TuxIP8RRsKL+Ux+4P0asmvWdnV+bNW2w4BWdG91Fe/bp1wjcdrTd
 03VniPP3YCQtc3YFurzzqoFRMSKbOincwGjvVu4RFvci3A6OKY4KoVmNvw2k0m9X62sh
 Xq2ADmR9TPnWmU5670WvZRDN5T0DMIF+C8bm1amktt53F6DvOPuYJrS+X7u934G5WDoV
 CWAomWGnU/MgiaAfcK2zVddVZUfElgB/yjtHtAD486k0R+0uaV/20bm3pvYksRYRhktb
 QgL1BXXrMJQ4wiqTGTevpKLKPsf4Nv5/hOOZh/V5Q8CbmtXsJjsZBKskBzEa116QujGs
 z4uA==
X-Gm-Message-State: APjAAAV0HlHU/+RZWIwvzQdIyeSDop0vnLlRSzhjj2Gt4xkGqbEE0Eqn
 G74LVZpGk1hvkNzL1y0xVvI23t2GsZI=
X-Google-Smtp-Source: APXvYqw7/UEveRUTPCVrQFPxvy/bPjTo9PEGewxq2Rd3gDL1z3a9AWG4mR4sT1kmHKTKkBjSXfI5mA==
X-Received: by 2002:a17:90a:5ae4:: with SMTP id
 n91mr1122499pji.143.1569874914139; 
 Mon, 30 Sep 2019 13:21:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 21/22] tcg/ppc: Update vector support for v3.00 load/store
Date: Mon, 30 Sep 2019 13:21:24 -0700
Message-Id: <20190930202125.21064-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

These new instructions are a mix of those like LXSD that are
only conditional only on MSR.VEC and those like LXV that are
conditional on MSR.VEC for TX=1.  Thus, in the end, we can
consider all of these as Altivec instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 47 ++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index bd9259c60f..5b7d1bd2dc 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -471,11 +471,16 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define LXSDX      (XO31(588) | 1)  /* v2.06, force tx=1 */
 #define LXVDSX     (XO31(332) | 1)  /* v2.06, force tx=1 */
 #define LXSIWZX    (XO31(12) | 1)   /* v2.07, force tx=1 */
+#define LXV        (OPCD(61) | 8 | 1)  /* v3.00, force tx=1 */
+#define LXSD       (OPCD(57) | 2)   /* v3.00 */
+#define LXVWSX     (XO31(364) | 1)  /* v3.00, force tx=1 */
 
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
 #define STXSDX     (XO31(716) | 1)  /* v2.06, force sx=1 */
 #define STXSIWX    (XO31(140) | 1)  /* v2.07, force sx=1 */
+#define STXV       (OPCD(61) | 8 | 5) /* v3.00, force sx=1 */
+#define STXSD      (OPCD(61) | 2)   /* v3.00 */
 
 #define VADDSBS    VX4(768)
 #define VADDUBS    VX4(512)
@@ -1114,7 +1119,7 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
                              TCGReg base, tcg_target_long offset)
 {
     tcg_target_long orig = offset, l0, l1, extra = 0, align = 0;
-    bool is_store = false;
+    bool is_int_store = false;
     TCGReg rs = TCG_REG_TMP1;
 
     switch (opi) {
@@ -1127,11 +1132,19 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
             break;
         }
         break;
+    case LXSD:
+    case STXSD:
+        align = 3;
+        break;
+    case LXV:
+    case STXV:
+        align = 15;
+        break;
     case STD:
         align = 3;
         /* FALLTHRU */
     case STB: case STH: case STW:
-        is_store = true;
+        is_int_store = true;
         break;
     }
 
@@ -1140,7 +1153,7 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
         if (rs == base) {
             rs = TCG_REG_R0;
         }
-        tcg_debug_assert(!is_store || rs != rt);
+        tcg_debug_assert(!is_int_store || rs != rt);
         tcg_out_movi(s, TCG_TYPE_PTR, rs, orig);
         tcg_out32(s, opx | TAB(rt & 31, base, rs));
         return;
@@ -1205,7 +1218,8 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
     case TCG_TYPE_V64:
         tcg_debug_assert(ret >= TCG_REG_V0);
         if (have_vsx) {
-            tcg_out_mem_long(s, 0, LXSDX, ret, base, offset);
+            tcg_out_mem_long(s, have_isa_3_00 ? LXSD : 0, LXSDX,
+                             ret, base, offset);
             break;
         }
         tcg_debug_assert((offset & 7) == 0);
@@ -1217,7 +1231,8 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
     case TCG_TYPE_V128:
         tcg_debug_assert(ret >= TCG_REG_V0);
         tcg_debug_assert((offset & 15) == 0);
-        tcg_out_mem_long(s, 0, LVX, ret, base, offset);
+        tcg_out_mem_long(s, have_isa_3_00 ? LXV : 0,
+                         LVX, ret, base, offset);
         break;
     default:
         g_assert_not_reached();
@@ -1258,7 +1273,8 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
     case TCG_TYPE_V64:
         tcg_debug_assert(arg >= TCG_REG_V0);
         if (have_vsx) {
-            tcg_out_mem_long(s, 0, STXSDX, arg, base, offset);
+            tcg_out_mem_long(s, have_isa_3_00 ? STXSD : 0,
+                             STXSDX, arg, base, offset);
             break;
         }
         tcg_debug_assert((offset & 7) == 0);
@@ -1271,7 +1287,8 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
         break;
     case TCG_TYPE_V128:
         tcg_debug_assert(arg >= TCG_REG_V0);
-        tcg_out_mem_long(s, 0, STVX, arg, base, offset);
+        tcg_out_mem_long(s, have_isa_3_00 ? STXV : 0,
+                         STVX, arg, base, offset);
         break;
     default:
         g_assert_not_reached();
@@ -3042,7 +3059,11 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
     tcg_debug_assert(out >= TCG_REG_V0);
     switch (vece) {
     case MO_8:
-        tcg_out_mem_long(s, 0, LVEBX, out, base, offset);
+        if (have_isa_3_00) {
+            tcg_out_mem_long(s, LXV, LVX, out, base, offset & -16);
+        } else {
+            tcg_out_mem_long(s, 0, LVEBX, out, base, offset);
+        }
         elt = extract32(offset, 0, 4);
 #ifndef HOST_WORDS_BIGENDIAN
         elt ^= 15;
@@ -3051,7 +3072,11 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
         break;
     case MO_16:
         tcg_debug_assert((offset & 1) == 0);
-        tcg_out_mem_long(s, 0, LVEHX, out, base, offset);
+        if (have_isa_3_00) {
+            tcg_out_mem_long(s, LXV | 8, LVX, out, base, offset & -16);
+        } else {
+            tcg_out_mem_long(s, 0, LVEHX, out, base, offset);
+        }
         elt = extract32(offset, 1, 3);
 #ifndef HOST_WORDS_BIGENDIAN
         elt ^= 7;
@@ -3059,6 +3084,10 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
         tcg_out32(s, VSPLTH | VRT(out) | VRB(out) | (elt << 16));
         break;
     case MO_32:
+        if (have_isa_3_00) {
+            tcg_out_mem_long(s, 0, LXVWSX, out, base, offset);
+            break;
+        }
         tcg_debug_assert((offset & 3) == 0);
         tcg_out_mem_long(s, 0, LVEWX, out, base, offset);
         elt = extract32(offset, 2, 2);
-- 
2.17.1


