Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430D8C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BF020675
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHcom7lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BF020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnp1-0001WL-3W
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:06:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbr-0007nN-C5
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbq-0004Hf-8l
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:19 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbq-0004F5-2e
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:18 -0400
Received: by mail-pl1-x643.google.com with SMTP id z8so3737565pln.4
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=4qREfMgDOvDIZnxD8mHxrlGbKtAgS56ZNj2GB4ImDXs=;
	b=uHcom7lbdbAHTa7Uh7NSEvhxxrGz9AHCDKPqv2B7ogzinWA2Ru5bFDpWi6WhqoJvNH
	F6guMw0RH+pFbWjjmSTU5vFsxsA5BbfMOTfBKou+roZoBePMfjiejkVxK7h0Mrskje4d
	uZ3G9/LD3omJ/E01aup2gVXOnBG1bF1r6lSH+HZNNZtylFg5V/vTOjFWxFAQyFVdpS+S
	wmKOSlM8dSC4f7Sy8O4efZ9RLBrM0SeszcMdEJnanyahFUaXBxGqq74iwAQsoZatU7+Y
	023QXn+FvWZjN0ni7ajX1Fqwsm9J9psSerupuOWKYzAKTQA8gUfgEmxH34DA8rJS64j+
	iUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=4qREfMgDOvDIZnxD8mHxrlGbKtAgS56ZNj2GB4ImDXs=;
	b=D6FKE7IcHiV1F0CCDeWz3GgMjXIbOVAlu43+M2L+hf++gZOu44be4jJNSNcwDQExua
	z8ecfJpYpusWXOk2Iqn68fHWSO4cfuvjVgamtgRzl03LENDVTgFkeBB8xbu5DvZ+EArb
	HV87xgZGIwIESyfjbYoXncKfrh2Z4otb6YHbK4bcfZRi0WwnSLSPym5+Af5F0tHTttcH
	3KXZdlRWX41wxFBrtGCbFDX3RIWomxQ/vgq+j9bAGHkgpMu3v4hP9o/nUWZ72MRQxZFL
	MJZQXq8EYTz2vb5uBRldc7aK7WDSQ1OL6PGRMz8MMv1YwYUF35j6oH5o1W04s9mYXORj
	RrJQ==
X-Gm-Message-State: APjAAAXjsIGsgswlMmUh6gBhLkHTsgzWhvAAVOrJG9XltcMbwRiRnlA0
	4zAkqlzsn6Ov4gW/BR73lXC9yNLBj9U=
X-Google-Smtp-Source: APXvYqw5hcWA4hzYx6Qh/odviPSA2cAk1pjC9Pe26TtNzMuHq9xREEnzDWWKbLfXYUAg8p3Ho0Gnng==
X-Received: by 2002:a17:902:7590:: with SMTP id
	j16mr16519061pll.296.1556949196878; 
	Fri, 03 May 2019 22:53:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:41 -0700
Message-Id: <20190504055300.18426-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v3 12/31] tcg/i386: Implement tcg_out_dupm_vec
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504055241.GGu_9BmMGekr0dA_YYgeo8elM92Iov_t679i4nHc8LU@z>

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


