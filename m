Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DA0C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F1520872
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHVMKSlA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F1520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37591 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4ez-0003zI-Kr
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:06:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dB-0002lS-7f
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4b4-0002jK-5B
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:19 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4b2-0002hv-3m
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:17 -0400
Received: by mail-pf1-x444.google.com with SMTP id v80so5259888pfa.3
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=2Z/xMZNbQQoNoZQShCqBViE6D5UwKBhH3tq+yJTAfz4=;
	b=SHVMKSlAm8YY9ESIqjMGZia8cRwr3363o57U/3uAfbatVFlhJLlx8pqzt7ynOMBp7A
	m4CiWEwVrQ6bQUPH12TBqjsE6GZbIQvqxBM9ziC2lzahrUREbSXdsYw8o3tU8tJyACoS
	d1tByaWRjzHeTsr5SKs7xnvxcT06T4K0Qro51hfvWC2ry3OUek6MdzACEJSGfUKpnm9Q
	JoKuptpsb0lwENFPTWLBPi4e4qtF1oDZaLIeBoitZ6bTBJsLxLOiZ30zjOZvqlAfziA6
	bYT83o9KwvgIPCiYjGsGFPGHZdkiPYfqQ5fBKTQ3OJB9E0vt3CVSIn4lZkqxDk/oa6a6
	PTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=2Z/xMZNbQQoNoZQShCqBViE6D5UwKBhH3tq+yJTAfz4=;
	b=hMcg6hXu1rH9oH42vHrGbelGD6GFwoJIa8PTzSOWLMQCLeHKpGySBodq3wDW5T5NCP
	2YRTQ2WDWE0AtQDoPSNNDoOKeXdTbEeRDTHaWWNIM976HkV+lRhgfKy9mlXe4pU01TDS
	4vHv42tWQv5mu4AJ07xeWq5cVHuiQNID31nwrZ5c1Q2t26PFecU+GoVceojOt3GTrn7r
	ni+C+VDXsWbaEqOaEWLuqp0fOgYjqErVyTQ33jYQEfzHdQ+vnwZwBJtwuCS1o8o4KlZ2
	j+/3EVsBf8wNESCCxa1LGpndugCjNJhTMwSLe5iMiQIL7zqGVSr/a+mFM7mf/vEnDsVn
	NiVQ==
X-Gm-Message-State: APjAAAXtEgeVzO97ITT2fjLNwTRtQsU/MpoHSxOYUMBt8mlLNL6wfLJJ
	ELQWT7QZkjz0C3TAR3eS69tKkEZuToY=
X-Google-Smtp-Source: APXvYqwB0P5y20DjUa71qneTcQGLHvEtiqkowjlaTrbiQyGPnXEsMTPDhz6ZaQzOmSwSYdKu0rii5Q==
X-Received: by 2002:a62:ea0a:: with SMTP id t10mr69243715pfh.236.1558206134214;
	Sat, 18 May 2019 12:02:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.02.13
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:02:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:52 -0700
Message-Id: <20190518190157.21255-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518190157.21255-1-richard.henderson@linaro.org>
References: <20190518190157.21255-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 11/16] tcg/aarch64: Support vector bitwise
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


