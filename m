Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FC7C33CAB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 04:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F2B21556
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 04:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E59JNfhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F2B21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqrp1-0000zQ-9Q
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 23:59:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1iqrnU-0007IM-1M
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 23:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1iqrnS-0006kV-Er
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 23:57:51 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1iqrnS-0006jA-5Y
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 23:57:50 -0500
Received: by mail-pl1-x642.google.com with SMTP id s21so3339430plr.7
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2020 20:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Smb5q2JKehl018b2NdA+yhR2A85PIPWYcZo1EvMvLD0=;
 b=E59JNfhk/r1jKFVwN5hcOKWwgcBGyOBh8nrad17AWYEKK1WZvef1lljC74tdL1FbPX
 He5tOyg87y998r8mxQHG3tkowQtFTfpkEt5Bxviz4fAhSTweEeu7rN2wpB5fDsE5Y/tR
 viryg+4lWtiBjC+o0MqPX1AJ+E9n3QkvDqFSOArSyi5qrF2lBKTDjwef3P8KJaeaX9fD
 2hSDZ+UBvT0+aFaFwT5CB5vYrgh1ZRDoRH7RSrQRfQeLeFSOv6eYZ3cZ15uCQr8LR4qD
 4aILm/l6Y58iQV4oWEcnwx43uCCJFLc2zRRQZFLiPwednwrRnw8mx3fyZdXXvvE19opn
 ay8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Smb5q2JKehl018b2NdA+yhR2A85PIPWYcZo1EvMvLD0=;
 b=LfQJ/4eftwd14Kwt+4FQLeledwavPj0Aic6zdytQPpD47+i61nxTXhatN/rUggpuKW
 mhVy3gcexlkBDX4p1CPJSpfgEBhw8ccOXUNf7gGWsGrf6hmJ+12XJYoJwHcGqqPzZ94b
 08GLSSKv0wb6tOvrfuYabbN1pVSTumY/SYY5x6vZ1EC1xR9QVP1RMwE8PzoXB2XPTivy
 eVVkenq3CjLsvkxZq4DoWvUkcBrJjUd3PzUjXDmiiC1qzQTZqXYxs7nvThGB3sL49VqC
 EetUOFNFgTAdsCLFk66GEbHSllvgih8q8ePGlleZCirgez98FzevRC/Gqcxz3yWNhgB3
 xmSA==
X-Gm-Message-State: APjAAAX11VJ+5JrYvWb0XyycpJ5uo0ur94v3KByG+RSV79ASS/f1n3qK
 aSk/cFApifn/IDkOXg7yEqFEwwtuKQCMlQ==
X-Google-Smtp-Source: APXvYqzWi+DUv9cZ9OMFU0xHUHpQLlUIQPQApqXCo+Cgz2+1/BqmBqrBUL/PJBt2kPengmGXcA4t4w==
X-Received: by 2002:a17:902:bd06:: with SMTP id
 p6mr12487987pls.27.1578891468802; 
 Sun, 12 Jan 2020 20:57:48 -0800 (PST)
Received: from localhost.localdomain ([175.124.145.172])
 by smtp.googlemail.com with ESMTPSA id o19sm17590552pjr.2.2020.01.12.20.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jan 2020 20:57:48 -0800 (PST)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/5] extend libvhost to support IOThread
Date: Mon, 13 Jan 2020 12:57:01 +0800
Message-Id: <20200113045704.12318-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113045704.12318-1-coiby.xu@gmail.com>
References: <20200113045704.12318-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, Coiby Xu <coiby.xu@gmail.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previously libvhost dispatch events in its own GMainContext. Now vhost-user client's kick event can be dispatched in block device drive's AioContext thus IOThread is supported.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 contrib/libvhost-user/libvhost-user.c | 64 ++++++++++++++++++++++-----
 contrib/libvhost-user/libvhost-user.h | 36 ++++++++++++++-
 2 files changed, 87 insertions(+), 13 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index ec27b78ff1..cd328c1509 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -67,7 +67,6 @@
 /* The version of inflight buffer */
 #define INFLIGHT_VERSION 1

-#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)

 /* The version of the protocol we support */
 #define VHOST_USER_VERSION 1
@@ -260,7 +259,7 @@ have_userfault(void)
 }

 static bool
-vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
+vu_message_read_(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
 {
     char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * sizeof(int))] = { };
     struct iovec iov = {
@@ -286,6 +285,8 @@ vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         return false;
     }

+    assert(rc == VHOST_USER_HDR_SIZE || rc == 0);
+
     vmsg->fd_num = 0;
     for (cmsg = CMSG_FIRSTHDR(&msg);
          cmsg != NULL;
@@ -328,6 +329,17 @@ fail:
     return false;
 }

+static bool vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
+{
+    vu_read_msg_cb read_msg;
+    if (dev->iface->read_msg) {
+        read_msg = dev->iface->read_msg;
+    } else {
+        read_msg = vu_message_read_;
+    }
+    return read_msg(dev, conn_fd, vmsg);
+}
+
 static bool
 vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
 {
@@ -400,7 +412,6 @@ vu_process_message_reply(VuDev *dev, const VhostUserMsg *vmsg)
     if ((vmsg->flags & VHOST_USER_NEED_REPLY_MASK) == 0) {
         return true;
     }
-
     if (!vu_message_read(dev, dev->slave_fd, &msg_reply)) {
         return false;
     }
@@ -644,7 +655,8 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
                     "%s: Failed to madvise(DONTNEED) region %d: %s\n",
                     __func__, i, strerror(errno));
         }
-        /* Turn off transparent hugepages so we dont get lose wakeups
+        /*
+         * Turn off transparent hugepages so we don't get lose wakeups
          * in neighbouring pages.
          * TODO: Turn this backon later.
          */
@@ -1047,9 +1059,13 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
     }

     if (dev->vq[index].kick_fd != -1 && dev->vq[index].handler) {
-        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
-                       vu_kick_cb, (void *)(long)index);
-
+        if (dev->set_watch_packed_data) {
+            dev->set_watch_packed_data(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
+                           dev->iface->kick_callback, (void *)(long)index);
+        } else {
+            dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
+                           vu_kick_cb, (void *)(long)index);
+        }
         DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
                dev->vq[index].kick_fd, index);
     }
@@ -1069,8 +1085,13 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
     vq->handler = handler;
     if (vq->kick_fd >= 0) {
         if (handler) {
-            dev->set_watch(dev, vq->kick_fd, VU_WATCH_IN,
-                           vu_kick_cb, (void *)(long)qidx);
+            if (dev->set_watch_packed_data) {
+                dev->set_watch_packed_data(dev, vq->kick_fd, VU_WATCH_IN,
+                        dev->iface->kick_callback, (void *)(long)qidx);
+            } else {
+                dev->set_watch(dev, vq->kick_fd, VU_WATCH_IN,
+                        vu_kick_cb, (void *)(long)qidx);
+            }
         } else {
             dev->remove_watch(dev, vq->kick_fd);
         }
@@ -1596,6 +1617,12 @@ vu_deinit(VuDev *dev)
         }

         if (vq->kick_fd != -1) {
+            /* remove watch for kick_fd
+             * When client process is running in gdb and
+             * quit command is run in gdb, QEMU will still dispatch the event
+             * which will cause segment fault in the callback function
+             */
+            dev->remove_watch(dev, vq->kick_fd);
             close(vq->kick_fd);
             vq->kick_fd = -1;
         }
@@ -1647,10 +1674,9 @@ vu_init(VuDev *dev,
         const VuDevIface *iface)
 {
     uint16_t i;
-
     assert(max_queues > 0);
     assert(socket >= 0);
-    assert(set_watch);
+    /* assert(set_watch); */
     assert(remove_watch);
     assert(iface);
     assert(panic);
@@ -1682,6 +1708,22 @@ vu_init(VuDev *dev,
     return true;
 }

+bool
+vu_init_packed_data(VuDev *dev,
+        uint16_t max_queues,
+        int socket,
+        vu_panic_cb panic,
+        vu_set_watch_cb_packed_data set_watch_packed_data,
+        vu_remove_watch_cb remove_watch,
+        const VuDevIface *iface)
+{
+    if (vu_init(dev, max_queues, socket, panic, NULL, remove_watch, iface)) {
+        dev->set_watch_packed_data = set_watch_packed_data;
+        return true;
+    }
+    return false;
+}
+
 VuVirtq *
 vu_get_queue(VuDev *dev, int qidx)
 {
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 46b600799b..5230d55092 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -34,6 +34,9 @@ typedef enum VhostSetConfigType {
     VHOST_SET_CONFIG_TYPE_MIGRATION = 1,
 } VhostSetConfigType;

+
+#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
+
 /*
  * Maximum size of virtio device config space
  */
@@ -200,6 +203,7 @@ typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
 typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
 typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
                                   int *do_reply);
+typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg);
 typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool started);
 typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx);
 typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_t len);
@@ -207,6 +211,15 @@ typedef int (*vu_set_config_cb) (VuDev *dev, const uint8_t *data,
                                  uint32_t offset, uint32_t size,
                                  uint32_t flags);

+typedef struct vu_watch_cb_data {
+   long index;
+   VuDev *vu_dev;
+} vu_watch_cb_data;
+typedef void (*vu_watch_cb_packed_data) (void *packed_data);
+
+typedef void (*vu_set_watch_cb_packed_data) (VuDev *dev, int fd, int condition,
+                                 vu_watch_cb_packed_data cb, void *data);
+
 typedef struct VuDevIface {
     /* called by VHOST_USER_GET_FEATURES to get the features bitmask */
     vu_get_features_cb get_features;
@@ -220,8 +233,11 @@ typedef struct VuDevIface {
     /* process_msg is called for each vhost-user message received */
     /* skip libvhost-user processing if return value != 0 */
     vu_process_msg_cb process_msg;
+    vu_read_msg_cb read_msg;
+    vu_watch_cb_packed_data kick_callback;
     /* tells when queues can be processed */
     vu_queue_set_started_cb queue_set_started;
+
     /*
      * If the queue is processed in order, in which case it will be
      * resumed to vring.used->idx. This can help to support resuming
@@ -366,7 +382,8 @@ struct VuDev {
     /* @set_watch: add or update the given fd to the watch set,
      * call cb when condition is met */
     vu_set_watch_cb set_watch;
-
+    /* AIO dispatch will only one data pointer to callback function */
+    vu_set_watch_cb_packed_data set_watch_packed_data;
     /* @remove_watch: remove the given fd from the watch set */
     vu_remove_watch_cb remove_watch;

@@ -398,7 +415,7 @@ typedef struct VuVirtqElement {
  * @remove_watch: a remove_watch callback
  * @iface: a VuDevIface structure with vhost-user device callbacks
  *
- * Intializes a VuDev vhost-user context.
+ * Initializes a VuDev vhost-user context.
  *
  * Returns: true on success, false on failure.
  **/
@@ -411,6 +428,21 @@ bool vu_init(VuDev *dev,
              const VuDevIface *iface);


+/**
+ * vu_init_packed_data:
+ * Same as vu_init except for set_watch_packed_data which will pack
+ * two parameters into a struct thus QEMU aio_dispatch can pass the
+ * required data to callback function.
+ *
+ * Returns: true on success, false on failure.
+ **/
+bool vu_init_packed_data(VuDev *dev,
+             uint16_t max_queues,
+             int socket,
+             vu_panic_cb panic,
+             vu_set_watch_cb_packed_data set_watch_packed_data,
+             vu_remove_watch_cb remove_watch,
+             const VuDevIface *iface);
 /**
  * vu_deinit:
  * @dev: a VuDev context
--
2.24.1


