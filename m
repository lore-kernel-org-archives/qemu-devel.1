Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA88C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE52C21D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4LOm3jB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE52C21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwo1-0000tT-LP
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhe-0007PI-Te; Wed, 09 Sep 2020 05:47:46 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhc-0007ms-Vy; Wed, 09 Sep 2020 05:47:46 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mm21so1062114pjb.4;
 Wed, 09 Sep 2020 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=faIdeALUAvLzj2kx9mbA5+e0PxUK1yXyWPv+NWO3/qo=;
 b=G4LOm3jBbJ1twzr17e/NtytI0gmonbXYgPwwv6iMltAQhv7FdVgulOLV1gqahG4xrG
 R2MtLQLDfhXHfQclUDcuacQezz0wlcHl9Jw+lypTB5mPaDU4CJvjmZqW2OmoIojogJ6L
 zgeBLX7FDK/R+x2PNSsC7P9gCyQS2rNEjLI2LIlibJdtx/uM3oVX4pbsGfhfbbnINhJM
 PRywuAl0QHg4kYt05G5nUTGziZ7uI+1D1ZTzsgGnIk1vHPSdFxFZaAufBApyjlLKDwez
 nxpovOA/wIqw8UIQwnLez0iBanReo06r4vmDNFNtBbzYX7GfFFkffJfOSLQrFBYN5PQk
 7sOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=faIdeALUAvLzj2kx9mbA5+e0PxUK1yXyWPv+NWO3/qo=;
 b=uJDMKWlhX7T4tqiCtI84wEfA6PYZNdIvEmYzvs1tMDkAoETNB0Czr1KrL1K/ekaxyT
 +zXrn7GlqDas3Ax6nJy0EbNt64tgA/i9ktD5VU2cCl3WUINaiCyKUTsgM9zwcKA0KO6M
 XKFvMLTu0X0b7qyH+KH2arxMynd+AwTPY94qBEJAufYL4ELB4MOOD0VQmTkETgJdatdF
 huNrwif4D4Ag2gPA/JHbiXhgWjCRE7Q60cmQ337bwAAs69WXYPmA2kvryoUUyJL1Xg+I
 eSUlZeGC0FcKF4oHt/4UeGza2nzLGYNWCcu5zac5XLDC9qgwuNnI7ruGWryVGrsrD8W7
 +SxQ==
X-Gm-Message-State: AOAM531RH2Ix+8lkdUIX5yMFcoQIzFGbejh+cm1J6x1/Tg42kKb030qE
 zfqTUL5PgdbwV08KOObE4KioVzLeYeHfFVQi
X-Google-Smtp-Source: ABdhPJzLPE/Mchrbh0iTFyjsCW7aPQ5RuuyT6Gz85HoER/Lvym9aSfIa6A4Vqr4qK3SNQO+xc3+HyA==
X-Received: by 2002:a17:90b:289:: with SMTP id az9mr107979pjb.31.1599644861563; 
 Wed, 09 Sep 2020 02:47:41 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:47:40 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/21] rcu: add uninit destructor for rcu
Date: Wed,  9 Sep 2020 17:46:12 +0800
Message-Id: <20200909094617.1582-17-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1042.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
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
index 783fe09a27..1fac9250aa 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -210,6 +210,8 @@ int main(int argc, char **argv)
                          tmp_path, test_logfile_lock);
 
     rc = g_test_run();
+    qemu_log_close();
+    rcu_wait_finished();
 
     rmdir_full(tmp_path);
     return rc;
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


