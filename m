Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAFCC38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066CA20776
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBH+tZhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066CA20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59687 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPqHY-0004c9-69
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 12:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBr-0004Lz-B9
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBq-0005T5-1C
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:35 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPqBp-0005Qb-Rl
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:33 -0400
Received: by mail-pg1-x542.google.com with SMTP id d17so2773372pgo.0
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kclyvX98JRyE2ZEPw+1FzvyDeiJrVyjendlYPY0jgDw=;
 b=HBH+tZhOTz/WAgvIXbrTM8pILG21icBtXOkoX6OXvCiZ3Dd1sjUSww20BHi7BI2jJO
 sZ5jANC5aYN/vMOGSkq+r5f7a044cgkbM5QhZ6WBo4clywVJNsa2W758BB1uEKKZo/5h
 GJdeax6CLy4uEGoCzLQw6zDwH+pLIXsFVHBhRw5LNFVuD8VWNRfxbMz3yimYqaJ6xmWs
 IzU6yWPVYScbXiuOotWpgVuF+rmqhMxmsUcGxD9XOaWOYd137OZKKsSCBGNuPYKNLC4J
 DD6JegWBBeBAMdUmFf23MPTlSDGgZcwY7Ouybu6Fem9VW1DMf1RcfX+QlCaE+E0WiA28
 7C6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kclyvX98JRyE2ZEPw+1FzvyDeiJrVyjendlYPY0jgDw=;
 b=jRuTUI8lEmZzetGobJdLMP7cPHjdKV6gYU5eytOc2YxrMHdA+G3/sawfgTmZNG5w8w
 vUxGO8EkXc7u6y9dOERqbTyGdnPTCQbN5J4RHvZnfugXi47GylLJcTt6SSBnQQmhn/Ts
 Zr3Z0+Et7AfrHp2x/SZZNrgBSz5fQeMzBpsV5xQ3z5xcvqxZF9cHQdaNoSTNxUrCKY+n
 VpqXh8ud01YcZvV1c+YfkfFOWXS3NZcV/QvHBXfHcgKApCtVdvHT1lrK/BVInn3FM185
 gk1caCUDrGRS4iLup76Wete9MU0JfMrb3b2OhM73cxKIK1QvWH3qkmVY5jaoxIV5OJux
 Hg3g==
X-Gm-Message-State: AGi0PuYg1ucSmvHJ+0HYqi0jAdI2/Oi4iRYyDyGXTv+EsMntsZ1HlZEw
 F8Ux00Z15FjF4w6LFO5Cn/tdQJjojBo=
X-Google-Smtp-Source: APiQypLtiRqZ9ENkxc/0xP3XIH6YV+IXSrQ2khBx8CSgFtrrLLO+2pEb4Ahc9zu0BY6y8t/R1CAP4g==
X-Received: by 2002:a62:8001:: with SMTP id j1mr8922341pfd.202.1587226772430; 
 Sat, 18 Apr 2020 09:19:32 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i187sm22398382pfc.112.2020.04.18.09.19.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 09:19:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/16] tcg: Use tcg_out_dupi_vec from temp_load
Date: Sat, 18 Apr 2020 09:19:10 -0700
Message-Id: <20200418161914.4387-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418161914.4387-1-richard.henderson@linaro.org>
References: <20200418161914.4387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Having dupi pass though movi is confusing and arguably wrong.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c |  7 ----
 tcg/i386/tcg-target.inc.c    | 63 ++++++++++++++++++++++++------------
 tcg/ppc/tcg-target.inc.c     |  6 ----
 tcg/tcg.c                    |  8 ++++-
 4 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 7918aeb9d5..e5c9ab70a9 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1009,13 +1009,6 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
     case TCG_TYPE_I64:
         tcg_debug_assert(rd < 32);
         break;
-
-    case TCG_TYPE_V64:
-    case TCG_TYPE_V128:
-        tcg_debug_assert(rd >= 32);
-        tcg_out_dupi_vec(s, type, rd, value);
-        return;
-
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 320a4bddd1..07424f7ef9 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -977,30 +977,32 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
     }
 }
 
-static void tcg_out_movi(TCGContext *s, TCGType type,
-                         TCGReg ret, tcg_target_long arg)
+static void tcg_out_movi_vec(TCGContext *s, TCGType type,
+                             TCGReg ret, tcg_target_long arg)
+{
+    if (arg == 0) {
+        tcg_out_vex_modrm(s, OPC_PXOR, ret, ret, ret);
+        return;
+    }
+    if (arg == -1) {
+        tcg_out_vex_modrm(s, OPC_PCMPEQB, ret, ret, ret);
+        return;
+    }
+
+    int rexw = (type == TCG_TYPE_I32 ? 0 : P_REXW);
+    tcg_out_vex_modrm_pool(s, OPC_MOVD_VyEy + rexw, ret);
+    if (TCG_TARGET_REG_BITS == 64) {
+        new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
+    } else {
+        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
+    }
+}
+
+static void tcg_out_movi_int(TCGContext *s, TCGType type,
+                             TCGReg ret, tcg_target_long arg)
 {
     tcg_target_long diff;
 
-    switch (type) {
-    case TCG_TYPE_I32:
-#if TCG_TARGET_REG_BITS == 64
-    case TCG_TYPE_I64:
-#endif
-        if (ret < 16) {
-            break;
-        }
-        /* fallthru */
-    case TCG_TYPE_V64:
-    case TCG_TYPE_V128:
-    case TCG_TYPE_V256:
-        tcg_debug_assert(ret >= 16);
-        tcg_out_dupi_vec(s, type, ret, arg);
-        return;
-    default:
-        g_assert_not_reached();
-    }
-
     if (arg == 0) {
         tgen_arithr(s, ARITH_XOR, ret, ret);
         return;
@@ -1029,6 +1031,25 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     tcg_out64(s, arg);
 }
 
+static void tcg_out_movi(TCGContext *s, TCGType type,
+                         TCGReg ret, tcg_target_long arg)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+#if TCG_TARGET_REG_BITS == 64
+    case TCG_TYPE_I64:
+#endif
+        if (ret < 16) {
+            tcg_out_movi_int(s, type, ret, arg);
+        } else {
+            tcg_out_movi_vec(s, type, ret, arg);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static inline void tcg_out_pushi(TCGContext *s, tcg_target_long val)
 {
     if (val == (int8_t)val) {
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index fb390ad978..7ab1e32064 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -987,12 +987,6 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
         tcg_out_movi_int(s, type, ret, arg, false);
         break;
 
-    case TCG_TYPE_V64:
-    case TCG_TYPE_V128:
-        tcg_debug_assert(ret >= TCG_REG_V0);
-        tcg_out_dupi_vec(s, type, ret, arg);
-        break;
-
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index adb71f16ae..4f1ed1d2fe 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3359,7 +3359,13 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
     case TEMP_VAL_CONST:
         reg = tcg_reg_alloc(s, desired_regs, allocated_regs,
                             preferred_regs, ts->indirect_base);
-        tcg_out_movi(s, ts->type, reg, ts->val);
+        if (ts->type <= TCG_TYPE_I64) {
+            tcg_out_movi(s, ts->type, reg, ts->val);
+        } else if (TCG_TARGET_REG_BITS == 64) {
+            tcg_out_dupi_vec(s, ts->type, reg, ts->val);
+        } else {
+            tcg_out_dupi_vec(s, ts->type, reg, dup_const(MO_32, ts->val));
+        }
         ts->mem_coherent = 0;
         break;
     case TEMP_VAL_MEM:
-- 
2.20.1


