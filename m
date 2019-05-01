Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528E6C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E40720866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGWQ3kPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E40720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhW2-0001Zf-6R
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:10:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRZ-0006YK-BT
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRV-0002ws-SE
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:09 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRV-0002vy-JS
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:05 -0400
Received: by mail-pf1-x442.google.com with SMTP id z26so4260165pfg.6
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Abtf7ymAcKqk+MfIJ4hNEtC4LePCgm1dY3zGf9JwmC8=;
	b=YGWQ3kPcRbB0RlOCGvzsguHvm5L1Q6I/PbfATDCENzuNEaUczoe7Tua1aWllbOFd2c
	9AywBqLFeOaxhppcyULRKbkiODOe3md/sjG8GJd3q6N3/uQp7CnABqGK+9c0wNEONuft
	bCGbJrP/HDw5w6N+Z/xnjeS72F1GDbKZ5LXgEI4tThm1QEGwNlJIPJKQ9ZtHntRrsN++
	zwM0jI8rOfSxzecY4xjz7b2GrJlju9VuB5INIpmf5ceBKZCCZG1Zs8vi+NsOMsZtlyl1
	t0pOV7MBa0UG9VRML9rdoqdJX31SVkO/zQ0/0Y2r/8mN1VsiLlWSLas0IeKgQ7SQBFA7
	A4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Abtf7ymAcKqk+MfIJ4hNEtC4LePCgm1dY3zGf9JwmC8=;
	b=ZISXSmxmDC+W6fglYyCpDGzfB5gUbeS9duLFc8zO5skPkNd/30F/5XSAo5yevtCRxs
	S1k7kLyczPBO30IWwhHdhc4DIYuQymp+cF1K1t0MuK6+jaL8XZNYhW55wan/LEAH4Uxd
	dvX0wgqAcuPpFBGUsx6ngmXIqcws4waI31uI/KQLjZqTxnqHtTBDE8zMmVEeuAsS7xXh
	Ur8DfY9KegXLjFj4+WD+vLETDdHg1LpD25T1tZSfL57sa3wxloaBwGRDrTnt2VDM0ofy
	TiFhCLeILvzC8VFy2UbZOv69iU+bpbUqy2DUjAao552Cay0NonC5OOCg0obLAEa0KIqt
	2fZg==
X-Gm-Message-State: APjAAAWutN3KokLUNAw5WBIdA+ULTfNbswz64If7Gm4yBKYVymCK8YJm
	NtbtakdJO4+CECt/cLh685mtIwbwEGw=
X-Google-Smtp-Source: APXvYqxYcF5spCGVOiOnVo4+i0WlHUwROXVDF0FZ6IXx6v/n4Kya21U/sKWREJw7NAS1wqMS2CftUg==
X-Received: by 2002:a63:6804:: with SMTP id d4mr72200013pgc.240.1556687163380; 
	Tue, 30 Apr 2019 22:06:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.06.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:23 -0700
Message-Id: <20190501050536.15580-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v2 16/29] tcg/aarch64: Support vector variable
 shift opcodes
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501050523.2ID-lpU0c5Qk1SGSAi--P319b2My5VJRSFAJaXXOBmU@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  2 +-
 tcg/aarch64/tcg-target.opc.h |  2 ++
 tcg/aarch64/tcg-target.inc.c | 42 ++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index ce2bb1f90b..f5640a229b 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -134,7 +134,7 @@ typedef enum {
 #define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
diff --git a/tcg/aarch64/tcg-target.opc.h b/tcg/aarch64/tcg-target.opc.h
index 4816a6c3d4..59e1d3f7f7 100644
--- a/tcg/aarch64/tcg-target.opc.h
+++ b/tcg/aarch64/tcg-target.opc.h
@@ -1,3 +1,5 @@
 /* Target-specific opcodes for host vector expansion.  These will be
    emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
    consider these to be UNSPEC with names.  */
+
+DEF(aa64_sshl_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 16381f5175..61c2dbbff2 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -538,12 +538,14 @@ typedef enum {
     I3616_CMEQ      = 0x2e208c00,
     I3616_SMAX      = 0x0e206400,
     I3616_SMIN      = 0x0e206c00,
+    I3616_SSHL      = 0x0e204400,
     I3616_SQADD     = 0x0e200c00,
     I3616_SQSUB     = 0x0e202c00,
     I3616_UMAX      = 0x2e206400,
     I3616_UMIN      = 0x2e206c00,
     I3616_UQADD     = 0x2e200c00,
     I3616_UQSUB     = 0x2e202c00,
+    I3616_USHL      = 0x2e204400,
 
     /* AdvSIMD two-reg misc.  */
     I3617_CMGT0     = 0x0e208800,
@@ -2258,6 +2260,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sari_vec:
         tcg_out_insn(s, 3614, SSHR, is_q, a0, a1, (16 << vece) - a2);
         break;
+    case INDEX_op_shlv_vec:
+        tcg_out_insn(s, 3616, USHL, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_aa64_sshl_vec:
+        tcg_out_insn(s, 3616, SSHL, is_q, vece, a0, a1, a2);
+        break;
     case INDEX_op_cmp_vec:
         {
             TCGCond cond = args[3];
@@ -2325,7 +2333,11 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
+    case INDEX_op_shlv_vec:
         return 1;
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+        return -1;
     case INDEX_op_mul_vec:
         return vece < MO_64;
 
@@ -2337,6 +2349,32 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
+    va_list va;
+    TCGv_vec v0, v1, v2, t1;
+
+    va_start(va, a0);
+    v0 = temp_tcgv_vec(arg_temp(a0));
+    v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+    v2 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+
+    switch (opc) {
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+        /* Right shifts are negative left shifts for AArch64.  */
+        t1 = tcg_temp_new_vec(type);
+        tcg_gen_neg_vec(vece, t1, v2);
+        opc = (opc == INDEX_op_shrv_vec
+               ? INDEX_op_shlv_vec : INDEX_op_aa64_sshl_vec);
+        vec_gen_3(opc, type, vece, tcgv_vec_arg(v0),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
+        tcg_temp_free_vec(t1);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    va_end(va);
 }
 
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
@@ -2518,6 +2556,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+    case INDEX_op_aa64_sshl_vec:
         return &w_w_w;
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
-- 
2.17.1


