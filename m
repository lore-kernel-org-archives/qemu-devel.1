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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B470C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B5420658
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdjv6DK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B5420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjfu-0005ez-Qx
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjch-0007Oj-MF; Tue, 08 Sep 2020 15:49:47 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjcg-0002Za-0Z; Tue, 08 Sep 2020 15:49:47 -0400
Received: by mail-pg1-x543.google.com with SMTP id v15so297678pgh.6;
 Tue, 08 Sep 2020 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mis/yrVWeY+EL6B3pLHydPEbEg8SDdnmsH3w5+AQmwk=;
 b=pdjv6DK2sXnNkV4WyJA5AnDPpSusmMZ8P9FJ6/K3nDcsYAuKUben43m+b3LZl5BS1p
 QnW2dZvjGfISKebySIomBqTWDm5xa89rSferkqUUYxLYlZd7GGWwTbLcqvQEVaDR/B3j
 pLd+3YhpDRiZNJlE+pyy2pbYQrvOD6DmfkjPjAfYkidpMA5QS+5kLyqR5d7887wJs2oa
 1eFY+GE/TAY428vGtseYEdBmDWe6mrlGBSAEWohimQ2AGQlbo6Q0al7tekuHYcEkcfzl
 wAxjVhR5Nq1jYWMdb5qv1N85TMgEF8Ryilmu1X2H9HOdaDXJoNtUgcGrsgNmxxL4DZLx
 35tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mis/yrVWeY+EL6B3pLHydPEbEg8SDdnmsH3w5+AQmwk=;
 b=sQvDSYqEZbUK/sYYeIShIvCmmo5PV7nBmUUMx5fp9ueAOxbeybnmUHy2G56hivy+Gk
 VJpyoMZ7SoQHeH+iZBzN7brfrHB/RhPuuVgmi/RIXyMg4PDRRRONLEe0D5ypXmjepRon
 puw9zSKgc3FA/DEL/5RCAkIdUeA6nwm7LVOsJ59q0G+Xn4Y3amB1czcu7DAJ7O3NA8Br
 OnnIf2r9HtYnJIV1Ufh2/EMjNdGF+OYXQEq1AGGkksIWesz7rPEHNJtxYxjTpaL9csak
 ylvta5HFhrbc1Oy3niUE5dnpONWtSpD/zT6gvo8nwb1z9c2kZUlhQFEHB5nS+NCbYHFq
 INHg==
X-Gm-Message-State: AOAM533WWPqZAK2eQrWMEE0RDE6TGd62+xsBxAn9J0nn3fh8wWBM4Ux+
 zfN9LRMurdACpOe1v7wfgrBS1u2UH0CfiBFk
X-Google-Smtp-Source: ABdhPJwYvcMEOL5IhmQwJqYtLcqd6NNGfn8WKwiWzfaVRLdwNyBLflmEtMtt28D8Z7MeQ/T6ZqksOQ==
X-Received: by 2002:a63:5d4a:: with SMTP id o10mr268551pgm.346.1599594584013; 
 Tue, 08 Sep 2020 12:49:44 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id n127sm216922pfn.155.2020.09.08.12.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 12:49:43 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/16] rcu: add uninit destructor for rcu
Date: Wed,  9 Sep 2020 03:48:20 +0800
Message-Id: <20200908194820.702-17-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908194820.702-1-luoyonggang@gmail.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Lieven <pl@kamp.de>
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
 util/rcu.c           | 37 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

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
index 60a37f72c3..43367988b9 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -308,10 +308,20 @@ void rcu_unregister_thread(void)
     qemu_mutex_unlock(&rcu_registry_lock);
 }
 
+typedef struct QemuRcuMessage {
+    struct rcu_head rcu;
+    void *message;
+} QemuRcuMessage;
+
+static int rcu_thread_exit_called = 0;
+static int rcu_thread_exited = 0;
+static QemuRcuMessage rcu_thread_message;
+
 static void rcu_init_complete(void)
 {
     QemuThread thread;
-
+    atomic_mb_set(&rcu_thread_exit_called, 0);
+    atomic_mb_set(&rcu_thread_exited, 0);
     qemu_mutex_init(&rcu_registry_lock);
     qemu_mutex_init(&rcu_sync_lock);
     qemu_event_init(&rcu_gp_event, true);
@@ -327,6 +337,26 @@ static void rcu_init_complete(void)
     rcu_register_thread();
 }
 
+static void rcu_thread_exit(QemuRcuMessage *param)
+{
+    atomic_mb_set((int*)param->message, 1);
+    qemu_thread_exit(NULL);
+}
+
+void rcu_wait_finished(void)
+{
+    if (atomic_xchg(&rcu_thread_exit_called, 1) == 0)
+    {
+        rcu_thread_message.message = &rcu_thread_exited;
+        call_rcu(&rcu_thread_message, rcu_thread_exit, rcu);
+    }
+
+    while (atomic_mb_read(&rcu_thread_exited) == 0)
+    {
+        g_usleep(10000);
+    }
+}
+
 static int atfork_depth = 1;
 
 void rcu_enable_atfork(void)
@@ -379,3 +409,8 @@ static void __attribute__((__constructor__)) rcu_init(void)
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


