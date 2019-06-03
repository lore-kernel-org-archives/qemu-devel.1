Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C54C28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3848426622
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA6StGP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3848426622
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38271 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqVz-0008Nu-Cd
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:12:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqTz-0006qN-09
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqTx-0003kr-2T
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqTw-0003j6-Sr
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id n4so9857539wrs.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=L35OTNbs9yg6HbUzXs3zt5zUEuPf28NyMyweU1KQGGM=;
	b=cA6StGP/qgolhAyRcTTwV/40k02CJP0i+BVNSb6KcGW1e4vZKigG/ZaUP7XWSeVfww
	yuHFB3flqZ4utgpIVMRX/fUYH4ti92Vd1UcjuBR+iylLw0aA5nnych68Z+mjwNrUr1FV
	WgVGWXeUXWgo0X9rMLycK2awoXxxru9H0QvWQwi9ucR6zjaIAmoeSiJcFsonltdwhBkv
	3UJdRcN30Lu/4625CWLHPKaB8IzIjeD640vVTSLDV/1M2vN0yASfgD+uvrxTw/m5wR2i
	Ju3vYS685x9G7WXUJS8cYgvvrTTadAS6EUfg5NOZjoentKVKeIPP7GgFiEnweKumFrMe
	XsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=L35OTNbs9yg6HbUzXs3zt5zUEuPf28NyMyweU1KQGGM=;
	b=ra8AfOaizDSFFACIBAxyNkbZC3fAZmUKEjJ9ZXZeAtbNDvwCRqUwJaMiysnj1kOhqu
	DcQFJUVR9XJAwWgKODpaZTOx00OwHjHyfUsNHJy1sNhCQgu+GqOEysnlsaH0fliaHwah
	p+PXrbeYOHtDv7HEGmZJuF+Vl5MMlS7QecVSesuWlqxXoN3srYDpwStWjTIYtI3GKMGN
	M1KUwGQU7rBEnpz+aWLPOJuaSGJHCwMu9z7hqz9Ki8qaa67jVvXlPXoF57fMCQkrtgrT
	J0sDx4i75ZrBSIOgRo6o2nv16uOB6kcKTOjBs3lu1Tpj6bZGvhPKcsLG+vUr3GwWwPDj
	uTvQ==
X-Gm-Message-State: APjAAAWukZpCmcCSfq4LtayE2yoe0tynXVwJUr6ZMQtwqgHbtX44smxY
	c2LjFiDc4th6Wuuf5Ob4dTj7TcKg
X-Google-Smtp-Source: APXvYqxc14Qnv7VLFvnVqIaVVnthxMIRKnWeWyMW1jVwL4YP13CSSo4B5PHCJwPV/mDf/7ZEnXbH0Q==
X-Received: by 2002:adf:f544:: with SMTP id j4mr3420888wrp.150.1559581847378; 
	Mon, 03 Jun 2019 10:10:47 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.45 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:20 +0200
Message-Id: <1559581843-3968-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 01/24] test-thread-pool: be more reliable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a rare race between the atomic_cmpxchg and
bdrv_aio_cancel/bdrv_aio_cancel_async invocations.  Detect it, the
only sensible we can do about it is to exit long_cb immediately.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-thread-pool.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tests/test-thread-pool.c b/tests/test-thread-pool.c
index 9cdccb3..0b67592 100644
--- a/tests/test-thread-pool.c
+++ b/tests/test-thread-pool.c
@@ -27,9 +27,10 @@ static int worker_cb(void *opaque)
 static int long_cb(void *opaque)
 {
     WorkerTestData *data = opaque;
-    atomic_inc(&data->n);
-    g_usleep(2000000);
-    atomic_inc(&data->n);
+    if (atomic_cmpxchg(&data->n, 0, 1) == 0) {
+        g_usleep(2000000);
+        atomic_or(&data->n, 2);
+    }
     return 0;
 }
 
@@ -171,7 +172,7 @@ static void do_test_cancel(bool sync)
     /* Cancel the jobs that haven't been started yet.  */
     num_canceled = 0;
     for (i = 0; i < 100; i++) {
-        if (atomic_cmpxchg(&data[i].n, 0, 3) == 0) {
+        if (atomic_cmpxchg(&data[i].n, 0, 4) == 0) {
             data[i].ret = -ECANCELED;
             if (sync) {
                 bdrv_aio_cancel(data[i].aiocb);
@@ -185,7 +186,7 @@ static void do_test_cancel(bool sync)
     g_assert_cmpint(num_canceled, <, 100);
 
     for (i = 0; i < 100; i++) {
-        if (data[i].aiocb && data[i].n != 3) {
+        if (data[i].aiocb && atomic_read(&data[i].n) < 4) {
             if (sync) {
                 /* Canceling the others will be a blocking operation.  */
                 bdrv_aio_cancel(data[i].aiocb);
@@ -201,13 +202,22 @@ static void do_test_cancel(bool sync)
     }
     g_assert_cmpint(active, ==, 0);
     for (i = 0; i < 100; i++) {
-        if (data[i].n == 3) {
+        g_assert(data[i].aiocb == NULL);
+        switch (data[i].n) {
+        case 0:
+            fprintf(stderr, "Callback not canceled but never started?\n");
+            abort();
+        case 3:
+            /* Couldn't be canceled asynchronously, must have completed.  */
+            g_assert_cmpint(data[i].ret, ==, 0);
+            break;
+        case 4:
+            /* Could be canceled asynchronously, never started.  */
             g_assert_cmpint(data[i].ret, ==, -ECANCELED);
-            g_assert(data[i].aiocb == NULL);
-        } else {
-            g_assert_cmpint(data[i].n, ==, 2);
-            g_assert(data[i].ret == 0 || data[i].ret == -ECANCELED);
-            g_assert(data[i].aiocb == NULL);
+            break;
+        default:
+            fprintf(stderr, "Callback aborted while running?\n");
+            abort();
         }
     }
 }
-- 
1.8.3.1



