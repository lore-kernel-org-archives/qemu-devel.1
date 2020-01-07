Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1002C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7AA206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMg31D+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7AA206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iojpD-0006wW-9U
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojOv-0004W4-Tk
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojOu-0007Ru-R1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46386
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojOu-0007RJ-3w
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9epneyHKkAEq5gGDVE/gbeFue8BzwP7OkBM6QzY9Yk=;
 b=aMg31D+0nhGp4C+H98QK8ZhQeumsQh5dRJvd5woXheNbqhmn146sTgyDen04qPyDREgm3X
 +82RDFXrr2PoI/gWwVFD/omuhHdTeq4XIQMnoFb6JKGAz2t7Lb7i/tpLK6e0EDG+fR2zjL
 4B1ycsM2ggrxh8KEtP3yQUTLicn1z3Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-NL-lLGPHOJyWC4QFG6FwSw-1; Tue, 07 Jan 2020 02:35:38 -0500
Received: by mail-qk1-f199.google.com with SMTP id s9so17952826qkg.21
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iiaP0RxMw50Y4u2HruPOoUKc+xP0ZRMmYrMUAAr8Wgg=;
 b=J2nQwWc2/XwEDSd4y26bpc/eLYyshDm5GrcfKwGqNdV2Os+vJyqwLe67HCKVrWfHNx
 Iku07ds0GIv2/jTUd1mP5F/rN4B+qcK6qAANAH3Z/vqnX1XoVze5eHM3ZWMxt77QBRAQ
 vZMfuu2oiWTO4+aZNrGQKH1GHtM5hqmLCWc5w7zk1h+xW46+wNVfnOitGS29CVYmjYnM
 mBmWxy1XxtJyM3lYLx6j0K3LPOZdWpep2D2xtbet6aR8hJD/RsuWgokse0HE6lyQY6MF
 Yhl/J3jN1Lyl1qLtoesQwmAkDZSWkSnMxP9xh7BPRjY8CkWjOEo7MNoCEUtQ98bii7S+
 brtQ==
X-Gm-Message-State: APjAAAUYYTizZB8qZ3E86dB8kmxuBL+aaKdQT3/u2m2E38+GBlRL1Uob
 O+qrK3nxtdHPbVaArcozUsgbgpAUv4hj2JR3q8T3JcKBItS+HMlqDhMB/1Pk+Z9cMNmg6zo9u17
 pjxsGPZmK0bCgpkc=
X-Received: by 2002:a37:488f:: with SMTP id v137mr83780580qka.16.1578382537525; 
 Mon, 06 Jan 2020 23:35:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkv1oPWjt7rNZi7HGQoXoGN2d6pjc1qSoK9A9XbpiK5tTkFajzlSADCJRwp6WnQgLHoDKpXQ==
X-Received: by 2002:a37:488f:: with SMTP id v137mr83780569qka.16.1578382537312; 
 Mon, 06 Jan 2020 23:35:37 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id f26sm24528080qtv.77.2020.01.06.23.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:35:36 -0800 (PST)
Date: Tue, 7 Jan 2020 02:35:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/32] virtio-input: convert to new virtio_delete_queue
Message-ID: <20200107073451.298261-6-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: NL-lLGPHOJyWC4QFG6FwSw-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Seems cleaner than using VQ index values.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/input/virtio-input.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index ec54e46ad6..9c013afddb 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -280,6 +280,7 @@ static void virtio_input_device_unrealize(DeviceState *=
dev, Error **errp)
 {
     VirtIOInputClass *vic =3D VIRTIO_INPUT_GET_CLASS(dev);
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VirtIOInput *vinput =3D VIRTIO_INPUT(dev);
     Error *local_err =3D NULL;
=20
     if (vic->unrealize) {
@@ -289,8 +290,8 @@ static void virtio_input_device_unrealize(DeviceState *=
dev, Error **errp)
             return;
         }
     }
-    virtio_del_queue(vdev, 0);
-    virtio_del_queue(vdev, 1);
+    virtio_delete_queue(vinput->evt);
+    virtio_delete_queue(vinput->sts);
     virtio_cleanup(vdev);
 }
=20
--=20
MST


