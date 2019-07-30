Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122C5C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B22216C8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnIzVVag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B22216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsWCh-0000sP-6m
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36091)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW3V-0006es-2u
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW3T-0000eB-Qa
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:36:57 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hsW3T-0000dv-K1; Tue, 30 Jul 2019 13:36:55 -0400
Received: by mail-pl1-x644.google.com with SMTP id k8so29191277plt.3;
 Tue, 30 Jul 2019 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HtKAermb8jkRwDYfQy50ghQZAMoE/J4HCHa8w9p4Lso=;
 b=gnIzVVagb+U1OgCSEAHTh91dBUTV+FtB00D8rn9inJSJyVA4vADj4Jh3b9BbTLzcjE
 vqxopa6rup94AFxpJvzSFdLkwao57bU+P8edBiejmlf/DATB5w8rNH4VgjtgbW4SF6fv
 s4uF++H2SoRgzwRa5AoPeqZLhBnvDh1A/3gH8OYitOIpoQ9nUOwPOrpDhkmi4EHofHy+
 kv5JBf42GELq4GynQTmhTHKhPYdVR+2/uRZwF8fRrC6/Hocvrk4a6PGFuNl8tyVRLk/9
 rtvYonmH743vHrCHXvOzBg7bjzEOpxMediT32PudI5VDWwjLE+GodIpR4IXC7iGHYK27
 7KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HtKAermb8jkRwDYfQy50ghQZAMoE/J4HCHa8w9p4Lso=;
 b=Go1CJUCfGKKGPcW+Pac3c6XC0CHv2YAVOZ27aiO+LJHD1LRmCB/9fU2kzZhCCcfpV/
 VTYABNKT4M8qh6HcDOJfbMS48spx++bchIthjkmtQdYB3MNIWyc1A60TI+Ky3DXI6Ekq
 mOmi3PIPAXZafebkg5NSOPYeXDvbbjpPRmpZy7F0ALcPk6RS/KzHWCDDQEks2AwrNLQE
 4Ry2zXBMMr03bEFQMPOsVuCAF7Za7loJRINPxUUnSy1sWoZu2YsqhLMsjcXQ72a9NrAE
 yx6fkopaqJmNHnzBSfTC1GCDM4cVeRp2iORsu/MyaPuIFsFY2btOjc88gbaAJixMfcmw
 1+BQ==
X-Gm-Message-State: APjAAAWIweG/aDtZlmmtx6xI51tJw/5uDkAK7UwSvs3IWacWQcGueDkq
 zcil/pQYsvmKgY6QeI6xb7tzWHHRdb7dtA==
X-Google-Smtp-Source: APXvYqzQDfmcDvr5w3sX0fH6XYiec33MvZN/Bz81R3aRCDBv3hmVBtrSD9OyWfLa+PCUI8+Y85dg9Q==
X-Received: by 2002:a17:902:e202:: with SMTP id
 ce2mr111846858plb.272.1564508214262; 
 Tue, 30 Jul 2019 10:36:54 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id q24sm59122895pjp.14.2019.07.30.10.36.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 10:36:53 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 23:04:41 +0530
Message-Id: <20190730173441.26486-17-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730173441.26486-1-mehta.aaru20@gmail.com>
References: <20190730173441.26486-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v8 16/16] block/io_uring: adds fd registration
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fd registration API in io_uring registers a series of fds
together that cannot be modified later. Thus, a hashtable
maintains an index of fds registered and their index in the
internally registered array. The existing fd array is unregistered
and a new one submitted.

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 block/io_uring.c   | 86 ++++++++++++++++++++++++++++++++++++++++++++--
 block/trace-events |  1 +
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index e2bef380e7..eb8fd23822 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -45,10 +45,17 @@ typedef struct LuringQueue {
     QSIMPLEQ_HEAD(, LuringAIOCB) submit_queue;
 } LuringQueue;
 
+typedef struct LuringFd {
+    int *fd_array;
+    int *fd_index;
+    GHashTable *fd_lookup;
+} LuringFd;
+
 typedef struct LuringState {
     AioContext *aio_context;
 
     struct io_uring ring;
+    LuringFd fd_reg;
 
     /* io queue for submit at batch.  Protected by AioContext lock. */
     LuringQueue io_q;
@@ -305,6 +312,70 @@ static int ioq_submit(LuringState *s)
     }
     return ret;
 }
+/**
+ * luring_fd_register:
+ *
+ * Register and unregisters file descriptors, see luring_fd_lookup
+ */
+static int luring_fd_register(struct io_uring *ring, LuringFd *fd_reg, int fd)
+{
+    int ret, nr;
+    GHashTable *lookup = fd_reg->fd_lookup;
+    nr = g_hash_table_size(lookup);
+
+    /* Unregister */
+    if (!fd) {
+        ret = io_uring_unregister_files(ring);
+        g_hash_table_remove_all(lookup);
+        return ret;
+    }
+
+    /* If adding new, API requires older registrations to be removed */
+    if (nr) {
+        io_uring_unregister_files(ring);
+    }
+
+    fd_reg->fd_array = g_realloc_n(fd_reg->fd_array, nr + 1, sizeof(int));
+    fd_reg->fd_array[nr] = fd;
+    fd_reg->fd_index = g_realloc_n(fd_reg->fd_index, nr + 1, sizeof(int));
+    fd_reg->fd_index[nr] = nr;
+
+    g_hash_table_insert(lookup, &fd_reg->fd_array[nr], &fd_reg->fd_index[nr]);
+    trace_luring_fd_register(fd, nr);
+    return io_uring_register_files(ring, fd_reg->fd_array, nr + 1);
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
+    int *index, ret;
+    if (!s->fd_reg.fd_lookup) {
+        s->fd_reg.fd_lookup = g_hash_table_new_full(g_int_hash, g_int_equal,
+                                                    g_free, g_free);
+        luring_fd_register(&s->ring, &s->fd_reg, fd);
+    }
+    index = g_hash_table_lookup(s->fd_reg.fd_lookup, &fd);
+
+    if (!index) {
+        ret = luring_fd_register(&s->ring, &s->fd_reg, fd);
+        if (ret < 0) {
+            g_hash_table_remove_all(s->fd_reg.fd_lookup);
+            return ret;
+        }
+        index = g_hash_table_lookup(s->fd_reg.fd_lookup, &fd);
+    }
+    return *index;
+}
 
 void luring_io_plug(BlockDriverState *bs, LuringState *s)
 {
@@ -357,7 +428,11 @@ static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
                         __func__, type);
         abort();
     }
+
     io_uring_sqe_set_data(sqes, luringcb);
+    if (s->fd_reg.fd_array) {
+        io_uring_sqe_set_flags(sqes, IOSQE_FIXED_FILE);
+    }
 
     QSIMPLEQ_INSERT_TAIL(&s->io_q.submit_queue, luringcb, next);
     s->io_q.in_queue++;
@@ -374,15 +449,21 @@ static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
 }
 
 int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, int fd,
                                   uint64_t offset, QEMUIOVector *qiov, int type)
 {
-    int ret;
+    int ret, fd_index;
     LuringAIOCB luringcb = {
         .co         = qemu_coroutine_self(),
         .ret        = -EINPROGRESS,
         .qiov       = qiov,
         .is_read    = (type == QEMU_AIO_READ),
     };
+
+    fd_index = luring_fd_lookup(s, fd);
+    if (fd_index >= 0) {
+        fd = fd_index;
+    }
+
     trace_luring_co_submit(bs, s, &luringcb, fd, offset, qiov ? qiov->size : 0,
                            type);
     ret = luring_do_submit(fd, &luringcb, s, offset, type);
@@ -399,6 +480,7 @@ int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, int fd,
 
 void luring_detach_aio_context(LuringState *s, AioContext *old_context)
 {
+    luring_fd_register(&s->ring, &s->fd_reg, 0);
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


