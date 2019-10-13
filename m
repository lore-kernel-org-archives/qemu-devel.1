Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783A5C4CECE
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C24206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhd4QTC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C24206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmSD-0007MC-U3
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJl-00076G-0g
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJj-00018k-8R
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:24 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:41187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJf-000142-EO
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:21 -0400
Received: by mail-pf1-x42c.google.com with SMTP id q7so9250227pfh.8
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ca0/JTgWp5vQ6VZt3FKmDT0cq5/Y2RTYUY9dPjXj27o=;
 b=xhd4QTC0KxQKaY5XSiafEMKIyaoyuwS1rh5ZG+mO98TROVit5Ta3pw5RUU9Qywr1IO
 6LBwD1R+8Ay8RCgoy/pRWOUZn/QckUhaDQZ7r+gy2bs+5or3MVx7rRV5vuoprSA5Qj35
 2CcsNMCwL1TiS70Lct9ywaRUPa2Ati9hoaxMvxC5eagNU3ej0Zunx4glcs8Kll1M34up
 Shtev8jNmXUVwN/xyaRU8dcHFKLfCeUf0nd14rr3l+1zEn8A9sDg9TxCvTalBXpbacTh
 EdO/qXKn77Yynr+uQ5cP4EuCV/EX7210pTvY+yHEo5QjIheiqhDgnv+aYeq7hHR/MQ5M
 EwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ca0/JTgWp5vQ6VZt3FKmDT0cq5/Y2RTYUY9dPjXj27o=;
 b=j2O7Da9hWa1Gb4RNvVIEwuTMS0XmMWdoSEOWga3N/bf27NrcBhv2PEnLErqH4dcILE
 sagFkyJVGlUA++3nM9hmJat3969rAKk/CDNcCjqO4vJ/c0VzCjVkY+4SuPdS96bOKTFP
 FHdPQup7Ml1SUmXl0x/HtcrPjoz75xAa/VFbGKc3Ubd5I/sU845JAPb4J7BRbwIUkgRE
 n7AV/Qnx3eVEmySg5g82NcUIt5fx4BDl28/+XWOjmmMT+V92EurKHMU75imRU7gRmA7l
 xOPjAcegM+H+PjYYv5C8+jvnjqAioR5tXCPXh95dyLzV+51MixBtwtgdOb8IyzH409RY
 IUcg==
X-Gm-Message-State: APjAAAWNG7vCY3r5mvWQNGVa4jeFs92OH5ZRLrTU+By5QJ5LIik/0GVv
 VaX4wW8Okglq1c8t+cqgsqbIbYJx26w=
X-Google-Smtp-Source: APXvYqxvlwtgqgdE6mE6lvZUkF7Fo8ULQ0q4HlQbckgH77Gvyoslj5PvQ+DGzxmSD4fBSJfusHBJ/g==
X-Received: by 2002:a63:1e59:: with SMTP id p25mr29501986pgm.361.1571005574041; 
 Sun, 13 Oct 2019 15:26:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:26:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/23] tcg/ppc: Update vector support for v3.00 load/store
Date: Sun, 13 Oct 2019 15:25:42 -0700
Message-Id: <20191013222544.3679-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42c
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These new instructions are a mix of those like LXSD that are
only conditional only on MSR.VEC and those like LXV that are
conditional on MSR.VEC for TX=1.  Thus, in the end, we can
consider all of these as Altivec instructions.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
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


