Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515B3C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0650321479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2Fa43b5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0650321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38185 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkgL-0000GY-6f
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:45:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWc-0008Up-SI
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWb-0007wj-LX
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:02 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWb-0007ud-EZ
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:01 -0400
Received: by mail-pf1-x442.google.com with SMTP id 10so3468870pfo.5
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=gN4B/Stb2lbgTIviKYPnpm58ErCGyH4cO3TJuIucX7A=;
	b=a2Fa43b5mKhdlmgzqumM14WhxwTkr7Duf/AZDdGRGE/bEwnGliZSOVhwrLWiwVquLL
	+fpLjlHf+T90QfrG6VpgMKC3RogA6sWXkDziwWQUgeZ/UcEEHgRR1eaHyzX8FcP38lp+
	fg03cDQvKS8iBfXtMi/hkDXz317yNWj0CJcmegsOQJek+l2tGKJBZGuh1WtwXzqJ2Nuw
	jZBWCQ/lnHB7ykrQRHRyvqxlvqE5Y16kuU1bElMaSx3J4VrBl8/ZY9o5TJqkOTQU9mio
	d1Sg7b+ZQ58qApKBYnGMmA9yZb1Ndy3Jerc2bGBE6Z3AUyiw+/6OTFfgApqt7gsUU9Ta
	xq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=gN4B/Stb2lbgTIviKYPnpm58ErCGyH4cO3TJuIucX7A=;
	b=CroBBuQ73F6/Fl3bIWEgLA4iFAN9iYCGJh/VlIX7/rH8Luf1Jp+S64BC98IOcJYvwI
	4hrGMhur1ZJA/4jZwUnj50xFPIVkLV1r+zgBtFyQDpe2b04A2tXfCENTfTGtmuTGaXjX
	4e2InHSf3dGUewrnJmOEhDjB2fQjSaPHkelLkhKB53XFVvcs/lKcdNJlbcbF65KHXHQs
	e6yjvQq6YpQQWhL3aLBimIFw8xcq5fh3q2zUUcS6dqmcQrBnijb5NmOkYuOEGO+aZ+rr
	xnszC7nGuzb8S9Qf05JbXSvoxodbNGudc2T/I66ICvsHrS3icoHOm8fFS7hRy91dZlFd
	wyDA==
X-Gm-Message-State: APjAAAXYn1fe5wQOLIpXjy/4I6KdjTj6erOLeh7Ewksqrt05RPSbP3WD
	8vS4bH2pDJiCbbMhryWjfLno9oF2aO0=
X-Google-Smtp-Source: APXvYqzAf1iLB0UbzyX75pVo4KTLT1xpYxFdL0uksOPzEKHFprbIkRiESb7rv//L3V7v1v2rUeyIcA==
X-Received: by 2002:a63:6f0a:: with SMTP id k10mr8017418pgc.78.1555745700138; 
	Sat, 20 Apr 2019 00:35:00 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.34.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:34:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:13 -1000
Message-Id: <20190420073442.7488-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 09/38] tcg/i386: Implement tcg_out_dupm_vec
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073413.fMa0nIqbateMUkc5enmvOoToz7ScPCn0iLPUnpzL1Yo@z>

At the same time, improve tcg_out_dupi_vec wrt broadcast
from the constant pool.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 57 +++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 0be7d8f589..fcabc1bdf2 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -358,7 +358,6 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVBE_MyGy  (0xf1 | P_EXT38)
 #define OPC_MOVD_VyEy   (0x6e | P_EXT | P_DATA16)
 #define OPC_MOVD_EyVy   (0x7e | P_EXT | P_DATA16)
-#define OPC_MOVDDUP     (0x12 | P_EXT | P_SIMDF2)
 #define OPC_MOVDQA_VxWx (0x6f | P_EXT | P_DATA16)
 #define OPC_MOVDQA_WxVx (0x7f | P_EXT | P_DATA16)
 #define OPC_MOVDQU_VxWx (0x6f | P_EXT | P_SIMDF3)
@@ -458,6 +457,10 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_UD2         (0x0b | P_EXT)
 #define OPC_VPBLENDD    (0x02 | P_EXT3A | P_DATA16)
 #define OPC_VPBLENDVB   (0x4c | P_EXT3A | P_DATA16)
+#define OPC_VPINSRB     (0x20 | P_EXT3A | P_DATA16)
+#define OPC_VPINSRW     (0xc4 | P_EXT | P_DATA16)
+#define OPC_VBROADCASTSS (0x18 | P_EXT38 | P_DATA16)
+#define OPC_VBROADCASTSD (0x19 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTB (0x78 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTW (0x79 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTD (0x58 | P_EXT38 | P_DATA16)
@@ -855,16 +858,17 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     return true;
 }
 
+static const int avx2_dup_insn[4] = {
+    OPC_VPBROADCASTB, OPC_VPBROADCASTW,
+    OPC_VPBROADCASTD, OPC_VPBROADCASTQ,
+};
+
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg r, TCGReg a)
 {
     if (have_avx2) {
-        static const int dup_insn[4] = {
-            OPC_VPBROADCASTB, OPC_VPBROADCASTW,
-            OPC_VPBROADCASTD, OPC_VPBROADCASTQ,
-        };
         int vex_l = (type == TCG_TYPE_V256 ? P_VEXL : 0);
-        tcg_out_vex_modrm(s, dup_insn[vece] + vex_l, r, 0, a);
+        tcg_out_vex_modrm(s, avx2_dup_insn[vece] + vex_l, r, 0, a);
     } else {
         switch (vece) {
         case MO_8:
@@ -894,10 +898,35 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                              TCGReg r, TCGReg base, intptr_t offset)
 {
-    return false;
+    if (have_avx2) {
+        int vex_l = (type == TCG_TYPE_V256 ? P_VEXL : 0);
+        tcg_out_vex_modrm_offset(s, avx2_dup_insn[vece] + vex_l,
+                                 r, 0, base, offset);
+    } else {
+        switch (vece) {
+        case MO_64:
+            tcg_out_vex_modrm_offset(s, OPC_VBROADCASTSD, r, 0, base, offset);
+            break;
+        case MO_32:
+            tcg_out_vex_modrm_offset(s, OPC_VBROADCASTSS, r, 0, base, offset);
+            break;
+        case MO_16:
+            tcg_out_vex_modrm_offset(s, OPC_VPINSRW, r, r, base, offset);
+            tcg_out8(s, 0); /* imm8 */
+            tcg_out_dup_vec(s, type, vece, r, r);
+            break;
+        case MO_8:
+            tcg_out_vex_modrm_offset(s, OPC_VPINSRB, r, r, base, offset);
+            tcg_out8(s, 0); /* imm8 */
+            tcg_out_dup_vec(s, type, vece, r, r);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    return true;
 }
 
-
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
                              TCGReg ret, tcg_target_long arg)
 {
@@ -918,16 +947,16 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
         } else if (have_avx2) {
             tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTQ + vex_l, ret);
         } else {
-            tcg_out_vex_modrm_pool(s, OPC_MOVDDUP, ret);
+            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSD, ret);
         }
         new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
-    } else if (have_avx2) {
-        tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTD + vex_l, ret);
-        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
     } else {
-        tcg_out_vex_modrm_pool(s, OPC_MOVD_VyEy, ret);
+        if (have_avx2) {
+            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSD + vex_l, ret);
+        } else {
+            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
+        }
         new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
-        tcg_out_dup_vec(s, type, MO_32, ret, ret);
     }
 }
 
-- 
2.17.1


