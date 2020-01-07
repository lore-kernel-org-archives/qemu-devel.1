Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F162BC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7542081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJEl2Xe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7542081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioroe-00036r-AE
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorjm-0006KI-77
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorjl-0004XD-6E
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:29:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorjl-0004Wq-2Y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ky3AoPDK1Dl90THjFQNp/2P2m3Le5A8fcjpKsYSUby0=;
 b=fJEl2Xe9Ib7uFfmiokp4KHemk60vM2VyacNmXmH54r718HU2kr+viZsqWc5oelrZbSk9gG
 /Qgc+53Fxm/dnFs5sT72SNlTQLi5KReKAEuEaQeC2KrGHB9VW6F4KBBpjnAbSWNOuakZbd
 cBFICAXAi5XJyZvzjWLUN6ANZAtjS30=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-llQ_2URYOzy6uzCwXl8Yug-1; Tue, 07 Jan 2020 11:29:41 -0500
Received: by mail-qk1-f199.google.com with SMTP id f22so137173qka.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S797ekb1koe77yVikHhjJoQQO+mcOVBkg02x1T+LNQw=;
 b=iDKl0cRUrCzRN4ainmFxCqiHbxboxdOBCwoyRtue2t4NJDyRwX9OLsZAc+LuvkTMTK
 YjW0HrDj5+6tU0tY7cheAwHP0X+CWj5KRsxwJstPmj0/TK71AkxIpizEmVLE1uzbeJur
 4mX5eJXk5LidWW8ISkyM0XBSbwGRnaA23FAryWzlyfxk7M/vLNRA+cT4UdaCllf+9erV
 l375LWsgqKnECyn/zMgI83vJVQqz7KRFqrvOzZ63uprNLcs2rZcFKM3uOnUJdDJvgdz0
 XObQnOc234fsUKNYb4hvbFlRx7NiJ+8pRoTgHLYXry9G2c3uR1+0gyi2Fok/WeajJazp
 G10A==
X-Gm-Message-State: APjAAAUAk1WGs/ym99z+OiFPk5o23pseC51zDEkDaMqy9LiMW/MsazRQ
 khEF7EcHtSTuUIiMacP2u4dUrFx4l8kwzUHVa8hZQtYuxcEJo6pL4mBAplW2krp5+5rs/nqWqp0
 0QBhKoZ7oc2iPeto=
X-Received: by 2002:aed:3fb7:: with SMTP id s52mr79810973qth.311.1578414580714; 
 Tue, 07 Jan 2020 08:29:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBASJc7+GSyeLhPK1jDxVtCqoIoPn5+Nf3z6SRS2r7n+a3n0rxMCEKINFN+2AFYKpI0OFtrg==
X-Received: by 2002:aed:3fb7:: with SMTP id s52mr79810955qth.311.1578414580543; 
 Tue, 07 Jan 2020 08:29:40 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id k14sm34585qki.66.2020.01.07.08.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:29:39 -0800 (PST)
Date: Tue, 7 Jan 2020 11:29:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 01/32] virtio: add ability to delete vq through a pointer
Message-ID: <20200107162850.411448-2-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: llQ_2URYOzy6uzCwXl8Yug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Devices tend to maintain vq pointers, allow deleting them trough a vq point=
er.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/hw/virtio/virtio.h |  2 ++
 hw/virtio/virtio.c         | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c32a815303..e18756d50d 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -183,6 +183,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int que=
ue_size,
=20
 void virtio_del_queue(VirtIODevice *vdev, int n);
=20
+void virtio_delete_queue(VirtQueue *vq);
+
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len);
 void virtqueue_flush(VirtQueue *vq, unsigned int count);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 04716b5f6c..31dd140990 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2330,17 +2330,22 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int=
 queue_size,
     return &vdev->vq[i];
 }
=20
+void virtio_delete_queue(VirtQueue *vq)
+{
+    vq->vring.num =3D 0;
+    vq->vring.num_default =3D 0;
+    vq->handle_output =3D NULL;
+    vq->handle_aio_output =3D NULL;
+    g_free(vq->used_elems);
+}
+
 void virtio_del_queue(VirtIODevice *vdev, int n)
 {
     if (n < 0 || n >=3D VIRTIO_QUEUE_MAX) {
         abort();
     }
=20
-    vdev->vq[n].vring.num =3D 0;
-    vdev->vq[n].vring.num_default =3D 0;
-    vdev->vq[n].handle_output =3D NULL;
-    vdev->vq[n].handle_aio_output =3D NULL;
-    g_free(vdev->vq[n].used_elems);
+    virtio_delete_queue(&vdev->vq[n]);
 }
=20
 static void virtio_set_isr(VirtIODevice *vdev, int value)
--=20
MST


