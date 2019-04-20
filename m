Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947C2C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016AB21479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wzh4i7e6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016AB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38216 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkh6-0000u7-Vg
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:45:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWk-00007Q-HC
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWj-00087V-ED
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:10 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWj-000860-8P
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:09 -0400
Received: by mail-pg1-x544.google.com with SMTP id e6so3598420pgc.4
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=qpLX9/DZZjJ+dprrH7G5JtH5NDJNPfgeQACEO5dLGO4=;
	b=Wzh4i7e6wasaoAYEAuOIkKNakbRfglvN8V46qqGkc1f7+9VMDOlCGJAm6CUYcagGms
	fy9RPIYB9E97bWJMOcFZtj2jKTzgZSKDBbigljJYHEBglXCq/PTZn/bcKZuyq0FZXvzi
	Q2XlSY/o8UlFl4bkq9+qVShsWdxc+ZmMKMw5udnAk+j3aBs/0Y5SvAE0L92pJQzryn8g
	3Fhjw1KIERJyWnZvGBl9LqaAs+uTGb1jyiIlrdiCVeEYQe4xi7we6zBLSeHyNYXJW0q6
	7qQ/kq6yp06IeQWL2NWxCboWfgcS7Mp9szR9D/2V4HycZbgjJ+85Np+OohdXcrLzMpMk
	6zAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=qpLX9/DZZjJ+dprrH7G5JtH5NDJNPfgeQACEO5dLGO4=;
	b=dk0BzTGgUkdCG9PIRLt2itp2LO6TOg3Pso+E5vB3z5nygpkQEu5uVzmVH9e5iWaYO2
	8r7rg9i4HHIGMa/PrOaAWBT3tTym2ajUUu+GOIcmkbWjaS23HBG75AgMpJHtH9DJMoxO
	0kqLWtXBXnkMOKtTdkVQBwUSikEEQcT4PFm8goZSJmUKcMORZ8iuffL7sssrhaIotP1z
	mo6sfdEN597zvdyC2GMCleqMdw1I9+azY/tbxC6q+UOhrAaxj2KmH7GPjLrr37Y5Qt2W
	xavoXgbWQKOsHkCs7fNgafPUN8NPVJKZnPHdu0nA3XtZmgyUHl+yM7J2AIdTTIIF+lnL
	dfmA==
X-Gm-Message-State: APjAAAWm6Nw8SYGfb8rNU2JNote++0riet3tH6hhMDa80v/b5qWdD3gL
	fTx9Co5hTBMyFHiDn3rAVtkhODkXaxk=
X-Google-Smtp-Source: APXvYqxzdEW0oIUcPI/kzYPx3dvhDZbPTW3lg0zch4Q5y0zA96go4bQRye20KaKa9THwL3aU2Nmc4g==
X-Received: by 2002:a62:2046:: with SMTP id g67mr8260862pfg.121.1555745707925; 
	Sat, 20 Apr 2019 00:35:07 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:18 -1000
Message-Id: <20190420073442.7488-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 14/38] tcg/aarch64: Support vector variable
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073418.vLdI72buS_nXdWrElUKUWxRli1ZwQ8yQGDmS3a3Y_fg@z>

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
index 1c9f4b0cb3..7d2a8213ec 100644
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
@@ -2254,6 +2256,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -2321,7 +2329,11 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
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
 
@@ -2333,6 +2345,32 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
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
@@ -2514,6 +2552,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
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


