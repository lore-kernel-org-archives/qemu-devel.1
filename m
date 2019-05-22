Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB06C282DD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C9F21773
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8ibIvSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C9F21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52685 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZw8-0004aD-6B
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:42:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj5-0003Ag-C4
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj3-0007S1-Uv
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:47 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:43923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZj3-0007N7-NZ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:45 -0400
Received: by mail-yb1-xb44.google.com with SMTP id n145so1485279ybg.10
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=2Z/xMZNbQQoNoZQShCqBViE6D5UwKBhH3tq+yJTAfz4=;
	b=K8ibIvSsLExOpQP8f2EyNiW9rB0tAJOSnxMoHymryzxrogsVcFvfWN7WY4P525e0rO
	+noSVh7PhvCGcYSINq7qkjKi4VI/wIyjYMxr9pDHrs4ao6Zpmmfthxyo2RYSm2nayCRN
	KSO658o+bzBrLxDRDvwWMKVloyGIBJk7qEY9boTgmenY6NbSb8EzWZRJTD826tpei885
	Sd5eURlJyr2w81YEp8/OGjr6H7JYsXPi+7n+6csEv13Nge4nTkJV7wjM7s9pp7BXd+Cs
	Yg3GAMQEoPvCxVGOYL5211IDdE7OUcBra0s8c+HXi6AUggOpNwXELustTE9eIyh++oEQ
	HfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=2Z/xMZNbQQoNoZQShCqBViE6D5UwKBhH3tq+yJTAfz4=;
	b=AiKG1Gm9hLvffRWy+XUIdlpQkwsfYaS5mQHZaX6IHKMDz938mQgSFLS12iVCOB8d2j
	K3/L9YM+uEPYCsNuI6TQwGb+W7/OLU9IXHeIaoLhYBWkjixyDbFYdW6SpDrrxcw0ojaA
	uiyk/0cwpSYYpmHdZCW1VuEbj4Enf0pHFm32JzkBmU1QidSGjN7jVEzMuvd6eD1o1kQv
	T+yiraaUAYcv0FpD5xIX5Fi6wyljrBPmL8aXmrqAih8yTP7hWjKHFkPEuukEJrHc3Wg7
	EBFK6OXGBFglMP1z+DJJ+fEKn56xuEAk7jo90xImJAQjX1VTAjvL0FEnDQhSp78dI8lZ
	scow==
X-Gm-Message-State: APjAAAWJGvlGMeuakNVKuBr7YLLyMZBi46DfykgTsDL67q7EUaMfD3OD
	TppXeFyYVcqp1x2l/AsVyVVofwadGbA=
X-Google-Smtp-Source: APXvYqwqng9tgWhO73AathvmZKP1+gCstXTrQ3RvjParmmkDJQWKhWXnZfIKdhGS0Z8dJRqi6/LlDQ==
X-Received: by 2002:a25:6889:: with SMTP id d131mr9553981ybc.211.1558564115845;
	Wed, 22 May 2019 15:28:35 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:16 -0400
Message-Id: <20190522222821.23850-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [PULL 11/16] tcg/aarch64: Support vector bitwise
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
index b4a9d36bbc..ca214f6909 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -140,7 +140,7 @@ typedef enum {
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       1
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
 #define TCG_TARGET_DEFAULT_MO (0)
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 40bf35079a..e99149cda7 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -523,6 +523,9 @@ typedef enum {
     I3616_ADD       = 0x0e208400,
     I3616_AND       = 0x0e201c00,
     I3616_BIC       = 0x0e601c00,
+    I3616_BIF       = 0x2ee01c00,
+    I3616_BIT       = 0x2ea01c00,
+    I3616_BSL       = 0x2e601c00,
     I3616_EOR       = 0x2e201c00,
     I3616_MUL       = 0x0e209c00,
     I3616_ORR       = 0x0ea01c00,
@@ -2181,7 +2184,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 
     TCGType type = vecl + TCG_TYPE_V64;
     unsigned is_q = vecl;
-    TCGArg a0, a1, a2;
+    TCGArg a0, a1, a2, a3;
 
     a0 = args[0];
     a1 = args[1];
@@ -2304,6 +2307,20 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_bitsel_vec:
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
@@ -2334,6 +2351,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
     case INDEX_op_shlv_vec:
+    case INDEX_op_bitsel_vec:
         return 1;
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
@@ -2408,6 +2426,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "rA", "rZ", "rZ" } };
     static const TCGTargetOpDef add2
         = { .args_ct_str = { "r", "r", "rZ", "rZ", "rA", "rMZ" } };
+    static const TCGTargetOpDef w_w_w_w
+        = { .args_ct_str = { "w", "w", "w", "w" } };
 
     switch (op) {
     case INDEX_op_goto_ptr:
@@ -2580,6 +2600,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &w_wr;
     case INDEX_op_cmp_vec:
         return &w_w_wZ;
+    case INDEX_op_bitsel_vec:
+        return &w_w_w_w;
 
     default:
         return NULL;
-- 
2.17.1


