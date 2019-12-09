Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3656C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 02:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A685206F4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 02:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A685206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie8Or-0005fp-Q3
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 21:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1ie8MH-0004IO-TH
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 21:01:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1ie8Ly-00085N-Cw
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 21:01:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2216 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1ie8Lw-0007zd-7t
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 21:00:50 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8C14555946C97999D62A;
 Mon,  9 Dec 2019 10:00:41 +0800 (CST)
Received: from HGHY2P002143101.china.huawei.com (10.184.39.213) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Mon, 9 Dec 2019 10:00:31 +0800
From: <pannengyuan@huawei.com>
To: <mst@redhat.com>
Subject: [PATCH v3 1/3] virtio: add ability to delete vq through a pointer
Date: Mon, 9 Dec 2019 10:00:08 +0800
Message-ID: <1575856810-9388-2-git-send-email-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.7.2.windows.1
In-Reply-To: <1575856810-9388-1-git-send-email-pannengyuan@huawei.com>
References: <1575856810-9388-1-git-send-email-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: liyiting@huawei.com, zhang.zhanghailiang@huawei.com,
 Amit Shah <amit@kernel.org>, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael S. Tsirkin <mst@redhat.com> 

Devices tend to maintain vq pointers, allow deleting them through a vq
pointer.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
[PMM: change function name to virtio_queue_cleanup; set used_elems to NULL after free]
Cc: Amit Shah <amit@kernel.org>
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
Changes v2 to v1:
- use virtio_delete_queue to cleanup vq through a vq pointer
---
Changes v3 to v2:
- change function name from virtio_delete_queue to virtio_queue_cleanup
---
 hw/virtio/virtio.c         | 16 +++++++++++-----
 include/hw/virtio/virtio.h |  2 ++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 04716b5..2743258 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2330,17 +2330,23 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
     return &vdev->vq[i];
 }
 
+void virtio_queue_cleanup(VirtQueue *vq)
+{
+    vq->vring.num = 0;
+    vq->vring.num_default = 0;
+    vq->handle_output = NULL;
+    vq->handle_aio_output = NULL;
+    g_free(vq->used_elems);
+    vq->used_elems = NULL;
+}
+
 void virtio_del_queue(VirtIODevice *vdev, int n)
 {
     if (n < 0 || n >= VIRTIO_QUEUE_MAX) {
         abort();
     }
 
-    vdev->vq[n].vring.num = 0;
-    vdev->vq[n].vring.num_default = 0;
-    vdev->vq[n].handle_output = NULL;
-    vdev->vq[n].handle_aio_output = NULL;
-    g_free(vdev->vq[n].used_elems);
+    virtio_queue_cleanup(&vdev->vq[n]);
 }
 
 static void virtio_set_isr(VirtIODevice *vdev, int value)
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c32a815..cc0b3f0 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -183,6 +183,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
 
 void virtio_del_queue(VirtIODevice *vdev, int n);
 
+void virtio_queue_cleanup(VirtQueue *vq);
+
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len);
 void virtqueue_flush(VirtQueue *vq, unsigned int count);
-- 
2.7.2.windows.1



