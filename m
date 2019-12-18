Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B35C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6444D2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q71I9QA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6444D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZHA-0003xI-Jr
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihZCU-0006fT-KV
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:17:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihZCT-00006Z-1z
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:17:14 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36799)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihZCS-0008Sv-Ox
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:17:12 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so2280141wru.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 05:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EIhNMqQ5gIhltsUn6hlrMExKL0eOLwZAeR0KE+AGHEo=;
 b=Q71I9QA3mK0w5OTJgEjIh/TQWWPkIIlNjlGAW6KCUpOSaI5DWkId7KDITA30rm2/cL
 Ni3Dh0IcwvaZ2/nDFl1CGh98CKz6yzQ+h016yRLpkmYMYC/tixlvUZHMRP7GdEaAq2w7
 h35pnGJW7KB/dfFnvJH1qr3H0AnXpKt/x9tCNvNZckNDsZyKa0Cge5k4lXoY9uSSAcZQ
 1V3yXmhyNSiqGJbB/WKfYAhslv2rfWq7vIFFOTc3SfIxsYhnocISntLGKLsDGpEWQbBV
 2+ppCW8zsmbcaZJuDncKi1xqgqdYM6xV9CNIA9P03Svo1WDr7LLIuRSDjRumJ3pxXqbe
 5W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=EIhNMqQ5gIhltsUn6hlrMExKL0eOLwZAeR0KE+AGHEo=;
 b=PGRb7tQDXPK9/uhsMJza5efNiqCquxVFeQWkcz9qrEK8/ByGeHENlsc9Fnm/nErFCn
 84BF0ARiyMpNtQJg5TTye5Ox2WPzV9nE81w4mDqPs7+e6jVBIEZDvpRTRY4OxznCFX06
 UViQ+cpUVBUjN2hYoYJaf+8A/yxL2oBfLqogXQKtOJR6wl633v2tRrjHt7nvBDKhzzy+
 JylHr86uonlYGjfLGyTRaD2uCF1YuzvzKtRFb4JTlcTWSxEBLqpuNbL+ltaJFP2wH4dG
 XNu1TS+p0REPnt3fO8LDMg4XKXC95yBTKRs8cCgP7rgds/pv5mwvgAXPJIcZ17yMl51Q
 5nlQ==
X-Gm-Message-State: APjAAAVLh92R3ZeQdXw4NUdC4tvIX+APZMU3j9ErIJwKlIW9jX5EdOfB
 JdwyfAxR7uWFqQw5VKTtn0W0/Hu3
X-Google-Smtp-Source: APXvYqyHf+nGkOYWtQ72z2/HE1SZWKyot7lOEN0x3LiH0Gj8ymZ4Kp9s4Cwt0LFECBxX+bkl/dXerA==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr2872485wrw.31.1576675031543; 
 Wed, 18 Dec 2019 05:17:11 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id t1sm2447980wma.43.2019.12.18.05.17.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 05:17:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] block/io: take bs->reqs_lock in
 bdrv_mark_request_serialising
Date: Wed, 18 Dec 2019 14:17:06 +0100
Message-Id: <1576675026-25046-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576675026-25046-1-git-send-email-pbonzini@redhat.com>
References: <1576675026-25046-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: kwolf@redhat.com, Peter Lieven <pl@kamp.de>, qemu-block@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_mark_request_serialising is writing the overlap_offset and
overlap_bytes fields of BdrvTrackedRequest.  Take bs->reqs_lock
for the whole direction of it, and not just when waiting for
serialising requests, so that tracked_request_overlaps does not
look at a half-updated request.

The new code does not unlock/relock around retries.  This is unnecessary
because a retry is always preceded by a CoQueue wait, which already
releases and reacquired bs->reqs_lock.

Reported-by: Peter Lieven <pl@kamp.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c | 112 ++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 63 insertions(+), 49 deletions(-)

diff --git a/block/io.c b/block/io.c
index e844c4b..166c2c1 100644
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


