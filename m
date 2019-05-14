Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69519C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240952084F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VsbJxcyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240952084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36601 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQL0Z-0002pg-3u
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:09:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKy9-0001dC-2O
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxJ-0003Jf-Fg
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:55 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:42687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxJ-0003CA-0N
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:05 -0400
Received: by mail-pf1-x430.google.com with SMTP id 13so8063103pfw.9
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=4qREfMgDOvDIZnxD8mHxrlGbKtAgS56ZNj2GB4ImDXs=;
	b=VsbJxcyKmRyLl+PMeAvEhUPlSvDfB1Vflk6p0VJD9jxHAY+PWtzH9+/si5XvfI6vWI
	pwnMO2wY8weJ/Ov+lppwE2cp5PfIo1dR6IH1KImgmq6BFyzu+qN5Z7Uvgl5uWjkCtiyi
	9dlJuAkrQRQwOZ9innjFLprn/XHgH0dhp3asvpaztEQXTKVNhpbItWmCc6ss9Hun6M7z
	pno5le59nwuDZDEmmGH45oCR0keVSza5JIi1AG/lXus48ZJgX6VsM3JOT3zaBFVX5p7M
	UUBYefKH47+j32PVdNEJx8JIXviD9ylMwlEYNES6y6mAwE6tpthsdVHS9hhH5d1ABNZ2
	zPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=4qREfMgDOvDIZnxD8mHxrlGbKtAgS56ZNj2GB4ImDXs=;
	b=I8CQwGSwBXF0t/liE85FxzdS1kcUthe2LX4gnnzXXlPC7xwYeaKsozdcOsTzNbih2s
	jWriBNWCPeDf/uWmetCxehpIkJke4MgvE1kWyInp7iomhyYwG+86p2supDzNBSCkg1B1
	YjPGDtIaj/zcDMLA0145V9yNGlJaTNPcycXl/PIC/CWdrajVkBgx0o7nlLeSr0vez8x6
	fsbnAkgKhWDP76z5B1qN4qJhsdYdBe72Q3Ubf6o0EtqcjkPHrVY/sKxv2nMVpav4t9oR
	G+Jk/QOfBv7bf9aho3vyUGDVXBX0d877fD+LZfz732OF4AHzoIQHWFvGnxCMsXmDvxYl
	5JzQ==
X-Gm-Message-State: APjAAAUgh+HsPanW4a1B/I+3koebbmyo9VAPqp1DDgrFvI6xfO9lWfqR
	QV5gvU7CafGvDOLrUuSSvoTCmB0OHXE=
X-Google-Smtp-Source: APXvYqyMNgvbBEYx+3uVNU7LYC4oavZefnMdaApUV+dOWDeL37xyNzuM9/Y0+lR8n70UFind+BLZkg==
X-Received: by 2002:a63:1e5b:: with SMTP id p27mr33871719pgm.213.1557792359244;
	Mon, 13 May 2019 17:05:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.05.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:05:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:21 -0700
Message-Id: <20190514000540.4313-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::430
Subject: [Qemu-devel] [PULL 12/31] tcg/i386: Implement tcg_out_dupm_vec
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the same time, improve tcg_out_dupi_vec wrt broadcast
from the constant pool.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 57 +++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index f04933bc19..f4bd00e24f 100644
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


