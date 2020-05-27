Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191E4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 04:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E5C206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 04:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQRXNDGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E5C206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdnT4-0001hM-PV
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 00:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jdnSM-0000Qx-LL
 for qemu-devel@nongnu.org; Wed, 27 May 2020 00:14:18 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:44734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jdnSL-0005Ea-FI
 for qemu-devel@nongnu.org; Wed, 27 May 2020 00:14:18 -0400
Received: by mail-qv1-xf44.google.com with SMTP id g7so69518qvx.11
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 21:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=uu+eGuLM51wMt7MJnUDUl/18Y8XdgrCH2g3OE17f+7o=;
 b=LQRXNDGYhUToqaONM58Wf9m+tMzNicXPnGFKImk7Q2757hgIW3Pb6vKraEOiIj9BtI
 I4KrslKxdb/rWlaIadvf7Jqbl2ne1ezrKmcv7ZNGOTUY9X2RdF7FQM4rd7ztdKjumewS
 la0jFv705HIcflkqWkXehqu7MVBwDO0FsW3yMx9135gZSejlzqBagAqzUWoUqtXnrNC7
 mb0CMn/LIQSfpN2Q39wzzUIUJ1vBwkC/gSfQ5keZCWUsqGceapd3IrtUdO3eXi32PQ24
 VY8yRakbAs6gqk90/pJA6PjugAgj4+Jzjs6XLzRFrcFsXyD95FjvJB4s/7UhYwj+5zZN
 N7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=uu+eGuLM51wMt7MJnUDUl/18Y8XdgrCH2g3OE17f+7o=;
 b=aRG88RVaa+njW+nUkKBMVK1+kGcjvFkwMoXLH8ZqPJJv4fbS10l/ambfbvCa37F8TJ
 a8qCuVHTijme3X5/WXnmh9U3G+1tNxUfCono+O7JN1z/sYPbb8tP4pWFwUQN+DUIyMwK
 7pScOqc1C0Ln9uked1MyAniZxdo/lMBN9TaTkxvHfZbfHyKmx01CHsgXuefEQ1TxXwhx
 l4K1kMoUbS3+kzua/EuSOxz9t9soWAf3biUwHIKB7ECykAEj99Aunn0/xPoJiAX97lY9
 tOWnmP96Pwgt7USJIUHWjpedF0FdS8CUTRO2vFsAKL2OtgNnfbEim/TBijYtHrgJd1/5
 wVYA==
X-Gm-Message-State: AOAM531b7mLCHOJpAQmEglDb0Rc0le7SBm0U4jc24JPF5R3k3Mj0jUK7
 o3wp/eWIw2sYonAiiilYpc+n0IWTkrc=
X-Google-Smtp-Source: ABdhPJxxl5g/oUL92sw9qetjFhEq4DiiA36ztLxCWlsPN1dUH+KwrJ8/3edAZbl5blfVQfdPOzAkLw==
X-Received: by 2002:ad4:4082:: with SMTP id l2mr6905103qvp.6.1590552856421;
 Tue, 26 May 2020 21:14:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id k17sm1707811qtb.5.2020.05.26.21.14.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 May 2020 21:14:16 -0700 (PDT)
Subject: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Tue, 26 May 2020 21:14:14 -0700
Message-ID: <20200527041414.12700.50293.stgit@localhost.localdomain>
In-Reply-To: <20200527041212.12700.60627.stgit@localhost.localdomain>
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=alexander.duyck@gmail.com; helo=mail-qv1-xf44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

In an upcoming patch a feature named Free Page Reporting is about to be
added. In order to avoid any confusion we should drop the use of the word
'report' when referring to Free Page Hinting. So what this patch does is go
through and replace all instances of 'report' with 'hint" when we are
referring to free page hinting.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c         |   78 ++++++++++++++++++------------------
 include/hw/virtio/virtio-balloon.h |   20 +++++----
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 3e2ac1104b5f..dc15409b0bb6 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -527,21 +527,21 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
             ret = false;
             goto out;
         }
-        if (id == dev->free_page_report_cmd_id) {
-            dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
+        if (id == dev->free_page_hint_cmd_id) {
+            dev->free_page_hint_status = FREE_PAGE_HINT_S_START;
         } else {
             /*
              * Stop the optimization only when it has started. This
              * avoids a stale stop sign for the previous command.
              */
-            if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
-                dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
+            if (dev->free_page_hint_status == FREE_PAGE_HINT_S_START) {
+                dev->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
             }
         }
     }
 
     if (elem->in_num) {
-        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
+        if (dev->free_page_hint_status == FREE_PAGE_HINT_S_START) {
             qemu_guest_free_page_hint(elem->in_sg[0].iov_base,
                                       elem->in_sg[0].iov_len);
         }
@@ -567,11 +567,11 @@ static void virtio_ballloon_get_free_page_hints(void *opaque)
         qemu_mutex_unlock(&dev->free_page_lock);
         virtio_notify(vdev, vq);
       /*
-       * Start to poll the vq once the reporting started. Otherwise, continue
+       * Start to poll the vq once the hinting started. Otherwise, continue
        * only when there are entries on the vq, which need to be given back.
        */
     } while (continue_to_get_hints ||
-             dev->free_page_report_status == FREE_PAGE_REPORT_S_START);
+             dev->free_page_hint_status == FREE_PAGE_HINT_S_START);
     virtio_queue_set_notification(vq, 1);
 }
 
@@ -592,14 +592,14 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
         return;
     }
 
-    if (s->free_page_report_cmd_id == UINT_MAX) {
-        s->free_page_report_cmd_id =
-                       VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
+    if (s->free_page_hint_cmd_id == UINT_MAX) {
+        s->free_page_hint_cmd_id =
+                       VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
     } else {
-        s->free_page_report_cmd_id++;
+        s->free_page_hint_cmd_id++;
     }
 
-    s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
+    s->free_page_hint_status = FREE_PAGE_HINT_S_REQUESTED;
     virtio_notify_config(vdev);
 }
 
@@ -607,18 +607,18 @@ static void virtio_balloon_free_page_stop(VirtIOBalloon *s)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
-    if (s->free_page_report_status != FREE_PAGE_REPORT_S_STOP) {
+    if (s->free_page_hint_status != FREE_PAGE_HINT_S_STOP) {
         /*
          * The lock also guarantees us that the
          * virtio_ballloon_get_free_page_hints exits after the
-         * free_page_report_status is set to S_STOP.
+         * free_page_hint_status is set to S_STOP.
          */
         qemu_mutex_lock(&s->free_page_lock);
         /*
-         * The guest hasn't done the reporting, so host sends a notification
-         * to the guest to actively stop the reporting.
+         * The guest isn't done hinting, so send a notification
+         * to the guest to actively stop the hinting.
          */
-        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
+        s->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
         qemu_mutex_unlock(&s->free_page_lock);
         virtio_notify_config(vdev);
     }
@@ -628,15 +628,15 @@ static void virtio_balloon_free_page_done(VirtIOBalloon *s)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
-    s->free_page_report_status = FREE_PAGE_REPORT_S_DONE;
+    s->free_page_hint_status = FREE_PAGE_HINT_S_DONE;
     virtio_notify_config(vdev);
 }
 
 static int
-virtio_balloon_free_page_report_notify(NotifierWithReturn *n, void *data)
+virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data)
 {
     VirtIOBalloon *dev = container_of(n, VirtIOBalloon,
-                                      free_page_report_notify);
+                                      free_page_hint_notify);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     PrecopyNotifyData *pnd = data;
 
@@ -685,7 +685,7 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
     if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         return offsetof(struct virtio_balloon_config, poison_val);
     }
-    return offsetof(struct virtio_balloon_config, free_page_report_cmd_id);
+    return offsetof(struct virtio_balloon_config, free_page_hint_cmd_id);
 }
 
 static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
@@ -697,14 +697,14 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
     config.actual = cpu_to_le32(dev->actual);
     config.poison_val = cpu_to_le32(dev->poison_val);
 
-    if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
-        config.free_page_report_cmd_id =
-                       cpu_to_le32(dev->free_page_report_cmd_id);
-    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
-        config.free_page_report_cmd_id =
+    if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
+        config.free_page_hint_cmd_id =
+                       cpu_to_le32(dev->free_page_hint_cmd_id);
+    } else if (dev->free_page_hint_status == FREE_PAGE_HINT_S_STOP) {
+        config.free_page_hint_cmd_id =
                        cpu_to_le32(VIRTIO_BALLOON_CMD_ID_STOP);
-    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_DONE) {
-        config.free_page_report_cmd_id =
+    } else if (dev->free_page_hint_status == FREE_PAGE_HINT_S_DONE) {
+        config.free_page_hint_cmd_id =
                        cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
     }
 
@@ -817,14 +817,14 @@ static int virtio_balloon_post_load_device(void *opaque, int version_id)
     return 0;
 }
 
-static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
+static const VMStateDescription vmstate_virtio_balloon_free_page_hint = {
     .name = "virtio-balloon-device/free-page-report",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = virtio_balloon_free_page_support,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
-        VMSTATE_UINT32(free_page_report_status, VirtIOBalloon),
+        VMSTATE_UINT32(free_page_hint_cmd_id, VirtIOBalloon),
+        VMSTATE_UINT32(free_page_hint_status, VirtIOBalloon),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -851,7 +851,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * []) {
-        &vmstate_virtio_balloon_free_page_report,
+        &vmstate_virtio_balloon_free_page_hint,
         &vmstate_virtio_balloon_page_poison,
         NULL
     }
@@ -883,12 +883,12 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
                            VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
                                            virtio_balloon_handle_free_page_vq);
-        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
-        s->free_page_report_cmd_id =
-                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
-        s->free_page_report_notify.notify =
-                                       virtio_balloon_free_page_report_notify;
-        precopy_add_notifier(&s->free_page_report_notify);
+        s->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
+        s->free_page_hint_cmd_id =
+                           VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
+        s->free_page_hint_notify.notify =
+                                       virtio_balloon_free_page_hint_notify;
+        precopy_add_notifier(&s->free_page_hint_notify);
         if (s->iothread) {
             object_ref(OBJECT(s->iothread));
             s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
@@ -919,7 +919,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
     if (virtio_balloon_free_page_support(s)) {
         qemu_bh_delete(s->free_page_bh);
         virtio_balloon_free_page_stop(s);
-        precopy_remove_notifier(&s->free_page_report_notify);
+        precopy_remove_notifier(&s->free_page_hint_notify);
     }
     balloon_stats_destroy_timer(s);
     qemu_remove_balloon_handler(s);
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index d49fef00cef2..28fd2b396087 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -23,7 +23,7 @@
 #define VIRTIO_BALLOON(obj) \
         OBJECT_CHECK(VirtIOBalloon, (obj), TYPE_VIRTIO_BALLOON)
 
-#define VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN 0x80000000
+#define VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN 0x80000000
 
 typedef struct virtio_balloon_stat VirtIOBalloonStat;
 
@@ -33,20 +33,20 @@ typedef struct virtio_balloon_stat_modern {
        uint64_t val;
 } VirtIOBalloonStatModern;
 
-enum virtio_balloon_free_page_report_status {
-    FREE_PAGE_REPORT_S_STOP = 0,
-    FREE_PAGE_REPORT_S_REQUESTED = 1,
-    FREE_PAGE_REPORT_S_START = 2,
-    FREE_PAGE_REPORT_S_DONE = 3,
+enum virtio_balloon_free_page_hint_status {
+    FREE_PAGE_HINT_S_STOP = 0,
+    FREE_PAGE_HINT_S_REQUESTED = 1,
+    FREE_PAGE_HINT_S_START = 2,
+    FREE_PAGE_HINT_S_DONE = 3,
 };
 
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
     VirtQueue *ivq, *dvq, *svq, *free_page_vq, *reporting_vq;
-    uint32_t free_page_report_status;
+    uint32_t free_page_hint_status;
     uint32_t num_pages;
     uint32_t actual;
-    uint32_t free_page_report_cmd_id;
+    uint32_t free_page_hint_cmd_id;
     uint64_t stats[VIRTIO_BALLOON_S_NR];
     VirtQueueElement *stats_vq_elem;
     size_t stats_vq_offset;
@@ -55,7 +55,7 @@ typedef struct VirtIOBalloon {
     QEMUBH *free_page_bh;
     /*
      * Lock to synchronize threads to access the free page reporting related
-     * fields (e.g. free_page_report_status).
+     * fields (e.g. free_page_hint_status).
      */
     QemuMutex free_page_lock;
     QemuCond  free_page_cond;
@@ -64,7 +64,7 @@ typedef struct VirtIOBalloon {
      * stopped.
      */
     bool block_iothread;
-    NotifierWithReturn free_page_report_notify;
+    NotifierWithReturn free_page_hint_notify;
     int64_t stats_last_update;
     int64_t stats_poll_interval;
     uint32_t host_features;


