Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD115C38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93AB20776
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yfoibbcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93AB20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPqJk-00084N-SJ
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 12:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBl-0004Am-E3
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBk-0005CH-38
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:29 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPqBj-00059k-Tc
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:28 -0400
Received: by mail-pf1-x442.google.com with SMTP id r14so2701293pfg.2
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=g8/p+PUrUK9+1D4LpE0xAeSYjcuN7ROr/u3zdSbPNQc=;
 b=yfoibbcJtsv9Ht7WzNfYGiVy9K50wZK8X9+bAtkN9qltdtoqfWfKl/TaRRbDAMC5zn
 se9HPkwpV8fe6BAqrtEXFkw3E/BwHcImYj/Yn3+sZVqeOtlQv4Dcnenkt22RNhUD+jto
 7kE+M+NOsIqaITUXvRmowlumPvy0NmU8DviqZ/fAThRRzUq/TG+x/VkZqECfXJepmoFM
 i76lyrtQtv+rLOsLl3j74GPs69rlP4jWi5m9qTTBFO3xNQE5a/JWeGzABrCGW6gPyt5d
 ASzTItYvAw+BmMGGf43lvvb25NbJkvbFRtMZ4LMehk1fQ/LqN3gbA4EA5Q8WyzxeTHkx
 0O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g8/p+PUrUK9+1D4LpE0xAeSYjcuN7ROr/u3zdSbPNQc=;
 b=V+QWk/bNUCTzZUMqboJO+eH8buL/nZqpbUlSt1kGQKhOxOiGafAiQtxZdpHlQ0RnUv
 9Hb1Wr0o6rbf17x+U93Ark4KR3mpAvPo8loDtkA2sNfN0OmSR7K6yppv0aRo0JmUak0b
 PylrEl9q4gxccIgYmkCBqOP/k8URCT1YPnGMajfmYvNvi+tbEXCaKY7lOxk+tohDgp+D
 ltAA41jPgF8/PJAeasfpXrSLWgie8+bWvlQP816VFWv4D66gdXeZDbfTNn3aJFip56Bb
 1QwnoxorXGy1ZYhLp0klZF8kHcHoxRRrOF0c0nB7P483x41OU3obAr+kwcatMDEEqiNs
 biKA==
X-Gm-Message-State: AGi0PuYkt3wR16LXi+Xni6dwohQyqhdEYCyUMirZg740pZSXWzdgPu1b
 IRLbaRYUR4d2R3WK1LiZTVAWRSNi4sk=
X-Google-Smtp-Source: APiQypKtv2zEPHjKxrndHFc1fvbtRuAKx0OhBM8MegPqZ5NMIHkcUdOwY7UDSjnGFMicUqL2P3PTDw==
X-Received: by 2002:a63:c6:: with SMTP id 189mr1711357pga.239.1587226765918;
 Sat, 18 Apr 2020 09:19:25 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i187sm22398382pfc.112.2020.04.18.09.19.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 09:19:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/16] tcg: Rename struct tcg_temp_info to TempOptInfo
Date: Sat, 18 Apr 2020 09:19:05 -0700
Message-Id: <20200418161914.4387-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418161914.4387-1-richard.henderson@linaro.org>
References: <20200418161914.4387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

Fix this name vs our coding style.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index effb47eefd..b86bf3d707 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -35,20 +35,20 @@
         glue(glue(case INDEX_op_, x), _i64):    \
         glue(glue(case INDEX_op_, x), _vec)
 
-struct tcg_temp_info {
+typedef struct TempOptInfo {
     bool is_const;
     TCGTemp *prev_copy;
     TCGTemp *next_copy;
     tcg_target_ulong val;
     tcg_target_ulong mask;
-};
+} TempOptInfo;
 
-static inline struct tcg_temp_info *ts_info(TCGTemp *ts)
+static inline TempOptInfo *ts_info(TCGTemp *ts)
 {
     return ts->state_ptr;
 }
 
-static inline struct tcg_temp_info *arg_info(TCGArg arg)
+static inline TempOptInfo *arg_info(TCGArg arg)
 {
     return ts_info(arg_temp(arg));
 }
@@ -71,9 +71,9 @@ static inline bool ts_is_copy(TCGTemp *ts)
 /* Reset TEMP's state, possibly removing the temp for the list of copies.  */
 static void reset_ts(TCGTemp *ts)
 {
-    struct tcg_temp_info *ti = ts_info(ts);
-    struct tcg_temp_info *pi = ts_info(ti->prev_copy);
-    struct tcg_temp_info *ni = ts_info(ti->next_copy);
+    TempOptInfo *ti = ts_info(ts);
+    TempOptInfo *pi = ts_info(ti->prev_copy);
+    TempOptInfo *ni = ts_info(ti->next_copy);
 
     ni->prev_copy = ti->prev_copy;
     pi->next_copy = ti->next_copy;
@@ -89,12 +89,12 @@ static void reset_temp(TCGArg arg)
 }
 
 /* Initialize and activate a temporary.  */
-static void init_ts_info(struct tcg_temp_info *infos,
+static void init_ts_info(TempOptInfo *infos,
                          TCGTempSet *temps_used, TCGTemp *ts)
 {
     size_t idx = temp_idx(ts);
     if (!test_bit(idx, temps_used->l)) {
-        struct tcg_temp_info *ti = &infos[idx];
+        TempOptInfo *ti = &infos[idx];
 
         ts->state_ptr = ti;
         ti->next_copy = ts;
@@ -114,7 +114,7 @@ static void init_ts_info(struct tcg_temp_info *infos,
     }
 }
 
-static void init_arg_info(struct tcg_temp_info *infos,
+static void init_arg_info(TempOptInfo *infos,
                           TCGTempSet *temps_used, TCGArg arg)
 {
     init_ts_info(infos, temps_used, arg_temp(arg));
@@ -177,7 +177,7 @@ static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg val)
     const TCGOpDef *def;
     TCGOpcode new_op;
     tcg_target_ulong mask;
-    struct tcg_temp_info *di = arg_info(dst);
+    TempOptInfo *di = arg_info(dst);
 
     def = &tcg_op_defs[op->opc];
     if (def->flags & TCG_OPF_VECTOR) {
@@ -208,8 +208,8 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg src)
     TCGTemp *dst_ts = arg_temp(dst);
     TCGTemp *src_ts = arg_temp(src);
     const TCGOpDef *def;
-    struct tcg_temp_info *di;
-    struct tcg_temp_info *si;
+    TempOptInfo *di;
+    TempOptInfo *si;
     tcg_target_ulong mask;
     TCGOpcode new_op;
 
@@ -242,7 +242,7 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg src)
     di->mask = mask;
 
     if (src_ts->type == dst_ts->type) {
-        struct tcg_temp_info *ni = ts_info(si->next_copy);
+        TempOptInfo *ni = ts_info(si->next_copy);
 
         di->next_copy = si->next_copy;
         di->prev_copy = src_ts;
@@ -605,7 +605,7 @@ void tcg_optimize(TCGContext *s)
 {
     int nb_temps, nb_globals;
     TCGOp *op, *op_next, *prev_mb = NULL;
-    struct tcg_temp_info *infos;
+    TempOptInfo *infos;
     TCGTempSet temps_used;
 
     /* Array VALS has an element for each temp.
@@ -616,7 +616,7 @@ void tcg_optimize(TCGContext *s)
     nb_temps = s->nb_temps;
     nb_globals = s->nb_globals;
     bitmap_zero(temps_used.l, nb_temps);
-    infos = tcg_malloc(sizeof(struct tcg_temp_info) * nb_temps);
+    infos = tcg_malloc(sizeof(TempOptInfo) * nb_temps);
 
     QTAILQ_FOREACH_SAFE(op, &s->ops, link, op_next) {
         tcg_target_ulong mask, partmask, affected;
-- 
2.20.1


