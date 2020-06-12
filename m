Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2E7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5866920792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlCKW9js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5866920792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjp2W-0001qh-MQ
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 15:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjoxP-0000ud-6x
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:03:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45111)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjoxI-0006vM-6H
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:03:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id c3so10772680wru.12
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=57l/aMK2332ZDMnrCc3giHMMSaLKEjqCHI6rtSAmCoo=;
 b=jlCKW9jsfwHQxeVIuK1Q5z+xzq4Hno/PT1Pc/u+MchoSQDMSD6a06hJNwyhcPbfyd1
 4Hi+ZAtp6A8r/4WVrZisDcDpvrVl8oLJf3AMgjsYrpO0rcicYqYP8XUpxXu0q+uJdfq4
 cgrRrqPf2ehlAh0cZWxPfdMIQzG8hKWyq9YXNl6ZcGtPFr5jhqhPadrfOF5MCj8gjC78
 /7h4gUgdTcFOE21oAHtNKxV1Ar1ia7q2qpPsxCsAipidzurLzK8gQSW8NLFx0LTTCsmZ
 VDUVunOoNxe/GROrgH965Qr5+9rv4WFYVw45qaVDNndy6IcevSDJaQWbVoIl14UAUv1+
 pTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=57l/aMK2332ZDMnrCc3giHMMSaLKEjqCHI6rtSAmCoo=;
 b=GpePqHKMu0ruGHPUxGTxrYOsPQYOZU9oVdVad16opEnt7fdAB8RfSCvLIssNd36nQZ
 N1EAcbpBaIGMr9sv5USBqK/mBp6AhcKGWT1X4QQiHJNkaB9iS8014vztyENXpRABpvLO
 XntTsMDdv2J006Vgou4oygkOfP0vin4pCjIQ6JFiPeoLzWmu9sFVc7EunEkGCNCauRX3
 H8+AuBhU0HAO4VVtttnuETmPuvcyEutAVHbMTclwMIz26PN3AA7FALYYPoyjymPvK5M0
 FScptiASSCb6cXpiG3R98Ea3OnbMWktem8hlKTsA/gN0bcwGN+NhYFyuLD/N1yi6cEOH
 zJaQ==
X-Gm-Message-State: AOAM530LfIcM52tgk9nHCTtjwlUEGXZeShcSxOJFfrQshOkSS+LTJAOj
 OlRpoJe74juBhGsGHOFS9xETxGH46hg=
X-Google-Smtp-Source: ABdhPJz/eIoi9K8q2nD7TN18OD8kbF4JriC+3UGu1gOVUe74e1ovukhsCMXGssWCZ45IpluCG/og3g==
X-Received: by 2002:a7b:cd06:: with SMTP id f6mr379029wmj.8.1591988579061;
 Fri, 12 Jun 2020 12:02:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b8sm11216298wrm.35.2020.06.12.12.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 12:02:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 92C981FF98;
 Fri, 12 Jun 2020 20:02:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 09/18] tcg: call qemu_spin_destroy for tb->jmp_lock
Date: Fri, 12 Jun 2020 20:02:28 +0100
Message-Id: <20200612190237.30436-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612190237.30436-1-alex.bennee@linaro.org>
References: <20200612190237.30436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
[RF: minor changes + remove tb_destroy_func]
Message-Id: <20200609200738.445-7-robert.foley@linaro.org>
---
 include/tcg/tcg.h         | 1 +
 accel/tcg/translate-all.c | 8 ++++++++
 tcg/tcg.c                 | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 380014ed805..e63450a8936 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -819,6 +819,7 @@ void tcg_pool_reset(TCGContext *s);
 TranslationBlock *tcg_tb_alloc(TCGContext *s);
 
 void tcg_region_init(void);
+void tb_destroy(TranslationBlock *tb);
 void tcg_region_reset_all(void);
 
 size_t tcg_code_size(void);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 42ce1dfcff7..c937210e217 100644
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
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1aa6cb47f29..1362bc61017 100644
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
2.20.1


