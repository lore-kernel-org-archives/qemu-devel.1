Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70D3C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6692083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAP0P6+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6692083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwvd-0007tl-Tg
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:15:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUG-0004fj-4x
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU8-0004Gd-Lm
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU8-0003Qo-9L
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:32 -0400
Received: by mail-wr1-x441.google.com with SMTP id r18so3320247wrm.10
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=OPmJIDS5EQ/XYTrJS7IKfgCnnuP6L+oh/wc5ZioeaMA=;
	b=YAP0P6+0NIZjQep8hUx2ZRVvPOX2BPiGfh5a2k2s2Rq1di8HrpM1voHArcgjT/rBC+
	qCbD1EsmKp1/o0lwtRemDDiREMl5QiQOYdk3BXunLB70qF7j7yH+L+MYQ6JQOH0QbC+w
	l9Su/02YGlOrQ5HiGMLupJgdc2OmG4cPOC7SOVv1ce6F3ORESdL+3DVhAy8AxDCJNKBc
	A9ezFuJwmtXzPX/OnA/0o9rmruy58t7D9Iz3TNxu0LffXhnUitufChLesfZK/O9n5UDL
	RGSqeNVHZaqPL/QU/aU4YKDwn3iace2pNlGXThMROUC7Wr4lRriQZeEVa5HYrLrUl7bu
	bNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=OPmJIDS5EQ/XYTrJS7IKfgCnnuP6L+oh/wc5ZioeaMA=;
	b=nc3L/JNYoK2p1H0WdEm23zaNQucUVGCbUe9v2EchTxT5aoj/t13nxtQyeIIFDEQ/SI
	Xj0ZjgjamDz6WoKHrGtDI9o/c51CRJsKw058fYUhOBEk7WM1jBPgVbCOUEBOrrmJMm5C
	vJNLBkU9bRFoAmkNLGPgmM1WjduKf5nGtLVk1k44SvVcPkMYZRYyY0NWR+Ci09ApoUWo
	cdbP6BVmmNSkkQ9y9JF2ofqJMdcVz6NSPduwMI4RCtbtQZpboBjhz3Y1Te1vHLwyXdMf
	ceBwFonDwQJR0hJa9T+QSWFA6OGxLQgvCyGzxx49gT6HV3NBN/PcqmShB1ByC7AFQAg1
	JLuw==
X-Gm-Message-State: APjAAAXkg6Gx7u2MO8pKtJ8BYLa4H7U8eCJzJwTKQNhSvJ9QsnRjOt7z
	Qo6dPrJy5GKIjdYM/q/4w2rS3g==
X-Google-Smtp-Source: APXvYqza78vRv1VdlV46zO8iPVj8g7XFAy1jZDRndXnGI90mLGZpQp40V+OIYKyhkv1gjtRt+nwcgg==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr10985542wrw.309.1559843218047; 
	Thu, 06 Jun 2019 10:46:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:46:09 +0100
Message-Id: <20190606174609.20487-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 42/42] target/arm: Fix short-vector increment
 behaviour
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For VFP short vectors, the VFP registers are divided into a
series of banks: for single-precision these are s0-s7, s8-s15,
s16-s23 and s24-s31; for double-precision they are d0-d3,
d4-d7, ... d28-d31. Some banks are "scalar" meaning that
use of a register within them triggers a pure-scalar or
mixed vector-scalar operation rather than a full vector
operation. The scalar banks are s0-s7, d0-d3 and d16-d19.
When using a bank as part of a vector operation, we
iterate through it, increasing the register number by
the specified stride each time, and wrapping around to
the beginning of the bank.

Unfortunately our calculation of the "increment" part of this
was incorrect:
 vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask)
will only do the intended thing if bank_mask has exactly
one set high bit. For instance for doubles (bank_mask = 0xc),
if we start with vd = 6 and delta_d = 2 then vd is updated
to 12 rather than the intended 4.

This only causes problems in the unlikely case that the
starting register is not the first in its bank: if the
register number doesn't have to wrap around then the
expression happens to give the right answer.

Fix this bug by abstracting out the "check whether register
is in a scalar bank" and "advance register within bank"
operations to utility functions which use the right
bit masking operations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 100 ++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 40 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 90bc23ef773..baeea14d56f 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1139,6 +1139,42 @@ typedef void VFPGen3OpDPFn(TCGv_i64 vd,
 typedef void VFPGen2OpSPFn(TCGv_i32 vd, TCGv_i32 vm);
 typedef void VFPGen2OpDPFn(TCGv_i64 vd, TCGv_i64 vm);
 
+/*
+ * Return true if the specified S reg is in a scalar bank
+ * (ie if it is s0..s7)
+ */
+static inline bool vfp_sreg_is_scalar(int reg)
+{
+    return (reg & 0x18) == 0;
+}
+
+/*
+ * Return true if the specified D reg is in a scalar bank
+ * (ie if it is d0..d3 or d16..d19)
+ */
+static inline bool vfp_dreg_is_scalar(int reg)
+{
+    return (reg & 0xc) == 0;
+}
+
+/*
+ * Advance the S reg number forwards by delta within its bank
+ * (ie increment the low 3 bits but leave the rest the same)
+ */
+static inline int vfp_advance_sreg(int reg, int delta)
+{
+    return ((reg + delta) & 0x7) | (reg & ~0x7);
+}
+
+/*
+ * Advance the D reg number forwards by delta within its bank
+ * (ie increment the low 2 bits but leave the rest the same)
+ */
+static inline int vfp_advance_dreg(int reg, int delta)
+{
+    return ((reg + delta) & 0x3) | (reg & ~0x3);
+}
+
 /*
  * Perform a 3-operand VFP data processing instruction. fn is the
  * callback to do the actual operation; this function deals with the
@@ -1149,7 +1185,6 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
 {
     uint32_t delta_m = 0;
     uint32_t delta_d = 0;
-    uint32_t bank_mask = 0;
     int veclen = s->vec_len;
     TCGv_i32 f0, f1, fd;
     TCGv_ptr fpst;
@@ -1164,16 +1199,14 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
     }
 
     if (veclen > 0) {
-        bank_mask = 0x18;
-
         /* Figure out what type of vector operation this is.  */
-        if ((vd & bank_mask) == 0) {
+        if (vfp_sreg_is_scalar(vd)) {
             /* scalar */
             veclen = 0;
         } else {
             delta_d = s->vec_stride + 1;
 
-            if ((vm & bank_mask) == 0) {
+            if (vfp_sreg_is_scalar(vm)) {
                 /* mixed scalar/vector */
                 delta_m = 0;
             } else {
@@ -1204,11 +1237,11 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
 
         /* Set up the operands for the next iteration */
         veclen--;
-        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
-        vn = ((vn + delta_d) & (bank_mask - 1)) | (vn & bank_mask);
+        vd = vfp_advance_sreg(vd, delta_d);
+        vn = vfp_advance_sreg(vn, delta_d);
         neon_load_reg32(f0, vn);
         if (delta_m) {
-            vm = ((vm + delta_m) & (bank_mask - 1)) | (vm & bank_mask);
+            vm = vfp_advance_sreg(vm, delta_m);
             neon_load_reg32(f1, vm);
         }
     }
@@ -1226,7 +1259,6 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
 {
     uint32_t delta_m = 0;
     uint32_t delta_d = 0;
-    uint32_t bank_mask = 0;
     int veclen = s->vec_len;
     TCGv_i64 f0, f1, fd;
     TCGv_ptr fpst;
@@ -1246,16 +1278,14 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     }
 
     if (veclen > 0) {
-        bank_mask = 0xc;
-
         /* Figure out what type of vector operation this is.  */
-        if ((vd & bank_mask) == 0) {
+        if (vfp_dreg_is_scalar(vd)) {
             /* scalar */
             veclen = 0;
         } else {
             delta_d = (s->vec_stride >> 1) + 1;
 
-            if ((vm & bank_mask) == 0) {
+            if (vfp_dreg_is_scalar(vm)) {
                 /* mixed scalar/vector */
                 delta_m = 0;
             } else {
@@ -1285,11 +1315,11 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
         }
         /* Set up the operands for the next iteration */
         veclen--;
-        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
-        vn = ((vn + delta_d) & (bank_mask - 1)) | (vn & bank_mask);
+        vd = vfp_advance_dreg(vd, delta_d);
+        vn = vfp_advance_dreg(vn, delta_d);
         neon_load_reg64(f0, vn);
         if (delta_m) {
-            vm = ((vm + delta_m) & (bank_mask - 1)) | (vm & bank_mask);
+            vm = vfp_advance_dreg(vm, delta_m);
             neon_load_reg64(f1, vm);
         }
     }
@@ -1306,7 +1336,6 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
 {
     uint32_t delta_m = 0;
     uint32_t delta_d = 0;
-    uint32_t bank_mask = 0;
     int veclen = s->vec_len;
     TCGv_i32 f0, fd;
 
@@ -1320,16 +1349,14 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
     }
 
     if (veclen > 0) {
-        bank_mask = 0x18;
-
         /* Figure out what type of vector operation this is.  */
-        if ((vd & bank_mask) == 0) {
+        if (vfp_sreg_is_scalar(vd)) {
             /* scalar */
             veclen = 0;
         } else {
             delta_d = s->vec_stride + 1;
 
-            if ((vm & bank_mask) == 0) {
+            if (vfp_sreg_is_scalar(vm)) {
                 /* mixed scalar/vector */
                 delta_m = 0;
             } else {
@@ -1355,7 +1382,7 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
         if (delta_m == 0) {
             /* single source one-many */
             while (veclen--) {
-                vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+                vd = vfp_advance_sreg(vd, delta_d);
                 neon_store_reg32(fd, vd);
             }
             break;
@@ -1363,8 +1390,8 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
 
         /* Set up the operands for the next iteration */
         veclen--;
-        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
-        vm = ((vm + delta_m) & (bank_mask - 1)) | (vm & bank_mask);
+        vd = vfp_advance_sreg(vd, delta_d);
+        vm = vfp_advance_sreg(vm, delta_m);
         neon_load_reg32(f0, vm);
     }
 
@@ -1378,7 +1405,6 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
 {
     uint32_t delta_m = 0;
     uint32_t delta_d = 0;
-    uint32_t bank_mask = 0;
     int veclen = s->vec_len;
     TCGv_i64 f0, fd;
 
@@ -1397,16 +1423,14 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
     }
 
     if (veclen > 0) {
-        bank_mask = 0xc;
-
         /* Figure out what type of vector operation this is.  */
-        if ((vd & bank_mask) == 0) {
+        if (vfp_dreg_is_scalar(vd)) {
             /* scalar */
             veclen = 0;
         } else {
             delta_d = (s->vec_stride >> 1) + 1;
 
-            if ((vm & bank_mask) == 0) {
+            if (vfp_dreg_is_scalar(vm)) {
                 /* mixed scalar/vector */
                 delta_m = 0;
             } else {
@@ -1432,7 +1456,7 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
         if (delta_m == 0) {
             /* single source one-many */
             while (veclen--) {
-                vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+                vd = vfp_advance_dreg(vd, delta_d);
                 neon_store_reg64(fd, vd);
             }
             break;
@@ -1440,8 +1464,8 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
 
         /* Set up the operands for the next iteration */
         veclen--;
-        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
-        vm = ((vm + delta_m) & (bank_mask - 1)) | (vm & bank_mask);
+        vd = vfp_advance_dreg(vd, delta_d);
+        vd = vfp_advance_dreg(vm, delta_m);
         neon_load_reg64(f0, vm);
     }
 
@@ -1783,7 +1807,6 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_sp *a)
 static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 {
     uint32_t delta_d = 0;
-    uint32_t bank_mask = 0;
     int veclen = s->vec_len;
     TCGv_i32 fd;
     uint32_t n, i, vd;
@@ -1804,9 +1827,8 @@ static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
     }
 
     if (veclen > 0) {
-        bank_mask = 0x18;
         /* Figure out what type of vector operation this is.  */
-        if ((vd & bank_mask) == 0) {
+        if (vfp_sreg_is_scalar(vd)) {
             /* scalar */
             veclen = 0;
         } else {
@@ -1835,7 +1857,7 @@ static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 
         /* Set up the operands for the next iteration */
         veclen--;
-        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+        vd = vfp_advance_sreg(vd, delta_d);
     }
 
     tcg_temp_free_i32(fd);
@@ -1845,7 +1867,6 @@ static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 {
     uint32_t delta_d = 0;
-    uint32_t bank_mask = 0;
     int veclen = s->vec_len;
     TCGv_i64 fd;
     uint32_t n, i, vd;
@@ -1871,9 +1892,8 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
     }
 
     if (veclen > 0) {
-        bank_mask = 0xc;
         /* Figure out what type of vector operation this is.  */
-        if ((vd & bank_mask) == 0) {
+        if (vfp_dreg_is_scalar(vd)) {
             /* scalar */
             veclen = 0;
         } else {
@@ -1902,7 +1922,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 
         /* Set up the operands for the next iteration */
         veclen--;
-        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+        vfp_advance_dreg(vd, delta_d);
     }
 
     tcg_temp_free_i64(fd);
-- 
2.20.1


