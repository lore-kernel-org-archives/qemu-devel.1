Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781E1C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458412173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWHz5H07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458412173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT4m-0008SZ-VH
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38078)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4J-0006gP-Ib
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4I-00085U-3w
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:37:03 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoT4H-00085I-UJ; Fri, 19 Jul 2019 09:37:02 -0400
Received: by mail-pl1-x642.google.com with SMTP id y8so15650626plr.12;
 Fri, 19 Jul 2019 06:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qY0xo2hXixt1PLBpK6m4GAmm/UqdRAy517OvZvjaF8o=;
 b=CWHz5H07nqKkrxon9+xt0jHVklP7fDp9G0UWCCX/dVPb/ZhBSpIGRf4+w2HfPbGkFk
 cIcOakCtrnhbuclspP80wtDBoi57GW8DUOVj346qiLXSXMI6R3p5TMIQe5cNXrgiBWim
 YcMahJIdxXo8wRmZzYG1VhBUA4Vk9hk+8H/dUU69iVs3UMdbwq3yiIoNK/HDl/CS9ghN
 MJYlNIj7Rn+kNILv2EE7muOdN2bFV2f9Noo+6A+SSgayPxJPeFPeSAwig5Ay+W2zDfsF
 CuQ1W0xdw94l4wRhRtkDWdK9wj5pVMPmaud/4x/GvRDxYuTYOKoBqW9GzaCTDxLO2DLD
 g+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qY0xo2hXixt1PLBpK6m4GAmm/UqdRAy517OvZvjaF8o=;
 b=Mykt5QU/abxdBD3pqn2E6YjvDvSBkKgxJGo3C4njCgQu0ebIevgjW7s5GTVzm8Ih5P
 uBJv/NxRddF39gaZtoHO9U4V7HMDogYFbrJ+funo2khgv4cC+dG5NNXx/NrS+qMfTezF
 YOds5PDtnRr3WhFqo6Sea0gLNjxelomnujAFX++gZ4f2wc+93AO5T6DlJMS6VFoEsCxx
 slsc3gNyDVk6opTLJSKAn+PjVh+6OkjnMQKwXmkh4bcM3WFMgAQr1QkLfbAGH4cmpYQi
 vn3N5gavcP3xI4swURmqOdT0LMJPSxDDjeGU3LnIjXjLr1aPoFqX0OKY/BA0/Hv+v/Mx
 Xl4g==
X-Gm-Message-State: APjAAAW1JkdZOeb3yqJZx4EylZfEtcjfEFw1HjZyZahjqA7t887EEGn+
 SQojIObAiX+4McMFi/2WMrt8k6Ea3Mk=
X-Google-Smtp-Source: APXvYqxyj7FYCQhbr9UJIVP8pbheLFPj+aU+uOLmFQiCq6ZBzLeda8omdmABfLcwvjOfGfIF8JZF0w==
X-Received: by 2002:a17:902:b70e:: with SMTP id
 d14mr56504036pls.309.1563543420769; 
 Fri, 19 Jul 2019 06:37:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id 11sm31895369pfw.33.2019.07.19.06.36.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:37:00 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 19:05:25 +0530
Message-Id: <20190719133530.28688-10-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719133530.28688-1-mehta.aaru20@gmail.com>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v6 09/14] block: add trace events for io_uring
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
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 block/io_uring.c   | 22 +++++++++++++++++++---
 block/trace-events | 12 ++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index e8dbc388a6..e9c1dc1dc7 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -17,6 +17,7 @@
 #include "block/raw-aio.h"
 #include "qemu/coroutine.h"
 #include "qapi/error.h"
+#include "trace.h"
 
 #define MAX_EVENTS 128
 
@@ -93,6 +94,8 @@ static void luring_resubmit_short_read(LuringState *s, LuringAIOCB *luringcb,
     QEMUIOVector *resubmit_qiov;
     size_t remaining;
 
+    trace_luring_resubmit_short_read(s, luringcb, nread);
+
     /* Update read position */
     luringcb->total_read = nread;
     remaining = luringcb->qiov->size - luringcb->total_read;
@@ -163,6 +166,7 @@ static void luring_process_completions(LuringState *s)
 
         /* Change counters one-by-one because we can be nested. */
         s->io_q.in_flight--;
+        trace_luring_process_completion(s, luringcb, ret);
 
         /* total_read is non-zero only for resubmitted read requests */
         total_bytes = ret + luringcb->total_read;
@@ -263,6 +267,7 @@ static int ioq_submit(LuringState *s)
             QSIMPLEQ_REMOVE_HEAD(&s->io_q.sq_overflow, next);
         }
         ret = io_uring_submit(&s->ring);
+        trace_luring_io_uring_submit(s, ret);
         /* Prevent infinite loop if submission is refused */
         if (ret <= 0) {
             if (ret == -EAGAIN) {
@@ -287,12 +292,15 @@ static int ioq_submit(LuringState *s)
 
 void luring_io_plug(BlockDriverState *bs, LuringState *s)
 {
+    trace_luring_io_plug(s);
     s->io_q.plugged++;
 }
 
 void luring_io_unplug(BlockDriverState *bs, LuringState *s)
 {
     assert(s->io_q.plugged);
+    trace_luring_io_unplug(s, s->io_q.blocked, s->io_q.plugged,
+                           s->io_q.in_queue, s->io_q.in_flight);
     if (--s->io_q.plugged == 0 &&
         !s->io_q.blocked && s->io_q.in_queue > 0) {
         ioq_submit(s);
@@ -313,6 +321,7 @@ void luring_io_unplug(BlockDriverState *bs, LuringState *s)
 static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
                             uint64_t offset, int type)
 {
+    int ret;
     struct io_uring_sqe *sqes = &luringcb->sqeq;
 
     switch (type) {
@@ -336,11 +345,14 @@ static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
 
     QSIMPLEQ_INSERT_TAIL(&s->io_q.sq_overflow, luringcb, next);
     s->io_q.in_queue++;
-
+    trace_luring_do_submit(s, s->io_q.blocked, s->io_q.plugged,
+                           s->io_q.in_queue, s->io_q.in_flight);
     if (!s->io_q.blocked &&
         (!s->io_q.plugged ||
          s->io_q.in_flight + s->io_q.in_queue >= MAX_EVENTS)) {
-        return ioq_submit(s);
+        ret = ioq_submit(s);
+        trace_luring_do_submit_done(s, ret);
+        return ret;
     }
     return 0;
 }
@@ -355,8 +367,10 @@ int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, int fd,
         .qiov       = qiov,
         .is_read    = (type == QEMU_AIO_READ),
     };
-
+    trace_luring_co_submit(bs, s, &luringcb, fd, offset, qiov ? qiov->size : 0,
+                           type);
     ret = luring_do_submit(fd, &luringcb, s, offset, type);
+
     if (ret < 0) {
         return ret;
     }
@@ -388,6 +402,7 @@ LuringState *luring_init(Error **errp)
     int rc;
     LuringState *s;
     s = g_new0(LuringState, 1);
+    trace_luring_init_state(s, sizeof(*s));
     struct io_uring *ring = &s->ring;
     rc = io_uring_queue_init(MAX_EVENTS, ring, 0);
     if (rc < 0) {
@@ -405,4 +420,5 @@ void luring_cleanup(LuringState *s)
 {
     io_uring_queue_exit(&s->ring);
     g_free(s);
+    trace_luring_cleanup_state(s);
 }
diff --git a/block/trace-events b/block/trace-events
index d724df0117..5060afb2f7 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -60,6 +60,18 @@ qmp_block_stream(void *bs) "bs %p"
 file_paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "acb %p opaque %p offset %"PRId64" count %d type %d"
 file_copy_file_range(void *bs, int src, int64_t src_off, int dst, int64_t dst_off, int64_t bytes, int flags, int64_t ret) "bs %p src_fd %d offset %"PRIu64" dst_fd %d offset %"PRIu64" bytes %"PRIu64" flags %d ret %"PRId64
 
+#io_uring.c
+luring_init_state(void *s, size_t size) "s %p size %zu"
+luring_cleanup_state(void *s) "%p freed"
+luring_io_plug(void *s) "LuringState %p plug"
+luring_io_unplug(void *s, int blocked, int plugged, int queued, int inflight) "LuringState %p blocked %d plugged %d queued %d inflight %d"
+luring_do_submit(void *s, int blocked, int plugged, int queued, int inflight) "LuringState %p blocked %d plugged %d queued %d inflight %d"
+luring_do_submit_done(void *s, int ret) "LuringState %p submitted to kernel %d"
+luring_co_submit(void *bs, void *s, void *luringcb, int fd, uint64_t offset, size_t nbytes, int type) "bs %p s %p luringcb %p fd %d offset %" PRId64 " nbytes %zd type %d"
+luring_process_completion(void *s, void *aiocb, int ret) "LuringState %p luringcb %p ret %d"
+luring_io_uring_submit(void *s, int ret) "LuringState %p ret %d"
+luring_resubmit_short_read(void *s, void *luringcb, int nread) "LuringState %p luringcb %p nread
+
 # qcow2.c
 qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
 qcow2_writev_done_req(void *co, int ret) "co %p ret %d"
-- 
2.21.0


