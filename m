Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61D5C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B5A2100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6a/3COB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B5A2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBUC-0001i2-GW
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBSY-0008Iv-QF
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:09:36 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBSU-0003Gc-EN
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:09:34 -0400
Received: by mail-pf1-x444.google.com with SMTP id k15so2935420pfc.12
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H44SjkvjfzSidhnIMnrWf5qrjXNq+aKE1JXm4N92uiY=;
 b=H6a/3COB70xb5XuicfLutNKKGptmBWSFNOQKkxCipsneNuRe+Dt/uxsCKCqH7HEJ+1
 VduKYudvA/vOx/v0Lb28D9EtTRtdujn71C+maDBGjLyLh0RbQfmT5sKNcY5Wf5bF0iGx
 LdNooVVug+yu1XfRncT6M9cbvS9UEtOPF7oC4BnS9lVonpnJBZih72ydoabInc4Bx+uP
 rmV2HCANqEMj65axCFEoQrqX3rVAxNQlTvw5UgNsx+59kca9AwJt3lsziF9DtSZhmrMk
 plSfJeUqfPMiNmn5obfcu//tWY06u5RB2gkn3JD7E8EY+Qg7cdagi/afSOse72ypLJSP
 aOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H44SjkvjfzSidhnIMnrWf5qrjXNq+aKE1JXm4N92uiY=;
 b=MCtREv4j1+oKywa09j5Dt1kMqLmYQt4pVDsWdk7zuIvwY2Bw7apenQxxjXvRcMh0my
 OD04Jv4WLCu+mT6AYfa/sFNtbhysT00Eeh7Ira9Vjuj7zI+QY0r5saV5AxAQXzUkIL13
 +tDt6Py58mmAfqvJFJjJccqpa2UbN/fGUes00sjOfJtPkbhTonn0VqhZ3V4xEApe540l
 LyufUI8ziS/rCxB1TGKCtjgiQls7fRH02WtsSHG81uoUe9zQUm3qppCnOWMBmu7IMhKd
 NKP5xea3Dzz/C21BlkazB0Z+19HJHbTAXtVjEncrih/FxRc9nFxLXVBs8Hf7FT6p9cLj
 Pt9w==
X-Gm-Message-State: AOAM533Bo3V01hYzFS6wdMe1Rj/4obeSsYUO2AHQ9Ra5h4x6Ox2grnAd
 NelSwHRpDnf0+JbRik0BvYAPcQlizrLaHA==
X-Google-Smtp-Source: ABdhPJyXf10MoT1U2xshkbeXqXcSSzGByeyZs+11FZMJQIGiXjiWUws+KogHqOULfLF4CJ/lwb5SdA==
X-Received: by 2002:a62:2c8:0:b029:13e:9ee9:5b25 with SMTP id
 191-20020a6202c80000b029013e9ee95b25mr31298605pfc.1.1600416567297; 
 Fri, 18 Sep 2020 01:09:27 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id gb19sm1907542pjb.38.2020.09.18.01.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:09:26 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 1/7] libvhost-user: Allow vu_message_read to be replaced
Date: Fri, 18 Sep 2020 16:09:06 +0800
Message-Id: <20200918080912.321299-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918080912.321299-1-coiby.xu@gmail.com>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=coiby.xu@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow vu_message_read to be replaced by one which will make use of the
QIOChannel functions. Thus reading vhost-user message won't stall the
guest. For slave channel, we still use the default vu_message_read.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 contrib/libvhost-user/libvhost-user-glib.c |  2 +-
 contrib/libvhost-user/libvhost-user.c      | 14 +++++++-------
 contrib/libvhost-user/libvhost-user.h      | 21 +++++++++++++++++++++
 tests/vhost-user-bridge.c                  |  2 ++
 tools/virtiofsd/fuse_virtio.c              |  4 ++--
 5 files changed, 33 insertions(+), 10 deletions(-)

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
index 53f16bdf08..73732b928f 100644
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
@@ -267,7 +265,7 @@ have_userfault(void)
 }
 
 static bool
-vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
+vu_message_read_default(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
 {
     char control[CMSG_SPACE(VHOST_MEMORY_BASELINE_NREGIONS * sizeof(int))] = {};
     struct iovec iov = {
@@ -415,7 +413,7 @@ vu_process_message_reply(VuDev *dev, const VhostUserMsg *vmsg)
         goto out;
     }
 
-    if (!vu_message_read(dev, dev->slave_fd, &msg_reply)) {
+    if (!vu_message_read_default(dev, dev->slave_fd, &msg_reply)) {
         goto out;
     }
 
@@ -898,7 +896,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
     /* Wait for QEMU to confirm that it's registered the handler for the
      * faults.
      */
-    if (!vu_message_read(dev, dev->sock, vmsg) ||
+    if (!dev->read_msg(dev, dev->sock, vmsg) ||
         vmsg->size != sizeof(vmsg->payload.u64) ||
         vmsg->payload.u64 != 0) {
         vu_panic(dev, "failed to receive valid ack for postcopy set-mem-table");
@@ -1860,7 +1858,7 @@ vu_dispatch(VuDev *dev)
     int reply_requested;
     bool need_reply, success = false;
 
-    if (!vu_message_read(dev, dev->sock, &vmsg)) {
+    if (!dev->read_msg(dev, dev->sock, &vmsg)) {
         goto end;
     }
 
@@ -1958,6 +1956,7 @@ vu_init(VuDev *dev,
         uint16_t max_queues,
         int socket,
         vu_panic_cb panic,
+        vu_read_msg_cb read_msg,
         vu_set_watch_cb set_watch,
         vu_remove_watch_cb remove_watch,
         const VuDevIface *iface)
@@ -1975,6 +1974,7 @@ vu_init(VuDev *dev,
 
     dev->sock = socket;
     dev->panic = panic;
+    dev->read_msg = read_msg ? read_msg : vu_message_read_default;
     dev->set_watch = set_watch;
     dev->remove_watch = remove_watch;
     dev->iface = iface;
@@ -2340,7 +2340,7 @@ static void _vu_queue_notify(VuDev *dev, VuVirtq *vq, bool sync)
 
         vu_message_write(dev, dev->slave_fd, &vmsg);
         if (ack) {
-            vu_message_read(dev, dev->slave_fd, &vmsg);
+            vu_message_read_default(dev, dev->slave_fd, &vmsg);
         }
         return;
     }
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 844c37c648..fe27831395 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -36,6 +36,8 @@
  */
 #define VHOST_USER_MAX_RAM_SLOTS 32
 
+#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
+
 typedef enum VhostSetConfigType {
     VHOST_SET_CONFIG_TYPE_MASTER = 0,
     VHOST_SET_CONFIG_TYPE_MIGRATION = 1,
@@ -221,6 +223,7 @@ typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
 typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
 typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
                                   int *do_reply);
+typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg);
 typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool started);
 typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx);
 typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_t len);
@@ -389,6 +392,23 @@ struct VuDev {
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
@@ -432,6 +452,7 @@ bool vu_init(VuDev *dev,
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
index 9e5537506c..f7da358d4a 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -996,8 +996,8 @@ int virtio_session_mount(struct fuse_session *se)
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
2.28.0


