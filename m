Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D841DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25D820721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rkVNg2/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25D820721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jef2b-0001Fs-OZ
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeezE-0004Ui-Rs
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:48 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeezD-0003d7-Rr
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:48 -0400
Received: by mail-pl1-x642.google.com with SMTP id a13so1164413pls.8
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JYiXtqj6gRVqxuRODQQz1eMSRJbQ7+uu1VT7LzsetPI=;
 b=rkVNg2/p5xwqEhzyR0dz8A/RKbFbxailFWq6cwwZ/814WE0lrIQ/nRyM63u6E6/Mt7
 vo8bNQ4cRgfOTi8+Z5eFu0Uzw8uNB1m65tA/nE9nkudtCuouXou0RlAR5Tz4p6nB0fzI
 xqBYbx6iOGylN4gO1F3KCBFyt2wTmhwCXUzjfI50sf9o6kHqz03GGvwi6KE+F09R/mKU
 HTkKLjeU9os8MdIWB/OvX7MzyGHaBLH5scmWmUcwbON+0vIdTZrEg4wRMDQ5gsmC/x6f
 zawPqM1F6MD9IGfGw1TJoKpPAuKSrYT5nLPL0P7rO3dFEwDye6nkLO94QhPtsPxxCtsE
 1+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JYiXtqj6gRVqxuRODQQz1eMSRJbQ7+uu1VT7LzsetPI=;
 b=qscd7/PXuCIGzjgsBTUt7txbZH3m/RWaugD2bVFg2gmVKUGCbP9QMsXyi+5igh20D4
 3xkmRxNU0StuC0G5Ksn/CUlHlWdGuBXfLqLUso7CSIjA054GiVtUDhfmzUG7msgpS+aX
 tDt1OnQcMR06ckndfoLy/Jdsm0DlbnWnIBi1DjpoRXPaeW/hp4LiZlX9RCo2tQ4tA9Tt
 vBjmZDudW0s/pIwdi6/7SYXuGXuSVTrXrpvJ3p7ZJeDIxqVvhRCUET9hWjkqK9+i/DyY
 IacEJGMSnL+2HGU3duXb3Hdz20ffmQBbGdTqpDjhSsWy+vL7ReCimZyTwczAUyz0oEd7
 gu6A==
X-Gm-Message-State: AOAM533NOF3xl99opFPv3h6gY4JAGcubtTtOi6WoI6+xBcAvBCpCPvhO
 h3fUBHbfePLk3ruu3jRAcIhCF6dQd2kChA==
X-Google-Smtp-Source: ABdhPJztSe7+0QS2bC8lcQlBNnzt7qdgei7tfmLkGLk3hXim/DOLxCFnVkmne04xjDm2+/PiLzgsKg==
X-Received: by 2002:a17:90b:46d7:: with SMTP id
 jx23mr9324529pjb.36.1590758626201; 
 Fri, 29 May 2020 06:23:46 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id e13sm1998686pfd.10.2020.05.29.06.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 06:23:45 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 06/12] tcg: call qemu_spin_destroy for tb->jmp_lock
Date: Fri, 29 May 2020 09:23:36 -0400
Message-Id: <20200529132341.755-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529132341.755-1-robert.foley@linaro.org>
References: <20200529132341.755-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
[RF: Minor changes to fix some checkpatch errors]
---
 accel/tcg/translate-all.c | 10 +++++++++-
 include/tcg/tcg.h         |  3 ++-
 tcg/tcg.c                 | 19 ++++++++++++++++---
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 42ce1dfcff..3708aab36b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -384,6 +384,11 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     return 0;
 }
 
+static void tb_destroy(TranslationBlock *tb)
+{
+    qemu_spin_destroy(&tb->jmp_lock);
+}
+
 bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc, bool will_exit)
 {
     TranslationBlock *tb;
@@ -413,6 +418,7 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc, bool will_exit)
                 /* one-shot translation, invalidate it immediately */
                 tb_phys_invalidate(tb, -1);
                 tcg_tb_remove(tb);
+                tb_destroy(tb);
             }
             r = true;
         }
@@ -1230,7 +1236,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
     page_flush_tb();
 
-    tcg_region_reset_all();
+    tcg_region_reset_all(tb_destroy);
     /* XXX: flush processor icache at this point if cache flush is
        expensive */
     atomic_mb_set(&tb_ctx.tb_flush_count, tb_ctx.tb_flush_count + 1);
@@ -1886,6 +1892,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
         orig_aligned -= ROUND_UP(sizeof(*tb), qemu_icache_linesize);
         atomic_set(&tcg_ctx->code_gen_ptr, (void *)orig_aligned);
+        tb_destroy(tb);
         return existing_tb;
     }
     tcg_tb_insert(tb);
@@ -2235,6 +2242,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
             tb_phys_invalidate(tb->orig_tb, -1);
         }
         tcg_tb_remove(tb);
+        tb_destroy(tb);
     }
 
     /* TODO: If env->pc != tb->pc (i.e. the faulting instruction was not
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index c48bd76b0a..2c5997e14e 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -815,8 +815,9 @@ void *tcg_malloc_internal(TCGContext *s, int size);
 void tcg_pool_reset(TCGContext *s);
 TranslationBlock *tcg_tb_alloc(TCGContext *s);
 
+typedef void (*tb_destroy_func)(TranslationBlock *tb);
 void tcg_region_init(void);
-void tcg_region_reset_all(void);
+void tcg_region_reset_all(tb_destroy_func tb_destroy);
 
 size_t tcg_code_size(void);
 size_t tcg_code_capacity(void);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a2268d9db0..2680968683 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -502,7 +502,16 @@ size_t tcg_nb_tbs(void)
     return nb_tbs;
 }
 
-static void tcg_region_tree_reset_all(void)
+static gboolean tcg_region_tree_traverse(gpointer k, gpointer v, gpointer data)
+{
+    TranslationBlock *tb = v;
+    tb_destroy_func tb_destroy = data;
+
+    tb_destroy(tb);
+    return FALSE;
+}
+
+static void tcg_region_tree_reset_all(tb_destroy_func tb_destroy)
 {
     size_t i;
 
@@ -510,6 +519,10 @@ static void tcg_region_tree_reset_all(void)
     for (i = 0; i < region.n; i++) {
         struct tcg_region_tree *rt = region_trees + i * tree_size;
 
+        if (tb_destroy != NULL) {
+            g_tree_foreach(rt->tree, tcg_region_tree_traverse, tb_destroy);
+        }
+
         /* Increment the refcount first so that destroy acts as a reset */
         g_tree_ref(rt->tree);
         g_tree_destroy(rt->tree);
@@ -586,7 +599,7 @@ static inline bool tcg_region_initial_alloc__locked(TCGContext *s)
 }
 
 /* Call from a safe-work context */
-void tcg_region_reset_all(void)
+void tcg_region_reset_all(tb_destroy_func tb_destroy)
 {
     unsigned int n_ctxs = atomic_read(&n_tcg_ctxs);
     unsigned int i;
@@ -603,7 +616,7 @@ void tcg_region_reset_all(void)
     }
     qemu_mutex_unlock(&region.lock);
 
-    tcg_region_tree_reset_all();
+    tcg_region_tree_reset_all(tb_destroy);
 }
 
 #ifdef CONFIG_USER_ONLY
-- 
2.17.1


