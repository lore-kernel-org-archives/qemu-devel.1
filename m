Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2154AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB1F20878
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGEn/oBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB1F20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgtUW-0008JM-9X
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jgtTN-0006zu-9c
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 13:16:09 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jgtTM-0001F6-8h
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 13:16:09 -0400
Received: by mail-pg1-x544.google.com with SMTP id r10so3749587pgv.8
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eJfVkMSOd2rAt/mYEDG86M9fkbe8y+LyR/mkRJhKFjo=;
 b=GGEn/oBHDUfPnBAInVwk0VwBDc90Ro+/DXMKPj5eR67AajwHugW7Do/U0lulreuvZF
 EK9fCuTHty2VS6y637jK+S+HgcTtifSj6bbvW/iarZofYZpTuyPNu4pxpZGl3sL43Pw9
 aPsiTp6DZNg6xGr7WXgzA8sdAeQyLO+oHjkPTXLwKJtkqvh1I0aSsL1FSuoxXiqMs/xM
 GxJd4GVbxuPLLQKeSUCOzTL9Wbi+fhMODWhsMvXgOvKNzy4xcVlemOuDaXQsjJX02R1r
 2n15DTC4csyoBlcVr+/sur9j7Pv9lRUi8tkU8Fq9Uly6QO7jhTwDmh92A5PhXcuu3Vcn
 Ar7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eJfVkMSOd2rAt/mYEDG86M9fkbe8y+LyR/mkRJhKFjo=;
 b=r5TALvVI89hhU2IvYovKZtoowts+izPIYTE46Gwgyxb6UXQ5lS9SeuW3529oxhZUEm
 m2Sbp7ziqV9b7QU/MbCE6f+vsCJtRnw8Q8iYqcnHnqe1YMOg9Ts5XzdBGYYcdqTRgC0e
 lnB0z34QCiCwG/6TKfzBrXaeNHJd6idSvC9b1RJeVztamZMlMb395xJkKOdVCFOD5kqH
 LXX7dEpWfHpT4KLbHsx3UkOWUxFotgKEsSCdZYVo7tJnnVrRhUKOck3DgtkzX1rjTag5
 kxrFugObuvCjmf/1ugCGA6cozl8xNy9TU0Uypr8U8qMBxOiw05QxkDMbbpZk9PEWYWjw
 lliw==
X-Gm-Message-State: AOAM53064UqOXno8ymjJzK02tVcpzFRYStA9n8KxXrpfth1O7GVLai4s
 +8tf4ftx1zziYDuYuhGv+1glKd2gRLSSgXfE
X-Google-Smtp-Source: ABdhPJyTrOwj5cArztm73xQqOCB0jWX1EM3ivjSaMznpYNa8hGJDqeL+aIYB0PqdAzFvYGToKmTPIw==
X-Received: by 2002:a63:4b0c:: with SMTP id y12mr5262537pga.56.1591290966404; 
 Thu, 04 Jun 2020 10:16:06 -0700 (PDT)
Received: from localhost (tunnel570486-pt.tunnel.tserv25.sin1.ipv6.he.net.
 [2001:470:35:3d5::2])
 by smtp.gmail.com with ESMTPSA id e12sm5055870pfj.137.2020.06.04.10.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 10:16:06 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 1/4] Allow vu_message_read to be replaced
Date: Fri,  5 Jun 2020 01:15:29 +0800
Message-Id: <20200604171532.209048-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604171532.209048-1-coiby.xu@gmail.com>
References: <20200604171532.209048-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=coiby.xu@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 stefanha@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow vu_message_read to be replaced by one which will make use of the
QIOChannel functions. Thus reading vhost-user message won't stall the
guest.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 contrib/libvhost-user/libvhost-user-glib.c |  2 +-
 contrib/libvhost-user/libvhost-user.c      | 11 ++++++-----
 contrib/libvhost-user/libvhost-user.h      | 21 +++++++++++++++++++++
 tests/vhost-user-bridge.c                  |  2 ++
 tools/virtiofsd/fuse_virtio.c              |  4 ++--
 5 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhost-user/libvhost-user-glib.c
index 53f1ca4cdd..0df2ec9271 100644
--- a/contrib/libvhost-user/libvhost-user-glib.c
+++ b/contrib/libvhost-user/libvhost-user-glib.c
@@ -147,7 +147,7 @@ vug_init(VugDev *dev, uint16_t max_queues, int socket,
     g_assert(dev);
     g_assert(iface);
 
-    if (!vu_init(&dev->parent, max_queues, socket, panic, set_watch,
+    if (!vu_init(&dev->parent, max_queues, socket, panic, NULL, set_watch,
                  remove_watch, iface)) {
         return false;
     }
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 3bca996c62..0c7368baa2 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -67,8 +67,6 @@
 /* The version of inflight buffer */
 #define INFLIGHT_VERSION 1
 
-#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
-
 /* The version of the protocol we support */
 #define VHOST_USER_VERSION 1
 #define LIBVHOST_USER_DEBUG 0
@@ -412,7 +410,7 @@ vu_process_message_reply(VuDev *dev, const VhostUserMsg *vmsg)
         goto out;
     }
 
-    if (!vu_message_read(dev, dev->slave_fd, &msg_reply)) {
+    if (!dev->read_msg(dev, dev->slave_fd, &msg_reply)) {
         goto out;
     }
 
@@ -647,7 +645,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
     /* Wait for QEMU to confirm that it's registered the handler for the
      * faults.
      */
-    if (!vu_message_read(dev, dev->sock, vmsg) ||
+    if (!dev->read_msg(dev, dev->sock, vmsg) ||
         vmsg->size != sizeof(vmsg->payload.u64) ||
         vmsg->payload.u64 != 0) {
         vu_panic(dev, "failed to receive valid ack for postcopy set-mem-table");
@@ -1653,7 +1651,7 @@ vu_dispatch(VuDev *dev)
     int reply_requested;
     bool need_reply, success = false;
 
-    if (!vu_message_read(dev, dev->sock, &vmsg)) {
+    if (!dev->read_msg(dev, dev->sock, &vmsg)) {
         goto end;
     }
 
@@ -1704,6 +1702,7 @@ vu_deinit(VuDev *dev)
         }
 
         if (vq->kick_fd != -1) {
+            dev->remove_watch(dev, vq->kick_fd);
             close(vq->kick_fd);
             vq->kick_fd = -1;
         }
@@ -1751,6 +1750,7 @@ vu_init(VuDev *dev,
         uint16_t max_queues,
         int socket,
         vu_panic_cb panic,
+        vu_read_msg_cb read_msg,
         vu_set_watch_cb set_watch,
         vu_remove_watch_cb remove_watch,
         const VuDevIface *iface)
@@ -1768,6 +1768,7 @@ vu_init(VuDev *dev,
 
     dev->sock = socket;
     dev->panic = panic;
+    dev->read_msg = read_msg ? read_msg : vu_message_read;
     dev->set_watch = set_watch;
     dev->remove_watch = remove_watch;
     dev->iface = iface;
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index f30394fab6..d756da8548 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -30,6 +30,8 @@
 
 #define VHOST_MEMORY_MAX_NREGIONS 8
 
+#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
+
 typedef enum VhostSetConfigType {
     VHOST_SET_CONFIG_TYPE_MASTER = 0,
     VHOST_SET_CONFIG_TYPE_MIGRATION = 1,
@@ -205,6 +207,7 @@ typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
 typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
 typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
                                   int *do_reply);
+typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg);
 typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool started);
 typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx);
 typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_t len);
@@ -373,6 +376,23 @@ struct VuDev {
     bool broken;
     uint16_t max_queues;
 
+    /* @read_msg: custom method to read vhost-user message
+     *
+     * Read data from vhost_user socket fd and fill up
+     * the passed VhostUserMsg *vmsg struct.
+     *
+     * If reading fails, it should close the received set of file
+     * descriptors as socket message's auxiliary data.
+     *
+     * For the details, please refer to vu_message_read in libvhost-user.c
+     * which will be used by default if not custom method is provided when
+     * calling vu_init
+     *
+     * Returns: true if vhost-user message successfully received,
+     *          otherwise return false.
+     *
+     */
+    vu_read_msg_cb read_msg;
     /* @set_watch: add or update the given fd to the watch set,
      * call cb when condition is met */
     vu_set_watch_cb set_watch;
@@ -416,6 +436,7 @@ bool vu_init(VuDev *dev,
              uint16_t max_queues,
              int socket,
              vu_panic_cb panic,
+             vu_read_msg_cb read_msg,
              vu_set_watch_cb set_watch,
              vu_remove_watch_cb remove_watch,
              const VuDevIface *iface);
diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 6c3d490611..bd43607a4d 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -520,6 +520,7 @@ vubr_accept_cb(int sock, void *ctx)
                  VHOST_USER_BRIDGE_MAX_QUEUES,
                  conn_fd,
                  vubr_panic,
+                 NULL,
                  vubr_set_watch,
                  vubr_remove_watch,
                  &vuiface)) {
@@ -573,6 +574,7 @@ vubr_new(const char *path, bool client)
                      VHOST_USER_BRIDGE_MAX_QUEUES,
                      dev->sock,
                      vubr_panic,
+                     NULL,
                      vubr_set_watch,
                      vubr_remove_watch,
                      &vuiface)) {
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 3b6d16a041..666945c897 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -980,8 +980,8 @@ int virtio_session_mount(struct fuse_session *se)
     se->vu_socketfd = data_sock;
     se->virtio_dev->se = se;
     pthread_rwlock_init(&se->virtio_dev->vu_dispatch_rwlock, NULL);
-    vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, fv_set_watch,
-            fv_remove_watch, &fv_iface);
+    vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, NULL,
+            fv_set_watch, fv_remove_watch, &fv_iface);
 
     return 0;
 }
-- 
2.26.2


