Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018AAC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E2D24980
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5WlKMK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E2D24980
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4uy-0005LL-Uw
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lG-0005xr-R0
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:02 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lF-00030H-KB
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:02 -0400
Received: by mail-pj1-x1044.google.com with SMTP id mq3so4401792pjb.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s8VXXHi1iDtHYGhbceKG3FGqG6XMQ3ZwJ4s4y4ornzs=;
 b=O5WlKMK+lw2xqLMfEROonr49PfT0cYPUmoGIrRn4GqMGdOt4PnMTilb2/XRfQBlSjR
 TjNFlKdTvCJGSVqhdU904I7GgnK0O6SECzZPGFHssQxODM7sBrBSqetArlX9qz9ZqVtn
 Exe/UjC7KT3Z5h5K9pW6HF9q6vdD8O7GUTVN/5ackxHTBhZU6ie4RpMX7tWcjjUGu6iW
 CqZEYiYX6QduyPjUojrco5/r+Q9/e6v6VTgRN4d/g3z9YE5vuYzYPK2/WtxPCggRkIsT
 NSGKdX7FfYf6G5CglXn6Sy+NlS0SHkumzO7VOz1moXJMFQYTuz3YX6MPbopY7FZnduMA
 UN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s8VXXHi1iDtHYGhbceKG3FGqG6XMQ3ZwJ4s4y4ornzs=;
 b=bqcfkEY4uku8nBoqapPp9EsphlzO8EiDsAT4wriuPlrylGlVCMb/O+S6aqNy5mcBkS
 LzH7uaL4Wah03W93q5hIEp4dhW9gdFJ+xDWfx8Eygv/gClEwi9If3syZftoVwb9E2mDJ
 1M/Y06MI4xoqiBqKY30TPhIBj2/cEFgwup0TjbrKySIazw7qsFQe27JGqfF77yes5C6S
 Wl3qUJIrkeGrHTfzdQlFgpkC+5MSk+uKX4Am+tBAqxgJRWA9e58VePu/EpsfoIMA2OzX
 PWnlc+R9X2x7YJUlN7ttj+bhBBX52fLg8NHoD6GS/jeouTxzFPJJ1Olh662OUvzGEjkF
 mTsw==
X-Gm-Message-State: AGi0PuYhHOoiJdzQTcfA7dh+aRpjoOFlhnOOFlMaEmaHbOZ00oNMT/1c
 DzB9tSrCYQhgzAPlKtjELRZjSqmxzKw=
X-Google-Smtp-Source: APiQypKfrkchL+nNHy6BayCNs8DXrYZnvq4A41dU+1VKNnpE5LOVnfAZjEELnYtQ1qa46ApF+mvIuA==
X-Received: by 2002:a17:90a:8c8e:: with SMTP id
 b14mr2356897pjo.222.1588951079874; 
 Fri, 08 May 2020 08:17:59 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b5sm2125933pfb.190.2020.05.08.08.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:17:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/19] tcg: Rename struct tcg_temp_info to TempOptInfo
Date: Fri,  8 May 2020 08:17:37 -0700
Message-Id: <20200508151747.6166-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151747.6166-1-richard.henderson@linaro.org>
References: <20200508151747.6166-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix this name vs our coding style.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8f3bd99ff4..c0fc5e3da6 100644
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
@@ -180,7 +180,7 @@ static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg val)
     const TCGOpDef *def;
     TCGOpcode new_op;
     tcg_target_ulong mask;
-    struct tcg_temp_info *di = arg_info(dst);
+    TempOptInfo *di = arg_info(dst);
 
     def = &tcg_op_defs[op->opc];
     if (def->flags & TCG_OPF_VECTOR) {
@@ -211,8 +211,8 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg src)
     TCGTemp *dst_ts = arg_temp(dst);
     TCGTemp *src_ts = arg_temp(src);
     const TCGOpDef *def;
-    struct tcg_temp_info *di;
-    struct tcg_temp_info *si;
+    TempOptInfo *di;
+    TempOptInfo *si;
     tcg_target_ulong mask;
     TCGOpcode new_op;
 
@@ -245,7 +245,7 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg src)
     di->mask = mask;
 
     if (src_ts->type == dst_ts->type) {
-        struct tcg_temp_info *ni = ts_info(si->next_copy);
+        TempOptInfo *ni = ts_info(si->next_copy);
 
         di->next_copy = si->next_copy;
         di->prev_copy = src_ts;
@@ -608,7 +608,7 @@ void tcg_optimize(TCGContext *s)
 {
     int nb_temps, nb_globals;
     TCGOp *op, *op_next, *prev_mb = NULL;
-    struct tcg_temp_info *infos;
+    TempOptInfo *infos;
     TCGTempSet temps_used;
 
     /* Array VALS has an element for each temp.
@@ -619,7 +619,7 @@ void tcg_optimize(TCGContext *s)
     nb_temps = s->nb_temps;
     nb_globals = s->nb_globals;
     bitmap_zero(temps_used.l, nb_temps);
-    infos = tcg_malloc(sizeof(struct tcg_temp_info) * nb_temps);
+    infos = tcg_malloc(sizeof(TempOptInfo) * nb_temps);
 
     QTAILQ_FOREACH_SAFE(op, &s->ops, link, op_next) {
         tcg_target_ulong mask, partmask, affected;
-- 
2.20.1


