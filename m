Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95098C28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6472520679
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8tB8Qfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6472520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46789 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKpV-0001Xf-Mr
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51400)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKh8-0000Vy-4A
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKh5-0002EF-8L
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:50:41 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1haKh4-0002B5-6y; Mon, 10 Jun 2019 09:50:39 -0400
Received: by mail-pg1-x541.google.com with SMTP id k187so4592321pga.0;
 Mon, 10 Jun 2019 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vDO5Ye23yozG3b4R1EbS2QLkzaqorKA/jm8V7Qr1Jtg=;
 b=l8tB8QfjFkx6HUbMjkiM8FAVD6W9b2pgnNgdYCS1njuGAzn9S90X7t8AJfst6w0kul
 UJz6yJc4yY7qStjJmOH6ubuBot21NhvEmiHxOrtnbDEaIT5Z1A4+fKrAAgTgvkMaGTc+
 I8QvXTtY0LPCvCh+EXtFUBeHuVcLUuD5LWMp5mOqdFZQA12UI2knqATDETNnOqjeXWE9
 rHEoNf0vGtx3EHP8kcxDQdj3l/Nrd2hhcyc8Yt8nx4Cws/9K+YeuF5g71v05b2TJ/vj+
 5smuOKH+uAMbPicutMPwHxDt2qlHWD6hKm60yHB1Df1g1F8W5Tp6SzqojcoxXmwa78tv
 ydgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vDO5Ye23yozG3b4R1EbS2QLkzaqorKA/jm8V7Qr1Jtg=;
 b=oImarehvpIKet4c4i3asB75RQ9yX7Q9M5TAyaV+BwaAi9YajZcfIJJ9Hra2KwfriKc
 EMHpv5erqr38pU/hOlOBlF7wukThfsVRgaV/LEiEMQ0GUs30rh+WU2xjw/wWclaDGyDG
 uu9SOU+9OxdeATI1NFZMzi262ddXxo5gDLx7bUILIWPTQolM30DhHX60IwHkD2oI4GfD
 B6e2RgfIIYfA9b4Hm3mgQCxMR6jdNhmMAJDIq8F81NId88E6q3Fzo2QBGP/yar5WzRSG
 1BYsDXFxB7PG5AEugQJ6qzCWBBhx2KGrr/rUNDMfDD0K7e/e3EOiS7IF0Em2d6cIaQCq
 gDLQ==
X-Gm-Message-State: APjAAAV3l5erB7X3NHxKfDzxVDMTITXIJ6QrdVJRO1OSmd+5yIq214wB
 9+mHKExAbCjH25GD/2wKJmrmec2lQs3IUQ==
X-Google-Smtp-Source: APXvYqxTIxicu62wkb3SPpCoZ4S2v/V3tkxWEGO44BRvM9+JE/nTSZuV2qeqimVH+QuetIDPTiKxuQ==
X-Received: by 2002:a62:5486:: with SMTP id
 i128mr74383752pfb.156.1560174632531; 
 Mon, 10 Jun 2019 06:50:32 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
 by smtp.gmail.com with ESMTPSA id d4sm13969837pfc.149.2019.06.10.06.50.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 06:50:31 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 19:19:02 +0530
Message-Id: <20190610134905.22294-10-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610134905.22294-1-mehta.aaru20@gmail.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v5 09/12] block: add trace events for io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 block/io_uring.c   | 14 ++++++++++++--
 block/trace-events |  8 ++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index f327c7ef96..47e027364a 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -17,6 +17,7 @@
 #include "block/raw-aio.h"
 #include "qemu/coroutine.h"
 #include "qapi/error.h"
+#include "trace.h"
 
 #define MAX_EVENTS 128
 
@@ -191,12 +192,15 @@ static int ioq_submit(LuringState *s)
 
 void luring_io_plug(BlockDriverState *bs, LuringState *s)
 {
+    trace_luring_io_plug();
     s->io_q.plugged++;
 }
 
 void luring_io_unplug(BlockDriverState *bs, LuringState *s)
 {
     assert(s->io_q.plugged);
+    trace_luring_io_unplug(s->io_q.blocked, s->io_q.plugged,
+                                 s->io_q.in_queue, s->io_q.in_flight);
     if (--s->io_q.plugged == 0 &&
         !s->io_q.blocked && s->io_q.in_queue > 0) {
         ioq_submit(s);
@@ -217,6 +221,7 @@ void luring_io_unplug(BlockDriverState *bs, LuringState *s)
 static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
                             uint64_t offset, int type)
 {
+    int ret;
     struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
     if (!sqes) {
         sqes = &luringcb->sqeq;
@@ -242,11 +247,14 @@ static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
     }
     io_uring_sqe_set_data(sqes, luringcb);
     s->io_q.in_queue++;
-
+    trace_luring_do_submit(s->io_q.blocked, s->io_q.plugged,
+                           s->io_q.in_queue, s->io_q.in_flight);
     if (!s->io_q.blocked &&
         (!s->io_q.plugged ||
          s->io_q.in_flight + s->io_q.in_queue >= MAX_EVENTS)) {
-        return ioq_submit(s);
+        ret = ioq_submit(s);
+        trace_luring_do_submit_done(ret);
+        return ret;
     }
     return 0;
 }
@@ -294,6 +302,7 @@ LuringState *luring_init(Error **errp)
     int rc;
     LuringState *s;
     s = g_malloc0(sizeof(*s));
+    trace_luring_init_state((void *)s, sizeof(*s));
     struct io_uring *ring = &s->ring;
     rc =  io_uring_queue_init(MAX_EVENTS, ring, 0);
     if (rc < 0) {
@@ -311,4 +320,5 @@ void luring_cleanup(LuringState *s)
 {
     io_uring_queue_exit(&s->ring);
     g_free(s);
+    trace_luring_cleanup_state();
 }
diff --git a/block/trace-events b/block/trace-events
index eab51497fc..c4564dcd96 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -60,6 +60,14 @@ qmp_block_stream(void *bs, void *job) "bs %p job %p"
 file_paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "acb %p opaque %p offset %"PRId64" count %d type %d"
 file_copy_file_range(void *bs, int src, int64_t src_off, int dst, int64_t dst_off, int64_t bytes, int flags, int64_t ret) "bs %p src_fd %d offset %"PRIu64" dst_fd %d offset %"PRIu64" bytes %"PRIu64" flags %d ret %"PRId64
 
+#io_uring.c
+luring_init_state(void *s, size_t size) "s %p size %zu"
+luring_cleanup_state(void) "s freed"
+disable luring_io_plug(void) "plug"
+disable luring_io_unplug(int blocked, int plugged, int queued, int inflight) "blocked %d plugged %d queued %d inflight %d"
+disable luring_do_submit(int blocked, int plugged, int queued, int inflight) "blocked %d plugged %d queued %d inflight %d"
+disable luring_do_submit_done(int ret) "submitted to kernel %d"
+
 # qcow2.c
 qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
 qcow2_writev_done_req(void *co, int ret) "co %p ret %d"
-- 
2.17.1


