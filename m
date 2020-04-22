Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03BDC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43DC2071C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EqoP1q5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43DC2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4Ai-0001aX-Oy
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41E-0001MO-At
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41D-0001aK-3r
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:40 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:39781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41C-0001Y7-L9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:38 -0400
Received: by mail-pj1-x1043.google.com with SMTP id e6so154508pjt.4
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YQvYsNBEjo7yFlIFBRyh3+DHsJ1dC0K7YRDq4gXsYZE=;
 b=EqoP1q5LGf1S8XKYYIbQJ7jjpu6yTzaYd5eP8r+laZrMnIL3f00ZaUZysvqMLNJEll
 qN6oa+8RqTObk9WdisMECG5hvOOm9CP73Awy6pCymwdef7Ru3kppafckErXqENSvDGfQ
 z+tfTj3Tz98aAh70u0wfcBoyl8M19i/HEAYoDZ+SnCI2lenIToBt/vlnr0TslWzqGyAC
 fDw45jm6pQvIPHL8UF+hyKtAxCU14nvxGNLi4WNHLWFMZkKwqTCU57NtV47oM6VHIpDT
 CMd+ee4ENQdyfLc5RmCaFHItJ3YJN41Jj7CMo9RXqYZCGSSUjI3VPLfljE38KJCHBr6X
 CvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YQvYsNBEjo7yFlIFBRyh3+DHsJ1dC0K7YRDq4gXsYZE=;
 b=hlGNsHPPyJR/jAJNMQKekivbv5P6+Gzror5Zagy8veGrbxGnaZfjrCsxdsMbnGJhWy
 dOnnH5iXI2pCuhOtqfqQ02TFL92qcMusVUhZOq0M6ZUc0jPrqbfJOOB3xVil8GcQ3Rc1
 c4qzNK3cRma5kPQbo8eLbbpOMDVz415qasmQnVuQUCHlp5hJSe+5IUMRTmkAButT7Z6Y
 sZ3hxY8TAE1DovOYyRLem3TAHc3xTn/TEvS43EmvbKP2CyxHpHlzOUePiFqoJmqakNtk
 Bct84v3Tah5BxmgKeNKD4/xBPrCLiRbYOZ8i3OEOX4A6Ca6io5i7Qj18vLpJN5hwLKyY
 SmeQ==
X-Gm-Message-State: AGi0PuaCY2BU1r6c0IfVLsPRkEbMgoq0BHQZgSIxnMtI0M+Q0jQg8OcS
 emYQiq+M11No3PtOK+MbQuObaYKDR8o=
X-Google-Smtp-Source: APiQypJssbNmP7zcU4/p5AsJYcSrh5vYTqZT5PQo2CWHkeDG3w1aO3g+9MHeo4VY3yUsNAf6c1OHLA==
X-Received: by 2002:a17:902:7489:: with SMTP id
 h9mr21816262pll.212.1587518256648; 
 Tue, 21 Apr 2020 18:17:36 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/36] tcg: Consolidate 3 bits into enum TCGTempKind
Date: Tue, 21 Apr 2020 18:16:55 -0700
Message-Id: <20200422011722.13287-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The temp_fixed, temp_global, temp_local bits are all related.
Combine them into a single enumeration.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  20 +++++---
 tcg/optimize.c    |   8 +--
 tcg/tcg.c         | 122 ++++++++++++++++++++++++++++------------------
 3 files changed, 90 insertions(+), 60 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index c48bd76b0a..3534dce77f 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -480,23 +480,27 @@ typedef enum TCGTempVal {
     TEMP_VAL_CONST,
 } TCGTempVal;
 
+typedef enum TCGTempKind {
+    /* Temp is dead at the end of all basic blocks. */
+    TEMP_NORMAL,
+    /* Temp is saved across basic blocks but dead at the end of TBs. */
+    TEMP_LOCAL,
+    /* Temp is saved across both basic blocks and translation blocks. */
+    TEMP_GLOBAL,
+    /* Temp is in a fixed register. */
+    TEMP_FIXED,
+} TCGTempKind;
+
 typedef struct TCGTemp {
     TCGReg reg:8;
     TCGTempVal val_type:8;
     TCGType base_type:8;
     TCGType type:8;
-    unsigned int fixed_reg:1;
+    TCGTempKind kind:3;
     unsigned int indirect_reg:1;
     unsigned int indirect_base:1;
     unsigned int mem_coherent:1;
     unsigned int mem_allocated:1;
-    /* If true, the temp is saved across both basic blocks and
-       translation blocks.  */
-    unsigned int temp_global:1;
-    /* If true, the temp is saved across basic blocks but dead
-       at the end of translation blocks.  If false, the temp is
-       dead at the end of basic blocks.  */
-    unsigned int temp_local:1;
     unsigned int temp_allocated:1;
 
     tcg_target_long val;
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 53aa8e5329..afb4a9a5a9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -116,21 +116,21 @@ static TCGTemp *find_better_copy(TCGContext *s, TCGTemp *ts)
     TCGTemp *i;
 
     /* If this is already a global, we can't do better. */
-    if (ts->temp_global) {
+    if (ts->kind >= TEMP_GLOBAL) {
         return ts;
     }
 
     /* Search for a global first. */
     for (i = ts_info(ts)->next_copy; i != ts; i = ts_info(i)->next_copy) {
-        if (i->temp_global) {
+        if (i->kind >= TEMP_GLOBAL) {
             return i;
         }
     }
 
     /* If it is a temp, search for a temp local. */
-    if (!ts->temp_local) {
+    if (ts->kind == TEMP_NORMAL) {
         for (i = ts_info(ts)->next_copy; i != ts; i = ts_info(i)->next_copy) {
-            if (ts->temp_local) {
+            if (i->kind >= TEMP_LOCAL) {
                 return i;
             }
         }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dd4b3d7684..eaf81397a3 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1155,7 +1155,7 @@ static inline TCGTemp *tcg_global_alloc(TCGContext *s)
     tcg_debug_assert(s->nb_globals == s->nb_temps);
     s->nb_globals++;
     ts = tcg_temp_alloc(s);
-    ts->temp_global = 1;
+    ts->kind = TEMP_GLOBAL;
 
     return ts;
 }
@@ -1172,7 +1172,7 @@ static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
     ts = tcg_global_alloc(s);
     ts->base_type = type;
     ts->type = type;
-    ts->fixed_reg = 1;
+    ts->kind = TEMP_FIXED;
     ts->reg = reg;
     ts->name = name;
     tcg_regset_set_reg(s->reserved_regs, reg);
@@ -1199,7 +1199,7 @@ TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
     bigendian = 1;
 #endif
 
-    if (!base_ts->fixed_reg) {
+    if (base_ts->kind != TEMP_FIXED) {
         /* We do not support double-indirect registers.  */
         tcg_debug_assert(!base_ts->indirect_reg);
         base_ts->indirect_base = 1;
@@ -1247,6 +1247,7 @@ TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
 TCGTemp *tcg_temp_new_internal(TCGType type, bool temp_local)
 {
     TCGContext *s = tcg_ctx;
+    TCGTempKind kind = temp_local ? TEMP_LOCAL : TEMP_NORMAL;
     TCGTemp *ts;
     int idx, k;
 
@@ -1259,7 +1260,7 @@ TCGTemp *tcg_temp_new_internal(TCGType type, bool temp_local)
         ts = &s->temps[idx];
         ts->temp_allocated = 1;
         tcg_debug_assert(ts->base_type == type);
-        tcg_debug_assert(ts->temp_local == temp_local);
+        tcg_debug_assert(ts->kind == kind);
     } else {
         ts = tcg_temp_alloc(s);
         if (TCG_TARGET_REG_BITS == 32 && type == TCG_TYPE_I64) {
@@ -1268,18 +1269,18 @@ TCGTemp *tcg_temp_new_internal(TCGType type, bool temp_local)
             ts->base_type = type;
             ts->type = TCG_TYPE_I32;
             ts->temp_allocated = 1;
-            ts->temp_local = temp_local;
+            ts->kind = kind;
 
             tcg_debug_assert(ts2 == ts + 1);
             ts2->base_type = TCG_TYPE_I64;
             ts2->type = TCG_TYPE_I32;
             ts2->temp_allocated = 1;
-            ts2->temp_local = temp_local;
+            ts2->kind = kind;
         } else {
             ts->base_type = type;
             ts->type = type;
             ts->temp_allocated = 1;
-            ts->temp_local = temp_local;
+            ts->kind = kind;
         }
     }
 
@@ -1336,12 +1337,12 @@ void tcg_temp_free_internal(TCGTemp *ts)
     }
 #endif
 
-    tcg_debug_assert(ts->temp_global == 0);
+    tcg_debug_assert(ts->kind < TEMP_GLOBAL);
     tcg_debug_assert(ts->temp_allocated != 0);
     ts->temp_allocated = 0;
 
     idx = temp_idx(ts);
-    k = ts->base_type + (ts->temp_local ? TCG_TYPE_COUNT : 0);
+    k = ts->base_type + (ts->kind == TEMP_NORMAL ? 0 : TCG_TYPE_COUNT);
     set_bit(idx, s->free_temps[k].l);
 }
 
@@ -1864,17 +1865,27 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
 static void tcg_reg_alloc_start(TCGContext *s)
 {
     int i, n;
-    TCGTemp *ts;
 
-    for (i = 0, n = s->nb_globals; i < n; i++) {
-        ts = &s->temps[i];
-        ts->val_type = (ts->fixed_reg ? TEMP_VAL_REG : TEMP_VAL_MEM);
-    }
-    for (n = s->nb_temps; i < n; i++) {
-        ts = &s->temps[i];
-        ts->val_type = (ts->temp_local ? TEMP_VAL_MEM : TEMP_VAL_DEAD);
-        ts->mem_allocated = 0;
-        ts->fixed_reg = 0;
+    for (i = 0, n = s->nb_temps; i < n; i++) {
+        TCGTemp *ts = &s->temps[i];
+        TCGTempVal val = TEMP_VAL_MEM;
+
+        switch (ts->kind) {
+        case TEMP_FIXED:
+            val = TEMP_VAL_REG;
+            break;
+        case TEMP_GLOBAL:
+            break;
+        case TEMP_NORMAL:
+            val = TEMP_VAL_DEAD;
+            /* fall through */
+        case TEMP_LOCAL:
+            ts->mem_allocated = 0;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        ts->val_type = val;
     }
 
     memset(s->reg_to_temp, 0, sizeof(s->reg_to_temp));
@@ -1885,12 +1896,17 @@ static char *tcg_get_arg_str_ptr(TCGContext *s, char *buf, int buf_size,
 {
     int idx = temp_idx(ts);
 
-    if (ts->temp_global) {
+    switch (ts->kind) {
+    case TEMP_FIXED:
+    case TEMP_GLOBAL:
         pstrcpy(buf, buf_size, ts->name);
-    } else if (ts->temp_local) {
+        break;
+    case TEMP_LOCAL:
         snprintf(buf, buf_size, "loc%d", idx - s->nb_globals);
-    } else {
+        break;
+    case TEMP_NORMAL:
         snprintf(buf, buf_size, "tmp%d", idx - s->nb_globals);
+        break;
     }
     return buf;
 }
@@ -2486,15 +2502,24 @@ static void la_bb_end(TCGContext *s, int ng, int nt)
 {
     int i;
 
-    for (i = 0; i < ng; ++i) {
-        s->temps[i].state = TS_DEAD | TS_MEM;
-        la_reset_pref(&s->temps[i]);
-    }
-    for (i = ng; i < nt; ++i) {
-        s->temps[i].state = (s->temps[i].temp_local
-                             ? TS_DEAD | TS_MEM
-                             : TS_DEAD);
-        la_reset_pref(&s->temps[i]);
+    for (i = 0; i < nt; ++i) {
+        TCGTemp *ts = &s->temps[i];
+        int state;
+
+        switch (ts->kind) {
+        case TEMP_FIXED:
+        case TEMP_GLOBAL:
+        case TEMP_LOCAL:
+            state = TS_DEAD | TS_MEM;
+            break;
+        case TEMP_NORMAL:
+            state = TS_DEAD;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        ts->state = state;
+        la_reset_pref(ts);
     }
 }
 
@@ -3069,7 +3094,8 @@ static void check_regs(TCGContext *s)
     }
     for (k = 0; k < s->nb_temps; k++) {
         ts = &s->temps[k];
-        if (ts->val_type == TEMP_VAL_REG && !ts->fixed_reg
+        if (ts->val_type == TEMP_VAL_REG
+            && ts->kind != TEMP_FIXED
             && s->reg_to_temp[ts->reg] != ts) {
             printf("Inconsistency for temp %s:\n",
                    tcg_get_arg_str_ptr(s, buf, sizeof(buf), ts));
@@ -3106,15 +3132,14 @@ static void temp_load(TCGContext *, TCGTemp *, TCGRegSet, TCGRegSet, TCGRegSet);
    mark it free; otherwise mark it dead.  */
 static void temp_free_or_dead(TCGContext *s, TCGTemp *ts, int free_or_dead)
 {
-    if (ts->fixed_reg) {
+    if (ts->kind == TEMP_FIXED) {
         return;
     }
     if (ts->val_type == TEMP_VAL_REG) {
         s->reg_to_temp[ts->reg] = NULL;
     }
     ts->val_type = (free_or_dead < 0
-                    || ts->temp_local
-                    || ts->temp_global
+                    || ts->kind != TEMP_NORMAL
                     ? TEMP_VAL_MEM : TEMP_VAL_DEAD);
 }
 
@@ -3131,7 +3156,7 @@ static inline void temp_dead(TCGContext *s, TCGTemp *ts)
 static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
                       TCGRegSet preferred_regs, int free_or_dead)
 {
-    if (ts->fixed_reg) {
+    if (ts->kind == TEMP_FIXED) {
         return;
     }
     if (!ts->mem_coherent) {
@@ -3289,7 +3314,8 @@ static void temp_save(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs)
 {
     /* The liveness analysis already ensures that globals are back
        in memory. Keep an tcg_debug_assert for safety. */
-    tcg_debug_assert(ts->val_type == TEMP_VAL_MEM || ts->fixed_reg);
+    tcg_debug_assert(ts->val_type == TEMP_VAL_MEM
+                     || ts->kind == TEMP_FIXED);
 }
 
 /* save globals to their canonical location and assume they can be
@@ -3314,7 +3340,7 @@ static void sync_globals(TCGContext *s, TCGRegSet allocated_regs)
     for (i = 0, n = s->nb_globals; i < n; i++) {
         TCGTemp *ts = &s->temps[i];
         tcg_debug_assert(ts->val_type != TEMP_VAL_REG
-                         || ts->fixed_reg
+                         || ts->kind == TEMP_FIXED
                          || ts->mem_coherent);
     }
 }
@@ -3327,7 +3353,7 @@ static void tcg_reg_alloc_bb_end(TCGContext *s, TCGRegSet allocated_regs)
 
     for (i = s->nb_globals; i < s->nb_temps; i++) {
         TCGTemp *ts = &s->temps[i];
-        if (ts->temp_local) {
+        if (ts->kind == TEMP_LOCAL) {
             temp_save(s, ts, allocated_regs);
         } else {
             /* The liveness analysis already ensures that temps are dead.
@@ -3347,7 +3373,7 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
                                   TCGRegSet preferred_regs)
 {
     /* ENV should not be modified.  */
-    tcg_debug_assert(!ots->fixed_reg);
+    tcg_debug_assert(ots->kind != TEMP_FIXED);
 
     /* The movi is not explicitly generated here.  */
     if (ots->val_type == TEMP_VAL_REG) {
@@ -3387,7 +3413,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
     ts = arg_temp(op->args[1]);
 
     /* ENV should not be modified.  */
-    tcg_debug_assert(!ots->fixed_reg);
+    tcg_debug_assert(ots->kind != TEMP_FIXED);
 
     /* Note that otype != itype for no-op truncation.  */
     otype = ots->type;
@@ -3426,7 +3452,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
         }
         temp_dead(s, ots);
     } else {
-        if (IS_DEAD_ARG(1) && !ts->fixed_reg) {
+        if (IS_DEAD_ARG(1) && ts->kind != TEMP_FIXED) {
             /* the mov can be suppressed */
             if (ots->val_type == TEMP_VAL_REG) {
                 s->reg_to_temp[ots->reg] = NULL;
@@ -3448,7 +3474,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
                  * Store the source register into the destination slot
                  * and leave the destination temp as TEMP_VAL_MEM.
                  */
-                assert(!ots->fixed_reg);
+                assert(ots->kind != TEMP_FIXED);
                 if (!ts->mem_allocated) {
                     temp_allocate_frame(s, ots);
                 }
@@ -3485,7 +3511,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
     its = arg_temp(op->args[1]);
 
     /* ENV should not be modified.  */
-    tcg_debug_assert(!ots->fixed_reg);
+    tcg_debug_assert(ots->kind != TEMP_FIXED);
 
     itype = its->type;
     vece = TCGOP_VECE(op);
@@ -3625,7 +3651,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         i_preferred_regs = o_preferred_regs = 0;
         if (arg_ct->ct & TCG_CT_IALIAS) {
             o_preferred_regs = op->output_pref[arg_ct->alias_index];
-            if (ts->fixed_reg) {
+            if (ts->kind == TEMP_FIXED) {
                 /* if fixed register, we must allocate a new register
                    if the alias is not the same register */
                 if (arg != op->args[arg_ct->alias_index]) {
@@ -3716,7 +3742,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             ts = arg_temp(arg);
 
             /* ENV should not be modified.  */
-            tcg_debug_assert(!ts->fixed_reg);
+            tcg_debug_assert(ts->kind != TEMP_FIXED);
 
             if ((arg_ct->ct & TCG_CT_ALIAS)
                 && !const_args[arg_ct->alias_index]) {
@@ -3758,7 +3784,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         ts = arg_temp(op->args[i]);
 
         /* ENV should not be modified.  */
-        tcg_debug_assert(!ts->fixed_reg);
+        tcg_debug_assert(ts->kind != TEMP_FIXED);
 
         if (NEED_SYNC_ARG(i)) {
             temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i));
@@ -3890,7 +3916,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
         ts = arg_temp(arg);
 
         /* ENV should not be modified.  */
-        tcg_debug_assert(!ts->fixed_reg);
+        tcg_debug_assert(ts->kind != TEMP_FIXED);
 
         reg = tcg_target_call_oarg_regs[i];
         tcg_debug_assert(s->reg_to_temp[reg] == NULL);
-- 
2.20.1


