Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625F3C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E182146E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWcBYc/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E182146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49935 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4cT-0001X6-9y
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:26:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aU-000063-Fg
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aT-0006nR-70
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:38 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:41201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aT-0006iv-0a
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:37 -0400
Received: by mail-pg1-x52a.google.com with SMTP id f6so1926257pgs.8
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=kpqVFtaSGqwvohuDuKrV4p1L52nRZgnSIh7tMyl91fs=;
	b=qWcBYc/0k38/sWxUVkByNbTVtEn4xzeSQgih+cXNC0MN0MytS/Uw/5yn3RrqPhUNDq
	8d8heByOri0hnQcwY1K+rK5eJncvfMF3jQu5HK/vVk65KIrbdlKY0pd4URPyvnVrqMYv
	lj7gu7liX8VHWIl2yXZ2lhBvFLh0Rn061jmauCks++mZC6W7HN1epotqs+GFpjDRdTqh
	JMofKXPAyGKT0N1hFlUXXCHfPCjJ6oo5w5J3r75xT5z3IHgmCgpGtdjaJ30QZkrsfdJt
	vsdDots+LVxmH2k4sELIXV6PttlHOjXbthg4pc5Xr22725/ctIwcvqoP+Jd4usBG5giX
	Kphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=kpqVFtaSGqwvohuDuKrV4p1L52nRZgnSIh7tMyl91fs=;
	b=kuILZUdHKKavFNb5Ukly6WjYkkBl6hiXn4zTcl5TFG44psCo6guWuBvaGTO7ejEO4c
	U7XtYVILjym2jwbBtOzhY+jaFxKnaKiNLTS6YydJo9m2KQ1KEMT0N8AoM00Ne+e++iWe
	rhcX9F7e78bu1/izk31Bz9WdBerHTJt04dP5fPiB7ClIoORg/pMxnZlfBj50qL5EM+2T
	p2Q1rBnLp9PvoIJ4azFfwUHdroWFn34IExFAOkqs9zO/1V9fhL0yKD4ssmI4miSyqGIh
	8QxeLWORJTSNZ8oGD1FkJnMmBKf7tqzgZDpdToqu32didCs3rBDRJe2t2JPYoFqG/yac
	SHYw==
X-Gm-Message-State: APjAAAUtSp1nH2XeU4VMlnTgo3x8SdWeB40fmQf+ILPJgmCQgLBZn7jB
	szF+K+mmQtcJjOvX531bFHUlVi/tW8g=
X-Google-Smtp-Source: APXvYqx4FvUsZlydsQh5QPoiafubfn6X34Wk7iuPH6tdCvAmMRhvqRoVan1IMdIntgq4qQ9QTIH+Ew==
X-Received: by 2002:a62:60c1:: with SMTP id u184mr3218999pfb.106.1556299475648;
	Fri, 26 Apr 2019 10:24:35 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:16 -0700
Message-Id: <20190426172421.27133-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52a
Subject: [Qemu-devel] [PULL 10/15] tcg: Restart TB generation after
 relocation overflow
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426172416.9AfMkjv8SJtnShtfGEVj6LZID3HTa5MU6B3H4YTsTuQ@z>

If the TB generates too much code, such that backend relocations
overflow, try again with a smaller TB.  In support of this, move
relocation processing from a random place within tcg_out_op, in
the handling of branch opcodes, to a new function at the end of
tcg_gen_code.

This is not a complete solution, as there are additional relocs
generated for out-of-line ldst handling and constant pools.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 15 +++++++-------
 tcg/tcg.c | 61 ++++++++++++++++++++++++++-----------------------------
 2 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 50de1cdda3..cfc57110a1 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -238,12 +238,13 @@ typedef uint64_t tcg_insn_unit;
     do { if (!(X)) { __builtin_unreachable(); } } while (0)
 #endif
 
-typedef struct TCGRelocation {
-    struct TCGRelocation *next;
-    int type;
+typedef struct TCGRelocation TCGRelocation;
+struct TCGRelocation {
+    QSIMPLEQ_ENTRY(TCGRelocation) next;
     tcg_insn_unit *ptr;
     intptr_t addend;
-} TCGRelocation; 
+    int type;
+};
 
 typedef struct TCGLabel TCGLabel;
 struct TCGLabel {
@@ -254,11 +255,9 @@ struct TCGLabel {
     union {
         uintptr_t value;
         tcg_insn_unit *value_ptr;
-        TCGRelocation *first_reloc;
     } u;
-#ifdef CONFIG_DEBUG_TCG
+    QSIMPLEQ_HEAD(, TCGRelocation) relocs;
     QSIMPLEQ_ENTRY(TCGLabel) next;
-#endif
 };
 
 typedef struct TCGPool {
@@ -691,7 +690,6 @@ struct TCGContext {
 #endif
 
 #ifdef CONFIG_DEBUG_TCG
-    QSIMPLEQ_HEAD(, TCGLabel) labels;
     int temps_in_use;
     int goto_tb_issue_mask;
 #endif
@@ -729,6 +727,7 @@ struct TCGContext {
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
 
     QTAILQ_HEAD(, TCGOp) ops, free_ops;
+    QSIMPLEQ_HEAD(, TCGLabel) labels;
 
     /* Tells which temporary holds a given register.
        It does not take into account fixed registers */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5d255166c0..752c45a0ec 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -263,37 +263,17 @@ static __attribute__((unused)) inline void tcg_patch64(tcg_insn_unit *p,
 static void tcg_out_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
                           TCGLabel *l, intptr_t addend)
 {
-    TCGRelocation *r;
+    TCGRelocation *r = tcg_malloc(sizeof(TCGRelocation));
 
-    if (l->has_value) {
-        /* FIXME: This may break relocations on RISC targets that
-           modify instruction fields in place.  The caller may not have 
-           written the initial value.  */
-        bool ok = patch_reloc(code_ptr, type, l->u.value, addend);
-        tcg_debug_assert(ok);
-    } else {
-        /* add a new relocation entry */
-        r = tcg_malloc(sizeof(TCGRelocation));
-        r->type = type;
-        r->ptr = code_ptr;
-        r->addend = addend;
-        r->next = l->u.first_reloc;
-        l->u.first_reloc = r;
-    }
+    r->type = type;
+    r->ptr = code_ptr;
+    r->addend = addend;
+    QSIMPLEQ_INSERT_TAIL(&l->relocs, r, next);
 }
 
 static void tcg_out_label(TCGContext *s, TCGLabel *l, tcg_insn_unit *ptr)
 {
-    intptr_t value = (intptr_t)ptr;
-    TCGRelocation *r;
-
     tcg_debug_assert(!l->has_value);
-
-    for (r = l->u.first_reloc; r != NULL; r = r->next) {
-        bool ok = patch_reloc(r->ptr, r->type, value, r->addend);
-        tcg_debug_assert(ok);
-    }
-
     l->has_value = 1;
     l->u.value_ptr = ptr;
 }
@@ -303,16 +283,32 @@ TCGLabel *gen_new_label(void)
     TCGContext *s = tcg_ctx;
     TCGLabel *l = tcg_malloc(sizeof(TCGLabel));
 
-    *l = (TCGLabel){
-        .id = s->nb_labels++
-    };
-#ifdef CONFIG_DEBUG_TCG
+    memset(l, 0, sizeof(TCGLabel));
+    l->id = s->nb_labels++;
+    QSIMPLEQ_INIT(&l->relocs);
+
     QSIMPLEQ_INSERT_TAIL(&s->labels, l, next);
-#endif
 
     return l;
 }
 
+static bool tcg_resolve_relocs(TCGContext *s)
+{
+    TCGLabel *l;
+
+    QSIMPLEQ_FOREACH(l, &s->labels, next) {
+        TCGRelocation *r;
+        uintptr_t value = l->u.value;
+
+        QSIMPLEQ_FOREACH(r, &l->relocs, next) {
+            if (!patch_reloc(r->ptr, r->type, value, r->addend)) {
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
 static void set_jmp_reset_offset(TCGContext *s, int which)
 {
     size_t off = tcg_current_code_size(s);
@@ -1096,9 +1092,7 @@ void tcg_func_start(TCGContext *s)
 
     QTAILQ_INIT(&s->ops);
     QTAILQ_INIT(&s->free_ops);
-#ifdef CONFIG_DEBUG_TCG
     QSIMPLEQ_INIT(&s->labels);
-#endif
 }
 
 static inline TCGTemp *tcg_temp_alloc(TCGContext *s)
@@ -4015,6 +4009,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         return -1;
     }
 #endif
+    if (!tcg_resolve_relocs(s)) {
+        return -2;
+    }
 
     /* flush instruction cache */
     flush_icache_range((uintptr_t)s->code_buf, (uintptr_t)s->code_ptr);
-- 
2.17.1


