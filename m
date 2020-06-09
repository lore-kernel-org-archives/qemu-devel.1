Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0AAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E4920734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qe6nEER4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E4920734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jikgq-0000zg-TB
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZC-0007dg-5B
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:50 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZB-0005at-6y
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:49 -0400
Received: by mail-pf1-x443.google.com with SMTP id j1so52125pfe.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qwuZW03UALyLreC41dDKLL3VuvvJz8e2voNJjWwlkPc=;
 b=qe6nEER44UMHZJMd1lWxtNsxrVCLglEqB+UsmAhsfFJgiznbPIbfk6cDYk1MugwxM7
 OwhZ60uoKRWB2mTzbFmNOpm0mi3PrRs0gj3B8JGmOKiU9BCs3QTXy9s9JG+AR7E5ZydF
 03jsXgTAYHxE7fYLCBsJweUdFmjFOk7icdd9oEAzM3W+wqJPEkBCZyb18fgiiswJsnmJ
 i76oWZIdNg+IMDJJwLXEldE7+plVvwHx7PSSpkJ5U/nWtqdw1BLMCoFocYlPTTD52NA7
 aYAIPpwcxUAPeEKxjYXlIyZq4Wv/BBRkuvL1dWtdDKJKsKzqtuxvzOqTDpnFOcSlGOXC
 QYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qwuZW03UALyLreC41dDKLL3VuvvJz8e2voNJjWwlkPc=;
 b=gCVgeE5enpSy10Xn9p0CgN2PeMeMpoES/dzwSeCRnX4P8f2QFvd+A3KqLA1YaKzF6M
 iPMWQ/ab6kOcmMOOQMHnHt71yS5OClddK3fcvgXEY6Cl9OFV5KNLOILq2fdsXhBfT24s
 YTCa5tyCN9h2snh5AHwNXvqIIwIDKmNK7sAjzI2k3pJS4rsMUeDri1pKLmgwGaCzmI94
 NGjEq6FyJLtmsFEIZrcxyqniL0UlF06bd5JedySrsV+yrBgs2l6DuW86wS+aOFzMSxRJ
 dhH5sc7yCSC2TeQisBi9YTwo246SkhhvKtprFT3BhBvIAixVkUdG6xU1kE1WWVpwnLZc
 bWxg==
X-Gm-Message-State: AOAM5324bcr56DKqVeqD5mVtKw6i2ZGpWlLTA9g8ZrRFssXPIzy9/asi
 1tQIQ8b+bx1hEghE9mmbtu4s/5RY8I6Qig==
X-Google-Smtp-Source: ABdhPJxKnlvrEpi/+d3CZifxs278bJiZkebAHmX7xunAY1mYrXD5p54CsfBffh+BbiqWj5HhykG/0g==
X-Received: by 2002:a63:1a11:: with SMTP id a17mr25991301pga.227.1591733386297; 
 Tue, 09 Jun 2020 13:09:46 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1d09:cef2:3b1f:abce])
 by smtp.gmail.com with ESMTPSA id n19sm10523374pfu.194.2020.06.09.13.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 13:09:45 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/13] tcg: call qemu_spin_destroy for tb->jmp_lock
Date: Tue,  9 Jun 2020 16:07:31 -0400
Message-Id: <20200609200738.445-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609200738.445-1-robert.foley@linaro.org>
References: <20200609200738.445-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x443.google.com
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
[RF: minor changes + remove tb_destroy_func]
---
 accel/tcg/translate-all.c | 8 ++++++++
 include/tcg/tcg.h         | 1 +
 tcg/tcg.c                 | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 42ce1dfcff..c937210e21 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -384,6 +384,11 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     return 0;
 }
 
+void tb_destroy(TranslationBlock *tb)
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
index 380014ed80..e63450a893 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -819,6 +819,7 @@ void tcg_pool_reset(TCGContext *s);
 TranslationBlock *tcg_tb_alloc(TCGContext *s);
 
 void tcg_region_init(void);
+void tb_destroy(TranslationBlock *tb);
 void tcg_region_reset_all(void);
 
 size_t tcg_code_size(void);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1aa6cb47f2..1362bc6101 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -502,6 +502,14 @@ size_t tcg_nb_tbs(void)
     return nb_tbs;
 }
 
+static gboolean tcg_region_tree_traverse(gpointer k, gpointer v, gpointer data)
+{
+    TranslationBlock *tb = v;
+
+    tb_destroy(tb);
+    return FALSE;
+}
+
 static void tcg_region_tree_reset_all(void)
 {
     size_t i;
@@ -510,6 +518,7 @@ static void tcg_region_tree_reset_all(void)
     for (i = 0; i < region.n; i++) {
         struct tcg_region_tree *rt = region_trees + i * tree_size;
 
+        g_tree_foreach(rt->tree, tcg_region_tree_traverse, NULL);
         /* Increment the refcount first so that destroy acts as a reset */
         g_tree_ref(rt->tree);
         g_tree_destroy(rt->tree);
-- 
2.17.1


