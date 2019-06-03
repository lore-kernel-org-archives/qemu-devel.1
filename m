Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACC0C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8BB27F7A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFXEito+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8BB27F7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmPm-0002SM-BS
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:50:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmKk-0007F5-NN
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmFX-0000XE-Eb
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:39:40 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hXmFX-0000VG-8S; Mon, 03 Jun 2019 08:39:39 -0400
Received: by mail-pf1-x444.google.com with SMTP id d126so10573977pfd.2;
	Mon, 03 Jun 2019 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=exvxrzkjOwxuFB3cwxOAuZc0lL7VPvQ7Qj9JqFUo65E=;
	b=gFXEito+I80q41xrNzphhouu3Ysd2EFCHnSAkLKD2C5U9U2EK0U2CBpFRgpBT9+y1b
	kcO+SSK2AdlhFZZDFC4Idp6CoYlRrXRrm8SfqkWhgPHyJMd+W9WmLZkAM6+prQLpKhqk
	CF/KM+df+Eg1+pem+5+RIY65bJRhlMEWSfobp9u4uyA3gD0PVBSfH1N8n+xTEHRNLHBs
	BgFhi/45ov8ZRcjYuYlVfQTxlUGRgJaD0LmR22cZArv/SQTcbQeCpDAL19mfO9TAglNN
	cbLG6zrrfBAC8Ac1TyOexiTSRjeX570ef5g79AfdjEFwWi7Y0HiP/3xEfdZwhIYaJ+eZ
	KQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=exvxrzkjOwxuFB3cwxOAuZc0lL7VPvQ7Qj9JqFUo65E=;
	b=ZESSXe6m6+g6RxRs3fdLL5pp5+lQF33fGDrgBkzsA+Vk00TWml2gaYbvtpK1J3I1IR
	qjRGF9ZEuMFYh9kM1LMhUsWvT2sZbRsRxUiCF2UHxA5J8vpGa2cqP+0SzGOGWNUQQFR2
	MewRusJn/hKv23BMUPw8LOmT4jCIfDmV54/p2Qe9tj72JDJqWqraXvFmoZg1SVGxhc62
	rmDckxkZORUoIFKgncO/yG8qjSmMAH/lSrneQ3dXGxlnogXXKHX3rhdJremvo1FYY5Ne
	m/v4UqCOzg/6g9oLS51OkgtCMSKfAx54rVj6TGsyp2kRbX9kK6Oe+PCa/3W54xUbwAnI
	CfJQ==
X-Gm-Message-State: APjAAAXUnleBaMbbboYeUJ71JpQ65OjD2VomJ2zQQ4Pj5h3OwmQ0FkKY
	oojVVvNl1YZYAgeXk6VzGkhZqaPriLvIpg==
X-Google-Smtp-Source: APXvYqzvdO4Z2vKk/9N0P5zOWQyGZaN8WYSkakUoMxEA+Va3/OPb4g1Qw/bHybiGuCDuaYfSitYgmw==
X-Received: by 2002:a62:160b:: with SMTP id 11mr30724598pfw.30.1559565577877; 
	Mon, 03 Jun 2019 05:39:37 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
	by smtp.gmail.com with ESMTPSA id
	k14sm34860257pga.5.2019.06.03.05.39.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 05:39:37 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 18:08:23 +0530
Message-Id: <20190603123823.32661-10-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603123823.32661-1-mehta.aaru20@gmail.com>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v4 9/9] block: add trace events for io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
index 536a9fbe87..e92e45ccca 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -17,6 +17,7 @@
 #include "block/raw-aio.h"
 #include "qemu/coroutine.h"
 #include "qapi/error.h"
+#include "trace.h"
 
 #define MAX_EVENTS 128
 
@@ -192,12 +193,15 @@ static int ioq_submit(LuringState *s)
 
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
@@ -218,6 +222,7 @@ void luring_io_unplug(BlockDriverState *bs, LuringState *s)
 static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
                             uint64_t offset, int type)
 {
+    int ret;
     struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
     if (!sqes) {
         sqes = &luringcb->sqeq;
@@ -243,11 +248,14 @@ static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
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
@@ -295,6 +303,7 @@ LuringState *luring_init(Error **errp)
     int rc;
     LuringState *s;
     s = g_malloc0(sizeof(*s));
+    trace_luring_init_state((void *)s, sizeof(*s));
     struct io_uring *ring = &s->ring;
     rc =  io_uring_queue_init(MAX_EVENTS, ring, 0);
     if (rc < 0) {
@@ -312,4 +321,5 @@ void luring_cleanup(LuringState *s)
 {
     io_uring_queue_exit(&s->ring);
     g_free(s);
+    trace_luring_cleanup_state();
 }
diff --git a/block/trace-events b/block/trace-events
index 1e0653ce6d..038ff14815 100644
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


