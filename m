Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE09C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA46C206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLU4bjck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA46C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51888 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnvj-0000xX-Vu
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:13:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbx-0007tk-8W
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbw-0004Ll-2K
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:25 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbv-0004LP-SX
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:24 -0400
Received: by mail-pl1-x642.google.com with SMTP id l2so3719837plt.11
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=prTUAzbPvH5wKS0jiTGzjhMb0GdRc5cNbrE395D55Ho=;
	b=ZLU4bjckbQeC31yKp3kZ8VboXHVOeg91xZNS7IyIckWkh/3tU3LgfQhYL/6EAdzwuh
	DZcdHvt3fGCWRyskTvAU32szKgFwF7PYdn0zOn15cKtSyAxadEeSV17zwG8Cstk1AY8L
	dAqLX22o6qrfyrsYX6nbbkueHai07+TDEXUQUfmQCJyBQXeGcuBugyggPqxoJi6oMZw0
	dFO9H/skJ27qoorh01A6w1Tp3Adkza8lYkvC1LRHrj3ZjnTXUy8xgDBfJnjaSjgKG8qg
	lis+pkRXQMS8mGbhd+S1Q6UCKsRlyOe0xi6NMmhwqH+L7rxNdgT/d3N80TA1zHcFhH0r
	QNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=prTUAzbPvH5wKS0jiTGzjhMb0GdRc5cNbrE395D55Ho=;
	b=aq8jddUQOzOoWL3clSRBKAk2dkG5Z2f3c+7xNcPZuyzZWJNyK+PcDzcC5ywe2qzqZx
	2p13wF9HOmYhvLsAQVzTK1Z1t8wVH2V0YN6yLfDngCJsE9YrtcQ6Ggt7kuvCEMiOYme9
	2nGm8SleNO/Yk92UtMaJiNOe3+2a/X9U2+gPd+hFy/er+SZDE9Mc7BbGq7C5UTM4ocrx
	yPFvZkTLYx8R8213ApYxMvE11ZRx4V8em0PFvXrmjHxELiSZHdFdRE+eQhopTzdTMEYm
	xHMJ9ZJeFSTAs63z57dqbZ8ow1TnkBEEDunzKigUO8HapU0ThbGuRF2KW5DdlpA4jlb7
	scPQ==
X-Gm-Message-State: APjAAAVeK412XuFKEl4dHFXPnfh4RG4K4H1DTT5LtP0SIqkVY2dEY8XK
	pfKfpaF4LKwIuqUtdSmis39YtrntFRY=
X-Google-Smtp-Source: APXvYqwDojzeoRKjicslUEtHNbE2HfIiqr9Pqm/1+XAEkA4O4R1wF22I5Zfizy5FNCj2xBb/bFedrQ==
X-Received: by 2002:a17:902:9884:: with SMTP id
	s4mr16702915plp.179.1556949202675; 
	Fri, 03 May 2019 22:53:22 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:46 -0700
Message-Id: <20190504055300.18426-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v3 17/31] tcg/aarch64: Support vector variable
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504055246.P5Vh2GeWLHV1HOtcGZWmnBenrrivLyPOIYg83AufPJE@z>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
index 15ab35adf7..7d842cad47 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -536,12 +536,14 @@ typedef enum {
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
@@ -2256,6 +2258,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -2323,7 +2331,11 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
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
 
@@ -2335,6 +2347,32 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
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
@@ -2516,6 +2554,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
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


