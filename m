Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372B0C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 12:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064982085B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 12:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3VHnbYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064982085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5Uu-0002Gd-Ry
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 07:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5TI-0000P5-04
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5TH-0003RR-1n
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33947
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5TG-0003Qx-TL
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ky3AoPDK1Dl90THjFQNp/2P2m3Le5A8fcjpKsYSUby0=;
 b=D3VHnbYg7+IctQi4zToZMmZquMO9B03QHkxFr5piFhTpXNYl92xrds2Ol5VDlO5RbcJFZ+
 KvgEcW8RZH8ymSc24GVYmyBcFJMxkk7+Jdrwx8LQiq78nsEC6RJBlJlXJfAK07WYrLUGNS
 jFV0ZO/0oK22EpNmOrvoJBhKV+hjEuA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-c6z1mY36Nay18Qe9GMr9aw-1; Sun, 05 Jan 2020 07:57:26 -0500
Received: by mail-qt1-f198.google.com with SMTP id e8so8946396qtg.9
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S797ekb1koe77yVikHhjJoQQO+mcOVBkg02x1T+LNQw=;
 b=jn53EQV5wCQz9tMFZkDwUgQtxA3ZsRZ4naV2IQGZ0NkXfMGj2uFWHW2+uwWd7I++Pq
 vGdBg8v58zFz4jsdYBe/kXcQbaa3XziY1pYuhuUTKBHUBtKjAmCltaDjZHdAHuwlnUGM
 WxlGlLLpt76BEiFflrDB7UgsJ0EqSd3A6VDIc7qLFusnOISty3BgJf/R+XcSaBaYCvfa
 CtCvpNycnDs53y3ersXQasLpc5StzsrftMksBr49fSXJhbOsMYRO5Loelic4IPftCs1X
 WqF5n6X6yCZKJXt1/elnASpijrUSpyvDjDKJY/wSCGPqTtkEdpFh/Y56hnVkXHmJlJ4t
 ZxDA==
X-Gm-Message-State: APjAAAVLaOZqGb4LsR9W6EThRylb5Qu/SiovTSEQOuce3HLWZuzX1jft
 LcFg8LM43gf6Cap9JNA1ZFkkwHKerJ92D7lJwXkfhCm9MAycBGDkHrr4N8DYfAbc8b+Nx344PCV
 hFrXLmgm5TBVRj6M=
X-Received: by 2002:a05:6214:13ef:: with SMTP id
 ch15mr68673854qvb.183.1578229046153; 
 Sun, 05 Jan 2020 04:57:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwGEkOL4TCdQsqJcdin/3NQQWXkgkSx+Z3V8ACExs9c74RHybbBIX30MaW53oxyD8AVJmoUkw==
X-Received: by 2002:a05:6214:13ef:: with SMTP id
 ch15mr68673841qvb.183.1578229045940; 
 Sun, 05 Jan 2020 04:57:25 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id l19sm21531653qtq.48.2020.01.05.04.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:57:25 -0800 (PST)
Date: Sun, 5 Jan 2020 07:57:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 01/32] virtio: add ability to delete vq through a pointer
Message-ID: <20200105125622.27231-2-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: c6z1mY36Nay18Qe9GMr9aw-1
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


