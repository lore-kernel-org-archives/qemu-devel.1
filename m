Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332F8C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 12:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B302084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 12:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbDEBq8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B302084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40320 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDpsV-00032r-2y
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 08:29:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDprU-0002ZX-6P
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDprT-00056Q-6F
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:28:24 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:33348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDprS-000562-Tv; Tue, 09 Apr 2019 08:28:23 -0400
Received: by mail-wr1-x42f.google.com with SMTP id q1so20682261wrp.0;
	Tue, 09 Apr 2019 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=VwkzIm+GdP9ilB0XCdR4w1omZCih5X4z6ryAVHSZ/Wc=;
	b=gbDEBq8iHZktipbhTJfnx8NCrvWpNTAfwvoqhGoOdR4cSfz4z6Lebk0jOTl2o5K6s+
	qcdxPe7RmWbMNfO8IXwm+gFWukEBAKuY3hSV4xmT4AWTC1fHUu1hjllyZ8LAN9g/UWs0
	jQ868GYThnf7dJ3p/7UTaQmsNR7AWPHGLQT8D3FsgYbRzpZKs1yQaZBJWrKv0O8GhBIl
	DSUDyUKUdaGc+FktGTTLZyJWXgqwEWTCOP+SK3AzBgLC1N5hyRKn97wnircYU7Y/UqK9
	kWTb9tSGfiFRlGO9FCIgJfBG7B74xeoU4B/knCLdHqzvXJ8IvoOHafJG/NzQe54KfNj4
	/GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=VwkzIm+GdP9ilB0XCdR4w1omZCih5X4z6ryAVHSZ/Wc=;
	b=p7Vc/p7T1JZVx8yw2SzKlEHSKtA29cmLfJpV1UA+H5xXC24POKsAXKeVhLLZfTKbtT
	F+aTqY2wz7a2iGix6Ee1PUEBr+IfIVX3VHU4c3HBXmcSuuUDYTUjk8E6Lf87FJMK/OuR
	TRxgT46nDFJmNBMtBL6Ue2O8VS+308M5RIgN8XKOU4lFISVKymNMZfK8Neeq70tqIgsD
	0Alg9El9uGT96WpGpkDxbM/Wk8z6Trl0Gb3EnnU60nqCp+f21GN3bDXK9c7nPiijnCRI
	WJcI6JoAB5LfahlwvX9Gsr08JCO0amjpGpoKtsHLRRGJR6h1ArFlHocxDp74/WxK/EQG
	kBTg==
X-Gm-Message-State: APjAAAW4ttbRjGt66gLRe7LwZ1SBsP3T6joYE9LPzp89aq6W7oCW3nUn
	GbIAEtUNvkGtxXjBQgfRUt01h/HY
X-Google-Smtp-Source: APXvYqxmih+EN4wwtJseVJp4WPvddOGYlQE/jtJac9qwhqQx0zM6hCC6iKelAAJjdpSp3Flc6WdrFA==
X-Received: by 2002:adf:f286:: with SMTP id k6mr19632230wro.137.1554812900848; 
	Tue, 09 Apr 2019 05:28:20 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:1015:663:c7e9:4214])
	by smtp.gmail.com with ESMTPSA id
	84sm22940820wme.43.2019.04.09.05.28.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Apr 2019 05:28:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 14:28:23 +0200
Message-Id: <20190409122823.12416-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PATCH v2 for-4.0?] aio-posix: ensure poll mode is
 left when aio_notify is called
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409122823.rLKzILyQYwHkLKxNu4cJR_dHCf6gX9KavCBoSOB6K34@z>

With aio=thread, adaptive polling makes latency worse rather than
better, because it delays the execution of the ThreadPool's
completion bottom half.

event_notifier_poll() does run while polling, detecting that
a bottom half was scheduled by a worker thread, but because
ctx->notifier is explicitly ignored in run_poll_handlers_once(),
scheduling the BH does not count as making progress and
run_poll_handlers() keeps running.  Fix this by recomputing
the deadline after *timeout could have changed.

With this change, ThreadPool still cannot participate in polling
but at least it does not suffer from extra latency.

Reported-by: Sergio Lopez <slp@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1553692145-86728-1-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2: use qemu_soonest_timeout to handle timeout == -1
 util/aio-posix.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 6fbfa7924f..db11021287 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -519,6 +519,10 @@ static bool run_poll_handlers_once(AioContext *ctx, int64_t *timeout)
         if (!node->deleted && node->io_poll &&
             aio_node_check(ctx, node->is_external) &&
             node->io_poll(node->opaque)) {
+            /*
+             * Polling was successful, exit try_poll_mode immediately
+             * to adjust the next polling time.
+             */
             *timeout = 0;
             if (node->opaque != &ctx->notifier) {
                 progress = true;
@@ -558,8 +562,9 @@ static bool run_poll_handlers(AioContext *ctx, int64_t max_ns, int64_t *timeout)
     do {
         progress = run_poll_handlers_once(ctx, timeout);
         elapsed_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time;
-    } while (!progress && elapsed_time < max_ns
-             && !atomic_read(&ctx->poll_disable_cnt));
+        max_ns = qemu_soonest_timeout(*timeout, max_ns);
+        assert(!(max_ns && progress));
+    } while (elapsed_time < max_ns && !atomic_read(&ctx->poll_disable_cnt));
 
     /* If time has passed with no successful polling, adjust *timeout to
      * keep the same ending time.
@@ -585,8 +590,7 @@ static bool run_poll_handlers(AioContext *ctx, int64_t max_ns, int64_t *timeout)
  */
 static bool try_poll_mode(AioContext *ctx, int64_t *timeout)
 {
-    /* See qemu_soonest_timeout() uint64_t hack */
-    int64_t max_ns = MIN((uint64_t)*timeout, (uint64_t)ctx->poll_ns);
+    int64_t max_ns = qemu_soonest_timeout(*timeout, ctx->poll_ns);
 
     if (max_ns && !atomic_read(&ctx->poll_disable_cnt)) {
         poll_set_started(ctx, true);
-- 
2.21.0


