Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A789C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CC92175B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/A1OJ91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CC92175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55586 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIxZq-0004e9-1s
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 11:43:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVe-00018m-PK
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVd-0006wp-Hm
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:02 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIxVd-0006wR-BX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:01 -0400
Received: by mail-pf1-x444.google.com with SMTP id z5so7691981pfn.3
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=xZfsJsQ1qLJS0hBY66Swluu5gyuxQl80LmSEU3qiQnM=;
	b=J/A1OJ91F4e+iRgxhDnnQyvKsMY+/Ywbqg3LQdq53eUOkdlsG6b+CU0MUgrlVz1p+h
	pQ25zTuY5Fc1nsWXlf6EDHQvekPwyW/pzdq0V6C8xpZA/N8h6I16ltdfvEZ8FwcJyakS
	p/I8i4Wqf31ZvIqU4bJ1CPAsxQXaGfnpbSgpeSUFRKlhTyHB1o+YSeROF/LrxEZMIryg
	hrnpQPW/E0+XwT0TPpRUvOAVB0UZtep0sW3kokbXk32hSNEH9RMJoQEzevuim9OvLWXw
	F5Yh/Gfc8DnKwC52r0Voi1xcepZmVDEkh74OaXjNoqydTeVtZvqKnO/ZceFhE3+1CO0E
	4feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=xZfsJsQ1qLJS0hBY66Swluu5gyuxQl80LmSEU3qiQnM=;
	b=ky/R/Um8YhgwcWkPmrHSdZbaFEJ000HiRfnF1H5FNO7BMj8834/LU6Eke7QwG7f9TC
	lvzj+DS43uYLqlIKuPjbP7uPIkpmi46SIe7gOzaIynuxF9Obfmhvo0yUrRsq6r3yIB9P
	ZB2BQliXKjl0RVa273cU/ac3BV8PEcoX7XP5Bx8Oe94G1tYHyXHZYEGCLId8JcqhHjnv
	UJfrrBcwh0e6Jrfy4C2MZi0YzrSl2VOEbA5fiR7OJE77oIJzrNHxqk+/PfUpS6CgX2rR
	39CFa1MHyC63xuT2i6V5jbUKnnhG+dgFs2zqWeLd8ZXCLHzTGOLEkUewUWld0RkCFCvL
	7rQw==
X-Gm-Message-State: APjAAAWJBaS4Pe3dNd5crac4YtQx0+JpAvJDviIXXFUtkAOg1uGIyhus
	xAr90gMkKsB2JKwV6+JorwlcZn4pIEc=
X-Google-Smtp-Source: APXvYqwy+xXi5GbRfFpccVLJNziA85nvDxbXVKLdt843fi6xp8rj65Rx1bvvq53fUF0tsCPXMNMo8A==
X-Received: by 2002:a63:224b:: with SMTP id t11mr8564219pgm.161.1556033940024; 
	Tue, 23 Apr 2019 08:39:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	c25sm24366591pfo.69.2019.04.23.08.38.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 08:38:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 08:38:49 -0700
Message-Id: <20190423153853.19790-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423153853.19790-1-richard.henderson@linaro.org>
References: <20190423153853.19790-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 3/7] tcg: Restart TB generation after
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423153849.wWtOPyBSRkOBPFC9sF58Gz1nZg_DTORt_GzyTZ3ZANQ@z>

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
index 32b7cf3489..d2f86174a3 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -237,12 +237,13 @@ typedef uint64_t tcg_insn_unit;
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
@@ -253,11 +254,9 @@ struct TCGLabel {
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
@@ -690,7 +689,6 @@ struct TCGContext {
 #endif
 
 #ifdef CONFIG_DEBUG_TCG
-    QSIMPLEQ_HEAD(, TCGLabel) labels;
     int temps_in_use;
     int goto_tb_issue_mask;
 #endif
@@ -728,6 +726,7 @@ struct TCGContext {
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
 
     QTAILQ_HEAD(, TCGOp) ops, free_ops;
+    QSIMPLEQ_HEAD(, TCGLabel) labels;
 
     /* Tells which temporary holds a given register.
        It does not take into account fixed registers */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index aa0e94521b..ab11235c42 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -262,37 +262,17 @@ static __attribute__((unused)) inline void tcg_patch64(tcg_insn_unit *p,
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
@@ -302,16 +282,32 @@ TCGLabel *gen_new_label(void)
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
@@ -1095,9 +1091,7 @@ void tcg_func_start(TCGContext *s)
 
     QTAILQ_INIT(&s->ops);
     QTAILQ_INIT(&s->free_ops);
-#ifdef CONFIG_DEBUG_TCG
     QSIMPLEQ_INIT(&s->labels);
-#endif
 }
 
 static inline TCGTemp *tcg_temp_alloc(TCGContext *s)
@@ -4010,6 +4004,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
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


