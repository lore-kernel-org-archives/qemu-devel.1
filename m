Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB457C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927A320678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzMhNwT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927A320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxHY-0006UG-OQ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMN-0005WH-Ji; Thu, 03 Sep 2020 17:01:31 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:45462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwML-0007wP-Lo; Thu, 03 Sep 2020 17:01:31 -0400
Received: by mail-ot1-x32c.google.com with SMTP id g96so3978002otb.12;
 Thu, 03 Sep 2020 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=coJkuEmlNkx1jl3SxtGVceRHzmpSFAl/1O2kd9aGIEI=;
 b=KzMhNwT4SzFuMYvIrN0Mg77+M/x/o+/6ac1fx+nUDjDNbLdz19Bbh9RDVYMRi6M8zc
 DShKL5vIDPkK8SjqwLpfAGmO9G1OXekk+CPqrw4q7KTXKvnRgSR0CbtXgzPvRnRudRUQ
 ty49O53Js0dPbwVjPKDDYYHY0mRVmdR/hAGMEKcDrJLaFuv+b9TmGOkmkGzB5noAcwDn
 8qWZgs3F2Iq+bkodsUzu/h92GWpH4P0aiwa2A4/uuBS27AUGIhJtN3zs+4m6BV6n9qT8
 hcH1yY9pP2CxGs/35HhwYje17MvjpUNO8QtF7eaeCD+R+Ufu9Tr7+F7FQ4D7HYVcO54g
 4TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=coJkuEmlNkx1jl3SxtGVceRHzmpSFAl/1O2kd9aGIEI=;
 b=F4wg9R6iRzmmK8DrOQ0o85vvlOUmDj5wBKOF0piXjZ+g/8044bxGBeeifslO3cyLQT
 awDyFiBzphTY2Fk0PPYE1GMw5SdZHJDy+Mo8+5PUTKCZmnxNskDohNk9Fpf5nlgBi7Do
 Z49jW08nA8RAA0Ddg9XUpG3ixkQ1fBZP0k9/vmCjRhdUD5RTe3zN/xCr4p2K8j0K3soU
 Lfc/nd17Wh5+QJlpNvV1pIkGQLMyV5yM2JKJX426K/0gpCWTnU76R0LxilaYaCQM4f8c
 AaXhAsTFQ9v5kD6T9IQZp5V9z7CPAdmcIAY5LI58xoIwyIWwhYtdkn+5584R5tLmJYoi
 zzBw==
X-Gm-Message-State: AOAM533Sjc/4fRPnNJwnY/Bv19bX07H+TezTXFQbQaMnP0zH12LhDFxo
 2FjEtKzGkdxvinvlXyKY5ERJzI+k9r0OFw==
X-Google-Smtp-Source: ABdhPJyO3MVr7dG/XxyIU4R+09TdGOCVn4IHZXGyOaFm3qDMMlCVmVACEkKslrleDL84AQ7Q0+O1WQ==
X-Received: by 2002:a9d:eed:: with SMTP id 100mr3006912otj.20.1599166887891;
 Thu, 03 Sep 2020 14:01:27 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id f12sm822384ooi.42.2020.09.03.14.01.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:27 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/77] virtio-balloon: fix free page hinting without an
 iothread
Date: Thu,  3 Sep 2020 15:58:25 -0500
Message-Id: <20200903205935.27832-8-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index a4729f7fc9..ef499e1b3b 100644
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
@@ -892,6 +886,11 @@ static void virtio_balloon_instance_init(Object *obj)
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


