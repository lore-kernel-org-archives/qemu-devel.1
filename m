Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722CCC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCB0206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsVjHs8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCB0206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCmO-0006m1-PV
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipCkd-0004dF-V6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipCkc-0005Re-H8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:56:03 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipCkc-0005QY-An; Wed, 08 Jan 2020 09:56:02 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so2827647wma.1;
 Wed, 08 Jan 2020 06:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qcVr5U+PaE347gU6Z5SP9PViHvCgA8hEGQiX601oVC8=;
 b=GsVjHs8GQ9BFdj0BD4UH6PXJzPqpOpQy0oD86GYjJIoJO9fhIQMnIiLlC9+hNMBWD4
 LCkvohBVeH1BJxdcYwq80OouFOjcYmp46f2VZUX0G1WValDd1sfkIWRbwAbtNX8zriio
 fKa7OqIHAy1w0Htsa0MU+GMj6aTi0gXnwrgHG7lLU6IQ2Jemo+txGNnYTWB4Z6Z3Gkuz
 ab77vCtmZKIrAghMBDvwqidWvw7YoGE+IrvERy6OGDEVc8qN1dpRABxIzm1/30U7dEHK
 zzbuowZvpizq3tiN0/X/9Ldj5MEXCrwwEQua8R8Tv9qMNQyVinmXfzMbkL8w5AMiCa3t
 irDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=qcVr5U+PaE347gU6Z5SP9PViHvCgA8hEGQiX601oVC8=;
 b=ra8o7X8tSjYiqSbKor4uV1p48BW7gb+U0XW1D4fp3augptq26CuNkilWdfJQLm3cRY
 FOGr0D/k7MqgF0tzzSn/qxRZ09LkAPQImkz7U4/2CJQZGQ25ED6w5fug4/JN6w4vdhIY
 2HbAAeqEkMB8Awsusm7u208GWlxDTsYK8QCSyJV8Yt3c6duuCwJqvZjsiDws0t3Py2Et
 9GkLSB3kucLYxpoLuwK9NQ7uZevUBstheTPR1AWP5yJtW6PD3aNRlUHWYyut+bVuyqBf
 DCRD+wYkIW4OZHp9o4xKAvDl7MFGisWy2NbFVIaGgARafxEasNQgFEcUD79m1flEh05b
 8kcQ==
X-Gm-Message-State: APjAAAVcxAOaLB6HzLsllYgT4tibBpWqW7va3ODOAiXb+2YUgiXN6qcD
 SCdlNAKXe+jxMMQN0SvFOKl9whub
X-Google-Smtp-Source: APXvYqyRPzdKIqXLdODIjRSCE1iCy+FJqVlNe/v3O1ohKV6TeM+bYkfXAt3JJo8hoaCpCKtmKXjlwA==
X-Received: by 2002:a1c:407:: with SMTP id 7mr4208946wme.29.1578495361111;
 Wed, 08 Jan 2020 06:56:01 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g21sm4703529wrb.48.2020.01.08.06.56.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 06:56:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] block/io: take bs->reqs_lock in
 bdrv_mark_request_serialising
Date: Wed,  8 Jan 2020 15:55:56 +0100
Message-Id: <1578495356-46219-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578495356-46219-1-git-send-email-pbonzini@redhat.com>
References: <1578495356-46219-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_mark_request_serialising is writing the overlap_offset and
overlap_bytes fields of BdrvTrackedRequest.  Take bs->reqs_lock
for the whole duration of it, and not just when waiting for
serialising requests, so that tracked_request_overlaps does not
look at a half-updated request.

The new code does not unlock/relock around retries.  This is unnecessary
because a retry is always preceded by a CoQueue wait, which already
releases and reacquires bs->reqs_lock.

Reported-by: Peter Lieven <pl@kamp.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c | 112 ++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 63 insertions(+), 49 deletions(-)

diff --git a/block/io.c b/block/io.c
index c466df8..1eb2b2b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -41,7 +41,6 @@
 #define MAX_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
 
 static void bdrv_parent_cb_resize(BlockDriverState *bs);
-static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags);
 
@@ -716,12 +715,69 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
     qemu_co_mutex_unlock(&bs->reqs_lock);
 }
 
+static bool tracked_request_overlaps(BdrvTrackedRequest *req,
+                                     int64_t offset, uint64_t bytes)
+{
+    /*        aaaa   bbbb */
+    if (offset >= req->overlap_offset + req->overlap_bytes) {
+        return false;
+    }
+    /* bbbb   aaaa        */
+    if (req->overlap_offset >= offset + bytes) {
+        return false;
+    }
+    return true;
+}
+
+static bool coroutine_fn
+bdrv_wait_serialising_requests_locked(BlockDriverState *bs,
+                                      BdrvTrackedRequest *self)
+{
+    BdrvTrackedRequest *req;
+    bool retry;
+    bool waited = false;
+
+    do {
+        retry = false;
+        QLIST_FOREACH(req, &bs->tracked_requests, list) {
+            if (req == self || (!req->serialising && !self->serialising)) {
+                continue;
+            }
+            if (tracked_request_overlaps(req, self->overlap_offset,
+                                         self->overlap_bytes))
+            {
+                /* Hitting this means there was a reentrant request, for
+                 * example, a block driver issuing nested requests.  This must
+                 * never happen since it means deadlock.
+                 */
+                assert(qemu_coroutine_self() != req->co);
+
+                /* If the request is already (indirectly) waiting for us, or
+                 * will wait for us as soon as it wakes up, then just go on
+                 * (instead of producing a deadlock in the former case). */
+                if (!req->waiting_for) {
+                    self->waiting_for = req;
+                    qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
+                    self->waiting_for = NULL;
+                    retry = true;
+                    waited = true;
+                    break;
+                }
+            }
+        }
+    } while (retry);
+    return waited;
+}
+
 bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 {
+    BlockDriverState *bs = req->bs;
     int64_t overlap_offset = req->offset & ~(align - 1);
     uint64_t overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
                                - overlap_offset;
+    bool waited;
 
+    qemu_co_mutex_lock(&bs->reqs_lock);
     if (!req->serialising) {
         atomic_inc(&req->bs->serialising_in_flight);
         req->serialising = true;
@@ -729,7 +785,9 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 
     req->overlap_offset = MIN(req->overlap_offset, overlap_offset);
     req->overlap_bytes = MAX(req->overlap_bytes, overlap_bytes);
-    return bdrv_wait_serialising_requests(req);
+    waited = bdrv_wait_serialising_requests_locked(bs, req);
+    qemu_co_mutex_unlock(&bs->reqs_lock);
+    return waited;
 }
 
 /**
@@ -783,20 +841,6 @@ static int bdrv_get_cluster_size(BlockDriverState *bs)
     }
 }
 
-static bool tracked_request_overlaps(BdrvTrackedRequest *req,
-                                     int64_t offset, uint64_t bytes)
-{
-    /*        aaaa   bbbb */
-    if (offset >= req->overlap_offset + req->overlap_bytes) {
-        return false;
-    }
-    /* bbbb   aaaa        */
-    if (req->overlap_offset >= offset + bytes) {
-        return false;
-    }
-    return true;
-}
-
 void bdrv_inc_in_flight(BlockDriverState *bs)
 {
     atomic_inc(&bs->in_flight);
@@ -816,45 +860,15 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
 static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self)
 {
     BlockDriverState *bs = self->bs;
-    BdrvTrackedRequest *req;
-    bool retry;
     bool waited = false;
 
     if (!atomic_read(&bs->serialising_in_flight)) {
         return false;
     }
 
-    do {
-        retry = false;
-        qemu_co_mutex_lock(&bs->reqs_lock);
-        QLIST_FOREACH(req, &bs->tracked_requests, list) {
-            if (req == self || (!req->serialising && !self->serialising)) {
-                continue;
-            }
-            if (tracked_request_overlaps(req, self->overlap_offset,
-                                         self->overlap_bytes))
-            {
-                /* Hitting this means there was a reentrant request, for
-                 * example, a block driver issuing nested requests.  This must
-                 * never happen since it means deadlock.
-                 */
-                assert(qemu_coroutine_self() != req->co);
-
-                /* If the request is already (indirectly) waiting for us, or
-                 * will wait for us as soon as it wakes up, then just go on
-                 * (instead of producing a deadlock in the former case). */
-                if (!req->waiting_for) {
-                    self->waiting_for = req;
-                    qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
-                    self->waiting_for = NULL;
-                    retry = true;
-                    waited = true;
-                    break;
-                }
-            }
-        }
-        qemu_co_mutex_unlock(&bs->reqs_lock);
-    } while (retry);
+    qemu_co_mutex_lock(&bs->reqs_lock);
+    waited = bdrv_wait_serialising_requests_locked(bs, self);
+    qemu_co_mutex_unlock(&bs->reqs_lock);
 
     return waited;
 }
-- 
1.8.3.1


