Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BD2C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCF020848
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gilRTb6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCF020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iojis-0002ib-Qy
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 02:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojOb-0003hV-Rb
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojOa-0007DY-Ed
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46347
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojOa-0007Ct-AV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ky3AoPDK1Dl90THjFQNp/2P2m3Le5A8fcjpKsYSUby0=;
 b=gilRTb6p/oHNDPkyEdtyowHhuopnKkdY3QSaxHLE3kHxZ3mnAA+ikxOF8b5/WxwsfunK5y
 pqec5MzMxYRz5WwSzfjMexB1nfgZERVoQwFi2r40vWGuRJGLKeOAe9ZWnzUKZeP6pH6XJX
 aR7dkkW6OpsaZRf3Hp3vFlttjdbBRuk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-78WXmuAXO1KyuZUMz2cnVA-1; Tue, 07 Jan 2020 02:35:18 -0500
Received: by mail-qt1-f197.google.com with SMTP id r9so11393037qtc.4
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:35:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S797ekb1koe77yVikHhjJoQQO+mcOVBkg02x1T+LNQw=;
 b=gOoHEMU8nxHGj93WKoiLbqnksV5oqlfJKopQfIiyk90jdb8xTlKGmWStN+rrO88W/T
 tQYDO3SEdB5ziwWAbw4g/hVcZ3M7UX8/2cElpS1DAY7Kg7urDZzestH6vYCxYgTWjSt+
 spDrSkxBSGr60yaamnwBUBH/OxNuUw+dWGYMvqna8u+DJ+lBFbSOwF6JUcWrGpoRUBZe
 1wtiGtr7tDtT4ut/0Whv+IVuH2S+N0QP5vdGiLTTczT6v4ySVTvpDtyeFL+UV/1dnxaR
 EFrXFpZwEiV7k6caU5FeRxQmUwErnkLqbnIE17+pcbbGS/FFVUhfckd2UaGAiQVSA97r
 ckSg==
X-Gm-Message-State: APjAAAVQmzOZt1bBoYIPz5i+C3zn6EB9BHxQKP44b274TWjVenJtiorG
 8+tba4Wewd0YLqsxl4VKFndGzlaioOeMhtsf0EJbDLfPPHKbB68oI8p3DQ1ZPRiXwWLlUgjViTj
 4gCxw1W9SwajJT9E=
X-Received: by 2002:a05:620a:147c:: with SMTP id
 j28mr78142492qkl.13.1578382518046; 
 Mon, 06 Jan 2020 23:35:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwNwktsZs5/b/1iC+2fvpm9h55X9qtq0lkJgTRivz28wZ2Ck6BnP2/SjQyelPOxTQo/PvDtA==
X-Received: by 2002:a05:620a:147c:: with SMTP id
 j28mr78142482qkl.13.1578382517856; 
 Mon, 06 Jan 2020 23:35:17 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id i28sm25247073qtc.57.2020.01.06.23.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:35:17 -0800 (PST)
Date: Tue, 7 Jan 2020 02:35:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/32] virtio: add ability to delete vq through a pointer
Message-ID: <20200107073451.298261-2-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 78WXmuAXO1KyuZUMz2cnVA-1
X-Mimecast-Spam-Score: 0
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


