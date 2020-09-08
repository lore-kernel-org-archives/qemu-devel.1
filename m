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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9D8C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA422087C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBSin0nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA422087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFipO-0002cW-Dw
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFiha-0003pI-CE; Tue, 08 Sep 2020 14:50:46 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFihX-0002pI-41; Tue, 08 Sep 2020 14:50:46 -0400
Received: by mail-pg1-x544.google.com with SMTP id m8so204140pgi.3;
 Tue, 08 Sep 2020 11:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mis/yrVWeY+EL6B3pLHydPEbEg8SDdnmsH3w5+AQmwk=;
 b=UBSin0ndWEHAjF6GgrKZbSQKKYKK4pOceqTUYQX5FPchRJGqE8HQrNsJEHacjbtc9L
 7tWIskMBcG5jnTAtzvAybNrYfqXKEf6GimDWtnrQjD1x97RNXxreOck3RQ0MdAlfsPMY
 Ify4rk8z3/wKiVUiLDK6+4pXEq95z/pY+5jlgb2/rW2cguH2sppso1O+or6JipzI8y+a
 hktE4XK4/Cqm6gBD6ppNwUpRWfQcnHXirQGkvA7DjPK9YEz3DsZ+W9PVf71rSidOgUR2
 KlzkHvEGlfK+qsCdd0XNMs6tYWjKRteYiNZh/hPNbmipwpK+jBmjIDGfvriuVcpJUrXl
 FFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mis/yrVWeY+EL6B3pLHydPEbEg8SDdnmsH3w5+AQmwk=;
 b=SsXQuR2wqMm9/e7TJ4swua2wp+f8uahueg1fYBSrCBO3kEHY7IHey4PRqWRRCFHEtq
 kdqT5Pg61f4TlH+bx06lvRh3xsn7Za/wGnTGqtZgpXyrVtf8uAqyWH71TNR6Gge10saL
 rh5XQmSNYBurgQXA3cHjpm7Hig2TuV6tCkYyDimmoCbKwDAgQpxgyBlrvtQpZVeZ127Z
 fLaZk87F0dvy5YX+a05ehFLx1wjGcubc0G8VTD6xnaSGs+k9FJQ/FbmwWYsXLi+Z7SRk
 SyHEItGWSxStM/e17Tgd9XmRgZPFE6PTcqTScFGODEllMlt+l739M2a6xqGUNwLc7S/1
 zQMw==
X-Gm-Message-State: AOAM533c6hDHlX96N+7YsBEezXMUea93AB4EcWOpgkhhH9ZjhTUtkyNi
 Krx76stFSPgRIuVeACosy2Cinq0Nk5JMchds
X-Google-Smtp-Source: ABdhPJwt3qCC3t8ZqV9ZMa9sep3CmFCK1vUHHzEa9xLHn4t7gwOhWBUp+G1W7O7miLis2bTe+pE64w==
X-Received: by 2002:a63:7a5b:: with SMTP id j27mr137161pgn.78.1599591041054;
 Tue, 08 Sep 2020 11:50:41 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:50:40 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] rcu: add uninit destructor for rcu
Date: Wed,  9 Sep 2020 02:49:18 +0800
Message-Id: <20200908184918.1085-17-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
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
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
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


