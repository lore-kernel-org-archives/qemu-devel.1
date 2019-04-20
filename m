Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BC8C282E2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 08:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20DEA2087F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 08:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZKcgEtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DEA2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38519 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHl11-0001De-Ad
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 04:06:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXY-00012z-Rb
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXW-0000nL-Ft
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:00 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXW-0000Do-6g
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:58 -0400
Received: by mail-pf1-x442.google.com with SMTP id i17so3465924pfo.6
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=DFRXZD7NX2YzkScQMMhpfUbyNqz4uR3r+/iPuMUtZlg=;
	b=nZKcgEtqvIgJ6O+Fo0xRG00kc2v8zY51aZI/2Cjkhrs7zUZfhIcNnMDYUvG78zHPpS
	6Aiddva4aNAKYnlcM2US7RYifgBCz8mDGjq4BTfZAL5Ed6r+supMHNwK9FesTN0I/5FJ
	9g0uHQn7u6N8YD8uTm8whgK3rS2DADJqlGHRzBqs9tGPuZ85Nv1AQNqX1iA6OYkQAvUk
	7c73Zer84KtBCmXAlFqxWpF8EsDIjzTn2IS2qzPQNr+tjlKzQKX2HlJb/8N9qSynZlNP
	7R2b5YrwOVRCJQPJL2Rs2TNJQQzS1g65CGk944vhCov2n7sntJS6vBE/WzckO5XQQa4x
	X2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=DFRXZD7NX2YzkScQMMhpfUbyNqz4uR3r+/iPuMUtZlg=;
	b=OYJozarnIn+smp09jIOwljeaYXiI8UuWZ95IbFWRZb25D2mCnw2IEjUgZqZJd9hWmq
	Soa7TvX1qQPsR0YvNU7sRa3XZePm8DKCEqyKZBBfkZkv/Rz8IwsRotfQoXV2ceQW97PX
	K/hYfPuWlyLwJDVIwV+Et5UITcMB0pE5s1+31VcbozO/e4G+bwIlEMwkO8WW0ru2XeM5
	Mvd0tZuJui6fzcV0FokHLsVW/RNdP5clCSlnaRYtTxPvy4tFKimPeatgNlHtWfBjHkLz
	b7QLtsiavp4Mk8iUe1E2BqKNsnG74tXmLqsNurSgk5H1qcr6k3PnxetJ/b9vHtEZGzd6
	WtQg==
X-Gm-Message-State: APjAAAU7Xv/QspYa8Ls3fHojCgso82FgTjcY5dp5liUfC2narpDFl+MO
	mPlK9La7i03hEZxoolZjIMUsFLNXldI=
X-Google-Smtp-Source: APXvYqyYk5vsB6jkCmlKEqH5nt58W0TrYuck8e3hcjJz8nbB6haUaZy3Yo8jGlWu6VRv/WtTZRC3yw==
X-Received: by 2002:a65:5202:: with SMTP id o2mr8032976pgp.402.1555745733492; 
	Sat, 20 Apr 2019 00:35:33 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:34 -1000
Message-Id: <20190420073442.7488-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 30/38] tcg/aarch64: Support vector comparison
 select value
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
Message-ID: <20190420073434.CZ_OsIrkn8Gs2POmtxmiuL1ropyTjsqrAS3ziCW65_4@z>

The instruction set has 3 insns that perform the same operation,
only varying in which operand must overlap the destination.  We
can represent the operation without overlap and choose based on
the operands seen.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  2 +-
 tcg/aarch64/tcg-target.inc.c | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index e1135e930a..e030bf3c8f 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -140,7 +140,7 @@ typedef enum {
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       1
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index cf891defd4..84d402acd8 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -525,6 +525,9 @@ typedef enum {
     I3616_ADD       = 0x0e208400,
     I3616_AND       = 0x0e201c00,
     I3616_BIC       = 0x0e601c00,
+    I3616_BIF       = 0x2ee01c00,
+    I3616_BIT       = 0x2ea01c00,
+    I3616_BSL       = 0x2e601c00,
     I3616_EOR       = 0x2e201c00,
     I3616_MUL       = 0x0e209c00,
     I3616_ORR       = 0x0ea01c00,
@@ -2178,7 +2181,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 
     TCGType type = vecl + TCG_TYPE_V64;
     unsigned is_q = vecl;
-    TCGArg a0, a1, a2;
+    TCGArg a0, a1, a2, a3;
 
     a0 = args[0];
     a1 = args[1];
@@ -2301,6 +2304,20 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_cmpsel_vec:
+        a3 = args[3];
+        if (a0 == a3) {
+            tcg_out_insn(s, 3616, BIT, is_q, 0, a0, a2, a1);
+        } else if (a0 == a2) {
+            tcg_out_insn(s, 3616, BIF, is_q, 0, a0, a3, a1);
+        } else {
+            if (a0 != a1) {
+                tcg_out_mov(s, type, a0, a1);
+            }
+            tcg_out_insn(s, 3616, BSL, is_q, 0, a0, a2, a3);
+        }
+        break;
+
     case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
@@ -2323,6 +2340,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_abs_vec:
     case INDEX_op_not_vec:
     case INDEX_op_cmp_vec:
+    case INDEX_op_cmpsel_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
@@ -2405,6 +2423,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "rA", "rZ", "rZ" } };
     static const TCGTargetOpDef add2
         = { .args_ct_str = { "r", "r", "rZ", "rZ", "rA", "rMZ" } };
+    static const TCGTargetOpDef w_w_w_w
+        = { .args_ct_str = { "w", "w", "w", "w" } };
 
     switch (op) {
     case INDEX_op_goto_ptr:
@@ -2577,6 +2597,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &w_wr;
     case INDEX_op_cmp_vec:
         return &w_w_wZ;
+    case INDEX_op_cmpsel_vec:
+        return &w_w_w_w;
 
     default:
         return NULL;
-- 
2.17.1


