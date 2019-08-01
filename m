Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE92AC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AA5206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os27WHrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AA5206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htKpX-0002sq-2r
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 19:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33107)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKiq-0007tI-DO
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKim-0003uG-VQ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:42:58 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46901)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1htKii-0003pK-Kd; Thu, 01 Aug 2019 19:42:52 -0400
Received: by mail-pl1-x644.google.com with SMTP id c2so32843160plz.13;
 Thu, 01 Aug 2019 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tjzNpLM2BOfkDI4Z/y396mBvH1SrcQto63wfXq3jE/w=;
 b=Os27WHrweq1S6Yl+xZkwzwWoQF6QbiCOSMEzwGLoABS9xO3p+Rh0BsnY1meSbbQKUV
 2E5Y+bHlqeUtKNfN0ONgrYMRUk7Dz+7Kl1Bu7lCHHjMZYZFDxcFx/W2iaYr0eINJzJ60
 3aihRZNJyY1kkT4jZaKJa3Rf367RCtpYY1ssexqLfATK20i5rCAiqlSE2O5kJ1qM8QBQ
 jAxIUDgw69WJi52WIQioRqHmJ6G6acAvKW8cCXOQ1vLW8EK1Ksy+izuKXBzOzSu/jGZE
 fbaaf4xzx84VtQ1XzOci+wYp2ymaWirbzsYMz3/tSS0GMWmZGDNgM8aT74RDP91S5G0M
 BMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tjzNpLM2BOfkDI4Z/y396mBvH1SrcQto63wfXq3jE/w=;
 b=RMcmV5bcWDEsUhQBJghpEgteFzoYsUD5ES08yCR2Q1nFMzCNIg4M2neJ5H3kB5Pi3A
 1ylcZO6xrOImCAOrFy+LN6ieMr8OPu+L9OR0oGUrFOFi6+CpD8FwcG//5zQbrfa6oSXe
 fkJBce9wpxBiP9FVSp4DKWqwlNKh8WsMKfDw4ObwUWnc6jNudiWDNnnfMPPqFr8oS3/z
 Cs4CEuH42jCz9H5TD/8M/vVHvOVl3sg1PZY5XuxrRcVmHiq7Mzh5Eqp4bKQ+fusKu7k+
 wGvIX8ZVRySpEHNp1nYfFKWZtWHLTQiVkYOoJwlieiY9QqQX7C2Ht05TJCW4qj+KFOj0
 ydnA==
X-Gm-Message-State: APjAAAV7SOuE6sViBi0MbDcTaFAOc3hzEHFnLFeGOz5sTVQnrNgM4g7P
 pCehlBbAn+ZZRfxp7mMslZAxgWS0CPeL4A==
X-Google-Smtp-Source: APXvYqyZxlSgSMfruui2ZMMuEAJBucP2NSFkZ9vp0HB+ZAh/R3gMX772GVn+aE3JyKV5oH3rMK/I8w==
X-Received: by 2002:a17:902:28e9:: with SMTP id
 f96mr123329422plb.114.1564702970995; 
 Thu, 01 Aug 2019 16:42:50 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:572:3de5:765:cb16:92cd:ee3e])
 by smtp.gmail.com with ESMTPSA id
 g18sm117975426pgm.9.2019.08.01.16.42.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 16:42:50 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:10:30 +0530
Message-Id: <20190801234031.29561-17-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801234031.29561-1-mehta.aaru20@gmail.com>
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v9 16/17] block/io_uring: adds fd registration
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 block/io_uring.c   | 107 ++++++++++++++++++++++++++++++++++++++++++++-
 block/trace-events |   1 +
 2 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index 86f32e18a1..1553cd2e58 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -45,10 +45,16 @@ typedef struct LuringQueue {
     QSIMPLEQ_HEAD(, LuringAIOCB) submit_queue;
 } LuringQueue;
 
+typedef struct LuringFd {
+    int *fd_array;
+    GHashTable *fd_lookup;
+} LuringFd;
+
 typedef struct LuringState {
     AioContext *aio_context;
 
     struct io_uring ring;
+    LuringFd fd_reg;
 
     /* io queue for submit at batch.  Protected by AioContext lock. */
     LuringQueue io_q;
@@ -306,6 +312,94 @@ static int ioq_submit(LuringState *s)
     return ret;
 }
 
+/**
+ * luring_fd_register:
+ *
+ * Register file descriptors, see luring_fd_lookup
+ */
+static int luring_fd_register(struct io_uring *ring, LuringFd *fd_reg, int fd)
+{
+    int ret, nr;
+    GHashTable *lookup = fd_reg->fd_lookup;
+    nr = g_hash_table_size(lookup);
+
+    /* If adding new, API requires older registrations to be removed */
+    if (nr) {
+        /*
+         * See linux b19062a56726, register needs the ring mutex, any
+         * submission in progress will complete before unregistering begins
+         * and new ones will have to wait.
+         */
+        ret = io_uring_unregister_files(ring);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    fd_reg->fd_array = g_realloc_n(fd_reg->fd_array, nr + 1, sizeof(int));
+    fd_reg->fd_array[nr] = fd;
+
+    g_hash_table_insert(lookup, GINT_TO_POINTER(fd), GINT_TO_POINTER(nr));
+    trace_luring_fd_register(fd, nr);
+    return io_uring_register_files(ring, fd_reg->fd_array, nr + 1);
+}
+/**
+ * luring_fd_unregister:
+ *
+ * Unregisters file descriptors, TODO: error handling
+ */
+static void luring_fd_unregister(LuringState *s)
+{
+        io_uring_unregister_files(&s->ring);
+        g_hash_table_unref(s->fd_reg.fd_lookup);
+        g_free(s->fd_reg.fd_array);
+}
+
+/**
+ * luring_fd_lookup:
+ *
+ * Used to lookup fd index in registered array at submission time
+ * If the lookup table has not been created or the fd is not in the table,
+ * the fd is registered.
+ *
+ * If registration errors, the hash is cleared and the fd used directly
+ *
+ * Unregistering is done at luring_detach_aio_context
+ */
+static int luring_fd_lookup(LuringState *s, int fd)
+{
+    int ret;
+    void *index;
+    GHashTable *lookup;
+
+    if (!s->fd_reg.fd_lookup) {
+        s->fd_reg.fd_lookup = g_hash_table_new_full(g_direct_hash,
+                                                    g_direct_equal,
+                                                    g_free, g_free);
+        luring_fd_register(&s->ring, &s->fd_reg, fd);
+    }
+    lookup = s->fd_reg.fd_lookup;
+    index = g_hash_table_lookup(lookup, GINT_TO_POINTER(fd));
+
+    if (index < 0) {
+        ret = luring_fd_register(&s->ring, &s->fd_reg, fd);
+
+        if (ret < 0) {
+            if (ret == -ENOMEM || ret == -EMFILE ||
+                ret == -ENXIO) {
+                return ret;
+            } else {
+                /* Should not reach here */
+                g_hash_table_remove_all(lookup);
+                g_free(s->fd_reg.fd_array);
+                return ret;
+            }
+        }
+        index = g_hash_table_lookup(lookup, GINT_TO_POINTER(fd));
+    }
+    return GPOINTER_TO_INT(index);
+}
+
 void luring_io_plug(BlockDriverState *bs, LuringState *s)
 {
     trace_luring_io_plug(s);
@@ -337,9 +431,14 @@ void luring_io_unplug(BlockDriverState *bs, LuringState *s)
 static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
                             uint64_t offset, int type)
 {
-    int ret;
+    int ret, fd_index;
     struct io_uring_sqe *sqes = &luringcb->sqeq;
 
+    fd_index = luring_fd_lookup(s, fd);
+    if (fd_index >= 0) {
+        fd = fd_index;
+    }
+
     switch (type) {
     case QEMU_AIO_WRITE:
         io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
@@ -357,7 +456,11 @@ static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
                         __func__, type);
         abort();
     }
+
     io_uring_sqe_set_data(sqes, luringcb);
+    if (fd_index >= 0) {
+        io_uring_sqe_set_flags(sqes, IOSQE_FIXED_FILE);
+    }
 
     QSIMPLEQ_INSERT_TAIL(&s->io_q.submit_queue, luringcb, next);
     s->io_q.in_queue++;
@@ -383,6 +486,7 @@ int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, int fd,
         .qiov       = qiov,
         .is_read    = (type == QEMU_AIO_READ),
     };
+
     trace_luring_co_submit(bs, s, &luringcb, fd, offset, qiov ? qiov->size : 0,
                            type);
     ret = luring_do_submit(fd, &luringcb, s, offset, type);
@@ -399,6 +503,7 @@ int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, int fd,
 
 void luring_detach_aio_context(LuringState *s, AioContext *old_context)
 {
+    luring_fd_unregister(s);
     aio_set_fd_handler(old_context, s->ring.ring_fd, false, NULL, NULL, NULL,
                        s);
     qemu_bh_delete(s->completion_bh);
diff --git a/block/trace-events b/block/trace-events
index 66aaf8352b..13571aa182 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -71,6 +71,7 @@ luring_co_submit(void *bs, void *s, void *luringcb, int fd, uint64_t offset, siz
 luring_process_completion(void *s, void *aiocb, int ret) "LuringState %p luringcb %p ret %d"
 luring_io_uring_submit(void *s, int ret) "LuringState %p ret %d"
 luring_resubmit_short_read(void *s, void *luringcb, int nread) "LuringState %p luringcb %p nread %d"
+luring_fd_register(int fd, int index) "fd %d index %d"
 
 # qcow2.c
 qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
-- 
2.21.0


