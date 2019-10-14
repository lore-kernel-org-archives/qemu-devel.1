Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A0AECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB712084B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2ej4W3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB712084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyH9-0005hZ-H6
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iJy1i-0005y8-BA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iJy1g-0004Zq-4n
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:56:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iJy1e-0004VI-QH; Mon, 14 Oct 2019 06:56:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id a6so16735559wma.5;
 Mon, 14 Oct 2019 03:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fpVCniRK6qIUkUWwjCvekvk/Zya7KZVpgagyAg4Va7E=;
 b=P2ej4W3YzxaUjqqMxBZ0lbQJLWqgq6A7WyXgIMKImSHEK5t08tedvQ1bFuT3DFdIPY
 PL6mLWCZAgeAVPKYWUIFTWEv6YhMALQMQ9m8J10pU73cksnzRhRUTQab/CqCshGcD+qe
 AjIPWQUEYlCn6PhpvhfNdv5UT1YlibT2g7UQY7lnyeBtY9sb0FU2Od33pMQBwfHNf92D
 Ie9LXyJDAcZN0QapP7gXs3gk+RobLol4rKukwsBz2GgdKZ2pYU01eCs06w7fAdhoTgYs
 i70I9CN76EQ6xMZD91lCGtArhECUb81ouN/E1arVFUlPmFEuQx9VR/qeqzSjC/dhSwwt
 5cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=fpVCniRK6qIUkUWwjCvekvk/Zya7KZVpgagyAg4Va7E=;
 b=SFyP8OI7KzQWg6+cUsxhaRdpwh/vohoXe4gXZETvPoHk2j8Vqx8P0dixGQ4Ru9wXF1
 WlnM3g3Z4iXNJDbMHTT9pyoW0N18tUp3yFHZ5VI2EPjvBO9yzRjOTJQZx0NjtXdMVCGF
 lgSbVGdSF5UM7hZEeSAetAiHZ84alO4qFu2VZEjirxtZFCg7t5aCoDs6wUsi3PXgS9fd
 HpDLYJsLG3oUjd27KwtbwIUHt6Q4npPFGQjiFHF24h7G5eNP3vqRkBYz06WwRYANaQFc
 GY9OM5o0PHzxFp43eGQU+AIXzn52npSiHn0GbzkNv1jj5jAO7W8Gxoov+o04uCiEQOZh
 ehTg==
X-Gm-Message-State: APjAAAVk+KwiUHCJM5ILaaRv78y8je58PMqwLTYgaFjWViM/ccjWm4He
 IOiOWAIGX6Wdi+7lxO88JyIRLMj7
X-Google-Smtp-Source: APXvYqyYAasWyajZoapl0hwR2HCIm238IshjLcUPX+Dp0i8UCvrIbUodFSyDg6FrEovHeO0E6BzEeA==
X-Received: by 2002:a1c:a444:: with SMTP id n65mr15078584wme.111.1571050587280; 
 Mon, 14 Oct 2019 03:56:27 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
 by smtp.gmail.com with ESMTPSA id s10sm33921404wmf.48.2019.10.14.03.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:56:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests: fix iothread_join() race condition
Date: Mon, 14 Oct 2019 12:56:27 +0200
Message-Id: <20191014105627.26977-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a similar race condition to the one fixed in commit 2362a28ea1
("iothread: fix iothread_stop() race condition", 2017-12-19), which in this case
was exposed as a failure in test-aio-multithread.  Here, the iothread->stopping
flag was set too soon, and the AioContext could be destroyed before the
last round of entering scheduled coroutines and bottom halves.  The fix is
similar.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/iothread.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/iothread.c b/tests/iothread.c
index 777d9eea46..1e6d3e2218 100644
--- a/tests/iothread.c
+++ b/tests/iothread.c
@@ -26,6 +26,7 @@ struct IOThread {
     QemuMutex init_done_lock;
     QemuCond init_done_cond;    /* is thread initialization done? */
     bool stopping;
+    bool running;
 };
 
 static __thread IOThread *my_iothread;
@@ -47,7 +48,7 @@ static void *iothread_run(void *opaque)
     qemu_cond_signal(&iothread->init_done_cond);
     qemu_mutex_unlock(&iothread->init_done_lock);
 
-    while (!atomic_read(&iothread->stopping)) {
+    while (iothread->running) {
         aio_poll(iothread->ctx, true);
     }
 
@@ -55,10 +56,26 @@ static void *iothread_run(void *opaque)
     return NULL;
 }
 
+/* Runs in iothread_run() thread */
+static void iothread_stop_bh(void *opaque)
+{
+    IOThread *iothread = opaque;
+
+    iothread->running = false; /* stop iothread_run() */
+}
+
 void iothread_join(IOThread *iothread)
 {
+    /* Forbid reentering iothread_join.  */
+    assert(!iothread->stopping);
     iothread->stopping = true;
-    aio_notify(iothread->ctx);
+
+    /*
+     * Force the loop to run once more, so that already scheduled bottom
+     * halves and coroutines are executed.
+     */
+    aio_bh_schedule_oneshot(iothread->ctx, iothread_stop_bh, iothread);
+
     qemu_thread_join(&iothread->thread);
     qemu_cond_destroy(&iothread->init_done_cond);
     qemu_mutex_destroy(&iothread->init_done_lock);
@@ -76,6 +93,7 @@ IOThread *iothread_new(void)
                        iothread, QEMU_THREAD_JOINABLE);
 
     /* Wait for initialization to complete */
+    iothread->running = true;
     qemu_mutex_lock(&iothread->init_done_lock);
     while (iothread->ctx == NULL) {
         qemu_cond_wait(&iothread->init_done_cond,
-- 
2.21.0


