Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47E7C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94CF21739
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94CF21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j23Jx-0007xy-TE
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 20:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j23It-0006Vg-Vz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j23Is-0004JC-Uh
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:28:31 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56702 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j23Iq-00045V-Id; Wed, 12 Feb 2020 20:28:28 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0453B863F9B3E7B1632F;
 Thu, 13 Feb 2020 09:28:26 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Feb 2020 09:28:15 +0800
From: <pannengyuan@huawei.com>
To: <mst@redhat.com>, <kwolf@redhat.com>, <mreitz@redhat.com>
Subject: [PATCH 2/2] vhost-use-blk: convert to new virtio_delete_queue
Date: Thu, 13 Feb 2020 09:28:07 +0800
Message-ID: <20200213012807.45552-3-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200213012807.45552-1-pannengyuan@huawei.com>
References: <20200213012807.45552-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

use the new virtio_delete_queue function to cleanup.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 hw/block/vhost-user-blk.c          | 11 +++++++----
 include/hw/virtio/vhost-user-blk.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 2eba8b9db0..ed6a5cc03b 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -420,9 +420,10 @@ static void vhost_user_blk_device_realize(DeviceStat=
e *dev, Error **errp)
     virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
                 sizeof(struct virtio_blk_config));
=20
+    s->virtqs =3D g_new0(VirtQueue *, s->num_queues);
     for (i =3D 0; i < s->num_queues; i++) {
-        virtio_add_queue(vdev, s->queue_size,
-                         vhost_user_blk_handle_output);
+        s->virtqs[i] =3D virtio_add_queue(vdev, s->queue_size,
+                                        vhost_user_blk_handle_output);
     }
=20
     s->inflight =3D g_new0(struct vhost_inflight, 1);
@@ -461,8 +462,9 @@ virtio_err:
     g_free(s->vqs);
     g_free(s->inflight);
     for (i =3D 0; i < s->num_queues; i++) {
-        virtio_del_queue(vdev, i);
+        virtio_delete_queue(s->virtqs[i]);
     }
+    g_free(s->virtqs);
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
 }
@@ -482,8 +484,9 @@ static void vhost_user_blk_device_unrealize(DeviceSta=
te *dev, Error **errp)
     g_free(s->inflight);
=20
     for (i =3D 0; i < s->num_queues; i++) {
-        virtio_del_queue(vdev, i);
+        virtio_delete_queue(s->virtqs[i]);
     }
+    g_free(s->virtqs);
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
 }
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost=
-user-blk.h
index 108bfadeeb..f68911f6f0 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -37,6 +37,7 @@ typedef struct VHostUserBlk {
     struct vhost_inflight *inflight;
     VhostUserState vhost_user;
     struct vhost_virtqueue *vqs;
+    VirtQueue **virtqs;
     guint watch;
     bool connected;
 } VHostUserBlk;
--=20
2.21.0.windows.1



