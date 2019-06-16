Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00978C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A5120679
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A5120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hccy5-0006qO-3i
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hccp2-0006fo-I6
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hccp1-0006cK-EX
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hccp1-0006ac-3h
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id p15so8596278qtl.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7QEd9uPNGjcGekY8ktYqdBCQVay6WGwADDC2Om2994Y=;
 b=IW9aQny4/YIx2vsr8BpssKC0Dt2Nt9SbuynVeYfbmV43wKFkKAen1IZptfHrAcpD1E
 lEAmlRLtnHnFy0p1AbyxTyMyg4E5L3hMA0aexSJgyzLqEP8/VYJGTChx2zIYWsUj1+Wj
 +4Zfke8/zAe9Vus/dkJCAVgcYD+2mHW7L0gRCswgk//t9shhDhoTnmpcffvsjwTQ5461
 CPPLSzZgU2seNp/6Ybhc9QNIweM1s9G3nKUX6bkUkmLscEfSzav35rm2JaS4dUidoh7c
 WjjL3i+lOl1e6uU0EjE9UI6tNXrll+RhWO5/9T39oO7WkJmhFSktyBk2JjMaKax7LG9d
 pS7w==
X-Gm-Message-State: APjAAAXZTtlLstKISjVEwihqjtMfY3RuF1RmqV5Vs3V1YQygxlP41Opw
 hdopWdvt9pEN08KeVTOXXLZ2kN373x0=
X-Google-Smtp-Source: APXvYqwndzFqp3zVh+ZH5se6MPN+moa9bVI0Hj8JxS4lbOqqfLGEG/hqRsNIavFw4tTZiF/jN4PR+Q==
X-Received: by 2002:ac8:2b10:: with SMTP id 16mr72141744qtu.351.1560720977990; 
 Sun, 16 Jun 2019 14:36:17 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id d17sm4386134qtp.84.2019.06.16.14.36.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:36:17 -0700 (PDT)
Date: Sun, 16 Jun 2019 17:36:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190603061524.24076-1-lihangjing@baidu.com>
References: <20190616213540.20430-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190616213540.20430-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.193
Subject: [Qemu-devel] [PULL 07/11] vhost: fix vhost_log size overflow during
 migration
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Xie Yongji <xieyongji@baidu.com>,
 Li Hangjing <lihangjing@baidu.com>, qemu-stable@nongnu.org,
 Chai Wen <chaiwen@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190616213616.Wgk73sTQCPBgFUmAKn5B3ITH0xqnzFG6msDlI95L304@z>

From: Li Hangjing <lihangjing@baidu.com>

When a guest which doesn't support multiqueue is migrated with a multi queues
vhost-user-blk deivce, a crash will occur like:

0 qemu_memfd_alloc (name=<value optimized out>, size=562949953421312, seals=<value optimized out>, fd=0x7f87171fe8b4, errp=0x7f87171fe8a8) at util/memfd.c:153
1 0x00007f883559d7cf in vhost_log_alloc (size=70368744177664, share=true) at hw/virtio/vhost.c:186
2 0x00007f88355a0758 in vhost_log_get (listener=0x7f8838bd7940, enable=1) at qemu-2-12/hw/virtio/vhost.c:211
3 vhost_dev_log_resize (listener=0x7f8838bd7940, enable=1) at hw/virtio/vhost.c:263
4 vhost_migration_log (listener=0x7f8838bd7940, enable=1) at hw/virtio/vhost.c:787
5 0x00007f88355463d6 in memory_global_dirty_log_start () at memory.c:2503
6 0x00007f8835550577 in ram_init_bitmaps (f=0x7f88384ce600, opaque=0x7f8836024098) at migration/ram.c:2173
7 ram_init_all (f=0x7f88384ce600, opaque=0x7f8836024098) at migration/ram.c:2192
8 ram_save_setup (f=0x7f88384ce600, opaque=0x7f8836024098) at migration/ram.c:2219
9 0x00007f88357a419d in qemu_savevm_state_setup (f=0x7f88384ce600) at migration/savevm.c:1002
10 0x00007f883579fc3e in migration_thread (opaque=0x7f8837530400) at migration/migration.c:2382
11 0x00007f8832447893 in start_thread () from /lib64/libpthread.so.0
12 0x00007f8832178bfd in clone () from /lib64/libc.so.6

This is because vhost_get_log_size() returns a overflowed vhost-log size.
In this function, it uses the uninitialized variable vqs->used_phys and
vqs->used_size to get the vhost-log size.

Signed-off-by: Li Hangjing <lihangjing@baidu.com>
Reviewed-by: Xie Yongji <xieyongji@baidu.com>
Reviewed-by: Chai Wen <chaiwen@baidu.com>
Message-Id: <20190603061524.24076-1-lihangjing@baidu.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 60747a6f93..bc899fc60e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -131,6 +131,11 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
     }
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
+
+        if (!vq->used_phys && !vq->used_size) {
+            continue;
+        }
+
         vhost_dev_sync_region(dev, section, start_addr, end_addr, vq->used_phys,
                               range_get_last(vq->used_phys, vq->used_size));
     }
@@ -168,6 +173,11 @@ static uint64_t vhost_get_log_size(struct vhost_dev *dev)
     }
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
+
+        if (!vq->used_phys && !vq->used_size) {
+            continue;
+        }
+
         uint64_t last = vq->used_phys + vq->used_size - 1;
         log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
     }
-- 
MST


