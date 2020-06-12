Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF85C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8752081A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgL5e/S5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8752081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlGD-0007hz-Iq
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2Z-0007N5-AC
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33606
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2X-0001UW-EF
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oiR6m9EPqvRwON04zA+EzVpgAt3vN6EqBTJGhjucyNs=;
 b=EgL5e/S5q03wDoHGWCRz+V6up26Y2TJZu9MQ31c63spYkI4tm+/Xb6MJL+yxTsXdRulpMf
 cCM0N9FC0CFajN60WBZ7vt9bSztZF+tKZ+p6bhTC0SH67bgzWDMWGwI75OqDYwIhe1EYgx
 cpnXKG+LpcXkzv+kqqm2bVubh6IfzaY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-mFYc0c8nPcmKgJgqqU_lpQ-1; Fri, 12 Jun 2020 10:52:04 -0400
X-MC-Unique: mFYc0c8nPcmKgJgqqU_lpQ-1
Received: by mail-wm1-f69.google.com with SMTP id y15so2035714wmi.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oiR6m9EPqvRwON04zA+EzVpgAt3vN6EqBTJGhjucyNs=;
 b=kGK54poU408CaL/Ve6p2jJJeiNh27IAuVsY0N9ExM4LwWtaW5SZkDLHUXc0Pln9RTF
 SqP0KdueICl1DJxy1W9kqZ5vvgzTVvOd0jnTla8T/Nq/DQqEST36L1SDCHtX2YSgG2CX
 4rKcC4jwU2xoj89EnIzJI4ZHa+bTw+YtThY5SnlgDdn3lBXy0sZN6aYyV4gQWR1vQv6n
 k6kr2C0K45MivCNZgAN2EMBRla1jHoYB/cF0R5LzbscvF8JJsYLMzlivdgo1n0uFKaNQ
 mWTlQxv91Ud2Yh/G1eYfgMDYKUP2m9VUP3gm6kJH4qMdjqQLrVPeY7s+ozx/J2Q3CL0g
 JeEw==
X-Gm-Message-State: AOAM531ijCe5koR25NVKZ+fZ/7sUw5lFzwHD4EJfUXhGP6gfUD79YXBa
 TcbEHYCaLIj+PqKAjj3PKMoi96jfgqUuhUSyek2ufUt6wJ6soT1dXsoToObAPmxgy3y3KzHY9C7
 oHBGVb4dQXXztQJo=
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr15427387wrw.91.1591973522429; 
 Fri, 12 Jun 2020 07:52:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzov7XLquS1rlXBvSllz4ZXl6iBj7WLdlSmtyXwQAG896WqEK8yaUMgX3cokOX7IKM1H++kyg==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr15427367wrw.91.1591973522214; 
 Fri, 12 Jun 2020 07:52:02 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id s2sm2848450wmh.15.2020.06.12.07.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:01 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 26/58] virtio-balloon: Provide an interface for free page
 reporting
Message-ID: <20200612141917.9446-27-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:00:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Add support for free page reporting. The idea is to function very similar
to how the balloon works in that we basically end up madvising the page as
not being used. However we don't really need to bother with any deflate
type logic since the page will be faulted back into the guest when it is
read or written to.

This provides a new way of letting the guest proactively report free
pages to the hypervisor, so the hypervisor can reuse them. In contrast to
inflate/deflate that is triggered via the hypervisor explicitly.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-Id: <20200527041407.12700.73735.stgit@localhost.localdomain>
---
 include/hw/virtio/virtio-balloon.h |  2 +-
 hw/virtio/virtio-balloon.c         | 72 ++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 7fe78e5c14..d49fef00ce 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
 
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
-    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
+    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *reporting_vq;
     uint32_t free_page_report_status;
     uint32_t num_pages;
     uint32_t actual;
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 31d3c88482..10507b2a43 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -321,6 +321,67 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
     balloon_stats_change_timer(s, 0);
 }
 
+static void virtio_balloon_handle_report(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
+    VirtQueueElement *elem;
+
+    while ((elem = virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
+        unsigned int i;
+
+        /*
+         * When we discard the page it has the effect of removing the page
+         * from the hypervisor itself and causing it to be zeroed when it
+         * is returned to us. So we must not discard the page if it is
+         * accessible by another device or process, or if the guest is
+         * expecting it to retain a non-zero value.
+         */
+        if (qemu_balloon_is_inhibited() || dev->poison_val) {
+            goto skip_element;
+        }
+
+        for (i = 0; i < elem->in_num; i++) {
+            void *addr = elem->in_sg[i].iov_base;
+            size_t size = elem->in_sg[i].iov_len;
+            ram_addr_t ram_offset;
+            RAMBlock *rb;
+
+            /*
+             * There is no need to check the memory section to see if
+             * it is ram/readonly/romd like there is for handle_output
+             * below. If the region is not meant to be written to then
+             * address_space_map will have allocated a bounce buffer
+             * and it will be freed in address_space_unmap and trigger
+             * and unassigned_mem_write before failing to copy over the
+             * buffer. If more than one bad descriptor is provided it
+             * will return NULL after the first bounce buffer and fail
+             * to map any resources.
+             */
+            rb = qemu_ram_block_from_host(addr, false, &ram_offset);
+            if (!rb) {
+                trace_virtio_balloon_bad_addr(elem->in_addr[i]);
+                continue;
+            }
+
+            /*
+             * For now we will simply ignore unaligned memory regions, or
+             * regions that overrun the end of the RAMBlock.
+             */
+            if (!QEMU_IS_ALIGNED(ram_offset | size, qemu_ram_pagesize(rb)) ||
+                (ram_offset + size) > qemu_ram_get_used_length(rb)) {
+                continue;
+            }
+
+            ram_block_discard_range(rb, ram_offset, size);
+        }
+
+skip_element:
+        virtqueue_push(vq, elem, 0);
+        virtio_notify(vdev, vq);
+        g_free(elem);
+    }
+}
+
 static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
@@ -835,6 +896,12 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
         s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
                                      virtio_ballloon_get_free_page_hints, s);
     }
+
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
+        s->reporting_vq = virtio_add_queue(vdev, 32,
+                                           virtio_balloon_handle_report);
+    }
+
     reset_stats(s);
 }
 
@@ -858,6 +925,9 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
     if (s->free_page_vq) {
         virtio_delete_queue(s->free_page_vq);
     }
+    if (s->reporting_vq) {
+        virtio_delete_queue(s->reporting_vq);
+    }
     virtio_cleanup(vdev);
 }
 
@@ -945,6 +1015,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
     DEFINE_PROP_BIT("page-poison", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_PAGE_POISON, true),
+    DEFINE_PROP_BIT("free-page-reporting", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_REPORTING, false),
     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
-- 
MST


