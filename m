Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2B7CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCE1206DD
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCE1206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iORzD-0001a2-7m
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 15:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iORuG-0000P2-Jm
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iORuF-00008o-Fs
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40514)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iORuF-00008W-7f
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:23 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4BCA6C01D36C
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 19:39:22 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id t16so6322277qtp.11
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 12:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=42QY6USANjxLIh2wuts0pVaXl5XWhZ8Sl7+dDJBp7pk=;
 b=jk+rFymt/Av21sBXPeawJJSSJvT0+T7OEK8VG2Lf/FnHq4RtS9910grtuEJQV7dtan
 AhZWVpCZgWuVs1PANESp0o1XkhHOE+K1mmYPefZGzcNDDk/Daawz5YU+3ACIeIsKkC1n
 xbPexFNU1xKT+tQRQ022M0n0ZM9Pd01cX1Yn94fx/nQSs9DCZFUKaG/Xx7DVcyb94rVf
 jJPvj1ZCnVrAjVvC4UPVC4qKYOC0linP6KI+fbAupIkovap8GCtTonwxSplDjD+UyyoO
 ZnFNzrTJbOEIIRI7Aipl3/md4j4CI1lqQipa94ipe8tsCSl/vxBi9hfJeFUGSYsP1MYI
 r28Q==
X-Gm-Message-State: APjAAAWa7smCaxBJTxHcW3Slx40yC/k0w+D8VaHFcxL6t1BScv4NSOEf
 bRiqayA7v2RK5PVzA3Gq7w65QSliGLOxDwZ82To0N4T6iGzXMc5MGyyBZJkhOyjtiYA0EXPrUzh
 MS96Gh48GMmmPhmM=
X-Received: by 2002:a37:383:: with SMTP id 125mr9218186qkd.482.1572118761181; 
 Sat, 26 Oct 2019 12:39:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy0xa33mrY3EfAWFFaoci3fH5N4xX4WisAKxdnr53QiZNbOUkHgEPYT5d/HKnSuHzdXibjf3g==
X-Received: by 2002:a37:383:: with SMTP id 125mr9218162qkd.482.1572118760807; 
 Sat, 26 Oct 2019 12:39:20 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 14sm2991819qtb.54.2019.10.26.12.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 12:39:20 -0700 (PDT)
Date: Sat, 26 Oct 2019 15:39:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/25] virtio: device/driver area size calculation refactor
 for split ring
Message-ID: <20191026193824.11926-3-mst@redhat.com>
References: <20191026193824.11926-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191026193824.11926-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>, Wei Xu <wexu@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Xu <wexu@redhat.com>

There is slight size difference between split/packed rings.

This is the refactor of split ring as well as a helper to expanding
device and driver area size calculation for packed ring.

Signed-off-by: Wei Xu <wexu@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
Reviewed-by: Jens Freimann <jfreimann@redhat.com>
Message-Id: <20191025083527.30803-3-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fdac203cdf..74cc10fad9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -159,10 +159,8 @@ static void virtio_init_region_cache(VirtIODevice *v=
dev, int n)
     VRingMemoryRegionCaches *old =3D vq->vring.caches;
     VRingMemoryRegionCaches *new =3D NULL;
     hwaddr addr, size;
-    int event_size;
     int64_t len;
=20
-    event_size =3D virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT=
_IDX) ? 2 : 0;
=20
     addr =3D vq->vring.desc;
     if (!addr) {
@@ -177,7 +175,7 @@ static void virtio_init_region_cache(VirtIODevice *vd=
ev, int n)
         goto err_desc;
     }
=20
-    size =3D virtio_queue_get_used_size(vdev, n) + event_size;
+    size =3D virtio_queue_get_used_size(vdev, n);
     len =3D address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
@@ -185,7 +183,7 @@ static void virtio_init_region_cache(VirtIODevice *vd=
ev, int n)
         goto err_used;
     }
=20
-    size =3D virtio_queue_get_avail_size(vdev, n) + event_size;
+    size =3D virtio_queue_get_avail_size(vdev, n);
     len =3D address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
@@ -2414,14 +2412,20 @@ hwaddr virtio_queue_get_desc_size(VirtIODevice *v=
dev, int n)
=20
 hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n)
 {
+    int s;
+
+    s =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0=
;
     return offsetof(VRingAvail, ring) +
-        sizeof(uint16_t) * vdev->vq[n].vring.num;
+        sizeof(uint16_t) * vdev->vq[n].vring.num + s;
 }
=20
 hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
 {
+    int s;
+
+    s =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0=
;
     return offsetof(VRingUsed, ring) +
-        sizeof(VRingUsedElem) * vdev->vq[n].vring.num;
+        sizeof(VRingUsedElem) * vdev->vq[n].vring.num + s;
 }
=20
 uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
--=20
MST


