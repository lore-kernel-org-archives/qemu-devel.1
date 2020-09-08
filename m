Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8A7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD1622204
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhOZGM/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD1622204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcpJ-0005wk-Cg
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFcnI-00020E-E5; Tue, 08 Sep 2020 08:32:16 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFcnG-0008De-IQ; Tue, 08 Sep 2020 08:32:16 -0400
Received: by mail-pg1-x543.google.com with SMTP id g29so9947900pgl.2;
 Tue, 08 Sep 2020 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6IbIev6UphKtRupMGnz/q+0CYLU1wctlYm7gArTx0pQ=;
 b=dhOZGM/+WrvXhFCPrQkriGNYYtN//wXapOzAAJV15ehlp8EpDkK46bDH/vjKdgwi2m
 TqGSJPhJSqZbjIJcM9kdQo07w38elyREQDTYYiJ4QxzlsAEzPpRpcnCsQkMTF6JmexaZ
 xl9FdaRMWQTHEYtrJpBBh8XoCuQUuoL1K5burUctnlzBMQYxNqivB/OMvz0Je2wzQ7VA
 wqnA1DeQByb4OmQuzAqQVp53TACOSzTQ7pEEJckF2fnkC2BOqjQsph6wyCNJH8mZXJBu
 S+R7Kt2kw1o4yIMQ1WTogaOANrc+ntgoVZwyES3HpEG3w1CSCX6rHIzvGHy5e4H+aPXk
 1bQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6IbIev6UphKtRupMGnz/q+0CYLU1wctlYm7gArTx0pQ=;
 b=RKHotCEUGqYpHpJOZBR9fCiGpIgGXHmioVYs0mtxQVWTMj3LqSudqmKmbuhxYd1ClP
 3a8gbCZqfv2JnAgXqL76oXchMj5qjbgUAEgONqy8LGMaEev80Vi2U4jkdo8iEZJn6Nz3
 FZ3yPfjjNU7NNEFgVpZuDktj8NGzUCGHSMtTht5E4sEoWmaP9JlInT3x/b16fmAC2BQ1
 idMiYG/l6p3+jI3RPHa7W7lCbBdZHDl4pVJGyAZA4+5fxNfZJaR1GbE4BndSnc5PyW8j
 Hf1uVj3yykgNqp6PzI3CURFHlrvuOgUfgiBrU2yBRyZJMsoNB8L3GIF5zSotuI9R/N9V
 kQqA==
X-Gm-Message-State: AOAM531xvK833NsX6RhT6/kn+Z0SX4wyta0PDOKIVHAVzusOFI6WCU+y
 qpOPn+xhSTrUlbTgNiYLDzcqHaR9QA/X16Hs
X-Google-Smtp-Source: ABdhPJylffKa9jtUUkYcB/Cd7nqnkLD9/k0+XQ5xQy3m8l4OAoaFKx/jXbdNinePdO02xJ0ymo5c7Q==
X-Received: by 2002:a63:29c7:: with SMTP id
 p190mr20078387pgp.292.1599568332265; 
 Tue, 08 Sep 2020 05:32:12 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id k5sm29172087pjl.3.2020.09.08.05.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 05:32:11 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] rcu: add uninit destructor for rcu
Date: Tue,  8 Sep 2020 20:31:49 +0800
Message-Id: <20200908123149.1475-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908123149.1475-1-luoyonggang@gmail.com>
References: <20200908123149.1475-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Daniel Brodsky <dnbrdsky@gmail.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is necessary if the pending  rcu calls are closing and removing
temp files. This also provide a function
void rcu_wait_finished(void);
to fixes test-logging.c test failure on msys2/mingw.
On windows if the file doesn't closed, you can not remove it.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/rcu.h   |  5 +++++
 tests/test-logging.c |  2 ++
 util/rcu.c           | 28 ++++++++++++++++++++++++----
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index 570aa603eb..dd0a92c1d0 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -124,6 +124,11 @@ extern void rcu_unregister_thread(void);
 extern void rcu_enable_atfork(void);
 extern void rcu_disable_atfork(void);
 
+/*
+ * Wait all rcu call executed and exit the rcu thread.
+ */
+extern void rcu_wait_finished(void);
+
 struct rcu_head;
 typedef void RCUCBFunc(struct rcu_head *head);
 
diff --git a/tests/test-logging.c b/tests/test-logging.c
index 957f6c08cd..7a5b59f4a5 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -210,6 +210,8 @@ int main(int argc, char **argv)
                          tmp_path, test_logfile_lock);
 
     rc = g_test_run();
+    qemu_log_close();
+    rcu_wait_finished();
 
     rmdir_full(tmp_path);
     g_free(tmp_path);
diff --git a/util/rcu.c b/util/rcu.c
index 60a37f72c3..3d5ba695a4 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -234,6 +234,7 @@ retry:
 
 static void *call_rcu_thread(void *opaque)
 {
+    int *rcu_finished_ptr = (int *)opaque;
     struct rcu_head *node;
 
     rcu_register_thread();
@@ -241,6 +242,10 @@ static void *call_rcu_thread(void *opaque)
     for (;;) {
         int tries = 0;
         int n = atomic_read(&rcu_call_count);
+        if (n == 0 && atomic_mb_read(rcu_finished_ptr) == 1)
+        {
+            return NULL;
+        }
 
         /* Heuristically wait for a decent number of callbacks to pile up.
          * Fetch rcu_call_count now, we only must process elements that were
@@ -308,10 +313,12 @@ void rcu_unregister_thread(void)
     qemu_mutex_unlock(&rcu_registry_lock);
 }
 
+static QemuThread rcu_thread;
+static int rcu_finished = 0;
+
 static void rcu_init_complete(void)
 {
-    QemuThread thread;
-
+    atomic_mb_set(&rcu_finished, 0);
     qemu_mutex_init(&rcu_registry_lock);
     qemu_mutex_init(&rcu_sync_lock);
     qemu_event_init(&rcu_gp_event, true);
@@ -321,12 +328,20 @@ static void rcu_init_complete(void)
     /* The caller is assumed to have iothread lock, so the call_rcu thread
      * must have been quiescent even after forking, just recreate it.
      */
-    qemu_thread_create(&thread, "call_rcu", call_rcu_thread,
-                       NULL, QEMU_THREAD_DETACHED);
+    qemu_thread_create(&rcu_thread, "call_rcu", call_rcu_thread,
+                       &rcu_finished, QEMU_THREAD_JOINABLE);
 
     rcu_register_thread();
 }
 
+void rcu_wait_finished(void)
+{
+    if (atomic_xchg(&rcu_finished, 1) == 0)
+    {
+        qemu_thread_join(&rcu_thread);
+    }
+}
+
 static int atfork_depth = 1;
 
 void rcu_enable_atfork(void)
@@ -379,3 +394,8 @@ static void __attribute__((__constructor__)) rcu_init(void)
 #endif
     rcu_init_complete();
 }
+
+static void __attribute__((__destructor__)) rcu_uninit(void)
+{
+    rcu_wait_finished();
+}
-- 
2.28.0.windows.1


