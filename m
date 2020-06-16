Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2AAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FC1208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTkc+hyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FC1208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCsr-0006hD-Pg
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCRE-0004je-Fo; Tue, 16 Jun 2020 10:19:44 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:35654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCRC-00073Z-NQ; Tue, 16 Jun 2020 10:19:44 -0400
Received: by mail-ot1-x333.google.com with SMTP id d4so1648994otk.2;
 Tue, 16 Jun 2020 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bSmWjteiTH5qC4xgVEDeGVyY7i9xPTV5XQWtaiyx/PM=;
 b=CTkc+hyQkow2DVidoyqTi2cokBSbwJyx69zMXhgZfCBQgN2lIYDnvVJcLxe+pwDeAy
 aJFWKJqH4O4ryay3nABUgNsN4u2JUUWJO7plwiLSzfbsNXfunqFQodc48jRWfIX0i/1u
 rASeUd8JLAA79+ezFMEuRYn35MccvCmj7w8ZJnn4ruxGKF8GhPBgrsw+22MsbnHb4/dU
 jMV57e6O3qafawK7mLGZwuidhVfRlKg1CwE8aSTBVUqlf3rWpkirez9mgz5a01Ut/j3W
 dbA1iJTf/utrJUv79XbmL3Mu2yuOTP9TG0Pt92Y/Mlcn7X36LiCj8xaAVv5P6zJOotFJ
 1c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bSmWjteiTH5qC4xgVEDeGVyY7i9xPTV5XQWtaiyx/PM=;
 b=VzFQsasr5e8ZoR6jAMTvHBDwbZHbaQz7C6IYvo+Lz5FlxfzYRnax5Jf+x39MOcb+9L
 0Yn3Oj/FNm3dnBU90CIqKnOf2IE5nDdVRiHuhYV6KngqRnqRicvUyQ28DrBi6oNUDfLu
 XROy5lC33zk0mVq/HOqyVa14T2hHPF+Yq8kZ/Z9+6+F84AcAZ/gFBZZ23lhzb5WPukaw
 A5TWPZ1TnXGuD6iJJSpoAG6usfI6itHybhG+33+yEKWvqQzwIxAfwm4KkHOZdvtb3Dgo
 pCuW+sjDcurGzcM7jodhRls+LU6sWiurqzAKIQUckQ8I6bi5r6nMF3vjVpUW0dWYqidf
 on6Q==
X-Gm-Message-State: AOAM530z7CpTu0BfM7LlHe1YwAqMASS+gUuZzU3AlSN4kjwwoXdBvyoB
 uzo75+ZXCDGndNS+lS4Fz5H3eOO6E1Q=
X-Google-Smtp-Source: ABdhPJye/x4AaMiH3jOD98zq49I/ymdALf0f+ZhBdPqog/doFJlMhd3RDLTHvlG1qwn+QWh/0VBkVQ==
X-Received: by 2002:a9d:32c3:: with SMTP id u61mr2760848otb.170.1592317180499; 
 Tue, 16 Jun 2020 07:19:40 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id z17sm256728oib.1.2020.06.16.07.19.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:38 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 75/78] virtio-balloon: fix free page hinting without an
 iothread
Date: Tue, 16 Jun 2020 09:15:44 -0500
Message-Id: <20200616141547.24664-76-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>, Wei Wang <wei.w.wang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

In case we don't have an iothread, we mark the feature as abscent but
still add the queue. 'free_page_bh' remains set to NULL.

qemu-system-i386 \
        -M microvm \
        -nographic \
        -device virtio-balloon-device,free-page-hint=true \
        -nographic \
        -display none \
        -monitor none \
        -serial none \
        -qtest stdio

Doing a "write 0xc0000e30 0x24
0x030000000300000003000000030000000300000003000000030000000300000003000000"

We will trigger a SEGFAULT. Let's move the check and bail out.

While at it, move the static initializations to instance_init().
free_page_report_status and block_iothread are implicitly set to the
right values (0/false) already, so drop the initialization.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Cc: qemu-stable@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200520100439.19872-2-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 12fc8903a8ee09fb5f642de82699a0b211e1b5a7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-balloon.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 40b04f5180..8c6a177365 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -789,6 +789,13 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HINT) &&
+        !s->iothread) {
+        error_setg(errp, "'free-page-hint' requires 'iothread' to be set");
+        virtio_cleanup(vdev);
+        return;
+    }
+
     s->ivq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
@@ -797,24 +804,11 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
                            VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
                                            virtio_balloon_handle_free_page_vq);
-        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
-        s->free_page_report_cmd_id =
-                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
-        s->free_page_report_notify.notify =
-                                       virtio_balloon_free_page_report_notify;
         precopy_add_notifier(&s->free_page_report_notify);
-        if (s->iothread) {
-            object_ref(OBJECT(s->iothread));
-            s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
-                                       virtio_ballloon_get_free_page_hints, s);
-            qemu_mutex_init(&s->free_page_lock);
-            qemu_cond_init(&s->free_page_cond);
-            s->block_iothread = false;
-        } else {
-            /* Simply disable this feature if the iothread wasn't created. */
-            s->host_features &= ~(1 << VIRTIO_BALLOON_F_FREE_PAGE_HINT);
-            virtio_error(vdev, "iothread is missing");
-        }
+
+        object_ref(OBJECT(s->iothread));
+        s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
+                                     virtio_ballloon_get_free_page_hints, s);
     }
     reset_stats(s);
 }
@@ -885,6 +879,11 @@ static void virtio_balloon_instance_init(Object *obj)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(obj);
 
+    qemu_mutex_init(&s->free_page_lock);
+    qemu_cond_init(&s->free_page_cond);
+    s->free_page_report_cmd_id = VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
+    s->free_page_report_notify.notify = virtio_balloon_free_page_report_notify;
+
     object_property_add(obj, "guest-stats", "guest statistics",
                         balloon_stats_get_all, NULL, NULL, s, NULL);
 
-- 
2.17.1


