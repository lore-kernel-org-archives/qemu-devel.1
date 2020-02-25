Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D144DC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1D620658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aF79g7JA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1D620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bw8-0003jp-M7
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:15:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6btR-0006se-6R
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6btP-0000zy-VN
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44906
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6btP-0000zc-RJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPFSbvv+WtlOtVos+MhqgsZmGBHXKy1YKRq49wrdV60=;
 b=aF79g7JA2YCE8TALamN7bHFhQnYq3xGs0aqC/dFQ7fGl9L8YXUDR0heUqa0V9OQj4eKAci
 0DNwKHvbr7UVkmaUYWhEv2RK5dcdO439exGV0PySuUNAnI6RsGgEu0LpXqo1wsxA+A37Ea
 Ntv8qAH3MgaqKwYprt5FHUwbDh0c53U=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-ppcYxvESN1Sz_FkfuR6jMA-1; Tue, 25 Feb 2020 10:12:59 -0500
X-MC-Unique: ppcYxvESN1Sz_FkfuR6jMA-1
Received: by mail-qv1-f70.google.com with SMTP id d7so13196485qvq.12
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X4na6KqmQ3c2V2WTi8kzbZFz4B5BaLaZ+cwVHA5c1dA=;
 b=hg/daR0/t9IDfEo7VNmBKmcrtei3biIm8YlHhNpjnTVt3i2VMykzoHVUZxryaVJqjP
 xFtdL2cWslwAS4S9N26gpKIWFcR20GblccxXd0OQj2lFM1CTo6a6YAM6ZSB2MxXmNQ5p
 yiulXTyWvAH9Uc3gfFtNBEvNK1VTY15RE+qbaNKN9jdPbjIQighB10IIBoLusZdvQQUq
 4iEBRHkqDXz+77DNz6qTw2aTgxf5zeOgBKLbkcSOaDT1tZ5kB67fQIE3gZ/N/sGdzZOb
 48kcCsMpfeLALUPncyKugawM6baD1o1mvG610TSSr+j62S0d5e6H+jfZ5J3fELiOHRkc
 4v7g==
X-Gm-Message-State: APjAAAW2m/6pfvccmA51k+jhX5tuoGIRwFoyjan7faU0wylEGlNZZRqd
 t2CXXtpG7YXEaLJ276e8B7wNzdA1llRLLsOnGCIKxHSRjlf+g4yOx0zSYdQwEe9I7oNtsto2tuD
 Pk8eGG7S0wBoU0mg=
X-Received: by 2002:ae9:e413:: with SMTP id q19mr10633883qkc.248.1582643578384; 
 Tue, 25 Feb 2020 07:12:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLPuQ/KTznrk4ef3sQqRpeSTzBa2ytk7WqONMjboVHht1+25o4ikLuqoSh3FK0QrhUVaG3xg==
X-Received: by 2002:ae9:e413:: with SMTP id q19mr10633868qkc.248.1582643578189; 
 Tue, 25 Feb 2020 07:12:58 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 n138sm466755qkn.33.2020.02.25.07.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:12:57 -0800 (PST)
Date: Tue, 25 Feb 2020 10:12:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/32] vhost-user-fs: convert to the new virtio_delete_queue
 function
Message-ID: <20200225151210.647797-7-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Pan Nengyuan <pannengyuan@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

use the new virtio_delete_queue function to cleanup.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200225075554.10835-3-pannengyuan@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user-fs.h |  2 ++
 hw/virtio/vhost-user-fs.c         | 15 +++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-us=
er-fs.h
index 9ff1bdb7cf..6f3030d288 100644
--- a/include/hw/virtio/vhost-user-fs.h
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -37,6 +37,8 @@ typedef struct {
     struct vhost_virtqueue *vhost_vqs;
     struct vhost_dev vhost_dev;
     VhostUserState vhost_user;
+    VirtQueue **req_vqs;
+    VirtQueue *hiprio_vq;
=20
     /*< public >*/
 } VHostUserFS;
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 4554d123b7..6136768875 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -209,11 +209,12 @@ static void vuf_device_realize(DeviceState *dev, Erro=
r **errp)
                 sizeof(struct virtio_fs_config));
=20
     /* Hiprio queue */
-    virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
+    fs->hiprio_vq =3D virtio_add_queue(vdev, fs->conf.queue_size, vuf_hand=
le_output);
=20
     /* Request queues */
+    fs->req_vqs =3D g_new(VirtQueue *, fs->conf.num_request_queues);
     for (i =3D 0; i < fs->conf.num_request_queues; i++) {
-        virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
+        fs->req_vqs[i] =3D virtio_add_queue(vdev, fs->conf.queue_size, vuf=
_handle_output);
     }
=20
     /* 1 high prio queue, plus the number configured */
@@ -230,10 +231,11 @@ static void vuf_device_realize(DeviceState *dev, Erro=
r **errp)
=20
 err_virtio:
     vhost_user_cleanup(&fs->vhost_user);
-    virtio_del_queue(vdev, 0);
+    virtio_delete_queue(fs->hiprio_vq);
     for (i =3D 0; i < fs->conf.num_request_queues; i++) {
-        virtio_del_queue(vdev, i + 1);
+        virtio_delete_queue(fs->req_vqs[i]);
     }
+    g_free(fs->req_vqs);
     virtio_cleanup(vdev);
     g_free(fs->vhost_dev.vqs);
     return;
@@ -252,10 +254,11 @@ static void vuf_device_unrealize(DeviceState *dev, Er=
ror **errp)
=20
     vhost_user_cleanup(&fs->vhost_user);
=20
-    virtio_del_queue(vdev, 0);
+    virtio_delete_queue(fs->hiprio_vq);
     for (i =3D 0; i < fs->conf.num_request_queues; i++) {
-        virtio_del_queue(vdev, i + 1);
+        virtio_delete_queue(fs->req_vqs[i]);
     }
+    g_free(fs->req_vqs);
     virtio_cleanup(vdev);
     g_free(fs->vhost_dev.vqs);
     fs->vhost_dev.vqs =3D NULL;
--=20
MST


