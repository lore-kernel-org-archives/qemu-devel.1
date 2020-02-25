Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB12C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D6D21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D6D21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6UsM-0004uB-0s
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 02:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j6Uph-0008OM-59
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j6Upg-0003cC-4V
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:40:45 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55678 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j6Upf-0003bh-PP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:40:44 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A1B0A4B482C74B6EBB24;
 Tue, 25 Feb 2020 15:40:41 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Feb 2020 15:40:31 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <mst@redhat.com>
Subject: [PATCH 2/4] vhost-user-fs: convert to the new virtio_delete_queue
 function
Date: Tue, 25 Feb 2020 15:55:52 +0800
Message-ID: <20200225075554.10835-3-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200225075554.10835-1-pannengyuan@huawei.com>
References: <20200225075554.10835-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: zhang.zhanghailiang@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

use the new virtio_delete_queue function to cleanup.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/vhost-user-fs.c         | 15 +++++++++------
 include/hw/virtio/vhost-user-fs.h |  2 ++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 4554d123b7..6136768875 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -209,11 +209,12 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
                 sizeof(struct virtio_fs_config));
 
     /* Hiprio queue */
-    virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
+    fs->hiprio_vq = virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
 
     /* Request queues */
+    fs->req_vqs = g_new(VirtQueue *, fs->conf.num_request_queues);
     for (i = 0; i < fs->conf.num_request_queues; i++) {
-        virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
+        fs->req_vqs[i] = virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
     }
 
     /* 1 high prio queue, plus the number configured */
@@ -230,10 +231,11 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
 
 err_virtio:
     vhost_user_cleanup(&fs->vhost_user);
-    virtio_del_queue(vdev, 0);
+    virtio_delete_queue(fs->hiprio_vq);
     for (i = 0; i < fs->conf.num_request_queues; i++) {
-        virtio_del_queue(vdev, i + 1);
+        virtio_delete_queue(fs->req_vqs[i]);
     }
+    g_free(fs->req_vqs);
     virtio_cleanup(vdev);
     g_free(fs->vhost_dev.vqs);
     return;
@@ -252,10 +254,11 @@ static void vuf_device_unrealize(DeviceState *dev, Error **errp)
 
     vhost_user_cleanup(&fs->vhost_user);
 
-    virtio_del_queue(vdev, 0);
+    virtio_delete_queue(fs->hiprio_vq);
     for (i = 0; i < fs->conf.num_request_queues; i++) {
-        virtio_del_queue(vdev, i + 1);
+        virtio_delete_queue(fs->req_vqs[i]);
     }
+    g_free(fs->req_vqs);
     virtio_cleanup(vdev);
     g_free(fs->vhost_dev.vqs);
     fs->vhost_dev.vqs = NULL;
diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-user-fs.h
index 9ff1bdb7cf..6f3030d288 100644
--- a/include/hw/virtio/vhost-user-fs.h
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -37,6 +37,8 @@ typedef struct {
     struct vhost_virtqueue *vhost_vqs;
     struct vhost_dev vhost_dev;
     VhostUserState vhost_user;
+    VirtQueue **req_vqs;
+    VirtQueue *hiprio_vq;
 
     /*< public >*/
 } VHostUserFS;
-- 
2.18.2


